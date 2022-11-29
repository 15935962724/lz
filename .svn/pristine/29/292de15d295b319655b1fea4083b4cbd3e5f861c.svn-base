package tea.entity.admin.sales;

import java.io.*;
import java.util.Date;
import tea.db.DbAdapter;
import java.sql.SQLException;
import tea.entity.*;

public class Document extends Entity
{
	private int id;
	private String documentname;
	private String keyword;
	private String fileold;
	private String files;
	private String fileurl;
	private String remark;
	private String filetype;
	private Date times;
	private String member;
	private Date timeamend;
	private String memberamend;

	private boolean exists;
	private static Cache _cache = new Cache(100);

	public Document(int id) throws SQLException
	{
		this.id = id;
		load();
	}

	public static Document find(int id) throws SQLException
	{
		return new Document(id);
	}

	public void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("select documentname,keyword,fileold,files,fileurl,remark,filetype,times,member,timeamend,memberamend from Document where id =" + id);
			if (db.next())
			{
				documentname = db.getVarchar(1, 1, 1);
				keyword = db.getVarchar(1, 1, 2);
				fileold = db.getVarchar(1, 1, 3);
				files = db.getVarchar(1, 1, 4);
				fileurl = db.getVarchar(1, 1, 5);
				remark = db.getVarchar(1, 1, 6);
				filetype = db.getVarchar(1, 1, 7);
				times = db.getDate(8);
				member = db.getVarchar(1, 1, 9);
				timeamend = db.getDate(10);
				memberamend = db.getVarchar(1, 1, 11);
			} else
			{
				this.exists = false;
			}} finally
		{
			db.close();
		}
	}

	public static int create(String documentname, String keyword, String fileold, String files, String fileurl, String remark, String filetype, RV _rv, String community) throws SQLException
	{
		int id = 0;
		Date times = new Date();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Document (documentname,keyword,fileold,files,fileurl,remark,filetype,times,member,community) VALUES(" + DbAdapter.cite(documentname) + "," + DbAdapter.cite(keyword) + "," + DbAdapter.cite(fileold) + " ," + DbAdapter.cite(files) + "," + DbAdapter.cite(fileurl) + "," + DbAdapter.cite(remark) + "," + DbAdapter.cite(filetype) + "," + DbAdapter.cite(times) + " ,'" + _rv + "'," + DbAdapter.cite(community) + "   )");
			id = db.getInt("SELECT MAX(id) FROM Document");} finally
		{
			db.close();
		}
		_cache.remove(new Integer(id));
		return id;
	}

	public void set(String documentname, String keyword, String fileold, String files, String fileurl, String remark, String filetype, RV _rv, String community) throws SQLException
	{
		Date timeamend = new Date();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Document SET documentname=" + DbAdapter.cite(documentname) + ",keyword=" + DbAdapter.cite(keyword) + ",fileold=" + DbAdapter.cite(fileold) + ",files=" + DbAdapter.cite(files) + ",fileurl=" + DbAdapter.cite(fileurl) + ",filetype=" + DbAdapter.cite(filetype) + ",remark=" + DbAdapter.cite(remark) + " ,timeamend=" + DbAdapter.cite(timeamend) + ",memberamend='" + _rv + "',community=" + DbAdapter.cite(community) + "  WHERE id =" + id);} finally
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
			dbadapter.executeQuery("SELECT id FROM Document WHERE community=" + DbAdapter.cite(community) + sql);
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
			dbadapter.executeUpdate("DELETE FROM Document WHERE id=" + id);} finally
		{
			dbadapter.close();
		}
		_cache.remove(new Integer(id));
	}

	public String getDocumentname()
	{
		return documentname;
	}

	public String getKeyword()
	{
		return keyword;
	}

	public String getFileold()
	{
		return fileold;
	}

	public String getFiles()
	{
		return files;
	}

	public String getFileurl()
	{
		return fileurl;
	}

	public String getRemark()
	{
		return remark;
	}

	public String getFiletype()
	{
		return filetype;
	}

	public Date getTimes()
	{
		return times;
	}

	public String getMember()
	{
		return member;
	}

	public Date getTimeamend()
	{
		return timeamend;
	}

	public String getMemberamend()
	{
		return memberamend;
	}

}
