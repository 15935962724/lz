package tea.entity.cio;

import java.sql.*;

import tea.db.*;
import tea.entity.*;
import java.util.Enumeration;
import java.util.Date;
import java.util.Vector;

public class CioClerk extends Entity
{
    private static Cache _cache = new Cache(100);
    private int id;
    private String sname; //接送人姓名
    private String stel; //接送人电话
    private boolean exists;

    public CioClerk(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public CioClerk(int id,String sname,String stel) throws SQLException
    {
        this.id = id;
        this.sname = sname;
        this.stel = stel;
        this.exists = true;
    }

    public static CioClerk find(int id) throws SQLException
    {
        CioClerk obj = (CioClerk) _cache.get(id);
        if(obj == null)
        {
            obj = new CioClerk(id);
            _cache.put(id,obj);
        }
        return obj;
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id,sname,stel from CioClerk where id=" + id);
            if(db.next())
            {
                id = db.getInt(1);
                sname = db.getString(2);
                stel = db.getString(3);
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

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id,sname,stel FROM CioClerk WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                int j = 1;
                int id = db.getInt(j++);

                String sname = db.getString(j++);

                String stel = db.getString(j++);

                CioClerk obj = new CioClerk(id,sname,stel);
                _cache.put(id,obj);
                v.add(obj);
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static void create(String sname,String stel) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Insert into  CioClerk(sname,stel) values(" + db.cite(sname) + "," + db.cite(stel) + ")");
        } finally
        {
            db.close();
        }
    }

    public static void set(int id,String sname,String stel) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update CioClerk set sname=" + db.cite(sname) + ",stel=" + db.cite(stel) + " where id=" + id);
        } finally
        {
            db.close();
        }
    }

    public static void delete(int id) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete CioClerk  where id=" + id);
        } finally
        {
            db.close();
        }
    }


    public boolean isExists()
    {
        return exists;
    }

    public int getId()
    {
        return id;
    }

    public String getSname()
    {
        return sname;
    }

    public String getStel()
    {
        return stel;
    }

}
