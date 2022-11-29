package tea.entity.admin;

import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

//品牌打折
public class SupplierBrandDiscounts extends Entity
{
    private static Cache _cache = new Cache(100);
    private int supplier;
    private int brand;
    private Date time;
    private float discounts;
    private Date starttime;
    private Date stoptime;
    private String member;
    private int goodstype;
    private int goodstype2;
    private int floor;
	private String nodename;//指定打折的商品
    private boolean exists;

    public static SupplierBrandDiscounts find(int supplier,int brand) throws SQLException
    {
        SupplierBrandDiscounts obj = (SupplierBrandDiscounts) _cache.get(supplier + ":" + brand);
        if(obj == null)
        {
            obj = new SupplierBrandDiscounts(supplier,brand);
            _cache.put(supplier + ":" + brand,obj);
        }
        return obj;
    }

    public SupplierBrandDiscounts(int supplier,int brand) throws SQLException
    {
        this.supplier = supplier;
        this.brand = brand;
        load();
    }

    public void set(float discounts,Date starttime,Date stoptime,String member,int goodstype,int floor,int goodstype2,String nodename) throws SQLException
    {
        if(this.isExists())
        {
            time = new Date();
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate("UPDATE SupplierBrandDiscounts SET nodename ="+db.cite(nodename)+", discounts=" + discounts + ",starttime=" + DbAdapter.cite(starttime) + ",stoptime=" + DbAdapter.cite(stoptime) + ",member=" + DbAdapter.cite(member) + ",time=" + DbAdapter.cite(time) + ",goodstype=" + goodstype + ",floor=" + floor + ",goodstype2=" + goodstype2 + " WHERE supplier=" + supplier + " AND brand=" + brand);
            } finally
            {
                db.close();
            }
            this.discounts = discounts;
            this.starttime = starttime;
            this.stoptime = stoptime;
            this.member = member;
            this.goodstype = goodstype;
            this.floor = floor;
            this.goodstype2 = goodstype2;
			this.nodename = nodename;
        } else
        {
            create(supplier,brand,discounts,starttime,stoptime,member,goodstype,floor,goodstype2,nodename);
        }
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(DISTINCT sb.brand) FROM SupplierBrandDiscounts sb,Supplier s,Brand b WHERE sb.supplier=s.supplier AND sb.brand=b.brand AND s.community=" + DbAdapter.cite(community) + sql);
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
            db.executeQuery("SELECT sb.supplier,sb.brand FROM SupplierBrandDiscounts sb,Supplier s,Brand b WHERE sb.supplier=s.supplier AND sb.brand=b.brand AND s.community=" + DbAdapter.cite(community) + sql,pos,size);
            while(db.next())
            {
                v.addElement(new int[]
                             {db.getInt(1),db.getInt(2)});
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    /*
     * public static SupplierBrandDiscounts findLast(int brand) throws SQLException { int id = 0; DbAdapter db = new DbAdapter(); try { db.executeQuery("SELECT branddiscounts FROM branddiscounts WHERE brand=" + brand + " ORDER BY stoptime DESC"); if (db.next()) { id = db.getInt(1); } } finally { db.close(); } return find(id); }
     */

    public static int create(int supplier,int brand,float discounts,Date starttime,Date stoptime,String member,int goodstype,int floor,int goodstype2,String nodename) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO SupplierBrandDiscounts(supplier,brand,time,discounts,starttime,stoptime,member,goodstype,floor,goodstype2,nodename)VALUES(" + supplier + "," + brand + "," + db.citeCurTime() + "," + discounts + "," + DbAdapter.cite(starttime) + "," + DbAdapter.cite(stoptime) + "," + DbAdapter.cite(member) + "," + goodstype + "," + floor + "," + goodstype2 + ","+db.cite(nodename)+")");
        } finally
        {
            db.close();
        }
        _cache.remove(supplier + ":" + brand);
        return brand;
    }
	//判断是否有这个商品
	public static float getNode(int node)throws SQLException
	{
		DbAdapter db = new DbAdapter();
		float d = 0;
		tea.entity.node.Node nobj =new tea.entity.node.Node(node);
		try
		{
			db.executeQuery("select discounts from SupplierBrandDiscounts where nodename like "+db.cite("%"+nobj.getSubject(1)+";%")+" ");
			if(db.next())
			{
				d = db.getFloat(1);
			}
		}finally
		{
			db.close();
		}
		return d;
	}
    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM SupplierBrandDiscounts WHERE supplier=" + supplier + " AND brand=" + brand);
        } finally
        {
            db.close();
        }
        _cache.remove(supplier + ":" + brand);
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT time,discounts,starttime,stoptime,member,goodstype,floor,goodstype2,nodename FROM SupplierBrandDiscounts WHERE supplier=" + supplier + " AND brand=" + brand);
            if(db.next())
            {
                time = db.getDate(1);
                discounts = db.getFloat(2);
                starttime = db.getDate(3);
                stoptime = db.getDate(4);
                member = db.getString(5);
                goodstype = db.getInt(6);
                floor = db.getInt(7);
                goodstype2 = db.getInt(8);
				nodename =db.getString(9);
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

    public int getBrand()
    {
        return brand;
    }

    public boolean isExists() throws SQLException
    {
        return exists;
    }

    public Date getStartTime()
    {
        return starttime;
    }

    public String getStartTimeToString()
    {
        return sdf.format(starttime);
    }

    public Date getStopTime()
    {
        return stoptime;
    }

    public String getStopTimeToString()
    {
        return sdf.format(stoptime);
    }

    public float getDiscounts()
    {
        return discounts;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        return sdf.format(time);
    }

    public String getMember()
    {
        return member;
    }

    public int getSupplier()
    {
        return supplier;
    }

    public int getGoodstype()
    {
        return goodstype;
    }

    public int getFloor()
    {
        return floor;
    }

    public int getGoodstype2()
    {
        return goodstype2;
    }
	public String getNodename()
	{
		return nodename;
	}
}
