package tea.entity.criterion;

import java.util.Date;
import java.util.Vector;
import java.sql.SQLException;
import tea.db.DbAdapter;
import tea.entity.*;

public class Referenceres extends Entity
{
	public static Cache _cache = new Cache(100);
	public static final String CALLING_TYPE[] = { "水泥", "钢铁", "石油", "玻璃" };
	public static final String SPECIALTY_TYPE[] = { "废水", "大气", "噪声", "固废", "生态", "土壤", "放射性" };

	private int referenceres;
	private String name;
	private String publishing;
	private Date time;
	private String author;
	private String calling;
	private String specialty;
	private String derivation;

	public Referenceres(int referenceres) throws SQLException
	{
		this.referenceres = referenceres;
		load();
	}

	public static Referenceres find(int expertres) throws SQLException
	{
		Referenceres obj = (Referenceres) _cache.get(new Integer(expertres));
		if (obj == null)
		{
			obj = new Referenceres(expertres);
			_cache.put(new Integer(expertres), obj);
		}
		return obj;
	}

	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT name,publishing,time,author,calling,specialty,derivation FROM Referenceres WHERE referenceres=" + referenceres);
			if (db.next())
			{
				name = db.getString(1);
				publishing = db.getString(2);
				time = db.getDate(3);
				author = db.getString(4);
				calling = db.getString(5);
				specialty = db.getString(6);
				derivation = db.getString(7);
			}
	} finally
		{
			db.close();
		}
	}

	public static int create(String name, String publishing, Date time, String author, String calling, String specialty, String derivation) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Referenceres(name,publishing,time,author,calling,specialty,derivation) VALUES(" + DbAdapter.cite(name) + "," + DbAdapter.cite(publishing) + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(author) + "," + DbAdapter.cite(calling) + "," + DbAdapter.cite(specialty) + "," + DbAdapter.cite(derivation) + ")");
			db.executeQuery("SELECT MAX(referenceres) FROM Referenceres");
			if (db.next())
			{
				return db.getInt(1);
			}
	} finally
		{
			db.close();
		}
		return 0;
	}

	public void set(String name, String publishing, Date time, String author, String calling, String specialty, String derivation) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Referenceres SET name=" + DbAdapter.cite(name) + ",publishing=" + DbAdapter.cite(publishing) + ",calling=" + DbAdapter.cite(calling) + ",specialty=" + DbAdapter.cite(specialty) + ",time=" + DbAdapter.cite(time) + ",author =" + DbAdapter.cite(author) + ",derivation =" + DbAdapter.cite(derivation) + " WHERE referenceres=" + referenceres);
	} finally
		{
			db.close();
		}
		// _cache.remove(new Integer(referenceres));
		this.name = name;
		this.publishing = publishing;
		this.time = time;
		this.author = author;
		this.calling = calling;
		this.specialty = specialty;
		this.derivation = derivation;
	}

	public static java.util.Enumeration find(String sql) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT referenceres FROM Referenceres WHERE 1=1 " + sql);
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
			db.executeUpdate("DELETE Referenceres WHERE referenceres=" + referenceres);
	} finally
		{
			db.close();
		}
		_cache.remove(new Integer(referenceres));
	}

	public int getReferenceres()
	{
		return referenceres;
	}

	public String getName()
	{
		return name;
	}

	public String getPublishing()
	{
		return publishing;
	}

	public Date getTime()
	{
		return time;
	}

	public String getTimeToString()
	{
		if (time == null)
		{
			return "";
		}
		return sdf.format(time);
	}

	public String getAuthor()
	{
		return author;
	}

	public String getCalling()
	{
		return calling;
	}

	public String getSpecialty()
	{
		return specialty;
	}

	public String getDerivation()
	{
		return derivation;
	}
}
