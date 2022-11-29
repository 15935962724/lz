package tea.entity.node;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class Author extends Entity
{
	public static final String AUTHOR_TYPE[] = { "BookAuthor", "BookTranslator" };
	public static final int AUTHORT_BOOKAUTHOR = 0;
	public static final int AUTHORT_BOOKTRANSLATOR = 1;
	private int _nAuthor;
	private int _nNode;
	private int _nType;
	private int _nSequence;
	private Hashtable _htLayer;
	private boolean _blLoaded;
	private static Cache _cache = new Cache(100);

	class Layer
	{

		String _strName;

		Layer()
		{
		}
	}

	public int getSequence() throws SQLException
	{
		load();
		return _nSequence;
	}

	public void set(int i, int j, String s) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Author SET sequence=" + i + " WHERE author=" + _nAuthor);
			db.executeQuery("SELECT author FROM AuthorLayer WHERE author=" + _nAuthor + " AND language=" + j);
			if (db.next())
			{
				db.executeUpdate("UPDATE AuthorLayer SET name=" + DbAdapter.cite(s) + "  AND language=" + j + "");
			} else
			{
				db.executeUpdate("INSERT INTO AuthorLayer (author, language, name)VALUES (" + _nAuthor + ", " + j + ", " + DbAdapter.cite(s) + ")");
			}
		} finally
		{
			db.close();
		}
		_nSequence = i;
		_htLayer.clear();
	}

	private Author(int i)
	{
		_nAuthor = i;
		_htLayer = new Hashtable();
		_blLoaded = false;
	}

	public static void create(int node, int type, int sequence, int language, String name) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Author (node, type, sequence) VALUES (" + node + ", " + type + ", " + sequence + ")");
			int k = db.getInt("SELECT MAX(author) FROM Author");
			db.executeUpdate("INSERT INTO AuthorLayer (author, language, name) VALUES (" + k + ", " + language + ", " + DbAdapter.cite(name) + ")");
		} finally
		{
			db.close();
		}
	}

	public boolean isLayerExisted(int i) throws SQLException
	{
		boolean flag = false;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT author  FROM AuthorLayer  WHERE author=" + _nAuthor + " AND language=" + i);
			flag = db.next();
		} finally
		{
			db.close();
		}
		return flag;
	}

	public int getNode() throws SQLException
	{
		load();
		return _nNode;
	}

	private void load() throws SQLException
	{
		if (!_blLoaded)
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT node, type, sequence FROM Author  WHERE author=" + _nAuthor);
				if (db.next())
				{
					_nNode = db.getInt(1);
					_nType = db.getInt(2);
					_nSequence = db.getInt(3);
				}
			} finally
			{
				db.close();
			}
			_blLoaded = true;
		}
	}

	public int getType() throws SQLException
	{
		load();
		return _nType;
	}

	public String getName(int i) throws SQLException
	{
		return getLayer(i)._strName;
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
				// int j = db.getInt("AuthorGetLanguage " + _nAuthor + ", " + i);
				int j = this.getLanguage(i);

				db.executeQuery("SELECT name  FROM AuthorLayer  WHERE author=" + _nAuthor + " AND language=" + j);
				if (db.next())
				{
					layer._strName = db.getVarchar(j, i, 1);
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
			db.executeQuery("SELECT language FROM AuthorLayer WHERE author=" + _nAuthor);
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
		{
			if (language == 1)
			{
				if (v.indexOf(new Integer(2)) != -1)
					return 2;
			} else if (language == 2)
			{
				if (v.indexOf(new Integer(1)) != -1)
					return 1;
			}
			if (v.size() == 0)
				return 0;
		}
		return ((Integer) v.elementAt(0)).intValue();
	}

	public void delete(int i) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			// db.executeUpdate("AuthorDeleteLayer " + _nAuthor + ", " + i);

			db.executeUpdate("DELETE FROM AuthorLayer WHERE author=" + _nAuthor + " AND language=" + i);
			db.executeQuery("SELECT author FROM AuthorLayer WHERE author=" + _nAuthor);
			if (db.next())
			{
				db.executeUpdate("DELETE FROM Author WHERE author=" + _nAuthor);
			}
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(_nAuthor));
	}

	public static Author find(int i)
	{
		Author author = (Author) _cache.get(new Integer(i));
		if (author == null)
		{
			author = new Author(i);
			_cache.put(new Integer(i), author);
		}
		return author;
	}

	public static Enumeration findByNodeType(int i, int j) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT author  FROM Author  WHERE node=" + i + " AND type=" + j);
			for (; db.next(); vector.addElement(new Integer(db.getInt(1))))
			{
				;
			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

}
