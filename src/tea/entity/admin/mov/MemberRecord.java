package tea.entity.admin.mov;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

//zhangjinshu yu 2008-11-18
public class MemberRecord extends Entity
{


	//记录会员注册的表 MemberRecord
	private int memberrecord;
	private String member;
	private int membertype;
	private String community;
	private Date times;
	private int previous; //记录 注册次会员时候的上级会员
	public MemberRecord(int memberrecord) throws SQLException
	{
		this.memberrecord = memberrecord;
		load();
	}

	public static MemberRecord findmr(int memberrecord) throws SQLException
	{
		return new MemberRecord(memberrecord);
	}

	public void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT member,membertype,community,times,previous FROM MemberRecord WHERE memberrecord=" + memberrecord);
			if(db.next())
			{
				member = db.getString(1);
				membertype = db.getInt(2);
				community = db.getString(3);
				times = db.getDate(4);
				previous = db.getInt(5);
			}
		} finally
		{
			db.close();
		}
	}

	public static void create(String member,int membertype,String community) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		Date times = new Date();
		try
		{
			db.executeUpdate("INSERT INTO MemberRecord(member,membertype,community,times) VALUES(" + db.cite(member) + "," + membertype + "," + db.cite(community) + "," + db.cite(times) + " )");
		} finally
		{
			db.close();
		}
	}


//previous
	public  void set(int membertype)throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("update MemberRecord set previous ="+membertype+" where memberrecord="+memberrecord);
		} finally
		{
			db.close();
		}
		this.previous=membertype;

	}

	public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT memberrecord FROM MemberRecord WHERE community=" + db.cite(community) + sql);
			for(int k = 0;k < pos + size && db.next();k++)
			{
				if(k >= pos)
				{
					v.addElement(new Integer(db.getInt(1)));
				}
			}

		} finally
		{
			db.close();
		}
		return v.elements();
	}

	public static boolean isMembertype(String above) throws SQLException
	{
		boolean fa = false;
		DbAdapter db = new DbAdapter();
		String ab[] = above.split("/");
		StringBuffer sb = new StringBuffer();
		try
		{
			if(above != null && above.length() > 0)
			{
				for(int i = 1;i < ab.length;i++)
				{
					sb.append(" AND membertype=").append(ab[i]);
				}
				db.executeQuery(" SELECT memberrecord FROM MemberRecord WHERE 1=1" + sb.toString());
				if(db.next())
				{
					fa = true;
				}
			}
		} finally
		{
			db.close();
		}
		return fa;
	}

	public static boolean isMemberRecord(String member,int membertype) throws SQLException
	{
		boolean fa = false;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT memberrecord FROM MemberRecord WHERE member =" + db.cite(member) + " AND membertype = " + membertype);
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
	public static boolean isMemberRecord(String member,String community,int membertype) throws SQLException
	{
		boolean fa = false;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT memberrecord FROM MemberRecord WHERE community="+db.cite(community)+" and member =" + db.cite(member) + " AND membertype = " + membertype);
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


//取出用户注册了什么类型的会员
	public static int getMemberType(String community ,String member,int membertype)throws SQLException
	{
	    int al =0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT memberrecord FROM MemberRecord WHERE community="+db.cite(community)+"  AND member = "+db.cite(member)+" AND membertype="+membertype);
			while(db.next())
			{
				al = db.getInt(1);
			}
		}finally
		{
			db.close();
		}
		return al;
	}
	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM MemberRecord WHERE memberrecord=" + memberrecord);
		} finally
		{
			db.close();
		}
	}

	public static  void delete(int membertype) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM MemberRecord WHERE membertype=" + membertype);
		} finally
		{
			db.close();
		}

	}
	public static  void deletemember(String member) throws SQLException
  {
	  DbAdapter db = new DbAdapter();
	  try
	  {
		  db.executeUpdate("DELETE FROM MemberRecord WHERE member=" + db.cite(member));
	  } finally
	  {
		  db.close();
	  }

  }


	public String getMember()
	{
		return member;
	}

	public int getMemberType()
	{
		return membertype;
	}

	public String getCommunity()
	{
		return community;
	}

	public Date getTimes()
	{
		return times;
	}

	public String getTimesToString()
	{
		if(times == null)
			return "";
		return sdf.format(times);
	}

	public int getPrevious()
	{
		return previous;
	}


}
