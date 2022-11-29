package tea.entity.admin;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Payinstall extends Entity
{
    private int payid;
    private int pay; //线上支付的 id
    private String payname; //支付的名称
    private int paytype; //标示 线上 1， 还是线下，2
    private String merchant; //支付的商户号
    private String safety; //支付的安全码
    private String payeail; //支付的Eail
    private String paycontent; //支付的说明
    private String community; //社区
    private int usetype; //支付方式的使用状态 // 0 暂停使用，1 正在使用
    private String payurl; //支付方式要跳转的路径
    private String processurl; //自动处理信息的URL
    private String returnurl; //支付完成后跳转返回的URL
    
    private String usename;//在什么地方使用
    public static final String  USE_NAME [] = {"","商品","会员","电子报套餐","手机支付"};


    public static final String PAYNAME[] =
                                           {"","网银在线","支付宝","快钱","云网","首信易支付"};

    public Payinstall(int payid) throws SQLException
    {
        this.payid = payid;
        load();
    }

    public Payinstall(int pay,String pays) throws SQLException
    {
        this.pay = pay;
        payload();
    }

    public static Payinstall find(int payid) throws SQLException
    {
        return new Payinstall(payid);
    }

    public static Payinstall findpay(int pay) throws SQLException
    {
        return new Payinstall(pay,"");
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT pay,payname,paytype,merchant,safety,payeail,paycontent,community,usetype,payurl,processurl,returnurl,usename FROM Payinstall WHERE payid=" + payid);
            if(db.next())
            {
                pay = db.getInt(1);
                payname = db.getString(2);
                paytype = db.getInt(3);
                merchant = db.getString(4);
                safety = db.getString(5);
                payeail = db.getString(6);
                paycontent = db.getString(7);
                community = db.getString(8);
                usetype = db.getInt(9);
                payurl = db.getString(10);
                processurl = db.getString(11);
                returnurl = db.getString(12);
                usename=db.getString(13);
            }
        } finally
        {
            db.close();
        }
    }


    public void payload() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT payid pay,payname,paytype,merchant,safety,payeail,paycontent,community,usetype,payurl,processurl,returnurl,usename FROM Payinstall WHERE pay=" + pay);
            if(db.next())
            {
                pay = db.getInt(1);
                payname = db.getString(2);
                paytype = db.getInt(3);
                merchant = db.getString(4);
                safety = db.getString(5);
                payeail = db.getString(6);
                paycontent = db.getString(7);
                community = db.getString(8);
                usetype = db.getInt(9);
                payurl = db.getString(10);
                processurl = db.getString(11);
                returnurl = db.getString(12);
                usename=db.getString(13);
            }
        } finally
        {
            db.close();
        }
    }

    //线上
    public static void create(int pay,String payname,int paytype,String merchant,String safety,String payeail,String paycontent,String community,int usetype,String payurl,String processurl,String returnurl,String usename) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("INSERT INTO Payinstall(pay,payname,paytype,merchant,safety,payeail,paycontent,community,usetype,payurl,processurl,returnurl,usename) VALUES(" + pay + "," + db.cite(payname) + "," + paytype + "," + db.cite(merchant) + "," + db.cite(safety) + "," + db.cite(payeail) + "," + db.cite(paycontent) + "," + db.cite(community) + "," + usetype + " ," + db.cite(payurl) + "," + db.cite(processurl) + "," + db.cite(returnurl) + ","+db.cite(usename)+" )");
        } finally
        {
            db.close();
        }
    }

    //线下
    public static void create(String payname,String paycontent,String community,int paytype,int usetype,String usename) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("INSERT INTO Payinstall(payname,paycontent,community,paytype,usetype,usename) VALUES(" + db.cite(payname) + "," + db.cite(paycontent) + "," + db.cite(community) + "," + paytype + "," + usetype + ","+db.cite(usename)+" )");
        } finally
        {
            db.close();
        }
    }

    //线上
    public void set(int pay,String payname,int paytype,String merchant,String safety,String payeail,String paycontent,String community,String payurl,String processurl,String returnurl,String usename) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Payinstall SET pay=" + pay + ", payname=" + db.cite(payname) + " ,paytype=" + paytype + ",merchant=" + db.cite(merchant) + ",safety=" + db.cite(safety) + ",payeail=" + db.cite(payeail) + ",paycontent=" + db.cite(paycontent) + ",community=" + db.cite(community) + ",payurl=" + db.cite(payurl) + ",processurl=" + db.cite(processurl) + ",returnurl=" + db.cite(returnurl) + ",usename="+db.cite(usename)+" WHERE pay=" + pay);
        } finally
        {
            db.close();
        }
    }

    //线下
    public void set(String payname,String paycontent,String community,int paytype,String usename) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Payinstall SET usename="+db.cite(usename)+",  payname=" + db.cite(payname) + " ,paycontent=" + db.cite(paycontent) + ",community=" + db.cite(community) + ",paytype=" + paytype + " WHERE payid=" + payid);
        } finally
        {
            db.close();
        }
    }


