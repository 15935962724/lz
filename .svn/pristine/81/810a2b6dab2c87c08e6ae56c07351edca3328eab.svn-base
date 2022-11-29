
package tea.entity.admin.mov;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.Entity;
import tea.entity.admin.orthonline.ProfileOrth;
import tea.entity.member.Profile;
import tea.ui.TeaSession;


public class MemberOrder extends Entity
{
    private String memberorder; //订单id
    private int membertype;
    private int payid;
    private Date times;
    private String member;
    private String community;
    private int verifg; //审核标志 0为没有审核，1为审核通过,2为审核没有通过,3为这个用户不需要审核的
    private int webverifg; //通过网上支付 成功后返回的数值，0为没有支付，1为支付成功
    private int paymode; //支付方式
    private Date becometime; //到期日期--阅读有效期
    private int servicetype; //暂停 和启动服务标示 0启动服务，1 暂停服务
    private String role; //角色权限
    private int period;//会员的减去的积分
    private Date verifgtime;//审核日期
    private int servicetypenumber;//会员锁定次数
    
    private int newsletter;//是否订阅电子报 0 否，1 是
    private int abstracts;//是否订阅学术论文摘要 0 否，1 是
    
    private java.math.BigDecimal remittance;//汇款金额
    private String invoiceremarks;//发票备注 
    private int invoicetype;//发票状态 0,不需要，1，未寄，2，已寄
    private int remtype;//汇款方式   0 邮局,1 银行
    private int proxymembertype;//是否有代理会员
    private String proxymember;//代理会员id
    private int proxymembertype2;//是否是代理 0 不是，1 是代理
     
    private int playmoneytype;//是否打款     0 没有打款，1 代理会员确认的，2 管理员确认成功
    
    private String ip;
    
    public static final String INVOICE_TYPE[]={"不需要","未寄","已寄"};
    public static final String REM_TYPE[]={"邮局","银行","代理人"};
    public static final String PROXYMEMBER_TYPE [] ={"自己注册","会员代理"}; //Proxy
    
    
      
    
    private static final java.text.SimpleDateFormat ymd = new java.text.SimpleDateFormat("yyyyMMdd");

    public MemberOrder(String memberorder) throws SQLException
    {
        this.memberorder = memberorder;
        load();

    }

    public static MemberOrder find(String memberorder) throws SQLException
    {
        return new MemberOrder(memberorder);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT membertype,payid,times,member,community,verifg,webverifg,paymode,becometime," +
            		"servicetype,role,period,verifgtime,servicetypenumber,newsletter,abstracts,remittance,invoiceremarks,invoicetype," +
            		"remtype,proxymembertype,proxymember,proxymembertype2,playmoneytype,ip FROM MemberOrder WHERE memberorder=" + db.cite(memberorder));
            if(db.next())
            {
                membertype = db.getInt(1);
                payid = db.getInt(2);
                times = db.getDate(3);
                member = db.getString(4);
                community = db.getString(5);
                verifg = db.getInt(6);
                webverifg = db.getInt(7);
                paymode = db.getInt(8);
                becometime = db.getDate(9);
                servicetype = db.getInt(10);
                role = db.getString(11);
                period=db.getInt(12);
                verifgtime=db.getDate(13);
                servicetypenumber=db.getInt(14);
                newsletter=db.getInt(15);
                abstracts=db.getInt(16);
                remittance=db.getBigDecimal(17, 2);
                invoiceremarks=db.getString(18);
                invoicetype=db.getInt(19);
                remtype=db.getInt(20);
                proxymembertype=db.getInt(21);
                proxymember=db.getString(22);
                proxymembertype2=db.getInt(23);
                playmoneytype=db.getInt(24);
                ip = db.getString(25);
            }
        } finally
        {
            db.close();
        }
    }
 
    public static void create(int membertype,int payid,String member,String community,int verifg,int webverifg,int paymode) throws SQLException
    {
        DbAdapter db = new DbAdapter();

        Date times = new Date();
        String memberorder = ymd.format(times) + tea.entity.SeqTable.getSeqNo("MemberOrder");
        int servicetype = 0;

        try
        {
            db.executeUpdate("INSERT INTO MemberOrder(memberorder,membertype,payid,times,member,community,verifg,webverifg,paymode,servicetype) VALUES(" + db.cite(memberorder) + "," + (membertype) + "," + (payid) + "," + db.cite(times) + "," + db.cite(member) + "," + db.cite(community) + "," + verifg + "," + webverifg + "," + paymode + "," + servicetype + "  )");
           
        
        } finally
        {
            db.close();
        }

    }

    public void set(int membertype,int payid,String member,String community,int verifg,int webverifg,int paymode) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE MemberOrder SET membertype=" + membertype + ", payid=" + payid + " ,member=" + db.cite(member) + ",community=" + db.cite(community) + "," +
            		"verifg=" + verifg + ",webverifg=" + webverifg + ",paymode=" + paymode + " WHERE memberorder=" + db.cite(memberorder));
        } finally
        {
            db.close();
        }
    }

