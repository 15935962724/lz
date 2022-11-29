package tea.newer;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import tea.db.DbAdapter;
import tea.entity.Cache;

public class Newproviders
{
    private static Cache c = new Cache(50);
    private int nid; //新闻提供者id
    private String nname; //新闻提供者姓名
    public static Newproviders finds(int id) throws SQLException
    {
        Newproviders np = null;
        List list = null;
        np = (Newproviders) c.get(new Integer(id));
        if(np == null)
        {
            list = findList(" AND nid=" + id,0,10);
            np = (list.size() > 0) ? (Newproviders) list.get(0) : new Newproviders(id);
        }
        return np;
    }

    public Newproviders(int id)
    {
        this.nid = id;
    }

    public Newproviders(int id,String name)
    {
        this.nid = id;
        this.nname = name;

    }

    public static List findList(String sql,int page,int size) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        List list = new ArrayList();
        try
        {
            db.executeQuery("SELECT nid,nname FROM newproviders where 1=1 " + sql,page,size);
            while(db.next())
            {
                Newproviders np = new Newproviders(db.getInt(1),db.getString(2));
                list.add(np);
            }
        } finally
        {
            db.close();
        }
        return list;

    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(this.getNid() > 0)
            {
                db.executeUpdate("UPDATE newProviders SET nname= " + db.cite(this.getNname()) + " WHERE nid=" + this.getNid());
            } else
            {
                db.executeUpdate("INSERT INTO newProviders(nname) values (" + db.cite(this.getNname()) + ")");
            }
        } finally
        {
            db.close();
        }
    }

    public void set(String key,String value) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE newProviders SET " + key + " = " + db.cite(value) + " WHERE nid=" + this.getNid());
        } finally
        {
            db.close();
        }

    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM newProviders WHERE nid=" + this.getNid());
        } finally
        {
            db.close();
        }

    }

    public static int count() throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) from newProviders");
    }

    public int getNid()
    {
        return nid;
    }

    public void setNid(int nid)
    {
        this.nid = nid;
    }

    public String getNname()
    {
        return nname;
    }

    public void setNname(String nname)
    {
        this.nname = nname;
    }

    public String toString()
    {
        StringBuilder sb = new StringBuilder();
        sb.append("{}");
        return sb.toString();
    }
}
