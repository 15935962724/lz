package tea.entity.node;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class Blog extends Entity
{
	private static Cache _cache = new Cache(100);
	private String community;
	private String member;
	private boolean exists;
	private int home;
	private int reportCount;

	public Blog(String community, String member) throws SQLException
	{
		this.community = community;
		this.member = member;
		loadBasic();
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			// dbadapter.executeQuery("SELECT Node.node FROM Template2,Node WHERE Node.father=Template2.node AND Node.rcreator=" + DbAdapter.cite(member) + " AND Template2.community= " + DbAdapter.cite(community));
			dbadapter.executeQuery("SELECT Node.node FROM BLOGCommunity,Node WHERE Node.father=BLOGCommunity.node AND Node.rcreator=" + DbAdapter.cite(member));
			if (dbadapter.next())
			{
				home = dbadapter.getInt(1);
				exists = true;
			} else
			{
				exists = false;
			}
			reportCount = dbadapter.getInt("SELECT COUNT(Node.node) FROM Node WHERE Node.rcreator=" + DbAdapter.cite(member) + " AND Node.community= " + DbAdapter.cite(community));
		} finally
		{
			dbadapter.close();
		}
	}

	// ��ԭ��ʽ(CSS/JS)
	public void revert() throws SQLException
	{
		tea.db.DbAdapter dbadapter = new tea.db.DbAdapter();
		try
		{
			dbadapter.executeUpdate("DELETE  FROM CssJs WHERE CssJs.node=" + this.home);
			dbadapter.executeQuery("SELECT cssjs FROM CssJs WHERE style=2 AND node=" + tea.entity.node.Node.find(this.home).getFather());
			if (dbadapter.next())
			{
				dbadapter.executeUpdate("CssJsHiden " + dbadapter.getInt(1) + ", " + home + ", " + 3); // 3 ������
			}
		} catch (Exception e)
		{
			throw new SQLException(e.toString());
		} finally
		{
			dbadapter.close();
		}
	}

	public static Blog find(String community, String member) throws SQLException
	{
		Blog obj = (Blog) _cache.get(community + ":" + member);
		// if (obj == null)
		{
			obj = new Blog(community, member);
			_cache.put(community + ":" + member, obj);
		}
		return obj;
	}

	public String getCommunity()
	{
		return community;
	}

	public String getMember()
	{
		return member;
	}

	public boolean isExists()
	{
		return exists;
	}

	public int getHome()
	{
		return home;
	}

	public int getReportCount()
	{
		return reportCount;
	}

}
