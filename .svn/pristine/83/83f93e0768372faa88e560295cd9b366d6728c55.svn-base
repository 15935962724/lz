package tea.entity.stat;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import java.text.*;
import java.util.regex.*;
import tea.entity.site.CommunityOption;

public class Stat
{
    protected static Cache c = new Cache(50);
    public int stat; //访问统计
    public String community; //社区
    public String ip; //IP地址
    public String method; //请求方式
    public String url; //访问网址
    public int code; //状态码
    public int length; //长度
    public String referer; //来源
    public String useragent; //客户端信息
    public boolean isnew; //
    public Date time; //时间

    public Stat(int stat)
    {
        this.stat = stat;
    }

    public static Stat find(int stat) throws SQLException
    {
        Stat t = (Stat) c.get(stat);
        if(t == null)
        {
            ArrayList al = find(" AND stat=" + stat,0,1);
            t = al.size() < 1 ? new Stat(stat) : (Stat) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT stat,community,ip,url,method,code,length,referer,useragent,isnew,time FROM stat WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Stat t = new Stat(rs.getInt(i++));
                t.community = rs.getString(i++);
                t.ip = rs.getString(i++);
                t.url = rs.getString(i++);
                t.method = rs.getString(i++);
                t.code = rs.getInt(i++);
                t.length = rs.getInt(i++);
                t.referer = rs.getString(i++);
                t.useragent = rs.getString(i++);
                t.isnew = rs.getBoolean(i++);
                t.time = db.getDate(i++);
                c.put(t.stat,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM stat WHERE 1=1" + sql);
    }

    public void set(DbAdapter db) throws SQLException
    {
        if(stat < 1)
            db.executeUpdate("INSERT INTO stat(community,ip,url,method,referer,useragent,isnew,time)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(ip) + "," + DbAdapter.cite(url) + "," + DbAdapter.cite(method) + "," + DbAdapter.cite(referer) + "," + DbAdapter.cite(useragent) + "," + DbAdapter.cite(isnew) + "," + DbAdapter.cite(time) + ")");
        else
            db.executeUpdate("UPDATE stat SET community=" + DbAdapter.cite(community) + ",ip=" + DbAdapter.cite(ip) + ",url=" + DbAdapter.cite(url) + ",method=" + DbAdapter.cite(method) + ",referer=" + DbAdapter.cite(referer) + ",useragent=" + DbAdapter.cite(useragent) + ",isnew=" + DbAdapter.cite(isnew) + ",time=" + DbAdapter.cite(time) + " WHERE stat=" + stat);
        c.remove(stat);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM stat WHERE stat=" + stat);
        c.remove(stat);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE stat SET " + f + "=" + DbAdapter.cite(v) + " WHERE stat=" + stat);
        c.remove(stat);
    }

    //
    static final ArrayList<Stat> al = new ArrayList();
    public static void add(Http h) throws SQLException
    {
        Stat t = new Stat(0);
        t.community = h.community;
        t.ip = h.request.getRemoteAddr();
        t.method = h.request.getMethod();
        t.url = String.valueOf(h.node);
        t.referer = h.request.getHeader("referer");
        t.useragent = h.request.getHeader("user-agent");
        if(t.useragent == null || t.useragent.toLowerCase().contains("spider") || t.useragent.contains("bot"))
            return;
        t.time = new Date();
        t.isnew = h.getCook("stat",null) == null;
        if(t.isnew)
        {
            Calendar c = Calendar.getInstance();
            c.set(Calendar.HOUR_OF_DAY,24);
            c.set(Calendar.MINUTE,0);
            c.set(Calendar.SECOND,0);
            h.setCook("stat","1",(int) (c.getTimeInMillis() - t.time.getTime()) / 1000);
        }
        al.add(t);
        if(al.size() > 1 && t.time.getTime() - al.get(0).time.getTime() > 20000)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db._con.setAutoCommit(false);
                while(al.size() > 0)
                {
                    t = al.remove(al.size() - 1);
                    t.set(db);
                }
                db._con.setAutoCommit(true);
            } finally
            {
                db.close();
            }
            parse();
        }
    }

