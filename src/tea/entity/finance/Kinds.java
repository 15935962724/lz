package tea.entity.finance;

import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;

public class Kinds extends Entity
{
    private int id;
    private String member;
    private String kname;
    private int sandz; //1:支出 2：收入
    private int cycle;
    private String ps;


    public Kinds(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static Kinds find(int id) throws SQLException
    {
        return new Kinds(id);
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id,member,kname,sandz,cycle,ps from kinds where id=" + id);
            if(db.next())
            {
                int j = 1;
                id = db.getInt(j++);
                member = db.getString(j++);
                kname = db.getString(j++);
                sandz = db.getInt(j++);
                cycle = db.getInt(j++);
                ps = db.getString(j++);
            }
        } finally
        {
            db.close();
        }
    }

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT  id FROM kinds WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static void create(String member,String kname,int sandz,int cycle,String ps) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into kinds(member,kname,sandz,cycle,ps) values(" + db.cite(member) + ", " + db.cite(kname) + ", " + sandz + ", " + cycle + ", " + db.cite(ps) + ")");
        } finally
        {
            db.close();
        }
    }

    public static void update(int id,String kname,int sandz,int cycle,String ps) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update kinds set kname=" + db.cite(kname) + ", sandz=" + sandz + ", cycle=" + cycle + ",ps=" + db.cite(ps) + " where id=" + id);
        } finally
        {
            db.close();
        }
    }


    public static void del(int id) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from kinds where id=" + id);
        } finally
        {
            db.close();
        }
    }


    public int getId()
    {
        return id;
    }

    public String getKname()
    {
        return kname;
    }

    public String getMember()
    {
        return member;
    }

    public int getSandz()
    {
        return sandz;
    }

    public String getPs()
    {
        return ps;
    }

    public int getCycle()
    {
        return cycle;
    }


}
