package tea.entity.member;

import java.util.*;
import java.text.*;
import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

//购物象网,积分卡
public class Profile9000 extends Entity
{
	public static Cache _cache = new Cache(100);
	private String community;
	private String member;
	private String code;
	private String password;
	private int point;
	private Date time;
	private boolean exists;

	public Profile9000(String code) throws SQLException
	{
		this.code = code;
		load();
	}

	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT community,member,password,point,time FROM Profile9000 WHERE code=" + DbAdapter.cite(code));
			if (db.next())
			{
				community = db.getString(1);
				member = db.getString(2);
				password = db.getString(3);
				point = db.getInt(4);
				time = db.getDate(5);
				exists = true;
			} else
			{
				exists = false;
			}
		} finally
		{
			db.close();
		}
	}

	public static Profile9000 find(String code) throws SQLException
	{
		Profile9000 obj = (Profile9000) _cache.get(code);
		if (obj == null)
		{
			obj = new Profile9000(code);
			_cache.put(code, obj);
		}
		return obj;
	}

	public static String findByMember(String member) throws SQLException
	{
		String code = null;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT code FROM Profile9000 WHERE member=" + DbAdapter.cite(member));
			if (db.next())
			{
				code = db.getString(1);
			}
		} finally
		{
			db.close();
		}
		return code;
	}

	public static String findMaxCode() throws SQLException
	{
		String code = null;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT MAX(code) FROM Profile9000");
			if (db.next())
			{
				code = db.getString(1);
			}
		} finally
		{
			db.close();
		}
		if (code == null || code.length() < 1)
		{
			code = "6688000000000000";
		}
		return code;
	}

	public static void create(String community, String member, String code, String password, int point, Date time) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Profile9000(community,member,code,password,point,time)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(code) + "," + DbAdapter.cite(password) + "," + point + "," + DbAdapter.cite(time) + ")");
		} finally
		{
			db.close();
		}
		_cache.remove(code);
	}

	public static java.util.Enumeration find(String community, String sql, int pos, int pagesize) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT code FROM Profile9000 WHERE community=" + DbAdapter.cite(community) + sql);
			for (int l = 0; l < pos + pagesize && db.next(); l++)
			{
				if (l >= pos)
				{
					v.addElement(db.getString(1));
				}
			}
		} finally
		{
			db.close();
		}
		return v.elements();
	}

	public static java.util.Enumeration findTime(String community) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT DISTINCT time FROM Profile9000 WHERE community=" + DbAdapter.cite(community));
			while (db.next())
			{
				v.addElement(db.getDate(1));
			}
		} finally
		{
			db.close();
		}
		return v.elements();
	}

	public static int count(String community, String sql) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			return db.getInt("SELECT COUNT(member) FROM Profile9000 WHERE community=" + DbAdapter.cite(community) + sql);
		} finally
		{
			db.close();
		}
	}

	public void set(String password, int point, String member) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Profile9000 SET password=" + DbAdapter.cite(password) + ",point=" + point + ",member=" + DbAdapter.cite(member) + " WHERE code=" + DbAdapter.cite(code));
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			db.close();
		}
		this.password = password;
		this.point = point;
		this.member = member;
	}

	public void setMember(String member) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Profile9000 SET member=" + DbAdapter.cite(member) + " WHERE code=" + DbAdapter.cite(code));
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			db.close();
		}
		this.member = member;
	}

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM Profile9000 WHERE code=" + DbAdapter.cite(code));
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			db.close();
		}
	}

	public String getMember()
	{
		return member;
	}

	public String getCommunity()
	{
		return community;
	}

	public boolean isExists()
	{
		return exists;
	}

	public String getCode()
	{
		return code;
	}

	public String getCodeToFormat()
	{
		DecimalFormat df = new DecimalFormat("#,###0");
		return df.format(Long.parseLong(code)).replace(',', ' ');
	}

	public String getPassword()
	{
		return password;
	}

	public int getPoint()
	{
		return point;
	}

	public Date getTime()
	{
		return time;
	}
}
