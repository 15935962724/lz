package tea.entity.node.access;

import java.sql.SQLException;
import java.util.ArrayList;
import tea.db.DbAdapter;
import tea.entity.Entity;

public class NodeAccessApkCity extends Entity
{
	private int id;
	private String community;
	private int sum;
	private int downsum;
	private String address;
	
	public NodeAccessApkCity()
    {
    }
    
    public NodeAccessApkCity(int id)
    {
        this.id = id;
    }
    
    /**
     * @entity NodeAccessApkCity
     * @param id
     * @return NodeAccessApkCity
     * @throws SQLException
     */
    public static NodeAccessApkCity find(int id) throws SQLException
    {
    	NodeAccessApkCity t = (NodeAccessApkCity) _cache.get(id);
        if(t == null)
        {
            ArrayList al = find(" AND id=" + id,0,1);
            t = al.size() < 1 ? new NodeAccessApkCity(id) : (NodeAccessApkCity) al.get(0);
        }
        return t;
    }
    
    /**
	 * @entity NodeAccessApkCity
	 * @throws SQLException
	 * 查询下载apk者的信息
	 */
    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter(8);
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT nac.id,nac.community,nac.sum,nac.downsum,nac.address FROM NodeAccessApkCity nac WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                NodeAccessApkCity t = new NodeAccessApkCity(rs.getInt(i++));
                t.setCommunity(rs.getString(i++));
                t.setSum(rs.getInt(i++));
                t.setDownsum(rs.getInt(i++));
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
     * @entity NodeAccessApkCity
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
    		db.executeQuery("SELECT COUNT(*) FROM NodeAccessApkCity naa  WHERE 1=1" + sql);
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
     * @entity NodeAccessApkCity
     * @param sql
     * @return sum  --所有地区访问量总和
     * @throws SQLException
     */
    public static int sum(String sql) throws SQLException
    {
    	int sum=0;
    	DbAdapter db = new DbAdapter(8);
    	try
    	{
    		db.executeQuery("SELECT sum(sum) FROM NodeAccessApkCity WHERE 1=1" + sql);
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
     * @entity NodeAccessApkCity
     * @param sql
     * @return downsum  --所有地区下载量总和
     * @throws SQLException
     */
    public static int downsum(String sql) throws SQLException
    {
    	int sum=0;
    	DbAdapter db = new DbAdapter(8);
    	try
    	{
    		db.executeQuery("SELECT sum(downsum) FROM NodeAccessApkCity WHERE 1=1" + sql);
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
	 * @entity NodeAccessApkCity
	 * @throws SQLException
	 * 插入或修改下载apk者地区的sum
	 */
    public void set(String community,String address) throws SQLException
    {
        DbAdapter db = new DbAdapter(8);
        int count=0;
        db.executeQuery("SELECT count(*) FROM NodeAccessApkCity nac  WHERE community="+DbAdapter.cite(community)+" AND address="+DbAdapter.cite(address));
		if(db.next())
			count=db.getInt(1);
		String sql;
        if(count < 1)
            sql = "INSERT INTO NodeAccessApkCity(community,sum,address)VALUES(" + DbAdapter.cite(community) + ",1," + DbAdapter.cite(address) + ")";
        else
            sql = "UPDATE NodeAccessApkCity SET sum=sum+1 WHERE community="+DbAdapter.cite(community)+" AND address="+DbAdapter.cite(address);
        try
        {
            db.executeUpdate(sql);
        } finally
        {
            db.close();
        }
    }
    
    /**
	 * @entity NodeAccessApkCity
	 * @throws SQLException
	 * 插入或修改下载apk者地区的downsum
	 */
    public void updateDownSum(String community,String address) throws SQLException
    {
        DbAdapter db = new DbAdapter(8);
		String sql = "UPDATE NodeAccessApkCity SET downsum=downsum+1 WHERE community="+DbAdapter.cite(community)+" AND address="+DbAdapter.cite(address);
        try
        {
            db.executeUpdate(sql);
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

	public int getSum() {
		return sum;
	}

	public void setSum(int sum) {
		this.sum = sum;
	}

	public int getDownsum() {
		return downsum;
	}

	public void setDownsum(int downsum) {
		this.downsum = downsum;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}    

}
