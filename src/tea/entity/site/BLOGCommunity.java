package tea.entity.site;

import tea.entity.*;
import tea.db.DbAdapter;
import java.sql.SQLException;

public class BLOGCommunity extends Entity
{
    private static Cache _cache = new Cache(100);
    private String community;
    private int node;
    private int cssjs;
    private String picture;

    public BLOGCommunity(String community) throws SQLException
    {
        this.community = community;
        load();
    }

    public static BLOGCommunity find(String name) throws SQLException
    {
        BLOGCommunity community = (BLOGCommunity) _cache.get(name);
        if(community == null)
        {
            community = new BLOGCommunity(name);
            _cache.put(name,community);
        }
        return community;
    }

    public void set(int node,int cssjs,String picture) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            // db.executeUpdate("BLOGCommunityEdit " + DbAdapter.cite(community) + ", " + node + ", " + cssjs + ", " + DbAdapter.cite(picture));

            db.executeQuery("SELECT community FROM BLOGCommunity WHERE community=" + DbAdapter.cite(community));
            if(db.next())
            {
                db.executeUpdate("UPDATE BLOGCommunity SET node=" + node + ",cssjs =" + cssjs + " ,picture =" + DbAdapter.cite(picture) + "  WHERE community=" + DbAdapter.cite(community) + "");
            } else
            {
                db.executeUpdate("INSERT INTO BLOGCommunity (community  ,node,cssjs ,picture  )VALUES ( " + DbAdapter.cite(community) + "  ," + node + "  ," + cssjs + "   ," + DbAdapter.cite(picture) + ")");
            }
            this.node = node;
            this.cssjs = cssjs;
            this.picture = picture;
        } finally
        {
            db.close();
        }
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node,cssjs,picture FROM BLOGCommunity WHERE community=" + DbAdapter.cite(community));
            if(db.next())
            {
                this.node = db.getInt(1);
                this.cssjs = db.getInt(2);
                this.picture = db.getString(3);
            }
        } finally
        {
            db.close();
        }
    }

    public String getCommunity()
    {
        return community;
    }

    public int getNode()
    {
        return node;
    }

    public int getCssjs()
    {
        return cssjs;
    }

    public String getPicture()
    {
        return picture;
    }

}
