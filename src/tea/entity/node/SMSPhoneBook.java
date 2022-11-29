package tea.entity.node;

import tea.db.*;
import tea.entity.*;
import java.util.*;
import java.sql.SQLException;

public class SMSPhoneBook
{
    private static Cache _cache = new Cache(100);
    private int id;
    private String phonenumber;
    private String community;
    private String name;
    private String mobile;
    private String telephone;
    private int groupid;
    private String email;
    private boolean exists;
    private String memberx;

    public SMSPhoneBook(int id)
    {
        this.id = id;
        load();
    }

    public static SMSPhoneBook find(int id)
    {
        SMSPhoneBook Sms = (SMSPhoneBook) _cache.get(new Integer(id));
        if(Sms == null)
        {
            Sms = new SMSPhoneBook(id);
            _cache.put(new Integer(id),Sms);
        }
        return Sms;
    }

    public static java.util.Enumeration findByGroup(int group) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM SMSPhoneBook WHERE groupid = " + group);
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

    public static java.util.Enumeration find(String community,String member,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM SMSPhoneBook WHERE community=" + DbAdapter.cite(community) + " AND phonenumber=" + DbAdapter.cite(member) + sql,pos,size);
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

    public static int count(String community,String member,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return db.getInt("SELECT COUNT(id) FROM SMSPhoneBook  WHERE community=" + DbAdapter.cite(community) + " AND phonenumber=" + DbAdapter.cite(member) + sql);
        } finally
        {
            db.close();
        }
    }

    public static java.util.Enumeration findByMember(String community,String member) throws SQLException
    {
        return find(community,member,"",0,Integer.MAX_VALUE);
    }

    public static int countByGroup(int group) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return db.getInt("SELECT count(id) FROM SMSPhoneBook  WHERE groupid = " + group);
        } finally
        {
            db.close();
        }
    }

    private void load()
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,phonenumber,groupid,name,mobile,telephone,email,memberx FROM SMSPhoneBook WHERE id=" + id);
            if(db.next())
            {
                community = db.getString(1);
                phonenumber = db.getString(2);
                groupid = db.getInt(3);
                name = db.getVarchar(1,1,4);
                mobile = db.getString(5);
                telephone = db.getString(6);
                email = db.getString(7);
                memberx = db.getString(8);
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

    public static void create(String community,String phonenumber,int groupid,String name,String mobile,String telephone,String email,String memberx) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO SMSPhoneBook(community,phonenumber,groupid,name,mobile,telephone,email,memberx)VALUES(" + DbAdapter.cite(community) + ", " + DbAdapter.cite(phonenumber) + ", " + groupid + ", " + DbAdapter.cite(name) + ", " + DbAdapter.cite(mobile) + ", " + DbAdapter.cite(telephone) + ", " + DbAdapter.cite(email) + "," + DbAdapter.cite(memberx) + ")");
        } finally
        {
            db.close();
        }
    }

    public void set(int groupid,String name,String mobile,String telephone,String email,String memberx) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE SMSPhoneBook SET groupid=" + groupid + ",name=" + DbAdapter.cite(name) + ",mobile=" + DbAdapter.cite(mobile) + ",telephone =" + DbAdapter.cite(telephone) + ",email=" + DbAdapter.cite(email) + ",memberx=" + DbAdapter.cite(memberx) + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM SMSPhoneBook WHERE id=" + id);
        } finally
        {
            db.close();
        }
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

    public void setMobile(String mobile)
    {
        this.mobile = mobile;
    }

    public void setTelephone(String telephone)
    {
        this.telephone = telephone;
    }

    public void setGroupid(int groupid)
    {
        this.groupid = groupid;
    }

    public void setEmail(String email)
    {
        this.email = email;
    }

    public void setMemberx(String memberx)
    {
        this.memberx = memberx;
    }

    public String getPhonenumber()
    {
        return phonenumber;
    }

    public String getName()
    {
        return name;
    }

    public String getMobile()
    {
        return mobile;
    }

    public String getTelephone()
    {
        return telephone;
    }

    public int getGroupid()
    {
        return groupid;
    }

    public String getEmail()
    {
        return email;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getMemberx()
    {
        return memberx;
    }

    public String getCommunity()
    {
        return community;
    }
}
