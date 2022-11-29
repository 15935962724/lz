package tea.entity.site;


import java.sql.*;
import tea.entity.*;
import tea.db.*;


public class NetdiskEnterprise extends Entity
{
    private static Cache _cache = new Cache(100);
    public static int PRODUCT_TYPE[] =
            {100, 300, 1000, 5000};
    public static String PRODUCT_TEXT[] =
            {"经济型", "普及型", "豪华型", "尊贵型"};
    private String community;
    private String fullname;
    /*
         经济型	100MB		KDYPA02000A
         普及型	300MB		KDYPA02000B
         豪华型	1000MB		KDYPA02000C
         尊贵型	5000MB		KDYPA02000D
     */
    private int productid;
    private java.util.Date invalidtime;
    private java.util.Date createtime;
    private boolean exists;
    public NetdiskEnterprise(String community) throws SQLException
    {
        this.community = community;
        loadBasic();
    }

    public NetdiskEnterprise(String community, String fullname, int productid, Date invalidtime, Date createtime)
    {
        this.community = community;
        this.fullname = fullname;
        this.productid = productid;
        this.invalidtime = invalidtime;
        this.createtime = createtime;
    }

    public static NetdiskEnterprise find(String dn) throws SQLException
    {
        NetdiskEnterprise obj = (NetdiskEnterprise) _cache.get(dn);
        if (obj == null)
        {
            obj = new NetdiskEnterprise(dn);
            _cache.put(dn, obj);
        }
        return obj;
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT fullname ,productid  ,invalidtime,createtime FROM NetdiskEnterprise  WHERE community=" + DbAdapter.cite(community));
            if (db.next())
            {
                fullname = db.getString(1);
                productid = db.getInt(2);
                invalidtime = db.getDate(3);
                createtime = db.getDate(4);
                exists = true;
            } else
            {
                exists = false;
            }} finally
        {
            db.close();
        }
    }

    public static String findByLast() throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT sn FROM NetdiskEnterprise");
            if (db.next())
            {
                sb.append(db.getInt(1));
                while (db.next())
                {
                    sb.append("," + db.getInt(1));
                }
            }} finally
        {
            db.close();
        }
        return sb.toString();
    }

    public static java.util.Enumeration find(String sql, int pos, int pageSize) throws SQLException
    {
        java.util.Vector vecotr = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community FROM NetdiskEnterprise WHERE 1=1 " + sql);
            while (db.next())
            {
                String dn = db.getString(1);
                vecotr.addElement(dn);
            }} finally
        {
            db.close();
        }
        return vecotr.elements();
    }

    public static void create(String community, String fullname, int productid, java.util.Date invalidtime) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO NetdiskEnterprise(community,fullname ,productid  ,invalidtime,createtime)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(fullname) + "," + (productid) + "," + DbAdapter.cite(invalidtime) + "," + DbAdapter.cite(new java.sql.Date(System.currentTimeMillis())) + ")");} finally
        {
            db.close();
        }
        _cache.remove(community);
    }

    public void set(String community, String fullname, int productid, Date invalidtime) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE NetdiskEnterprise SET fullname=" + DbAdapter.cite(fullname) + ",productid=" + (productid) + ",invalidtime=" + DbAdapter.cite(invalidtime) + " WHERE community=" + DbAdapter.cite(community));} finally
        {
            db.close();
        }
        this.community = community;
        this.fullname = fullname;
        this.productid = productid;
        this.invalidtime = invalidtime;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM NetdiskEnterprise WHERE community=" + DbAdapter.cite(community));} finally
        {
            db.close();
        }
        _cache.remove(community);
    }

    public static void clear() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM NetdiskEnterprise");} finally
        {
            db.close();
        }
    }

    public synchronized static String getLast() throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community FROM NetdiskEnterprise");
            if (db.next())
            {
                sb.append(db.getString(1));
                while (db.next())
                {
                    sb.append("," + db.getString(1));
                }
            }} finally
        {
            db.close();
        }
        return sb.toString();
    }


    public int getProductid()
    {
        return productid;
    }

    /*
        public int getSize()
        {
            int size = 0;
            if ("KDYPA02000D".equals(productid))
            {
                size = 5000;
            } else
            if ("KDYPA02000C".equals(productid))
            {
                size = 1000;
            } else
            if ("KDYPA02000B".equals(productid))
            {
                size = 300;
            } else
//if("KDYPA02000A".equals(productid))
            {
                size = 100;
            }
            return size;
        }
     */
    public java.util.Date getInvalidtime()
    {
        return invalidtime;
    }

    public String getInvalidtimeToString()
    {
        return sdf.format(invalidtime);
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getFullname()
    {
        return fullname;
    }

}
