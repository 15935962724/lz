package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import org.json.JSONObject;
import tea.resource.Common;
import tea.entity.weibo.*;
import org.json.JSONException;
import tea.ui.TeaSession;
import java.text.SimpleDateFormat;
import org.json.JSONArray;
import java.net.HttpURLConnection;
import java.net.URL;

//large:大图 bmiddle:中图 thumbnail:小图
public class Historical
{
    protected static Cache c = new Cache(50);
    public static int COUNT;
    static
    {
        try
        {
            COUNT = Historical.count("");
        } catch(Throwable ex)
        {}
    }

    public int node; //节点号
    public int language; //语言层
    public Date otime; //发生时间
    public int year,month,day;
    private int oday;
    public static String[] HISTORICAL_TYPE =
            {"--","网站","微博"};
    public int type; //来源
    public String source; //来源出处
    public String sourcedesc; //来源出处说明
    public int smember; //分享人
    public Date stime; //分享时间
    //
    private int wvoice; //视频状态
    //
    public long microid; //微博ID
    public int reposts; //转发数
    public int comments; //评论数
//    public String mtext; //微博内容
//    public long muser; //微博的用户ID
//    public String mname; //微博姓名
//    public String avatar; //头像
//    public int verified; //是否已认证
    public Date time; //上传时间

    public Historical(int node,int language)
    {
        this.node = node;
        this.language = language;
    }

    public static Historical find(int node,int language) throws SQLException
    {
        Historical t = (Historical) c.get(node + ":" + language);
        if(t == null)
        {
            ArrayList al = find(" AND node=" + node + " AND language=" + language,0,1);
            t = al.size() < 1 ? new Historical(node,language) : (Historical) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT node,language,otime,year,month,day,oday,type,source,sourcedesc,smember,stime,wvoice,microid,reposts,comments,time FROM historical WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Historical t = new Historical(rs.getInt(i++),rs.getInt(i++));
                t.otime = db.getDate(i++);
                t.year = db.getInt(i++);
                t.month = db.getInt(i++);
                t.day = db.getInt(i++);
                t.oday = db.getInt(i++);
                t.type = rs.getInt(i++);
                t.source = rs.getString(i++);
                t.sourcedesc = rs.getString(i++);
                t.smember = rs.getInt(i++);
                t.stime = db.getDate(i++);
                //
                t.wvoice = rs.getInt(i++);
                //
                t.microid = rs.getLong(i++);
                t.reposts = rs.getInt(i++);
                t.comments = rs.getInt(i++);

                t.time = db.getDate(i++);
                c.put(t.node,t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM historical WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        //if (otime != null)
        //{
        //    oday = Integer.parseInt(new SimpleDateFormat("MMdd").format(otime));
        //}
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate("UPDATE historical SET otime=" + DbAdapter.cite(otime) + ",year=" + year + ",month=" + month + ",day=" + day + ",oday=" + oday + ",type=" + type + ",source=" + DbAdapter.cite(source) + ",sourcedesc=" + DbAdapter.cite(sourcedesc) + ",smember=" + smember + ",stime=" + DbAdapter.cite(stime) + ",wvoice=" + wvoice + ",microid=" + microid + ",reposts=" + reposts + ",comments=" + comments + ",time=" + DbAdapter.cite(time) + " WHERE node=" + node + " AND language=" + language);
            if(i < 1)
            {
                time = new Date();
                db.executeUpdate("INSERT INTO historical(node,language,otime,year,month,day,oday,type,source,sourcedesc,smember,stime,wvoice,microid,reposts,comments,time)VALUES(" + node + "," + language + "," + DbAdapter.cite(otime) + "," + year + "," + month + "," + day + "," + oday + "," + type + "," + DbAdapter.cite(source) + "," + DbAdapter.cite(sourcedesc) + "," + smember + "," + DbAdapter.cite(stime) + "," + wvoice + "," + microid + "," + reposts + "," + comments + "," + DbAdapter.cite(time) + ")");
            }
        } finally
        {
            db.close();
        }
        c.remove(node);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM historical WHERE node=" + node + " AND language=" + language);
        c.remove(node);
    }


    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE historical SET " + f + "=" + DbAdapter.cite(v) + " WHERE node=" + node + " AND language=" + language);
        c.remove(node);
    }

