package tea.entity.site;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class Player
{
    static
    {
        try
        {
            DbAdapter db = new DbAdapter(),d2 = new DbAdapter();
            try
            {
                //2014-08-07
                db.executeQuery("SELECT community FROM Community WHERE id IS NULL");
                while(db.next())
                {
                    d2.executeUpdate("UPDATE Community SET id=" + Seq.get() + " WHERE community=" + DbAdapter.cite(db.getString(1)));
                }
                Community._cache.clear();
            } finally
            {
                db.close();
            }
        } catch(Throwable ex)
        {
            ex.printStackTrace();
        }
    }

    public static float VER = 6.4F;
    public static Cache _cache = new Cache(50);
    public int player; //社区
    public int logo; //右上角Logo
    public String pm_logo = "2,0,-100,20";
    public int buffer; //缓冲时显示的LOGO
    //
    public static String[] ALIGN_TYPE =
            {"左对齐","居中","右对齐"};
    public static String[] PLAY_TYPE =
            {"暂停","播放","不加载"};
    public static String[] VALIGN_TYPE =
            {"顶端","居中","底部"};
    public static String[] FRONT_TYPE =
            {"不开启","开启","开启+跳过按钮"};
    public int fronttype; //前置广告
    public static String[] FRONT_ORDER =
            {"顺序播放","随机播放"};
    public int frontorder; //播放顺序
    public String front0 = "|"; //前置广告
    public String front1 = "|"; //前置广告链接
    public String front2 = "|"; //前置广告时间
    //
    public static String[] PAUSE_TYPE =
            {"不开启","开启","开启+关闭按钮"};
    public int pausetype; //暂停广告
    public String pause0 = "|"; //暂停广告
    public String pause1 = "|"; //暂停广告链接
    //
    public static String[] MARQUEE_TYPE =
            {"不开启","开启","开启+关闭按钮"};
    public int marqueetype; //滚动广告
    public String marquee = "<a href='http://www.so.com'>是谁迈向时代的进程！<font color='#ff0000' size='12'>5.9秒</font>不再是时间的概念，而是力量的象征！<font color='#ff0000' size='12'>1.6升</font>不再是点滴的节省，而是纵情的驰骋！</a>"; //滚动广告
    //分享
    public String share_uuid="d4dd2535-c28b-4ed6-862c-7e8651d6c37c";
    public Player(int player)
    {
        this.player = player;
    }

    public static Player find(int player) throws SQLException
    {
        Player t = (Player) _cache.get(player);
        if(t == null)
        {
            ArrayList al = find(" AND player=" + player,0,1);
            t = al.size() < 1 ? new Player(player) : (Player) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT player,logo,pm_logo,buffer,fronttype,frontorder,front0,front1,front2,pausetype,pause0,pause1,marqueetype,marquee,share_uuid FROM player WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Player t = new Player(rs.getInt(i++));
                t.logo = rs.getInt(i++);
                t.pm_logo = rs.getString(i++);
                t.buffer = rs.getInt(i++);
                t.fronttype = rs.getInt(i++);
                t.frontorder = rs.getInt(i++);
                t.front0 = rs.getString(i++);
                t.front1 = rs.getString(i++);
                t.front2 = rs.getString(i++);
                t.pausetype = rs.getInt(i++);
                t.pause0 = rs.getString(i++);
                t.pause1 = rs.getString(i++);
                t.marqueetype = rs.getInt(i++);
                t.marquee = rs.getString(i++);
                t.share_uuid = rs.getString(i++);
                _cache.put(t.player,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM player WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate(player,"UPDATE player SET logo=" + logo + ",pm_logo=" + DbAdapter.cite(pm_logo) + ",buffer=" + buffer + ",fronttype=" + fronttype + ",frontorder=" + frontorder + ",front0=" + DbAdapter.cite(front0) + ",front1=" + DbAdapter.cite(front1) + ",front2=" + DbAdapter.cite(front2) + ",pausetype=" + pausetype + ",pause0=" + DbAdapter.cite(pause0) + ",pause1=" + DbAdapter.cite(pause1) + ",marqueetype=" + marqueetype + ",marquee=" + DbAdapter.cite(marquee) + ",share_uuid=" + DbAdapter.cite(share_uuid) + " WHERE player=" + player);
            if(j < 1)
                db.executeUpdate(player,"INSERT INTO player(player,logo,pm_logo,buffer,fronttype,frontorder,front0,front1,front2,pausetype,pause0,pause1,marqueetype,marquee,share_uuid)VALUES(" + player + "," + logo + "," + DbAdapter.cite(pm_logo) + "," + buffer + "," + fronttype + "," + frontorder + "," + DbAdapter.cite(front0) + "," + DbAdapter.cite(front1) + "," + DbAdapter.cite(front2) + "," + pausetype + "," + DbAdapter.cite(pause0) + "," + DbAdapter.cite(pause1) + "," + marqueetype + "," + DbAdapter.cite(marquee) + "," + DbAdapter.cite(share_uuid) + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(player);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(player,"DELETE FROM player WHERE player=" + player);
        } finally
        {
            db.close();
        }
        _cache.remove(player);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(player,"UPDATE player SET " + f + "=" + DbAdapter.cite(v) + " WHERE player=" + player);
        } finally
        {
            db.close();
        }
        _cache.remove(player);
    }

    //
    public void cache() throws SQLException,IOException
    {
        Community c = Community.find(player);
        StringBuilder xml = new StringBuilder();
        xml.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
        xml.append("<ckplayer>");
        xml.append("  <share_html>{embed src='http://" + c.webName + "/tea/image/flv/ckplayer.swf' flashvars='[$share]' quality='high' width='480' height='400' align='middle' allowScriptAccess='always' allowFullscreen='true' type='application/x-shockwave-flash'}{/embed}</share_html>");
        xml.append("  <share_flash>http://" + c.webName + "/tea/image/flv/ckplayer.swf?[$share]</share_flash>");
        xml.append("  <share_flashvars>f,x,s,a,my_url</share_flashvars>");
        xml.append("  <share_path>/tea/image/share/</share_path>");
        xml.append("  <share_replace></share_replace>");
        xml.append("  <share_permit>0</share_permit>"); //是否有视听许可证,默认0没有，1是有
        xml.append("  <share_load>1</share_load>"); //开启了手动读取模式
        xml.append("  <share_charset>0</share_charset>");
        //writerpost@163.com/writer_post_123/writer_post_12
        //7cdbbaaf-7f00-4597-9584-0eb1028f2cb3
        xml.append("  <share_uuid>" + share_uuid + "</share_uuid>");
        if(VER == 6.4F)
        {
            xml.append("  <share_button>");
            xml.append("    <share><id>qqmb</id><img>qq.png</img><coordinate>20,50</coordinate></share>");
            xml.append("    <share><id>sinaminiblog</id><img>sina.png</img><coordinate>101,50</coordinate></share>");
            xml.append("    <share><id>qzone</id><img>qzone.png</img><coordinate>182,50</coordinate></share>");
            xml.append("    <share><id>renren</id><img>rr.png</img><coordinate>263,50</coordinate></share>");
            xml.append("    <share><id>kaixin001</id><img>kaixin001.png</img><coordinate>20,85</coordinate></share>");
            xml.append("    <share><id>tianya</id><img>tianya.png</img><coordinate>101,85</coordinate></share>");
            xml.append("    <share><id>feixin</id><img>feixin.png</img><coordinate>182,85</coordinate></share>");
            xml.append("    <share><id>msn</id><img>msn.png</img><coordinate>263,85</coordinate></share>");
            xml.append("  </share_button>");
        } else
        {
            xml.append("  <share_button>");
            xml.append("    <share><id>qqmb</id><img>qq.png</img><coordinate>13,30</coordinate></share>");
            xml.append("    <share><id>sinaminiblog</id><img>sina.png</img><coordinate>101,30</coordinate></share>");
            xml.append("    <share><id>qzone</id><img>qzone.png</img><coordinate>189,30</coordinate></share>");
            xml.append("    <share><id>renren</id><img>rr.png</img><coordinate>277,30</coordinate></share>");
            xml.append("    <share><id>kaixin001</id><img>kaixin001.png</img><coordinate>13,65</coordinate></share>");
            xml.append("    <share><id>tianya</id><img>tianya.png</img><coordinate>101,65</coordinate></share>");
            xml.append("    <share><id>feixin</id><img>feixin.png</img><coordinate>189,65</coordinate></share>");
            xml.append("    <share><id>msn</id><img>msn.png</img><coordinate>277,65</coordinate></share>");
            xml.append("  </share_button>");
        }
        xml.append("</ckplayer>");
        Filex.write(Http.REAL_PATH + "/res/" + c.community + "/player/share.xml",xml.toString());
    }

    public static void ref() throws SQLException,IOException
    {
        ArrayList al = Player.find("",0,Integer.MAX_VALUE);
        for(int i = 0;i < al.size();i++)
        {
            Player t = (Player) al.get(i);
            t.cache();
        }
    }
}
