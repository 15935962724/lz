package tea.entity.node;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Entity;
import tea.entity.Seq;

public class MeetingNotice extends Entity
{
    private static Cache _cache = new Cache(100);
    private int id;
    private int node;
    private String title;
    private String content;
    private Date time; //邀请时间
    private boolean exist;

    public MeetingNotice(int id) throws SQLException
    {
        this.id = id;
    }
    
    public void set() throws SQLException
    {
        String sql;
        if(id<1)
            sql = "INSERT INTO MeetingNotice(id,node,title,content,time) VALUES (" + (id = Seq.get()) + "," + node + "," + DbAdapter.cite(title) + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(time) + " )";
        else
            sql = "UPDATE MeetingNotice SET node=" + node + ",title=" + DbAdapter.cite(title) + ",content=" + DbAdapter.cite(content) + ",time=" + DbAdapter.cite(time) + " WHERE id=" + id;
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

    public static MeetingNotice find(int id) throws SQLException
    {
        ArrayList al = find(" AND id="+id,0,1);
        MeetingNotice obj  = al.size() < 1 ?  new MeetingNotice(id) : (MeetingNotice) al.get(0);
        return obj;
    }
    
    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM MeetingNotice mn "+tab(sql)+" WHERE 1=1" + sql);
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT mn.id,mn.node,mn.title,mn.content,mn.time FROM MeetingNotice mn "+tab(sql)+" WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                MeetingNotice t = new MeetingNotice(rs.getInt(i++));
                t.node = rs.getInt(i++);
                t.title = rs.getString(i++);
                t.content = db.getString(i++);
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
            sb.append(" INNER JOIN adminunit au ON mn.adminunitid=au.id");
        else if(sql.contains(" AND ym."))
            sb.append(" INNER JOIN Meeting ym on ym.node=mn.node");
        return sb.toString();
    }
    
    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM MeetingNotice WHERE id=" + id);
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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
