package tea.entity.member;

import java.sql.SQLException;
import java.math.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;

public class Code extends Entity
{
	public static final java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
	private static Cache _cache = new Cache(100);
	public static final int PARVALUE_TYPE[] = { 20, 200, 400, 600 };
	public static final char SYMBOL_TYPE[] = { 'D', 'A', 'B', 'C' };
	private boolean exists;
	private String code;
	private BigDecimal parvalue;
	private Date time;
	private String password;
	private String member;
	private String community;
	private Date time2;
	private char symbol = 0;

	public Code()
	{
	}

	public Code(String code) throws SQLException
	{
		this.code = code;
		loadBasic();
	}

	public Code(String code, String password, java.math.BigDecimal parvalue, String member, String community, Date time, Date time2)
	{
		this.code = code;
		this.password = password;
		this.parvalue = parvalue;
		this.member = member;
		this.community = community;
		this.time = time;
		this.time2 = time2;
	}

	public static Code find(String code) throws SQLException
	{
		Code obj = (Code) _cache.get(code);
		if (obj == null)
		{
			obj = new Code(code);
			_cache.put(code, obj);
		}
		return obj;
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT password    ,parvalue       ,member ,community    ,time,time2 FROM Code  WHERE code=" + DbAdapter.cite(code));
			if (db.next())
			{
				password = db.getVarchar(1, 1, 1);
				parvalue = db.getBigDecimal(2, 2);
				member = db.getVarchar(1, 1, 3);
				community = db.getVarchar(1, 1, 4);
				time = db.getDate(5);
				time2 = db.getDate(6);
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

	public static java.util.Enumeration find(String community, String member, int pos, int pageSize) throws SQLException
	{
		java.util.Vector vecotr = new java.util.Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT password    ,parvalue       ,member ,community    ,time,code,time2 FROM Code WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member) + " ORDER BY time2 DESC");
			for (int l = 0; l < pos + pageSize && db.next(); l++)
			{
				if (l >= pos)
				{
					String password = db.getString(1);
					java.math.BigDecimal parvalue = db.getBigDecimal(2, 2);
					// String member = db.getVarchar(1, 1, 3);
					java.util.Date time = db.getDate(5);
					String code = db.getString(6);
					java.util.Date time2 = db.getDate(7);
					vecotr.addElement(new Code(code, password, parvalue, member, community, time, time2));
				}
			}
		} finally
		{
			db.close();
		}
		return vecotr.elements();
	}

	public static java.util.Enumeration find(String community, java.util.Date time, int pos, int pageSize) throws SQLException
	{
		java.util.Vector vecotr = new java.util.Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT password    ,parvalue       ,member ,community    ,time,code,time2 FROM Code WHERE community=" + DbAdapter.cite(community) + " AND time=" + DbAdapter.cite(time) + " ORDER BY code DESC");
			for (int l = 0; l < pos + pageSize && db.next(); l++)
			{
				if (l >= pos)
				{
					String password = db.getString(1);
					java.math.BigDecimal parvalue = db.getBigDecimal(2, 2);
					String member = db.getVarchar(1, 1, 3);
					// java.util.Date time = db.getDate(5);
					String code = db.getString(6);
					java.util.Date time2 = db.getDate(7);
					vecotr.addElement(new Code(code, password, parvalue, member, community, time, time2));
				}
			}
		} finally
		{
			db.close();
		}
		return vecotr.elements();
	}

	public static void create(String code, String password, java.math.BigDecimal parvalue, String member, String community) throws SQLException
	{
		java.util.Date time = new java.util.Date();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Code(code,password    ,parvalue       ,member     ,community   ,time)VALUES(" + DbAdapter.cite(code) + "," + DbAdapter.cite(password) + "," + (parvalue) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(time) + ")");
		} finally
		{
			db.close();
		}
		_cache.remove(code);
	}

	public synchronized static void create(java.math.BigDecimal parvalue, int quantity, String community) throws SQLException
	{
		java.util.Random r = new java.util.Random();
		java.util.Date time = new java.util.Date();
		DbAdapter db = new DbAdapter();
		try
		{
			for (; quantity > 0; quantity--)
			{
				StringBuilder sb = new StringBuilder(10);
				for (int index = 0; index < 10; index++)
				{
					int value = r.nextInt(36);
					sb.append(value > 9 ? String.valueOf((char) (value + 55)) : String.valueOf(value));
				}
				db.executeUpdate("INSERT INTO Code(password    ,parvalue       ,community   ,time)VALUES(" + DbAdapter.cite(sb.toString()) + "," + (parvalue) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(time) + ")");
			}
		} finally
		{
			db.close();
		}
	}

	public void set(String member) throws SQLException
	{
		time2 = new java.util.Date();
		// /if (exists)
		// {
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Code SET member=" + DbAdapter.cite(member) + ",time2=" + DbAdapter.cite(time2) + " WHERE code=" + DbAdapter.cite(code));
		} finally
		{
			db.close();
		}
		_cache.remove(code);
		/*
		 * } else { create(code, password, parvalue, member, community); }
		 */
	}

	public boolean isFull() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT * FROM Code WHERE NOT member IS NULL AND NOT time2 IS NULL AND code=" + DbAdapter.cite(code));
			return db.next();
		} finally
		{
			db.close();
		}
	}

	public void delete()
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM Code WHERE code=" + DbAdapter.cite(code));
		} catch (SQLException ex)
		{
			ex.printStackTrace();
		} finally
		{
			db.close();
		}
		_cache.remove(code);
	}

	public synchronized static String getLast() throws SQLException
	{
		StringBuilder sb = new StringBuilder();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT orderid FROM Code");
			if (db.next())
			{
				sb.append(db.getString(1));
				while (db.next())
				{
					sb.append("," + db.getString(1));
				}
			}
		} finally
		{
			db.close();
		}
		return sb.toString();
	}

	public String getMember()
	{
		return member;
	}

	public boolean isExists()
	{
		return exists;
	}

	public String getCode()
	{
		return code;
	}

	public BigDecimal getParvalue()
	{
		return parvalue;
	}

	public Date getTime()
	{
		return time;
	}

	public String getTimeToString()
	{
		return sdf.format(time);
	}

	public String getPassword()
	{
		return password;
	}

	public String getCommunity()
	{
		return community;
	}

	public Date getTime2()
	{
		return time2;
	}

	public char getSymbol()
	{
		if (symbol == 0)
		{
			for (int index = 0; index < PARVALUE_TYPE.length; index++)
			{
				if (parvalue.intValue() == PARVALUE_TYPE[index])
				{
					symbol = SYMBOL_TYPE[index];
					break;
				}
			}
		}
		return symbol;
	}

	public String getTime2ToString()
	{
		if (time2 == null)
		{
			return "";
		}
		return sdf.format(time2);
	}

}
