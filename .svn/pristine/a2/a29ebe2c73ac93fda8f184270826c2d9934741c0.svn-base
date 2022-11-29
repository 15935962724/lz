package tea.entity.copyright;

import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;
import java.util.*;

public class Crtransfer extends Entity
{
    public static Cache _cache = new Cache(100);
    private int crtransfer;
    private String community;
    private String scrbid;
    private String heir;
    private String heirnation;
    private String droit;
    private Date startdate;
    private Date enddate;
    private Date passdate;

    public Crtransfer(int crtransfer) throws SQLException
    {
        this.crtransfer = crtransfer;
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,scrbid,heir,heirnation,droit,startdate,enddate,passdate FROM crtransfer WHERE crtransfer=" + crtransfer);
            if(db.next())
            {
                community = db.getString(1);
                scrbid = db.getString(2);
                heir = db.getString(3);
                heirnation = db.getString(4);
                droit = db.getString(5);
                startdate = db.getDate(6);
                enddate = db.getDate(7);
                passdate = db.getDate(8);
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(String community,String scrbid,String heir,String heirnation,String droit,Date startdate,Date enddate,Date passdate) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO crtransfer(community,scrbid,heir,heirnation,droit,startdate,enddate,passdate)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(scrbid) + "," + DbAdapter.cite(heir)
                             + "," + DbAdapter.cite(heirnation) + "," + DbAdapter.cite(droit) + "," + DbAdapter.cite(startdate) + "," + DbAdapter.cite(enddate) + "," + DbAdapter.cite(passdate) + ")");
        } finally
        {
            db.close();
        }
        // _cache.remove(new Integer(crtransfer));
    }

    public void set(String scrbid,String heir,String heirnation,String droit,Date startdate,Date enddate,Date passdate) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE crtransfer SET scrbid=" + DbAdapter.cite(scrbid) + ",heir=" + DbAdapter.cite(heir) + ",heirnation=" + DbAdapter.cite(heirnation) + ",droit=" + DbAdapter.cite(droit) + ",startdate="
                             + DbAdapter.cite(startdate) + ",enddate=" + DbAdapter.cite(enddate) + ",passdate=" + DbAdapter.cite(passdate) + " WHERE crtransfer=" + crtransfer);
        } finally
        {
            db.close();
        }
        this.scrbid = scrbid;
        this.heir = heir;
        this.heirnation = heirnation;
        this.droit = droit;
        this.startdate = startdate;
        this.enddate = enddate;
        this.passdate = passdate;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM crtransfer WHERE crtransfer=" + crtransfer);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(crtransfer));
    }

    public String getDroit()
    {
        return droit;
    }

    public Date getEnddate()
    {
        return enddate;
    }

    public String getEnddateToString()
    {
        if(enddate == null)
        {
            return "";
        }
        return sdf.format(enddate);
    }

    public String getHeir()
    {
        return heir;
    }

    public String getHeirnation()
    {
        return heirnation;
    }

    public Date getPassdate()
    {
        return passdate;
    }

    public String getPassdateToString()
    {
        if(passdate == null)
        {
            return "";
        }
        return sdf.format(passdate);
    }

    public String getScrbid()
    {
        return scrbid;
    }

    public Date getStartdate()
    {
        return startdate;
    }

    public String getStartdateToString()
    {
        if(startdate == null)
        {
            return "";
        }
        return sdf.format(startdate);
    }

    public int getCrtransfer()
    {
        return crtransfer;
    }

    public static Crtransfer find(int crtransfer) throws SQLException
    {
        Crtransfer obj = (Crtransfer) _cache.get(new Integer(crtransfer));
        if(obj == null)
        {
            obj = new Crtransfer(crtransfer);
            _cache.put(new Integer(crtransfer),obj);
        }
        return obj;
    }

    public static int find(String scrbid) throws SQLException
    {
        int crtransfer = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT crtransfer FROM crtransfer WHERE scrbid=" + DbAdapter.cite(scrbid));
            if(db.next())
            {
                crtransfer = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return crtransfer;
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(crtransfer) FROM crtransfer WHERE community=" + DbAdapter.cite(community) + sql);
            if(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT crtransfer FROM crtransfer WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }
}
