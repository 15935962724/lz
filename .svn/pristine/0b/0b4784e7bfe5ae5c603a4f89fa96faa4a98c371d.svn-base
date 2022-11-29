package tea.entity.admin.mov;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import tea.entity.admin.AdminUsrRole;

import javax.mail.*;

//zhangjinshu yu 2008-11-18
public class MemberType extends Entity
{
    private int membertype; //主键ID
    private String membername; //会员类型名称
    private String role; //对应角色
    private int above; //上级
    private String lowers; //下级
    private String fileurl; //注册成功跳转的路径
    private String caption; //说明文字
	private int appemail;//是否验证Email
    private int skips; //是否自动跳转
    private String member; //
    private String community; //
    private Date times; //
    private int roletype;//标示审核时候是否选择角色的字段
	//设置积分的字段
	private int register;//设置注册积分 的分值
	private int logincount;// 设置用户登录次数 在次之内才能积分
	private int loginjifen;//登录后的积分
	
	
    private int type; //启动服务的标示
    


    public MemberType(int membertype) throws SQLException
    {
        this.membertype = membertype;
        load();
    }

    public static MemberType find(int membertype) throws SQLException
    {
        return new MemberType(membertype);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT membername,role,above,lowers,fileurl,caption,skips,member,community,times,roletype,register,logincount,loginjifen,appemail,type FROM MemberType WHERE membertype=" + membertype);
            if(db.next())
            {
                membername = db.getString(1);
                role = db.getString(2);
                above = db.getInt(3);
                lowers = db.getString(4);
                fileurl = db.getString(5);
                caption = db.getString(6);
                skips = db.getInt(7);
                member = db.getString(8);
                community = db.getString(9);
                times = db.getDate(10);
                roletype = db.getInt(11);
				register=db.getInt(12);
				logincount=db.getInt(13);
				loginjifen=db.getInt(14);
				appemail=db.getInt(15);
				type=db.getInt(16);
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(String membername,String role,int above,String lowers,String fileurl,String caption,int skips,String member,String community,int roletype,int appemail) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("INSERT INTO MemberType(membername,role,above,lowers,fileurl,caption,skips,member,community,times,roletype,appemail,type) VALUES(" + db.cite(membername) + "," + db.cite(role) + "," + (above) + "," + db.cite(lowers) + "," + db.cite(fileurl) + "," + db.cite(caption) + "," + skips + "," + db.cite(member) + "," + db.cite(community) + "," + db.cite(times) + "," + roletype + ","+appemail+",0  )");
        } finally
        {
            db.close();
        }
    }

    public void set(String membername,String role,int above,String lowers,String fileurl,String caption,int skips,String member,String community,int roletype,int appemail) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE MemberType SET membername=" + db.cite(membername) + ", role=" + db.cite(role) + " ,above=" + (above) + ",lowers=" + db.cite(lowers) + ",fileurl=" + db.cite(fileurl) + ",caption=" + db.cite(caption) + " ,skips=" + skips + ",member=" + db.cite(member) + ",community=" + db.cite(community) + ",roletype=" + roletype + ",appemail="+appemail+" WHERE membertype=" + membertype);
        } finally
        {
            db.close();
        } 
    }
	//在积分设置里面用到的方法
	public void set(int register,int logincount,int loginjifen)throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE MemberType SET register ="+register+",logincount="+logincount+",loginjifen="+loginjifen+" WHERE  membertype="+membertype);
		}finally
		{
			db.close();
		}
	}
// 单个字段修改
	public void set(String field,int fieldvalue)throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE MemberType SET "+field+" = "+fieldvalue+" WHERE membertype= "+membertype);
		}finally
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
            db.executeQuery("SELECT membertype FROM MemberType WHERE community=" + db.cite(community) + sql,pos,size);
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
	public static int count(String community,String sql) throws SQLException
   {
	   int count = 0;
	   DbAdapter db = new DbAdapter();
	   try
	   {
		   db.executeQuery("SELECT COUNT(membertype) FROM MemberType  WHERE community=" + db.cite(community) + sql);
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


    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM MemberType WHERE membertype=" + membertype);
        } finally
        {
            db.close();
        }
    }

    public static int getGetAbove(int membertype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int m = 0;
        try
        {
            db.executeQuery("select membertype from MemberType where above = " + membertype);
            if(db.next())
            {
                m = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return m;
    } 
    
    public void setType(int type)throws SQLException
    {
          DbAdapter db = new DbAdapter();
          try
          {
              db.executeUpdate("UPDATE MemberType SET type = "+type+" WHERE membertype = "+membertype);
          }finally
          {
              db.close();
          }
    }

//    public static String getGetAbove(String getabove) throws SQLException
//    {
//        String ab[] = getabove.split("/");
//        String str = getabove;
//        DbAdapter db = new DbAdapter();
//        try
//        {
//            for(int i = 1;i < ab.length;i++)
//            {
//                MemberType obj = MemberType.find(Integer.parseInt(ab[i]));
//                db.executeQuery("SELECT id FROM AdminRole WHERE type =1 AND id = " + obj.getRole());
//                if(db.next())
//                {
//                    str = getabove.replaceAll("/" + ab[i] + "/","");
//                }
//            }
//
//        } finally
//        {
//            db.close();
//        }
//        return str;
//    }

//	public static int getMemberType(String community,String member)throws SQLException
//	{
//		//先取出用户所属的 角色
//		int mt = 0;
//		java.util.ArrayList al =  MemberRecord.getMemberType(community,member);
//		Collections.sort(al);// 排序的
//		if(al.size()>1){
//			int aaaaa = 0;
//            for(int i = 0;i < al.size();i++)
//            {
//                int m = (int) al.get(i).hashCode();
//                RegisterInstall riobj = RegisterInstall.find(m);
//				if(aaaaa<riobj.getRegister().length())
//				{
//					aaaaa=riobj.getRegister().length();
//					mt = m;
//				}
//               // System.out.println(m + "---" + riobj.getRegister().length());
//
//            }
//        }else
//		{
//			mt = (int) al.get(0).hashCode();
//		}
//		return mt;
//	}

    public static int getMemberType(String community,String member)throws SQLException 
    {
    	int my = 0;
    	DbAdapter db = new DbAdapter();
    	
        try
        {
            db.executeQuery("SELECT membertype FROM MemberOrder WHERE community=" + db.cite(community) + " AND member= " + db.cite(member));
            while(db.next())
            {
            	my = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
    	 
    	return my;
    }
    public String getMembername()
    {
        return membername;
    }

    public int getAbove()
    {
        return above;
    }

    public String getCaption()
    {
        return caption;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getFileurl()
    {
        return fileurl;
    }

    public String getLowers()
    {
        return lowers;
    }

    public String getMember()
    {
        return member;
    }

    public String getRole()
    {
        return role;
    }

    public int getSkips()
    {
        return skips;
    }

    public Date getTimes()
    {
        return times;
    }

    public int getLogincount()
    {
        return logincount;
    }

    public int getLoginjifen()
    {
        return loginjifen;
    }

    public int getRegister()
    {
        return register;
    }

    public String getTimesToString()
    {
        if(times == null)
        {
            return "";
        }
        return sdf.format(times);
    }

    public int getRoleType()
    {
        return roletype;
    }
	public int getAppemail()
	{
		return appemail;
	}
   public int getType()
   {
       return type;
   }


}
