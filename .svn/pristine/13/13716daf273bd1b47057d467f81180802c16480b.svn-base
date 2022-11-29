// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3)
// Source File Name:   CreateBookBuy.java

package tea;
import java.io.PrintStream;
import java.math.BigDecimal;
import java.sql.*;
import java.text.DateFormat;
import java.util.Date;
public class CreateBookBuy
{
	public static String citeSql(String s)
	{
		if (s == null)
			return "null";
		if (s.indexOf(ACSQL[0]) != -1)
			s = replace(s, ACSQL, ASTRSQL);
		return "'" + s + "'";
	}
	public static String citeSql(byte ab[])
	{
		if (ab == null)
			return "null";
		StringBuilder sb = new StringBuilder("0x");
		for (int i = 0; i < ab.length; i++)
			sb.append(BYTEMAP[0xff & ab[i]]);

		return sb.toString();
	}

	public CreateBookBuy()
	{
	}

	public static String replace(String s, char ac[], String astr[])
	{
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < s.length(); i++)
		{
			char c = s.charAt(i);
			boolean blReplaced = false;
			for (int j = 0; j < ac.length; j++)
			{
				if (c != ac[j])
					continue;
				sb.append(astr[j]);
				blReplaced = true;
				break;
			}

			if (!blReplaced)
				sb.append(c);
		}