//添加到期日期
    public void setBecometime(Date becometime) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE MemberOrder SET becometime=" + db.cite(becometime) + " WHERE   memberorder= " + db.cite(memberorder));

        } finally
        {
            db.close();
        }
    }
    public void setIp(String ip)throws SQLException
    {
    	 DbAdapter db = new DbAdapter();
         try
         {
             db.executeUpdate("UPDATE MemberOrder SET ip=" + db.cite(ip) + " WHERE   memberorder= " + db.cite(memberorder));

         } finally
         {
             db.close();
         }
    }
    // 修改汇款方式
    public void setRemtype(int remtype)throws SQLException
    {
    	DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE MemberOrder SET remtype=" + remtype + " WHERE   memberorder= " + db.cite(memberorder));
        } finally
        {
            db.close();
        }
    }
    //修改是否代理会员状态
    public void setProxymembertype(int proxymembertype)throws SQLException
    {
    	DbAdapter db = new DbAdapter();
    	try
    	{
    		db.executeUpdate("UPDATE MemberOrder SET proxymembertype="+proxymembertype+" WHERE  memberorder = "+db.cite(memberorder));
    	}finally
    	{
    		db.close();
    	}
    }
    public void setProxymembertype2(int proxymembertype2)throws SQLException
    {
    	DbAdapter db = new DbAdapter();
    	try
    	{
    		db.executeUpdate("UPDATE MemberOrder SET proxymembertype2="+proxymembertype2+" WHERE  memberorder = "+db.cite(memberorder));
    	}finally
    	{
    		db.close();
    	}
    }
    public void setPlaymoneytype(int playmoneytype)throws SQLException
    {
    	DbAdapter db = new DbAdapter();
    	try
    	{
    		db.executeUpdate("UPDATE MemberOrder SET playmoneytype="+playmoneytype+" WHERE  memberorder = "+db.cite(memberorder));
    	}finally
    	{
    		db.close();
    	}
    }
    //修改代理会员ID
    public void setProxymember(String proxymember)throws SQLException
    { 
    	DbAdapter db = new DbAdapter();
    	try
    	{
    		db.executeUpdate("UPDATE MemberOrder SET proxymember="+db.cite(proxymember)+" WHERE  memberorder = "+db.cite(memberorder));
    	}finally
    	{ 
    		db.close();
    	}
    }
    //是否订阅电子报
    public void setNewsletter(int newsletter)throws SQLException
    {
         DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE MemberOrder SET newsletter=" + newsletter + " WHERE   memberorder= " + db.cite(memberorder));
            

        } finally
        {
            db.close();
        }
    }
       //是否订阅学术论文摘要
    public void setAbstracts(int abstracts)throws SQLException
    {
         DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE MemberOrder SET abstracts=" + abstracts + " WHERE   memberorder= " + db.cite(memberorder));
            
        } finally
        {
            db.close();
        } 
    }

    public void setTime(Date time )throws SQLException
    {
         DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE MemberOrder SET times=" + db.cite(time) + " WHERE   memberorder= " + db.cite(memberorder));
            
        } finally
        {
            db.close();
        }
    }
