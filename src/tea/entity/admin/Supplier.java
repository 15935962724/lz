package tea.entity.admin;

import java.util.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class Supplier extends Entity
{
    class Layer
    {
        private String name;
        private String address;
    }


    private static Cache _cache = new Cache(100);
    private Hashtable _htLayer;
    private String community;
    private int supplier;
    private String tel;
    private String fax;
    private int card;
    private String member;
    private Date time; //修改日期
    private boolean exists;

    public Supplier(int supplier) throws SQLException
    {
        this.supplier = supplier;
        _htLayer = new Hashtable();
        load();
    }

    public static Supplier find(int supplier) throws SQLException
    {
        Supplier obj = (Supplier) _cache.get(new Integer(supplier));
        if(obj == null)
        {
            obj = new Supplier(supplier);
            _cache.put(new Integer(supplier),obj);
        }
        return obj;
    }

    public int getSupplier()
    {
        return supplier;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Supplier WHERE supplier=" + supplier);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(supplier));
    }

    public void set(String tel,String fax,int card,String member,int language,String name,String address) throws SQLException
    {
        time = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE Supplier SET tel=" + DbAdapter.cite(tel) + ",fax=" + DbAdapter.cite(fax) + ",card=" + card + ",member=" + DbAdapter.cite(member) + ",time=" + DbAdapter.cite(time) + " WHERE supplier=" + supplier);
            j = db.executeUpdate("UPDATE SupplierLayer SET name=" + DbAdapter.cite(name) + ",address=" + DbAdapter.cite(address) + " WHERE supplier=" + supplier + " AND language=" + language);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO SupplierLayer (supplier, language, name, address)VALUES (" + supplier + "," + language + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(address) + ")");
            }
        } finally
        {
            db.close();
        }
        this.tel = tel;
        this.fax = fax;
        this.card = card;
        this.member = member;
        _htLayer.clear();
    }

    public static int create(String community,String tel,String fax,int card,String member,int language,String name,String address) throws SQLException
    {
        int supplier = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Supplier (community,tel,fax,card,member,time) VALUES (" + DbAdapter.cite(community) + "," + DbAdapter.cite(tel) + "," + DbAdapter.cite(fax) + "," + card + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(new Date()) + ")");
            supplier = db.getInt("SELECT MAX(supplier) FROM Supplier");
            db.executeUpdate("INSERT INTO SupplierLayer (supplier, language, name, address)VALUES (" + supplier + "," + language + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(address) + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(supplier));
        return supplier;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,tel,fax,card,member FROM Supplier WHERE supplier=" + supplier);
            if(db.next())
            {
                community = db.getString(1);
                tel = db.getString(2);
                fax = db.getString(3);
                card = db.getInt(4);
                member = db.getString(5);
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

    private Layer getLayer(int i) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(i));
        if(layer == null)
        {
            layer = new Layer();
            int j = getLanguage(i);
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT name,address FROM SupplierLayer WHERE supplier=" + supplier + " AND language=" + j);
                if(db.next())
                {
                    layer.name = db.getVarchar(j,i,1);
                    layer.address = db.getVarchar(j,i,2);
                }
            } finally
            {
                db.close();
            }
            _htLayer.put(new Integer(i),layer);
        }
        return layer;
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM SupplierLayer WHERE supplier=" + supplier);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        if(v.indexOf(new Integer(language)) != -1)
        {
            return language;
        } else
        {
            if(language == 1)
            {
                if(v.indexOf(new Integer(2)) != -1)
                {
                    return 2;
                }
            } else if(language == 2)
            {
                if(v.indexOf(new Integer(1)) != -1)
                {
                    return 1;
                }
            }
            if(v.size() < 1)
            {
                return 0;
            }
        }
        return((Integer) v.elementAt(0)).intValue();
    }

    public static Enumeration findByCommunity(String community) throws SQLException
    {
        return find(community,"",0,Integer.MAX_VALUE);
    }

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT supplier FROM Supplier WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
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

    public static Enumeration findByMember(String community,String member) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT supplier FROM Supplier WHERE community=" + DbAdapter.cite(community) + " AND member LIKE " + db.concat("'%/'",DbAdapter.cite(member),"'/%'"));
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
//通过内查找是否有这个供应商
	public static int getSuid (String community,String sname)throws SQLException
	{
		   DbAdapter db = new DbAdapter();
		   int s = 0;
		   try
		   {
			   db.executeQuery("select supplier   FROM Supplier WHERE community="+db.cite(community)+" and supplier in (select supplier from SupplierLayer where name = "+db.cite(sname)+") ");
			   if(db.next())
			   {
				   s= db.getInt(1);
			   }
		   }finally
		   {
			   db.close();
		   }
		   return s;
	}
    public String getName(int language) throws SQLException
    {
        return getLayer(language).name;
    }

    public String getTel()
    {
        return tel;
    }

    public String getFax()
    {
        return fax;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getCard()
    {
        return card;
    }

    public String getMember()
    {
        return member;
    }

    public String getAddress(int language) throws SQLException
    {
        return getLayer(language).address;
    }
}
