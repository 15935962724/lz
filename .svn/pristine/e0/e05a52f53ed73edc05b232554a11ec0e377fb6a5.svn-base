package tea.entity.node;

import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;

public class CompanyDetail extends Entity
{
    private static Cache _cache = new Cache(100);
    private Hashtable _htLayer;
    private int companydetail;
    private int node;
    private boolean exists;
    class Layer
    {
        String name;
        String contact;
        String email;
        String telephone;
        String fax;
        String address;
        String zip;
        String webpage;
        String map;
    }


    public static CompanyDetail find(int companydetail) throws SQLException
    {
        CompanyDetail obj = (CompanyDetail) _cache.get(new Integer(companydetail));
        if (obj == null)
        {
            obj = new CompanyDetail(companydetail);
            _cache.put(new Integer(companydetail), obj);
        }
        return obj;
    }


    public static void create(int node, int language, String name, String contact, String email, String telephone, String fax, String address, String zip, String webpage, String map) throws SQLException
    {
        StringBuilder s1 = new StringBuilder();
        s1.append("INSERT INTO CompanyDetailLayer(node,language,name,contact,email,telephone,fax,address,zip,webpage,map)");
        s1.append("VALUES(").append(node).append(",").append(language).append(",").append(DbAdapter.cite(name)).append(",").append(DbAdapter.cite(contact)).append(",").append(DbAdapter.cite(email)).append(",").append(DbAdapter.cite(telephone)).append(",").append(DbAdapter.cite(fax));
        s1.append(",").append(DbAdapter.cite(address)).append(",").append(DbAdapter.cite(zip)).append(", ").append(DbAdapter.cite(webpage)).append(", ").append(DbAdapter.cite(map)).append(")");
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(s1.toString());
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
            db.executeUpdate("DELETE FROM CompanyDetailLayer WHERE companydetail=" + companydetail);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(companydetail));
    }

    public void set(int language, String name, String contact, String email, String telephone, String fax, String address, String zip, String webpage, String map) throws SQLException
    {
        int j = 0;
        StringBuilder s1 = new StringBuilder();
        s1.append("UPDATE CompanyDetailLayer SET name=").append(DbAdapter.cite(name));
        s1.append(",contact=").append(DbAdapter.cite(contact));
        s1.append(",email=").append(DbAdapter.cite(email));
        s1.append(",telephone=").append(DbAdapter.cite(telephone));
        s1.append(",fax=").append(DbAdapter.cite(fax));
        s1.append(",address=").append(DbAdapter.cite(address));
        s1.append(",zip=").append(DbAdapter.cite(zip));
        s1.append(",webpage=").append(DbAdapter.cite(webpage));
        if (map != null)
        {
            s1.append(",map=").append(DbAdapter.cite(map));
        }
        s1.append(" WHERE companydetail=").append(companydetail);
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.executeUpdate(s1.toString());
        } finally
        {
            db.close();
        }
        if (j < 1)
        {
            create(node, language, name, contact, email, telephone, fax, address, zip, webpage, map);
        }
        _cache.remove(new Integer(companydetail));
    }

    public CompanyDetail(int companydetail) throws SQLException
    {
        this.companydetail = companydetail;
        _htLayer = new Hashtable();
    }

    private Layer getLayer(int i) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(i));
        if (layer == null)
        {
            int j = i;
            layer = new Layer();
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT name,contact,email,telephone,fax,address,zip,webpage,map FROM CompanyDetailLayer WHERE companydetail=" + companydetail);
                if (db.next())
                {
                    layer.name = db.getVarchar(j, i, 1);
                    layer.contact = db.getVarchar(j, i, 2);
                    layer.email = db.getString(3);
                    layer.telephone = db.getString(4);
                    layer.fax = db.getString(5);
                    layer.address = db.getVarchar(j, i, 6);
                    layer.zip = db.getString(7);
                    layer.webpage = db.getString(8);
                    layer.map = db.getString(9);
                }
            } finally
            {
                db.close();
            }
        }
        return layer;
    }

    public static Enumeration findByNode(int node) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT companydetail FROM CompanyDetailLayer WHERE node=" + node);
            while (db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public int getNode()
    {
        return node;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getAddress(int i) throws SQLException
    {
        return getLayer(i).address;
    }

    public String getContact(int i) throws SQLException
    {
        return getLayer(i).contact;
    }

    public String getEmail(int i) throws SQLException
    {
        return getLayer(i).email;
    }

    public String getFax(int i) throws SQLException
    {
        return getLayer(i).fax;
    }

    public String getMap(int i) throws SQLException
    {
        return getLayer(i).map;
    }

    public String getName(int i) throws SQLException
    {
        return getLayer(i).name;
    }

    public String getTelephone(int i) throws SQLException
    {
        return getLayer(i).telephone;
    }

    public String getWebPage(int i) throws SQLException
    {
        return getLayer(i).webpage;
    }

    public String getZip(int i) throws SQLException
    {
        return getLayer(i).zip;
    }
}
