package tea.entity.node;

import java.util.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class Family
{
	private static Cache _cache = new Cache(100);
	public static final String FAMSA_TYPE[][] = { { "1", "配偶" }, { "11", "父亲" }, { "12", "母亲" }, { "2", "子女" }, { "7", "紧急联络" }, { "9001", "配偶父亲" }, { "9002", "配偶母亲" }, { "9003", "兄" }, { "9004", "弟" }, { "9005", "姐" }, { "9006", "妹" } };
	public static final String STATU_TYPE[][] = { { "01", "在职" }, { "03", "离退休" }, { "06", "无工作" }, { "91", "从军" }, { "92", "海外" }, { "93", "务农" }, { "94", "在校" }, { "99", "其他" } };
	private int node;
	private int language;
	private boolean exists;
	private Date fgbdt;
	private String fgbld;
	private String fanat;
	private boolean fasex;
	private String favor;
	private String fanam;
	private String fgbot;
	private String zzhkszd;
	private String zzracky;
	private String zzgzdw;
	private String zzzwmc;
	private String zzslart;
	private String statu;
	private String pstat;
	private String telnr;
	private int family;
	private String famsa;

	public Family(int family) throws SQLException
	{
		this.family = family;
		load();
	}

	public static Family find(int family) throws SQLException
	{
		Family obj = (Family) _cache.get(new Integer(family));
		if (obj == null)
		{
			obj = new Family(family);
			_cache.put(new Integer(family), obj);
		}
		return obj;
	}

	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT node,language,famsa,fgbdt,fgbld,fanat,fasex,favor,fanam,fgbot,zzhkszd,zzracky,zzgzdw,zzzwmc,zzslart,statu,pstat,telnr FROM Family WHERE family=" + family);
			if (db.next())
			{
				node = db.getInt(1);
				language = db.getInt(2);
				famsa = db.getString(3);
				fgbdt = db.getDate(4);
				fgbld = db.getString(5);
				fanat = db.getString(6);
				fasex = db.getInt(7) != 0;
				favor = db.getVarchar(1, language, 8);
				fanam = db.getVarchar(1, language, 9);
				fgbot = db.getVarchar(1, language, 10);
				zzhkszd = db.getVarchar(1, language, 11);
				zzracky = db.getVarchar(1, language, 12);
				zzgzdw = db.getVarchar(1, language, 13);
				zzzwmc = db.getVarchar(1, language, 14);
				zzslart = db.getVarchar(1, language, 15);
				statu = db.getString(16);
				pstat = db.getString(17);
				telnr = db.getVarchar(1, language, 18);
				exists = true;
			} else
			{
				zzracky = "HA";
				exists = false;
			}
		} finally
		{
			db.close();
		}
	}

	public static void create(int node, int language, String famsa, Date fgbdt, String fgbld, String fanat, boolean fasex, String favor, String fanam, String fgbot, String zzhkszd, String zzracky, String zzgzdw, String zzzwmc, String zzslart, String statu, String pstat, String telnr) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Family(node,language,famsa,fgbdt,fgbld,fanat,fasex,favor,fanam,fgbot,zzhkszd,zzracky,zzgzdw,zzzwmc,zzslart,statu,pstat,telnr)VALUES(" + node + "," + language + "," + DbAdapter.cite(famsa) + "," + DbAdapter.cite(fgbdt) + "," + DbAdapter.cite(fgbld) + "," + DbAdapter.cite(fanat) + "," + (fasex ? "1" : "0") + "," + DbAdapter.cite(favor) + "," + DbAdapter.cite(fanam) + "," + DbAdapter.cite(fgbot) + "," + DbAdapter.cite(zzhkszd) + "," + DbAdapter.cite(zzracky)
					+ "," + DbAdapter.cite(zzgzdw) + "," + DbAdapter.cite(zzzwmc) + "," + DbAdapter.cite(zzslart) + "," + DbAdapter.cite(statu) + "," + DbAdapter.cite(pstat) + "," + DbAdapter.cite(telnr) + ")");
		} finally
		{
			db.close();
		}
	}

	public void set(String famsa, Date fgbdt, String fgbld, String fanat, boolean fasex, String favor, String fanam, String fgbot, String zzhkszd, String zzracky, String zzgzdw, String zzzwmc, String zzslart, String statu, String pstat, String telnr) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Family SET famsa=" + DbAdapter.cite(famsa) + ",fgbdt=" + DbAdapter.cite(fgbdt) + ",fgbld=" + DbAdapter.cite(fgbld) + ",fanat=" + DbAdapter.cite(fanat) + ",fasex=" + (fasex ? "1" : "0") + ",favor=" + DbAdapter.cite(favor) + ",fanam=" + DbAdapter.cite(fanam) + ",fgbot=" + DbAdapter.cite(fgbot) + ",zzhkszd=" + DbAdapter.cite(zzhkszd) + ",zzracky=" + DbAdapter.cite(zzracky) + ",zzgzdw=" + DbAdapter.cite(zzgzdw) + ",zzzwmc=" + DbAdapter.cite(zzzwmc) + ",zzslart="
					+ DbAdapter.cite(zzslart) + ",statu=" + DbAdapter.cite(statu) + ",pstat=" + DbAdapter.cite(pstat) + ",telnr=" + DbAdapter.cite(telnr) + " WHERE family=" + family);
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(family));
	}

	public static java.util.Enumeration find(int node, int language) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT family FROM Family WHERE node=" + node + " AND language=" + language);
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

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM Family WHERE family=" + family);
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(family));
	}

	public boolean isExists()
	{
		return exists;
	}

	public int getLanguage()
	{
		return language;
	}

	public int getNode()
	{
		return node;
	}

	public Date getFgbdt()
	{
		return fgbdt;
	}

	public String getFgbld()
	{
		return fgbld;
	}

	public String getFanat()
	{
		return fanat;
	}

	public boolean isFasex()
	{
		return fasex;
	}

	public String getFavor()
	{
		return favor;
	}

	public String getFanam()
	{
		return fanam;
	}

	public String getFgbot()
	{
		return fgbot;
	}

	public String getZzhkszd()
	{
		return zzhkszd;
	}

	public String getZzracky()
	{
		return zzracky;
	}

	public String getZzgzdw()
	{
		return zzgzdw;
	}

	public String getZzzwmc()
	{
		return zzzwmc;
	}

	public String getZzslart()
	{
		return zzslart;
	}

	public String getStatu()
	{
		return statu;
	}

	public String getPstat()
	{
		return pstat;
	}

	public String getTelnr()
	{
		return telnr;
	}

	public int getFamily()
	{
		return family;
	}

	public String getFamsa()
	{
		return famsa;
	}
}
