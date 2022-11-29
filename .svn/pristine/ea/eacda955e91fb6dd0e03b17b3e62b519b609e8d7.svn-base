package tea.entity.admin.erp;

import java.math.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class OrdersBatch extends Entity
{
	//流水表
    private int obid; //主键ID
    private String paid; //订单号
    private int node; //商品供应商提供的商品id
    private int quantity; //到货数量
    private String agentmember; //经办人
    private String member; //登录者
    private String community; //社区
    private Date time_s; //销售时间
    private Date times; //添加时间
	private int type;// //0表示是进货单和销售单，1表示是加盟店的退货单,2采购单,3退货单,4调拨单,5报损单,6配送单 7 赠送单 8 半成品生成规则， 9 ，半成品合成 进货单,半成品采购单 10.半成品合成成品 11.成品拆成半成品
	private int sgid; //商品的实际id
	private BigDecimal price; //商品的实际id


    private boolean exists;

    public OrdersBatch(int obid) throws SQLException
    {
        this.obid = obid;
        load();
    }

    public static OrdersBatch find(int obid) throws SQLException
    {
        return new OrdersBatch(obid);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT paid,node,quantity,agentmember,member,community,time_s,times,type,sgid,price FROM OrdersBatch WHERE obid=" + obid);
            if(db.next())
            {
                paid = db.getString(1);
                node = db.getInt(2);
				quantity=db.getInt(3);
                agentmember = db.getString(4);
                member = db.getString(5);
                community = db.getString(6);
                time_s = db.getDate(7);
                times = db.getDate(8);
				type=db.getInt(9);
				sgid=db.getInt(10);
				price =db.getBigDecimal(11,2);
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

    public static void create(String paid,int node,int quantity,String agentmember,String member,String community,Date time_s,int type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("INSERT INTO OrdersBatch (paid,node,quantity,agentmember,member,community,time_s,times,type) VALUES (" + db.cite(paid) + "," + node + "," + quantity + "," + db.cite(agentmember) + "," + db.cite(member) + "," + db.cite(community) + "," + db.cite(time_s) + "," + db.cite(times) +","+type+" )");
        } finally
        {
            db.close();
        }
    }

    public static void createSemi(String paid,int node,int quantity,String agentmember,String member,String community,Date time_s,int type,int sgid,BigDecimal price) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("INSERT INTO OrdersBatch (paid,node,quantity,agentmember,member,community,time_s,times,type,sgid,price) VALUES (" + db.cite(paid) + "," + node + "," + quantity + "," + db.cite(agentmember) + "," + db.cite(member) + "," + db.cite(community) + "," + db.cite(time_s) + "," + db.cite(times) + "," + type + ","+sgid+","+price+" )");
        } finally
        {
            db.close();
        }
    }

    public void set(String paid,int node,int quantity,String agentmember,String member,String community,Date time_s,int type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("UPDATE OrdersBatch SET paid=" + paid + ",node=" + node + ",quantity=" + quantity + ",agentmember=" + db.cite(agentmember) + ",member=" + db.cite(member) + ",community=" + db.cite(community) + ",time_s=" + db.cite(time_s) + ",times=" + db.cite(times) + ",type="+type+" WHERE obid=" + obid);
        } finally
        {
            db.close();
        }
    }

    public void setSemi(String paid,int node,int quantity,String agentmember,String member,String community,Date time_s,int type,int sgid,BigDecimal price) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("UPDATE OrdersBatch SET paid=" + paid + ",node=" + node + ",quantity=" + quantity + ",agentmember=" + db.cite(agentmember) + ",member=" + db.cite(member) + ",community=" + db.cite(community) + ",time_s=" + db.cite(time_s) + ",times=" + db.cite(times) + ",type=" + type + ",sgid="+sgid+",price="+price+" WHERE obid=" + obid);
        } finally
        {
            db.close();
        }
    }

    public static Enumeration find(String community,String sql,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT obid FROM OrdersBatch WHERE community= " + db.cite(community) + sql,pos,size);
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

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM OrdersBatch WHERE obid=" + obid);
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
            db.executeQuery("SELECT COUNT(obid) FROM OrdersBatch  WHERE community=" + db.cite(community) + sql);
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

    public String getAgentmember()
    {
        return agentmember;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getMember()
    {
        return member;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getNode()
    {
        return node;
    }

    public String getPaid()
    {
        return paid;
    }

    public int getQuantity()
    {
        return quantity;
    }

    public Date getTime_s()
    {
        return time_s;
    }
	public String getTime_sToString()
	{
		if(time_s==null)
			return "";
		return sdf.format(time_s);
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
	public int getType()
	{
		return type;
	}

    public int getSgid()
    {
        return sgid;
    }

    public BigDecimal getPrice()
    {
        return price;
    }

    public int getObid()
    {
        return obid;
    }


}
