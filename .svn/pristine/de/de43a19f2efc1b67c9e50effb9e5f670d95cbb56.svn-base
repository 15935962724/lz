package tea.entity.node;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Discoun extends Entity
{
	private int disid;//打折表ID
	private int psid;//场次id
	private int voteid;//票种ID
	private float disprice;//折扣设置
	private Date timek;//开始时间
	private Date timej;//结束时间
	private String member;
	private String community;
    private boolean exist; //
    
    public final static String DISPRICE_TYPE []={"","9.0","8.0","7.0","6.0","5.0","4.0","3.0","2.0","1.0"};
	public  Discoun(int disid)throws SQLException
	{
		this.disid = disid;
		load();
	}
	
	public static Discoun find(int disid)throws SQLException
	{
		return new Discoun(disid);
	}
	
	public void load()throws SQLException
	{
		DbAdapter db =new DbAdapter();
		try
		{
				db.executeQuery("SELECT psid,voteid,disprice,timek,timej,member,community FROM Discoun WHERE disid="+disid);	
				if(db.next())
				{
					psid=db.getInt(1);
					voteid=db.getInt(2);
					disprice=db.getFloat(3);
					timek=db.getDate(4);
					timej=db.getDate(5);
					member=db.getString(6);
					community=db.getString(7);
					exist=true;
				}else
				{
					exist= false;
				}
		}finally
		{
			db.close();
		}
	}
	
	public static void create(int psid, int voteid, float disprice, Date timek,Date timej,  String member,String community) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Discoun(psid,voteid,disprice,timek,timej,member,community) VALUES(" + psid + "," +voteid + ","+disprice+","+db.cite(timek)+","+db.cite(timej)+"," + db.cite(member) + ","
					+ db.cite(community) + " )");

		} finally
		{
			db.close();
		}
	} 
	
	public void set(int psid, int voteid, float disprice, Date timek,Date timej,  String member,String community) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Discoun SET psid ="+psid+",voteid="+voteid+",disprice="+disprice+",timek="+db.cite(timek)+",timej="+db.cite(timej)+",member="+db.cite(member)+",community="+db.cite(community)+" WHERE disid= "+disid);
		} finally
		{
			db.close();
		}
		this.psid=psid;
		this.voteid=voteid;
		this.disprice=disprice;
		this.timej=timej;
		this.timek=timek;
		this.member=member;
		this.community=community;
	}
	public static Enumeration find(String community, String sql, int pos, int size)
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT disid FROM Discoun WHERE community= " + db.cite(community) + sql, pos, size);
			while (db.next())
			{
				vector.add(new Integer(db.getInt(1)));
			}
		} catch (Exception exception3)
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
			db.executeUpdate("DELETE FROM  Discoun WHERE disid = " + disid);
		} finally
		{
			db.close();
		}
	}
	public static void delete(int psid) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM  Discoun WHERE psid = " + psid);
		} finally
		{
			db.close();
		}
	}
	public int getPsid()
	{
		return psid;
	}

	public int getVoteid()
	{
		return voteid;
	}

	public float getDisprice()
	{
		return disprice;
	}

	public Date getTimek()
	{
		return timek;
	}
	public String getTimekToString()
	{
		if(timek == null)
			return "";
		return sdf2.format(timek);
	}

	public Date getTimej()
	{
		return timej;
	}
	public String getTimejToString()
	{
		if(timej == null)
			return "";
		return sdf2.format(timej);
	}
	public String getMember()
	{
		return member;
	}

	public String getCommunity()
	{
		return community;
	}

	public boolean isExist()
	{
		return exist;
	}
	
	
	
}