    public static void parse() throws SQLException
    {
        Calendar c = Calendar.getInstance();
        CommunityOption co = CommunityOption.find("[SYSTEM]");
        int last = co.getInt("stat");
        HashMap hh = new HashMap(),hr = new HashMap(),hp = new HashMap(),hc = new HashMap();
        DbAdapter db = new DbAdapter();
        try
        {
            db.setAutoCommit(false);
            Iterator it = Stat.find(" AND stat>" + last + " ORDER BY stat",0,1000).iterator();
            while(it.hasNext())
            {
                Stat t = (Stat) it.next();
                last = t.stat;
                c.setTime(t.time);
                c.set(Calendar.MINUTE,0);
                c.set(Calendar.SECOND,0);
                Date time = c.getTime();
                //小时
                String key = t.community + ":" + time.getTime();
                SHour sh = (SHour) hh.get(key);
                if(sh == null)
                {
                    ArrayList al = SHour.find(" AND community=" + DbAdapter.cite(t.community) + " AND time=" + DbAdapter.cite(time),0,1);
                    sh = al.size() < 1 ? new SHour(0) : (SHour) al.get(0);
                    hh.put(key,sh);
                    sh.community = t.community;
                    sh.time = time;
                }
                c.set(Calendar.HOUR_OF_DAY,0);
                time = c.getTime();
                //来路页面
                key = t.community + ":" + t.referer + ":" + time.getTime();
                SReferer sr = (SReferer) hr.get(key);
                if(sr == null)
                {
                    ArrayList al = SReferer.find(" AND community=" + DbAdapter.cite(t.community) + " AND url=" + DbAdapter.cite(t.referer) + " AND time=" + DbAdapter.cite(time),0,1);
                    sr = al.size() < 1 ? new SReferer(0) : (SReferer) al.get(0);
                    hr.put(key,sr);
                    sr.community = t.community;
                    sr.url = t.referer;
                    sr.time = time;
                }
                //受访页面
                key = t.community + ":" + t.url + ":" + time.getTime();
                SPage sp = (SPage) hp.get(key);
                if(sp == null)
                {
                    ArrayList al = SPage.find(" AND community=" + DbAdapter.cite(t.community) + " AND url=" + DbAdapter.cite(t.url) + " AND time=" + DbAdapter.cite(time),0,1);
                    sp = al.size() < 1 ? new SPage(0) : (SPage) al.get(0);
                    hp.put(key,sp);
                    sp.community = t.community;
                    sp.url = t.url;
                    sp.time = time;
                }
                //地区分布
                String city = Ip.findByIp(t.ip);
                //int j = city.indexOf(" ");
                //if(j != -1)
                //    city = city.substring(0,j);
                key = t.community + ":" + city + ":" + time.getTime();
                SCity sc = (SCity) hc.get(key);
                if(sc == null)
                {
                    ArrayList al = SCity.find(" AND community=" + DbAdapter.cite(t.community) + " AND city=" + DbAdapter.cite(city) + " AND time=" + DbAdapter.cite(time),0,1);
                    sc = al.size() < 1 ? new SCity(0) : (SCity) al.get(0);
                    hc.put(key,sc);
                    sc.community = t.community;
                    sc.city = city;
                    sc.time = time;
                }
                //
                sh.pv++;
                sr.pv++;
                sp.pv++;
                sc.pv++;
                if(t.isnew)
                {
                    sh.uv++;
                    sr.uv++;
                    sp.uv++;
                    sc.uv++;
                    db.executeQuery("SELECT ip FROM sip WHERE community=" + DbAdapter.cite(t.community) + " AND ip=" + DbAdapter.cite(t.ip));
                    if(!db.next())
                    {
                        db.executeUpdate("INSERT INTO sip(community,ip)VALUES(" + DbAdapter.cite(t.community) + "," + DbAdapter.cite(t.ip) + ")");
                        sh.ip++;
                        sr.ip++;
                        sp.ip++;
                        sc.ip++;
                    }
                }
            }
            it = hh.values().iterator();
            while(it.hasNext())
                ((SHour) it.next()).set(db);
            it = hr.values().iterator();
            while(it.hasNext())
                ((SReferer) it.next()).set(db);
            it = hp.values().iterator();
            while(it.hasNext())
                ((SPage) it.next()).set(db);
            it = hc.values().iterator();
            while(it.hasNext())
                ((SCity) it.next()).set(db);
            db.setAutoCommit(true);
        } finally
        {
            db.close();
        }
        //
        co.set("stat",last);
    }


