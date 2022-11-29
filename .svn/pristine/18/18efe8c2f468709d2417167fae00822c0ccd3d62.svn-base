package tea.entity.site;

import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;
import tea.resource.*;
import java.util.*;

/*
 招聘地区
 */
public class Jobcity
{
	private static Cache _cache = new Cache(100);
	private int jobcity;
	private int father;
	private String subject;
	private int sequence;
	private boolean exists;
	private String community;
	private String code;

	public Jobcity(int jobcity) throws SQLException
	{
		this.jobcity = jobcity;
		load();
	}

	public static Jobcity find(int jobcity) throws SQLException
	{
		Jobcity obj = (Jobcity) _cache.get(new Integer(jobcity));
		if (obj == null)
		{
			obj = new Jobcity(jobcity);
			_cache.put(new Integer(jobcity), obj);
		}
		return obj;
	}

	public static Jobcity find(String community, String code) throws SQLException
	{
		int id = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT jobcity FROM Jobcity WHERE code=" + DbAdapter.cite(code) + " AND community=" + DbAdapter.cite(community));
			if (db.next())
			{
				id = db.getInt(1);
			}
		} finally
		{
			db.close();
		}
		return find(id);
	}

	public static int getRootId(String community) throws SQLException
	{
		int root = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT jobcity FROM Jobcity WHERE father=0 AND community=" + DbAdapter.cite(community));
			if (db.next())
			{
				root = db.getInt(1);
			}
		} finally
		{
			db.close();
		}
		if (root == 0)
		{
			root = create(0, "", "根", 10, community);
			create(root, "000", "境外", 20, community);
			create(root, "010", "北京", 30, community);
			create(root, "020", "上海", 40, community);
			create(root, "030", "天津", 50, community);
			create(root, "040", "内蒙古", 60, community);
			create(root, "050", "山西", 70, community);
			create(root, "060", "河北", 80, community);
			create(root, "070", "辽宁", 90, community);
			create(root, "080", "吉林", 100, community);
			create(root, "090", "黑龙江", 110, community);
			create(root, "100", "江苏", 120, community);
			create(root, "110", "安徽", 130, community);
			create(root, "120", "山东", 140, community);
			create(root, "130", "浙江", 150, community);
			create(root, "140", "江西", 160, community);
			create(root, "150", "福建", 170, community);
			create(root, "160", "湖南", 180, community);
			create(root, "170", "湖北", 190, community);
			create(root, "180", "河南", 200, community);
			create(root, "190", "广东", 210, community);
			create(root, "200", "海南", 220, community);
			create(root, "210", "广西", 230, community);
			create(root, "220", "贵州", 240, community);
			create(root, "230", "四川", 250, community);
			create(root, "240", "云南", 260, community);
			create(root, "250", "陕西", 270, community);
			create(root, "260", "甘肃", 280, community);
			create(root, "270", "宁夏", 290, community);
			create(root, "280", "青海", 300, community);
			create(root, "290", "新疆", 310, community);
			create(root, "300", "西藏", 320, community);
			create(root, "320", "重庆", 330, community);
			create(root, "330", "香港", 340, community);
			create(root, "340", "澳门", 350, community);
		}
		return root;
	}

	public static Enumeration findByFather(int father) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT jobcity FROM Jobcity WHERE father=" + father + " ORDER BY sequence,subject");
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

	public void set(String code, String subject) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Jobcity SET code=" + DbAdapter.cite(code) + ",subject=" + DbAdapter.cite(subject) + " WHERE jobcity=" + jobcity);
		} finally
		{
			db.close();
		}
		this.exists = true;
		this.code = code;
		this.subject = subject;
	}

	public static int create(int father, String code, String subject, int sequence, String community) throws SQLException
	{
		int i = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Jobcity(father,sequence,community,code,subject)VALUES(" + father + " ," + sequence + " ," + DbAdapter.cite(community) + " ," + DbAdapter.cite(code) + " ," + DbAdapter.cite(subject) + ")");
			i = db.getInt("SELECT MAX(jobcity) from Jobcity");
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(i));
		return i;
	}

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM Jobcity WHERE jobcity=" + jobcity);
		} finally
		{
			db.close();
		}
		this.exists = false;
		_cache.remove(new Integer(jobcity));
	}

	public static String getNextCode(String community) throws SQLException
	{
		String code = "A0";
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT MAX(code) FROM Jobcity WHERE community= " + DbAdapter.cite(community));
			if (db.next())
			{
				code = db.getString(1);
			}
		} finally
		{
			db.close();
		}
		for (int i = code.length(); i > 0; i--)
		{
			int ch = (int) code.charAt(i - 1);
			if (ch == 'Z')
			{
				ch = '1';
				code = code.substring(0, i - 1) + (char) ch + code.substring(i, code.length());
				continue;
			} else if (ch == '9')
			{
				ch = 'A';
			} else
			{
				ch = ch + 1;
			}
			code = code.substring(0, i - 1) + (char) ch + code.substring(i, code.length());
			break;
		}
		return code;
	}

	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT father,code,subject,sequence,community FROM Jobcity WHERE jobcity=" + jobcity);
			if (db.next())
			{
				father = db.getInt(1);
				code = db.getString(2);
				subject = db.getVarchar(1, 1, 3);
				sequence = db.getInt(4);
				community = db.getString(5);
				exists = true;
			} else
			{
				exists = false;
			}
		} finally
		{
			db.close();
		}
	}

	public void setSequenceUp() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		DbAdapter db2 = new DbAdapter();
		try
		{
			db.executeQuery("SELECT jobcity FROM Jobcity WHERE father=" + father + " AND community=" + DbAdapter.cite(community) + " ORDER BY sequence,subject");
			int occ;
			for (int index = 0; db.next(); index += 10)
			{
				occ = db.getInt(1);
				if (occ == this.jobcity)
				{
					db2.executeUpdate("UPDATE Jobcity SET sequence=" + (index - 15) + " WHERE jobcity=" + occ);
				} else
				{
					db2.executeUpdate("UPDATE Jobcity SET sequence=" + index + " WHERE jobcity=" + occ);
				}
			}
		} finally
		{
			db.close();
			db2.close();
		}
	}

	public void setSequenceDown() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		DbAdapter db2 = new DbAdapter();
		try
		{
			db.executeQuery("SELECT jobcity FROM Jobcity WHERE father=" + father + " AND community=" + DbAdapter.cite(community) + " ORDER BY sequence,subject");
			int occ;
			for (int index = 0; db.next(); index += 10)
			{
				occ = db.getInt(1);
				if (occ == this.jobcity)
				{
					db2.executeUpdate("UPDATE Jobcity SET sequence=" + (index + 15) + " WHERE jobcity=" + occ);
				} else
				{
					db2.executeUpdate("UPDATE Jobcity SET sequence=" + index + " WHERE jobcity=" + occ);
				}
			}
		} finally
		{
			db.close();
			db2.close();
		}
	}

	public int getJobcity()
	{
		return jobcity;
	}

	public int getFather()
	{
		return father;
	}

	public String getSubject()
	{
		return subject;
	}

	public int getSequence()
	{
		return sequence;
	}

	public boolean isExists()
	{
		return exists;
	}

	public String getCommunity()
	{
		return community;
	}

	public String getCode()
	{
		return code;
	}

}
