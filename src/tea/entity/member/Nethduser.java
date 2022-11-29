package tea.entity.member;

import java.util.Date;

import tea.db.DbAdapter;
import java.sql.SQLException;
import tea.entity.Cache;
import java.sql.SQLException;

public class Nethduser
{
    private static Cache _cache = new Cache(100);
    private String member;
    private String orderid;
    private String oudn;
    private String region;
    private String redionid;
    private String fullname;
    private String employee;
    private String title;
//    private String workphone;
    private String usertype;
    private String dutydesc;
    private Date invalidtime;
    private boolean exists;
    private int sn; //用户同步信息流水号
    private String department; //部门名称
    public Nethduser()
    {
    }

    public Nethduser(String orderid) throws SQLException
    {
        this.orderid = orderid;
        loadBasic();
    }

    public Nethduser(int sn, String member, String orderid, String oudn, String region, String redionid, String fullname, String employee, String title, String usertype, String dutydesc, String department, Date invalidtime)
    {
        this.sn = sn;
        this.member = member;
        this.orderid = orderid;
        this.oudn = oudn;
        this.region = region;
        this.redionid = redionid;
        this.fullname = fullname;
        this.employee = employee;
        this.title = title;
//        this.workphone = workphone;
        this.usertype = usertype;
        this.dutydesc = dutydesc;
        this.department = department;
        this.invalidtime = invalidtime;
    }

    public static Nethduser find(String orderid) throws SQLException
    {
        Nethduser obj = (Nethduser) _cache.get(orderid);
        if (obj == null)
        {
            obj = new Nethduser(orderid);
            _cache.put(orderid, obj);
        }
        return obj;
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT sn,member    ,oudn       ,region     ,redionid   ,fullname   ,employee   ,title      ,usertype   ,dutydesc,department,invalidtime FROM Nethduser  WHERE orderid=" + DbAdapter.cite(orderid));
            if (dbadapter.next())
            {
                sn = dbadapter.getInt(1);
                member = dbadapter.getVarchar(1, 1, 2);
                oudn = dbadapter.getVarchar(1, 1, 3);
                region = dbadapter.getVarchar(1, 1, 4);
                redionid = dbadapter.getVarchar(1, 1, 5);
                fullname = dbadapter.getVarchar(1, 1, 6);
                employee = dbadapter.getVarchar(1, 1, 7);
                title = dbadapter.getVarchar(1, 1, 8);
                //workphone = dbadapter.getVarchar(1, 1, 8);
                usertype = dbadapter.getVarchar(1, 1, 9);
                dutydesc = dbadapter.getVarchar(1, 1, 10);
                department = dbadapter.getVarchar(1, 1, 11);
                invalidtime = dbadapter.getDate(12);
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
            dbadapter.executeQuery("SELECT sn,member ,orderid   ,oudn       ,region     ,redionid   ,fullname   ,employee   ,title      ,usertype   ,dutydesc,department,invalidtime FROM Nethduser");
            if (dbadapter.next())
            {
                int sn = dbadapter.getInt(1);
                String member = dbadapter.getString(2);
                String orderid = dbadapter.getVarchar(1, 1, 3);
                String oudn = dbadapter.getVarchar(1, 1, 4);
                String region = dbadapter.getVarchar(1, 1, 5);
                String redionid = dbadapter.getVarchar(1, 1, 6);
                String fullname = dbadapter.getVarchar(1, 1, 7);
                String employee = dbadapter.getVarchar(1, 1, 8);
                String title = dbadapter.getVarchar(1, 1, 9);
                //String workphone = dbadapter.getVarchar(1, 1, 9);
                String usertype = dbadapter.getVarchar(1, 1, 10);
                String dutydesc = dbadapter.getVarchar(1, 1, 11);
                String department = dbadapter.getVarchar(1, 1, 12);
                java.util.Date invalidtime = dbadapter.getDate(13);
                vecotr.addElement(new Nethduser(sn, member, orderid, oudn, region, redionid, fullname, employee, title, usertype, dutydesc, department, invalidtime));
            }
        } finally
        {
            dbadapter.close();
        }
        return vecotr.elements();
    }

    public static void create(int sn, String member, String orderid, String oudn, String region, String redionid, String fullname, String employee, String title, String usertype, String dutydesc, String department, String invalidtime) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("INSERT INTO Nethduser(sn,member,orderid    ,oudn       ,region     ,redionid   ,fullname   ,employee   ,title      ,usertype   ,dutydesc ,department  ,invalidtime)VALUES(" +
                                    sn + "," + DbAdapter.cite(member) + "," + (orderid) + "," + DbAdapter.cite(oudn) + "," + DbAdapter.cite(region) + "," + DbAdapter.cite(redionid) + "," + DbAdapter.cite(fullname) + "," + DbAdapter.cite(employee) + "," + DbAdapter.cite(title) + "," + DbAdapter.cite(usertype) + "," + DbAdapter.cite(dutydesc) + "," + DbAdapter.cite(department) + "," + DbAdapter.cite(invalidtime) + ")");
        } finally
        {
            dbadapter.close();
        }
        _cache.remove(orderid);
    }

    public void set(int sn, String member, String oudn, String region, String redionid, String fullname, String employee, String title, String usertype, String dutydesc, String department, String invalidtime) throws SQLException
    {
        if (exists)
        {
            DbAdapter dbadapter = new DbAdapter();
            try
            {
                dbadapter.executeUpdate("UPDATE Nethduser SET sn=" + sn + ",oudn=" + DbAdapter.cite(oudn) + ",region=" + DbAdapter.cite(region) + ",redionid=" + DbAdapter.cite(redionid) + ",fullname=" + DbAdapter.cite(fullname) + ",employee=" + DbAdapter.cite(employee) + ",title=" + DbAdapter.cite(title) + // ",workphone=" + DbAdapter.cite(workphone) +
                                        ",dutydesc=" + DbAdapter.cite(dutydesc) + ",usertype=" + DbAdapter.cite(usertype) + ",department=" + DbAdapter.cite(department) + ",invalidtime=" + DbAdapter.cite(invalidtime) + " WHERE orderid=" + DbAdapter.cite(orderid)); //member=" + DbAdapter.cite(member));
            } finally
            {
                dbadapter.close();
            }
            _cache.remove(orderid);
        } else
        {
            create(sn, member, orderid, oudn, region, redionid, fullname, employee, title, usertype, dutydesc, department, invalidtime);
        }
    }

    public void delete()
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("DELETE FROM Nethduser WHERE orderid=" + DbAdapter.cite(orderid));
        } catch (SQLException ex)
        {
            ex.printStackTrace();
        } finally
        {
            dbadapter.close();
        }
        _cache.remove(orderid);
    }

    public synchronized static String getLast() throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT sn FROM Nethduser");
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

    public String getMember()
    {
        return member;
    }

    public String getOrderid()
    {
        return orderid;
    }

    public String getOudn()
    {
        return oudn;
    }

    public String getRegion()
    {
        return region;
    }

    public String getRedionid()
    {
        return redionid;
    }

    public String getFullname()
    {
        return fullname;
    }

    public String getEmployee()
    {
        return employee;
    }

    public String getTitle()
    {
        return title;
    }


    public String getUsertype()
    {
        return usertype;
    }

    public String getDutydesc()
    {
        return dutydesc;
    }

    public Date getInvalidtime()
    {
        return invalidtime;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getSn()
    {
        return sn;
    }

    public String getDepartment()
    {
        return department;
    }
}
