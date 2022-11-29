package tea.entity.node;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Entity;
import tea.entity.Seq;

public class MeetingInvite extends Entity
{
    private static Cache _cache = new Cache(100);
    private int id;
    private int node;
    private int adminunitid;
    private int state;
    private String remark;
    private Date time; //邀请时间
    private boolean exist;

    public MeetingInvite(int id) throws SQLException
    {
        this.id = id;
    }
    
    public MeetingInvite(int node,int adminunitid) throws SQLException
    {
        this.node = node;
        this.adminunitid = adminunitid;
    }

    public void set() throws SQLException
    {
        String sql;
        if(id<1)
            sql = "INSERT INTO MeetingInvite(id,node,adminunitid,state,remark,time) VALUES (" + (id = Seq.get()) + "," + node + "," + adminunitid + "," + state + "," + DbAdapter.cite(remark) + "," + DbAdapter.cite(time) + " )";
        else
            sql = "UPDATE MeetingInvite SET node=" + node + ",adminunitid=" + adminunitid + ",state=" + state + ",remark=" + DbAdapter.cite(remark) + ",time=" + DbAdapter.cite(time) + " WHERE id=" + id;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id,sql);
        } finally
        {
            db.close();
        }
        _cache.remove(id);
    }

    public static MeetingInvite find(int id) throws SQLException
    {
        ArrayList al = find(" AND id="+id,0,1);
        MeetingInvite obj  = al.size() < 1 ?  new MeetingInvite(id) : (MeetingInvite) al.get(0);
        return obj;
    }
    
    public static MeetingInvite find(int node,int adminunitid) throws SQLException
    {
        ArrayList al = find(" AND node="+node+" AND adminunitid="+adminunitid,0,1);
        MeetingInvite obj  = al.size() < 1 ?  new MeetingInvite(node,adminunitid) : (MeetingInvite) al.get(0);
        return obj;
    }
    
    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM MeetingInvite ymi "+tab(sql)+" WHERE 1=1" + sql);
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT ymi.id,ymi.node,ymi.adminunitid,ymi.state,ymi.remark,ymi.time FROM MeetingInvite ymi "+tab(sql)+" WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                MeetingInvite t = new MeetingInvite(rs.getInt(i++));
                t.node = rs.getInt(i++);
                t.adminunitid = rs.getInt(i++);
                t.state = rs.getInt(i++);
                t.remark = db.getString(i++);
                t.time = db.getDate(i++);                
                t.exist = true;
                _cache.put(t.id,t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }
    
    private static String tab(String sql){
    	StringBuilder sb = new StringBuilder();
        if(sql.contains(" AND au."))
            sb.append(" INNER JOIN adminunit au ON ymi.adminunitid=au.id");
        else if(sql.contains(" AND ym."))
            sb.append(" INNER JOIN Meeting ym on ym.node=ymi.node");
        return sb.toString();
    }
    
    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM MeetingInvite WHERE id=" + id);
        }

        finally
        {
            db.close();
        }
        _cache.remove(id);
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getNode() {
		return node;
	}

	public void setNode(int node) {
		this.node = node;
	}

	public int getAdminunitid() {
		return adminunitid;
	}

	public void setAdminunitid(int adminunitid) {
		this.adminunitid = adminunitid;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public boolean isExist() {
		return exist;
	}

	public void setExist(boolean exist) {
		this.exist = exist;
	}

}
