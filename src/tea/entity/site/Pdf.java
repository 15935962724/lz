package tea.entity.site;

import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class Pdf extends Entity
{
	private static Cache _cache = new Cache(100);
	private String footer;
	private String community;
	private String header;
	private boolean exists;

	public Pdf(String community) throws SQLException
	{
		this.community = community;
		loadBasic();
	}

	public static Pdf find(String community) throws SQLException
	{
		Pdf obj = (Pdf) _cache.get(community);
		if (obj == null)
		{
			obj = new Pdf(community);
			_cache.put(community, obj);
		}
		return obj;
	}

	public void delete() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("DELETE Pdf WHERE domainname=" + DbAdapter.cite(community));
		} finally
		{
			dbadapter.close();
		}
		_cache.remove(community);
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT header,footer FROM Pdf WHERE community=" + DbAdapter.cite(community));
			if (dbadapter.next())
			{
				this.header = dbadapter.getString(1);
				this.footer = dbadapter.getString(2);
				exists = true;
			} else
			{
				header = footer = "/tea/image/public/blank.bmp";
				exists = false;
			}
		} finally
		{
			dbadapter.close();
		}
	}

	public void set(String header, String footer) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			if (this.exists)
			{
				dbadapter.executeUpdate("UPDATE Pdf SET header=" + DbAdapter.cite(header) + ",footer=" + DbAdapter.cite(footer) + " WHERE community=" + DbAdapter.cite(community));
			} else
			{
				dbadapter.executeUpdate("INSERT INTO Pdf(community,header,footer)VALUES(" + DbAdapter.cite(community) + ", " + DbAdapter.cite(header) + ", " + DbAdapter.cite(footer) + ")");
			}
		} finally
		{
			dbadapter.close();
		}
		this.header = header;
		this.community = community;
		this.footer = footer;
		exists = true;
	}

	public String getHeader()
	{
		return header;
	}

	public String getCommunity()
	{
		return community;
	}

	public String getFooter()
	{
		return footer;
	}

	public boolean isExists()
	{
		return exists;
	}
}
