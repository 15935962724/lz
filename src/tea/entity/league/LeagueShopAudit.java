package tea.entity.league;


import java.math.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class LeagueShopAudit extends Entity
{
    private int id;
    private int lsid; //
    private int lsyear;
    private int lsmonth;
    private int type; // 0 未审核通过，1审核通过
    private Date auditdate;
    private String member;
    private String community;
	private BigDecimal yfmoney; //
    private boolean exists;

    public static LeagueShopAudit find(int id) throws SQLException
    {
        return new LeagueShopAudit(id);
    }
    public LeagueShopAudit(int id) throws SQLException
    {
        this.id = id;
        load();
    }
    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select lsid,lsyear,lsmonth,type,auditdate,member,community,yfmoney from LeagueShopAudit where id=" + id);
            if(db.next())
            {
                int j = 1;

                lsid = db.getInt(j++);
                lsyear = db.getInt(j++);
                lsmonth = db.getInt(j++);
                type = db.getInt(j++);
                auditdate = db.getDate(j++);
                member = db.getString(j++);
                community = db.getString(j++);
				yfmoney=db.getBigDecimal(j++,2);
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

	public static void set(int id,int lsid,int lsyear,int lsmonth,int type,Date auditdate,String member,String community,BigDecimal yfmoney)throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{

			auditdate = new Date();
			db.executeQuery("Select id from LeagueShopAudit where id="+id);
			if(db.next())
			{
				db.executeUpdate("Update LeagueShopAudit set lsid="+lsid+",lsyear="+lsyear+",lsmonth="+lsmonth+",type="+type+",auditdate="+db.cite(auditdate)+",member="+db.cite(member)+",community="+db.cite(community)+",yfmoney="+yfmoney+" where id="+id);
			}
			else
			{
				db.executeUpdate("Insert into LeagueShopAudit(lsid,lsyear,lsmonth,type,auditdate,member,community,yfmoney)values("+lsid+","+lsyear+","+lsmonth+","+type+","+db.cite(auditdate)+","+db.cite(member)+","+db.cite(community)+","+yfmoney+")");
			}

		}
		finally
		{
			db.close();
		}

	}


    public static Enumeration findByCommunity(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM LeagueShopAudit WHERE community=" + db.cite(community) + sql,pos,size);
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

    public static int count(String community,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int num = 0;
        try
        {
            db.executeQuery("Select count(id) from LeagueShopAudit where 1=1 " + sql);
            if(db.next())
            {

                num = db.getInt(1);
                return num;
            } else
            {
                return num;
            }
        } finally
        {
            db.close();
        }
    }

    public static void delete(int id) throws SQLException
    {
        DbAdapter db = new DbAdapter();

        try
        {
            db.executeUpdate("Delete  LeagueShopAudit where id= " + id);

        } finally
        {
            db.close();
        }
    }

    public int getType()
    {
        return type;
    }

    public boolean isExists()
    {
        return exists;
    }

    public Date getAuditdate()
    {
        return auditdate;
    }

    public String getAuditdatetoString()
    {
        if(auditdate != null)
        {
            return LeagueShopAudit.sdf.format(auditdate);
        } else
        {
            return "";
        }
    }

    public String getCommunity()
    {
        return community;
    }

    public int getId()
    {
        return id;
    }

    public int getLsid()
    {
        return lsid;
    }

    public int getLsmonth()
    {
        return lsmonth;
    }

    public int getLsyear()
    {
        return lsyear;
    }

    public String getMember()
    {
        return member;
    }

}
