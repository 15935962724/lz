package tea.entity.stat;

import java.io.*;
import java.net.*;
import java.security.*;
import java.security.spec.*;
import java.sql.*;
import java.text.*;
import java.util.*;
import java.util.regex.*;
import java.util.zip.*;

import javax.crypto.*;
import javax.mail.*;
import javax.mail.Flags;

import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipFile;
import org.json.*;
import sun.misc.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.site.*;

//http://dev2.baidu.com
public class TJBaidu
{
    public static String[] FILTER_TYPE =
            {"--","直达","搜索引擎","外部链接","新访客","老访客"};
    public static String[] DATA_TYPE =
            {"--","搜索词-分指标","外部链接","地域分布","系统环境","","事件分析"}; //最多定制10个
    static Key PUBLIC_KEY = getPublicKey("MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDHn/hfvTLRXViBXTmBhNYEIJeGGGDkmrYBxCRelriLEYEcrwWrzp0au9nEISpjMlXeEW4+T82bCM22+JUXZpIga5qdBrPkjU08Ktf5n7Nsd7n9ZeI0YoAKCub3ulVExcxGeS3RVxFai9ozERlavpoTOdUzEH6YWHP4reFfpMpLzwIDAQAB");
    public int ucid; //用户ucid
    public int rquota; //剩余配额数 /最多2000
    public int status;
    public String message; //错误描述
    String st, //会话ID
    header;

    //取得公钥
    public static Key getPublicKey(String key)
    {
        try
        {
            byte[] by = new BASE64Decoder().decodeBuffer(key);
            return KeyFactory.getInstance("RSA").generatePublic(new X509EncodedKeySpec(by));
        } catch(Throwable ex)
        {
            return null;
        }
    }

    //由于密钥为 1024 位，所以最多对 117 个字符进行加密，若压缩后的数据超过117个字符，则进行分块（117 字符为 1 块）加密，再拼接。最多支持加密 2047 个字符
    public static byte[] process(Cipher cipher,int blockSize,byte[] input) throws GeneralSecurityException,IOException
    {
        ByteArrayOutputStream ba = new ByteArrayOutputStream();
        int i = 0;
        do
        {
            ba.write(cipher.doFinal(input,i,Math.min(input.length - i,blockSize)));
            i += blockSize;
        } while(i < input.length);
        return ba.toByteArray();
    }

    public static final byte[] gzip(byte[] by) throws IOException
    {
        ByteArrayOutputStream ba = new ByteArrayOutputStream();
        GZIPOutputStream os = new GZIPOutputStream(ba);
        os.write(by);
        os.close();
        return ba.toByteArray();
    }

    public static final byte[] ungzip(InputStream is) throws IOException
    {
        GZIPInputStream zip = new GZIPInputStream(is);
        ByteArrayOutputStream ba = new ByteArrayOutputStream();
        Filex.piped(zip,ba);
        return ba.toByteArray();
    }

