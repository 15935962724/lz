package tea.entity.admin.erp;

import java.math.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class BatchPrice extends Entity
{
    private int bpid;
    private int joinname; //加盟店ID
    private int node; //商品ID
    private java.math.BigDecimal price; //修改后的价格
    private Date times;
    private String community;
    private String member;
	private float discount;//折扣
    private boolean exists;

    public BatchPrice(int bpid) throws SQLException
    {
        this.bpid = bpid;
        load();
    }

    public static BatchPrice find(int bpid) throws SQLException
    {
        return new BatchPrice(bpid);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(" SELECT joinname,node,price,times,community,member,discount FROM BatchPrice  WHERE bpid =" + bpid);
            if(db.next())
            {
                joinname = db.getInt(1);
                node = db.getInt(2);
                price = db.getBigDecimal(3,2);
                times = db.getDate(4);
                community = db.getString(5);
                member = db.getString(6);
				discount=db.getFloat(7);
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

    public static void create(int joinname,int node,java.math.BigDecimal price,String community,String member,float discount) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("INSERT INTO BatchPrice (joinname,node,price,times,community,member,discount" +
                             ") VALUES (" + joinname + "," + node + "," + price + "," + db.cite(times) + "," + db.cite(community) + " ,"+db.cite(member)+","+discount+" )");
        } finally
        {
            db.close();
        }
    }

    public void set(int joinname,int node,java.math.BigDecimal price,String member,float discount) throws SQLException
    {
        DbAdapter db = new DbAdapter();
		 Date times = new Date();
        try
        {
            db.executeUpdate("UPDATE BatchPrice SET times="+db.cite(times)+", joinname=" + joinname + ",node=" + node + ",price=" + price + ",member=" + db.cite(member) + ",discount="+discount+"  WHERE bpid = " + bpid);
        } finally
        {
            db.close();
        }
    }

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT bpid FROM BatchPrice WHERE community= " + db.cite(community) + sql,pos,size);
            while(db.next())
            {
                vector.add(new Integer(db.getInt(1)));
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
// 通过加盟店和商品id 判断是否存在
    public static int isJN(String community,int joinname,int node) throws SQLException
    {
		int f = 0;
		 DbAdapter db = new DbAdapter();
		 try
		 {
			 db.executeQuery("select bpid from BatchPrice where community ="+db.cite(community)+" and joinname ="+joinname+" and node ="+node);
			 if(db.next())
			 {
				f = db.getInt(1);
			 }
		 }finally
		 {
			 db.close();
		 }
		 return f;

    }
    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM  BatchPrice WHERE bpid = " + bpid);

        } finally
        {
            db.close();
        }
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(bpid) FROM BatchPrice  WHERE community=" + db.cite(community) + sql);
            if(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }

    public String getCommunity()
    {
        return community;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getJoinname()
    {
        return joinname;
    }

    public String getMember()
    {
        return member;
    }

    public int getNode()
    {
        return node;
    }

    public BigDecimal getPrice()
    {
        return price;
    }

    public Date getTimes()
    {
        return times;
    }
	public String getTimesToString()
	{
		if(times==null)
			return "";
		return sdf.format(times);
	}
	public float getDiscount()
	{
		return discount;
	}
}