    //
    public String getDetail(Node n,Http h,int listing,String target) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        String subject = n.getSubject(h.language);
        ListingDetail detail = ListingDetail.find(listing,97,h.language);
        Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
                continue;
            int a = detail.getAnchor(name);

            String url = "/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/historical/" + node + "-" + h.language + ".htm";
            String bi = detail.getBeforeItem(name),ai = detail.getAfterItem(name);
            //int dq = detail.getQuantity(name);
            if(name.equals("subject"))
            {
                value = subject;
            } else if(name.equals("content"))
                value = n.getText(h.language);
            else if(name.equals("otime"))
                value = MT.f(otime);
            else if(name.equals("source"))
                value = source;
            else if(name.equals("sourcedesc"))
                value = sourcedesc;
            else if(name.equals("picture"))
            {
                value = n.getPicture(h.language);
                value = value == null ? null : "<img src='" + value + "' />";
            } else if(name.equals("voice"))
            {
                value = n.getVoice(h.language);
                value = value == null ? null : "<embed src='/tea/image/flv/FLVPlayer_Progressive.swf' width='460' height='380' type='application/x-shockwave-flash' flashvars='&MM_ComponentVersion=1&skinName=/tea/image/flv/Clear_Skin_3&streamName=" + Http.enc(value) + "&autoPlay=false&autoRewind=false'></embed>";
            } else if(name.equals("time"))
                value = MT.f(time,1);
            else if(microid > 0)
            {
                WMicro wm = WMicro.find(microid);
                WUser wu = WUser.find(wm.userid);
                url = "http://weibo.com/" + wm.userid;
                if(name.equals("mname"))
                {
                    value = wu.nick;
                    if(wu.verified != -1)
                        value += "<img src='/tea/image/weibo/v" + wu.verified + ".png' />";
                } else if(name.equals("avatar"))
                {
                    value = "<img src='" + (wu.avatar == null ? "/tea/image/weibo/avatar1.gif" : wu.avatar) + "' />";
                } else
                {
                    url += "/" + OAuth.mid(microid);
                    if(name.equals("mtext"))
                    {
                        value = OAuth.face(wm.content);
                        if(a != 0)
                        {
                            value = OAuth.a(value,url);
                            a = 0;
                        }
                    } else if(name.equals("stime"))
                        value = OAuth.f(stime);
                    else if(name.equals("reposts"))
                    {
                        value = String.valueOf(reposts);
                        url += "?type=repost";
                    } else if(name.equals("comments"))
                    {
                        value = String.valueOf(comments);
                    }
                }
            }

            if(value == null)
                value = "";
            if(istype == 2 && value.length() < 1)
                continue;

            //限制字数
            value = detail.getOptionsToHtml(name,n,value);

