package tea.entity.ocean;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;


public class LevyPicture extends Entity
{
    private int id;//community,firstname,tel,card,address,path,type,member,addtime,verifydate
    private String community;
    private String firstname;
    private String tel;
    private String card;
    private String address;
    private String path;
    private int type;
    private String member;
    private Date addtime;
    private Date verifydate;
	private boolean exists;


    public static LevyPicture find(int id) throws SQLException
    {
        return new LevyPicture(id);
    }

    public LevyPicture(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public void load() throws SQLException
    {
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("Select community,firstname,tel,card,address,path,type,member,addtime,verifydate from  LevyPicture where id="+id);
			if(db.next())
			{
				int j=1;
                community = db.getString(j++);
                firstname = db.getString(j++);
                tel = db.getString(j++);
                card = db.getString(j++);
                address = db.getString(j++);
                path = db.getString(j++);
                type = db.getInt(j++);
                member = db.getString(j++);
                addtime = db.getDate(j++);
                verifydate = db.getDate(j++);
				exists = true;
			}
			else
			{
				exists = false;
			}
		}
		finally
		{
			db.close();
		}
    }

	public static void set(int id,String community,String firstname,String tel,String card,String address,String path,int type,String member,Date addtime,Date verifydate) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("select id from LevyPicture where id="+id);
			if(db.next())
			{
				db.executeUpdate("Update LevyPicture set  community="+db.cite(community)+",firstname="+db.cite(firstname)+",tel="+db.cite(tel)+",card="+db.cite(card)+",address="+db.cite(address)+",path="+db.cite(path)+",type="+type+",member="+db.cite(member)+",addtime="+db.cite(addtime)+",verifydate="+db.cite(verifydate)+"   where id="+id);
			}
			else
			{
				db.executeUpdate("Insert into LevyPicture (community,firstname,tel,card,address,path,type,member,addtime,verifydate)values("+db.cite(community)+","+db.cite(firstname)+","+db.cite(tel)+","+db.cite(card)+","+db.cite(address)+","+db.cite(path)+","+type+","+db.cite(member)+","+db.cite(addtime)+","+db.cite(verifydate)+")");
			}
		}
		finally
		{
			db.close();
		}
	}


	public static Enumeration findByCommunity(String community,String sql,int pos,int size) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();

		try
		{
			db.executeQuery("SELECT id FROM LevyPicture WHERE 1=1 " + sql);
			for(int i=0;i<pos+size && db.next();i++)
			{
				if(i>=pos)
				v.addElement(db.getInt(1));
			}
		} finally
		{
			db.close();
		}
		return v.elements();
	}


    public static int count(String community,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int num = 0;
        try
        {
            db.executeQuery("Select count(id) from LevyPicture where community=" + db.cite(community) + " " + sql);
            if(db.next())
            {

                num = db.getInt(1);
                return num;
            } else
            {
                return num;
            }
        } finally
        {
            db.close();
        }
    }

	public static void delete(int id) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		int num = 0;
		try
		{
			db.executeUpdate("delete LevyPicture where id=" + id);
		} finally
		{
			db.close();
		}
	}


    public String getAddress()
    {
        return address;
    }

    public Date getAddtime()
    {
        return addtime;
    }

    public String getAddtimetoString()
    {
        if(addtime != null)
        {
            return LevyPicture.sdf.format(addtime);
        } else
        {
            return "";
        }
    }

    public String getCard()
    {
        return card;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getFirstname()
    {
        return firstname;
    }

    public int getId()
    {
        return id;
    }

    public String getMember()
    {
        return member;
    }

    public String getPath()
    {
        return path;
    }

    public String getTel()
    {
        return tel;
    }

    public int getType()
    {
        return type;
    }

    public Date getVerifydate()
    {
        return verifydate;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getVerifydatetoString()
    {
		if(verifydate!=null)
		{
			return LevyPicture.sdf.format(verifydate);
		}
		else
		{
			return "";
		}

    }
}
