package tea.entity.site;

import java.sql.*;

import tea.db.*;
import tea.entity.*;

public class Communitybbs
{
    private static Cache _cache = new Cache(20);
    private String community;
    private boolean exists;
    private String superhost;
    private int upFileType; // 0:隐藏  1：显示     上传附件

    public static Communitybbs find(String community) throws SQLException
    {
        Communitybbs obj = (Communitybbs) _cache.get(community);
        if(obj == null)
        {
            obj = new Communitybbs(community);
            _cache.put(community,obj);
        }
        return new Communitybbs(community);
    }

    public Communitybbs(String community) throws SQLException
    {
        this.community = community;
        loadBasic();
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT superhost,upfiletype FROM Communitybbs WHERE community=" + DbAdapter.cite(community));
            if(db.next())
            {
                superhost = db.getString(1);
                upFileType = db.getInt(2);
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

    public void set(String superhost) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.executeUpdate("UPDATE Communitybbs SET superhost=" + DbAdapter.cite(superhost) + " WHERE community=" + DbAdapter.cite(community));
        } finally
        {
            db.close();
        }
        this.exists = true;
        this.superhost = superhost;
        if(j == 0)
        {
            create(community,superhost,0);
        }
    }

    public void set(String community1,int upFileType) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.executeUpdate("UPDATE Communitybbs SET upfiletype=" + upFileType + " WHERE community=" + DbAdapter.cite(community1));
        } finally
        {
            db.close();
        }
        this.exists = true;
        this.upFileType = upFileType;

        if(j == 0)
        {
            create(community1,superhost,upFileType);
        }
    }


    public static void create(String community,String superhost,int upFileType) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Communitybbs(community,superhost,upfiletype)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(superhost) + "," + upFileType + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(community);
    }

    public String getCommunity()
    {
        return community;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getSuperhost()
    {
        return superhost;
    }

    public int getUpFileType()
    {
        return upFileType;
    }
}
