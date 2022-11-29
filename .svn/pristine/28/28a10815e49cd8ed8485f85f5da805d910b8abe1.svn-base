package tea.entity.integral;
import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
public class CommunityPoints extends Entity
{
	private int igid;
	private float pthyjf;//注册普通会员加分
	private float sjhyjf;//普通会员升级积分限定
	private float yqhyjf;//邀请会员加分
	private float yshyjf;//医生升级为高级会员加分
	private float dlhyjf;//会员登陆加分
	
	//投稿加分
	private float tgjf;//投稿加分
	private float cyjf;//稿件被采用加分
	private float jjjf;//聚焦稿件加分
	private float ttjf1;//头条1稿件加分
	private float ttjf2;//头条2稿件加分
	private float ttjf3;//头条3稿件加分
	private float tgjianf;//退稿减分
	
	//绑定的id
	private int mark;//聚焦的id
	private int mark1;//头条1
	private int mark2;//头条2
	private int mark3;//头条3
	
	private String community; //所属的社区

	private boolean exists;

	public  CommunityPoints(int igid)throws SQLException
	{
		this.igid = igid;
		load();
	}
	public static CommunityPoints find(int igid)throws SQLException
	{
		return new CommunityPoints(new Integer(igid));
	}

	public void load()throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT  pthyjf, sjhyjf,yqhyjf, yshyjf,community,dlhyjf,tgjf,cyjf,jjjf, ttjf1, ttjf2, ttjf3,tgjianf,mark,mark1,mark2,mark3 FROM CommunityPoints WHERE igid = "+igid);
			if(db.next())
			{
				pthyjf=db.getFloat(1);
				sjhyjf=db.getFloat(2);
				yqhyjf=db.getFloat(3);
				yshyjf=db.getFloat(4);
				community = db.getString(5);
				dlhyjf=db.getFloat(6);
				
				tgjf=db.getFloat(7);
				cyjf=db.getFloat(8);
				jjjf=db.getFloat(9);
				ttjf1=db.getFloat(10);
				ttjf2=db.getFloat(11);
				ttjf3=db.getFloat(12);
				tgjianf=db.getFloat(13);
				
				mark=db.getInt(14);
				mark1=db.getInt(15);
				mark2=db.getInt(16);
				mark3=db.getInt(17);
				
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
	public static int create(String field,float fieldvalue,String community) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		Date times = new Date();
		int i = 0; 
		try
		{
			db.executeUpdate("INSERT INTO CommunityPoints (" + field + ",community) VALUES (" + fieldvalue + ","+DbAdapter.cite(community) + ")");
			i = db.getInt("SELECT MAX(igid) FROM CommunityPoints");
		} finally
		{
			db.close();
		}
		return i;
	}

	public void set(String field,float fieldvalue)throws SQLException
	{
		DbAdapter db = new DbAdapter();
		Date times = new Date();
		try
		{
			db.executeUpdate("UPDATE CommunityPoints SET "+field+"="+fieldvalue+" WHERE  igid="+igid);
		}finally
		{
			db.close();
		}
	}

	//判断 这个 类别 是否 存在
	public static int getIgid(String community)throws SQLException
	{
		DbAdapter db = new DbAdapter();
		int i = 0;
		try
		{
			db.executeQuery("SELECT igid FROM CommunityPoints WHERE community="+db.cite(community));
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
	public float getPthyjf()
	{
		return pthyjf;
	}
	public float getSjhyjf()
	{
		return sjhyjf;
	}
	public float getYqhyjf()
	{
		return yqhyjf;
	}
	public float getYshyjf()
	{
		return yshyjf;
	}
	public float getTgjf()
	{
		return tgjf;
	}
	public float getTtjf1()
	{
		return ttjf1;
	}
	public float getTtjf2()
	{
		return ttjf2;
	}
	public float getTtjf3()
	{
		return ttjf3;
	}
	public float getTgjianf()
	{
		return tgjianf;
	}
	public float getCyjf()
	{
		return cyjf;
	}
	public float getJjjf()
	{
		return jjjf;
	}
	public float getDlhyjf()
	{
		return dlhyjf;
	}
	public String getCommunity()
	{
		return community;
	}
	public int getMark()
	{
		return mark;
	}
	public int getMark1()
	{
		return mark1;
	}
	public int getMark2()
	{
		return mark2;
	}
	public int getMark3()
	{
		return mark3;
	}




}
