package tea.entity.member;

import java.util.*;

import tea.entity.*;
import tea.db.*;
import java.sql.SQLException;

public class Inhabit extends Entity
{
	public static String ANSSA_TYPE[][] = { { "1", "长期居住" }, { "2", "临时居住" }, { "3", "家庭地址" }, { "4", "紧急联系地址" }, { "5", "邮寄地址" }, { "9001", "户籍地址" } };
	private static Cache _cache = new Cache(100);
	private Date endda;
	private String anssa;
	private String name2;
	private String stras;
	private String orto1;
	private String pstlz;
	private String land1;
	private String state;
	private int inhabit;
	private Date begda;
	private String member;
	private boolean exists;

	public Inhabit(int inhabit) throws SQLException
	{
		this.inhabit = inhabit;
		loadBasic();
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT member,begda ,endda ,anssa ,name2 ,stras ,orto1 ,pstlz ,land1 ,state  FROM Inhabit WHERE inhabit=" + inhabit);
			if (db.next())
			{
				member = db.getString(1);
				begda = db.getDate(2);
				endda = db.getDate(3);
				anssa = db.getString(4);
				name2 = db.getVarchar(1, 1, 5);
				stras = db.getVarchar(1, 1, 6);
				orto1 = db.getVarchar(1, 1, 7);
				pstlz = db.getString(8);
				land1 = db.getString(9);
				state = db.getVarchar(1, 1, 10);
				exists = true;
			} else
			{
				exists = false;
				land1 = "CN";
			}
		} finally
		{
			db.close();
		}
	}

	public static Inhabit find(int inhabit) throws SQLException
	{
		Inhabit obj = (Inhabit) _cache.get(new Integer(inhabit));
		if (obj == null)
		{
			obj = new Inhabit(inhabit);
			_cache.put(new Integer(inhabit), obj);
		}
		return obj;
	}

	public void set() throws SQLException
	{
		tea.db.DbAdapter db = new tea.db.DbAdapter();
		try
		{
			// db.executeUpdate("InhabitEdit " + inhabit + "," +
			// DbAdapter.cite(member) + "," + DbAdapter.cite(begda)
			// + "," + DbAdapter.cite(endda) + "," + DbAdapter.cite(anssa)
			// + "," + DbAdapter.cite(name2) + "," + DbAdapter.cite(stras)
			// + "," + DbAdapter.cite(orto1) + "," + DbAdapter.cite(pstlz)
			// + "," + DbAdapter.cite(land1) + "," + DbAdapter.cite(state));
			db.executeQuery("SELECT inhabit FROM Inhabit WHERE inhabit=" + inhabit);
			if (db.next())
			{
				db.executeUpdate("UPDATE Inhabit SET begda =" + DbAdapter.cite(begda) + " ,endda =" + DbAdapter.cite(endda) + " ,anssa =" + DbAdapter.cite(anssa) + " ,name2 =" + DbAdapter.cite(name2) + " ,stras =" + DbAdapter.cite(stras) + " ,orto1 =" + DbAdapter.cite(orto1) + " ,pstlz =" + DbAdapter.cite(pstlz) + " ,land1 =" + DbAdapter.cite(land1) + " ,state =" + DbAdapter.cite(state) + "  WHERE inhabit=" + inhabit);
			} else
			{
				db.executeUpdate("INSERT INTO Inhabit (member,begda ,endda ,anssa ,name2 ,stras ,orto1 ,pstlz ,land1 ,state)VALUES (" + DbAdapter.cite(member) + "," + DbAdapter.cite(begda) + " ," + DbAdapter.cite(endda) + " ," + DbAdapter.cite(anssa) + " ," + DbAdapter.cite(name2) + " ," + DbAdapter.cite(stras) + "," + DbAdapter.cite(orto1) + " ," + DbAdapter.cite(pstlz) + " ," + DbAdapter.cite(land1) + " ," + DbAdapter.cite(state) + ")");
			}
		} finally
		{
			db.close();
		}
		_cache.remove(new java.lang.Integer(inhabit));
	}

	public void delete() throws SQLException
	{
		tea.db.DbAdapter db = new tea.db.DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM Inhabit WHERE inhabit=" + inhabit);
		} finally
		{
			db.close();
		}
		this.exists = false;
		_cache.remove(new java.lang.Integer(inhabit));
	}

	public static java.util.Enumeration findByMember(String member) throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		tea.db.DbAdapter db = new tea.db.DbAdapter();
		try
		{
			db.executeQuery("SELECT inhabit FROM Inhabit WHERE member=" + DbAdapter.cite(member));
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

	public static Inhabit findByLast(String member) throws SQLException
	{
		int id = 0;
		tea.db.DbAdapter db = new tea.db.DbAdapter();
		try
		{
			db.executeQuery("SELECT inhabit FROM Inhabit WHERE member=" + DbAdapter.cite(member) + " AND endda IS NULL ORDER BY begda DESC");
			if (db.next())
			{
				id = db.getInt(1);
			} else
			{
				db.executeQuery("SELECT inhabit FROM Inhabit WHERE member=" + DbAdapter.cite(member) + " ORDER BY endda DESC");
				if (db.next())
				{
					id = db.getInt(1);
				}
			}
		} finally
		{
			db.close();
		}
		return find(id);
	}

	public void setEndda(Date endda)
	{
		this.endda = endda;
	}

	public void setAnssa(String anssa)
	{
		this.anssa = anssa;
	}

	public void setName2(String name2)
	{
		this.name2 = name2;
	}

	public void setStras(String stras)
	{
		this.stras = stras;
	}

	public void setOrto1(String orto1)
	{
		this.orto1 = orto1;
	}

	public void setPstlz(String pstlz)
	{
		this.pstlz = pstlz;
	}

	public void setLand1(String land1)
	{
		this.land1 = land1;
	}

	public void setState(String state)
	{
		this.state = state;
	}

	public void setBegda(Date begda)
	{
		this.begda = begda;
	}

	public void setMember(String member)
	{
		this.member = member;
	}

	public void setInhabit(int inhabit)
	{
		this.inhabit = inhabit;
	}

	public void setExists(boolean exists)
	{
		this.exists = exists;
	}

	public Date getEndda()
	{
		return endda;
	}

	public String getEnddaToString()
	{
		if (endda == null)
		{
			return "至今";
		} else
		{
			return sdf.format(endda);
		}
	}

	public String getAnssa()
	{
		return anssa;
	}

	public String getName2()
	{
		return name2;
	}

	public String getStras()
	{
		return stras;
	}

	public String getOrto1()
	{
		return orto1;
	}

	public String getPstlz()
	{
		return pstlz;
	}

	public String getLand1()
	{
		return land1;
	}

	public String getState()
	{
		return state;
	}

	public int getInhabit()
	{
		return inhabit;
	}

	public Date getBegda()
	{
		return begda;
	}

	public String getBegdaToString()
	{
		return sdf.format(begda);
	}

	public String getMember()
	{
		return member;
	}

	public boolean isExists()
	{
		return exists;
	}

}