//添加 审核状态
    public void setVerifg(int verifg) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE MemberOrder SET verifg=" + verifg + " WHERE   memberorder= " + db.cite(memberorder));
        } finally
        {
            db.close();
        }
    }

    //修改会员类型
    public void setMembertype(int membertype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE MemberOrder SET membertype=" + membertype + " WHERE   memberorder= " + db.cite(memberorder));
        } finally
        {
            db.close();
        }

    }

    public void setPeriod(int period) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE MemberOrder SET period=" + period + " WHERE   memberorder= " + db.cite(memberorder));
        } finally
        {
            db.close();
        }

    }
    public void setVerifgtime(Date verifgtime)throws SQLException
    {
    	  DbAdapter db = new DbAdapter();
          try
          {
              db.executeUpdate("UPDATE MemberOrder SET verifgtime=" + db.cite(verifgtime) + " WHERE   memberorder= " + db.cite(memberorder));
          } finally
          {
              db.close();
          }
    }
    //修改 是否有公司数值
    public void setType(int type)throws SQLException
    {
        DbAdapter db = new DbAdapter();
       try
       {
           db.executeUpdate("UPDATE MemberOrder SET type=" + type + " WHERE   memberorder= " + db.cite(memberorder));
       } finally
       {
           db.close();
       }

    }

    //添加角色
    public void setRole(String role) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE MemberOrder SET role=" + db.cite(role) + " WHERE   memberorder= " + db.cite(memberorder));
        } finally
        {
            db.close();
        }

    }


