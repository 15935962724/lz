package tea.entity.copyright;

import tea.db.DbAdapter;
import tea.entity.*;

import java.util.*;
import java.sql.SQLException;

public class Crbargain extends Entity
{
    public static Cache _cache = new Cache(100);
    private int crbargain;
    private String community;
    private String scrbid;
    private String name;
    private String pubarea;
    private String crto;
    private String pubyear;
    private String impower;
    private String remark;
    private boolean flag;

    public Crbargain(int crbargain) throws SQLException
    {
        this.crbargain = crbargain;
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,scrbid,name,pubarea,crto,pubyear,impower,remark,flag FROM crbargain WHERE crbargain=" + crbargain);
            if(db.next())
            {
                community = db.getString(1);
                scrbid = db.getString(2);
                name = db.getString(3);
                pubarea = db.getString(4);
                crto = db.getString(5);
                pubyear = db.getString(6);
                impower = db.getString(7);
                remark = db.getString(8);
                flag = db.getInt(9) != 0;
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(String community,String scrbid,String name,String pubarea,String crto,String pubyear,String impower,String remark,boolean flag) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO crbargain(community,scrbid,name,pubarea,crto,pubyear,impower,remark,flag)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(scrbid) + "," + DbAdapter.cite(name) + ","
                             + DbAdapter.cite(pubarea) + "," + DbAdapter.cite(crto) + "," + DbAdapter.cite(pubyear) + "," + DbAdapter.cite(impower) + "," + DbAdapter.cite(remark) + "," + DbAdapter.cite(flag) + ")");
        } finally
        {
            db.close();
        }
        // _cache.remove(new Integer(crbargain));
    }

    public void set(String scrbid,String name,String pubarea,String crto,String pubyear,String impower,String remark,boolean flag) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE crbargain SET scrbid=" + DbAdapter.cite(scrbid) + ",name=" + DbAdapter.cite(name) + ",pubarea=" + DbAdapter.cite(pubarea) + ",crto=" + DbAdapter.cite(crto) + ",pubyear=" + DbAdapter.cite(pubyear)
                             + ",impower=" + DbAdapter.cite(impower) + ",remark=" + DbAdapter.cite(remark) + ",flag=" + DbAdapter.cite(flag) + " WHERE crbargain=" + crbargain);
        } finally
        {
            db.close();
        }
        this.scrbid = scrbid;
        this.name = name;
        this.pubarea = pubarea;
        this.crto = crto;
        this.pubyear = pubyear;
        this.impower = impower;
        this.remark = remark;
        this.flag = flag;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM crbargain WHERE crbargain=" + crbargain);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(crbargain));
    }

    public String getCrto()
    {
        return crto;
    }

    public boolean isFlag()
    {
        return flag;
    }

    public String getName()
    {
        return name;
    }

    public String getPubarea()
    {
        return pubarea;
    }

    public String getPubyear()
    {
        return pubyear;
    }

    public String getScrbid()
    {
        return scrbid;
    }

    public String getRemark()
    {
        return remark;
    }

    public String getImpower()
    {
        return impower;
    }

    public int getCrbargain()
    {
        return crbargain;
    }

    public static int find(String scrbid) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT crbargain FROM crbargain WHERE scrbid=" + DbAdapter.cite(scrbid));
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

    public static Crbargain find(int crbargain) throws SQLException
    {
        Crbargain obj = (Crbargain) _cache.get(new Integer(crbargain));
        if(obj == null)
        {
            obj = new Crbargain(crbargain);
            _cache.put(new Integer(crbargain),obj);
        }
        return obj;
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(crbargain) FROM crbargain WHERE community=" + DbAdapter.cite(community) + sql);
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
            db.executeQuery("SELECT crbargain FROM crbargain WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
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
