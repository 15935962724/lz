package tea.entity.member;

import java.util.Date;
import java.sql.SQLException;
import tea.db.DbAdapter;
import tea.entity.*;
import java.io.*;
import java.util.*;

public class ProfileEnterprise extends Entity
{
	private static Cache _cache = new Cache(100);
	private String member;
	private String community;
	private String name;
	private String property;
	private int scale;
	private String calling;
	private String linkman;
	private boolean linkmansex;
	private String synopsis;
	private String license;
	private boolean exists;
	private boolean auditing;
	private Date valid;

	public static ProfileEnterprise find(String member, String community) throws SQLException
	{
		ProfileEnterprise obj = (ProfileEnterprise) _cache.get(member + ":" + community);
		if (obj == null)
		{
			obj = new ProfileEnterprise(member, community);
			_cache.put(member + ":" + community, obj);
		}
		return obj;
	}

	public ProfileEnterprise(String member, String community) throws SQLException
	{
		this.member = member;
		this.community = community;
		load();
	}

	public void set() throws SQLException
	{
		if (this.isExists())
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeUpdate("UPDATE ProfileEnterprise SET name       =" + DbAdapter.cite(name) + ", property   =" + DbAdapter.cite(property) + ",scale=" + (scale) + ",calling    =" + DbAdapter.cite(calling) + ",linkman    =" + DbAdapter.cite(linkman) + ",linkmansex =" + (linkmansex ? "1" : "0") + ",synopsis   =" + DbAdapter.cite(synopsis) + ",license    =" + DbAdapter.cite(license) + ",auditing    =" + (auditing ? "1" : "0") + ",valid=" + DbAdapter.cite(valid) + " WHERE member="
						+ DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
			} finally
			{
				db.close();
			}
			_cache.remove(member + ":" + community);
		} else
		{
			create();
		}
	}

	public static int count(String community, String sql) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			return db.getInt("SELECT COUNT(DISTINCT pe.member) FROM ProfileEnterprise pe INNER JOIN " + db.citeTab("Profile") + " p ON pe.member=p.member WHERE pe.community=" + DbAdapter.cite(community) + sql);
		} finally
		{
			db.close();
		}
	}

	public static Enumeration find(String community, String sql, int pos, int pagesize) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT DISTINCT pe.member,p.time FROM ProfileEnterprise pe INNER JOIN " + db.citeTab("Profile") + " p ON pe.member=p.member WHERE pe.community=" + DbAdapter.cite(community) + sql+" ORDER BY p.time DESC");
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

	public void create() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO ProfileEnterprise(member,community,name      ,    property  ,    scale      ,    calling   ,    linkman   ,    linkmansex,    synopsis  ,    license ,auditing,valid  )VALUES(" + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(property) + "," + scale + "," + DbAdapter.cite(calling) + "," + DbAdapter.cite(linkman) + "," + (linkmansex ? "1" : "0") + "," + DbAdapter.cite(synopsis) + ","
					+ DbAdapter.cite(license) + "," + (auditing ? "1" : "0") + "," + DbAdapter.cite(valid) + ")");
		} finally
		{
			db.close();
		}
		_cache.remove(member + ":" + community);
	}

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE ProfileEnterprise WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
		} finally
		{
			db.close();
		}
		_cache.remove(member + ":" + community);
	}

	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT name,property,scale,calling,linkman,linkmansex,synopsis,license,auditing,valid FROM ProfileEnterprise WHERE member= " + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
			if (db.next())
			{
				name = db.getVarchar(1, 1, 1);
				property = db.getVarchar(1, 1, 2);
				scale = db.getInt(3);
				calling = db.getVarchar(1, 1, 4);
				linkman = db.getVarchar(1, 1, 5);
				linkmansex = db.getInt(6) != 0;
				synopsis = db.getVarchar(1, 1, 7);
				license = db.getString(8);
				auditing = db.getInt(9) != 0;
				valid = db.getDate(10);
				exists = true;
			} else
			{
				exists = false;
				license = "";
			}
		} finally
		{
			db.close();
		}
	}

	public void setMember(String member)
	{
		this.member = member;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public void setProperty(String property)
	{
		this.property = property;
	}

	public void setSize(int scale)
	{
		this.scale = scale;
	}

	public void setCalling(String calling)
	{
		this.calling = calling;
	}

	public void setLinkman(String linkman)
	{
		this.linkman = linkman;
	}

	public void setLinkmansex(boolean linkmansex)
	{
		this.linkmansex = linkmansex;
	}

	public void setSynopsis(String synopsis)
	{
		this.synopsis = synopsis;
	}

	public void setAuditing(boolean auditing)
	{
		this.auditing = auditing;
	}

	public void setValidity(Date valid)
	{
		this.valid = valid;
	}

	/*
	 * public void setLicense(byte[] licensePrcture) { if (licensePrcture == null) { this.license = ""; } else { this.license =write(licensePrcture); } }
	 */
	public String getMember()
	{
		return member;
	}

	public String getName()
	{
		if (name != null)
		{

			return (name);

		}
		return "";
	}

	public String getProperty()
	{
		if (property != null)
		{
			return property;
		}

		return "";
	}

	public int getSize()
	{
		return scale;
	}

	public String getCalling()
	{
		if (calling != null)
		{
			return calling;
		}
		return "";
	}

	public String getLinkman()
	{
		if (linkman != null)
		{
			return linkman;
		}
		return "";
	}

	public boolean isLinkmansex()
	{
		return linkmansex;
	}

	public String getSynopsis()
	{
		if (synopsis != null)
		{
			return synopsis;
		}
		return "";
	}

	public String getLicense()
	{
		return license;
	}

	public boolean isExists()
	{
		return exists;
	}

	public boolean isAuditing()
	{
		return auditing;
	}

	public Date getValid()
	{
		return valid;
	}

	public String getValidToString()
	{
		if (valid == null)
			return "";
		return sdf.format(valid);
	}
}
