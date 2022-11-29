package tea.entity.admin.erp;

import java.math.*;
import java.sql.*;
import java.util.*;

import tea.db.*;

//加盟店: 库存
public class ICInventory
{
	private int icid;
    private int leagueshop; //加盟店
    private int node; //商品
    private int quantity; //库存
    private boolean exists;
    private ICInventory(int icid) throws SQLException
    {
        this.icid = icid;
        load();
    }

    public static ICInventory find(int icid) throws SQLException
    {
        return new ICInventory(icid);
    }

    public static void create(int leagueshop,int node,int quantity) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO ICInventory (leagueshop,node,quantity) VALUES (" + leagueshop + "," + node + "," + quantity + ")");
        } finally
        {
            db.close();
        }
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT leagueshop,node,quantity FROM ICInventory WHERE icid= "+icid);
            if(db.next())
            {
                leagueshop = db.getInt(1);
                node = db.getInt(2);
                quantity = db.getInt(3);
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

    public void setQuantity(int quantity) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE ICInventory SET quantity=" + quantity + " WHERE leagueshop=" + leagueshop + " AND node=" + node);
        } finally
        {
            db.close();
        }
        this.quantity = quantity;
    }

    public static java.util.Enumeration find(String sql,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT icid FROM ICInventory WHERE 1= 1 " + sql,pos,size);
           System.out.println("SELECT icid FROM ICInventory WHERE 1= 1 " + sql);
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } catch(Exception exception3)
        {
            System.out.print(exception3);
        } finally
        {
            db.close();
        }
        return vector.elements();
    }
//以加盟店为主键显示
    public static java.util.Enumeration findLeagueshop(String field,String sql,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select "+field+" from ICInventory ic ,LeagueShop ls where ic.leagueshop=ls.id " + sql+" group by  "+ field,pos,size);
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } catch(Exception exception3)
        {
            System.out.print(exception3);
        } finally
        {
            db.close();
        }
        return vector.elements();
    }
	//显示加盟店为主键的数量
    public static int count(String field,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int num = 0;
        try
        {
            db.executeQuery("select count(distinct("+field+")) from ICInventory ic ,LeagueShop ls where ic.leagueshop=ls.id " + sql);
            if(db.next())
            {
                num = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return num;
    }

	//通过加盟店 显示库存总数
	public static int getLeQuantity(String field,int leagueshop)throws SQLException
	{
		 DbAdapter db = new DbAdapter();
		 int q = 0;
		 try
		 {
		 db.executeQuery("select sum(quantity) from ICInventory where "+field+" = "+leagueshop);
		 if(db.next())
		 {
			 q = db.getInt(1);
		 }
		 }finally
		 {
			 db.close();
		 }
		 return q;
	}
	//通过加盟店 显示库存总数
	public static int getLeQuantity2(int node,int leagueshop)throws SQLException
	{
		 DbAdapter db = new DbAdapter();
		 int q = 0;
		 try
		 {
		 db.executeQuery("select sum(quantity) from ICInventory where leagueshop = "+leagueshop+" and node="+node);
		 if(db.next())
		 {
			 q = db.getInt(1);
		 }
		 }finally
		 {
			 db.close();
		 }
		 return q;
	}

   //显示合计总库存
   public static int getLeTotal(String sql) throws SQLException
   {
       DbAdapter db = new DbAdapter();
       int q = 0;
       try
       {
          db.executeQuery("select sum(ic.quantity) from ICInventory ic ,LeagueShop ls where ic.leagueshop=ls.id " + sql);

           if(db.next())
           {
               q = db.getInt(1);
           }
       } finally
       {
           db.close();
       }
       return q;
   }


    public static int count(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int num = 0;
        try
        {
            db.executeQuery("select count(icid) from  ICInventory  where 1=1 " + sql);
            if(db.next())
            {
                num = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return num;
    }
	public static int count2(String sql) throws SQLException
		{
			DbAdapter db = new DbAdapter();
			int num = 0;
			try
			{
				 db.executeQuery("select count(distinct(ic.leagueshop)) from ICInventory ic ,LeagueShop ls where ic.leagueshop=ls.id  " + sql);
				if(db.next())
				{
					num = db.getInt(1);
				}
			} finally
			{
				db.close();
			}
			return num;
    }

    public static int count3(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int num = 0;
        try
        {
            db.executeQuery("select count(distinct(ic.node)) from ICInventory ic ,LeagueShop ls where ic.leagueshop=ls.id  " + sql);
            if(db.next())
            {
                num = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return num;
    }

    public int getQuantity()
    {
        return quantity;
    }

    public int getNode()
    {
        return node;
    }

    public int getLeagueshop()
    {
        return leagueshop;
    }

    public boolean isExists()
    {
        return exists;
    }

}