    public static void parse(String path) throws Exception
    {
        SimpleDateFormat SDF = new SimpleDateFormat("dd/MMM/yyyy:HH:mm:ss",Locale.ENGLISH);

        //125.35.87.182 - - [2109.75.23.226 - - [25/Sep/2012:13:52:14 +0800] "GET /zb/201106/images/index_48.jpg HTTP/1.1" 404 -
        //183.60.214.43 - - [18/Sep/2012:08:00:07 +0800] "GET /html/Home/report/330600-1.htm HTTP/1.1" 200 24792
        //Pattern P = Pattern.compile("^([^ ]+) - - \\[([^]]+)\\] \"GET ([^ ]+) HTTP/1.\\d\" (\\d+) (.+)$",Pattern.MULTILINE);

        //125.35.87.182 - - [05/Jul/2013:17:00:03 +0800] "GET /res/doc/1103/11039915.gif HTTP/1.1" 200 294 "http://www.genderstudy.cn/html/folder/24-1.htm" "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; InfoPath.2; .NET4.0C; BRI/2; BOIE8;ENUS)"
        Pattern P = Pattern.compile("^([^ ]+) - - \\[([^]]+)\\] \"([^ ]+) ([^ ]+) HTTP/1.\\d\" (\\d+) ([-\\d]+) \"(.+)\" \"(.+)\"$",Pattern.MULTILINE);
		Pattern TYPE = Pattern.compile("\\.(\\w+)$");
        BufferedReader bf = new BufferedReader(new FileReader(path));
        DbAdapter db = new DbAdapter();
        try
        {
            db._con.setAutoCommit(false);
            String str;
            for(int i = 0;(str = bf.readLine()) != null;i++)
            {
                Matcher m = P.matcher(str);
                if(!m.find())
                    continue;
                Stat t = new Stat(0);
                t.ip = m.group(1);
                String tmp = m.group(2);
                tmp = tmp.substring(0,tmp.indexOf(' '));
                try
                {
                    t.time = SDF.parse(tmp);
                } catch(Exception ex)
                {
                    System.out.println(m.group(0));
                }
                t.method = m.group(3);
                t.url = m.group(4);
                t.code = Integer.parseInt(m.group(5));
                tmp = m.group(6);
                t.length = "-".equals(tmp) ? 0 : Integer.parseInt(tmp);
                t.referer = m.group(7);
                t.useragent = m.group(8);

                //if(t.url.endsWith(".jpg") || t.url.endsWith(".gif") || t.url.endsWith(".png") || t.url.endsWith(".js") || t.url.endsWith(".css"))
                //    continue;
                if(t.url.length() > 1000)
                    t.url = t.url.substring(0,1000);
                if(t.referer.length() > 1000)
                    t.referer = t.referer.substring(0,1000);

                String type = null;
				//type = t.url.substring(				t.url.lastIndexOf('.')+1);
				//if(type.length()>50)type=type.substring(0,50);
                m = TYPE.matcher(t.url);
                if(m.find())
				{
					//System.out.println(m.group(0));
                    type = m.group(0);
                }
                db.executeUpdate("INSERT INTO stat(ip,url,method,code,length,referer,useragent,type,time)VALUES(" + DbAdapter.cite(t.ip) + "," + DbAdapter.cite(t.url) + "," + DbAdapter.cite(t.method) + "," + t.code + "," + t.length + "," + DbAdapter.cite(t.referer) + "," + DbAdapter.cite(t.useragent) + "," + DbAdapter.cite(type) + "," + DbAdapter.cite(t.time) + ")");
                if(i % 10000 == 0)
                {
                    db._con.commit();
                    System.out.println(i);
                }
            }
        } finally
        {
			db._con.setAutoCommit(true);
            db.close();
            bf.close();
        }
        System.out.println("OK");
    }
}
