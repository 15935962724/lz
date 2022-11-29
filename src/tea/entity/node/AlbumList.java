package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.resource.*;

//http://news.qq.com/a/20110305/000382.htm
public class AlbumList
{
    protected static Cache c = new Cache(50);
    public int album;
    public int node; //节点
    public int sequence; //顺序
    public String subject; //标题
    public String content; //说明
    public Date time; //时间

    public AlbumList(int album)
    {
        this.album = album;
    }

    public static AlbumList find(int album) throws SQLException
    {
        AlbumList t = (AlbumList) c.get(album);
        if(t == null)
        {
            ArrayList al = find(" AND album=" + album,0,1);
            t = al.size() < 1 ? new AlbumList(album) : (AlbumList) al.get(0);
        }
        return t;
    }

    public static ArrayList findByNode(int node) throws SQLException
    {
        return find(" AND node=" + node + " ORDER BY sequence",0,200);
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT album,node,sequence,subject,content,time FROM AlbumList WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                AlbumList t = new AlbumList(rs.getInt(i++));
                t.node = rs.getInt(i++);
                t.sequence = rs.getInt(i++);
                t.subject = rs.getString(i++);
                t.content = rs.getString(i++);
                t.time = db.getDate(i++);
                c.put(t.album,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM AlbumList WHERE 1=1" + sql);
    }

    public int set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(album < 1)
            {
                db.executeUpdate(node,"INSERT INTO AlbumList(node,sequence,subject,content,time)VALUES(" + node + "," + sequence + "," + DbAdapter.cite(subject) + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(time) + ")");
                album = db.getInt("SELECT MAX(album) FROM AlbumList WHERE node=" + node);
            } else
                db.executeUpdate(node,"UPDATE AlbumList SET sequence=" + sequence + ",subject=" + DbAdapter.cite(subject) + ",content=" + DbAdapter.cite(content) + ",time=" + DbAdapter.cite(time) + " WHERE album=" + album);
        } finally
        {
            db.close();
        }
        c.remove(album);
        return album;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(album,"DELETE FROM AlbumList WHERE album=" + album);
        } finally
        {
            db.close();
        }
        c.remove(album);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(album,"UPDATE AlbumList SET " + f + "=" + DbAdapter.cite(v) + " WHERE album=" + album);
        } finally
        {
            db.close();
        }
        c.remove(album);
    }

    public static String js(int node) throws SQLException,IOException
    {
        String community = Node.find(node).getCommunity();
        StringBuffer sb = new StringBuffer();
        ArrayList al = findByNode(node);

        sb.append("{'Name':'root','Children':[{'Name':'groupimginfo', 'Content':'', 'Attributes':[], 'Children':[{'Name':'pageno', 'Content':'', 'Attributes':[], 'Children':[{'Name':'', 'Content':'" + al.size() + "', 'Attributes':[], 'Children':[]}]},{'Name':'groupimg', 'Content':'', 'Attributes':[], 'Children':[");
        for(int i = 0;i < al.size();i++)
        {
            AlbumList a = (AlbumList) al.get(i);
            if(i > 0)
                sb.append(",");
            sb.append("{'Name':'img', 'Content':'', 'Attributes':[], 'Children':[{'Name':'imgname', 'Content':'', 'Attributes':[], 'Children':[{'Name':'', 'Content':'" + MT.f(a.content).replaceAll("\r\n","<br/>") + "', 'Attributes':[], 'Children':[]}]},{'Name':'smallimgurl', 'Content':'', 'Attributes':[], 'Children':[{'Name':'', 'Content':'/res/" + community + "/album/T_" + a.album + ".jpg', 'Attributes':[], 'Children':[]}]}");
            sb.append(",{'Name':'bigimgurl', 'Content':'', 'Attributes':[], 'Children':[{'Name':'', 'Content':'/res/" + community + "/album/M_" + a.album + ".jpg', 'Attributes':[], 'Children':[]}]},{'Name':'cnt_article', 'Content':'', 'Attributes':[], 'Children':[{'Name':'', 'Content':'', 'Attributes':[], 'Children':[]}]},{'Name':'simg_article_url', 'Content':'', 'Attributes':[], 'Children':[{'Name':'text', 'Content':'/html/" + community + "/album/" + node + ".htm#" + i + "', 'Attributes':[], 'Children':[]}]}]}");
        }
        sb.append("]},{'Name':'last_url', 'Content':'', 'Attributes':[], 'Children':[{'Name':'', 'Content':'/a/20110308/001934.htm', 'Attributes':[], 'Children':[]}]},{'Name':'last_title', 'Content':'', 'Attributes':[], 'Children':[{'Name':'', 'Content':'高清：韩红等在政协小组上讨论限制低空飞行', 'Attributes':[], 'Children':[]}]},{'Name':'last_imgUrl', 'Content':'', 'Attributes':[], 'Children':[{'Name':'', 'Content':'http://img1.gtimg.com/news/pics/hv1/123/86/734/47750403.jpg', 'Attributes':[], 'Children':[]}]},{'Name':'continuous_play', 'Content':'', 'Attributes':[], 'Children':[{'Name':'', 'Content':'0', 'Attributes':[], 'Children':[]}]},{'Name':'simg_article_id', 'Content':'', 'Attributes':[], 'Children':[{'Name':'text', 'Content':'20110309000391', 'Attributes':[], 'Children':[]}]},{'Name':'top_content', 'Content':'', 'Attributes':[{'Name':'is_firstpage', 'Children':[{'Name':'text', 'Content':'0', 'Attributes':[], 'Children':[]}]}], 'Children':[]},{'Name':'bottom_content', 'Content':'', 'Attributes':[{'Name':'is_firstpage', 'Children':[{'Name':'text', 'Content':'0', 'Attributes':[], 'Children':[]}]}], 'Children':[]}]}]}"
                );
        Filex.write(Common.REAL_PATH + "/res/" + community + "/album/N_" + node + ".js",sb.toString());
        return sb.toString();
    }


}
