package tea.entity.admin;

import java.io.*;
import java.util.Date;
import tea.db.DbAdapter;
import java.sql.SQLException;
import tea.entity.*;
import tea.entity.admin.Bulletin;

public class Maintenance extends Entity
{
	private int id;
	private int vehicle;
	private Date times;
	private int vtype;
	private String cause;
	private String man;
	private float charge;
	private String remark;

	private boolean exists;
	private static Cache _cache = new Cache(100);

	public Maintenance(int id) throws SQLException
	{
		this.id = id;
		load();
	}

	public static Maintenance find(int id) throws SQLException
	{
		return new Maintenance(id);
	}

	public void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT vehicle,times,vtype,cause,man,charge,remark FROM Maintenance WHERE id = " + id);
			if (db.next())
			{
				vehicle = db.getInt(1);
				times = db.getDate(2);
				vtype = db.getInt(3);
				cause = db.getVarchar(1, 1, 4);
				man = db.getVarchar(1, 1, 5);
				charge = db.getFloat(6);
				remark = db.getVarchar(1, 1, 7);
			} else
			{
				this.exists = false;
			}} finally
		{
			db.close();
		}
	}

	public static int create(int vehicle, Date times, int vtype, String cause, String man, float charge, String remark, String community, RV _rv) throws SQLException
	{
		int id = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Maintenance (vehicle,times,vtype,cause,man,charge,remark,community,member)VALUES(" + vehicle + "," + DbAdapter.cite(times) + "," + vtype + "," + DbAdapter.cite(cause) + "," + DbAdapter.cite(man) + "," + charge + "," + DbAdapter.cite(remark) + "," + DbAdapter.cite(community) + ",'" + _rv + "')");
			id = db.getInt("SELECT MAX(id) FROM Maintenance");} finally
		{
			db.close();
		}
		_cache.remove(new Integer(id));
		return id;
	}

	public void set(int vehicle, Date times, int vtype, String cause, String man, float charge, String remark) throws SQLException
	{
		// Date d = new Date();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Maintenance SET vehicle =" + vehicle + ",times=" + DbAdapter.cite(times) + ",vtype=" + vtype + ",cause=" + DbAdapter.cite(cause) + ",man=" + DbAdapter.cite(man) + ",charge=" + charge + ",remark=" + DbAdapter.cite(remark) + "  WHERE id =" + id);} finally
		{
			db.close();
		}
		_cache.remove(new Integer(id));

	}

	public static java.util.Enumeration findByCommunity(String community, String sql) throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT id FROM Maintenance WHERE community=" + DbAdapter.cite(community) + sql);

			while (dbadapter.next())
			{
				vector.addElement(new Integer(dbadapter.getInt(1)));
			}} finally
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
			dbadapter.executeUpdate("DELETE FROM Maintenance WHERE id=" + id);} finally
		{
			dbadapter.close();
		}
		_cache.remove(new Integer(id));
	}

	public int getVehicle()
	{
		return vehicle;
	}

	public Date getTimes()
	{
		return times;
	}

	public int getVtype()
	{
		return vtype;
	}

	public String getCause()
	{
		return cause;
	}

	public String getMan()
	{
		return man;
	}

	public float getCharge()
	{
		return charge;
	}

	public String getRemark()
	{
		return remark;
	}

}
