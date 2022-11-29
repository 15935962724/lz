package tea.entity.bpicture;


import java.sql.*;

import tea.db.*;
import tea.entity.*;

public class Bpseudonym extends Entity
{
    private int id;
    private String member;
    private String community;
    private String name;//笔名
    private int ltype;//缴费类型
    private int applied;//被应用
    private boolean exists;

    public static final String[] LTYPE={"No default licence type","Royalty-Free","Licenced"};

    public Bpseudonym(int id)throws SQLException
    {
        this.id=id;
        load();
    }

    public static Bpseudonym find(int id)throws SQLException
    {
        return new Bpseudonym(id);
    }

    public void load()throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id,member,community,name,ltype,applied from Bpseudonym where id="+id);
            if(db.next())
            {
                int j=1;
                id=db.getInt(j++);
                member=db.getString(j++);
                community=db.getString(j++);
                name=db.getString(j++);
                ltype = db.getInt(j++);
                applied = db.getInt(j++);
                exists = true;
            }
            else
            {
                exists=false;
            }
        }
        finally
        {
            db.close();
        }
    }

    public static void set (int id ,String member ,String community,String name,int ltype,int applied)throws SQLException
    {
        DbAdapter db = new DbAdapter() ;
        try
        {
            db.executeQuery("select id from Bpseudonym where id="+id);
            if(db.next())
            {
                db.executeUpdate("Update Bpseudonym  set  member="+db.cite(member)+",community="+db.cite(community)+",name="+db.cite(name)+",ltype="+ltype+",applied="+applied+" where id="+id);
            }
            else
            {
                db.executeUpdate("insert into Bpseudonym( member , community,name ,ltype,applied )values("+db.cite(member)+","+db.cite(community)+","+db.cite(name)+","+ltype+","+applied+")");
            }
        }
        finally
        {
            db.close();
        }
    }

    public static void delete(int id)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete Bpseudonym where id="+id);
        }
        finally
        {
            db.close();
        }
    }

    public static java.util.Enumeration findByCommunity(String community,String sql,int pos,int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM Bpseudonym WHERE community=" + DbAdapter.cite(community) + sql);
            for(int l = 0;l < pos + pageSize && db.next();l++)
            {
                if(l >= pos)
                {
                    vector.addElement(String.valueOf(db.getString(1)));
                }
            }

        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static String getsql(String first,String sql)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        String str ="";
        try
        {
            db.executeQuery("Select "+first+" from Bpseudonym where 1=1 "+sql);
            if(db.next())
            {
                str=db.getString(1);
            }
        }
        finally
        {
            db.close();
        }
        return str;
    }

    public static void setltype(int id,int ltype,String member)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update Bpseudonym set applied=0 where member = "+db.cite(member));
            db.executeUpdate("Update Bpseudonym set ltype="+ltype+",applied=1 where id="+id);
        }
        finally
        {
            db.close();
        }



    }



    public String getCommunity()
    {
        return community;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getId()
    {
        return id;
    }

    public String getMember()
    {
        return member;
    }

    public String getName()
    {
        return name;
    }

    public int getLtype()
    {
        return ltype;
    }

    public int getApplied()
    {
        return applied;
    }


}
