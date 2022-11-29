package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class InfraredGroup
{
    protected static Cache c = new Cache(50);
    public int infraredgroup;
    public String name; //名称
    public int count; //数量
    public int picture; //图片
    public int sequence; //顺序
    public Date utime; //更新时间
    public Date time; //时间

    public InfraredGroup(int infraredgroup)
    {
        this.infraredgroup = infraredgroup;
    }

    public static InfraredGroup find(int infraredgroup) throws SQLException
    {
        InfraredGroup t = (InfraredGroup) c.get(infraredgroup);
        if(t == null)
        {
            ArrayList al = find(" AND infraredgroup=" + infraredgroup,0,1);
            t = al.size() < 1 ? new InfraredGroup(infraredgroup) : (InfraredGroup) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT infraredgroup,name,count,picture,sequence,utime,time FROM infraredgroup WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                InfraredGroup t = new InfraredGroup(rs.getInt(i++));
                t.name = rs.getString(i++);
                t.count = rs.getInt(i++);
                t.picture = rs.getInt(i++);
                t.sequence = rs.getInt(i++);
                t.utime = db.getDate(i++);
                t.time = db.getDate(i++);
                c.put(t.infraredgroup,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM infraredgroup WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(infraredgroup < 1)
            {
                infraredgroup = Seq.get();
                if(sequence == 0)
                    sequence = infraredgroup;
                db.executeUpdate("INSERT INTO infraredgroup(infraredgroup,name,count,picture,sequence,utime,time)VALUES(" + infraredgroup + "," + DbAdapter.cite(name) + "," + count + "," + picture + "," + sequence + "," + DbAdapter.cite(utime) + "," + DbAdapter.cite(time) + ")");
            } else
                db.executeUpdate("UPDATE infraredgroup SET name=" + DbAdapter.cite(name) + ",count=" + count + ",picture=" + picture + ",sequence=" + sequence + ",utime=" + DbAdapter.cite(utime) + ",time=" + DbAdapter.cite(time) + " WHERE infraredgroup=" + infraredgroup);
        } finally
        {
            db.close();
        }
        c.remove(infraredgroup);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM infraredgroup WHERE infraredgroup=" + infraredgroup);
        c.remove(infraredgroup);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE infraredgroup SET " + f + "=" + DbAdapter.cite(v) + " WHERE infraredgroup=" + infraredgroup);
        c.remove(infraredgroup);
    }

    //
    public static InfraredGroup find(String name) throws SQLException
    {
        ArrayList al = find(" AND name=" + DbAdapter.cite(name),0,1);
        return al.size() < 1 ? new InfraredGroup(0) : (InfraredGroup) al.get(0);
    }

    public static void ref() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT wzname,COUNT(wzname),MIN(picture),MAX(pstime) FROM infrared WHERE pstime IS NOT NULL AND wzname!='' GROUP BY wzname",0,Integer.MAX_VALUE);
            for(int i = 0;db.next();i++)
            {
                String name = db.getString(1);
                InfraredGroup ig = InfraredGroup.find(name);
                ig.name = name;
                ig.count = db.getInt(2);
                String pic = db.getString(3);
                ig.utime = db.getDate(4);
                if(ig.infraredgroup < 1 && pic != null)
                {
                    Attch a = new Attch(0);
                    a.path = "/res/attch" + pic.replaceFirst("TestData","170");
                    a.set();
                    ig.picture = a.attch;
                    ig.time = new Date();
                }
                ig.set();
            }
        } finally
        {
            db.close();
        }
    }

}
