package tea.entity.node;

import java.sql.SQLException;
import java.util.Enumeration;
import java.util.Vector;
import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.ui.member.profile.newcaller;


public class Translation {
	protected static Cache c = new Cache(50);
	public int id;
    public int fromNode;
    public int toNode;
    public Translation(){
 	   
     }
    public Translation(int node){
	   this.fromNode=node;
    }
    public static Translation load(int id){
    	Translation t=new Translation();
    	DbAdapter db =new DbAdapter();
        try {
			db.executeQuery("select * from Translation where id="+id);
			if(db.next()){
	        	t.id=db.getInt(1);
	        	t.fromNode=db.getInt(2);	
	        	t.toNode=db.getInt(3);	
	        }
        } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			db.close();
		}
        return t;
    }
    public static Translation find(int fromNode,int toNode)
    {
    	Translation t=new Translation();
        DbAdapter db =new DbAdapter();
        try {
			db.executeQuery("select * from Translation where fromnode="+fromNode+" and tonode="+toNode);
			if(db.next()){
	        	t.id=db.getInt(1);
	        	t.fromNode=db.getInt(2);	
	        	t.toNode=db.getInt(3);	
	        }
        } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			db.close();
		}
        return t;
    }
    public static Enumeration find(String sql,int pos,int size) throws SQLException{
    	Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM Translation WHERE 1=1 " + sql,pos,size);
            while(db.next())
            {
                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }
    public static Enumeration findtoNode(int toNode) throws SQLException{
    	Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT fromnode FROM Translation WHERE tonode= " + toNode,0,Integer.MAX_VALUE);
            while(db.next())
            {
                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }
    public static Translation find(int id){
    	Translation obj = (Translation) c.get(id);
        if(obj == null)
        {
            obj = load(id);
        }
        return obj;
    }
    public static int create(int fromNode,int toNode){
    	/*Translation translation=find(fromNode, toNode);
    	if (translation.id<1) {
			return 0;
		}*/
    	DbAdapter db =new DbAdapter();
        try {
			db.executeUpdate("insert into Translation(fromnode,tonode) values("+fromNode+","+toNode+")");
			
        } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			db.close();
		}
        return toNode;
    }
    public static String inTranslation(int node){
    	StringBuffer sql=new StringBuffer("");
    	try {
    		int count= count(" and tonode="+node);
			
			if(count>0){
				Enumeration e= findtoNode(node);
				sql.append(" or (n.hidden=0 AND n.finished=1 and n.node in(");
				for (int i=0;e.hasMoreElements();i++) {
					
					
					int fromnode = (Integer) e.nextElement();
					
					String string=(i==0?"":",")+fromnode;
					sql.append(string);
				}
				sql.append("))");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return sql.toString();
    }
    
    public static void del(int id){
    	DbAdapter db =new DbAdapter();
        try {
			db.executeQuery("delete from Translation where id="+id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			db.close();
		}
    }
    

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(0) FROM Translation WHERE 1=1" + sql);
    }
    
    
}
