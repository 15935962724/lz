package tea.entity.node;

import java.sql.*;
import java.util.*;
import tea.resource.*;
import tea.db.*;
import tea.entity.*;
import java.io.*;

public class Media extends Entity
{
	public static Cache _cache = new Cache(100);
	private Hashtable _htLayer;
	public int media;
	public String community;
	public int type; //0:新闻咨询,1:知识资源,2:招标
	class Layer
	{
		public int language;
		public String name;
		public String logo;
		public String url;
	}


	public Media(int media) throws SQLException
	{
		this.media = media;
		_htLayer = new Hashtable();
	}

	public static Media find(int media) throws SQLException
	{
		Media t = (Media) _cache.get(new Integer(media));
		if(t == null)
		{
			ArrayList al = find(" AND m.media=" + media,0,1);
			t = al.size() < 1 ? new Media(media) : (Media) al.get(0);
		}
		return t;
	}

	public void set(int language,String name,String logo,String url) throws SQLException,IOException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			if(media < 1)
				db.executeUpdate(media,"INSERT INTO Media(media,community,type)VALUES(" + (media = Seq.get()) + "," + DbAdapter.cite(community) + "," + type + ")");
			int j = db.executeUpdate(media,"UPDATE MediaLayer SET name=" + DbAdapter.cite(name) + ",logo=" + DbAdapter.cite(logo) + ",url=" + DbAdapter.cite(url) + " WHERE media=" + media + " AND language=" + language);
			if(j < 1)
				db.executeUpdate(media,"INSERT INTO MediaLayer(media,language,name,logo,url)VALUES(" + media + "," + language + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(logo) + "," + DbAdapter.cite(url) + ")");
		} finally
		{
			db.close();
		}
		Media.js(language,type);
		_htLayer.clear();
	}

	private int getLanguage(int language) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT language FROM MediaLayer WHERE media=" + media);
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


	private Layer getLayer(int i) throws SQLException
	{
		Layer layer = (Layer) _htLayer.get(new Integer(i));
		if(layer == null)
		{
			layer = new Layer();
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT language,name,logo,url FROM MediaLayer WHERE media=" + media + " ORDER BY " + (ConnectionPool._nType == 1 ? "DBO." : "") + "LAYER(language," + i + ")");
				if(db.next())
				{
					layer.name = db.getVarchar(db.getInt(1),i,2);
					layer.logo = db.getString(3);
					layer.url = db.getString(4);
				}
			} finally
			{
				db.close();
			}
			_htLayer.put(new Integer(i),layer);
		}
		return layer;
	}

	public String getName(int language) throws SQLException
	{
		return getLayer(language).name;
	}

	public String getLogo(int language) throws SQLException
	{
		return getLayer(language).logo;
	}

	public String getUrl(int language) throws SQLException
	{
		return getLayer(language).url;
	}

	public static int count(String sql) throws SQLException
	{
		int j = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT COUNT(m.media) FROM Media m" + tab(sql) + " WHERE 1=1" + sql);
			if(db.next())
			{
				j = db.getInt(1);
			}
		} finally
		{
			db.close();
		}
		return j;
	}

	public static ArrayList find(String sql,int pos,int size) throws SQLException
	{
		ArrayList al = new ArrayList();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT m.media,m.community,m.type FROM Media m" + tab(sql) + " WHERE 1=1" + sql,pos,size);
			while(db.next())
			{
				Media t = new Media(db.getInt(1));
				t.community = db.getString(2);
				t.type = db.getInt(3);
				_cache.put(t.media,t);
				al.add(t);
			}
		} finally
		{
			db.close();
		}
		return al;
	}

	public boolean isLayerExists(int i) throws SQLException
	{
		return getLanguage(i) == i;
	}

	public void delete(int language) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate(media,"DELETE FROM MediaLayer WHERE media=" + media + " AND language=" + language);
			db.executeQuery("SELECT media FROM MediaLayer WHERE media=" + media);
			if(!db.next())
			{
				db.executeUpdate(media,"DELETE FROM Media WHERE media=" + media);
			}
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(media));
	}

	static String tab(String sql)
	{
		StringBuilder sb = new StringBuilder();
		if(sql.contains(" AND ml."))
			sb.append(" INNER JOIN MediaLayer ml ON m.media=ml.media");
		return sb.toString();
	}

	public static void js(int lang,int type) throws IOException,SQLException
	{
		PrintWriter pw = new PrintWriter(Common.REAL_PATH + "/tea/inc/media_" + lang + "_" + type + ".js","UTF-8");
		try
		{
			pw.write("var h=\"<option value='0'>-------------------------");
			ArrayList al = Media.find(" AND m.type=" + type,0,Integer.MAX_VALUE);
			for(int i = 0;i < al.size();i++)
			{
				Media m = (Media) al.get(i);
				pw.write("<option value='" + m.media + "'>" + m.getName(lang));
			}
			pw.write("\";");
			pw.write("function media(name,dv)");
			pw.write("{");
			pw.write("  document.write(\"<select name='\"+name+\"'>\"); document.write(h); document.write(\"</select>\");");
			pw.write("  document.all(name).value=dv;");
			pw.write("}");
		} finally
		{
			pw.close();
		}
	}

//    public static String options(String community,int type,int lang) throws SQLException
//    {
//        StringBuilder sb = new StringBuilder();
//        ArrayList e = Media.find(" AND m.community=" + DbAdapter.cite(community) + " AND m.type=" + type + " AND m.media in (select media from medialayer)",0,Integer.MAX_VALUE);
//        for(int i = 0;i < e.size();i++)
//        {
//            Media nobj = (Media) e.get(i);
//            sb.append("<option value=" + nobj.media + ">" + nobj.getName(lang) + "</option>");
//        }
//        return sb.toString();
//    }

	public String toString()
	{
		StringBuilder sb = new StringBuilder();
		sb.append("{media:" + media);
		sb.append(",type:" + type);
		sb.append("}");
		return sb.toString();
	}
}
