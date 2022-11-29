package tea.entity.site;

import java.util.Enumeration;
import java.util.Vector;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class Organizer extends Entity
{
    private static Cache _cache = new Cache(100);
    private String community;
    private String member;

    public Organizer(String community,String member)
    {
        this.community = community;
        this.member = member;
    }

    public static Organizer find(String community,String member)
    {
        Organizer obj = (Organizer) _cache.get(community + ":" + member);
        if(obj == null)
        {
            obj = new Organizer(community,member);
            _cache.put(community + ":" + member,obj);
        }
        return obj;
    }

    public static void create(String community,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT community  FROM Organizer WHERE community=" + DbAdapter.cite(community) + " AND member= " + DbAdapter.cite(member));
            if(db.next())
            {
            } else
            {
                db.executeUpdate("INSERT INTO Organizer (community, member) VALUES (" + DbAdapter.cite(community) + ", " + DbAdapter.cite(member) + ")");
            }
        } finally
        {
            db.close();
        }
    }

    public static int countOrganizing(RV rv) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter(1);
        try
        {
            i = db.getInt("SELECT COUNT(community) " + getOrganizingSql(rv));
        } finally
        {
            db.close();
        }
        return i;
    }

    private static String getOrganizingSql(RV rv) throws SQLException
    {
        if(rv.isWebMaster())
        {
            return " FROM Community";
        } else
        {
            return " FROM Organizer  WHERE member=" + DbAdapter.cite(rv._strR);
        }
    }

    public static Enumeration findOrganizing(RV rv) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT community " + getOrganizingSql(rv) + " ORDER BY community");
            while(db.next())
            {
                vector.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static boolean isOrganizer(String community,String member) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT community   FROM Organizer  WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }

    public static void deleteByCommunity(String s) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("DELETE FROM Organizer  WHERE community=" + DbAdapter.cite(s));
        } finally
        {
            db.close();
        }
    }

    public static int count(String s) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter(1);
        try
        {
            i = db.getInt("SELECT COUNT(community)  FROM Organizer  WHERE community=" + DbAdapter.cite(s));
        } finally
        {
            db.close();
        }
        return i;
    }

    public static Enumeration find(String community,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT community,member FROM Organizer WHERE community=" + DbAdapter.cite(community) + " ORDER BY member ",pos,size);
            while(db.next())
            {
                vector.addElement(new Organizer(db.getString(1),db.getString(2)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static Enumeration find(String s,int i,int j,boolean flag) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT rmember FROM Subscriber  WHERE  rmember not in (SELECT member FROM Organizer  WHERE community=" + DbAdapter.cite(s) + ") and community=" + DbAdapter.cite(s) + " ORDER BY rmember");
            for(int k = 0;k < i + j && db.next();k++)
            {
                if(k >= i)
                {
                    vector.addElement(db.getString(1));
                }
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("DELETE FROM Organizer  WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
    }

    public String getMember()
    {
        return member;
    }

    public String getCommunity()
    {
        return community;
    }
}
