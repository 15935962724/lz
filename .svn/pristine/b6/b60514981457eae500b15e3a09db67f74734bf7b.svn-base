package tea.entity.admin;

import java.io.*;
import java.util.Date;
import tea.db.DbAdapter;
import java.sql.SQLException;
import tea.entity.*;
import tea.entity.admin.Bulletin;
import java.sql.SQLException;

public class Attemper extends Entity
{
    private String community;
    private String names;
    private boolean exists;
    private static Cache _cache = new Cache(100);

    public Attemper(String community) throws SQLException
    {
        this.community = community;
        load();
    }

    public static Attemper find(String community) throws SQLException
    {
        return new Attemper(community);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT names  FROM Attemper WHERE community = " + DbAdapter.cite(community));
            if(db.next())
            {
                names = db.getVarchar(1,1,1);

            } else
            {
                this.exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(String names,String community,RV _rv) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT names  FROM Attemper WHERE community = " + DbAdapter.cite(community));
            if(db.next())
            {
                db.executeUpdate("update Attemper set names =" + DbAdapter.cite(names) + " ");
            } else
            {
                db.executeUpdate("INSERT INTO Attemper (names,community,member)VALUES(" + DbAdapter.cite(names) + "," + DbAdapter.cite(community) + ",'" + _rv + "')");
            }
        } finally
        {
            db.close();
        }

    }

    public static java.util.Enumeration findByCommunity(String community,String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community FROM Attemper WHERE community=" + DbAdapter.cite(community) + sql);
            while(db.next())
            {
                vector.addElement(String.valueOf(db.getVarchar(1,1,1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public String getNames()
    {
        return names;
    }
}
