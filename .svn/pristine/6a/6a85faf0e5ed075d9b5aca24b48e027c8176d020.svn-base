package tea.entity.site;
import java.sql.*;
import tea.db.*;
import tea.entity.*;
public class Communitymsn extends Entity
{
    private static Cache _cache = new Cache(100);
    private String community;//板块名
    private String name;//用户名
    private String password;//密码
    private boolean exists;

    public static Communitymsn find(String community) throws SQLException
    {
        Communitymsn obj = (Communitymsn) _cache.get(community);
        if (obj == null)
        {
            obj = new Communitymsn(community);
            _cache.put(community, obj);
        }
        return obj;
    }

    public Communitymsn(String community) throws SQLException
    {
        this.community = community;
        load();
    }
    /**查询一条记录*/
    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT name,password FROM Communitymsn WHERE community=" + DbAdapter.cite(community));
            if (db.next())
            {
                name = db.getString(1);
                password = db.getString(2);
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
    /**更新一条记录*/
    public void set(String name, String password) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.executeUpdate("UPDATE Communitymsn SET name=" + DbAdapter.cite(name) + ",password=" + DbAdapter.cite(password) + " WHERE community=" + DbAdapter.cite(community));
        } finally
        {
            db.close();
        }
        if (j < 1)
        {
            exists = true;
            create(community, name, password);
        }
        this.name = name;
        this.password = password;
    }
    /**插入一条记录*/
    public static void create(String community, String name, String password) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Communitymsn(community,name,password)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(password) + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(community);
    }


    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM communityim WHERE community=" + DbAdapter.cite(community));
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

    public boolean isExists() throws SQLException
    {
        return exists;
    }

    public String getPassword()
    {
        return password;
    }

    public String getName()
    {
        return name;
    }
}