            //显示连接的地方
            if(a != 0)
            {
                value = "<a href='" + url + "' target='" + target + "' title=\"" + MT.f(subject) + "\">" + value + "</a>";
            }
            sb.append(bi).append("<span id='HistoricalID" + name + "'>" + value + "</span>").append(ai);
        }
        return sb.toString();
    }

    public String getOTime()
    {
        StringBuilder sb = new StringBuilder();
        if(year > 0)
            sb.append(year).append("年 ");
        if(month > 0)
            sb.append(month).append("月 ");
        if(day > 0)
            sb.append(day).append("日 ");
        return sb.toString();
    }

    static int last = 0;
    public static void counts()
    {
        try
        {
            String community = null;
            Iterator it = Historical.find(" AND node>" + last + " AND microid>0 ORDER BY node",0,50).iterator();
            if(!it.hasNext())
                last = 0;
            else
            {
                StringBuilder sb = new StringBuilder();
                while(it.hasNext())
                {
                    Historical t = (Historical) it.next();
                    last = t.node;
                    if(sb.length() > 0)
                        sb.append(",");
                    else
                        community = Node.find(t.node).getCommunity();
                    sb.append(t.microid);
                }
                counts(community,sb.toString());
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }

    //ids:最大100条
    public static void counts(String community,String ids) throws SQLException,JSONException
    {
        WConfig wc = WConfig.find(community);
        JSONObject o = new JSONObject(OAuth2.oauth("https://api.weibo.com/2/statuses/count.json?ids=" + ids,null,null,wc.sinatoken));
        String err = o.getString("error");
        if(err.length() > 0)
        {
            System.out.println(err);
            return;
        }
        JSONArray ja = o.getJSONArray("data");
        System.out.println("Historical 条数：" + ja.length());
        //
        for(int i = 0;i < ja.length();i++)
        {
            o = ja.getJSONObject(i);
            long id = o.getLong("id");
            int reposts = o.getInt("reposts"),comment = o.getInt("comments");
            if(reposts == 0 && comment == 0)
                continue;

            Iterator it = Historical.find(" AND microid=" + id,0,1).iterator();
            if(!it.hasNext())
                continue;
            Historical t = (Historical) it.next();
            if(t.reposts != reposts)
            {
                WMicro.find(id).ref_reposts(wc);
                t.reposts = reposts;
            }
            if(t.comments != comment)
            {
                WMicro.find(id).ref_comments(wc);
                t.comments = comment;
            }
            t.set();
        }
    }

    //分享到微博
    public String share() throws JSONException,IOException,SQLException
    {
        Node n = Node.find(node);
        WConfig wc = WConfig.find(n.getCommunity());
        String content = n.getText(language),picture = n.getPicture(language);
        //内容
        Iterator it = WVoice.find(" AND node=" + node + " AND state=1",0,100).iterator();
        int len = 280;
        if(wc.url.length() > 0)
            len -= 19;
        if(it.hasNext())
            len -= 19;
        if(wc.topic.length() > 0)
            content = "#" + wc.topic + "#" + content;
        content = OAuth.f(content,len); //"http://t.cn/zOmVGZc";
        while(it.hasNext())
        {
            WVoice wv = (WVoice) it.next();
            content += "http://www.tudou.com/programs/view/" + wv.code + "/";
        }
        content += wc.url;
        //图片
        byte[] pic = null;
        String tmp = MT.f(picture,wc.picture);
        if(tmp != null)
            pic = Filex.read(Common.REAL_PATH + tmp);
        //
        String json = OAuth2.oauth("https://api.weibo.com/2/statuses/" + (pic == null ? "update" : "upload") + ".json","status=" + Http.enc(content),pic,wc.sinatoken);
        JSONObject o = new JSONObject(json);
        int code = o.getInt("error_code");
        if(code > 0)
        {
            return OAuth2.err(code,o.getString("error"));
        }
        WMicro m = WMicro.create(o.getJSONObject("data"),false);
        microid = m.microid;
        stime = m.time;
        set();
        return null;
    }

    //分享视频
    public String share(Writer out) throws SQLException,JSONException
    {
        System.out.println("上传视频：开始 " + (out != null ? "手动" : "定时") + " 编号：" + node);
        String info = null;
        Iterator it = WVoice.find(" AND node=" + node,0,1).iterator();
        if(it.hasNext())
        {
            WVoice wv = (WVoice) it.next();
            info = "视频状态：" + Tudou.STATE_TYPE[wv.state];
        } else
        {
            Node n = Node.find(node);
            try
            {
                if(out != null)
                {
                    for(int j = 0;j < 20;j++)
                        out.write("// 显示进度条  \n");
                    out.write("<script>parent.$('dialog_header').innerHTML='正在上传中...';parent.$('dialog_content').innerHTML='正在连接视频服务器...';</script>");
                    out.flush();
                }

                WConfig wc = WConfig.find(n.getCommunity());
                JSONObject o = new Tudou(wc.community).upload(n.getSubject(1),"无",wc.topic).getJSONObject("itemUploadInfo");
                String url = o.getString("uploadUrl");
                String item = o.getString("itemCode");
                url = "http://119.167.203.129" + url.substring(url.indexOf('/',8));

                File f = new File(Http.REAL_PATH + n.getVoice(1));
                //f = new File("E:/测试/test_flv.flv");
                int size = (int) f.length() + 140;

                HttpURLConnection conn = (HttpURLConnection)new URL(url).openConnection();
                conn.addRequestProperty("Content-Type","multipart/form-data; boundary=Jf4mVY1mx_eLBt5GRmSe9hz6i_u6bW");
                conn.setFixedLengthStreamingMode(size);
                conn.setDoOutput(true);
                OutputStream os = conn.getOutputStream();
                os.write("--Jf4mVY1mx_eLBt5GRmSe9hz6i_u6bW\r\nContent-Disposition: form-data; name=\"file\"; filename=\"picx.wmv\"\r\n\r\n".getBytes());
                long cur = 0;
                int j = 0,total = 0;
                byte[] by = new byte[1024];
                FileInputStream fis = new FileInputStream(f);
                while((j = fis.read(by)) != -1)
                {
                    os.write(by,0,j);
                    os.flush();
                    total += j;

                    long tmp = System.currentTimeMillis();
                    if(tmp - cur < 1000)
                        continue;
                    cur = tmp;
                    if(out != null)
                    {
                        out.write("<script>mt.progress(" + total + "," + size + ",'总大小：" + MT.f(size / 1024F) + "K　已完成：" + MT.f(total / 1024F) + "K');</script>");
                        out.flush();
                    } else
                    {
                        System.out.println("进度：" + total * 100L / size + "%");
                    }
                }
                fis.close();
                os.write("\r\n--Jf4mVY1mx_eLBt5GRmSe9hz6i_u6bW--\r\n".getBytes());
                os.close();

                //
                int code = conn.getResponseCode();
                InputStream is = code == 200 ? conn.getInputStream() : conn.getErrorStream();
                String str = new String(Filex.read(is),"UTF-8");
                //{"result":"ok","content":"ok"}
                System.out.println(str);

                WVoice wv = new WVoice(0);
                wv.community = wc.community;
                wv.type = 1;
                wv.state = 3;
                wv.node = node;
                wv.code = item;
                wv.set();
            } catch(IOException ex)
            {
                info = ex.toString();
            }
        }
        System.out.println("上传视频：结束");
        return info;
    }

    //定时分享
    public static void run() throws SQLException
    {
        if(COUNT < 1)
            return;
        Calendar c = Calendar.getInstance();
        int hour = c.get(Calendar.HOUR_OF_DAY);
        if(hour != 7)
            return;
        c.set(Calendar.MINUTE,0);
        c.set(Calendar.SECOND,0);
        try
        {
            ArrayList al = Historical.find(" AND microid=0 AND stime=" + DbAdapter.cite(c.getTime()),0,200);
            Filex.logs("Historical.txt","条数：" + al.size() + "　语句： AND microid=0 AND stime=" + DbAdapter.cite(c.getTime()));
            Iterator it = al.iterator();
            if(it.hasNext())
            {
                while(it.hasNext())
                {
                    Historical t = (Historical) it.next();
                    Node n = Node.find(t.node);

                    WConfig.find(n.getCommunity()).token();
                    String voice = n.getVoice(1);
                    String info = voice == null ? t.share() : t.share(null);
                    Thread.sleep(1000L);
                    Filex.logs("Historical.txt","  " + t.node + "、" + info);

                    NodeFlow nf = NodeFlow.findLast(" AND node=" + t.node + " AND state=3");
                    nf.content = info;
                    nf.set();
                }
            }
        } catch(Throwable ex)
        {
            Filex.logs("Historical.txt",ex.toString());
            ex.printStackTrace();
        }
    }
}