//支付方式的使用状态
    public void set(int usetype,String str,int id) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Payinstall SET usetype=" + usetype + " WHERE " + str + " = " + id);
        } finally
        {
            db.close();
        }
    }

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT payid FROM Payinstall WHERE community=" + db.cite(community) + sql,pos,size);
          
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Payinstall WHERE payid=" + payid);
        } finally
        {
            db.close();
        }
    }

    public static boolean isPay(int pay) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        boolean fa = false;
        try
        {
            db.executeQuery("SELECT payid FROM Payinstall WHERE pay =" + pay);
            if(db.next())
            {
                fa = true;
            }
        } finally
        {
            db.close(); 
        }
        return fa;
    }
    //显示支付按钮
    public static String getPaybutton(String community,int usename,int poid)throws SQLException
    {
    	StringBuffer sp = new StringBuffer();
    	
    	
    		Enumeration e = tea.entity.admin.Payinstall.find(community," and paytype=1 and usetype =1 and usename like "+DbAdapter.cite("%/"+String.valueOf(usename)+"/%")+" ",0,20);
    		while(e.hasMoreElements())
    		{
    			int payid = ((Integer)e.nextElement()).intValue();
    			tea.entity.admin.Payinstall pobj = tea.entity.admin.Payinstall.find(payid);
    			Payinstall piobj = Payinstall.findpay(pobj.getPay()); 
    			  
    			//<input type=button value="首信易支付" onclick="window.open('/jsp/pay/newspaperbeijing/Send.jsp?community='+form1.community.value+'&pkorder='+form1.pkorder.value,'_blank');" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    			sp.append(" <input type=button id=payid_button"+payid+"  onclick =");//value=\""+Payinstall.PAYNAME[pobj.getPay()]+"\"
    			sp.append("f_button('"+piobj.getPayurl()+"?community="+community+"&poid="+poid+"&payid="+payid+"');");
    			sp.append(" >"); 
    		}
    		
    		sp.append("<script>");
    		sp.append(" function f_button(url){");
    		    sp.append(" document.getElementById('paybutton2_id').style.display=''; ");
    		    sp.append(" document.getElementById('Paybutton').style.display='none'; ");
    		    sp.append(" document.getElementById('Payment').style.display='none'; ");
	    		sp.append(" window.open(url,'_blank'); ");
				
    		sp.append("}");
    		sp.append("</script>");
    		
    	return sp.toString();
    	
    }
    public String getCommunity()
    {
        return community;
    }

    public String getMerchant()
    {
        return merchant;
    }

    public int getPay()
    {
        return pay;
    }

    public String getPaycontent()
    {
        return paycontent;
    }

    public String getPayeail()
    {
        return payeail;
    }

    public String getPayname()
    {
        return payname;
    }

    public int getPaytype()
    {
        return paytype;
    }

    public String getSafety()
    {
        return safety;
    }

    public int getPayid()
    {
        return payid;
    }

    public int getUsetype()
    {
        return usetype;
    }

    public String getPayurl()
    {
        return payurl;
    }

    public String getProcessurl()
    {
        return processurl;
    }

    public String getReturnurl()
    {
        return returnurl;
    }
    public String getUsename()
    {
    		return usename;
    }
}
