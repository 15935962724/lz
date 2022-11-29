package tea.entity.admin.erp.semi;


import java.math.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;


//半成品的相信列表
public class SemiGoods extends Entity
{
    private int id;//id,goodsnumber,subject,supply,measure,spec,community,member,addtime
    private String goodsnumber; //商品编号 goodsnumber  ---node
    private String subject; //商品名称 subject ---  Nodelayer
    private BigDecimal supply; //商品进货价 supply ---BuyPrice---------用不到了
    private String measure; //商品单位 measure ---Goods---------用不到了
    private String spec; //商品规格 spec ---Goods---------用不到了
    private String community;
    private String member;
    private Date addtime;
	private String info;//备注
	private boolean exists;
    public static SemiGoods find(int id) throws SQLException
    {
        return new SemiGoods(id);
    }

    public SemiGoods(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public void load() throws SQLException
    {
		DbAdapter db = new DbAdapter();
		try
		{
            db.executeQuery("select id,goodsnumber,subject,supply,measure,spec,community,member,addtime,info from SemiGoods where id="+id);
            if(db.next())
            {
                int j = 1;
                id = db.getInt(j++);
                goodsnumber = db.getString(j++);
                subject = db.getString(j++);
                supply = db.getBigDecimal(j++,2);
                measure = db.getString(j++);
                spec = db.getString(j++);
                community = db.getString(j++);
                member = db.getString(j++);
                addtime = db.getDate(j++);
				info = db.getString(j++);
                exists = true;
            } else
            {
                exists = false;
            }
        }
		finally
		{
			db.close();
		}

    }

    public static void set(int id,String goodsnumber,String subject,BigDecimal supply,String measure,String spec,String community,String member,Date addtime,String info) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date date = new Date();

        try
        {
            db.executeQuery("Select id from LeagueShop where id=" + id);
            if(db.next())
            {
                db.executeUpdate("update SemiGoods set goodsnumber="+db.cite(goodsnumber)+",subject="+db.cite(subject)+",supply="+supply+",measure="+db.cite(measure)+",spec="+db.cite(spec)+",community="+db.cite(community)+",member="+db.cite(member)+",addtime="+db.cite(date)+",info="+db.cite(info)+" where id ="+id);
            } else
            {
                db.executeUpdate("insert into SemiGoods (goodsnumber,subject,supply,measure,spec,community,member,addtime,info)values("+db.cite(goodsnumber)+" ,"+db.cite(subject)+","+ supply+","+db.cite(measure) +","+db.cite(spec) +","+ db.cite( community)+","+db.cite( member)+","+ db.cite(addtime)+ ","+db.cite(info)+")");
            }
        } finally
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
            db.executeQuery("SELECT id FROM SemiGoods WHERE community=" + db.cite(community) + sql,pos,size);
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
            db.executeQuery("Select count(id) from SemiGoods where community="+db.cite(community)+" " + sql);
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
            db.executeUpdate("Delete  SemiGoods where id= " + id);

        } finally
        {
            db.close();
        }
    }
	public static boolean isNumber(String goodsnumber) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		boolean f = false;
		try
		{
			db.executeQuery("SELECT id FROM SemiGoods WHERE goodsnumber=" + db.cite(goodsnumber));
			if(db.next())
			{
				f = true;
			}
		} finally
		{
			db.close();
		}
		return f;
    }


    public Date getAddtime()
    {
        return addtime;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getGoodsnumber()
    {
        return goodsnumber;
    }

    public int getId()
    {
        return id;
    }

    public String getMeasure()
    {
        return measure;
    }

    public String getMember()
    {
        return member;
    }

    public String getSpec()
    {
        return spec;
    }

    public String getSubject()
    {
        return subject;
    }

    public BigDecimal getSupply()
    {
        return supply;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getInfo()
    {
        return info;
    }



}
