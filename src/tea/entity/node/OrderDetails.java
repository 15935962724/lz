package tea.entity.node;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.swetake.util.Qrcode;

import tea.db.*;
import tea.entity.*;
import tea.entity.member.Profile;
import tea.ui.TeaSession;

public class OrderDetails extends Entity
{
	private int orid;
	private int numbers;//座位编号
	private String performname;//演出名称
	private String psname;//场次名称
	private String pstime;//演出时间
	private String region;//演出区域
	private int linage;//排
	private int seat;//座号
	private java.math.BigDecimal price;//价格]
	private String orderid;//演出订单号
	private String community;

	private java.math.BigDecimal discountprice;//折扣价格
	//private float 	fare;//运费 
	private java.math.BigDecimal totalprice;//合计价格
	private int psid;//演出-场次id
	private String QRCode;//二维码地址
	
	private boolean exist; //

	public OrderDetails(int orid) throws SQLException
    {
        this.orid = orid;
        load();
    }

    public static OrderDetails find(int orid) throws SQLException
    {
        return new OrderDetails(orid);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT numbers,performname,psname,pstime,region,linage,seat,price,orderid,community,discountprice,totalprice,psid,QRCode  FROM OrderDetails  WHERE orid = " + orid);
            if(db.next())
            {
            	numbers=db.getInt(1);
            	performname=db.getString(2);
            	psname=db.getString(3);
            	pstime=db.getString(4);
            	region=db.getString(5);
            	linage=db.getInt(6);
            	seat=db.getInt(7);
            	price=db.getBigDecimal(8,2);
            	orderid=db.getString(9);
            	community=db.getString(10);
            	discountprice=db.getBigDecimal(11,2);
            
            	totalprice=db.getBigDecimal(12,2);
            	psid=db.getInt(13);
            	QRCode=db.getString(14);
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

    public static int create(int numbers,String performname,String psname,String pstime,String region,int linage,int seat,java.math.BigDecimal price,String orderid,String community,int psid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int id = 0;
        try
        {
            db.executeUpdate("INSERT INTO OrderDetails (numbers,performname,psname,pstime,region,linage,seat,price,orderid,community,psid) " +
            		" VALUES ("+numbers+", "+db.cite(performname)+","+db.cite(psname)+","+db.cite(pstime)+","+db.cite(region)+","+linage+","+seat+","+(price)+","+db.cite(orderid)+","+db.cite(community)+","+psid+" )");
	       	 db.executeQuery("Select SCOPE_IDENTITY()  as orid");
			 if(db.next())
			 {
			  id= db.getInt(1);
			 }
        } finally 
        {
            db.close();
        }
        return id;
    }
    public  void set(int numbers,String performname,String psname,String pstime,String region,int linage,int seat,java.math.BigDecimal price,String orderid ) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
        	 db.executeUpdate("UPDATE OrderDetails SET numbers="+numbers+",performname="+db.cite(performname)+",psname="+db.cite(psname)+",pstime="+db.cite(pstime)+" ," +
        	 		" region="+db.cite(region)+",linage="+linage+",seat="+seat+" ,price="+price+",orderid="+db.cite(orderid)+"  WHERE orid = " +orid);
        } finally
        {
            db.close();
        }
    }
    public  void set(java.math.BigDecimal discountprice,java.math.BigDecimal totalprice) throws SQLException
    {
        DbAdapter db = new DbAdapter();

        try
        {
        	 db.executeUpdate("UPDATE OrderDetails SET discountprice="+discountprice+",totalprice="+totalprice+" WHERE orid = " +orid);
        } finally
        {
            db.close();
        }
    }
    //添加二维码
    
