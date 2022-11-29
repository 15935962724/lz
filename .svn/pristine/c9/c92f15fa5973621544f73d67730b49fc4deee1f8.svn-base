package tea.entity.weibo;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class MMessenger
{
    protected static Cache c = new Cache(50);
    public long mmessenger; //微信消息
    public static String[] MMESSENGER_TYPE =
            {"--","text","image","location","link","news","voice","video"};
    public int type; //类型
    public String fusername; //发送方
    public String tusername; //接收方
    public String title; //标题
    public String content; //内容
    public String url; //网址
    public double x; //地理位置纬度
    public double y; //地理位置经度
    public int scale; //地图缩放大小
    public Date time; //创建时间

    public MMessenger(long mmessenger)
    {
        this.mmessenger = mmessenger;
    }

    public static MMessenger find(long mmessenger) throws SQLException
    {
        MMessenger t = (MMessenger) c.get(mmessenger);
        if(t == null)
        {
            ArrayList al = find(" AND mmessenger=" + mmessenger,0,1);
            t = al.size() < 1 ? new MMessenger(mmessenger) : (MMessenger) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT mmessenger,type,fusername,tusername,title,content,url,x,y,scale,time FROM mmessenger WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                MMessenger t = new MMessenger(rs.getLong(i++));
                t.type = rs.getInt(i++);
                t.fusername = rs.getString(i++);
                t.tusername = rs.getString(i++);
                t.title = rs.getString(i++);
                t.content = rs.getString(i++);
                t.url = rs.getString(i++);
                t.x = rs.getDouble(i++);
                t.y = rs.getDouble(i++);
                t.scale = rs.getInt(i++);
                t.time = db.getDate(i++);
                c.put(t.mmessenger,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM mmessenger WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("INSERT INTO mmessenger(mmessenger,type,fusername,tusername,title,content,url,x,y,scale,time)VALUES(" + mmessenger + "," + type + "," + DbAdapter.cite(fusername) + "," + DbAdapter.cite(tusername) + "," + DbAdapter.cite(title) + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(url) + "," + x + "," + y + "," + scale + "," + DbAdapter.cite(time) + ")");
            if(j < 1)
                db.executeUpdate("UPDATE mmessenger SET type=" + type + ",fusername=" + DbAdapter.cite(fusername) + ",tusername=" + DbAdapter.cite(tusername) + ",title=" + DbAdapter.cite(title) + ",content=" + DbAdapter.cite(content) + ",url=" + DbAdapter.cite(url) + ",x=" + x + ",y=" + y + ",scale=" + scale + ",time=" + DbAdapter.cite(time) + " WHERE mmessenger=" + mmessenger);
        } finally
        {
            db.close();
        }
        c.remove(mmessenger);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM mmessenger WHERE mmessenger=" + mmessenger);
        c.remove(mmessenger);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE mmessenger SET " + f + "=" + DbAdapter.cite(v) + " WHERE mmessenger=" + mmessenger);
        c.remove(mmessenger);
    }
}
