package tea.entity.member;

import java.sql.SQLException;
import java.math.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;

public class ProfileMoney extends Entity
{
	private static Cache _cache = new Cache(100);

	private boolean exists;
	private String community;
	private BigDecimal money;
	private String member;

	public ProfileMoney()
	{
	}

	public ProfileMoney(String community, String member) throws SQLException
	{
		this.community = community;
		this.member = member;
		loadBasic();
	}

	public ProfileMoney(String community, String member, java.math.BigDecimal money)
	{
		this.community = community;
		this.member = member;
		this.money = money;
	}

	public static ProfileMoney find(String community, String member) throws SQLException
	{
		ProfileMoney obj = (ProfileMoney) _cache.get(community + ":" + member);
		if (obj == null)
		{
			obj = new ProfileMoney(community, member);
			_cache.put(community + ":" + member, obj);
		}
		return obj;
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT money FROM ProfileMoney  WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
			if (db.next())
			{
				money = db.getBigDecimal(1, 2);
				exists = true;
			} else
			{
				money = new java.math.BigDecimal(0);
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
		StringBuilder sql = new StringBuilder("SELECT member,money FROM ProfileMoney WHERE community=" + DbAdapter.cite(community));
		if (member != null && member.length() > 0)
		{
			sql.append(" AND member LIKE " + DbAdapter.cite("%" + member + "%"));
		}
		sql.append(" ORDER BY money DESC");
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery(sql.toString());
			for (int l = 0; l < pos + pageSize && db.next(); l++)
			{
				if (l >= pos)
				{
					member = db.getString(1);
					java.math.BigDecimal money = db.getBigDecimal(2, 2);
					vecotr.addElement(new ProfileMoney(community, member, money));
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
			db.executeQuery("SELECT password    ,parvalue       ,member ,community    ,time,code,time2 FROM ProfileMoney WHERE community=" + DbAdapter.cite(community) + " AND time=" + DbAdapter.cite(time) + " ORDER BY code DESC");
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
					// vecotr.addElement(new ProfileMoney(code, password, parvalue, member, community, time, time2));
				}
			}
		} finally
		{
			db.close();
		}
		return vecotr.elements();
	}

	public static void create(String community, String member, java.math.BigDecimal money) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO ProfileMoney(community,member,money)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(member) + "," + (money) + ")");
		} finally
		{
			db.close();
		}
		_cache.remove(community + ":" + member);
	}

	public void set(BigDecimal money) throws SQLException
	{
		if (exists)
		{
			this.money = this.money.add(money);
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeUpdate("UPDATE ProfileMoney SET money=" + money + " WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
			} finally
			{
				db.close();
			}
			// _cache.remove(community + ":" + member);
		} else
		{
			create(community, member, money);
		}
	}

	public void delete()
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM ProfileMoney WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
		} catch (SQLException ex)
		{
			ex.printStackTrace();
		} finally
		{
			db.close();
		}
		_cache.remove(community + ":" + member);
	}

	public boolean isExists()
	{
		return exists;
	}

	public String getCommunity()
	{
		return community;
	}

	public BigDecimal getMoney()
	{
		return money;
	}

	public String getMember()
	{
		return member;
	}

}
