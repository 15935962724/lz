package tea.entity.site;

import java.util.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;
import java.sql.SQLException;

public class Communityinfo extends Entity
{
    private static Cache _cache = new Cache(100);
	private int cfid;
    private String community;
    private String host;
    private String name;
    private String ip;
    private String context; //工程的文件夹
    private String picurl; //社区图片路径
    private boolean exists;
    private boolean _bLoad;

    public static Communityinfo find(int cfid) throws SQLException
    {
        Communityinfo obj = (Communityinfo) _cache.get(cfid);
        if(obj == null)
        {
			obj = new Communityinfo(new Integer(cfid));
            _cache.put(cfid,obj);
        }
        return obj;
    }

    public Communityinfo(int cfid) throws SQLException
    {
        this.cfid = cfid;
        _bLoad = !true;
    }

    private void load() throws SQLException
    {
        if(!_bLoad)
        {
            DbAdapter db = new DbAdapter(1);
            try
            {
                db.executeQuery("SELECT host,name,picurl,community,ip,context FROM Communityinfo WHERE cfid="+cfid);
                if(db.next())
                {
                    host = db.getString(1);
                    name = db.getString(2);
                    picurl = db.getString(3);
					community=db.getString(4);
					ip=db.getString(5);
					context=db.getString(6);
                    exists = true;
                } else
                {
                    exists = false;
                }
            } finally
            {
                db.close();
            }
            _bLoad = true;
        }
    }

    /*
     * public void set() throws SQLException { DbAdapter db = new DbAdapter(); try { nodecount = db.getInt("SELECT COUNT(node) FROM Node WHERE community=" + DbAdapter.cite(community)); daycount = db.getInt("SELECT COUNT(node) FROM Node WHERE community=" + DbAdapter.cite(community) + " AND time>" + DbAdapter.cite(sdf.format(new java.util.Date()))); } finally { db.close(); } int j; String str = tea.entity.site.Communityinfo.class.getResource("/").getFile(); java.util.regex.Matcher m =
     * java.util.regex.Pattern.compile("/([^/]+)/WEB-INF/").matcher(str); if (m.find()) { context = m.group(1); } db = new DbAdapter(1); try { ip = java.net.InetAddress.getLocalHost().getHostAddress(); j = db.executeUpdate("UPDATE Communityinfo SET nodecount=" + nodecount + ",daycount=" + daycount + ",ip=" + DbAdapter.cite(ip) + ",context=" + DbAdapter.cite(context) + " WHERE community=" + DbAdapter.cite(community)); } finally { db.close(); } exists = true; if (j < 1) { create(community,
     * nodecount, daycount); } }
     */

	public static boolean isCfid(String community,String ip,String context)throws SQLException
	{
		  DbAdapter db = new DbAdapter(1);
		  boolean f = false;
		  try
		  {
			db.executeQuery("select cfid from Communityinfo where community ="+db.cite(community)+" and ip ="+db.cite(ip)+" and context = "+db.cite(context)+" ");
			if(db.next())
			{
				f = true;
			}
		  }finally
		  {
			  db.close();
		  }
		  return f;
	}

    public static void create(String community,String host,String name,String ip,String context,String picurl) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("INSERT INTO Communityinfo(community,host,name,ip,context,picurl)VALUES"
                             + " (" + DbAdapter.cite(community) + "," + DbAdapter.cite(host) + "," + DbAdapter.cite(name) + " ," + db.cite(ip) + "," + db.cite(context) + "," + db.cite(picurl) + " )");
        } finally
        {
            db.close();
        }
        _cache.remove(community);
    }

    public static Enumeration findByHost(String host,int pos,int pagesize) throws SQLException
    {
        return find(" AND host=" + DbAdapter.cite(host),pos,pagesize);
    }

    public static int countByHost(String host) throws SQLException
    {
        return count(" AND host=" + DbAdapter.cite(host));
    }


    public static Enumeration find(String sql,int pos,int pagesize) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT cfid FROM Communityinfo WHERE 1=1" + sql);
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

    public static int count(String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM Communityinfo WHERE 1=1" + sql);
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

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("DELETE FROM Communityinfo WHERE cfid=" + (cfid));
        } finally
        {
            db.close();
        }
        _cache.remove(community);
    }

    public static void deleteByHost(String host) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("DELETE FROM Communityinfo WHERE host=" + DbAdapter.cite(host));
        } finally
        {
            db.close();
        }
        _cache.clear();
    }

    public String getCommunity()
    {
        return community;
    }

    public boolean isExists() throws SQLException
    {
        load();
        return exists;
    }


    public String getSnapshots()
    {
        return "/res/ROOT/snapshots/" + community + ".jpg";
    }

    public String getName() throws SQLException
    {
        load();
        return name;
    }

    public String getHost() throws SQLException
    {
        load();
        return host;
    }

    public String getContext()
    {
        return context;
    }

    public String getPicurl()
    {
        return picurl;
    }


}
