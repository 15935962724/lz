package tea.entity.site;

import java.util.*;
import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class MsnsmsRule
{
	private static Cache _cache = new Cache(100);
	private static final java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-hh HH:mm");
	private int msnsmsrule;
	private Date time;
	private String mobile;
	private String mobile2;
	private String content;
	private int states;// 0拒绝,1允许

	public MsnsmsRule(int msnsmsrule) throws SQLException
	{
		this.msnsmsrule = msnsmsrule;
		loadBasic();
	}

	public MsnsmsRule(int msnsmsrule, String mobile, String mobile2, String content, int states, java.util.Date time)
	{
		this.msnsmsrule = msnsmsrule;
		this.mobile = mobile;
		this.mobile2 = mobile2;
		this.content = content;
		this.states = states;
		this.time = time;
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT  mobile,mobile2,content,states,time FROM Msnsmsrule WHERE msnsmsrule=" + (msnsmsrule));
			if (db.next())
			{
				mobile = db.getString(1);
				mobile2 = db.getString(2);
				content = db.getString(3);
				states = db.getInt(4);
				time = db.getDate(5);
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
			db.executeUpdate("DELETE Msnsmsrule WHERE msnsmsrule=" + msnsmsrule);
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(msnsmsrule));
	}

	public static void create(String mobile, String mobile2, String content, int states) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Msnsmsrule( mobile  , mobile2,  content    ,states ,time) VALUES(" + DbAdapter.cite(mobile) + "," + DbAdapter.cite(mobile2) + "," + DbAdapter.cite(content) + "," + (states) + "," + DbAdapter.cite(new java.util.Date()) + ")");
		} finally
		{
			db.close();
		}
	}

	public static java.util.Enumeration findByMobile(String mobile, int pos, int pageSize) throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT msnsmsrule, mobile2  ,content,states,time   FROM Msnsmsrule WHERE mobile=" + DbAdapter.cite(mobile) + " ORDER BY time");
			for (int l = 0; l < (pos + pageSize) && db.next(); l++)
			{
				if (l >= pos)
				{
					int msnsmsrule = db.getInt(1);
					String mobile2 = db.getString(2);
					String content = db.getString(3);
					int states = db.getInt(4);
					java.util.Date time = db.getDate(5);
					MsnsmsRule obj = new MsnsmsRule(msnsmsrule, mobile, mobile2, content, states, time);
					_cache.put(new Integer(msnsmsrule), obj);
					vector.addElement(obj);
				}
			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	// 发送者的手机号，发送的内容，接收者的手机号
	public static boolean isDeny(String mobile2, String content, String mobile) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT msnsmsrule FROM Msnsmsrule WHERE states=0 AND mobile=" + DbAdapter.cite(mobile) + " AND(" + DbAdapter.cite(content) + " LIKE '%'+content+'%' OR " + DbAdapter.cite(mobile2) + " LIKE '%'+mobile2+'%' )");
			return (db.next());
		} finally
		{
			db.close();
		}
	}

	public static MsnsmsRule findByIpLast(String ip) throws SQLException
	{
		MsnsmsRule obj = null;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT   msnsms,mobile,content ,mobile2,idcard    ,time    ,states   FROM Msnsmsrule WHERE ip=" + DbAdapter.cite(ip) + " ORDER BY time DESC");
			if (db.next())
			{
				int msnsms = db.getInt(1);
				String mobile = db.getString(2);
				String content = db.getString(3);
				String mobile2 = db.getString(4);
				String idcard = db.getString(5);
				java.util.Date time = db.getDate(6);
				int states = db.getInt(7);
				// obj = new MsnsmsRule(msnsms, mobile, content, ip, mobile2, idcard, time, states);
				_cache.put(new Integer(msnsms), obj);
			}
		} finally
		{
			db.close();
		}
		return obj;
	}

	public static MsnsmsRule find(int msnsmsrule) throws SQLException
	{
		MsnsmsRule obj = (MsnsmsRule) _cache.get(new Integer(msnsmsrule));
		if (obj == null)
		{
			obj = new MsnsmsRule(msnsmsrule);
			_cache.put(new Integer(msnsmsrule), obj);
		}
		return obj;
	}

	public int getMsnsmsrule()
	{
		return msnsmsrule;
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

	public String getMobile()
	{
		return mobile;
	}

	public String getMobile2()
	{
		return mobile2;
	}
}
