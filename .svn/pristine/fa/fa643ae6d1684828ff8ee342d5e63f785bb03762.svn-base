package tea.entity.admin;

import java.io.*;
import java.util.Date;
import tea.db.DbAdapter;
import java.sql.SQLException;
import tea.entity.*;
import tea.entity.admin.Bulletin;

public class Manage extends Entity
{
	private int id;
	private String vehicle;
	private String factory;
	private String engine;
	private int genre;
	private String chauffeur;
	private float price;
	private String pic;
	private Date times;
	private int fettle;
	private String remark;
	private Date times1;

	private boolean exists;
	private static Cache _cache = new Cache(100);

	public Manage(int id) throws SQLException
	{
		this.id = id;
		load();
	}

	public static Manage find(int id) throws SQLException
	{
		return new Manage(id);
	}

	public void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT vehicle,factory,engine,genre,chauffeur,price,pic,times,fettle,remark,times1 FROM Manage WHERE id = " + id);
			if (db.next())
			{
				vehicle = db.getVarchar(1, 1, 1);
				factory = db.getString(2);
				engine = db.getString(3);
				genre = db.getInt(4);
				chauffeur = db.getVarchar(1, 1, 5);
				price = db.getFloat(6);
				pic = db.getVarchar(1, 1, 7);
				times = db.getDate(8);
				fettle = db.getInt(9);
				remark = db.getVarchar(1, 1, 10);
				times1 = db.getDate(11);
			} else
			{
				this.exists = false;
			}} finally
		{
			db.close();
		}
	}

	public static int create(String vehicle, String factory, String engine, int genre, String chauffeur, float price, String pic, Date times, int fettle, String remark, String community, RV _rv) throws SQLException
	{
		int id = 0;
		Date d = new Date();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Manage (vehicle,factory,engine,genre,chauffeur,price,pic,times,fettle,remark,times1,community,member)VALUES(" + DbAdapter.cite(vehicle) + "," + DbAdapter.cite(factory) + "," + DbAdapter.cite(engine) + "," + genre + "," + DbAdapter.cite(chauffeur) + "," + price + "," + DbAdapter.cite(pic) + "," + DbAdapter.cite(times) + "," + fettle + "," + DbAdapter.cite(remark) + "," + DbAdapter.cite(d) + "," + DbAdapter.cite(community) + ",'" + _rv + "')");
			id = db.getInt("SELECT MAX(id) FROM Manage");} finally
		{
			db.close();
		}
		_cache.remove(new Integer(id));
		return id;
	}

	public void set(String vehicle, String factory, String engine, int genre, String chauffeur, float price, String pic, Date times, int fettle, String remark) throws SQLException
	{
		// Date d = new Date();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Manage SET vehicle =" + DbAdapter.cite(vehicle) + ",factory=" + DbAdapter.cite(factory) + ",engine=" + DbAdapter.cite(engine) + ",genre=" + genre + ",chauffeur=" + DbAdapter.cite(chauffeur) + ",price=" + price + ",pic=" + DbAdapter.cite(pic) + ",times=" + DbAdapter.cite(times) + ",fettle=" + fettle + " ,remark=" + DbAdapter.cite(remark) + "  WHERE id =" + id);} finally
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
			dbadapter.executeQuery("SELECT id FROM Manage WHERE community=" + DbAdapter.cite(community) + sql);
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
			dbadapter.executeUpdate("DELETE FROM Manage WHERE id=" + id);} finally
		{
			dbadapter.close();
		}
		_cache.remove(new Integer(id));
	}

	public String getVehicle()
	{
		return vehicle;
	}

	public String getFactory()
	{
		return factory;
	}

	public String getEngine()
	{
		return engine;
	}

	public int getGenre()
	{
		return genre;
	}

	public String getChauffeur()
	{
		return chauffeur;
	}

	public float getPrice()
	{
		return price;
	}

	public String getPic()
	{
		return pic;
	}

	public Date getTimes()
	{
		return times;
	}

	public int getFettle()
	{
		return fettle;
	}

	public String getRemark()
	{
		return remark;
	}

	public Date getTimes1()
	{
		return times1;
	}

}
