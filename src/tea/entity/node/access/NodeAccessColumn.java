package tea.entity.node.access;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;

import tea.db.DbAdapter;
import tea.entity.Entity;
import tea.entity.Seq;
import tea.db.ConnectionPool;

public class NodeAccessColumn extends Entity
{
	public int columnid; //栏目节点表
    public int node; //节点id
    public String name; //栏目名称
    public String source; //来源
    public String community; //社区
    public Date time;

    public int nodeclick; //栏目节点总点击量

    public NodeAccessColumn(int columnid)
    {
        this.columnid = columnid;
    }

    public static NodeAccessColumn find(int columnid) throws SQLException
    {
        NodeAccessColumn t = (NodeAccessColumn) _cache.get(columnid);
        if(t == null)
        {
            ArrayList al = find(" AND columnid=" + columnid,0,1);
            t = al.size() < 1 ? new NodeAccessColumn(columnid) : (NodeAccessColumn) al.get(0);
        }
        return t;
    }

    public static NodeAccessColumn findByNode(int node,String community) throws SQLException
    {
        ArrayList al = find(" AND node=" + node + " AND community=" + DbAdapter.cite(community),0,1);
        NodeAccessColumn t = al.size() < 1 ? null : (NodeAccessColumn) al.get(0);
        return t;
    }

    public static NodeAccessColumn findBySource(String source,String community) throws SQLException
    {
        ArrayList al = find(" AND source=" + DbAdapter.cite(source) + " AND community=" + DbAdapter.cite(community),0,1);
        NodeAccessColumn t = al.size() < 1 ? null : (NodeAccessColumn) al.get(0);
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter(8);
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT nac.columnid,nac.node,nac.nodeclick,nac.name,nac.source,nac.community,nac.time FROM NodeAccessColumn nac WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                NodeAccessColumn t = new NodeAccessColumn(rs.getInt(i++));
                t.node = rs.getInt(i++);
                t.nodeclick = rs.getInt(i++);
                t.name = rs.getString(i++);
                t.source = rs.getString(i++);
                t.community = rs.getString(i++);
                t.time = db.getDate(i++);
                //_cache.put(t.columnid,t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }

    public static int count(String sql) throws SQLException
    {
    	int count=0;
    	DbAdapter db = new DbAdapter(8);
    	try
    	{
    		db.executeQuery("SELECT COUNT(*) FROM NodeAccessColumn nac  WHERE 1=1" + sql);
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

    public void set() throws SQLException
    {
    	Date time = new Date();
        DbAdapter db = new DbAdapter(8);
        try
        {
        	//if(columnid < 1)
        	//	columnid = Seq.get();
        	//ArrayList checkList = find(" AND columnid="+columnid,0,1);
            //if(checkList.size()<1)
        	if(columnid < 1)
                db.executeUpdate("INSERT INTO NodeAccessColumn(columnid,node,name,source,community,time)VALUES(" + (columnid = Seq.get()) + "," + node + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(source) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(time) + ")");
            else
                db.executeUpdate("UPDATE NodeAccessColumn SET node=" + node + ",name=" + DbAdapter.cite(name) + ",source=" + DbAdapter.cite(source) + ",community=" + DbAdapter.cite(community) + ",time=" + DbAdapter.cite(time) + " WHERE columnid=" + columnid);
        } finally
        {
            db.close();
        }
        //_cache.remove(columnid);
    }

    public void delete() throws SQLException
    {
    	DbAdapter db = new DbAdapter(8);
        try
        {
            db.executeUpdate("DELETE FROM NodeAccessColumn WHERE columnid=" + columnid);
        } finally
        {
            db.close();
        }
        //_cache.remove(columnid);
    }

    public void set(String f,String v) throws SQLException
    {
    	DbAdapter db = new DbAdapter(8);
        try
        {
            db.executeUpdate("UPDATE NodeAccessColumn SET " + f + "=" + DbAdapter.cite(v) + " WHERE columnid=" + columnid);
        } finally
        {
            db.close();
        }
        //_cache.remove(columnid);
    }

    //查询栏目节点表总点击量
    public static int countByNode(String community) throws SQLException
    {
    	int count=0;
    	DbAdapter db = new DbAdapter(8);
    	try
    	{
    		db.executeQuery("SELECT sum(nac.nodeclick) FROM NodeAccessColumn nac  WHERE 1=1 AND nac.community=" + DbAdapter.cite(community));
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

    //更新栏目节点表各个栏目节点的总点击量
    public static void updateByNode(String sql) throws SQLException
    {
    	//获取信息库库名
//    	Properties cache = new Properties();
//		try {
//			cache.load(NodeAccessColumn.class.getClassLoader().getResourceAsStream("db.properties"));
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		String url = ConnectionPool._strUrl[0];//cache.getProperty("0Url");
		String databaseName = url.substring(url.indexOf("=")+1);

    	DbAdapter db = new DbAdapter(8);
        try
        {
            db.executeUpdate("update NodeAccessColumn set nodeclick=(select sum(n.click) from "+databaseName+".dbo.node n WHERE n.path like '%/'+cast(NodeAccessColumn.node as varchar)+'/%' AND n.hidden=0 AND n.finished=1) WHERE 1=1 "+sql);
        } finally
        {
            db.close();
        }
    }

    //
    public String toString()
    {
        StringBuilder sb = new StringBuilder();
        sb.append("{columnid:" + columnid);
        sb.append(",node:" + node);
        sb.append("}");
        return sb.toString();
    }

}
