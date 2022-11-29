package tea.entity.admin.erp.semi;

import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import java.util.Vector;
import java.math.BigDecimal;
import java.util.Enumeration;

public class SemiPurchase extends Entity
{

    private String purchase; //订单号合成规则单号
    private String quantityarr; //半成品ID每个商品的数量
    private String semigoods; //半成品ID
    private String goods; //成品ID node
    private Date time_s; //提交时间
    private String member; //操作人员
    private String community; //社区
    private String remarks; //备注
    private int type; //类型
    private boolean exists;

    public static SemiPurchase find(String purchase) throws SQLException
    {
        return new SemiPurchase(purchase);
    }

    public SemiPurchase(String purchase) throws SQLException
    {
        this.purchase = purchase;
        load();
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select purchase,quantityarr,semigoods,goods,time_s,member,community,remarks,type from SemiPurchase where purchase=" + db.cite(purchase));
            if(db.next())
            {
                int j = 1;
                purchase = db.getString(j++);
                quantityarr = db.getString(j++);
                semigoods = db.getString(j++);
                goods = db.getString(j++);
                time_s = db.getDate(j++);
                member = db.getString(j++);
                community = db.getString(j++);
                remarks = db.getString(j++);
                type = db.getInt(j++);
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

	public static void set(String purchase,String quantityarr,String semigoods,String goods,Date time_s,String member,String community,String remarks,int type) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("Select purchase from SemiPurchase where purchase="+db.cite(purchase));
			if(db.next())
			{
				db.executeUpdate("Update SemiPurchase set purchase="+db.cite(purchase)+",quantityarr="+db.cite(quantityarr)+",semigoods="+db.cite(semigoods)+",goods="+db.cite(goods)+",time_s="+db.cite(time_s)+",member="+db.cite(member)+",community="+db.cite(community)+",remarks="+db.cite(remarks)+",type="+type+" where purchase="+db.cite(purchase));
			}else
			{
				db.executeUpdate("Insert into SemiPurchase(purchase,quantityarr,semigoods,goods,time_s,member,community,remarks,type)values("+db.cite(purchase)+","+db.cite(quantityarr)+","+db.cite(semigoods)+","+db.cite(goods)+","+db.cite(time_s)+","+db.cite(member)+","+db.cite(community)+","+db.cite(remarks)+","+type+")");
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
			db.executeQuery("SELECT purchase FROM SemiPurchase WHERE community=" + db.cite(community) + sql,pos,size);
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

	public static int count(String community,String sql) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		int num = 0;
		try
		{
			db.executeQuery("Select count(purchase) from SemiPurchase where community=" + db.cite(community) + " " + sql);
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

	public static void delete(String purchase) throws SQLException
	{
		DbAdapter db = new DbAdapter();

		try
		{
			db.executeUpdate("Delete  SemiPurchase where purchase= " + purchase);

		} finally
		{
			db.close();
		}
	}



    public String getCommunity()
    {
        return community;
    }

    public String getGoods()
    {
        return goods;
    }

    public String getMember()
    {
        return member;
    }

    public String getPurchase()
    {
        return purchase;
    }

    public String getQuantityarr()
    {
        return quantityarr;
    }

    public String getRemarks()
    {
        return remarks;
    }

    public String getSemigoods()
    {
        return semigoods;
    }

    public Date getTime_s()
    {
        return time_s;
    }

    public int getType()
    {
        return type;
    }

    public boolean isExists()
    {
        return exists;
    }
}
