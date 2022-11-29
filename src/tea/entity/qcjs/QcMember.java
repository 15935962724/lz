package tea.entity.qcjs;

import java.sql.SQLException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.Entity;
import tea.entity.photography.Photography;

public class QcMember extends Entity
{
	private int mid;
	private String name;//姓名
	private int sex;//性别 0 男 1 女 
	private String card;//身份证
	private String telephone;//电话
	private String mobile;//手机
	private String address;//地址
	private Date registratime;//报名时间
	private String archives;//档案编号
	private Date outtime;//出证时间
	private String source;//来源
	private String community;//
	private Date times;//
	private String member;//添加用户
	private String drivers;//驾驶证号
	private boolean exists;
	
	public static QcMember find(int mid) throws SQLException
	{
		return new QcMember(mid);
	}
	
	public QcMember(int mid) throws SQLException
	{
		this.mid = mid;
		load();
	}
	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT name,sex,card,telephone,mobile,address,registratime,archives,outtime,source,community,times,member,drivers FROM QcMember  WHERE mid=" + mid);
			if(db.next())
			{
				name=db.getString(1);
				sex=db.getInt(2);
				card=db.getString(3);
				telephone=db.getString(4);
				mobile=db.getString(5);
				address=db.getString(6);
				registratime=db.getDate(7);
				archives=db.getString(8);
				outtime=db.getDate(9);
				source=db.getString(10);
				community=db.getString(11);
				times=db.getDate(12);
				member=db.getString(13);
				drivers=db.getString(14);
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
	
	public static void create(String name,int sex,String card,String telephone,String mobile,String address,Date registratime,String archives,Date outtime,String source,
			String community,Date times,String member,String drivers) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO QcMember(name,sex,card,telephone,mobile,address,registratime,archives,outtime,source,community,times,member,drivers)VALUES" +
					"("+db.cite(name)+","+sex+","+db.cite(card)+","+db.cite(telephone)+" ,"+db.cite(mobile)+" ,"+db.cite(address)+" ,"+db.cite(registratime)+" ,"+db.cite(archives)+" ," +
					" "+db.cite(outtime)+" ,"+db.cite(source)+" ,"+db.cite(community)+" ,"+db.cite(times)+","+db.cite(member)+" ,"+db.cite(drivers)+"     )");
		
		} finally
		{
			db.close();
		}
	}
	
	
	public void set(String name,int sex,String card,String telephone,String mobile,String address,Date registratime,String archives,Date outtime,String source,
			String community,String member,String drivers) throws SQLException
	{
		StringBuilder sb = new StringBuilder();
		sb.append("UPDATE QcMember SET");
		sb.append(" name=").append(DbAdapter.cite(name));
		sb.append(",sex=").append(sex);
		sb.append(",card=").append(DbAdapter.cite(card));
		sb.append(",telephone=").append(DbAdapter.cite(telephone));
		sb.append(",address=").append(DbAdapter.cite(address));
		sb.append(",registratime=").append(DbAdapter.cite(registratime));
		sb.append(",archives=").append(DbAdapter.cite(archives));
		sb.append(",outtime=").append(DbAdapter.cite(outtime));
		sb.append(",source=").append(DbAdapter.cite(source));
		sb.append(",community=").append(DbAdapter.cite(community));
		sb.append(",member=").append(DbAdapter.cite(member));
		sb.append(",drivers=").append(DbAdapter.cite(drivers));
	
	
		sb.append(" WHERE mid=").append( mid);
		DbAdapter db = new DbAdapter();
		try
		{
			 db.executeUpdate(sb.toString());
		} finally
		{
			db.close();
		}
	}
	
	public void delete()throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate(" DELETE FROM QcMember   WHERE mid=" + mid);
		} finally
		{
			db.close();
		}
	}
	
    public static Enumeration find(String community,String sql,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT mid FROM QcMember WHERE community= " + db.cite(community) + sql,pos,size);
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
	
    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(mid) FROM QcMember  WHERE community=" + db.cite(community) + sql);
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
    //通过驾驶证号和档案号 查询id	private String drivers;//驾驶证号archives
    public static int getMid(String community,String card ,String archives) throws SQLException
    {
    	int mid = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT mid FROM QcMember  WHERE community=" + db.cite(community) + " and card ="+db.cite(card)+" and archives ="+db.cite(archives)+" ");
            if(db.next())
            {
                mid = db.getInt(1);
            }
        } finally
        {
            db.close();
        } 
        return mid;
    }
    public String getName()
    {
        return name;
    }

    public int getSex()
    {
        return sex;
    }
    public String getCard()
    {
        return card;
    }
    public String getTelephone()
    {
        return telephone;
    }
    public String getMobile()
    {
        return mobile;
    }
    public String getAddress()
    {
        return address;
    }
    public Date getRegistratime()
    {
        return registratime;
    }
    public String getArchives()
    {
        return archives;
    }
    public Date getOuttime()
    {
        return outtime;
    }
    public String getSource()
    {
        return source;
    }
    public String getCommunity()
    {
        return community;
    }
    public Date getTimes()
    {
        return times;
    }
    public String getMember()
    {
        return member;
    }

	public boolean isExists()
	{
		return exists;
	}
	public String getDrivers()
	{
		return drivers;
	}

    
}
