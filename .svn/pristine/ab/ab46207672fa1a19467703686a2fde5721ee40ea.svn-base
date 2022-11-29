package tea.entity.admin;

import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;
import tea.entity.member.Profile;

public class AdminUnitSeq
{
    private static Cache _cache = new Cache(100);
    private int unit;
    private String member;
    private int sequence;
    private boolean exists;

    public AdminUnitSeq(int unit,String member) throws SQLException
    {
        this.unit = unit;
        this.member = member;
        load();
    }

    public static AdminUnitSeq find(int unit,String member) throws SQLException
    {
        AdminUnitSeq obj = (AdminUnitSeq) _cache.get(unit + ":" + member);
        if(obj == null)
        {
            obj = new AdminUnitSeq(unit,member);
            _cache.put(unit + ":" + member,obj);
        }
        return obj;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM AdminUnitSeq WHERE unit=" + unit + " AND member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
        _cache.remove(unit + ":" + member);
    }

    public static void create(int unit,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO AdminUnitSeq(unit,member,sequence)VALUES(" + unit + "," + DbAdapter.cite(member) + "," + (System.currentTimeMillis() / 1000) + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(unit + ":" + member);
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT sequence FROM AdminUnitSeq WHERE unit=" + unit + " AND member= " + DbAdapter.cite(member));
            if(db.next())
            {
                sequence = db.getInt(1);
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

    public static void refresh(String community) throws SQLException
    {
        Enumeration e = AdminUsrRole.find(community," AND role!='/' ",0,Integer.MAX_VALUE);
        while(e.hasMoreElements())
        {
            String member = (String) e.nextElement();
            AdminUsrRole aur = AdminUsrRole.find(community,member);
            String s[] = (aur.getUnit() + aur.getClasses()).split("/");
            for(int i = 0;i < s.length;i++)
            {
                int unit = Integer.parseInt(s[i]);
                AdminUnitSeq aus = AdminUnitSeq.find(unit,member);
                if(!aus.isExists())
                {
                    AdminUnitSeq.create(unit,member);
                }
            }
        }
    }

    public static Enumeration findByCommunity(String community,int unit) throws SQLException
    {
        return findByCommunity(community,unit,false);
    }

    //bool: true:不显到部门信息中
    public static Enumeration findByCommunity(String community,int unit,boolean bool) throws SQLException
    {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT aus.member FROM AdminUnitSeq aus INNER JOIN AdminUsrRole aur ON aus.unit=" + unit + " AND (select profile from profile where member = aus.member)=aur.member WHERE aur.community=").append(DbAdapter.cite(community));
        sql.append(" AND aur.role!='/' AND ( aur.unit=" + unit + " OR aur.dept LIKE ").append(DbAdapter.cite("%/" + unit + "/%")).append(")");
        if(bool)
        {
            sql.append(" AND aur.options NOT LIKE '%/1/%'");
        }
        sql.append(" ORDER BY aus.sequence");
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(sql.toString());
            while(db.next())
            {
                v.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }


    public static Enumeration findByCommunity(String sql) throws SQLException
    {

        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select unit from adminunitseq where 1=1" + sql.toString());
            while(db.next())
            {
                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static String findByMember(String sql) throws SQLException
    {

        String member = "";
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select member from adminunitseq where 1=1" + sql.toString());
            while(db.next())
            {
                member = db.getString(1);
            }
        } finally
        {
            db.close();
        }
        return member;
    }

    public static Enumeration findBM(String sql) throws SQLException
    {

        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select member from adminunitseq where 1=1" + sql.toString());
            while(db.next())
            {
                v.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }


    public void setSequence(int sequence) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE AdminUnitSeq SET sequence=" + sequence + " WHERE unit=" + unit + " AND member= " + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
        this.sequence = sequence;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getUnit()
    {
        return unit;
    }

    public int getSequence()
    {
        return sequence;
    }

    public String getMember()
    {
        return member;
    }
}
