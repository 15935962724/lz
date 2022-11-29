package tea.entity.node;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class SeatPic extends Entity
{
    private static Cache _cache = new Cache(100);
    private Hashtable _htLayer;

	private int picid;
    private int node;
    private String picname; //
    private String picpath; //
    private String community; //
    private String member;
    private Date times;
    private int type;//标示 1为座位示意图  2为价格示意图
    private boolean exists;


    public static SeatPic find(int picid) throws SQLException
    {
        SeatPic obj = (SeatPic) _cache.get(new Integer(picid));
        if(obj == null)
        {
            obj = new SeatPic(picid);
            _cache.put(new Integer(picid),obj);
        }
        return obj;
    }

    public SeatPic(int picid) throws SQLException
    {
        this.picid = picid;
        _htLayer = new Hashtable();
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT picname,picpath,community,member,times,node,type FROM SeatPic  WHERE picid=" + picid);
            if(db.next())
            {
                picname = db.getString(1);
                picpath = db.getString(2);
                community = db.getString(3);
                member = db.getString(4);
                times = db.getDate(5);
				node = db.getInt(6);
				type = db.getInt(7);
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

    public static void create(int node,String picname,String picpath,String community,String member,int type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("INSERT INTO SeatPic(node,picname,picpath,community,member,"
                             + " times,type )VALUES(" + node + "," + db.cite(picname) + "," + db.cite(picpath) + "," + db.cite(community) + "," + db.cite(member) + "," + db.cite(times) + ","+type+" )");
        } finally
        {
            db.close();
        }
    }

    public void set(int node,String picname,String picpath) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {

            db.executeUpdate("UPDATE SeatPic SET picname=" + db.cite(picname) + ",picpath=" + db.cite(picpath) + ",node="+node+" WHERE picid = " + picid);

        } finally
        {
            db.close();
        }
        this.picname = picname;
        this.picpath = picpath;
		this.node=node;
        _htLayer.clear();
    }

	public static Enumeration find(String community,String sql,int pos,int size)
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT picid FROM SeatPic WHERE community= " + db.cite(community) + sql,pos,size);
			while(db.next())
			{
				vector.add(new Integer(db.getInt(1)));
			}
		} catch(Exception exception3)
		{
			System.out.print(exception3);
		} finally
		{
			db.close();
		}
		return vector.elements();
    }
    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM  SeatPic WHERE picid = " + picid);

        } finally
        {
            db.close();
        }
    }
    public static void delete(int node,int type)throws SQLException
    {
    	   DbAdapter db = new DbAdapter();
           try
           {
               db.executeUpdate("DELETE FROM  SeatPic WHERE node = " + node +" and type = "+type);

           } finally
           {
               db.close();
           }
    }
    public String getCommunity()
    {
        return community;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getMember()
    {
        return member;
    }

    public String getPicname()
    {
        return picname;
    }

    public String getPicpath()
    {
        return picpath;
    }

    public Date getTimes()
    {
        return times;
    }
	public String getTimeToString()
	{
		if(times == null)
			return "";
		return sdf.format(times);
	}
	public int getNode()
	{
		return node;
	}
	public int getType()
	{
		return type;
	}

}
