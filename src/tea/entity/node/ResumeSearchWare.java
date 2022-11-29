package tea.entity.node;

import tea.entity.*;
import tea.db.DbAdapter;
import java.sql.SQLException;

public class ResumeSearchWare
{
	private static Cache _cache = new Cache(100);
	private int id;
	private String occid;
	private String city;
	private String deg;
	private String sex;
	private String age;
	private String wrk;
	private String keyword;
	private String name;
	private String member;

	public ResumeSearchWare(int id) throws SQLException
	{
		this.id = id;
		loadBasic();
	}

	public static ResumeSearchWare find(int id) throws SQLException
	{
		ResumeSearchWare obj = (ResumeSearchWare) _cache.get(new Integer(id));
		if (obj == null)
		{
			obj = new ResumeSearchWare(id);
			_cache.put(new Integer(id), obj);
		}
		return obj;
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT  occid  ,city   ,deg    ,sex    ,age    ,wrk    ,keyword,name   ,member 	 FROM ResumeSearchWare  WHERE id=" + this.id);
			if (dbadapter.next())
			{
				occid = dbadapter.getVarchar(1, 1, 1);
				city = dbadapter.getVarchar(1, 1, 2);
				deg = dbadapter.getString(3);
				sex = dbadapter.getString(4);
				age = dbadapter.getString(5);
				wrk = dbadapter.getString(6);
				keyword = dbadapter.getVarchar(1, 1, 7);
				name = dbadapter.getVarchar(1, 1, 8);
				member = dbadapter.getVarchar(1, 1, 9);
			}
		} finally
		{
			dbadapter.close();
		}
	}

	public void set(String occid, String city, String deg, String sex, String age, String wrk, String keyword, String name, String member) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			/*
			 * dbadapter.executeUpdate("ResumeSearchWareEdit " + (id) + "," + DbAdapter.cite(occid) + "," + DbAdapter.cite(city) + "," + DbAdapter.cite(deg) + "," + DbAdapter.cite(sex) + "," + DbAdapter.cite(age) + "," + DbAdapter.cite(wrk) + "," + DbAdapter.cite(keyword) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(member) );
			 */
			dbadapter.executeQuery("SELECT id FROM ResumeSearchWare WHERE id=" + id);
			if (dbadapter.next())
			{
				dbadapter.executeUpdate("UPDATE ResumeSearchWare SET occid  =" + DbAdapter.cite(occid) + ",city   =" + DbAdapter.cite(city) + ",deg   =" + DbAdapter.cite(deg) + " ,sex  =" + DbAdapter.cite(sex) + "  ,age   =" + DbAdapter.cite(age) + " ,wrk   =" + DbAdapter.cite(wrk) + " ,keyword =" + DbAdapter.cite(keyword) + ",name  =" + DbAdapter.cite(name) + " 	WHERE  id=" + id);
			} else
			{
				dbadapter.executeUpdate("INSERT INTO ResumeSearchWare(occid  ,city   ,deg    ,sex    ,age    ,wrk    ,keyword,name   ,member )VALUES(" + DbAdapter.cite(occid) + "  ," + DbAdapter.cite(city) + "   ," + DbAdapter.cite(deg) + "    ," + DbAdapter.cite(sex) + "    ," + DbAdapter.cite(age) + "    ," + DbAdapter.cite(wrk) + "    ," + DbAdapter.cite(keyword) + "," + DbAdapter.cite(name) + "   ," + DbAdapter.cite(member) + " )");
			}
		} finally
		{
			dbadapter.close();
		}
		_cache.remove(new Integer(id));
	}

	public void delete() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("DELETE FROM ResumeSearchWare WHERE id=" + id);
		} finally
		{
			dbadapter.close();
		}
		_cache.remove(new Integer(id));
	}

	public static java.util.Enumeration findByMember(String member) throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT id FROM ResumeSearchWare WHERE member=" + DbAdapter.cite(member));
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

	public int getId()
	{
		return id;
	}

	public String getOccid()
	{
		return occid;
	}

	public String getCity()
	{
		return city;
	}

	public String getDeg()
	{
		return deg;
	}

	public String getSex()
	{
		return sex;
	}

	public String getAge()
	{
		return age;
	}

	public String getWrk()
	{
		return wrk;
	}

	public String getKeyword()
	{
		return keyword;
	}

	public String getName()
	{
		return name;
	}

	public String getMember()
	{
		return member;
	}
}
