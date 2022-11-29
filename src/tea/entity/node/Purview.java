package tea.entity.node;

import tea.db.DbAdapter;
import java.sql.SQLException;
import java.sql.SQLException;

/**
 * <p>Title: 企业发展网络系统平台</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * @version 2004
 */
public class Purview
{
    private String member;
    private String node;
    private boolean job;
    private boolean resume;
    private boolean apply;
    private boolean company;
    private boolean exists;
    private String community;
    private int purview;
    public Purview()
    {

    }

    public Purview(String member, String community) throws SQLException
    {
        this.member = member;
        this.community = community;

        loadBasic();
    }

    public static void create(String member, String community, String node, boolean job, boolean resume, boolean apply, boolean company) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("INSERT INTO Purview(username,community,company,job,resume,apply,comp)VALUES(" + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(node) + "," + (job ? "1" : "0") + "," + (resume ? "1" : "0") + "," + (apply ? "1" : "0") + "," + (company ? "1" : "0") + ")");
        } finally
        {
            dbadapter.close();
        }
    }

    public void set(String node, boolean job, boolean resume, boolean apply, boolean company) throws SQLException
    {
        if (this.isExists())
        {
            DbAdapter dbadapter = new DbAdapter();
            try
            {
                dbadapter.executeUpdate("UPDATE Purview set company=" + DbAdapter.cite(node) + ",job=" + (job ? "1" : "0") + ",resume=" + (resume ? "1" : "0") + ",apply=" + (apply ? "1" : "0") + ",comp=" + (company ? "1" : "0") + " WHERE username=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
            } finally
            {
                dbadapter.close();
            }
        } else
        {
            create(member, community, node, job, resume, apply, company);
        }
    }

    public boolean isExists() throws SQLException
    {
//        loadBasic();
        return exists;
    }

    private void loadBasic() throws SQLException
    {
        //if (!_blLoaded)
        {
            DbAdapter dbadapter = new DbAdapter();
            try
            {
                dbadapter.executeQuery("SELECT  company, job, resume, apply, comp FROM Purview  WHERE username=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
                if (dbadapter.next())
                {
                    node = dbadapter.getString(1);
                    job = dbadapter.getInt(2) != 0;
                    resume = dbadapter.getInt(3) != 0;
                    apply = dbadapter.getInt(4) != 0;
                    company = dbadapter.getInt(5) != 0;
                    exists = true;
                } else
                {
                    exists = false;
                }
                if (node == null)
                {
                    node = "/";
                }
            } finally
            {
                dbadapter.close();
            }
            //  _blLoaded = true;
        }
    }

    public static Purview find(String member, String community) throws SQLException
    {
        return new Purview(member, community);
    }

    public String getMember()
    {
        return member;
    }

    public String getNode()
    {
        return node;
    }


    public static int countByCommunity(String community)
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            return dbadapter.getInt("SELECT count(username) FROM Purview WHERE community=" + DbAdapter.cite(community));
        } catch (SQLException ex)
        {
            ex.printStackTrace();
            return 0;
        } finally
        {
            dbadapter.close();
        }
    }

    public boolean isJob()
    {
        return job;
    }

    public boolean isResume()
    {
        return resume;
    }

    public boolean isApply()
    {
        return apply;
    }

    public boolean isCompany()
    {
        return company;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getPurview()
    {
        return purview;
    }
}
