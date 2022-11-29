package tea.entity.admin.mov;

import java.math.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class RegisterInstall extends Entity
{
//    /private int raid; //主键
    private int clause; //是否需要条款声明
    private String register; //注册信息选项
    private int restrictions; //用户名限制
    private int related; //是否关联填写类别信息 是否值
    private int relatednews; //是否关联填写类别信息 关联的信息
    private int fathernode; //存放关联类别的 node节点
    private String buttonurl; //生成注册按钮路径
    private int verify; //是否需要审核
    private String menuurl; //生成审核菜单路径
    private String member; //
    private String community; //
    private Date times; //
    private int membertype; //会员类型表的ID
    private String inspect; //注册信息选项 是否验证
    private int payment; //是否缴费 
    private java.math.BigDecimal paymoney; //缴费金额
    private int paytime; //缴费期限
    private String paycontent; //缴费说明
    public static final String PAY_TIME[] =
                                            {"---------","一年","两年","三年","四年","一次交五年"};

    public RegisterInstall(int membertype) throws SQLException
    {
        this.membertype = membertype;
        load();
    }

    public static RegisterInstall find(int membertype) throws SQLException
    {
        return new RegisterInstall(membertype);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT clause,register,restrictions,related,relatednews,buttonurl,verify,menuurl,member,community,times,membertype,inspect,payment,paymoney,paytime,paycontent,fathernode FROM RegisterInstall WHERE membertype=" + membertype);
            if(db.next())
            {
                clause = db.getInt(1);
                register = db.getString(2);
                restrictions = db.getInt(3);
                related = db.getInt(4);
                relatednews = db.getInt(5);
                buttonurl = db.getString(6);
                verify = db.getInt(7);
                menuurl = db.getString(8);
                member = db.getString(9);
                community = db.getString(10);
                times = db.getDate(11);
                membertype = db.getInt(12);
                inspect = db.getString(13);
                payment = db.getInt(14);
                paymoney = db.getBigDecimal(15,2);
                paytime = db.getInt(16);
                paycontent = db.getString(17);
                fathernode = db.getInt(18);
            }
        } finally
        {
            db.close();
        }
    }


    public static void create(int clause,String register,int restrictions,int related,int relatednews,String buttonurl,int verify,String menuurl,String member,String community,int membertype,String inspect,int payment,java.math.BigDecimal paymoney,int paytime,String paycontent,int fathernode) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("INSERT INTO RegisterInstall(clause,register,restrictions,related,relatednews,buttonurl,verify,menuurl,member,community,times,membertype,inspect,payment,paymoney,paytime,paycontent,fathernode) VALUES(" + clause + "," + db.cite(register) + "," + restrictions + "," + related + "," + (relatednews) + "," + db.cite(buttonurl) + "," + verify + "," + db.cite(menuurl) + "," + db.cite(member) + "," + db.cite(community) + "," + db.cite(times) + "," + membertype + "," + db.cite(inspect) + "," + payment + "," + (paymoney) + "," + paytime + "," + db.cite(paycontent) + " ," + fathernode + " )");
        } finally
        {
            db.close();
        }
    }

    public void set(int clause,String register,int restrictions,int related,int relatednews,String buttonurl,int verify,String menuurl,String member,String community,String inspect,
    		int payment,java.math.BigDecimal paymoney,int paytime,String paycontent,int fathernode) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE RegisterInstall SET clause=" + clause + ", register=" + db.cite(register) + " ,restrictions=" + restrictions + ",related=" + related + ",relatednews=" + (relatednews) + ",buttonurl=" + db.cite(buttonurl) + " ,verify=" + verify + ",menuurl=" + db.cite(menuurl) + ",member=" + db.cite(member) + ",community=" + db.cite(community) + ",inspect=" + db.cite(inspect) + ",payment=" + payment + ",paymoney=" + paymoney + ",paytime=" + paytime + ",paycontent=" + db.cite(paycontent) + ",fathernode=" + fathernode + "  WHERE membertype=" + membertype);
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
            db.executeQuery("SELECT membertype FROM RegisterInstall WHERE community=" + db.cite(community) + sql,pos,size);
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
            db.executeUpdate("DELETE FROM RegisterInstall WHERE membertype=" + membertype);
        } finally
        {
            db.close();
        }
    }

    public boolean isMemberType() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        boolean fa = false;
        try
        {
            db.executeQuery("SELECT membertype FROM RegisterInstall WHERE membertype=" + membertype);
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

    public boolean isInspect(String value) throws SQLException
    {
        boolean fa = false;
        if(this.getInspect() != null && this.getInspect().indexOf(value) != -1)
        {
            fa = true;
        }
        return fa;

    }

    public boolean isRegister(String value) throws SQLException
    {
        boolean fa = false;
        if(this.getRegister() != null && this.getRegister().indexOf(value) != -1)
        {
            fa = true;
        }
        return fa;

    }

    //注册导航
    public static String getNavigation(int membertype,int language) throws SQLException
    {
        RegisterInstall riobj = RegisterInstall.find(membertype);
        StringBuffer sp = new StringBuffer();
        sp.append("<div>");
        
	   if( MemberType.count(riobj.getCommunity(),"")>1)
	   {
           sp.append("<span class=lzj_zcbt>选择会员类型</span>");
       }
        if(riobj.getClause() == 1)
        {
            sp.append(" <span class=lzj_zcbt>服务条款</span>");
        }
        sp.append("<span class=lzj_zcbt>注册会员信息</span>");
        if(riobj.getRelated() == 1)
        {
            if(riobj.getRelatednews() == 21)
            {
                sp.append("<span class=lzj_zcbt>填写公司信息</span>");
            } else
            {
                tea.entity.site.Dynamic d = tea.entity.site.Dynamic.find(riobj.getRelatednews());
                sp.append("<span class=lzj_zcbt>填写" + d.getName(language) + "信息</span>");
            }
        }
        if(riobj.getPayment() == 1)
        {
            sp.append("<span class=lzj_zcbt id=lzj_zccg>选择缴费金额</span><span class=lzj_zcbt>选择支付方式</span>");

        }
        sp.append("<span class=lzj_zcbt>显示服务信息</span>");
        sp.append("</div>");
        return sp.toString();

    }
	//注册导航
  public static  String getNavigation(int membertype,int language,String cssid,int fa) throws SQLException
  {
	  MemberType mtobj = MemberType.find(membertype);
	  RegisterInstall riobj = RegisterInstall.find(membertype);
	  StringBuffer sp = new StringBuffer();
	  sp.append("<div class = RegProcess>");
	  
	     
	   if (MemberType.count(riobj.getCommunity(), "") > 1)
		{
			sp.append("<span class=Process00");
			if (fa == 0)
			{
				sp.append("  id = ").append(cssid);
			}
			sp.append(">选择会员类型</span>");
		}
	  if(riobj.getClause() == 1)
	  {
		 sp.append(" <span class=Process01 ");
		 if(fa==1)
			 sp.append("  id = ").append(cssid);
		  sp.append(" >服务条款</span>");
	  }
	  sp.append("<span class=Process02 " );
	   if(fa==2)
		  sp.append("  id = ").append(cssid);
	  sp.append(">注册会员信息</span>");

	  if(riobj.getRelated() == 1)
	  {
		  if(riobj.getRelatednews() == 21)
		  {
			  sp.append("<span class=Process03");
			  if (fa==3)
				  sp.append("  id = ").append(cssid);
			  sp.append(">填写公司信息</span>");
		  } else
		  {
			  tea.entity.site.Dynamic d = tea.entity.site.Dynamic.find(riobj.getRelatednews());
			 sp.append("<span class=Process04 ");
			 if (fa==4)
				  sp.append("  id = ").append(cssid);
			 sp.append(">填写" + d.getName(language) + "信息</span>");
		  }
	  }
	  if(riobj.getPayment() == 1)
	  {
		  sp.append("<span class=Process05 ");
		  if(fa==5)
			sp.append("  id = ").append(cssid);
		  sp.append(">选择缴费金额</span>");

		  sp.append("<span class=Process06");
		  if(fa==6)
			sp.append("  id = ").append(cssid);
		  sp.append(">选择支付方式</span>");
		  sp.append("<span class=Process07 ");
		  if(fa==7)
			sp.append("  id = ").append(cssid);
		  sp.append(">确认支付信息</span>");
	  }
	  
	  //邮箱验证
	  if(mtobj.getAppemail()==1)
	  {
		  sp.append("<span class=Process08 ");
		  if(fa==8)
		  {
			  sp.append( " id = ").append(cssid);
		  }
		  sp.append(">邮箱验证</span>");
		  
	  }
	  sp.append("<span class=Process09>注册成功</span>");
	  sp.append("</div>");
	  return sp.toString();

  }



    public String getButtonurl()
    {
        return buttonurl;
    }

    public int getClause()
    {
        return clause;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getMember()
    {
        return member;
    }

    public String getMenuurl()
    {
        return menuurl;
    }

    public String getRegister()
    {
        return register;
    }

    public int getRelated()
    {
        return related;
    }

    public int getRelatednews()
    {
        return relatednews;
    }

    public int getRestrictions()
    {
        return restrictions;
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

    public int getVerify()
    {
        return verify;
    }

    public int getMembertype()
    {
        return membertype;
    }

    public String getInspect()
    {
        return inspect;
    }

    public String getPaycontent()
    {
        return paycontent;
    }

    public int getPayment()
    {
        return payment;
    }

    public BigDecimal getPaymoney()
    {
        return paymoney;
    }

    public int getPaytime()
    {
        return paytime;
    }

    public int getFathernode()
    {
        return fathernode;
    }


}
