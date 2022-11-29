package tea.entity.member;

import java.util.Date;

import tea.db.DbAdapter;
import java.sql.SQLException;
import tea.entity.*;

public class Nethdou extends Entity
{
    private static Cache _cache = new Cache(100);
    private String oudn;
    private int ouid;
    private String ouname;
    private String oufullname;
    private String productid;
    private Date invalidtime;
    private boolean exists;
    private String updateop;
    private int sn; //企业同步信息流水号
    public Nethdou(String oudn) throws SQLException
    {
        this.oudn = oudn;
        loadBasic();
    }

    public Nethdou(int sn,String oudn, int ouid, String ouname, String oufullname, String productid, String updateop, Date invalidtime)
    {
        this.sn=sn;
        this.oudn = oudn;
        this.ouid = ouid;
        this.ouname = ouname;
        this.oufullname = oufullname;
        this.productid = productid;
        this.updateop = updateop;
        this.invalidtime = invalidtime;
    }

    public static Nethdou find(String oudn) throws SQLException
    {
        Nethdou obj = (Nethdou) _cache.get(oudn);
        if (obj == null)
        {
            obj = new Nethdou(oudn);
            _cache.put(oudn, obj);
        }
        return obj;
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT sn,ouid,ouname,oufullname,productid,updateop,invalidtime FROM Nethdou WHERE oudn=" + DbAdapter.cite(oudn));
            if (dbadapter.next())
            {
                sn = dbadapter.getInt(1);
                ouid = dbadapter.getInt(2);
                ouname = dbadapter.getVarchar(1, 1, 3);
                oufullname = dbadapter.getVarchar(1, 1, 4);
                productid = dbadapter.getVarchar(1, 1, 5);
                updateop = dbadapter.getString(6);
                invalidtime = dbadapter.getDate(7);
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

    public static java.util.Enumeration find(int pos, int pageSize) throws SQLException
    {
        java.util.Vector vecotr = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT sn,oudn,ouid       ,ouname     ,oufullname ,productid  ,updateop,invalidtime FROM Nethdou");
            if (dbadapter.next())
            {
                int sn = dbadapter.getInt(1);
                String oudn = dbadapter.getString(2);
                int ouid = dbadapter.getInt(3);
                String ouname = dbadapter.getVarchar(1, 1, 4);
                String oufullname = dbadapter.getVarchar(1, 1, 5);
                String productid = dbadapter.getVarchar(1, 1, 6);
                String updateop = dbadapter.getString(7);
                java.util.Date invalidtime = dbadapter.getDate(8);
                vecotr.addElement(new Nethdou(sn,oudn, ouid, ouname, oufullname, productid, updateop, invalidtime));
            }
        } finally
        {
            dbadapter.close();
        }
        return vecotr.elements();
    }

    public static void create(int sn, String oudn, int ouid, String ouname, String oufullname, String productid, String invalidtime) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("INSERT INTO Nethdou(sn,oudn,ouid,ouname,oufullname,productid,updateop,invalidtime)VALUES(" + sn + "," + DbAdapter.cite(oudn) + "," + (ouid) + "," + DbAdapter.cite(ouname) + "," + DbAdapter.cite(oufullname) + "," + DbAdapter.cite(productid) + "," + DbAdapter.cite("+") + "," + DbAdapter.cite(invalidtime) + ")");
        } finally
        {
            dbadapter.close();
        }
        _cache.remove(oudn);
    }

    public void set(int sn, int ouid, String ouname, String oufullname, String productid, String invalidtime) throws SQLException
    {
        if (exists)
        {
            DbAdapter dbadapter = new DbAdapter();
            try
            {
                dbadapter.executeUpdate("UPDATE Nethdou SET sn=" + sn + ",ouid=" + (ouid) + ",ouname  =" + DbAdapter.cite(ouname) + ",oufullname=" + DbAdapter.cite(oufullname) + ",productid=" + DbAdapter.cite(productid) + "  ,updateop='M',invalidtime=" + DbAdapter.cite(invalidtime) + " WHERE oudn=" + DbAdapter.cite(oudn));
            } finally
            {
                dbadapter.close();
            }
            _cache.remove(oudn);
        } else
        {
            create(sn, oudn, ouid, ouname, oufullname, productid, invalidtime);
        }
    }

    public void delete()
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("DELETE FROM Nethdou WHERE oudn=" + DbAdapter.cite(oudn));
            dbadapter.executeUpdate("DELETE FROM Nethduser WHERE oudn=" + DbAdapter.cite(oudn));
        } catch (SQLException ex)
        {
            ex.printStackTrace();
        } finally
        {
            dbadapter.close();
        }
        _cache.remove(oudn);
    }

    public synchronized static String getLast() throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT sn FROM Nethdou");
            if (dbadapter.next())
            {
                sb.append(dbadapter.getInt(1));
                while (dbadapter.next())
                {
                    sb.append("," + dbadapter.getInt(1));
                }
            }
        } finally
        {
            dbadapter.close();
        }
        return sb.toString();
    }

    public String getOudn()
    {
        return oudn;
    }

    public int getOuid()
    {
        return ouid;
    }

    public String getOuname()
    {
        return ouname;
    }

    public String getOufullname()
    {
        return oufullname;
    }

    public String getProductid()
    {
        return productid;
    }

    public Date getInvalidtime()
    {
        return invalidtime;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getUpdateop()
    {
        return updateop;
    }

    public int getSn()
    {
        return sn;
    }
}
