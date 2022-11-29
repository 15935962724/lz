package tea.entity.admin.express;

import java.math.*;
import tea.db.*;
import tea.entity.*;
import java.util.*;
import java.sql.SQLException;

public class ExpressPricezjs extends Entity
{
	private static Cache _cache = new Cache(100);
	private int expresspricezjs;
	private String community;
	private float wfrom;
	private float wto;
	private BigDecimal province;// 省内
	private BigDecimal capital;// 省会
	private BigDecimal interim;// 中转
	private boolean exists;

	public static ExpressPricezjs find(int expresspricezjs) throws SQLException
	{
		ExpressPricezjs obj = (ExpressPricezjs) _cache.get(new Integer(expresspricezjs));
		if (obj == null)
		{
			obj = new ExpressPricezjs(expresspricezjs);
			_cache.put(new Integer(expresspricezjs), obj);
		}
		return obj;
	}

	public ExpressPricezjs(int expresspricezjs) throws SQLException
	{
		this.expresspricezjs = expresspricezjs;
		load();
	}

	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT community,wfrom,wto,province,capital,interim FROM expresspricezjs WHERE expresspricezjs=" + expresspricezjs);
			if (db.next())
			{
				community = db.getString(1);
				wfrom = db.getInt(2);
				wto = db.getInt(3);
				province = db.getBigDecimal(4, 2);
				capital = db.getBigDecimal(5, 2);
				interim = db.getBigDecimal(6, 2);
				exists = true;
			} else
			{
				exists = false;
			}
		}  finally
		{
			db.close();
		}
	}

	public static void create(String community, float wfrom, float wto, BigDecimal province, BigDecimal capital, BigDecimal interim) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO expresspricezjs (community,wfrom,wto,province,capital,interim) VALUES(" + DbAdapter.cite(community) + "," + wfrom + "," + wto + "," + province + "," + capital + "," + interim + ")");
		} finally
		{
			db.close();
		}
		// _cache.remove(expresspricezjs);
	}

	public void set(float wfrom, float wto, BigDecimal province, BigDecimal capital, BigDecimal interim) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE expresspricezjs SET wfrom=" + wfrom + ",wto=" + wto + ",province=" + province + ",capital=" + capital + ",interim=" + interim + " WHERE expresspricezjs=" + expresspricezjs);
		}  finally
		{
			db.close();
		}
		_cache.remove(new Integer(expresspricezjs));
	}

	public static java.util.Enumeration find(String community) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT expresspricezjs FROM expresspricezjs WHERE community=" + DbAdapter.cite(community));
			while (db.next())
			{
				v.add(new Integer(db.getInt(1)));
			}
		} finally
		{
			db.close();
		}
		return v.elements();
	}

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM expresspricezjs WHERE expresspricezjs=" + expresspricezjs);
		} catch (SQLException ex)
		{
			ex.printStackTrace();
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(expresspricezjs));
	}

	public int getExpresspricezjs()
	{
		return expresspricezjs;
	}

	public String getCommunity()
	{
		return community;
	}

	public float getWfrom()
	{
		return wfrom;
	}

	public float getWto()
	{
		return wto;
	}

	public BigDecimal getProvince()
	{
		return province;
	}

	public BigDecimal getCapital()
	{
		return capital;
	}

	public BigDecimal getInterim()
	{
		return interim;
	}

	public boolean isExists()
	{
		return exists;
	}
}
