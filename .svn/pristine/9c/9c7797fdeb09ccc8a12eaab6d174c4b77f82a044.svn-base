package tea.entity.util;

import java.sql.SQLException;
import tea.db.DbAdapter;
import tea.entity.*;

public class Street
{
	private int street;
	private String name;
	private String content;
	private int card;
	private boolean exists;

	public Street(int street) throws SQLException
	{
		this.street = street;
		load();
	}

	public int getCard()
	{
		return card;
	}

	public String getName()
	{
		return name;
	}

	public Street(int street, String name, String content, int card) throws SQLException
	{
		this.street = street;
		this.name = name;
		this.content = content;
		this.card = card;
		this.exists = true;
	}

	public static Street find(int street) throws SQLException
	{
		return new Street(street);
	}

	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT name,content,card FROM street WHERE street=" + street);
			if (db.next())
			{
				name = db.getString(1);
				content = db.getString(2);
				card = db.getInt(3);
				exists = true;
			} else
			{
				exists = false;
			}} finally
		{
			db.close();
		}
	}

	public static void create(int street, String name, String content, int card) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO street(street,name,content,card)VALUES(" + street + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(content) + "," + card + ")");} finally
		{
			db.close();
		}
	}

	public static java.util.Enumeration find(String sql, int pos, int size) throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT street,name,content,card FROM street WHERE 1=1" + sql);
			while (db.next())
			{
				vector.addElement(new Street(db.getInt(1), db.getString(2), db.getString(3), db.getInt(4)));
			}} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public int getStreet()
	{
		return street;
	}

	public boolean isExists()
	{
		return exists;
	}

	public String getContent()
	{
		return content;
	}
	
	public String toString()
	{
		StringBuilder sb = new StringBuilder();
		if (card > 0)
		{
			String str = String.valueOf(card);
			try
			{
				sb.append(Card.find(Integer.parseInt(str.substring(0, 2))).getAddress()).append(" ");
				sb.append(Card.find(Integer.parseInt(str.substring(0, 4))).getAddress()).append(" ");
				sb.append(Card.find(Integer.parseInt(str.substring(0, 6))).getAddress()).append(" ");
			} catch (Exception ex)
			{
			}
		}
		return sb.append(name).toString();
	}
}