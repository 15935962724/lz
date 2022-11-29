package tea.entity.lms;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class LmsPro
{
    protected static Cache c = new Cache(50);
    public int lmspro;
    public String code; //专业代码
    public String name; //专业名称
    public String content; //描述
    public float credit; //毕业学分
    public int member; //创建者
    public Date time; //时间
    public Date utime; //修改时间
    public String remark1;
    public String remark2;

    public LmsPro(int lmspro)
    {
        this.lmspro = lmspro;
    }

    public static LmsPro find(int lmspro) throws SQLException
    {
        LmsPro t = (LmsPro) c.get(lmspro);
        if(t == null)
        {
            ArrayList al = find(" AND lmspro=" + lmspro,0,1);
            t = al.size() < 1 ? new LmsPro(lmspro) : (LmsPro) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT lmspro,code,name,content,credit,member,time,utime,remark1,remark2 FROM lmspro WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                LmsPro t = new LmsPro(rs.getInt(i++));
                t.code = rs.getString(i++);
                t.name = rs.getString(i++);
                t.content = rs.getString(i++);
                t.credit = rs.getFloat(i++);
                t.member = rs.getInt(i++);
                t.time = db.getDate(i++);
                t.utime = db.getDate(i++);
                t.remark1 = rs.getString(i++);
                t.remark2 = rs.getString(i++);
                c.put(t.lmspro,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM lmspro WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(lmspro < 1)
            sql = "INSERT INTO lmspro(lmspro,code,name,content,credit,member,time,utime,remark1,remark2)VALUES(" + (lmspro = Seq.get()) + "," + DbAdapter.cite(code) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(content) + "," + credit + "," + member + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(utime) + "," + DbAdapter.cite(remark1) + "," + DbAdapter.cite(remark2) + ")";
        else
            sql = "UPDATE lmspro SET code=" + DbAdapter.cite(code) + ",name=" + DbAdapter.cite(name) + ",content=" + DbAdapter.cite(content) + ",credit=" + credit + ",member=" + member + ",time=" + DbAdapter.cite(time) + ",utime=" + DbAdapter.cite(utime) + ",remark1=" + DbAdapter.cite(remark1) + ",remark2=" + DbAdapter.cite(remark2) + " WHERE lmspro=" + lmspro;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql);
        } finally
        {
            db.close();
        }
        c.remove(lmspro);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM lmspro WHERE lmspro=" + lmspro);
        c.remove(lmspro);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE lmspro SET " + f + "=" + DbAdapter.cite(v) + " WHERE lmspro=" + lmspro);
        c.remove(lmspro);
    }
}
