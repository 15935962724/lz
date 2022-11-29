package tea.entity.node;


import java.sql.*;
import java.util.*;
import java.util.Date;


import tea.db.*;
import tea.entity.*;

public class SeatEditor extends Entity
{
    private static Cache _cache = new Cache(100);
    private Hashtable _htLayer;

	private int seid;
    private int node;
    private String region; // 区域
    private int linagenumber; //排号
    private int seatnumber; //座号
    private int picid; //视图id
    private String community; //
    private String member;
    private Date times;
    private boolean exists;

    public static SeatEditor find(int seid,int node) throws SQLException
	{
            return  new SeatEditor(seid,node);
    }

    public SeatEditor(int seid,int node) throws SQLException
    {
        this.seid = seid;
		this.node = node;
        _htLayer = new Hashtable();
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT region,linagenumber,seatnumber,picid,community,member,times FROM SeatEditor  WHERE seid=" + seid +" and node= "+node);
            if(db.next())
            {
                region = db.getString(1);
                linagenumber = db.getInt(2);
                seatnumber = db.getInt(3);
                picid = db.getInt(4);
                community = db.getString(5);
                member = db.getString(6);
                times = db.getDate(7);
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

    public static void create(int seid,int node,String region,int linagenumber,int seatnumber,int picid,String community,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("INSERT INTO SeatEditor(node,region,linagenumber,seatnumber,picid,community,member,"
                             + " times,seid )VALUES(" + node + "," + db.cite(region) + "," + linagenumber + "," + seatnumber + "," + picid + "," + db.cite(community) + "," + db.cite(member) + "," + db.cite(times) + ","+seid+" )");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(seid));
    }

    public void set(String region,int linagenumber,int seatnumber,int picid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {

            db.executeUpdate("UPDATE SeatEditor SET region=" + db.cite(region) + ", linagenumber=" + linagenumber + ",seatnumber=" + seatnumber + ",picid=" + picid + " WHERE seid = " + seid +" AND node = "+node);

        } finally
        {
            db.close();
        }
        this.region = region;
        this.linagenumber = linagenumber;
        this.seatnumber = seatnumber;
        this.picid = picid;
        _htLayer.clear();
    }

	public static Enumeration find(String community,String sql,int pos,int size)
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT seid FROM SeatEditor WHERE community= " + db.cite(community) + sql,pos,size);
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
            db.executeUpdate("DELETE FROM  SeatEditor WHERE seid = " + seid +" AND node = "+node);


        } finally
        {
            db.close();
        }
    }
    public static  void delete(int node) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM  SeatEditor WHERE  node = "+node);


        } finally
        {
            db.close();
        }
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(node) FROM SeatEditor  WHERE community=" + db.cite(community) + sql);
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


    public String getCommunity()
    {
        return community;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getLinagenumber()
    {
        return linagenumber;
    }

    public String getMember()
    {
        return member;
    }

    public int getPicid()
    {
        return picid;
    }

    public String getRegion()
    {
        return region;
    }

    public int getSeatnumber()
    {
        return seatnumber;
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


}
