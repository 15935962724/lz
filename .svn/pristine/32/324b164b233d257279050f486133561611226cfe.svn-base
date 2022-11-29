package tea.entity.node;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class AdwordClick extends Entity
{
	private int adwordclick;
	private int adword;
	private String ip;
	private Date time;

	public AdwordClick(int adwordclick) throws SQLException
	{
		this.adwordclick = adwordclick;
		load();
	}

	public int getAdword()
	{
		return adword;
	}

	public int getAdwordclick()
	{
		return adwordclick;
	}

	public String getIp()
	{
		return ip;
	}

	public Date getTime()
	{
		return time;
	}

	public String getTimeToString()
	{
		return sdf2.format(time);
	}

	public static AdwordClick find(int adword) throws SQLException
	{
		/*
		 * AdwordClick obj = (AdwordClick) _cache.get(new Integer(adword)); if (obj == null) { obj = new AdwordClick(adword); _cache.put(new Integer(adword), obj); } return obj;
		 */
		return new AdwordClick(adword);
	}

	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT adword,ip,time FROM adwordclick WHERE adwordclick=" + adwordclick);
			if (db.next())
			{
				adword = db.getInt(1);
				ip = db.getString(2);
				time = db.getDate(3);
			}
		} finally
		{
			db.close();
		}
	}

	public static int create(int adword, String ip) throws SQLException
	{
		int i1 = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO adwordclick (adword,ip,time)VALUES(" + adword + "," + DbAdapter.cite(ip) + "," + db.citeCurTime() + ")");
			i1 = db.getInt("SELECT MAX(adwordclick) FROM adwordclick");
		} finally
		{
			db.close();
		}
		return i1;
	}

	public static int count(int adword, String sql) throws SQLException
	{
		int count = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT COUNT(adwordclick) FROM adwordclick WHERE adword=adword" + sql);
			if (db.next())
			{
				count = db.getInt(1);
			}
		} finally
		{
			db.close();
		}
		return count;
	}

	public static Enumeration find(int adword, String sql, int pos, int size) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT adwordclick FROM adwordclick WHERE adword=adword" + sql,pos,size);
			while(db.next())
			{
					vector.addElement(new Integer(db.getInt(1)));
			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}
}
