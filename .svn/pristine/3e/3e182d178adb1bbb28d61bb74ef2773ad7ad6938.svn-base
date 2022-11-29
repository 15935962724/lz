package tea.entity.admin.erp;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Warehouse extends Entity
{
    private int warehouse; //主键ID
    private String warname; //仓库名称
    private String contact; //联系人
    private String telephone; //电话
    private String address; //仓库地址
    private Date times; //添加时间
    private String member; //添加用户
    private String community; //添加的社区
    private boolean exists;

    public Warehouse(int warehouse) throws SQLException
    {
        this.warehouse = warehouse;
        load();
    }

    public static Warehouse find(int warehouse) throws SQLException
    {
        return new Warehouse(warehouse);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT warname,contact,telephone,address,times,member,community FROM Warehouse WHERE warehouse =" + warehouse);
            if(db.next())
            {
                warname = db.getString(1);
                contact = db.getString(2);
                telephone = db.getString(3);
                address = db.getString(4);
                times = db.getDate(5);
                member = db.getString(6);
                community = db.getString(7);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(String warname,String contact,String telephone,String address,String member,String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("INSERT INTO Warehouse ( warname,contact,telephone,address,times,member,community) VALUES ( " + db.cite(warname) + "," + db.cite(contact) + "," + db.cite(telephone) + "," + db.cite(address) + "," + db.cite(times) + "," + db.cite(member) + "," + db.cite(community) + ")");
        } finally
        {
            db.close();
        }

    }

    public void set(String warname,String contact,String telephone,String address,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Warehouse SET warname=" + db.cite(warname) + ",contact=" + db.cite(contact) + ",telephone=" + db.cite(telephone) + ",address=" + db.cite(address) + ",member=" + db.cite(member) + " WHERE warehouse=" + warehouse);
        } finally
        {
            db.close();
        }

    }

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT warehouse FROM Warehouse WHERE community= " + db.cite(community) + sql,pos,size);
            while(db.next())
            {
                v.add(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM  Warehouse WHERE warehouse = " + warehouse);
        } finally
        {
            db.close();
        }
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(warehouse) FROM Warehouse  WHERE community=" + db.cite(community) + sql);
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

    public String getAddress()
    {
        if(address == null)
        {
            return "";
        }
        return address;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getContact()
    {
        if(contact == null)
        {
            return "";
        }
        return contact;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getMember()
    {
        return member;
    }

    public String getTelephone()
    {
        if(telephone == null)
        {
            return "";
        }
        return telephone;
    }

    public Date getTimes()
    {
        return times;
    }

    public String getWarname()
    {
        if(warname == null)
        {
            return "";
        }
        return warname;
    }


}
