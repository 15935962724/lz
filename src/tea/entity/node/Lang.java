package tea.entity.node;

import tea.entity.*;
import java.util.*;
import tea.db.DbAdapter;
import java.sql.SQLException;

public class Lang
{
	private static Cache _cache = new Cache(100);
	public static final String TYPE[][] = { { "01", "较差" }, { "02", "一般" }, { "03", "熟练" }, { "04", "掌握" }, { "05", "精通" } };
	public static final String ZDZDJ_TYPE[][] = { { "Z1", "1级" }, { "Z2", "2级" }, { "Z3", "3级" }, { "Z4", "4级" }, { "Z5", "5级" }, { "Z6", "6级" }, { "Z7", "7级" }, { "Z8", "8级" } };
	public static final String SPRSL_TYPE[][] = { { "AF", "南非的" }, { "AR", "阿拉伯语" }, { "BG", "保加利亚语" }, { "CA", "加泰罗尼亚语" }, { "CS", "捷克文" }, { "DA", "丹麦语" }, { "DE", "德语" }, { "EL", "希腊语" }, { "EN", "英语" }, { "ES", "西班牙语" }, { "ET", "爱沙尼亚语" }, { "FI", "芬兰语" }, { "FR", "法语" }, { "HE", "西伯来文" }, { "HR", "克罗地亚语" }, { "HU", "匈牙利语" }, { "ID", "印度尼西亚的" }, { "IS", "冰岛的" }, { "IT", "意大利语" }, { "JA", "日语" }, { "KO", "朝鲜语" }, { "LT", "立陶宛人" }, { "LV", "拉脱维亚人" }, { "MS", "马来西亚的" }, { "NL", "荷兰语" },
			{ "NO", "挪威语" }, { "PL", "波兰语" }, { "PT", "葡萄牙语" }, { "RO", "罗马尼亚文" }, { "RU", "俄语" }, { "SH", "塞尔维亚（拉丁）" }, { "SK", "斯洛伐克语" }, { "SL", "斯洛文尼亚的" }, { "SR", "塞尔维亚语" }, { "SV", "瑞典语" }, { "TH", "泰文" }, { "TR", "土耳其语" }, { "UK", "乌克兰语" }, { "Z1", "客户预留" }, { "ZF", "中文繁体" }, { "ZH", "中文" }

	};
	private int lang;
	private String sprsl;
	private String ztlnl;
	private String zkynl;
	private String zxznl;
	private String zydnl;
	private String zdzdj;
	private String zbz;
	private boolean exists;
	private int node;
	private int language;

	public Lang(int lang) throws SQLException
	{
		this.lang = lang;
		load();
	}

	public static Lang find(int lang) throws SQLException
	{
		Lang obj = (Lang) _cache.get(new Integer(lang));
		if (obj == null)
		{
			obj = new Lang(lang);
			_cache.put(new Integer(lang), obj);
		}
		return obj;
	}

	private void load() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT node,language,sprsl,ztlnl,zkynl,zxznl,zydnl,zdzdj,zbz FROM Lang WHERE lang=" + lang);
			if (dbadapter.next())
			{
				node = dbadapter.getInt(1);
				language = dbadapter.getInt(2);
				sprsl = dbadapter.getString(3);
				ztlnl = dbadapter.getString(4);
				zkynl = dbadapter.getString(5);
				zxznl = dbadapter.getString(6);
				zydnl = dbadapter.getString(7);
				zdzdj = dbadapter.getString(8);
				zbz = dbadapter.getVarchar(1, language, 9);
				exists = true;
			} else
			{
				sprsl = "ZH";
				exists = false;
			}
		} finally
		{
			dbadapter.close();
		}
	}

	public static void create(int node, int language, String sprsl, String ztlnl, String zkynl, String zxznl, String zydnl, String zdzdj, String zbz) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("INSERT INTO Lang(node,language,sprsl,ztlnl,zkynl,zxznl,zydnl,zdzdj,zbz)VALUES(" + node + "," + language + "," + DbAdapter.cite(sprsl) + "," + DbAdapter.cite(ztlnl) + "," + DbAdapter.cite(zkynl) + "," + DbAdapter.cite(zxznl) + "," + DbAdapter.cite(zydnl) + "," + DbAdapter.cite(zdzdj) + "," + DbAdapter.cite(zbz) + ")");
		} finally
		{
			dbadapter.close();
		}
	}

	public void set(String sprsl, String ztlnl, String zkynl, String zxznl, String zydnl, String zdzdj, String zbz) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("UPDATE Lang SET sprsl=" + DbAdapter.cite(sprsl) + ",ztlnl=" + DbAdapter.cite(ztlnl) + ",zkynl=" + DbAdapter.cite(zkynl) + ",zxznl=" + DbAdapter.cite(zxznl) + ",zydnl=" + DbAdapter.cite(zydnl) + ",zdzdj=" + DbAdapter.cite(zdzdj) + ",zbz=" + DbAdapter.cite(zbz) + " WHERE lang=" + lang);
		} finally
		{
			dbadapter.close();
		}
		_cache.remove(new Integer(lang));
	}

	public static java.util.Enumeration find(int node, int language) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT lang FROM Lang WHERE node=" + node + " AND language=" + language);
			while (dbadapter.next())
			{
				vector.addElement(new Integer(dbadapter.getInt(1)));
			}
		} finally
		{
			dbadapter.close();
		}
		return vector.elements();
	}

	public void delete() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("DELETE FROM Lang WHERE lang=" + lang);
		} finally
		{
			dbadapter.close();
		}
		_cache.remove(new Integer(lang));
	}

	public int getLang()
	{
		return lang;
	}

	public String getSprsl()
	{
		return sprsl;
	}

	public String getZtlnl()
	{
		return ztlnl;
	}

	public String getZkynl()
	{
		return zkynl;
	}

	public String getZxznl()
	{
		return zxznl;
	}

	public String getZydnl()
	{
		return zydnl;
	}

	public String getZdzdj()
	{
		return zdzdj;
	}

	public String getZbz()
	{
		return zbz;
	}

	public boolean isExists()
	{
		return exists;
	}

	public int getNode()
	{
		return node;
	}

	public int getLanguage()
	{
		return language;
	}
}
