package tea.entity.admin.office;


import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Sealapply extends Entity
{

    private static Cache _cache = new Cache(100);
    private int sealapply;
    private String community;
    private int cachet; //印章名字ID
    private Date usetime; //印章使用时间
    private Date times;
    private int shares; //份数
    private int examinetype; //审批标示 0，1 批准，-1 不批准
    private int sealtype; //盖章 ，0 等待盖章 ,1 已经盖章
    private String usecausation; //用章事由
    private String notcausation; //不批准理由
    private int item; //使用的项目
    private String member;
    private String auditingmember; //印章审批人
    private String sealmember; //印章盖章人
    private boolean exists;

    public Sealapply(int sealapply) throws SQLException
    {
        this.sealapply = sealapply;
        load();
    }

    public static Sealapply find(int sealapply) throws SQLException
    {
        Sealapply obj = (Sealapply) _cache.get(new Integer(sealapply));
        if(obj == null)
        {
            obj = new Sealapply(sealapply);
            _cache.put(new Integer(sealapply),obj);
        }
        return obj;
    }


    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select cachet,usetime,shares,times,examinetype,sealtype,usecausation,notcausation,community,member,item,auditingmember,sealmember from Sealapply where sealapply=" + sealapply);
            if(db.next())
            {

                cachet = db.getInt(1);
                usetime = db.getDate(2);
                shares = db.getInt(3);
                times = db.getDate(4);
                examinetype = db.getInt(5);
                sealtype = db.getInt(6);
                usecausation = db.getString(7);
                notcausation = db.getString(8);
                community = db.getString(9);
                member = db.getString(10);
                item = db.getInt(11);
                auditingmember = db.getString(12);
                sealmember = db.getString(13);
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

    public static void create(int cachet,Date usetime,int shares,int examinetype,int sealtype,String usecausation,String notcausation,String community,String member,int item) throws SQLException
    {
        Date times = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Sealapply (cachet,usetime,shares,times,examinetype,sealtype,usecausation,notcausation,community,member,item)VALUES(" + (cachet) + "," + DbAdapter.cite(usetime) + "," + shares + "," + DbAdapter.cite(times) + "," + examinetype + "," + sealtype + "," + DbAdapter.cite(usecausation) + "," + DbAdapter.cite(notcausation) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(member) + "," + item + " )");
        } finally
        {
            db.close();
        }
    }

    public void set(int cachet,Date usetime,int shares,int examinetype,int sealtype,String usecausation,String notcausation,String community,String member,int item) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Sealapply SET cachet=" + (cachet) + ",usetime=" + DbAdapter.cite(usetime) + ",shares=" + shares + ",examinetype=" + examinetype + ",sealtype=" + sealtype + " ,usecausation=" + DbAdapter.cite(usecausation) + ",notcausation=" + DbAdapter.cite(notcausation) + ",community=" + DbAdapter.cite(community) + ",member=" + DbAdapter.cite(member) + ",item=" + item + "  WHERE sealapply=" + sealapply);
        } finally
        {
            db.close();
        }
        this.cachet = cachet;
        this.usetime = usetime;
        this.shares = shares;
        this.examinetype = examinetype;
        this.sealtype = sealtype;
        this.usecausation = usecausation;
        this.notcausation = notcausation;
        this.community = community;
        this.member = member;
        this.item = item;
    }


    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Sealapply WHERE sealapply=" + sealapply);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(sealapply));
    }

    public static int count(String community,String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM Sealapply WHERE community=" + DbAdapter.cite(community) + sql);
            while(db.next())
            {
                i = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return i;
    }


    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT sealapply FROM Sealapply WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
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

//审核
    public void set(int type,String field,String member,String fieldmember) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Sealapply SET " + field + " = " + (type) + "," + fieldmember + "=" + DbAdapter.cite(member) + "  WHERE sealapply=" + sealapply);

        } finally
        {
            db.close();
        }

        if(field.equals("examinetype"))
        {
            this.examinetype = type;
            this.auditingmember = member;
        }
        if(field.equals("sealtype"))
        {
            this.sealtype = type;
            this.sealmember = member;
        }

    }

//审核 不批准 填写原因
    public void set(String notcausation) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Sealapply SET notcausation =" + DbAdapter.cite(notcausation) + "  WHERE sealapply=" + sealapply);

        } finally
        {
            db.close();
        }
        this.notcausation = notcausation;
    }


    public int getSealapply()
    {
        return sealapply;
    }

    public int getCachet()
    {
        return cachet;
    }

    public String getCommunity()
    {
        return community;
    }

    public Date getUsetime()
    {
        return usetime;
    }

    public String getUsetimeToString()
    {
        if(usetime == null)
        {
            return "";
        }
        return sdf.format(usetime);
    }

    public Date getTimes()
    {
        return times;
    }

    public String getTimestoString()
    {
        if(times == null)
        {
            return "";
        }
        return sdf.format(times);
    }

    public int getShare()
    {
        return shares;
    }

    public int getExaminetype()
    {
        return examinetype;
    }

    public int getSealtype()
    {
        return sealtype;
    }

    public String getUsecausation()
    {
        return usecausation;
    }

    public String getNotcausation()
    {
        return notcausation;
    }

    public String getMember()
    {
        return member;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getItem()
    {
        return item;
    }


    public String getAuditingmember()
    {
        return auditingmember;
    }

    public String getSealmember()
    {
        return sealmember;
    }


}
