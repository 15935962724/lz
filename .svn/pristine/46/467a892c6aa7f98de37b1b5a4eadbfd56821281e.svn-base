package tea.entity.member;

import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.node.*;

public class Award extends Entity
{
	private static Cache _cache = new Cache(100);
	public static final String ZJLJB_TYPE[] = { "国家级", "部委级", "省级", "市级", "总公司级", "二级公司级", "三级公司级及以下", "系统外其他单位各级别" };
	private int award;
	private int node;
	private int language;
	private Date begda;
	private Date endda;
	private int zjljb;
	private String zjcmc;
	private String zjcdw;
	private String zjcyy;
	private Date zjcsj;
	private String zjcbh;
	private String zqtbz1;
	private String zqtbz2;
	private String zqtbz3;
	private String zqtbz4;
	private boolean exists;

	public Award()
	{
	}

	public static Award find(int award) throws SQLException
	{
		Award obj = (Award) _cache.get(new Integer(award));
		if (obj == null)
		{
			obj = new Award(award);
			_cache.put(new Integer(award), obj);
		}
		return obj;
	}

	public static java.util.Enumeration findByNode(int node, int language) throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT award FROM Award WHERE node=" + (node) + " AND language=" + language + " ORDER BY begda");
			while (db.next())
			{
				vector.addElement(new Integer(db.getInt(1)));
			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public Award(int award) throws SQLException
	{
		this.award = award;
		loadBasic();
	}

	public void set(Date begda, Date endda, int zjljb, String zjcmc, String zjcdw, String zjcyy, Date zjcsj, String zjcbh, String zqtbz1, String zqtbz2, String zqtbz3, String zqtbz4) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Award SET begda=" + DbAdapter.cite(begda) + ",endda=" + DbAdapter.cite(endda) + ",zjljb=" + DbAdapter.cite("" + zjljb) + ",zjcmc=" + DbAdapter.cite(zjcmc) + ",zjcdw=" + DbAdapter.cite(zjcdw) + ",zjcyy=" + DbAdapter.cite(zjcyy) + ",zjcsj=" + DbAdapter.cite(zjcsj) + ",zjcbh=" + DbAdapter.cite(zjcbh) + ",zqtbz1=" + DbAdapter.cite(zqtbz1) + ",zqtbz2=" + DbAdapter.cite(zqtbz2) + ",zqtbz3=" + DbAdapter.cite(zqtbz3) + ",zqtbz4=" + DbAdapter.cite(zqtbz4) + " WHERE award=" + award);
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(award));
	}

	public static void create(int node, int language, Date begda, Date endda, int zjljb, String zjcmc, String zjcdw, String zjcyy, Date zjcsj, String zjcbh, String zqtbz1, String zqtbz2, String zqtbz3, String zqtbz4) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Award( node,    language,begda,   endda,   zjljb,   zjcmc,   zjcdw,   zjcyy,   zjcsj,   zjcbh,   zqtbz1,  zqtbz2,  zqtbz3,  zqtbz4)VALUES(" + node + "," + language + "," + DbAdapter.cite(begda) + "," + DbAdapter.cite(endda) + "," + DbAdapter.cite("" + zjljb) + "," + DbAdapter.cite(zjcmc) + "," + DbAdapter.cite(zjcdw) + "," + DbAdapter.cite(zjcyy) + "," + DbAdapter.cite(zjcsj) + "," + DbAdapter.cite(zjcbh) + "," + DbAdapter.cite(zqtbz1) + "," + DbAdapter.cite(zqtbz2) + ","
					+ DbAdapter.cite(zqtbz3) + "," + DbAdapter.cite(zqtbz4) + ")");
		} finally
		{
			db.close();
		}
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT node,    language,begda,   endda,   zjljb,   zjcmc,   zjcdw,   zjcyy,   zjcsj,   zjcbh,   zqtbz1,  zqtbz2,  zqtbz3,  zqtbz4  FROM Award  WHERE award=" + award);
			if (db.next())
			{
				node = db.getInt(1);
				language = db.getInt(2);
				begda = db.getDate(3);
				endda = db.getDate(4);
				zjljb = db.getInt(5);
				zjcmc = db.getVarchar(1, language, 6);
				zjcdw = db.getVarchar(1, language, 7);
				zjcyy = db.getVarchar(1, language, 8);
				zjcsj = db.getDate(9);
				zjcbh = db.getVarchar(1, language, 10);
				zqtbz1 = db.getVarchar(1, language, 11);
				zqtbz2 = db.getVarchar(1, language, 12);
				zqtbz3 = db.getVarchar(1, language, 13);
				zqtbz4 = db.getVarchar(1, language, 14);
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

	public void delete()
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM Award WHERE award=" + award);
		} catch (SQLException ex)
		{
			ex.printStackTrace();
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(award));
	}

	public int getAward()
	{
		return award;
	}

	public int getNode()
	{
		return node;
	}

	public int getLanguage()
	{
		return language;
	}

	public Date getBegda()
	{
		return begda;
	}

	public String getBegdaToString()
	{
		return sdf.format(begda);
	}

	public Date getEndda()
	{
		return endda;
	}

	public String getEnddaToString()
	{
		return sdf.format(endda);
	}

	public int getZjljb()
	{
		return zjljb;
	}

	public String getZjcmc()
	{
		return zjcmc;
	}

	public String getZjcdw()
	{
		return zjcdw;
	}

	public String getZjcyy()
	{
		return zjcyy;
	}

	public Date getZjcsj()
	{
		return zjcsj;
	}

	public String getZjcsjToString()
	{
		return java.text.DateFormat.getDateInstance().format(zjcsj);
	}

	public String getZjcbh()
	{
		return zjcbh;
	}

	public String getZqtbz1()
	{
		return zqtbz1;
	}

	public String getZqtbz2()
	{
		return zqtbz2;
	}

	public String getZqtbz3()
	{
		return zqtbz3;
	}

	public String getZqtbz4()
	{
		return zqtbz4;
	}

	public boolean isExists()
	{
		return exists;
	}

}
