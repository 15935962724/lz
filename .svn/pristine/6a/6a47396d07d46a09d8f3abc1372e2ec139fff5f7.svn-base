package tea.entity.node;

import java.util.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class TravelShopping extends Entity
{
	private static Cache _cache = new Cache(100);
	private Hashtable _htLayer;
	private int travelshopping;
	private String code;
	private String sessionid;
	private int node;
	private int counts;

	private String postalcode;
	private String phone;
	private int payment;

	private int states;
	private Date time;
	private int language;
	private boolean sex;
	private String email;

	class Layer
	{
		Layer()
		{
		}

		private String name;
		private String address;
		private String request;
	}

	public TravelShopping(int travelshopping) throws SQLException
	{
		this.travelshopping = travelshopping;
		_htLayer = new Hashtable();
		loadBasic();
	}

	public static TravelShopping find(int travelshopping) throws SQLException
	{
		TravelShopping obj = (TravelShopping) _cache.get(new Integer(travelshopping));
		if (obj == null)
		{
			obj = new TravelShopping(travelshopping);
			_cache.put(new Integer(travelshopping), obj);
		}
		return obj;
	}

	private Layer getLayer(int i) throws SQLException
	{
		Layer layer = (Layer) _htLayer.get(new Integer(i));
		if (layer == null)
		{
			layer = new Layer();
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT name,address,request FROM TravelShopping  WHERE travelshopping=" + travelshopping);
				if (db.next())
				{
					layer.name = db.getVarchar(language, i, 1);
					layer.address = db.getVarchar(language, i, 2);
					layer.request = db.getVarchar(language, i, 3);
				}
			}  finally
			{
				db.close();
			}
			_htLayer.put(new Integer(i), layer);
		}
		return layer;
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT language,sessionid ,node      ,counts    ,  postalcode,phone     ,payment   ,states    ,time,sex,email        FROM TravelShopping  WHERE travelshopping=" + travelshopping);
			if (db.next())
			{
				language = db.getInt(1);
				sessionid = db.getString(2);
				node = db.getInt(3);
				counts = db.getInt(4);
				postalcode = db.getString(5);
				phone = db.getString(6);
				payment = db.getInt(7);
				states = db.getInt(8);
				time = db.getDate(9);
				sex = db.getInt(10) != 0;
				email = db.getString(11);
				if (time != null)
				{
					java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMdd");
					code = sdf.format(time) + travelshopping;
				}
			}
		}  finally
		{
			db.close();
		}
	}

	public static java.util.Enumeration findBySessionid(String sessionid) throws SQLException
	{
		java.util.Vector v = new java.util.Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT travelshopping FROM TravelShopping WHERE sessionid=" + DbAdapter.cite(sessionid));
			if (db.next())
			{
				v.addElement(new Integer(db.getInt(1)));
			}
		}  finally
		{
			db.close();
		}
		return v.elements();
	}

	public static java.util.Enumeration find(String community, String sql) throws SQLException
	{
		java.util.Vector v = new java.util.Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT DISTINCT travelshopping FROM TravelShopping,Node WHERE NOT TravelShopping.time IS NULL AND TravelShopping.node=Node.node AND Node.community=" + DbAdapter.cite(community) + sql);
			if (db.next())
			{
				v.addElement(new Integer(db.getInt(1)));
			}
		}  finally
		{
			db.close();
		}
		return v.elements();
	}

	public static int create(String sessionid, int node, int counts) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO TravelShopping(sessionid,node,counts)VALUES(" + DbAdapter.cite(sessionid) + "," + node + "," + counts + ")");
			return db.getInt("SELECT MAX(travelshopping) FROM TravelShopping");
		}  finally
		{
			db.close();
		}
	}

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM TravelShopping WHERE travelshopping=" + travelshopping);
		}  finally
		{
			db.close();
		}
		_cache.remove(new Integer(travelshopping));
	}

	public int getTravelshopping()
	{
		return travelshopping;
	}

	public String getCode()
	{
		return code;
	}

	public String getSessionid()
	{
		return sessionid;
	}

	public int getNode()
	{
		return node;
	}

	public int getCounts()
	{
		return counts;
	}

	public String getName(int language) throws SQLException
	{
		return getLayer(language).name;
	}

	public String getAddress(int language) throws SQLException
	{
		return getLayer(language).address;
	}

	public String getPostalcode()
	{
		return postalcode;
	}

	public String getPhone()
	{
		return phone;
	}

	public int getPayment()
	{
		return payment;
	}

	public String getRequest(int language) throws SQLException
	{
		return getLayer(language).request;
	}

	public int getStates()
	{
		return states;
	}

	public Date getTime()
	{
		return time;
	}

	public String getTimeToString()
	{
		if (time == null)
		{
			return "";
		} else
		{
			return sdf.format(time);
		}
	}

	public int getLanguage()
	{
		return language;
	}

	public boolean isSex()
	{
		return sex;
	}

	public String getEmail()
	{
		return email;
	}

	public void set(String name, boolean sex, String address, String postalcode, String phone, String email, int payment, String request, java.util.Date time, int language) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE TravelShopping SET name=" + DbAdapter.cite(name) + ",sex=" + (sex ? "1" : "0") + ",address=" + DbAdapter.cite(address) + ",postalcode=" + DbAdapter.cite(postalcode) + ",phone=" + DbAdapter.cite(phone) + ",email=" + DbAdapter.cite(email) + ",payment=" + (payment) + ",request=" + DbAdapter.cite(request) + ",states=" + 0 + ",time=" + DbAdapter.cite(time) + ",language=" + language + " WHERE travelshopping=" + travelshopping);
			_cache.remove(new Integer(travelshopping));
		}  finally
		{
			db.close();
		}
	}

	public void setCounts(int counts) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE TravelShopping SET counts=" + counts + " WHERE travelshopping=" + travelshopping);
			this.counts = counts;
		}  finally
		{
			db.close();
		}
	}
}
