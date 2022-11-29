package tea.entity.integral;
import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
public class Integral extends Entity
{
    private int igid;
    private float scwz;
	private float llwz;
	private float sczy;
	private float xzzy; 
	private float wzbll; 
	private float zybxz; 
	
    private String member; //添加积分的用户
    private String community; //所属的社区
    private Date times; //最后 时间
	private int type;//类别 id
	private int typealias;//别名类别 id
    private boolean exists;

	public  Integral(int igid)throws SQLException
	{
		this.igid = igid;
		load();
	}
	public static Integral find(int igid)throws SQLException
	{
		return new Integral(new Integer(igid));
	}

	public void load()throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT scwz, llwz, sczy, xzzy,wzbll,zybxz,community,times,member,type,typealias FROM Integral WHERE igid = "+igid);
			if(db.next())
			{
				 scwz=db.getFloat(1);
            	 llwz=db.getFloat(2);
            	 sczy=db.getFloat(3); 
            	 xzzy=db.getFloat(4); 
            	 wzbll=db.getFloat(5);
            	 zybxz=db.getFloat(6);
                community = db.getString(7);
                times = db.getDate(8);
                member = db.getString(9);
				type = db.getInt(10);
				typealias=db.getInt(11);
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

    public static int create(String field,float fieldvalue,int type,int typealias,String community,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        int i = 0;
        try
        {
            db.executeUpdate("INSERT INTO Integral (" + field + ",type,typealias,community,member,times) VALUES (" + fieldvalue + ","+type+","+typealias+"," + db.cite(community) + "," + db.cite(member) + "," + db.cite(times) + ")");
            i = db.getInt("SELECT MAX(igid) FROM Integral");
        } finally
        {
            db.close();
        }
        return i;
    }

	public void set(String field,float fieldvalue,String member)throws SQLException
	{
		DbAdapter db = new DbAdapter();
        Date times = new Date();
		try
		{
			db.executeUpdate("UPDATE Integral SET "+field+"="+fieldvalue+" ,member="+db.cite(member)+",times="+db.cite(times)+" WHERE  igid="+igid);
		}finally
		{
			db.close();
		}
	}

	//判断 这个 类别 是否 存在
	public static int getIgid(String community,int type,int typealias)throws SQLException
	{
		DbAdapter db = new DbAdapter();
		int i = 0;
		try
		{
			db.executeQuery("SELECT igid FROM Integral WHERE community="+db.cite(community)+" and  type ="+type+" and typealias="+typealias);
			if(db.next())
			{
				i = db.getInt(1);
			}
		}finally
		{
			db.close();
		}
		return i;
	}


  
    public boolean isExists()
    {
        return exists;
    }

    public String getMember()
    {
        return member;
    }

   

    public Date getTimes()
    {
        return times;
    }

	public String getTimesToString()
	{
		if(times == null)
			return "";
		return sdf.format(times);
	}

    public int getType()
    {
        return type;
    }

    public int getTypealias()
    {
        return typealias;
    }
	public float getScwz()
	{
		return scwz;
	}
	public float getLlwz()
	{
		return llwz;
	}
	public float getSczy()
	{
		return sczy;
	}
	public float getXzzy()
	{
		return xzzy;
	}
	public float getWzbll()
	{
		return wzbll;
	}
	public float getZybxz()
	{
		return zybxz;
	}

   


}
