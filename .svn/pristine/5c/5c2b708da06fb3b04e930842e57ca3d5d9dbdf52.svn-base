package tea.entity.pm;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import java.net.*;
import java.util.regex.*;

/**实时数据  每五钟采集一次金十的相关数据！*/
public class Newsline
{
    public static int COUNT;
    static
    {
        try
        {
            COUNT = Newsline.count("");
        } catch(Throwable ex)
        {}
    }

    protected static Cache c = new Cache(50);
    /**主键*/
    public int newsline;
    /**type 的分类！*/
    public static String[] NEWSLINE_TYPE =
            {"--","一般新闻","重要新闻","一般数据","重要数据"};
    /**分类
     * @see NEWSLINE_TYPE
     * */
    public int type;
    /**内容*/
    public String content;
    /**附件*/
    public int attch;
    /**网址*/
    public String url;
    /**时间*/
    public Date time;

    public Newsline(int newsline)
    {
        this.newsline = newsline;
    }

    /**根据 主键 获取其它信息*/
    public static Newsline find(int newsline) throws SQLException
    {
        Newsline t = (Newsline) c.get(newsline);
        if(t == null)
        {
            ArrayList al = find(" AND newsline=" + newsline,0,1);
            t = al.size() < 1 ? new Newsline(newsline) : (Newsline) al.get(0);
        }
        return t;
    }

    /**根据 SQL语句 获取相关信息
     * @param sql SQL语句，必须 AND 开头
     * @param pos 起始行数
     * @param size 返回的条数
     * */
    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT newsline,type,content,attch,url,time FROM newsline WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Newsline t = new Newsline(rs.getInt(i++));
                t.type = rs.getInt(i++);
                t.content = rs.getString(i++);
                t.attch = rs.getInt(i++);
                t.url = rs.getString(i++);
                t.time = db.getDate(i++);
                c.put(t.newsline,t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }

