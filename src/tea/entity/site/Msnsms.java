package tea.entity.site;

import java.util.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class Msnsms
{
	private static Cache _cache = new Cache(100);
	private static final java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-hh HH:mm");
	private int msnsms;
	private String content;
	private String ip;
	private String idcard;
	private Date time;
	private int states;
	private String mobile;
	private String mobile2;

	public Msnsms(int msnsms) throws SQLException
	{
		this.msnsms = msnsms;
		loadBasic();
	}

	public Msnsms(int msnsms, String mobile, String content, String ip, String mobile2, String idcard, java.util.Date time, int states)
	{
		this.msnsms = msnsms;
		this.mobile = mobile;
		this.content = content;
		this.ip = ip;
		this.mobile2 = mobile2;
		this.idcard = idcard;
		this.time = time;
		this.states = states;
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT  mobile,content  ,ip   ,mobile2,idcard    ,time    ,states   FROM Msnsms WHERE msnsms=" + (msnsms));
			if (db.next())
			{
				mobile = db.getString(1);
				content = db.getString(2);
				ip = db.getString(3);
				mobile2 = db.getString(4);
				idcard = db.getString(5);
				time = db.getDate(6);
				states = db.getInt(7);
			}
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
			db.executeUpdate("DELETE Msnsms WHERE msnsms=" + msnsms);
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(msnsms));
	}

	public static void create(String mobile, String content, String ip, String mobile2, String idcard, int states) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Msnsms( mobile  , content,  ip    ,mobile2,idcard    ,time       ,states) VALUES(" + DbAdapter.cite(mobile) + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(ip) + "," + DbAdapter.cite(mobile2) + "," + DbAdapter.cite(idcard) + "," + DbAdapter.cite(new java.util.Date()) + "," + (states) + ")");
		} finally
		{
			db.close();
		}
	}

	public static java.util.Enumeration findByStates(int states, int type, int pos, int pageSize) throws SQLException
	{
		StringBuilder sb = new StringBuilder();
		if (type == 0) // 移动
		{
			sb.append(" AND NOT(mobile LIKE '130%' OR mobile LIKE '131%' OR mobile LIKE '132%' OR mobile LIKE '133%')");
		} else if (type == 1) // 联通
		{
			sb.append(" AND(mobile LIKE '130%' OR mobile LIKE '131%' OR mobile LIKE '132%' OR mobile LIKE '133%')");
		}
		java.util.Vector vector = new java.util.Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT msnsms ,mobile , content,  ip    ,mobile2,idcard    ,time  FROM Msnsms WHERE states=" + (states) + sb.toString() + " ORDER BY time");
			for (int l = 0; l < (pos + pageSize) && db.next(); l++)
			{
				if (l >= pos)
				{
					int msnsms = db.getInt(1);
					String mobile = db.getString(2);
					String content = db.getString(3);
					String ip = db.getString(4);
					String mobile2 = db.getString(5);
					String idcard = db.getString(6);
					java.util.Date time = db.getDate(7);
					Msnsms obj = new Msnsms(msnsms, mobile, content, ip, mobile2, idcard, time, states);
					_cache.put(new Integer(msnsms), obj);
					vector.addElement(obj);
				}
			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public static java.util.Enumeration findByMobile2(String mobile2, int pos, int pageSize) throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT msnsms ,mobile , content,  ip    ,mobile2,idcard    ,time,states  FROM Msnsms WHERE mobile2=" + DbAdapter.cite(mobile2) + " ORDER BY time");
			for (int l = 0; l < (pos + pageSize) && db.next(); l++)
			{
				if (l >= pos)
				{
					int msnsms = db.getInt(1);
					String mobile = db.getString(2);
					String content = db.getString(3);
					String ip = db.getString(4);
					String idcard = db.getString(5);
					java.util.Date time = db.getDate(6);
					int states = db.getInt(7);
					Msnsms obj = new Msnsms(msnsms, mobile, content, ip, mobile2, idcard, time, states);
					_cache.put(new Integer(msnsms), obj);
					vector.addElement(obj);
				}
			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public static Msnsms findByIpLast(String ip) throws SQLException
	{
		Msnsms obj = null;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT   msnsms,mobile,content ,mobile2,idcard    ,time    ,states   FROM Msnsms WHERE ip=" + DbAdapter.cite(ip) + " ORDER BY time DESC");
			if (db.next())
			{
				int msnsms = db.getInt(1);
				String mobile = db.getString(2);
				String content = db.getString(3);
				String mobile2 = db.getString(4);
				String idcard = db.getString(5);
				java.util.Date time = db.getDate(6);
				int states = db.getInt(7);
				obj = new Msnsms(msnsms, mobile, content, ip, mobile2, idcard, time, states);
				_cache.put(new Integer(msnsms), obj);
			}
		} finally
		{
			db.close();
		}
		return obj;
	}

	public static Msnsms find(int msnsms) throws SQLException
	{
		Msnsms obj = (Msnsms) _cache.get(new Integer(msnsms));
		if (obj == null)
		{
			obj = new Msnsms(msnsms);
			_cache.put(new Integer(msnsms), obj);
		}
		return obj;
	}

	public int getMsnsms()
	{
		return msnsms;
	}

	public String getIdcard()
	{
		return idcard;
	}

	public String getContent()
	{
		return content;
	}

	public Date getTime()
	{
		return time;
	}

	public String getTimeToString()
	{
		return sdf.format(time);
	}

	public int getStates()
	{

		return states;
	}

	public String getIp()
	{
		return ip;
	}

	public String getMobile()
	{
		return mobile;
	}

	public String getMobile2()
	{
		return mobile2;
	}

	public static int countByCommunity(String community, int type) throws SQLException
	{
		int j = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT COUNT(community) FROM Msnsms WHERE community=" + DbAdapter.cite(community) + " AND type=" + type);
			if (db.next())
			{
				j = db.getInt(1);
			}
		} finally
		{
			db.close();
		}
		return j;
	}

	public static int countByCommunity(String community, String domain) throws SQLException
	{
		int j = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT COUNT(community) FROM Msnsms WHERE community=" + DbAdapter.cite(community) + " AND referer LIKE " + DbAdapter.cite(domain + "_%") + " AND type=1 ");
			if (db.next())
			{
				j = db.getInt(1);
			}
		} finally
		{
			db.close();
		}
		return j;
	}

	public void setStates(int states) throws SQLException
	{
		this.states = states;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Msnsms SET states=" + states + " WHERE msnsms=" + msnsms);
		} finally
		{
			db.close();
		}
	}

	public static String getMaster()
	{
		return "iwlk";
	}
}
