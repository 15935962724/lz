package tea.entity.node;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class Discourse extends tea.entity.Entity
{
	private static Cache _cache = new Cache(100);
	private String member;
	private String discourse;
	private String discourseName;
	private String syllabus;
	private String syllabusName;
	private boolean exists;

	public static Discourse find(String member) throws SQLException
	{
		Discourse obj = (Discourse) _cache.get(member);
		if (obj == null)
		{
			obj = new Discourse(member);
			_cache.put(member, obj);
		}
		return obj;
	}

	public static java.util.Enumeration find() throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		tea.db.DbAdapter dbadpater = new tea.db.DbAdapter();
		try
		{
			dbadpater.executeQuery("SELECT member FROM Discourse WHERE NOT syllabus is null OR NOT discourse IS NULL");
			while (dbadpater.next())
			{
				vector.addElement(dbadpater.getString(1));
			}
		} finally
		{
			dbadpater.close();
		}
		return vector.elements();
	}

	public Discourse(String member) throws SQLException
	{
		this.member = member;
		loadBasic();
	}

	/*
	 * public void set() throws SQLException { if (this.isExists()) { DbAdapter dbadapter = new DbAdapter(); try { dbadapter.executeUpdate("UPDATE Discourse SET discourse=" + DbAdapter.cite(discourse) + ",discoursename=" + DbAdapter.cite(discoursename) + ",syllabus=" + DbAdapter.cite(syllabus) + ",syllabusname=" + DbAdapter.cite(syllabusname) + " WHERE member=" + DbAdapter.cite(member)); _cache.remove(member); } catch (Exception exception) { exception.printStackTrace(); throw new
	 * SQLException(exception.toString()); } finally { dbadapter.close(); } } else { // create(); } }
	 */

	public static Discourse create(String member) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("INSERT INTO Discourse(member)VALUES(" + DbAdapter.cite(member) + ")");
			return Discourse.find(member);
		} finally
		{
			dbadapter.close();
		}
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT discourse,discoursename,syllabus,syllabusname 	FROM Discourse WHERE member= " + DbAdapter.cite(member));
			if (dbadapter.next())
			{
				this.discourse = dbadapter.getString(1);
				this.discourseName = dbadapter.getVarchar(1, 1, 2);
				this.syllabus = dbadapter.getString(3);
				this.syllabusName = dbadapter.getVarchar(1, 1, 4);
				exists = true;
			} else
			{
				exists = false;
			}
		} finally
		{
			dbadapter.close();
		}
	}

	public String getMember()
	{
		return member;
	}

	public String getDiscourse()
	{
		return discourse;
	}

	public String getDiscourseName()
	{

		return discourseName;
	}

	public String getSyllabus()
	{
		return syllabus;
	}

	public String getSyllabusName()
	{

		return syllabusName;
	}

	public boolean isExists()
	{
		return exists;
	}

	public void setDiscourse(String discourse, String filename) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			if (discourse != null)
			{
				this.discourse = discourse;
			}
			this.discourseName = filename;
			dbadapter.executeUpdate("UPDATE Discourse SET discourse=" + DbAdapter.cite(this.discourse) + ",discoursename=" + DbAdapter.cite(filename) + " WHERE member=" + DbAdapter.cite(member));
			_cache.remove(member);
		} finally
		{
			dbadapter.close();
		}
	}

	public void deleteDiscourse() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("UPDATE Discourse SET discourse=null,discoursename=null WHERE member=" + DbAdapter.cite(member));
			_cache.remove(member);
		} finally
		{
			dbadapter.close();
		}
	}

	public void setSyllabus(String syllabus, String filename) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			if (syllabus != null)
			{
				this.syllabus = syllabus;
			}
			this.syllabusName = filename;
			dbadapter.executeUpdate("UPDATE Discourse SET syllabus=" + DbAdapter.cite(this.syllabus) + ",syllabusname=" + DbAdapter.cite(filename) + " WHERE member=" + DbAdapter.cite(member));
			_cache.remove(member);
		} finally
		{
			dbadapter.close();
		}
	}

	public void deleteSyllabus() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("UPDATE Discourse SET syllabus=null,syllabusname=null WHERE member=" + DbAdapter.cite(member));
			_cache.remove(member);
		} finally
		{
			dbadapter.close();
		}
	}
}
