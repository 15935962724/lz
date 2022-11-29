package tea.entity.node;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import tea.db.DbAdapter;



public class Goodscon {
	
	
	private int goodsconid;
	private int node;
	private String sessionid;
	private boolean exists ;
	
	
	
	public static Goodscon find(int node,String sessionid) throws SQLException
    {
        
        return new Goodscon(node,sessionid);
    }

    public Goodscon(int node,String sessionid) throws SQLException
    {
        this.node = node;
        this.sessionid = sessionid;
        load();
    }
    
    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT goodsconid FROM Goodscon WHERE node=" + node+" and sessionid = "+db.cite(sessionid));
            if(db.next())
            {
            	goodsconid = db.getInt(1);
            	exists=true;
            }else
            {
            	exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    
    public static void add(int node,String sessionid)throws SQLException
    {
    	DbAdapter db = new DbAdapter();
    	try
    	{
    		db.executeUpdate("insert into Goodscon(node,sessionid)values("+node+","+db.cite(sessionid)+")");
    	}finally
    	{
    		db.close();
    	}
    }
    public static void delete (int node ,String sessionid)throws SQLException
    {
    	DbAdapter db = new DbAdapter();
    	try
    	{
    		db.executeUpdate("delete from  Goodscon where node = "+node+" and sessionid = "+db.cite(sessionid));
    	}finally
    	{
    		db.close();
    	}
    }
    
    public static List getList(String sessionid)throws SQLException
    {
    	List list = new ArrayList();
    	DbAdapter db = new DbAdapter();
    	try
    	{
    		db.executeQuery("select node from  Goodscon where sessionid = "+db.cite(sessionid));
    		while(db.next())
    		{
    			list.add(db.getInt(1));
    		}
    	}finally
    	{
    		db.close();
    	}
    	return list;
    }
    
    
    public int getNode()
    {
    	return node;
    }
    public String getSessionid()
    {
    	return sessionid;
    }
    public boolean isExists()
    {
    	return exists;
    }
    
    
}