    JSONObject send(String str) throws IOException
    {
        boolean flag = str.contains("request"); //登录/出
        for(int i = 0;i < 10;i++)
        {
            Filex.logs("TJBaidu.send.txt","请求" + i + "：" + str);
            long cur = System.currentTimeMillis();

            //旧:https://api.baidu.com/json/tongji/v1/ProductService/api
            String url = flag ? "https://api.baidu.com/sem/common/HolmesLoginService" : "https://api.baidu.com/json/tongji/v1/ReportService/getData";
            if(str.contains("getSiteList")) //站点列表
                url = url.substring(0,url.length() - 4) + "SiteList";
            HttpURLConnection conn = (HttpURLConnection)new URL(null,url,new sun.net.www.protocol.https.Handler()).openConnection();
            try
            {
                conn.setReadTimeout(20000);
                conn.setRequestProperty("UUID","ABCDEFG-12345678");
                if(flag)
                    conn.setRequestProperty("account_type","1");
                else
                    conn.setRequestProperty("USERID","" + ucid);
                conn.setRequestMethod("POST");
                conn.setDoOutput(true);
                //
                OutputStream os = conn.getOutputStream();
                byte[] by = str.getBytes("UTF-8");
                if(flag)
                {
                    Cipher cipher = Cipher.getInstance("RSA");
                    cipher.init(Cipher.ENCRYPT_MODE,PUBLIC_KEY);
                    by = process(cipher,117,gzip(by));
                }
                os.write(by);
                os.close();
                //
                InputStream is = conn.getInputStream();
                if(flag)
                {
                    by = new byte[8];
                    if(is.read(by) != 8)
                    {
                        throw new IOException("Server response is invalid.");
                    }
                    String[] ERR =
                            {"正常","CLIENT ID错误","加密方法错误","数据体损坏","数据太大(超过2K)","数据太小","请求消息体格式不正确","访问的方法不存在","方法处理出错","TOKEN错误","用户名错误","登录请求处理异常","账户类型无效"};
                    by = by[1] == 0 ? ungzip(is) : ("{retcode:" + by[1] + ",retmsg:'" + ERR[by[1]] + "'}").getBytes("UTF-8");
                } else
                    by = Filex.read(is);
                str = new String(by,"UTF-8");
                //Filex.logs("TJBaidu.send.txt","返回" + i + "：" + str + "\r\n\r\n");
                return new JSONObject(str);
            } catch(Throwable ex)
            {
                Filex.logs("TJBaidu.txt",ex);
            } finally
            {
                conn.disconnect();
                Filex.logs("TJBaidu.send.txt","时间" + i + "：" + MT.ss((int) (System.currentTimeMillis() - cur) / 1000));
            }
        }
        return null;
    }

    static final Pattern URL = Pattern.compile("/x?html\\d?/[A-Za-z/]+/(\\d+/)?(\\d+)(-\\d+)?.htm"),PAR = Pattern.compile("\\?node=(\\d+)");
    public static int parse(String url) throws SQLException
    {
        int node = 0;
        Matcher m = URL.matcher(url);
        if(m.find())
        {
            String s1 = m.group(1);
            int a1 = s1 == null ? 0 : Integer.parseInt(s1.substring(0,s1.length() - 1));
            node = a1 * 10000 + Integer.parseInt(m.group(2));
        } else
        {
            url = url.substring(url.charAt(7) == '/' ? 8 : 7);
            int j = url.indexOf('/',4); //-1:首页
            if(url.charAt(j + 1) == '?') //带参数的首页
            {
                url = url.substring(0,j);
                j = -1;
            }
            if(j == -1)
            {
                try
                {
                    DNS obj = DNS.find(url);
                    if(!obj.isExists())
                        obj = DNS.find("%");
                    node = obj.getNode();
                } catch(Throwable ex)
                {}
            } else if((m = PAR.matcher(url)).find())
            {
                node = Integer.parseInt(m.group(1));
            } else
            {
                int x;
                String str = url.substring(j);
                StringBuilder sb = new StringBuilder();
                sb.append("SELECT node FROM NodeLayer WHERE clickurl IN(" + DbAdapter.cite(str));
                if((x = str.indexOf('?')) > 0)
                    sb.append("," + DbAdapter.cite(str = str.substring(0,x)));
                if(str.endsWith("/index.html"))
                    sb.append("," + DbAdapter.cite(str.substring(0,str.length() - 10)));
                sb.append(")");
                if(str.endsWith(".htm"))
                    sb.append(" UNION ALL SELECT node FROM Node WHERE name=" + DbAdapter.cite(str.substring(1,str.length() - 4)));
                DbAdapter db = new DbAdapter();
                try
                {
                    db.executeQuery(sb.toString());
                    if(db.next())
                        node = db.getInt(1);
                    else
                        Filex.logs("TJBaidu.url.txt",url);
                } finally
                {
                    db.close();
                }
            }
        }
        return node;
    }