    /**根据SQL查询总条数，SQL必须以 AND 开头*/
    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM newsline WHERE 1=1" + sql);
    }

    /**把字段中的数写入到数据库中， 如果 newsline 小于1就插入反之修改！*/
    public void set() throws SQLException
    {
        String sql;
        if(newsline < 1)
            sql = "INSERT INTO newsline(newsline,type,content,attch,url,time)VALUES(" + (newsline = Seq.get()) + "," + type + "," + DbAdapter.cite(content) + "," + attch + "," + DbAdapter.cite(url) + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE newsline SET type=" + type + ",content=" + DbAdapter.cite(content) + ",attch=" + attch + ",url=" + DbAdapter.cite(url) + ",time=" + DbAdapter.cite(time) + " WHERE newsline=" + newsline;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql);
        } finally
        {
            db.close();
        }
        c.remove(newsline);
    }

    /**从数据库中删除本条记录！*/
    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM newsline WHERE newsline=" + newsline);
        c.remove(newsline);
    }

    /**修改某个字段的数据
     * @param field 字段名称
     * @param value 字段值
     */
    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE newsline SET " + f + "=" + DbAdapter.cite(v) + " WHERE newsline=" + newsline);
        c.remove(newsline);
    }

    //
    public static void main55(String args[]) throws Exception
    {
        byte[] by = Filex.read("F:/redcome/edn2/web_0.txt");
        for(int i = 0;i < by.length;i++)
        {
            int j = (int) by[i] & 0xFF;
            System.out.println(i + "：" + by[i] + "：" + j + ":" + Integer.toBinaryString(j));
        }
        String str = s8(by[0]);
        char fin = str.charAt(0);
        char rsv1 = str.charAt(1);
        char rsv2 = str.charAt(2);
        char rsv3 = str.charAt(3);
        String opcode = str.substring(4);
        System.out.println("fin: " + fin);
        System.out.println("rsv1: " + rsv1);
        System.out.println("rsv2: " + rsv2);
        System.out.println("rsv3: " + rsv3);
        System.out.println("opcode: " + opcode);

        str = s8(by[1]);
        char mask = str.charAt(0);
        String payload = str.substring(1);
        System.out.println("mask: " + mask);
        System.out.println("payload: " + payload);

        str = s8(by[2]);
        String masking = mask == '1' ? str.substring(0,4) : "";
    }

    static String s8(byte by)
    {
        String str = Integer.toBinaryString((int) by & 0xFF);
        for(int i = str.length();i < 8;i++)
            str = "0" + str;
        return str;
    }


    public static void main44(String args[]) throws Exception
    {
        byte[] by = (byte[]) Http.open("http://112.124.117.189:8080/socket.io/1/?t=1411627937867",null);
        String str = new String(by);
        System.out.println(str);
        java.net.HttpURLConnection conn = (HttpURLConnection)new java.net.URL("http://112.124.117.189:8080/socket.io/1/websocket/" + str.substring(0,str.indexOf(':'))).openConnection();
        conn.setRequestProperty("Upgrade","websocket");
        conn.setRequestProperty("Connection","Upgrade");
        conn.setRequestProperty("Sec-WebSocket-Key","52SojEvyJnTChbnNVh3q1Q==");
        conn.setRequestProperty("Sec-WebSocket-Version","13");
        conn.setRequestProperty("Sec-WebSocket-Extensions","permessage-deflate; client_max_window_bits, x-webkit-deflate-frame");
        conn.setRequestProperty("User-Agent","Mozilla/5.0 (Windows NT 5.2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.114 Safari/537.36");
        InputStream is = conn.getInputStream();
        for(int i = 0;true;i++)
        {
            int j = is.available();
            if(j > 0)
            {
                by = new byte[j];
                j = is.read(by);
                Filex.write("web_" + i + ".txt",by);
                System.out.println(new String(by,0,j));
            }
            Thread.sleep(1000);
        }
    }

    /**采集程序*/
    public static void ref() throws Exception
    {
        if(COUNT < 1)
            return;
        String date = MT.f(new Date()) + " ";
        Pattern ALT = Pattern.compile(" alt=\"([^\"]+)\""),HREF = Pattern.compile(" href=\"([^\"]+)\"");

        String str = (String) Http.open("http://www.jin10.com/",null);
        Filex.write("jin10.txt",str);
        //str = Filex.read("jin10.txt","utf-8");
        //str = str.substring(0,str.indexOf("<div id=\"right\">"));
        str = str.substring(0,str.indexOf("<div id=\"navs_0\" "));
        String[] arr = str.split("<div class=\"newsline\">");
        for(int i = 1;i < arr.length;i++)
        {
            String[] tds = arr[i].split("<td align=\"");
            Newsline n = new Newsline(0);
            Matcher m = ALT.matcher(tds[1]);
            if(m.find())
                n.type = Arrayx.indexOf(Newsline.NEWSLINE_TYPE,m.group(1));
            n.content = parse(tds[3]).replace("\"images/","\"/res/Home/newsline/");
            n.time = MT.SDF[1].parse(date + parse(tds[2]));
            if(n.content.contains(".jin10.com") || n.content.contains("金十") || Newsline.count(" AND time=" + DbAdapter.cite(n.time) + " AND content=" + DbAdapter.cite(n.content)) > 0)
                continue;
            if(tds.length == 5)
            {
                m = HREF.matcher(tds[4]);
                while(m.find())
                {
                    String url = m.group(1);
                    if(url.endsWith(".jpg") || url.startsWith("http://image.jin10.com/"))
                    {
                        byte[] by = (byte[]) Http.open(url,null);
                        Attch a = new Attch(Seq.get());
                        a.community = "Home";
                        a.name = url.substring(url.lastIndexOf('/') + 1);
                        a.type = a.name.substring(a.name.lastIndexOf('.') + 1).toLowerCase();
                        a.path3 = url; //原始图片路径
                        a.path = "/res/" + a.community + "/newsline/" + a.attch / 10000 + "/" + a.attch + "." + a.type;
                        a.length = by.length;
                        a.set();
                        Filex.write(Http.REAL_PATH + a.path,by);
                        n.attch = a.attch;
                    } else
                        n.url = url;
                }
            }
            n.set();
        }
    }

    static String parse(String htm)
    {
        return htm.substring(htm.indexOf('>') + 1,htm.lastIndexOf("</td>"));
    }

}
