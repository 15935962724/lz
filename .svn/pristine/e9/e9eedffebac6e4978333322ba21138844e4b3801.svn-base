package tea.entity.node;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class SMSGroup
{
    private int id;
    private String phonenumber;
    private String name;
    private String discript;
    private static Cache _cache = new Cache(100);
    private boolean exists;
    private String community;

    public SMSGroup(int id)
    {
        this.id = id;
        load();
    }

    public static SMSGroup find(int id)
    {
        SMSGroup obj = (SMSGroup) _cache.get(new Integer(id));
        if(obj == null)
        {
            obj = new SMSGroup(id);
            _cache.put(new Integer(id),obj);
        }
        return obj;
    }

    private void load()
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT phonenumber,community,name,discript FROM SMSgroup WHERE id=" + this.id);
            if(db.next())
            {
                phonenumber = db.getString(1);
                community = db.getString(2);
                name = db.getVarchar(1,1,3);
                discript = db.getVarchar(1,1,4);
                exists = true;
            } else
            {
                exists = false;
            }
        } catch(SQLException ex)
        {
            ex.printStackTrace();
        } finally
        {
            db.close();
        }
    }

    public static void create(String community,String phonenumber,String name,String discript) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO SMSgroup(community,phonenumber,name,discript) VALUES (" + DbAdapter.cite(community) + "," + DbAdapter.cite(phonenumber) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(discript) + ") ");
        } finally
        {
            db.close();
        }
    }

    public void set(String name,String discript) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE SMSgroup SET name=" + DbAdapter.cite(name) + ",discript=" + DbAdapter.cite(discript) + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
        // _cache.remove(new Integer(id));
        this.name = name;
        this.discript = discript;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM SMSgroup WHERE id= " + id);
        } finally
        {
            db.close();
        }
        this.exists = false;
        _cache.remove(new Integer(id));
    }

    public int getId()
    {
        return id;
    }

    public void setPhonenumber(String phonenumber)
    {
        this.phonenumber = phonenumber;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public void setDiscript(String discript)
    {
        this.discript = discript;
    }

    public String getPhonenumber()
    {
        return phonenumber;
    }

    public String getName()
    {
        return name;
    }

    public static int countByMember(String community,String member) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(id) FROM SMSgroup WHERE community=" + DbAdapter.cite(community) + " AND phonenumber=" + DbAdapter.cite(member));
            if(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }

    public static java.util.Enumeration findByMember(String community,String member) throws SQLException
    {
        java.util.Vector v = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM SMSgroup WHERE community=" + DbAdapter.cite(community) + " AND phonenumber=" + DbAdapter.cite(member));
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        if(v.size() < 1) // 生成默认的组
        {
            create(community,member,"我的朋友","我的亲朋好友组...");
            create(community,member,"我的同事","");
            create(community,member,"其它联系人","");
            return findByMember(community,member);
        }
        return v.elements();
    }

    public String getDiscript()
    {
        return discript;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getCommunity()
    {
        return community;
    }
}
