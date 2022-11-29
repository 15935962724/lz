package tea.entity.node;


import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;



import tea.applet.PrintTest;
import tea.db.*;
import tea.entity.*;
import tea.ui.TeaSession;
import tea.ui.member.profile.newcaller;

public class BouncePiao extends Entity 
{
	private int orderdetails_id;//表主键--座位表中的ID
	private int psid;//场次的id
	private java.math.BigDecimal price;//票的原价格
	private float poundage;//手续利率
	private java.math.BigDecimal pounprice;//退还的价格
	private Date times;//退票时间
	private String member;//退票操作的管理员
	private String performorders_id;//订单表的id ， 表示这个座位是那个订单表中的数据
	private int seatnumber;//座位号
	private int type;//标示 是退票和废票 0 是退票，1是废票
	private Date pftime;//演出时间
	private String weizhi;//演出座位号
	
	private boolean exist; //
	
	public BouncePiao(int orderdetails_id) throws SQLException
    {
        this.orderdetails_id = orderdetails_id;
        load();
    }

    public static BouncePiao find(int orderdetails_id) throws SQLException
    {
        return new BouncePiao(orderdetails_id);
    }
    public void load()throws SQLException
    {
    	 DbAdapter db = new DbAdapter();
         try
         {
             db.executeQuery(" SELECT psid,price,poundage,pounprice,times,member,performorders_id,seatnumber,type,pftime,weizhi FROM BouncePiao  WHERE orderdetails_id = " + orderdetails_id );
             if(db.next())
             {
            	 psid = db.getInt(1);
            	 price =db.getBigDecimal(2,2);
            	 poundage=db.getFloat(3);
            	 pounprice=db.getBigDecimal(4,2);
            	 times=db.getDate(5);
            	 member=db.getString(6);
            	 performorders_id=db.getString(7);
            	 seatnumber=db.getInt(8);
            	 type=db.getInt(9);
            	 pftime=db.getDate(10);
            	 weizhi=db.getString(11);
                 exist = true;
             } else
             {
                 exist = false;
             }
         } finally
         {
             db.close();
         }
    }
    
    public static void create(int orderdetails_id,int psid,java.math.BigDecimal price,float poundage,java.math.BigDecimal pounprice,String member,String performorders_id,int seatnumber,int type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("INSERT INTO BouncePiao (orderdetails_id,psid,price,poundage,pounprice,times,member,performorders_id,seatnumber,type ) VALUES ("+(orderdetails_id)+","+psid+","+price+"," +
            		" "+poundage+","+pounprice+","+db.cite(times)+","+db.cite(member)+","+db.cite(performorders_id)+","+(seatnumber)+","+type+" )");
        } finally
        {
            db.close();
        }
    }
    public  void set(int psid,java.math.BigDecimal price,float poundage,java.math.BigDecimal pounprice,String member,String performorders_id,int seatnumber ) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
        	 db.executeUpdate("UPDATE BouncePiao SET  psid="+psid+",price="+price+",poundage="+poundage+",pounprice="+pounprice+",member="+member+"," +
        	 		"performorders_id="+db.cite(performorders_id)+",seatnumber="+seatnumber+" WHERE orderdetails_id = " +orderdetails_id);
        } finally
        {
            db.close();
        }
    }
    
    public  void set(Date pftime,String weizhi) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
        	 db.executeUpdate("UPDATE BouncePiao SET  pftime="+db.cite(pftime)+",weizhi="+db.cite(weizhi)+"  WHERE orderdetails_id = " +orderdetails_id);
        } finally
        {
            db.close();
        }
    }
     
    public static Enumeration find(String sql,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT orderdetails_id FROM BouncePiao WHERE 1=1 " + sql,pos,size);
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
    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM  BouncePiao WHERE orderdetails_id = " + orderdetails_id);

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
            db.executeQuery("SELECT COUNT(orderdetails_id) FROM BouncePiao  WHERE 1= 1 "+ sql);
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

	public int getOrderdetails_id() {
		return orderdetails_id;
	}
 
	public int getPsid() {
		return psid;
	}

	public java.math.BigDecimal getPrice() {
		return price;
	}

	public float getPoundage() {
		return poundage;
	}

	public java.math.BigDecimal getPounprice() {
		return pounprice;
	}

	public Date getTimes() {
		return times;
	}

	public String getMember() {
		return member;
	}

	public String getPerformorders_id() {
		return performorders_id;
	}

	public boolean isExist() {
		return exist;
	}
	public int getSeatnumber()
	{
		return seatnumber;
	}
     public int getType()
     {
    	 return type;
     }
    public Date getPftime() {
    	return pftime;
	}
    public String getWeizhi()
    {
    	return weizhi;
    }
     
	
}
