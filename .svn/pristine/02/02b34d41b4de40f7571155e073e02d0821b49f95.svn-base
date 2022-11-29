package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.cluster.*;
import java.net.URL;

public class Video extends Entity
{
    public static String HOST;
    static
    {
        try
        {
            Class c = Class.forName("tea.entity.Http");
            Properties p = new Properties();
            URL u = c.getResource("/db.properties");
            if(u != null)
            {
                InputStream is = u.openStream();
                p.load(is);
                is.close();
            }
            HOST = p.getProperty("video.host","");
        } catch(Throwable ex)
        {
            ex.printStackTrace();
        }
    }

    //protected static Cache _cache = new Cache(50);
    public int node; //节点
    public int language; //语言
    public int video; //视频
    public boolean exists;
    public Video(int node,int language)
    {
        this.node = node;
        this.language = language;
    }

    public static Video find(int node,int language) throws SQLException
    {
        Video t = (Video) _cache.get(node + ":" + language);
        if(t == null)
        {
            ArrayList al = find(" AND node=" + node + " AND language=" + language,0,1);
            t = al.size() < 1 ? new Video(node,language) : (Video) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT node,language,video FROM Video WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Video t = new Video(rs.getInt(i++),rs.getInt(i++));
                t.video = rs.getInt(i++);
                t.exists = true;
                _cache.put(t.node + ":" + t.language,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM Video WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(exists)
            sql = "UPDATE Video SET video=" + video + " WHERE node=" + node + " AND language=" + language;
        else
            sql = "INSERT INTO Video(node,language,video)VALUES(" + node + "," + language + "," + video + ")";
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(node,sql);
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(node,"DELETE FROM Video WHERE node=" + node + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(node,"UPDATE Video SET " + f + "=" + DbAdapter.cite(v) + " WHERE node=" + node + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }

    //
    public String getDetail(Node n,Http h,int listing,String target) throws SQLException
    {
        Attch a = Attch.find(video);
        StringBuilder htm = new StringBuilder();
        String subject = n.getSubject(h.language);
        ListingDetail detail = ListingDetail.find(listing,113,h.language);
        Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
                continue;

            String bi = detail.getBeforeItem(name),ai = detail.getAfterItem(name);
            int an = detail.getAnchor(name);
            if(name.equals("subject")) //标题
                value = subject;
            else if(name.equals("content")) //内容
                value = n.getText(h.language);
            else if(name.equals("picture")) //图片
            {
                int picture = n.getPicture2(h.language);
                value = "<img src='" + Video.HOST + (picture < 1 ? a.path4 : Attch.find(picture).path) + "' />";
            } else if(name.equals("picture3")) //小图
            {
                int picture = n.getPicture2(h.language);
                value = "<img src='" + Video.HOST + (picture < 1 ? a.path4 : Attch.find(picture).path3) + "' />";
            } else if(name.equals("starttime")) //日期
            {
                value = MT.f(n.getStartTime());
            } else if(name.equals("duration")) //时长
            {
                value = MT.ss(a.numbers);
            } else if(name.equals("player")) //视频
            {
                int picture = n.getPicture2(h.language);
                int width = detail.getQuantity(name); //640x480
                //if(an == 2) //6.3不支持
                //    an = 0;
                //value = "<script>mt.embed('/tea/image/flv/ckplayer.swf'," + width + "," + (width * 3 / 4) + ",'f=" + Http.enc(Video.HOST + (a.path2 == null ? a.path : a.path2)) + "&i=" + Http.enc(Video.HOST + picture) + "&p=" + an + "&e=0&a=" + a.attch + "&x=%2FPlayers.do%3Fact%3Dconf%26width%3D" + width + (width < 400 ? "" : "%26quality%3D" + (a.path2 != null)) + "');</script>";
                value = "<script>mt.embed('/tea/image/flv/ckplayer.swf'," + width + "," + (width * 3 / 4) + ",'f=%2FPlayers.do%3Fact%3Dquality%26quality%3D%5B%24pat%5D%26attch%3D" + a.attch + "&i=" + Http.enc(Video.HOST + (picture < 1 ? a.path4 : Attch.find(picture).path)) + "&p=" + an + "&o=" + a.numbers + "&e=0&a=2&s=1&x=%2FPlayers.do%3Fact%3Dconf%26width%3D" + width + (width < 400 ? "" : "%26quality%3D" + (a.path2 != null)) + "');</script>";
                an = 0;
            } else if(name.equals("correlation113")) //相关视频
            {
                StringBuilder sb = new StringBuilder();
                ArrayList al = Node.find1(" AND n.father=" + n.getFather() + " ORDER BY n.starttime DESC",h.language,0,detail.getQuantity(name));
                for(int i = 0;i < al.size();i++)
                {
                    Node ln = (Node) al.get(i);
                    Video lv = Video.find(ln._nNode,h.language);
                    Attch la = Attch.find(lv.video);
                    String picture = ln.getPicture(h.language);
                    if(picture == null)
                        picture = la.path4;
                    sb.append("<li class='" + (n._nNode == ln._nNode ? "current" : "") + "'><a href='" + ln.getAnchor(h.language,h.status) + "'>");
                    sb.append("<span class='picture'><img src='" + Video.HOST + picture + "'></span>");
                    sb.append("<span class='duration'>" + MT.ss(la.numbers) + "</span>");
                    sb.append("<span class='title'>" + ln.getSubject(h.language) + "</span>");
                    sb.append("<span class='content'>" + ln.getText(h.language) + "</span>");
                    sb.append("</a></li>");
                }
                value = sb.toString();
            } else
            {
                try
                {
                    Object tmp = Class.forName("tea.entity.node.Video").getField(name).get(this);
                    if(tmp != null)
                    {
                        if(tmp instanceof Date)
                            value = MT.f((Date) tmp);
                        else
                            value = tmp.toString();
                    }
                } catch(Throwable ex)
                {
                    value = ex.toString();
                }
            }

            if(value == null)
                value = "";
            if(istype == 2 && value.length() < 1)
                continue;

            //限制字数
            value = detail.getOptionsToHtml(name,n,value);

            //显示连接的地方
            if(an != 0)
            {
                value = "<a href='" + n.getAnchor(h.language,h.status) + "' target='" + target + "' title=\"" + subject.replace('"','\'') + "\">" + value + "</a>";
            }
            htm.append(bi).append("<span id='VideoID" + name + "'>" + value + "</span>").append(ai);
        }
        return htm.toString();
    }

    //
    public static void conv() throws SQLException
    {
        ArrayList al = Attch.find(" AND path2 IS NULL AND attch IN(SELECT v.video FROM Node n INNER JOIN Video v ON n.node=v.node WHERE n.finished=1) ORDER BY attch",0,100);
        for(int i = 0;i < al.size();i++)
        {
            Attch a = (Attch) al.get(i);
            Filex.logs("Video.txt","attch:" + a.attch + "　　" + a.path);
            try
            {
                net.mietian.convert.Video v = new net.mietian.convert.Video(Http.REAL_PATH + a.path);
                a.width = v.width;
                a.height = v.height;
                a.numbers = v.duration;
                String prefix = "/res/" + a.community + "/video/" + a.attch / 10000 + "/" + a.attch % 10000;
                //视频
                v.width = 0; //960
                v.height = 720;
                String path = prefix + "_1.mp4";
                v.start(Http.REAL_PATH + path);
                a.content = v.error;
                //标清
                v = new net.mietian.convert.Video(Http.REAL_PATH + path);
                v.width = 0; //640
                v.height = 480;
                a.path2 = prefix + "_2.mp4";
                v.start(Http.REAL_PATH + a.path2);
                //
                v = new net.mietian.convert.Video(Http.REAL_PATH + a.path2);
                v.width = 0; //320
                v.height = 240;
                a.path3 = prefix + "_3.mp4";
                v.start(Http.REAL_PATH + a.path3);
                //缩略图
                a.path4 = prefix + "_4.jpg";
                v.pic(5,Http.REAL_PATH + a.path4);
                a.path = path;
                a.set();
            } catch(Throwable ex)
            {
                Filex.logs("Video.txt",ex);
            }
        }
    }
}