    public synchronized static void main2(String[] args)
    {
        Http.enc("");
        try
        {
            TJBaidu tj = new TJBaidu();
            String info = tj.login("ednccic","cA3rED6vvtBa7Fbc","57ece6b2c1c6132bb998e5991794aa3e");
            System.out.println(tj.header);

            JSONObject jo = tj.find("'site_id':8367906,'method':'source/all/a','start_date':'20161120','end_date':'20161120','metrics':'pv_count,visitor_count,ip_count,bounce_ratio,avg_visit_time','max_results':100");
            System.out.println(jo);
        } catch(Throwable ex)
        {
            Filex.logs("TJBaidu.txt",ex);
        }
    }

    public synchronized static void main(String[] args)
    {
        Http.enc("");
        try
        {
            HashMap hm = new HashMap();
            ArrayList al = Community.find(" AND tjbaidu IS NOT NULL",0,Integer.MAX_VALUE);
            for(int x = 0;x < al.size();x++)
            {
                Community c = (Community) al.get(x);
                String[] arr = (c.tjbaidu + "||||| ").split("[|]");

                TJBaidu tj = (TJBaidu) hm.get(arr[1]);
                if(tj == null)
                {
                    tj = new TJBaidu();
                    String info = tj.login(arr[1],arr[2],arr[3]);
                    if(info != null)
                    {
                        Filex.logs("TJBaidu.txt","返回,method:login　data:" + info);
                        continue;
                    }
                }
                hm.put(arr[1],tj);
                tj.stat1(c,Integer.parseInt(arr[4]));
            }
        } catch(Throwable ex)
        {
            Filex.logs("TJBaidu.txt",ex);
        }
    }

