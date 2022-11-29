package tea.entity.admin;


import java.math.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;


public class ProjectNotPay extends Entity
{
    //日期、 金额、 说明（输入框）、 方式（转帐、现金、支票）、 接受方（输入框）、经办人
    private int id;
    private BigDecimal paymoney; //id,paymoney,paydate,payinfo,paytype,receives,member,exists
    private Date paydate;
    private String payinfo;
    private int paytype;
    private String receives;
    private String member;
	private String community;
    private boolean exists;


	public static final String PAYTYPES[]={"转帐","现金","支票","其他"};

    public static ProjectNotPay find(int id) throws SQLException
    {
        return new ProjectNotPay(id);
    }


    public ProjectNotPay(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id,paymoney,paydate,payinfo,paytype,receives,member,community from ProjectNotPay where id= " + id);
            if(db.next())
            {
                int j = 1;
                id = db.getInt(j++);
                paymoney = db.getBigDecimal(j++,2);
                paydate = db.getDate(j++);
                payinfo = db.getString(j++);
                paytype = db.getInt(j++);
                receives = db.getString(j++);
                member = db.getString(j++);
				community = db.getString(j++);
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
	public static void set(int id,BigDecimal paymoney,Date paydate,String payinfo,int paytype,String receives,String member,String community)throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("select id from ProjectNotPay where id="+id);
			if(db.next())
			{
				db.executeUpdate("Update ProjectNotPay set paymoney="+paymoney+",paydate="+db.cite(paydate)+",payinfo="+db.cite(payinfo)+",paytype="+paytype+",receives="+db.cite(receives)+",member="+db.cite(member)+",community="+db.cite(community)+" where id="+id);
			}
			else
			{
				db.executeUpdate("Insert into ProjectNotPay(paymoney,paydate,payinfo,paytype,receives,member,community)values("+paymoney+","+db.cite(paydate)+","+db.cite(payinfo)+","+paytype+","+db.cite(receives)+","+db.cite(member)+","+db.cite(community)+")");
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
            db.executeQuery("SELECT id FROM ProjectNotPay WHERE community=" + db.cite(community) + " "+sql,pos,size);
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
            db.executeQuery("Select count(id) from ProjectNotPay where community= "+db.cite(community)+"  "+ sql);
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
			db.executeUpdate("delete ProjectNotPay where id="+id);
		}
		finally
		{
			db.close();
		}
    }

    public static BigDecimal sumPaymoney(String community,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
		BigDecimal pp = new BigDecimal("0");
		try
		{
			db.executeQuery("select sum(paymoney) from ProjectNotPay where community="+db.cite(community)+" "+sql);
			if(db.next())
			{
				pp = db.getBigDecimal(1,2);
			}
		}
		finally
		{
			db.close();
		}
		return pp;
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

    public Date getPaydate()
    {
        return paydate;
    }

    public String getPaydatetoString()
    {
        if(paydate != null)
        {
            return ProjectNotPay.sdf.format(paydate);

        } else
        {
            return "";
        }
    }
    public String getPayinfo()
    {
        return payinfo;
    }

    public BigDecimal getPaymoney()
    {
        return paymoney;
    }

    public int getPaytype()
    {
        return paytype;
    }

    public String getReceives()
    {
        return receives;
    }

    public String getCommunity()
    {
        return community;
    }


}
