package tea.entity.criterion;

import java.io.*;
import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class Unitres implements Serializable
{
    public static Cache _cache = new Cache(100);
    public static final String CALLING_TYPE[] =
                                                {"水泥","钢铁","石油","玻璃"};
    public static final String SPECIALTY_TYPE[] =
                                                  {"废水","大气","噪声","固废","生态","土壤","放射性"};
    private String address;
    private String calling;
    private String specialty;
    private String product;
    private String linkmanname;
    private String job;
    private String phone;
    private String mobile;
    private String email;
    private int unit;
    private boolean exists;
    private String zip;
    private String url;
    private String have_a_project;
    private String fax;
    private String bank;
    private String account;

    public Unitres(int unit) throws SQLException
    {
        this.unit = unit;
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT address,calling    ,specialty  ,product    ,linkmanname,job        ,phone,fax,mobile     ,email,zip,url,have_a_project,bank,account FROM Unitres WHERE unit=" + unit);
            if(db.next())
            {
                address = db.getString(1);
                calling = db.getString(2);
                specialty = db.getString(3);
                product = db.getString(4);
                linkmanname = db.getString(5);
                job = db.getString(6);
                phone = db.getString(7);
                fax = db.getString(8);
                mobile = db.getString(9);
                email = db.getString(10);
                zip = db.getString(11);
                url = db.getString(12);
                have_a_project = db.getString(13);
                bank = db.getString(14);
                account = db.getString(15);
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

    public static java.util.Enumeration find(String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            if(sql.indexOf(" ur.") == -1)
            {
                db.executeQuery("SELECT id FROM AdminUnit au WHERE 1=1 " + sql);
            } else
            {
                db.executeQuery("SELECT unit FROM Unitres ur,AdminUnit au WHERE ur.unit=au.id " + sql);
            } while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static void create(int unit,String address,String calling,String specialty,String product,String linkmanname,String job,String phone,String fax,String mobile,String email,String zip,String url,String have_a_project,String bank,String account) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Unitres(unit,address,calling,specialty,product,linkmanname,job,phone,fax,mobile     ,email,zip,url,have_a_project,bank,account)VALUES(" + unit + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(calling) + "," + DbAdapter.cite(specialty) + "," + DbAdapter.cite(product) + "," + DbAdapter.cite(linkmanname) + "," + DbAdapter.cite(job) + "," + DbAdapter.cite(phone) + "," + DbAdapter.cite(fax) + "," + DbAdapter.cite(mobile) + ","
                             + DbAdapter.cite(email) + "," + DbAdapter.cite(zip) + "," + DbAdapter.cite(url) + "," + DbAdapter.cite(have_a_project) + "," + DbAdapter.cite(bank) + "," + DbAdapter.cite(account) + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(unit));
    }

    public void set(String address,String calling,String specialty,String product,String linkmanname,String job,String phone,String fax,String mobile,String email,String zip,String url,String have_a_project,String bank,String account) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Unitres SET address=" + DbAdapter.cite(address) + ",calling=" + DbAdapter.cite(calling) + ",specialty=" + DbAdapter.cite(specialty) + ",product=" + DbAdapter.cite(product) + ",linkmanname=" + DbAdapter.cite(linkmanname) + ",job=" + DbAdapter.cite(job) + ",phone=" + DbAdapter.cite(phone) + ",fax=" + DbAdapter.cite(fax) + ",mobile=" + DbAdapter.cite(mobile) + ",email=" + DbAdapter.cite(email) + ",zip=" + DbAdapter.cite(zip) + ",url="
                             + DbAdapter.cite(url) + ",have_a_project=" + DbAdapter.cite(have_a_project) + ",bank=" + DbAdapter.cite(bank) + ",account=" + DbAdapter.cite(account) + " WHERE unit=" + unit);
        } finally
        {
            db.close();
        }
        this.address = address;
        this.calling = calling;
        this.specialty = specialty;
        this.product = product;
        this.linkmanname = linkmanname;
        this.job = job;
        this.phone = phone;
        this.fax = fax;
        this.mobile = mobile;
        this.email = email;
        this.zip = zip;
        this.url = url;
        this.have_a_project = have_a_project;
        this.bank = bank;
        this.account = account;
    }

    public static Unitres find(int expertres) throws SQLException
    {
        Unitres obj = (Unitres) _cache.get(new Integer(expertres));
        if(obj == null)
        {
            obj = new Unitres(expertres);
            _cache.put(new Integer(expertres),obj);
        }
        return obj;
    }

    private void readObject(ObjectInputStream ois) throws IOException,ClassNotFoundException
    {
        ois.defaultReadObject();
    }

    private void writeObject(ObjectOutputStream oos) throws IOException
    {
        oos.defaultWriteObject();
    }

    public String getAddress()
    {
        return address;
    }

    public String getCalling()
    {
        return calling;
    }

    public String getSpecialty()
    {
        return specialty;
    }

    public String getProduct()
    {
        return product;
    }

    public String getLinkmanname()
    {
        return linkmanname;
    }

    public String getJob()
    {
        return job;
    }

    public String getPhone()
    {
        return phone;
    }

    public String getMobile()
    {
        return mobile;
    }

    public String getEmail()
    {
        return email;
    }

    public int getUnit()
    {
        return unit;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getZip()
    {
        return zip;
    }

    public String getUrl()
    {
        return url;
    }

    public String getHave_a_project()
    {
        return have_a_project;
    }

    public String getFax()
    {
        return fax;
    }

    public String getBank()
    {
        return bank;
    }

    public String getAccount()
    {
        return account;
    }
}
