package tea.entity.site;

import java.math.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class YellowPageBrokage
{
	private String member;
	private String memberx;
	private BigDecimal price;
	private static tea.entity.Cache _cache = new tea.entity.Cache(100);
	private boolean exists;
	private Date time;
	private BigDecimal pay;
	private int states;

	public YellowPageBrokage(String member, String memberx) throws SQLException
	{
		this.member = member;
		this.memberx = memberx;
		loadBasic();
	}

	public static YellowPageBrokage find(String member, String memberx) throws SQLException
	{
		YellowPageBrokage node = (YellowPageBrokage) _cache.get(member + ":" + memberx);
		if (node == null)
		{
			node = new YellowPageBrokage(member, memberx);
			_cache.put(member + ":" + memberx, node);
		}
		return node;
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT price,time,pay,states FROM YellowPageBrokage  WHERE member=" + DbAdapter.cite(member) + " AND memberx=" + DbAdapter.cite(memberx));
			if (db.next())
			{
				price = db.getBigDecimal(1, 4);
				time = db.getDate(2);
				pay = db.getBigDecimal(3, 4);
				states = db.getInt(4);
				this.exists = true;
			} else
			{
				this.exists = false;
			}
		} finally
		{
			db.close();
		}
	}

	public static YellowPageBrokage create(String member, String memberx, java.math.BigDecimal pay, int states, java.math.BigDecimal price) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO YellowPageBrokage (member,memberx,pay,states,price)VALUES( " + DbAdapter.cite(member) + "," + DbAdapter.cite(memberx) + "," + (pay) + "," + (states) + "," + (price) + ")");
			YellowPageBrokage obj = new YellowPageBrokage(member, memberx);
			_cache.put(member + ":" + memberx, obj);
			return obj;
		} finally
		{
			db.close();
		}
	}

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE YellowPageBrokage WHERE member=" + DbAdapter.cite(member) + " AND memberx=" + DbAdapter.cite(memberx));
			_cache.remove(member + ":" + memberx);
		} finally
		{
			db.close();
		}
	}

	public void set(java.math.BigDecimal pay, int states, java.math.BigDecimal price) throws SQLException
	{
		if (exists)
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeUpdate("UPDATE YellowPageBrokage SET pay=" + pay + ",states=" + states + ",price=" + (price) + " WHERE member=" + DbAdapter.cite(member) + " AND memberx=" + DbAdapter.cite(memberx));
				_cache.remove(member + ":" + memberx);
			} finally
			{
				db.close();
			}
		} else
		{
			create(member, memberx, pay, states, price);
		}
	}

	public static java.util.Enumeration findByMember(String member) throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT memberx FROM YellowPageBrokage WHERE member=" + DbAdapter.cite(member) + " ORDER BY time DESC");
			while (db.next())
			{
				vector.addElement(db.getString(1));
			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public String getMember()
	{
		return member;
	}

	public String getMemberx()
	{
		return memberx;
	}

	public BigDecimal getPrice()
	{
		return price;
	}

	public boolean isExists()
	{
		return exists;
	}

	public Date getTime()
	{
		return time;
	}

	public BigDecimal getPay()
	{
		return pay;
	}

	public int getStates()
	{
		return states;
	}

	public String getTime(String pattern)
	{
		if (time == null)
		{
			return "";
		} else
		{
			return new java.text.SimpleDateFormat(pattern).format(time);
		}
	}

}