    public void stat1(Community c,int id) throws Exception
    {
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_YEAR, -30);
        for(int i = 11;i < 15;i++)
            cal.set(i,0);
        for(int x = 0;x < 30;x++,cal.add(Calendar.DAY_OF_YEAR,1))
        {
            String stime = MT.f(cal.getTime()).replaceAll("-","");

            java.sql.Date date = new java.sql.Date(cal.getTimeInMillis());

            {
                String sql = " WHERE community=" + DbAdapter.cite(c.community) + " AND time=" + DbAdapter.cite(cal.getTime());
                Filex.logs("TJBaidu.log.txt",sql + "　" + Http.REAL_PATH);
                DbAdapter db = new DbAdapter();
                try
                {
                    db.executeQuery("SELECT pv0 FROM sday" + sql);
                    if(db.next())
                    {
                        Filex.logs("TJBaidu.log.txt","　　跳过1\r\n");
                        continue;
                    }
                    String[] tab =
                            {"spage","sdata"};
                    for(int i = 0;i < tab.length;i++)
                        db.executeUpdate("DELETE FROM " + tab[i] + sql);
                } finally
                {
                    db.close();
                }
            }
            //事件分析
            {
                int f = 0;
                JSONObject jo = find("'site_id':" + id + ",'method':'custom/event_track/a','start_date':'" + stime + "','end_date':'" + stime + "','metrics':'event_count,uniq_event_count','max_results':200"); //,event_value,avg_event_value',category':'search','action':'query','label':''
                JSONArray ja = jo.getJSONArray("items");
                JSONArray ja0 = ja.getJSONArray(0),ja1 = ja.getJSONArray(1);
                DbAdapter db = new DbAdapter();
                try
                {
                    PreparedStatement ps = db._con.prepareStatement("INSERT INTO sdata(type,community,time,data,pv" + f + ",uv" + f + ")VALUES(?,?,?,?,?,?)");
                    ps.setInt(1,6);
                    ps.setString(2,c.community);
                    ps.setDate(3,date);
                    //总计
                    JSONArray val = jo.getJSONArray("sum").getJSONArray(0);
                    ps.setString(4,"总计");
                    //set(val,val.length() - 1);
                    set(val,ps,5);
                    ps.executeUpdate();

                    //列表
                    for(int i = 0;i < ja0.length();i++)
                    {
                        jo = ja0.getJSONArray(i).getJSONObject(0);
                        String name = jo.getString("c") + "," + jo.getString("a") + "," + jo.getString("l");
                        if(name.length() > 50)
                            name = name.substring(0,47) + "...";
                        ps.setString(4,name);
                        val = ja1.getJSONArray(i);
                        //set(val,val.length() - 1);
                        set(val,ps,5);
                        try
                        {
                            ps.executeUpdate(); //搜索词区分大小写
                        } catch(SQLException ex)
                        {
                            Filex.logs("TJBaidu.txt","json:" + ja0.toString() + "\r\nsearch:" + name + "\r\nerr:" + ex.toString());
                        }
                    }
                    ps.close();
                } catch(Throwable ex)
                {
                    Filex.logs("TJBaidu.txt",ex);
                } finally
                {
                    db.close();
                }
            }

            String[] filter =
                    {"--","through","search,0","link","new","old"};
            for(int f = 0;f < filter.length;f++)
            {
                String fstr = "";
                if(f > 0)
                    fstr += ",'" + (f > 3 ? "visitor" : "source") + "':'" + filter[f] + "'";

                String[] type =
                        {"--","source/searchword/a","source/link/a","visit/district/a"};
                for(int t = 1;t < type.length;t++)
                {
                    String tstr = fstr;
                    if(f < 4)
                        if(t == 1) //搜索词
                        {
                            //1:百度,2:Google,14:360搜索
                            tstr = ",'source':'search," + (f == 3 ? 14 : f) + "'";
                        } else if(t == 2) //外部链接
                        {
                            //1:社会化媒,2:导航网站,4:电子邮箱
                            tstr = ",'domainType':" + (f == 3 ? 4 : f) + "";
                        }

                    JSONObject jo = find("'site_id':" + id + ",'method':'" + type[t] + "','start_date':'" + stime + "','end_date':'" + stime + "','metrics':'pv_count,visitor_count,ip_count,bounce_ratio,avg_visit_time','max_results':100" + tstr);
                    JSONArray ja = jo.getJSONArray("items");
                    JSONArray ja0 = ja.getJSONArray(0),ja1 = ja.getJSONArray(1);
                    DbAdapter db = new DbAdapter();
                    try
                    {
                        PreparedStatement ps = db._con.prepareStatement(f < 1 ? "INSERT INTO sdata(pv" + f + ",uv" + f + ",ip" + f + ",rate" + f + ",stay" + f + ",type,community,time,data)VALUES(?,?,?,?,?,?,?,?,?)" : "UPDATE sdata SET pv" + f + "=?,uv" + f + "=?,ip" + f + "=?,rate" + f + "=?,stay" + f + "=? WHERE type=? AND community=? AND time=? AND data=?");
                        ps.setInt(6,t);
                        ps.setString(7,c.community);
                        ps.setDate(8,date);
                        //总计
                        JSONArray val = jo.getJSONArray("sum").getJSONArray(0);
                        ps.setString(9,"总计");
                        set(val,val.length() - 2);
                        set(val,ps,1);
                        ps.executeUpdate();

                        //列表
                        for(int i = 0;i < ja0.length();i++)
                        {
                            String name = ja0.getJSONArray(i).getJSONObject(0).getString("name");
                            if(name.length() > 50)
                                name = name.substring(0,47) + "...";
                            ps.setString(9,name);
                            val = ja1.getJSONArray(i);
                            set(val,val.length() - 2);
                            set(val,ps,1);
                            try
                            {
                                ps.executeUpdate(); //搜索词区分大小写
                            } catch(SQLException ex)
                            {
                                Filex.logs("TJBaidu.txt","json:" + ja0.toString() + "\r\nname:" + name + "\r\nerr:" + ex.toString() + "\r\n");
                            }
                        }
                        ps.close();
                    } finally
                    {
                        db.close();
                    }
                }

                //受访页面
                JSONObject jo = find("'site_id':" + id + ",'method':'visit/toppage/a','start_date':'" + stime + "','end_date':'" + stime + "','metrics':'pv_count,visitor_count,ip_count,visit1_count,outward_count,exit_count,average_stay_time,exit_ratio','max_results':200" + fstr);
                DbAdapter db = new DbAdapter(),d2 = new DbAdapter();
                try
                {
                    PreparedStatement pu = d2._con.prepareStatement("UPDATE spage SET pv" + f + "=COALESCE(pv" + f + ",0)+?,uv" + f + "=COALESCE(uv" + f + ",0)+?,ip" + f + "=COALESCE(ip" + f + ",0)+?,entrance" + f + "=COALESCE(entrance" + f + ",0)+?,outward" + f + "=COALESCE(outward" + f + ",0)+?,exit" + f + "=COALESCE(exit" + f + ",0)+?,stay" + f + "=COALESCE(stay" + f + ",?),rate" + f + "=COALESCE(rate" + f + ",?) WHERE community=? AND time=? AND node=?");
                    PreparedStatement ps = db._con.prepareStatement("INSERT INTO spage(pv" + f + ",uv" + f + ",ip" + f + ",entrance" + f + ",outward" + f + ",exit" + f + ",stay" + f + ",rate" + f + ",community,time,node)VALUES(?,?,?,?,?,?,?,?,?,?,?)");
                    pu.setString(9,c.community);
                    pu.setDate(10,date);
                    ps.setString(9,c.community);
                    ps.setDate(10,date);
                    //总计
                    JSONArray val = jo.getJSONArray("sum").getJSONArray(0);
                    set(val,val.length() - 1);
                    if(f < 1)
                    {
                        ps.setInt(11, -1);
                        set(val,ps,1);
                        ps.executeUpdate();
                    } else
                    {
                        pu.setInt(11, -1);
                        set(val,pu,1);
                        pu.executeUpdate();
                    }
                    //列表
                    JSONArray ja = jo.getJSONArray("items");
                    JSONArray ja0 = ja.getJSONArray(0),ja1 = ja.getJSONArray(1); //0维度数据,1指标数据,2对比时间段数据,3变化率数据
                    for(int i = 0;i < ja0.length();i++)
                    {
                        String name = ja0.getJSONArray(i).getJSONObject(0).getString("name");
                        int node = name.length() < 8 ? 0 : parse(name); //小于8位:其他
                        val = ja1.getJSONArray(i);
                        set(val,val.length() - 1);

                        pu.setInt(11,node);
                        set(val,pu,1);
                        int j = pu.executeUpdate();
                        if(j < 1)
                        {
                            ps.setInt(11,node);
                            set(val,ps,1);
                            ps.executeUpdate();
                        }
                    }
                    pu.close();
                    ps.close();

                    //趋势分析
                    jo = find("'site_id':" + id + ",'method':'trend/time/a','start_date':'" + stime + "','end_date':'" + stime + "','metrics':'pv_count,visitor_count,ip_count,bounce_ratio,avg_visit_time','gran':'day'" + fstr);
                    //总计
                    val = jo.getJSONArray("sum").getJSONArray(0);
                    set(val,val.length() - 2);
                    ps = db._con.prepareStatement(f < 1 ? "INSERT INTO sday(pv" + f + ",uv" + f + ",ip" + f + ",rate" + f + ",stay" + f + ",community,time)VALUES(?,?,?,?,?,?,?)" : "UPDATE sday SET pv" + f + "=?,uv" + f + "=?,ip" + f + "=?,rate" + f + "=?,stay" + f + "=? WHERE community=? AND time=?");
                    ps.setString(6,c.community);
                    ps.setDate(7,date);
                    set(val,ps,1);
                    ps.executeUpdate();
                    ps.close();
                } finally
                {
                    db.close();
                    d2.close();
                }
            }
        }
    }

    //跳出率 转 int
    static void set(JSONArray val,int i)
    {
        val.put(i,(int) (val.optDouble(i) * 100));
    }

    static void set(JSONArray val,PreparedStatement ps,int i) throws JSONException,SQLException
    {
        for(int j = 0;j < val.length();j++)
        {
            ps.setInt(i + j,val.optInt(j));
        }
    }

    public void stat(Community c,int id) throws Exception
    {
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_YEAR, -5);
        for(int x = 0;x < 5;x++,cal.add(Calendar.DAY_OF_YEAR,1))
        {
            String dtime = DbAdapter.cite(cal.getTime(),true);
            String stime = MT.f(cal.getTime()).replaceAll("-","");

            String sql = " WHERE community=" + DbAdapter.cite(c.community) + " AND time=" + dtime;
            Filex.logs("TJBaidu.log.txt",sql + "　" + Http.REAL_PATH);
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT pv0 FROM sday" + sql);
                if(db.next())
                {
                    Filex.logs("TJBaidu.log.txt","　　跳过1\r\n");
                    continue;
                }
                db.executeUpdate("DELETE FROM spage" + sql);
            } finally
            {
                db.close();
            }
            //
            int f = 0,start = 0;
            while(f < FILTER_TYPE.length)
            {
                Filex.logs("TJBaidu.log.txt","　　" + FILTER_TYPE[f]);
                String str = "{'reportid':1,'siteid':" + id + ",'start_time':'" + stime + "000000','end_time':'" + stime + "235959','metrics':['pageviews','visitors','ips','entrances','outwards','exits','stayTime','exitRate'],'sort':['pageviews desc'],'start_index':" + start + ",'max_results':10000";
                if(f > 3) //访客
                    str += ",'filters':['newVisitor=" + (f - 3) + "']";
                else if(f > 0) //来源
                    str += ",'filters':['fromType=" + f + "']";
                str += "}";
                JSONArray ja;
                if((str = query(str)) == null || (ja = getstatus(str)) == null) //siteid错误 || start_time错误
                {
                    f = Short.MAX_VALUE;
                    if(status == 8501)
                        x = f;
                    Filex.logs("TJBaidu.log.txt","　　跳过2,　" + status + ":" + message + "\r\n");
                    break;
                }
                //
                db = new DbAdapter();
                try
                {
                    db.setAutoCommit(false);
                    for(int i = 0;i < ja.length();i++)
                    {
                        JSONObject jo = ja.getJSONObject(i);
                        String page = jo.getString("page");
                        SPage t = new SPage(0);
                        t.community = c.community;
                        if(i % 1000 == 0)
                            System.out.println(FILTER_TYPE[f] + " " + i + "、" + page);
                        if(page != null && page.length() > 10) //null,others
                            t.node = parse(page);
                        t.pv[f] = jo.getInt("pageviews");
                        t.uv[f] = jo.getInt("visitors");
                        t.ip[f] = jo.getInt("ips");
                        t.entrance[f] = jo.getInt("entrances");
                        t.outward[f] = jo.getInt("outwards");
                        t.exit[f] = jo.getInt("exits");
                        t.stay[f] = (int) jo.getDouble("stayTime"); //有可能是null
                        t.rate[f] = (int) (jo.getDouble("exitRate") * 10000); //同上

                        int j = db.executeUpdate("UPDATE spage SET pv" + f + "=COALESCE(pv" + f + ",0)+" + t.pv[f] + ",uv" + f + "=COALESCE(uv" + f + ",0)+" + t.uv[f] + ",ip" + f + "=COALESCE(ip" + f + ",0)+" + t.ip[f] + ",entrance" + f + "=COALESCE(entrance" + f + ",0)+" + t.entrance[f] + ",outward" + f + "=COALESCE(outward" + f + ",0)+" + t.outward[f] + ",exit" + f + "=COALESCE(exit" + f + ",0)+" + t.exit[f] + ",stay" + f + "=COALESCE(stay" + f + "," + t.stay[f] + "),rate" + f + "=COALESCE(rate" + f + "," + t.rate[f] + ")" + sql + " AND node=" + t.node);
                        if(j < 1)
                            db.executeUpdate("INSERT INTO spage(community,time,node,pv" + f + ",uv" + f + ",ip" + f + ",entrance" + f + ",outward" + f + ",exit" + f + ",stay" + f + ",rate" + f + ")VALUES(" + DbAdapter.cite(t.community) + "," + dtime + "," + t.node + "," + t.pv[f] + "," + t.uv[f] + "," + t.ip[f] + "," + t.entrance[f] + "," + t.outward[f] + "," + t.exit[f] + "," + t.stay[f] + "," + t.rate[f] + ")");
                    }
                } finally
                {
                    db.setAutoCommit(true);
                    db.close();
                }
                if(ja.length() == 10000)
                    start += ja.length();
                else
                {
                    start = 0;
                    f++;
                }
            }
            if(f == FILTER_TYPE.length)
            {
                db = new DbAdapter();
                try
                {
                    db.executeQuery("SELECT SUM(pv0),SUM(pv1),SUM(pv2),SUM(pv3),SUM(pv4),SUM(pv5),SUM(CASE WHEN uv0<entrance0 THEN uv0 ELSE entrance0 END),SUM(CASE WHEN uv1<entrance1 THEN uv1 ELSE entrance1 END),SUM(CASE WHEN uv2<entrance2 THEN uv2 ELSE entrance2 END),SUM(CASE WHEN uv3<entrance3 THEN uv3 ELSE entrance3 END),SUM(CASE WHEN uv4<entrance4 THEN uv4 ELSE entrance4 END),SUM(CASE WHEN uv5<entrance5 THEN uv5 ELSE entrance5 END),SUM(CASE WHEN ip0<entrance0 THEN ip0 ELSE entrance0 END) FROM spage" + sql);
                    if(db.next())
                    {
                        int uv0 = db.getInt(7),uv2 = db.getInt(9),uv3 = db.getInt(10),uv4 = db.getInt(11);
                        db.executeUpdate("INSERT INTO sday(community,time,pv0,pv1,pv2,pv3,pv4,pv5,uv0,uv1,uv2,uv3,uv4,uv5,ip0)VALUES(" + DbAdapter.cite(c.community) + "," + dtime + "," + db.getInt(1) + "," + db.getInt(2) + "," + db.getInt(3) + "," + db.getInt(4) + "," + db.getInt(5) + "," + db.getInt(6) + "," + uv0 + "," + (uv0 - uv2 - uv3) + "," + uv2 + "," + uv3 + "," + uv4 + "," + (uv0 - uv4) + "," + db.getInt(13) + ")");
                    }
                } finally
                {
                    db.close();
                }
            }
        }
    }

    public String query(String str) throws IOException
    {
        JSONObject jo = find("'serviceName':'report','methodName':'query','parameterJSON':" + Attch.cite(str.replace('\'','"')));
        return jo == null ? null : jo.getJSONObject("query").getString("result_id");
    }

    public JSONArray getstatus(String id) throws IOException
    {
        try
        {
            Thread.sleep(30000);
        } catch(InterruptedException ex)
        {
        }
        JSONObject jo = find("'serviceName':'report','methodName':'getstatus','parameterJSON':" + Attch.cite("{\"result_id\":\"" + id + "\"}"));
        jo = jo.getJSONObject("result");
        status = jo.getInt("status"); //0:无效/result_id过期，1:报告结果生成中，2:生成失败/无数据，3:已生成、可下载
        if(status == 0)
            return null;
        if(status == 1)
            return getstatus(id);
        if(status == 2)
        {
            return new JSONArray();
        }
        String url = jo.getString("result_url");
        String str = (String) Http.open(url,null); //https://apidata.baidu.com
        Filex.write("TJBaidu.getstatus.txt",str);
        return new JSONArray(str);
    }

    public void gettrans() throws IOException
    {
        String str = "{'url':'%api.healthlink.cn%'}";
        JSONObject jo = find("'serviceName':'profile','methodName':'get_trans_info','parameterJSON':" + Attch.cite(str.replace('\'','"')));
    }

    public JSONObject find(String data) throws IOException
    {
        String str = "{'header':{" + header + "},'body':{" + data + "}}";
        JSONObject jo = send(str.replace('\'','"'));

        //
        JSONObject he = jo.getJSONObject("header");
        he.getString("desc"); //响应描述
        status = he.getInt("status"); //响应状态,2:failure,3:system failure
        if(status == 0)
        {
            he.getInt("quota"); //请求消耗的配额数
            rquota = he.getInt("rquota"); //剩余配额数

            jo = jo.getJSONObject("body");
            str = jo.optString("responseData",null); //旧接口
            if(str != null)
                return new JSONObject(str);
            else
            {
                jo = jo.getJSONArray("data").getJSONObject(0);
                return jo.isNull("result") ? jo : jo.getJSONObject("result");
            }
        } else
        {
            jo = he.getJSONArray("failures").getJSONObject(0);
            //8501:You do not have enough quota.
            //8206:The session is invalid.
            //84024:The token is invalid, please contact administrator. sn:567577669976704
            //9102101:no right to operate current siteid
            //91021052:start_time is latter than now
            //91021053:end_time is latter than now
            status = jo.getInt("code");
            message = jo.getString("message");
            jo.getString("position");
            //8611:Time out exception, please try again later.
            if(status == 8611)
            {
                try
                {
                    Thread.sleep(10000);
                } catch(Throwable ex)
                {}
                return find(data);
            }
            Filex.logs("TJBaidu.log.txt","　　Line:600,　Err:" + jo);
            return null;
        }
    }

    public void getsites() throws IOException
    {
        JSONObject jo = find("'serviceName':'profile','methodName':'getsites'");
        JSONArray ja = jo.getJSONArray("sites");
        for(int i = 0;i < ja.length();i++)
        {
            jo = ja.getJSONObject(i);
            jo.getInt("type"); //是否是子目录
            JSONArray co = jo.getJSONArray("conf");
            for(int j = 0;j < co.length();j++)
            {
                jo = co.getJSONObject(j);
                jo.getInt("flag"); //0：白名单，1：黑名单；
                jo.getString("pattern"); //站点域名或者子目录配置的 url 规则
            }
        }
    }

    //登录
    public String login(String username,String password,String token) throws IOException
    {
        if(token.length() < 1)
            return username + "未开通！";
        header = "'username':'" + username + "','token':'" + token + "','uuid':'MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBg-1'";
        //
        String json = "{" + header + ",'functionName':'preLogin','request':{'osVersion':'Android','deviceType':'cellphone','clientVersion':'0.1'}}";
        JSONObject jo = send(json.replace('\'','"'));
        if(jo == null)
            return "网络错误！";
        int code = jo.optInt("retcode");
        if(code > 0)
            return code + ":" + jo.getString("retmsg");
        if(jo.getBoolean("needAuthCode")) //验证码
        {
            jo = jo.getJSONObject("authCode");
            byte[] by = new BASE64Decoder().decodeBuffer(jo.getString("imgdata"));
            Filex.write("TJBaidu." + jo.getString("imgtype"),by);

            ByteArrayOutputStream ba = new ByteArrayOutputStream();
            int j = 0;
            InputStream in = System.in;
            while((j = in.read()) != 10)
                ba.write(j);
            jo.put("code",ba.toString("GBK"));
        }
        //
        json = "{" + header + ",'functionName':'doLogin','request':{'password':'" + password + "','imageCode':'" + jo.optString("code") + "','imageSsid':'" + jo.optString("imgssid") + "'}}";
        jo = send(json.replace('\'','"'));
        ucid = jo.getInt("ucid");
        st = jo.getString("st");
        header += ",'account_type':1,'password':'" + st + "'";

        code = jo.getInt("retcode");
        return code == 0 ? null : code + ":" + jo.getString("retmsg");
    }

    //退出
    public boolean logout() throws IOException
    {
        String json = "{" + header + ",'functionName':'doLogout','request':{'ucid':'" + ucid + "','st':'" + st + "'}}";
        JSONObject jo = send(json.replace('\'','"'));
        return jo.getInt("retcode") == 0;
    }

    public static String[] f(int type)
    {
        String[] arr = TJBaidu.FILTER_TYPE;
        if(type == 1)
            arr = new String[]
                  {"--","百度","Google","360搜索","新访客","老访客"};
        if(type == 2)
            arr = new String[]
                  {"--","社会化媒","导航网站","电子邮箱","新访客","老访客"};
        return arr;
    }
}
