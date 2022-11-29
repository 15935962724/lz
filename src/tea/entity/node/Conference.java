package tea.entity.node;

import java.io.*;

import tea.db.DbAdapter;
import tea.entity.Cache;
import java.sql.SQLException;

public class Conference implements Serializable
{
    private static Cache _cache = new Cache(100);
    private int conference;
    private String name;
    private String ename;
    private boolean exists;
    private String community;

    public Conference()
    {
    }

    public static Conference find(int conference) throws SQLException
    {
        Conference obj = (Conference) _cache.get(new Integer(conference));
        if (obj == null)
        {
            obj = new Conference(conference);
            _cache.put(new Integer(conference), obj);
        }
        return obj;
    }

    public Conference(int conference) throws SQLException
    {
        this.conference = conference;
        loadBasic();
    }

    public void set() throws SQLException
    {
        if (this.isExists())
        {
            DbAdapter dbadapter = new DbAdapter();
            try
            {
                //dbadapter.executeUpdate("ConferenceEdit " +
                                       // conference + "," +
                                       // DbAdapter.cite(name) + "," +
                                       // DbAdapter.cite(ename)
                    //);
            	dbadapter.executeUpdate("UPDATE Conference SET name ="+ DbAdapter.cite(name)+" ,ename="+ DbAdapter.cite(name)+"  WHERE @conference="+conference);
                this.loadBasic();
                _cache.put(new Integer(conference), this);

            } finally
            {
                dbadapter.close();
            }
        } else
            create();
    }

    public void create() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
           // dbadapter.executeUpdate("ConferenceCreate " +
                                   // DbAdapter.cite(community) + "," +
                                   // DbAdapter.cite(name) + "," +
                                   // DbAdapter.cite(ename)
                //);
        	dbadapter.executeUpdate("INSERT INTO Conference(community ,name,ename)VALUES("+DbAdapter.cite(community)+","+name+","+ename +"   )");
            this.loadBasic();
            _cache.put(new Integer(conference), this);
        } finally
        {
            dbadapter.close();
        }
    }

    public void delete() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("DELETE FROM Conference WHERE conference=" + this.conference);
            _cache.remove(new Integer(conference));
        } finally
        {
            dbadapter.close();
        }
    }

    private void loadBasic() throws SQLException
    {
        //if (!_blLoaded)
        {
            DbAdapter dbadapter = new DbAdapter();
            try
            {
                dbadapter.executeQuery("SELECT    name ,ename,community	FROM Conference WHERE conference= " + conference);
                if (dbadapter.next())
                {
                    name = dbadapter.getVarchar(1, 1, 1);
                    ename = dbadapter.getString(2);
                    community = dbadapter.getString(3);
                    exists = true;
                } else
                {
                    exists = false;
                }
            } finally
            {
                dbadapter.close();
            }
        }
    }

    public static java.util.Enumeration findByCommunity(String community) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        java.util.Vector vector = new java.util.Vector();
        try
        {
            dbadapter.executeQuery("SELECT    conference FROM Conference WHERE community= " + DbAdapter.cite(community));
            while (dbadapter.next())
                vector.addElement(new Integer(dbadapter.getInt(1)));
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    private void readObject(ObjectInputStream ois) throws IOException, ClassNotFoundException
    {
        ois.defaultReadObject();
    }

    private void writeObject(ObjectOutputStream oos) throws IOException
    {
        oos.defaultWriteObject();
    }

    public void setConference(int conference)
    {
        this.conference = conference;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public void setEname(String ename)
    {

        this.ename = ename; }

    public void setCommunity(String community)
    {
        this.community = community; }

    public int getConference()
    {
        return conference;
    }

    public String getName()
    {
        return name;
    }

    public String getEname()
    {

        return ename; }

    public boolean isExists()
    {
        return exists; }

    public String getCommunity()
    {
        return community; }
}
