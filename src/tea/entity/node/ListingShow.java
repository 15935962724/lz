package tea.entity.node;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class ListingShow
{

	public ListingShow(int id) throws SQLException
	{
		this.id = id;
		loadBasic();
	}

	public static ListingShow find(int id) throws SQLException
	{
		ListingShow listing = (ListingShow) _cache.get(new Integer(id));
		if (listing == null)
		{
			listing = new ListingShow(id);
			_cache.put(new Integer(id), listing);
		}
		return listing;
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT listing,type,typealias,style,root  FROM ListingShow  WHERE id=" + id);
			if (dbadapter.next())
			{
				listing = dbadapter.getInt(1);
				type = dbadapter.getInt(2);
				typeAlias = dbadapter.getInt(3);
				style = dbadapter.getInt(4);
				root = dbadapter.getInt(5);
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

	public static java.util.Enumeration findByListing(int listing) throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT id FROM ListingShow  WHERE listing=" + listing);
			while (dbadapter.next())
			{
				vector.addElement(new Integer(dbadapter.getInt(1)));
			}
		} finally
		{
			dbadapter.close();
		}
		return vector.elements();
	}

	public void delete() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("DELETE FROM ListingShow  WHERE id=" + id);
			_cache.remove(new Integer(id));
		} finally
		{
			dbadapter.close();
		}
	}

	public void set(int listing, int type, int typeAlias, int style, int root) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			// dbadapter.executeUpdate("ListingShowEdit " + id + "," +
			// listing + "," + type + "," + typeAlias + "," + style + "," + root);
			dbadapter.executeQuery("SELECT id FROM ListingShow WHERE id=" + id);
			if (dbadapter.next())
			{
				dbadapter.executeUpdate("UPDATE ListingShow SET type=" + type + ",typealias=" + typeAlias + ",style=" + style + ",root=" + root + " WHERE  id=" + id);
			} else
			{
				dbadapter.executeUpdate("INSERT INTO ListingShow(listing,type,typealias,style,root)VALUES(" + listing + "," + type + "," + typeAlias + "," + style + "," + root + ")");
			}
			this.listing = listing;
			this.type = type;
			this.typeAlias = typeAlias;
			this.style = style;
			this.root = root;
		} finally
		{
			dbadapter.close();
		}
	}

	public static void clone(int sourceListing, int newListing) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("INSERT INTO ListingShow(listing,type,typealias,style,root) SELECT " + newListing + ",type,typealias,style,root FROM ListingShow WHERE listing=" + sourceListing);
		} finally
		{
			dbadapter.close();
		}
	}

	public int getId()
	{
		return id;
	}

	public int getStyle()
	{
		return style;
	}

	public int getType()
	{
		return type;
	}

	public int getRoot()
	{
		return root;
	}

	public int getListing()
	{
		return listing;
	}

	public boolean isExists()
	{
		return exists;
	}

	public int getTypeAlias()
	{
		return typeAlias;
	}

	private static Cache _cache = new Cache(700);
	private int id;
	private int style;
	private int type;
	private int root;
	private int listing;
	private boolean exists;
	private int typeAlias;
	public static final String STYLE_TYPE[] = { "ThisNode", "ThisTree", "SonNodes" };
}
