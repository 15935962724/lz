package tea.entity.criterion;

import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class Itemmember extends Entity
{
    private static Cache _cache = new Cache(100);
    private String member;
    private int oldunit;
    private String community;
    private boolean exists;

    public Itemmember(String member,String community) throws SQLException
    {
        this.member = member;
        this.community = community;
        loadBasic();
    }

    public Itemmember(String member,String community,int oldunit)
    {
        this.member = member;
        this.community = community;
        this.oldunit = oldunit;
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT oldunit FROM Itemmember WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
            if(db.next())
            {
                oldunit = db.getInt(1);
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

    public static void create(String member,String community,int oldunit) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Itemmember( member  , community,  oldunit ) VALUES(" + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + "," + oldunit + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(member + ":" + community);
    }

    public void set(int oldunit) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Itemmember SET oldunit=" + oldunit + " WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
        this.oldunit = oldunit;
    }

    public static java.util.Enumeration find(String community,String sql,int pos,int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT outlay FROM Itemmember WHERE community=" + DbAdapter.cite(community) + sql,pos,pageSize);
            while(db.next())
            {
                int Itemmember = db.getInt(1);
                vector.addElement(new Integer(Itemmember));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static Itemmember find(String member,String community) throws SQLException
    {
        Itemmember obj = (Itemmember) _cache.get(member + ":" + community);
        if(obj == null)
        {
            obj = new Itemmember(member,community);
            _cache.put(member + ":" + community,obj);
        }
        return obj;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getOldunit()
    {
        return oldunit;
    }

    public String getMember()
    {
        return member;
    }

    public boolean isExists()
    {
        return exists;
    }

    public static int countByCommunity(String community) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(community) FROM Itemmember WHERE community=" + DbAdapter.cite(community));
            if(db.next())
            {
                j = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return j;
    }

}
