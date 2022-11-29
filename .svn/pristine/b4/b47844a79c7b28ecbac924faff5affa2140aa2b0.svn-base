package tea.newer;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import tea.db.DbAdapter;
import tea.entity.*;

public class Newexperts
{

    private static Cache c = new Cache(50);
    private int eid; //专家id
    private String ename; //专家姓名
    public static Newexperts finds(int id) throws SQLException
    {
        Newexperts np = null;
        List list = null;
        np = (Newexperts) c.get(new Integer(id));
        if(np == null)
        {
            list = findList(" AND eid=" + id,0,10);
            np = (list.size() > 0) ? (Newexperts) list.get(0) : new Newexperts(id);
        }
        return np;
    }

    public Newexperts(int id)
    {
        this.eid = id;
    }

    public Newexperts(int id,String name)
    {
        this.eid = id;
        this.ename = name;
    }

    public static List findList(String sql,int page,int size) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        List list = new ArrayList();
        try
        {
            db.executeQuery("SELECT eid,ename FROM newexperts where 1=1 " + sql,page,size);
            while(db.next())
            {
                Newexperts np = new Newexperts(db.getInt(1),db.getString(2));
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
        String sql;
        if(eid > 0)
            sql = "UPDATE newexperts SET ename=" + DbAdapter.cite(ename) + " WHERE eid=" + eid;
        else
            sql = "INSERT INTO newexperts(eid,ename) values (" + (eid = Seq.get()) + "," + DbAdapter.cite(ename) + ")";
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(eid,sql);
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
            db.executeUpdate(eid,"UPDATE newexperts SET " + key + " = " + db.cite(value) + " WHERE eid=" + this.getEid());
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
            db.executeUpdate(eid,"DELETE FROM newexperts WHERE eid=" + this.getEid());
        } finally
        {
            db.close();
        }
    }

    public static int count() throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM newexperts");
    }

    public int getEid()
    {
        return eid;
    }

    public void setEid(int eid)
    {
        this.eid = eid;
    }

    public String getEname()
    {
        return ename;
    }

    public void setEname(String ename)
    {
        this.ename = ename;
    }

    public String toString()
    {
        StringBuilder sb = new StringBuilder();
        sb.append("{}");
        return sb.toString();
    }
}
