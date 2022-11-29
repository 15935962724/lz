package tea.entity.node;

import java.util.Date;
import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class PShoppingCarts
{
	private static Cache _cache = new Cache(100);
	private String member;
	private int node;
	private String time;
	private int counts;
	private float price;
	private boolean exist;
	private int status;
	private int id;
	private Date orders;

	public PShoppingCarts()
	{
	}

	public PShoppingCarts(int id) throws SQLException
	{
		// this.member = member;
		// this.node = node;
		this.id = id;
		loadBase();
	}

	public PShoppingCarts create() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			// db.executeUpdate("PShoppingCartsCreate " + DbAdapter.cite(member) + "," + node + "," +
			// DbAdapter.cite(time) + "," + counts + "," + price);
			db.executeUpdate("INSERT INTO PShoppingCarts(member ,node   ,time   ,counts ,price,status)VALUES(" + DbAdapter.cite(member) + " ," + node + "   ," + DbAdapter.cite(time) + "   ," + counts + " ," + price + ",0)");

		} finally
		{
			db.close();
		}
		this.exist = true;
		_cache.remove(new Integer(id));
		return this;
	}

	public void set() throws SQLException
	{
		if (this.isExist())
		{
			DbAdapter db = new DbAdapter();
			try
			{
				// db.executeUpdate("PShoppingCartsEdit " + id + "," + DbAdapter.cite(member) + "," +
				// node + "," + DbAdapter.cite(time) + "," + counts + "," + price);
				db.executeUpdate("UPDATE  PShoppingCarts  SET member =" + DbAdapter.cite(member) + " ,node    =" + node + ",time    =" + DbAdapter.cite(time) + ",counts  =" + counts + ",price=" + price + "  WHERE id=" + id);
			} catch (Exception ex)
			{
				ex.printStackTrace();
			} finally
			{
				db.close();
			}
			_cache.remove(new Integer(id));
		} else
		{
			create();
		}
	}

	public static void setStatus(String member, boolean status) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE PShoppingCarts SET status=" + (status ? "1" : "0") + " WHERE member=" + DbAdapter.cite(member));

		} finally
		{
			db.close();
		}
		_cache.clear();
	}

	public void loadBase() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT time, counts,price,node,member FROM PShoppingCarts WHERE id=" + id);
			if (db.next())
			{
				time = db.getVarchar(1, 1, 1);
				counts = db.getInt(2);
				price = db.getFloat(3);
				this.node = db.getInt(4);
				this.member = db.getString(5);
				exist = true;
			} else
			{
				exist = false;
			}
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
			db.executeUpdate("DELETE FROM PShoppingCarts WHERE node=" + node + " AND member=" + DbAdapter.cite(member));

		} finally
		{
			db.close();
		}
		_cache.remove(member + ":" + node);
	}

	public static java.util.Vector findByMember(String member, boolean buy) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		java.util.Vector vector = new java.util.Vector();
		try
		{
			String status = buy ? " AND status=1" : " AND status<>1";
			db.executeQuery("SELECT id FROM PShoppingCarts,Node WHERE Node.node=PShoppingCarts.node AND member=" + DbAdapter.cite(member) + status);
			while (db.next())
			{
				vector.addElement(new Integer(db.getInt(1)));
			}
		} finally
		{
			db.close();
		}
		return vector;
	}

	public static float sumByMember(String member) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		float sum = 0f;
		try
		{
			db.executeQuery("SELECT price*counts FROM PShoppingCarts,Node WHERE Node.node=PShoppingCarts.node AND member=" + DbAdapter.cite(member));
			while (db.next())
			{
				sum = sum + db.getFloat(1);
			}
		} finally
		{
			db.close();
		}
		return sum;
	}

	public static PShoppingCarts find(int id) throws SQLException
	{
		PShoppingCarts objPerform = (PShoppingCarts) _cache.get(new Integer(id));
		// if (objPerform == null)
		{
			objPerform = new PShoppingCarts(id);
			_cache.put(new Integer(id), objPerform);
		}
		return objPerform;
	}

	public void setMember(String member)
	{
		this.member = member;
	}

	public void setNode(int node)
	{
		this.node = node;
	}

	public void setTime(String time)
	{
		this.time = time;
	}

	public void setCounts(int counts)
	{
		this.counts = counts;
	}

	public void setPrice(float price)
	{
		this.price = price;
	}

	public void setId(int id)
	{
		this.id = id;
	}

	public void setOrders(Date orders)
	{
		this.orders = orders;
	}

	public static void setOrders(String member, Date orders) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE PShoppingCarts orders=" + DbAdapter.cite(orders) + " WHERE order is null AND member=" + DbAdapter.cite(member));
		} finally
		{
			db.close();
		}
	}

	public String getMember()
	{
		return member;
	}

	public int getNode()
	{
		return node;
	}

	public String getTime()
	{
		return time;
	}

	public int getCounts()
	{
		return counts;
	}

	public float getPrice()
	{
		return price;
	}

	public boolean isExist()
	{
		return exist;
	}

	public int getStatus()
	{
		return status;
	}

	public int getId()
	{
		return id;
	}

	public Date getOrders()
	{
		return orders;
	}
}
