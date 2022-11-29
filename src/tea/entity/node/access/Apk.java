package tea.entity.node.access;

import java.sql.SQLException;
import java.util.ArrayList;
import tea.db.DbAdapter;
import tea.entity.Entity;

public class Apk extends Entity
{
	private int id;
	private String community;
	private String name;
	private String path;
	private int count;
	private int downcount;
    
    public Apk(int id)
    {
        this.id = id;
    }
    
    /**
     * @param id
     * @return Apk
     * @throws SQLException
     */
    public static Apk find(int id) throws SQLException
    {
    	Apk t = (Apk) _cache.get(id);
        if(t == null)
        {
            ArrayList al = find(" AND id=" + id,0,1);
            t = al.size() < 1 ? new Apk(id) : (Apk) al.get(0);
        }
        return t;
    }
    
    /**
     * @param sql,pos,size
     * @return ArrayList
	 * @throws SQLException
	 * 查询下载apk者的信息
	 */
    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter(8);
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT a.id,a.community,a.name,a.path,a.count,a.downcount FROM Apk a WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Apk t = new Apk(rs.getInt(i++));
                t.setCommunity(rs.getString(i++));
                t.setName(rs.getString(i++));
                t.setPath(rs.getString(i++));
                t.setCount(rs.getInt(i++));
                t.setDowncount(rs.getInt(i++));
                _cache.put(t.getId(),t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }
    
    /**
     * @param sql
     * @return count
     * @throws SQLException
     */
    public static int count(String sql) throws SQLException
    {
    	int count=0;
    	DbAdapter db = new DbAdapter(8);
    	try
    	{
    		db.executeQuery("SELECT COUNT(*) FROM Apk a  WHERE 1=1" + sql);
    		if(db.next())
        		count=db.getInt(1);
    	}catch(Exception e)
		{
    		e.printStackTrace();
		}finally
		{
			db.close();
		}
        return count;
    }
    
    /**
	 * @entity Apk
	 * @param apkid
	 * @throws SQLException
	 */	
    public static void updateApkCount(int apkid) throws SQLException 
	{       
    	DbAdapter db = new DbAdapter(8);
        try
        {
            db.executeUpdate("UPDATE Apk SET count=count+1 WHERE id=" + apkid);
        } finally
        {
            db.close();
        }
 		 
	}
    
    /**
	 * @entity Apk
	 * @param apkid
	 * @throws SQLException
	 */	
    public static void updateApkDowncount(int apkid) throws SQLException 
	{       
    	DbAdapter db = new DbAdapter(8);
        try
        {
            db.executeUpdate("UPDATE Apk SET downcount=downcount+1 WHERE id=" + apkid);
        } finally
        {
            db.close();
        }
 		 
	}
    
    /**
	 * @param sql
	 * @return apkSumCount
	 * @throws SQLException
	 */
    public static int apkSumCount(String sql) throws SQLException
    {
    	int sum=0;
    	DbAdapter db = new DbAdapter(8);
    	try
    	{
    		db.executeQuery("SELECT sum(count) FROM Apk WHERE 1=1" + sql);
    		if(db.next())
    			sum=db.getInt(1);
    	}catch(Exception e)
		{
    		e.printStackTrace();
		}finally
		{
			db.close();
		}
        return sum;
    }
    
    /**
	 * @param sql
	 * @return apkSumDowncount
	 * @throws SQLException
	 */
    public static int apkSumDowncount(String sql) throws SQLException
    {
    	int sum=0;
    	DbAdapter db = new DbAdapter(8);
    	try
    	{
    		db.executeQuery("SELECT sum(downcount) FROM Apk WHERE 1=1" + sql);
    		if(db.next())
    			sum=db.getInt(1);
    	}catch(Exception e)
		{
    		e.printStackTrace();
		}finally
		{
			db.close();
		}
        return sum;
    }
    
    /**
	 * @entity Apk
	 * @param apkid
	 * @return apkCount
	 * @throws SQLException
	 */
    public static int apkCount(int apkid) throws SQLException
    {
    	int count=0;
    	DbAdapter db = new DbAdapter(8);
    	try
    	{
    		db.executeQuery("SELECT count FROM Apk WHERE id=" + apkid);
    		if(db.next())
        		count=db.getInt(1);
    	}catch(Exception e)
		{
    		e.printStackTrace();
		}finally
		{
			db.close();
		}
        return count;
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCommunity() {
		return community;
	}

	public void setCommunity(String community) {
		this.community = community;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getDowncount() {
		return downcount;
	}

	public void setDowncount(int downcount) {
		this.downcount = downcount;
	}
    
}
