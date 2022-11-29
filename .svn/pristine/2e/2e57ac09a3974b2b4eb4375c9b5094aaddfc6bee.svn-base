package tea.entity.yl.shop;

import java.sql.SQLException;
import java.util.ArrayList;

import tea.entity.Cache;
import tea.entity.DbAdapter;
import tea.entity.Seq;

public class Showimg {

	protected static Cache c = new Cache(50);
	public int sid;
	public int imgid;//attchid 图片id
	public String shref;//链接路径
	public int seq;//顺序

	 public Showimg(int sid)
	    {
	        this.sid = sid;
	    }

	 public static Showimg find(int sid) throws SQLException
	    {
		 Showimg t = (Showimg) c.get(sid);
	        if (t == null)
	        {
	            ArrayList al = find(" AND sid=" + sid, 0, 1);
	            t = al.size() < 1 ? new Showimg(sid) : (Showimg) al.get(0);
	        }
	        return t;
	    }

	 public static ArrayList find(String sql, int pos, int size) throws SQLException
	    {
	        ArrayList al = new ArrayList();
	        DbAdapter db = new DbAdapter();
	        try
	        {
	            java.sql.ResultSet rs = db.executeQuery("select id,imgid,shref,seq from showimg WHERE 1=1 " + sql, pos, size);
	            while (rs.next())
	            {
	                int i = 1;
	                Showimg t = new Showimg(rs.getInt(i++));
	                t.imgid = rs.getInt(i++);
	                t.shref = rs.getString(i++);
	                t.seq = rs.getInt(i++);
	                c.put(t.sid, t);
	                al.add(t);
	            }
	            rs.close();
	        } finally
	        {
	            db.close();
	        }
	        return al;
	    }

	 public void set() throws SQLException
	    {
	        String sql;
	        if (sid < 1)
	        {
	        	sql = " INSERT INTO [showimg]([id],[imgid],[shref],[seq]) values (" + (sid = Seq.get()) + ","+imgid+","+DbAdapter.cite(shref)+","+seq+")";
	        }
	        else
	            sql = "UPDATE [showimg] SET [imgid] = "+imgid+",[shref] = "+DbAdapter.cite(shref)+",[seq] = "+seq+" where sid = "+sid;

	        DbAdapter db = new DbAdapter();
	        try
	        {
	            db.executeUpdate(sid, sql);
	        } finally
	        {
	            db.close();
	        }
	        c.remove(sid);
	    }

	 public void set(String f, String v) throws SQLException
	    {
                DbAdapter db = new DbAdapter();
                try
                {
                    db.executeUpdate(sid, "UPDATE showimg SET " + f + "=" + DbAdapter.cite(v) + " WHERE id=" + sid);
                } finally
                {
                    db.close();
                }
	        c.remove(sid);
	    }

	 public static int count(String sql) throws SQLException
	    {
	        return DbAdapter.execute("SELECT COUNT(*) FROM [showimg] WHERE 1=1" + sql);
	    }

	 public void delete() throws SQLException
	    {
                DbAdapter db = new DbAdapter();
                try
                {
                    db.executeUpdate(sid, "DELETE FROM showimg WHERE id=" + sid);
                } finally
                {
                    db.close();
                }
	        c.remove(sid);
	    }

}
