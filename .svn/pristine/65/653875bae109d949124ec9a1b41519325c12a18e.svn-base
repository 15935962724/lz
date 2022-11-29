package tea.entity.node;

import java.util.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class RoomPrice extends Entity
{
	private static Cache _cache = new Cache(100);
	public static final String PAYMENT[] = { "Retail", "Proscenium", "Net", "Weekend" };
	private int node;
	private int roomprice;
	private float retail;
	private float proscenium;
	private float net;
	private float weekend;
	private Hashtable _htLayer;
	private boolean _blLoaded;
	private boolean exists;
    private Date periodtime;//开始日期
    private Date periodtime2;//结束时间
	class Layer
	{
		Layer()
		{
		}

		private String roomtype;
		private String breakfast;
		private String remark;
	}

	public RoomPrice()
	{
	}


	public RoomPrice(int roomprice)
	{
		_htLayer = new Hashtable();
		this.roomprice = roomprice;
		loadBasic();
	}

	public int getNode()
	{
		return node;
	}

	public void setNode(int node)
	{
		this.node = node;
	}

	private Layer getLayer(int i) throws SQLException
	{
		Layer layer = (Layer) _htLayer.get(new Integer(i));
		if (layer == null)
		{
			layer = new Layer();
			int j = this.getLanguage(i);
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT roomtype, breakfast,remark FROM RoomPriceLayer WHERE roomprice=" + roomprice + " AND language=" + j);
				if (db.next())
				{
					layer.roomtype = db.getVarchar(j, i, 1);
					layer.breakfast = db.getVarchar(j, i, 2);
					layer.remark = db.getText(j, i, 3);
				}
			} finally
			{
				db.close();
			}
			_htLayer.put(new Integer(i), layer);
		}
		return layer;
	}

	private int getLanguage(int language) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT language FROM RoomPriceLayer WHERE roomprice=" + roomprice);
			while (db.next())
			{
				v.addElement(new Integer(db.getInt(1)));
			}
		} finally
		{
			db.close();
		}
		if (v.indexOf(new Integer(language)) != -1)
			return language;
		else
		{			if (language == 1)
			{
				if (v.indexOf(new Integer(2)) != -1)
					return 2;
			} else if (language == 2)
			{
				if (v.indexOf(new Integer(1)) != -1)
					return 1;
			}
			if (v.size() < 1)
				return 0;
		}
		return ((Integer) v.elementAt(0)).intValue();
	}

	public String getRoomtype(int language) throws SQLException
	{
		return getLayer(language).roomtype;
	}

	public float getRetail()
	{
		return retail;
	}

	public void setRetail(float retail)
	{
		this.retail = retail;
	}

	public float getProscenium()
	{
		return proscenium;
	}

	public float getPrice(int payment)
	{
		switch (payment)
		{
		case 0:
			return getRetail();
		case 1:
			return getProscenium();
		case 2:
			return getNet();
		case 3:
			return getWeekend();
		}
		return 0.0f;
	}

	public void setProscenium(float proscenium)
	{
		this.proscenium = proscenium;
	}
    public void set(int node) throws SQLException
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate("UPDATE RoomPrice set node= " + node + " WHERE roomprice=" + roomprice);
            } finally
            {
                db.close();
            }
    }

    public void set(int roomprice, int node, float retail, float proscenium, float net, float weekend, int language, String roomtype, String breakfast, String remark,Date periodtime,Date periodtime2) throws SQLException
   {
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeUpdate("UPDATE RoomPrice SET retail=" + retail + ",proscenium=" + proscenium + ",net=" + net + ",weekend=" + weekend + ",periodtime="+db.cite(periodtime)+",periodtime2="+db.cite(periodtime2)+" WHERE roomprice=" + roomprice);
           db.executeQuery("SELECT roomprice FROM RoomPriceLayer WHERE roomprice=" + roomprice + " AND language=" + language);
           if (db.next())
           {
               db.executeUpdate("UPDATE RoomPriceLayer SET roomtype=" + db.cite(roomtype) + ",breakfast=" + DbAdapter.cite(breakfast) + ",remark=" + DbAdapter.cite(remark) + " WHERE roomprice=" + roomprice + " AND language=" + language);
           } else
           {
               db.executeUpdate("INSERT INTO RoomPriceLayer (roomprice, language, roomtype, breakfast, remark)VALUES (" + roomprice + ", " + language + ", " + DbAdapter.cite(roomtype) + ", " + DbAdapter.cite(breakfast) + ", " + DbAdapter.cite(remark) + ")");
           }
       } finally
       {
           db.close();
       }
       this.net = net;
       this.retail = retail;
       this.proscenium = proscenium;
       this.weekend = weekend;
       this.periodtime=periodtime;
       this.periodtime2=periodtime2;
       // this.node = node;
       _htLayer.clear();
   }

   public int create(int node, float retail, float proscenium, float net, float weekend, int language, String roomtype, String breakfast, String remark,Date periodtime,Date periodtime2) throws SQLException
       {
           int roomprice = 0;
           int k = 0;
           DbAdapter db = new DbAdapter();
           try
           {
               db.executeUpdate("INSERT INTO RoomPrice (node, retail, proscenium, net, weekend,periodtime,periodtime2) VALUES (" + node + ", " + retail + ", " + proscenium + ", " + net + ", " + weekend + " ,"+db.cite(periodtime)+","+db.cite(periodtime2)+"   )");
               k = db.getInt("SELECT MAX(roomprice) FROM RoomPrice");
               db.executeUpdate("INSERT INTO RoomPriceLayer (roomprice, language, roomtype, breakfast, remark)VALUES (" + k + ", " + language + ", " + DbAdapter.cite(roomtype) + ", " + DbAdapter.cite(breakfast) + ", " + DbAdapter.cite(remark) + ")");
           } finally
           {
               db.close();
           }
           return roomprice;
    }

	public float getNet()
	{
		return net;
	}

	public void setNet(float net)
	{
		this.net = net;
	}

	public float getWeekend()
	{
		return weekend;
	}

	public void setWeekend(float weekend)
	{
		this.weekend = weekend;
	}

	public String getBreakfast(int language) throws SQLException
	{
		return getLayer(language).breakfast;
	}

	public String getRemark(int language) throws SQLException
	{
		return getLayer(language).remark;
	}

	public int create(int node, float retail, float proscenium, float net, float weekend, int language, String roomtype, String breakfast, String remark) throws SQLException
	{
		int roomprice = 0;
		int k = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO RoomPrice (node, retail, proscenium, net, weekend) VALUES (" + node + ", " + retail + ", " + proscenium + ", " + net + ", " + weekend + ")");
			k = db.getInt("SELECT MAX(roomprice) FROM RoomPrice");
			db.executeUpdate("INSERT INTO RoomPriceLayer (roomprice, language, roomtype, breakfast, remark)VALUES (" + k + ", " + language + ", " + DbAdapter.cite(roomtype) + ", " + DbAdapter.cite(breakfast) + ", " + DbAdapter.cite(remark) + ")");
		} finally
		{
			db.close();
		}
		return roomprice;
	}

	public void set(int roomprice, int node, float retail, float proscenium, float net, float weekend, int language, String roomtype, String breakfast, String remark) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE RoomPrice SET retail=" + retail + ",proscenium=" + proscenium + ",net=" + net + ",weekend=" + weekend + " WHERE roomprice=" + roomprice);
			db.executeQuery("SELECT roomprice FROM RoomPriceLayer WHERE roomprice=" + roomprice + " AND language=" + language);
			if (db.next())
			{
				db.executeUpdate("UPDATE RoomPriceLayer SET roomtype=" + DbAdapter.cite(roomtype) + ",breakfast=" + DbAdapter.cite(breakfast) + ",remark=" + DbAdapter.cite(remark) + " WHERE roomprice=" + roomprice + " AND language=" + language);
			} else
			{
				db.executeUpdate("INSERT INTO RoomPriceLayer (roomprice, language, roomtype, breakfast, remark)VALUES (" + roomprice + ", " + language + ", " + DbAdapter.cite(roomtype) + ", " + DbAdapter.cite(breakfast) + ", " + DbAdapter.cite(remark) + ")");
			}
		} finally
		{
			db.close();
		}
		this.net = net;
		this.retail = retail;
		this.proscenium = proscenium;
		this.weekend = weekend;
		// this.node = node;
		_htLayer.clear();
	}

	public void delete()throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM RoomPrice WHERE roomprice=" + roomprice);
		}  finally
		{
			db.close();
		}
	}

	public static RoomPrice find(int roomprice)
	{
		RoomPrice obj = (RoomPrice) _cache.get(new Integer(roomprice));
		if (obj == null)
		{
			obj = new RoomPrice(roomprice);
			_cache.put(new Integer(roomprice), obj);
		}
		return obj;
	}

	/*
	 * public static Enumeration findRoomType(int node, int language) throws SQLException { Vector vector = new Vector(); DbAdapter db = new DbAdapter(); try { db.executeQuery("SELECT roomprice FROM RoomPrice WHERE node=" + node); for (; db.next(); vector.addElement(db.getString(1))) { ; }} finally { db.close(); } return vector.elements(); }
	 */
	public static java.util.Enumeration findByNode(int node)
	{
		java.util.Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT roomprice FROM RoomPrice WHERE node=" + node);
			while (db.next())
			{
				vector.addElement(new Integer(db.getInt(1)));
			}
		} catch (Exception exception)
		{
			exception.printStackTrace();
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	private void loadBasic()
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT retail,proscenium,net,weekend FROM RoomPrice WHERE roomprice=" + roomprice);
			if (db.next())
			{
				retail = db.getFloat(1);
				proscenium = db.getFloat(2);
				net = db.getFloat(3);
				weekend = db.getFloat(4);
				exists = true;
			} else
			{
				exists = false;
			}
		} catch (Exception exception)
		{
			exception.printStackTrace();
		} finally
		{
			db.close();
		}
	}

	/*
	 * public boolean exists() { DbAdapter db = new DbAdapter(); try { db.executeQuery("SELECT node FROM RoomPrice WHERE node=" + node + " AND roomprice=" + roomprice); return (db.next()); } catch (Exception exception) { exception.printStackTrace(); } finally { db.close(); } return false; }
	 */
	public int getRoomprice()
	{
		return roomprice;
	}

	public boolean isExists()
	{
		return exists;
	}

}
