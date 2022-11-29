package tea.entity.member;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

/*
 中华环境保护基金会
 http://www.cepf.org.cn/
 注册会员
 */
public class ProfileCepf
{
	public ProfileCepf(String member) throws SQLException
	{
		this.member = member;
		loadBasic();
	}

	public static ProfileCepf find(String strMember) throws SQLException
	{
		ProfileCepf profile = (ProfileCepf) _cache.get(strMember.trim().toLowerCase());
		if (profile == null)
		{
			profile = new ProfileCepf(strMember);
			_cache.put(strMember, profile);
		}
		return profile;
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT type,principal,enterprise  FROM ProfileCepf WHERE member=" + DbAdapter.cite(member));
			if (db.next())
			{
				type = db.getInt(1);
				principal = db.getVarchar(1, 1, 2);
				enterprise = db.getInt(3) != 0;
			}
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			db.close();
		}
	}

	private void set(String fieldName, Object value) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			String str = null;
			if (value instanceof String)
			{
				str = DbAdapter.cite((String) value);
			} else if (value instanceof java.util.Date)
			{
				str = DbAdapter.cite((java.util.Date) value);
			} else
			{
				str = DbAdapter.cite(value.toString());
			}
			db.executeUpdate("IF EXISTS(SELECT member FROM ProfileCepf WHERE member=" + DbAdapter.cite(this.member) + ")" + "        UPDATE ProfileCepf SET " + fieldName + "=" + str + " WHERE member=" + DbAdapter.cite(member) + " ELSE " + "        INSERT INTO ProfileCepf(member," + fieldName + ")VALUES (" + DbAdapter.cite(this.member) + "," + str + ")");
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			db.close();
		}
		_cache.remove(member);
	}

	public void setType(int type) throws SQLException
	{
		this.type = type;
		set("type", String.valueOf(type));
	}

	public void setPrincipal(String principal) throws SQLException
	{
		this.principal = principal;
		set("principal", String.valueOf(principal));
	}

	public void setEnterprise(boolean enterprise) throws SQLException
	{
		this.enterprise = enterprise;
		set("enterprise", String.valueOf(enterprise ? "0" : "1"));
	}

	public int getType()
	{
		return type;
	}

	public String getMember()
	{
		return member;
	}

	public String getPrincipal()
	{
		return principal;
	}

	public boolean isEnterprise()
	{
		return enterprise;
	}

	public static Cache _cache = new Cache(100);
	private int type; // 会员级别

	private String member;
	private String principal; // 单位负责人

	private boolean enterprise; // 是否是企业会员
}
