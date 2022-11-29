package tea.entity.integral;

import java.sql.*;
import java.util.Date;
import tea.db.*;
import tea.entity.*;

public class IntegralPrize extends Entity
{
    private String community;
    private String member;
    private int id;
    private String shopping;//商品名称
    private int shop_integral;//商品积分
    private Date times;
    
    private String coding;//商品编码
    private String recomm;//小编推荐
    private String text;//奖品介绍
    private String explain;//使用说明
    private String spic;//小图片
    private String dpic;//大图片
    private String rpic;// 推荐图片
    
    private String statustype;//状态 0 最新上架,1 推荐礼品,2热门礼品,3特色商品
    
    private int cstype;//兑换商品的次数
    
    
     
     
    private boolean exists;


    public IntegralPrize(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static IntegralPrize find(int id) throws SQLException
    {
        return new IntegralPrize(id);

    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select community ,member,times,shopping,shop_integral,coding,recomm,texts,explains,spic,dpic,rpic,statustype,cstype from IntegralPrize where id ="+id);
            if (db.next())
            {
                community = db.getString(1);
                member = db.getString(2);
                times = db.getDate(3);
                shopping = db.getString(4);
                shop_integral = db.getInt(5);
                coding=db.getString(6);
                recomm=db.getString(7);
                text=db.getString(8);
                explain=db.getString(9);
                spic=db.getString(10);
                dpic=db.getString(11);
                rpic=db.getString(12);
                statustype=db.getString(13); 
                cstype=db.getInt(14);
                exists = true;
            }else
            {
            	spic = "";
            	dpic="";
            	rpic="";
            	exists=false;
            }
        } finally
        {
            db.close();
        }
    }
 
    public static void create(String community ,String member ,Date times,String shopping,int shop_integral,
    		String coding,String recomm,String text,String explain,String spic,String dpic,String rpic,String statustype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into IntegralPrize(community ,member , times,shopping,shop_integral,coding,recomm,texts,explains," +
            		"spic,dpic,rpic,statustype) values " +
            		"("+db.cite(community)+","+db.cite(member)+" , "+db.cite(times)+","+db.cite(shopping)+","+shop_integral+"," +
            		" "+db.cite(coding)+","+db.cite(recomm)+","+db.cite(text)+","+db.cite(explain)+","+db.cite(spic)+"," +
            	    ""+db.cite(dpic)+","+db.cite(rpic)+","+db.cite(statustype)+")");

        } finally
        {
            db.close();
        }
    }

    public  void set(int id,String community ,String member ,Date times,String shopping,int shop_integral,
    		String coding,String recomm,String text,String explain,String spic,String dpic,String rpic) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update IntegralPrize set community="+db.cite(community)+" ,member="+db.cite(member)+" , times="+db.cite(times)+",shopping="+db.cite(shopping)+",shop_integral="+shop_integral+"," +
            		" coding="+db.cite(coding)+",recomm="+db.cite(recomm)+",texts="+db.cite(text)+",explains="+db.cite(explain)+"," +
            		" spic="+db.cite(spic)+",dpic="+db.cite(dpic)+",rpic="+db.cite(rpic)+"  where id = "+id);

        } finally
        {
            db.close();
        }
    }
    
    public void setStatustype(String statustype)throws SQLException
    {
    	  DbAdapter db = new DbAdapter();
          try
          {
              db.executeUpdate("update IntegralPrize set statustype="+db.cite(statustype)+" where id = "+id);

          } finally
          {
              db.close();
          }
    }
    public void setCstype(int cstype)throws SQLException
    {
    	  DbAdapter db = new DbAdapter();
          try
          {
              db.executeUpdate("update IntegralPrize set cstype="+cstype+" where id = "+id);

          } finally
          {
              db.close();  
          }
    }
    
    public static void delete(int id ) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from IntegralPrize where id = "+id);

        } finally
        {
            db.close();
        }
    }
    public static int count(String community,String sql)throws SQLException 
    {
    	int c = 0;
    	DbAdapter db = new DbAdapter();
    	try
    	{
    		db.executeQuery("select count(id) from IntegralPrize where community = "+DbAdapter.cite(community)+sql);
    		if(db.next())
    		{
    			c = db.getInt(1);
    		}
    	}finally
    	{
    		db.close();
    	}
    	return c;
    }

    public static java.util.Enumeration findByIntegral(String community, String sql, int pos, int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM IntegralPrize WHERE community=" + DbAdapter.cite(community) + sql);

            for (int l = 0; l < pos + pageSize && db.next(); l++)
            {
                if (l >= pos)
                {
                    vector.addElement(String.valueOf(db.getInt(1)));
                }
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public String getCommunity()
    {
        return community;
    }

    public int getId()
    {
        return id;
    }

    public String getMember()
    {
        return member;
    }

    public int getShop_integral()
    {
        return shop_integral;
    }

    public String getShopping()
    {
        return shopping;
    }

    public boolean isExists()
    {
        return exists;
    }

    public Date getDatetime()
    {
        return times;
    }

	public String getCoding() {
		return coding;
	}

	public String getRecomm() {
		return recomm;
	}

	public String getText() {
		return text;
	}

	public String getExplain() {
		return explain;
	}
	public String getSpic()
	{
		return spic;
	}
	public String getDpic()
	{
		return dpic;
	}
	public String getRpic()
	{
		return rpic;
	}
	public String getStatustype()
	{
		return statustype; 
	}
	public int getCstype()
	{
		return cstype;
	}
    
	
}
