package tea.entity.site;

import java.math.*;
import java.util.*;
import tea.db.DbAdapter;
import java.sql.SQLException;
import java.sql.SQLException;

public class YellowPage
{
	private String member;
	private String domain[];
	private int states;
	private String mailid;
	private String mailpw;
	private Date time;
	private BigDecimal price;
	private Date nextTime;
	private static tea.entity.Cache _cache = new tea.entity.Cache(100);
	private boolean exists;

	public YellowPage(String member) throws SQLException
	{
		this.member = member;
		domain = new String[5];
		loadBasic();
	}

	public static YellowPage find(String member) throws SQLException
	{
		YellowPage node = (YellowPage) _cache.get(member);
		if (node == null)
		{
			node = new YellowPage(member);
			_cache.put(member, node);
		}
		return node;
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT domain,domain2,domain3,domain4,domain5, states, time, price, nexttime, mailid, mailpw FROM YellowPage  WHERE member=" + DbAdapter.cite(member));
			if (db.next())
			{
				for (int index = 0; index < 5; index++)
				{
					domain[index] = db.getVarchar(1, 1, index + 1);
				}
				states = db.getInt(6);
				time = db.getDate(7);
				price = db.getBigDecimal(8, 4);
				nextTime = db.getDate(9);
				mailid = db.getString(10);
				mailpw = db.getString(11);
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

	public static void create(String member, String domain[], int states, Date time, java.math.BigDecimal price, Date nexttime, String mailid, String mailpw) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO YellowPage(member  ,domain  ,domain2,domain3,domain4,domain5,states  ,time    ,price   ,nexttime,mailid  ,mailpw )VALUES( " + DbAdapter.cite(member) + "," + DbAdapter.cite(domain[0]) + "," + DbAdapter.cite(domain[1]) + "," + DbAdapter.cite(domain[2]) + "," + DbAdapter.cite(domain[3]) + "," + DbAdapter.cite(domain[4]) + "," + (states) + "," + DbAdapter.cite(time) + "," + (price) + "," + DbAdapter.cite(nexttime) + "," + DbAdapter.cite(mailid) + ","
					+ DbAdapter.cite(mailpw) + ")");
		} finally
		{
			db.close();
		}
	}

	public void set(String domain[], int states, Date time, java.math.BigDecimal price, Date nexttime, String mailid, String mailpw) throws SQLException
	{
		if (exists)
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeUpdate("UPDATE  YellowPage SET domain=" + DbAdapter.cite(domain[0]) + ",domain2=" + DbAdapter.cite(domain[1]) + ",domain3=" + DbAdapter.cite(domain[2]) + ",domain4=" + DbAdapter.cite(domain[3]) + ",domain5=" + DbAdapter.cite(domain[4]) + ",states=" + (states) + ",time=" + DbAdapter.cite(time) + ",price=" + (price) + ",nexttime=" + DbAdapter.cite(nexttime) + ",mailid=" + DbAdapter.cite(mailid) + ",mailpw=" + DbAdapter.cite(mailpw) + " WHERE member=" + DbAdapter.cite(member));
			} finally
			{
				db.close();
			}
		} else
		{
			create(member, domain, states, time, price, nexttime, mailid, mailpw);
		}
		_cache.remove(member);
	}

	public String getMember()
	{
		return member;
	}

	public String[] getDomain()
	{
		return domain;
	}

	public int getStates()
	{
		return states;
	}

	public String getMailid()
	{
		return mailid;
	}

	public String getMailpw()
	{
		return mailpw;
	}

	public Date getTime()
	{
		return time;
	}

	public String getTime(String pattern)
	{
		if (time == null)
		{
			return "";
		}
		return new java.text.SimpleDateFormat(pattern).format(time);
	}

	public BigDecimal getPrice()
	{
		return price;
	}

	public Date getNextTime()
	{
		return nextTime;
	}

	public String getNextTime(String pattern)
	{
		if (time == null)
		{
			return "";
		}
		return new java.text.SimpleDateFormat(pattern).format(nextTime);
	}

	public boolean isExists()
	{
		return exists;
	}
}