//修改暂停和启动服务的

    public void setServicetype(int servicetype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE MemberOrder SET servicetype=" + servicetype + " WHERE   memberorder= " + db.cite(memberorder));
        } finally
        {
            db.close();
        }

    }
    //修改锁定次数
    public void setServicetypenumber(int servicetypenumber)throws SQLException
    {
    	 DbAdapter db = new DbAdapter();
         try
         {
             db.executeUpdate("UPDATE MemberOrder SET servicetypenumber=" + servicetypenumber + " WHERE   memberorder= " + db.cite(memberorder));
         } finally
         {
             db.close();
         }
    }

    //如果会员类型已经暂停了，测要删除没有审核的会员订单
    public static void DELETETYPE() throws SQLException
   {
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeUpdate("DELETE FROM MemberOrder WHERE verifg = 0");
       } finally
       {
           db.close();
       }
   }

    //添加payid支付金额
    public void setPayid(int payid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE MemberOrder SET payid=" + payid + " WHERE memberorder=" + db.cite(memberorder));
        } finally
        {
            db.close();
        }
    }

    //添加支付方式
    public void setPaymode(int paymode) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE MemberOrder SET paymode=" + paymode + " WHERE memberorder=" + db.cite(memberorder));
        } finally
        {
            db.close();
        }
    }
    //修改发票信息
    public void setInvoice(java.math.BigDecimal remittance,String invoiceremarks,int invoicetype)throws SQLException
    {
    	 DbAdapter db = new DbAdapter();
         try
         {
             db.executeUpdate("UPDATE MemberOrder SET remittance=" + remittance + ",invoiceremarks="+db.cite(invoiceremarks)+",invoicetype="+invoicetype+" WHERE memberorder=" + db.cite(memberorder));
         } finally
         { 
             db.close();
         }
    }
    //邮寄发票状态修改
    public void setInvoice(int invoicetype)throws SQLException
    {
    	 DbAdapter db = new DbAdapter();
         try
         {
             db.executeUpdate("UPDATE MemberOrder SET invoicetype="+invoicetype+" WHERE memberorder=" +db.cite(memberorder));
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
            db.executeQuery("SELECT memberorder FROM MemberOrder WHERE community=" + db.cite(community) + sql,pos,size);
            while(db.next())
            {
                v.addElement(new String(db.getString(1)));
            }

        } finally
        {
            db.close();
        }
        return v.elements();
    }
    public static Enumeration findMP(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT m.memberorder FROM MemberOrder m,Profile p WHERE m.member=p.member and  m.community=" + db.cite(community) + sql,pos,size);
           // System.out.println("SELECT m.memberorder FROM MemberOrder m,Profile p WHERE m.member=p.member and  m.community=" + db.cite(community));

            while(db.next())
            {
                v.addElement(new String(db.getString(1)));
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
            db.executeUpdate("DELETE FROM MemberOrder WHERE memberorder=" + db.cite(memberorder));
        } finally
        {
            db.close();
        }
    }

    ///根据membertype 字段删除所有相关数据
    public static void delete(int membertype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM MemberOrder WHERE membertype=" + membertype);
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
            count = db.getInt("SELECT COUNT(memberorder) FROM MemberOrder WHERE community=" + DbAdapter.cite(community) + sql);
        } finally
        {
            db.close();
        }
        return count;
    }
    public static int countMP(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            count = db.getInt("SELECT COUNT(m.memberorder) FROM MemberOrder m,Profile p WHERE m.member=p.member and m.community=" + DbAdapter.cite(community) + sql);
        } finally
        {
            db.close();
        }
        return count;
    }
    public static java.math.BigDecimal countRemittance(String community,String sql) throws SQLException
    {
        java.math.BigDecimal count = new java.math.BigDecimal("0");
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT SUM(m.remittance) FROM MemberOrder m,Profile p WHERE m.member=p.member and m.community=" + DbAdapter.cite(community) + sql);
          //  System.out.println("SELECT SUM(m.remittance) FROM MemberOrder m,Profile p WHERE m.member=p.member and m.community=" + DbAdapter.cite(community) + sql);
            if(db.next())
            {
            	count = db.getBigDecimal(1, 2);
            }
        } finally
        {
            db.close();
        }
        return count;
    }
    
    
    public static java.math.BigDecimal countRemittance(String community,String sql,String srt) throws SQLException
    {
        java.math.BigDecimal count = new java.math.BigDecimal("0.00");
        DbAdapter db = new DbAdapter();
        try
        {
        	
        	 java.util.Enumeration e = MemberOrder.findMP(community,sql,0,Integer.MAX_VALUE);
    		
        	for(int i=1;e.hasMoreElements();i++)
        	{
        		String memberorder =((String)e.nextElement());
        	    MemberOrder  moobj = MemberOrder.find(memberorder);
        	    Profile pobj = Profile.find(moobj.getMember());
        	    MemberType mtobj = MemberType.find(moobj.getMembertype());
        	    
        	    db.executeQuery("SELECT SUM(m.remittance) FROM MemberOrder m,Profile p WHERE m.member=p.member and m.community=" + DbAdapter.cite(community) + srt +" and proxymember ="+DbAdapter.cite(moobj.getMember()));
        	   // System.out.println("SELECT SUM(m.remittance) FROM MemberOrder m,Profile p WHERE m.member=p.member and m.community=" + DbAdapter.cite(community) + srt +" and proxymember ="+DbAdapter.cite(moobj.getMember()));
        	    if(db.next())
                {
        	    	//System.out.println(db.getBigDecimal(1, 2));
        	    	count = count.add(db.getBigDecimal(1, 2));
                }
        	} 
            
        } finally
        {
            db.close();
        }
        return count;
    }

    
    //统计人数
    public static int count(String community,String sql,String srt) throws SQLException
    {
        int count =0;
        DbAdapter db = new DbAdapter();
        try
        {
        	
        	 java.util.Enumeration e = MemberOrder.findMP(community,sql,0,Integer.MAX_VALUE);
    		
        	for(int i=1;e.hasMoreElements();i++)
        	{
        		String memberorder =((String)e.nextElement());
        	    MemberOrder  moobj = MemberOrder.find(memberorder);
        	    Profile pobj = Profile.find(moobj.getMember());
        	    MemberType mtobj = MemberType.find(moobj.getMembertype());
        	    
        	    db.executeQuery("SELECT count(*) FROM MemberOrder m,Profile p WHERE m.member=p.member and m.community=" + DbAdapter.cite(community) + srt +" and proxymember ="+DbAdapter.cite(moobj.getMember()));
        	   // System.out.println("SELECT SUM(m.remittance) FROM MemberOrder m,Profile p WHERE m.member=p.member and m.community=" + DbAdapter.cite(community) + srt +" and proxymember ="+DbAdapter.cite(moobj.getMember()));
        	    if(db.next())
                {
        	    	//System.out.println(db.getBigDecimal(1, 2));
        	    	count = count+db.getInt(1);
                }
        	} 
            
        } finally
        {
            db.close();
        }
        return count; 
    }
    
    
    
    public static boolean isMemberOrder(String community,int membertype,int payid,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        boolean fa = false;
        try
        {
            db.executeQuery("SELECT memberorder FROM MemberOrder WHERE community=" + DbAdapter.cite(community) + " AND  member=" + db.cite(member) + " AND membertype=" + membertype + " AND payid =" + payid);
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

    //判断审核标示是否存在
    public static String getMemberTypeSQL(String community,String member,int verifg) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        StringBuffer sp = new StringBuffer();
        try
        {
            db.executeQuery("SELECT membertype FROM MemberOrder WHERE community=" + db.cite(community) + " AND verifg = " + verifg + " AND member= " + db.cite(member));
            while(db.next())
            {
                sp.append(" AND membertype!=").append(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return sp.toString();
    }

    public static String getMemberOrder(String community,int membertype,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        String str = "0";
        try
        {
            db.executeQuery("SELECT memberorder FROM MemberOrder WHERE community=" + DbAdapter.cite(community) + " AND member=" + db.cite(member) + " AND membertype=" + membertype);
            if(db.next())
            {
                str = db.getString(1);
            }
        } finally
        {
            db.close();
        }
        return str;
    }
    
    public static String getMemberOrder(String community,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        String str = "0";
        try
        {
            db.executeQuery("SELECT memberorder FROM MemberOrder WHERE community=" + DbAdapter.cite(community) + " AND member=" + db.cite(member) );
            if(db.next())
            {
                str = db.getString(1);
            }
        } finally
        {
            db.close();
        }
        return str;
    }
    
    
    
    
    public static int getMemberType(String community,String member)throws SQLException
    {
    	DbAdapter db = new DbAdapter();
        int str = 0;
        try
        {
            db.executeQuery("SELECT membertype FROM MemberOrder WHERE community=" + DbAdapter.cite(community) + " AND member=" + db.cite(member));
            if(db.next())
            {
                str = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return str;
    }

//查找用户的审核状态，并返回INT 数值
    public static int getVerifg(String community,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int v = 0;
        try
        {
            db.executeQuery("SELECT verifg FROM MemberOrder WHERE   community =" + db.cite(community) + " AND member =" + db.cite(member));
            if(db.next())
            {
                v = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return v;
    }

    //判断用户的 服务是否启动，如果为1 则是停止的该用户的服务
    public static int getServiceType(String community,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int v = 0; 
        try
        {
            db.executeQuery("SELECT servicetype FROM MemberOrder WHERE   community =" + db.cite(community) + " AND member =" + db.cite(member));
            if(db.next())
            {
                v = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return v;

    }
    //英文网发送邮件
    public static void send(TeaSession teasession,Profile pobj) throws SQLException,NoSuchAlgorithmException,UnsupportedEncodingException
    { 
    	String sn=teasession.getRequest().getRequestURL().toString();
        sn=sn.substring(0,sn.indexOf("/",9));
        String user = pobj.getMember();
        int membertype = MemberOrder.getMemberType(pobj.getCommunity(),user);
        String dig = ProfileOrth.md5(pobj.getMember() + pobj.getTime().getTime()); 
        String affirm = sn + "/jsp/user/ValidateProfile_en.jsp?community=" + teasession._strCommunity + "&membertype="+membertype+"&member=" + java.net.URLEncoder.encode(user,"UTF-8") + "&validate=" + dig + "&validate2=" + System.currentTimeMillis();
        //发送邮件
        //发送邮件  
   	   String subject = "Activation e-mail from womenofchina.cn";//主题
   	   String conent = "Dear<font color=red><b>"+user+"</b></font>:<br>";
   	   conent =conent+"Thank you for registration.<br>";
   	   //"<A href=\""+affirm+"&affirm=ON\">"+affirm+"&affirm=ON</A>
   		conent = conent + "To activate your account and log-in to womenofchina.cn simply click on<br> ";
   		conent = conent + "<A href=\""+affirm+"&affirm=ON\">";
   		conent = conent + ""+affirm+"&affirm=ON";
   		conent = conent + "</A><br> or cut and paste it to your web browser.<br>"; 
   		conent = conent + "After activating your account, use your sign-in name and password to log in.<br> "; 
   	   
   	    
   	   conent =conent+"Your sign-in name:<font color=red>"+user+"</font>.<br>";
   	   conent =conent+"Password:<font color=red>"+pobj.getPassword()+"</font>.<br>";
   	   conent =conent+"Best regards<br>";
   	   conent =conent+"womenofchina.cn"; 
   	     
   	   //rstr 
   	   try 
         {
   		   
             tea.service.SendEmaily se = new tea.service.SendEmaily(teasession._strCommunity);
             se.sendEmail(pobj.getEmail(),subject,conent);//p.getEmail() 
            
         } catch(Exception _ex)
         {
           _ex.printStackTrace();
         }
      
    }
    public String getCommunity()
    {
        return community;
    }

    public String getMember()
    {
        return member;
    }

    public int getMembertype()
    {
        return membertype;
    }

    public int getPayid()
    {
        return payid;
    }

    public Date getTimes()
    {
        return times;
    }

    public String getTimesToString()
    {
        if(times == null)
        {
            return "";
        }
        return sdf.format(times);
    }

    public int getVerifg()
    {
        return verifg;
    }

    public int getWebverifg()
    {
        return webverifg;
    }

    public int getPaymode()
    {
        return paymode;
    }

    public int getServicetype()
    {
        return servicetype;
    }

    public String getRole()
    {
        return role;
    }
    public int getPeriod()
    {
    	return period;
    }
    public Date getVerifgtime()
    {
    	return verifgtime;
    }
    public Date getBecometime()
    {
    	return becometime;
    }
    public String getIp()
    {
    	return ip;
    }
    public int getServicetypenumber()
    {
    	return servicetypenumber;
    }
     public int getNewsletter()
    {
    	return newsletter;
    }
    public int getAbstracts()
    {
    	return abstracts;
    }

	public java.math.BigDecimal getRemittance() {
		return remittance;
	}

	public String getInvoiceremarks() {
		return invoiceremarks;
	}

	public int getInvoicetype() {
		return invoicetype;
	}
	public int getRemtype()
	{
		return remtype;
	}
	public int getProxymembertype()
	{
		return proxymembertype;
	}
	public String getProxymember()
	{
		return proxymember;
	}
	public int getProxymembertype2()
	{
		return proxymembertype2;
	}
	public int getPlaymoneytype()
	{
		return playmoneytype;
	}
    
}