		return sb.toString();
	}

	public static String nullTo0(String s)
	{
		if (s == null)
			return "";
		else
			return s.trim();
	}

	/*public static void main(String argv[])
	{
		try
		{
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			Connection conFrom = DriverManager.getConnection("jdbc:odbc:Trendscape", "sa", "");
			Statement stmtFrom = conFrom.createStatement();
			Connection conFrom2 = DriverManager.getConnection("jdbc:odbc:Trendscape", "sa", "");
			Statement stmtFrom2 = conFrom2.createStatement();
			Connection conTo = DriverManager.getConnection("jdbc:odbc:Trendscape", "sa", "");
			Statement stmtTo = conTo.createStatement();
			String strCommunity = "shopping_china_books";
			int i = 0;
			ResultSet rsFrom;
			for (rsFrom = stmtFrom.executeQuery("SELECT n.node, rcreator, vcreator, options, path, price  FROM Node n, Book b  WHERE n.node=b.node  AND n.community=" + citeSql(strCommunity)); rsFrom.next();)
			{
				int nFather = rsFrom.getInt(1);
				String strRCreator = rsFrom.getString(2);
				String strVCreator = rsFrom.getString(3);
				int nOptions = rsFrom.getInt(4);
				String strPath = rsFrom.getString(5);
				BigDecimal bdPrice = rsFrom.getBigDecimal(6, 2);
				boolean blCategoryExisted = false;
				ResultSet rsFrom2 = stmtFrom2.executeQuery("SELECT node  FROM Node  WHERE father=" + nFather + " AND type=1");
				if (rsFrom2.next())
					blCategoryExisted = true;
				rsFrom2.close();
				if (blCategoryExisted)
				{
					System.err.print("\rCatgory existed: " + nFather);
				} else
				{
					System.err.println("Book: " + nFather);
					conTo.setAutoCommit(false);
					try
					{
						stmtTo.executeUpdate("INSERT INTO Node  (community, time, father, sequence, rcreator, vcreator, type, hidden, options, options1, starttime, stoptime, path) VALUES(" + citeSql(strCommunity) + ", " + citeSql(DateFormat.getDateTimeInstance().format(new Date(System.currentTimeMillis()))) + ", " + nFather + ", " + 0 + ", " + citeSql(strRCreator) + ", " + citeSql(strVCreator) + ", " + 1 + ", " + 0 + ", " + (nOptions | 0x40000) + ", 0 " + ", null, null " + ", '') ");
						int nNode = 0;
						ResultSet rsTo = stmtTo.executeQuery("SELECT MAX(node) FROM Node");
						if (rsTo.next())
							nNode = rsTo.getInt(1);
						rsTo.close();
						if (nNode == 0)
						{
							System.err.println("Insert category node failure");
							conTo.rollback();
							conTo.setAutoCommit(true);
							break;
						}
						stmtTo.executeUpdate("UPDATE Node  SET path=" + citeSql(strPath + "/" + nNode) + " WHERE node=" + nNode);
						stmtTo.executeUpdate("INSERT INTO NodeLayer  (node, language, subject, keywords)VALUES(" + nNode + ", " + 1 + ", " + citeSql("\271\272\302\362") + ", " + citeSql("") + ")");
						stmtTo.executeUpdate("INSERT INTO Category  (node, category, typealias)  VALUES(" + nNode + ", 4, 0)");
						stmtTo.executeUpdate("INSERT INTO Node  (community, time, father, sequence, rcreator, vcreator, type, hidden, options, options1, starttime, stoptime, path) VALUES(" + citeSql(strCommunity) + ", " + citeSql(DateFormat.getDateTimeInstance().format(new Date(System.currentTimeMillis()))) + ", " + nNode + ", " + 0 + ", " + citeSql(strRCreator) + ", " + citeSql(strVCreator) + ", " + 4 + ", " + 0 + ", " + (nOptions | 0x40000) + ", 0 " + ", null, null, '') ");
						int nSon = 0;
						rsTo = stmtTo.executeQuery("SELECT MAX(node) FROM Node");
						if (rsTo.next())
							nSon = rsTo.getInt(1);
						rsTo.close();
						if (nSon == 0)
						{
							System.err.println("Insert buy node failure: " + nFather + " : " + nNode);
							conTo.rollback();
							conTo.setAutoCommit(true);
							break;
						}
						stmtTo.executeUpdate("UPDATE Node  SET path=" + citeSql(strPath + "/" + nNode + "/" + nSon) + " WHERE node=" + nNode);
						stmtTo.executeUpdate("INSERT INTO NodeLayer  (node, language, subject, keywords)VALUES(" + nSon + ", " + 1 + ", " + citeSql("\320\302\273\252\312\351\265\352") + ", " + citeSql("") + ")");
						stmtTo.executeUpdate("INSERT INTO Commodity (node, sku, serialnumber, quality, inventory, minquantity, maxquantity, delta)  VALUES(" + nSon + ", '', '', 0, 1000, 0, 0, 0)");
						BigDecimal bdRealPrice = bdPrice.multiply(new BigDecimal("0.9"));
						stmtTo.executeUpdate("INSERT INTO BuyPrice (node, currency, supply, list, price) VALUES(" + nSon + ", 1, " + bdPrice + ", " + bdPrice + ", " + bdRealPrice + ")");
						BigDecimal bdUsPrice = bdPrice.multiply(new BigDecimal("0.67"));
						BigDecimal bdRealUsPrice = bdUsPrice.multiply(new BigDecimal("0.9"));
						stmtTo.executeUpdate("INSERT INTO BuyPrice (node, currency, supply, list, price) VALUES(" + nSon + ", 0, " + bdUsPrice + ", " + bdUsPrice + ", " + bdRealUsPrice + ")");
						conTo.commit();
					} catch (Exception eee)
					{
						eee.printStackTrace();
						conTo.rollback();
						break;
					}
					conTo.setAutoCommit(true);
				}
				System.err.print("\r" + i + "               ");
				i++;
			}

			rsFrom.close();
			stmtFrom.close();
			conFrom.close();
			stmtTo.close();
			conTo.close();
			System.err.println("\nEND");
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}*/

	static final String JDBC_DRIVER = "sun.jdbc.odbc.JdbcOdbcDriver";
	static final String FROM_URL = "jdbc:odbc:Trendscape";
	static final String TO_URL = "jdbc:odbc:Trendscape";
	static final String DBO_USER_ID = "sa";
	static final String DBO_PASSWORD = "";
	private static String BYTEMAP[];
	static final char ACSQL[] = { '\'' };
	static final String ASTRSQL[] = { "''" };

}
