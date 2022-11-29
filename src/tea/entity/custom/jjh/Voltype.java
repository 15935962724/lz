package tea.entity.custom.jjh;

import java.sql.*;
import java.util.*;

import tea.db.DbAdapter;
import tea.entity.Cache;

public class Voltype {
	protected static Cache c=new Cache(50);
	private int vtid;
	private String vtname;
	
	public Voltype(int vtid){
		this.vtid=vtid;
	}
	
	public Voltype(int vtid,String vtname){
		this.vtid=vtid;
		this.vtname=vtname;
	}
	
	public static Voltype findVoltype(int vtid){
		Voltype v=(Voltype) c.get(vtid);
		if(v==null){
			List list=findVoltypes(" AND vtid="+vtid,0,Integer.MAX_VALUE);
			if(list.size()>0){
				v=(Voltype) list.get(0);
			}else{
				v=new Voltype(vtid);
			}
		}
		return v;
	}
	
	public static int countVoltype(String sql) throws SQLException{
		return DbAdapter.execute("SELECT COUNT(*) FROM vtype WHERE 1=1 "+sql);
	}
	
	public void delVtype() throws SQLException{
		try {
			DbAdapter.execute("DELETE FROM vtype WHERE vtid="+getVtid());
		} finally{
			c.remove(getVtid());
		}
		
	}
	public void setVtype() throws SQLException{
		DbAdapter db=new DbAdapter();
			try {
				if(getVtid()<1){
					db.executeUpdate("INSERT INTO vtype(vtname) VALUES("+db.cite(getVtname())+");");
				}else{
					db.executeUpdate("UPDATE vtype SET vtname="+db.cite(getVtname())+" WHERE vtid="+getVtid());
				}
			} finally{
				db.close();
				c.remove(getVtid());
			}
		
	}
	
	public static List findVoltypes(String sql,int page,int size)
    {
        DbAdapter db = new DbAdapter();
        List list=new ArrayList();
        try
        {
            ResultSet rs=db.executeQuery("SELECT vtid,vtname FROM vtype WHERE 1=1 " + sql,page,size);
            while(rs.next())
            {
            	int i=1;
                int vtid=rs.getInt(i++);
                String vtname=rs.getString(i++);
                Voltype v=new Voltype(vtid,vtname);
                list.add(v);
                c.put(vtid,v);
            }
            rs.close();
        } catch(Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            db.close();
        }
        return list;
    }

	

	public int getVtid() {
		return vtid;
	}
	public void setVtid(int vtid) {
		this.vtid = vtid;
	}
	public String getVtname() {
		return vtname;
	}
	public void setVtname(String vtname) {
		this.vtname = vtname;
	}
}
