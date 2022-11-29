package tea.entity.cio;

import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;

public class CioInviteCode extends Entity
{
    private static Cache _cache = new Cache(100);
    private String code;
    private String community;
    private String member;
    private String ip;
    private boolean exists;
    public CioInviteCode(String code) throws SQLException
    {
        this.code = code;
        load();
    }

    public CioInviteCode(String code,String community,String member,String ip) throws SQLException
    {
        this.code = code;
        this.community = community;
        this.member = member;
        this.ip = ip;
        this.exists = true;
    }

    public static CioInviteCode find(String code) throws SQLException
    {
        CioInviteCode obj = (CioInviteCode) _cache.get(code);
        if(obj == null)
        {
            obj = new CioInviteCode(code);
            _cache.put(code,obj);
        }
        return obj;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,member,ip FROM CioInviteCode WHERE code=" + DbAdapter.cite(code));
            if(db.next())
            {
                community = db.getString(1);
                member = db.getString(2);
                ip = db.getString(3);
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

    public static void create(String community,int count) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            for(int i = 0;i < count;i++)
            {
                String code = String.valueOf(Math.random()).substring(2,8);
                db.executeQuery("SELECT * FROM CioInviteCode WHERE code=" + DbAdapter.cite(code));
                if(!db.next())
                {
                    db.executeUpdate("INSERT INTO CioInviteCode(code,community)VALUES(" + DbAdapter.cite(code) + ", " + DbAdapter.cite(community) + ")");
                }
            }
        } finally
        {
            db.close();
        }
    }

    public static int count(String community,String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM CioInviteCode WHERE community=" + DbAdapter.cite(community) + sql);
            if(db.next())
            {
                j = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return j;
    }

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT code,member,ip FROM CioInviteCode WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
            while(db.next())
            {
                String code = db.getString(1);
                String member = db.getString(2);
                String ip = db.getString(3);
                CioInviteCode obj = new CioInviteCode(code,community,member,ip);
                _cache.put(code,obj);
                v.add(obj);
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public void set(String member,String ip) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE CioInviteCode SET member=" + DbAdapter.cite(member) + ",ip=" + DbAdapter.cite(ip) + " WHERE code=" + DbAdapter.cite(code));
        } finally
        {
            db.close();
        }
        this.member = member;
        this.ip = ip;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM CioInviteCode WHERE code=" + DbAdapter.cite(code));
        } finally
        {
            db.close();
        }
        _cache.remove(code);
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getMember()
    {
        return member;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getCode()
    {
        return code;
    }

    public String getIp()
    {
        return ip;
    }


}
