package tea.entity.member;

import java.util.Hashtable;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.*;
import java.io.*;
import java.sql.SQLException;

public class SMSSubcode extends Entity
{
    private static Cache _cache = new Cache(100);
    private int code;
    private String password;
    private boolean autoreverse; // 是否自动回复
    private int fincode; // 企业号
    private String mobileno; // 手机号
    private boolean exists;

    public SMSSubcode(int code) throws SQLException
    {
        this.code = code;
        loadBasic();
    }

    public static SMSSubcode find(int code) throws SQLException
    {
        SMSSubcode obj = (SMSSubcode) _cache.get(new Integer(code));
        if(obj == null)
        {
            obj = new SMSSubcode(code);
            _cache.put(new Integer(code),obj);
        }
        return obj;
    }

    public static void create(int code,String password,boolean autoreverse,int fincode,String mobileno) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO sms_subcode(code,password,autoreverse,fincode,mobileno,reversecount)VALUES(" + code + "," + DbAdapter.cite(password) + "," + DbAdapter.cite(autoreverse) + ","
                             + fincode + "," + DbAdapter.cite(mobileno) + ",0)");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(code));
    }

    /*
     * public void set(int code, String password) throws SQLException { if (!exists) { create(member, community); } DbAdapter db = new DbAdapter(); try { db.executeUpdate("UPDATE SMSSubcode SET
     * code=" + (code) + ",password=" + DbAdapter.cite(password) + getWhereSql(member, community));} finally {
     * db.close(); } this.code = code; this.password = password; }
     *
     * public void set(boolean states, String signature, int code, String password) throws SQLException { DbAdapter db = new DbAdapter(); try { db.executeUpdate("UPDATE SMSSubcode SET states=" +
     * DbAdapter.cite(states) + ",signature=" + DbAdapter.cite(signature) + ",autor=" + DbAdapter.cite(autor) + ",code=" + code + ",password=" + DbAdapter.cite(password) + " WHERE member=" +
     * DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community)); } finally {
     * db.close(); } this.states = states; this.code = code; this.password = password; _htLayer.clear(); }
     */
    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT password,autoreverse,fincode,mobileno FROM sms_subcode WHERE code=" + code);
            if(db.next())
            {
                password = db.getString(1);
                autoreverse = db.getInt(2) != 0;
                fincode = db.getInt(3);
                mobileno = db.getString(4);
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

    public static int count(String sql) throws SQLException
    {
        int c = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(code) FROM sms_subcode WHERE 1=1" + sql);
            if(db.next())
            {
                c = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return c;
    }

    public static java.util.Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT code FROM sms_subcode WHERE 1=1" + sql,pos,size);
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

    public int getCode()
    {
        return code;
    }

    public String getPassword()
    {
        return password;
    }

    public boolean isAutoreverse()
    {
        return autoreverse;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getFincode()
    {
        return fincode;
    }

    public String getMobileno()
    {
        return mobileno;
    }
}
