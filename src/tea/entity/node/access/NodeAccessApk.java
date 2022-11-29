package tea.entity.node.access;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import tea.db.DbAdapter;
import tea.entity.Entity;

public class NodeAccessApk extends Entity
{
	private int id;
	private String community;
	private int apkid;
	private String ip;
	private Date time;
	private String address;
	
	public NodeAccessApk()
    {
    }
    
    public NodeAccessApk(int id)
    {
        this.id = id;
    }
    
    /**
     * @entity NodeAccessApk
     * @param id
     * @return NodeAccessApk
     * @throws SQLException
     */
    public static NodeAccessApk find(int id) throws SQLException
    {
    	NodeAccessApk t = (NodeAccessApk) _cache.get(id);
        if(t == null)
        {
            ArrayList al = find(" AND id=" + id,0,1);
            t = al.size() < 1 ? new NodeAccessApk(id) : (NodeAccessApk) al.get(0);
        }
        return t;
    }
    
    /**
	 * @entity NodeAccessApk
	 * @throws SQLException
	 * 查询下载apk者的信息
	 */
    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter(8);
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT naa.id,naa.community,naa.apkid,naa.ip,naa.time,naa.address FROM NodeAccessApk naa WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                NodeAccessApk t = new NodeAccessApk(rs.getInt(i++));
                t.setCommunity(rs.getString(i++));
                t.setApkid(rs.getInt(i++));
                t.setIp(rs.getString(i++));
                t.setTime(db.getDate(i++));
                t.setAddress(rs.getString(i++));
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
     * @entity NodeAccessApk
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
    		db.executeQuery("SELECT COUNT(*) FROM NodeAccessApk naa  WHERE 1=1" + sql);
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
	 * @entity NodeAccessApk
	 * @throws SQLException
	 * 插入下载apk者的信息
	 */
    public void set() throws SQLException
    {
    	Date time = new Date();
        DbAdapter db = new DbAdapter(8);
        try
        {
            db.executeUpdate("INSERT INTO NodeAccessApk(community,apkid,ip,time,address)VALUES(" + DbAdapter.cite(community) + "," + apkid + "," + DbAdapter.cite(ip) + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(address) + ")");
        } finally
        {
            db.close();
        }
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

	public int getApkid() {
		return apkid;
	}

	public void setApkid(int apkid) {
		this.apkid = apkid;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

}