    public  void set(String QRCode) throws SQLException
    {
        DbAdapter db = new DbAdapter();

        try
        {
        	 db.executeUpdate("UPDATE OrderDetails SET QRCode="+db.cite(QRCode)+"  WHERE orid = " +orid);
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
            db.executeQuery("SELECT orid FROM OrderDetails WHERE community= " + db.cite(community) + sql,pos,size);
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
    //演出和座位票表
    public static Enumeration find2(String community,String sql,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select od.orid from PerformOrders po,OrderDetails od WHERE po.ordersid=od.orderid AND od.community= " + db.cite(community) + sql,pos,size);
            while(db.next())
            { 
                vector.add(db.getInt(1));
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
            db.executeUpdate("DELETE FROM  OrderDetails WHERE orid = " +orid);

        } finally
        {
            db.close();
        }
    }
    //删除订单的细节
    public static void delete (String ordersid)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM  OrderDetails WHERE orderid = " +DbAdapter.cite(ordersid));
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
            db.executeQuery("SELECT COUNT(orid) FROM OrderDetails  WHERE community=" + db.cite(community) + sql);
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
    public static int count2(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
           // db.executeQuery("SELECT COUNT(ordersid) FROM PerformOrders  WHERE community=" + db.cite(community) + sql);
            db.executeQuery("select COUNT(od.orid) from PerformOrders po,OrderDetails od WHERE po.ordersid=od.orderid AND od.community= " + db.cite(community) + sql);
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
    //获取订单的总金额
    public static java.math.BigDecimal getTotalprice(String orderid) throws SQLException
    {
    	DbAdapter db = new DbAdapter();
    	java.math.BigDecimal p = new java.math.BigDecimal("0");
    	try{
    		db.executeQuery("SELECT price FROM OrderDetails WHERE orderid ="+db.cite(orderid));
    		while(db.next())
    		{
    			p = p.add(db.getBigDecimal(1,2));
    		}
    	}finally{
    		db.close();
    	}
    	return p.setScale(0,BigDecimal.ROUND_HALF_UP);
    }
    public static java.math.BigDecimal getTotalprice(String orderid,String member) throws SQLException
    {
    	DbAdapter db = new DbAdapter();
    	java.math.BigDecimal p = new java.math.BigDecimal("0");
    	try{
    		db.executeQuery("SELECT price FROM OrderDetails WHERE orderid ="+db.cite(orderid));
    		while(db.next())
    		{
    			java.math.BigDecimal price = db.getBigDecimal(1,2);

    			if(Profile.isExisted(member))//打折
    			{
    				price = price.multiply(new BigDecimal("0.9"));
					//price =
    			}

    			p = p.add(price);
    		}
    	}finally{
    		db.close();
    	}
		//p= p.add(new BigDecimal(fare));
    	return p.setScale(0,BigDecimal.ROUND_HALF_UP);
    }
    //判断座位是否选中
    public static boolean isPitchon(int psid,int numbers)throws SQLException
    {
    	boolean f = false;
    	DbAdapter db = new DbAdapter();
    	try{
    		db.executeQuery("SELECT orid FROM OrderDetails WHERE psid ="+psid+" AND  numbers = "+numbers);
    		if(db.next())
    		{
    			f = true;
    		}
    	}finally
    	{
    		db.close();
    	}
    	return f;
    }
    //生产二维码
    public String getQRCodeImgUrl(String content,int odid,String community,String surlString)throws SQLException
    {
    	String url = null;
		int size = 100;
		byte[] d = content.getBytes();
		
		int ver = 1;
		ver = d.length / 10 + 1;
		char err = 'L';
	
		// /////以上是参数/////////////////////////////////////////
		Qrcode x = new Qrcode();
		x.setQrcodeErrorCorrect(err); // 纠错级别:M-中,L-低,Q-高,H-最高
		x.setQrcodeEncodeMode('B');
		x.setQrcodeVersion(ver); // 模块大小:1-7

		boolean[][] s = x.calQrcode(d);
		int b = 1;
		if (size < s.length)
		{
			size = s.length;
		} else
		{
			b = size / s.length;
			if (size % s.length != 0)
			{
				size = s.length * b;
			}
		}  
		BufferedImage image = new BufferedImage(size, size, BufferedImage.TYPE_INT_RGB);
		Graphics g = image.getGraphics();
		g.setColor(Color.WHITE);
		g.fillRect(0, 0, size, size);
		g.setColor(Color.BLACK);
		// if (d.length > 0 && d.length < 120)
		{
			for (int i = 0; i < s.length; i++)
			{
				for (int j = 0; j < s.length; j++)
				{
					if (s[j][i])
					{
						g.fillRect(j * b, i * b, b, b);
					}
				}
			}
		}
		g.dispose();
		try {
		
			/*创建一个图片 */
			File f = new File(surlString+"\\res\\"+community+"\\QRCodeImg\\"+odid+".jpg");
	         if(!f.exists()){
	               f.createNewFile();
	         }  
	         ImageIO.write(image, "BMP", f);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		url = "/res/"+community+"/QRCodeImg/"+odid+".jpg";
		System.out.println("二维码创建成功!");
    	return url;
    } 

	public int getNumbers()
	{
		return numbers;
	}

	public String getPerformname()
	{
		return performname;
	}

	public String getPsname()
	{
		return psname;
	}

	public String getPstime()
	{
		return pstime;
	}

	public String getRegion()
	{
		return region;
	}

	public int getLinage()
	{
		return linage;
	}

	public int getSeat()
	{
		return seat;
	}

	public java.math.BigDecimal getPrice()
	{
		return price;
	}

	public String getOrderid()
	{
		return orderid;
	}

	public boolean isExist()
	{
		return exist;
	}
	public String getCommunity()
	{
		return community;
	}

	public java.math.BigDecimal getDiscountprice()
	{
		return discountprice;
	}



	public java.math.BigDecimal getTotalprice()
	{
		return totalprice;
	}
    public int getPsid()
    {
    	return psid;
    }
    public String getQRCode()
    {
    	return QRCode;
    }

}
