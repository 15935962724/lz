package tea.entity.criterion;

import java.util.Date;

import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class Egqb extends Entity
{
	private static Cache _cache = new Cache(100);
	// private static final java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-hh HH:mm");
	private int egqb;
	private int item;
	private String question;
	private String advice;
	private String result;
	private String fileuri;
	private String filename;
	private Date time;

	public Egqb(int egqb) throws SQLException
	{
		this.egqb = egqb;
		loadBasic();
	}

	public Egqb(int egqb, int item, String question, String advice, String result, String fileuri)
	{
		this.egqb = egqb;
		this.item = item;
		this.question = question;
		this.advice = advice;
		this.result = result;
		this.fileuri = fileuri;
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT  item,question,advice,result,fileuri,filename,time FROM Egqb WHERE egqb=" + (egqb));
			if (db.next())
			{
				item = db.getInt(1);
				question = db.getVarchar(1, 1, 2);
				advice = db.getVarchar(1, 1, 3);
				result = db.getVarchar(1, 1, 4);
				fileuri = db.getString(5);
				filename = db.getString(6);
				time = db.getDate(7);
			}
		} finally
		{
			db.close();
		}
	}

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE Egqb WHERE egqb=" + egqb);
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(egqb));
	}

	public static void create(int item, String question, String advice, String result, String fileuri, String filename) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Egqb(  item,  question    ,advice ,result  ,fileuri,filename,time) VALUES(" + (item) + "," + DbAdapter.cite(question) + "," + DbAdapter.cite(advice) + "," + DbAdapter.cite(result) + "," + DbAdapter.cite(fileuri) + "," + DbAdapter.cite(filename) + "," + DbAdapter.cite(new java.util.Date()) + ")");
		} finally
		{
			db.close();
		}
	}

	public void set(int item, String question, String advice, String result, String fileuri, String filename) throws SQLException
	{
		if (fileuri == null)
		{
			fileuri = this.fileuri;
			filename = this.filename;
		} else
		{
			this.fileuri = fileuri;
			this.filename = filename;
		}
		time = new java.util.Date();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Egqb SET item=" + (item) + ",question=" + DbAdapter.cite(question) + ",advice=" + DbAdapter.cite(advice) + ",result=" + DbAdapter.cite(result) + ",fileuri=" + DbAdapter.cite(fileuri) + ",filename=" + DbAdapter.cite(filename) + ",time=" + DbAdapter.cite(time) + " WHERE egqb=" + egqb);
		} finally
		{
			db.close();
		}
		this.item = item;
		this.question = question;
		this.advice = advice;
		this.result = result;
		// _cache.remove(new Integer(egqb));
	}

	public static java.util.Enumeration find(String community, String sql, int pos, int pageSize) throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT egqb FROM Egqb e,Item i WHERE i.item=e.item AND i.community=" + DbAdapter.cite(community) + sql);
			for (int l = 0; l < (pos + pageSize) && db.next(); l++)
			{
				if (l >= pos)
				{
					int egqb = db.getInt(1);
					vector.addElement(new Integer(egqb));
				}
			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public static Egqb find(int egqb) throws SQLException
	{
		Egqb obj = (Egqb) _cache.get(new Integer(egqb));
		if (obj == null)
		{
			obj = new Egqb(egqb);
			_cache.put(new Integer(egqb), obj);
		}
		return obj;
	}

	public static int countByCommunity(String community) throws SQLException
	{
		int j = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT COUNT(community) FROM Outlay WHERE community=" + DbAdapter.cite(community));
			if (db.next())
			{
				j = db.getInt(1);
			}
		} finally
		{
			db.close();
		}
		return j;
	}

	public String getAdvice()
	{
		return advice;
	}

	public int getEgqb()
	{
		return egqb;
	}

	public String getFileuri()
	{
		return fileuri;
	}

	public int getItem()
	{
		return item;
	}

	public String getQuestion()
	{
		return question;
	}

	public String getResult()
	{
		return result;
	}

	public String getFilename()
	{
		return filename;
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

}
