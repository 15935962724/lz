package tea.entity.taoism;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.ui.member.profile.newcaller;

/**
 * 
 * @author:
 * @开发时间:2014-5-27
 * @描述:皈依弟子信息年检情况表
 */
public class Situation {
	private static Cache c = new Cache(50);
	public int id;
    /**皈依弟子关联Id*/
    public int situationId;
    /**皈依证颁发时间*/
    public Date ctime;
    /**年检情况*/
    public String situation;
    public Situation(int id)
    {
        this.id = id;
    }

    public static Situation find(int id) throws SQLException
    {
   	 Situation t = (Situation) c.get(id);
        if(t == null)
        {
            ArrayList al = find(" AND id=" + id,0,1);
            t = al.size() < 1 ? new Situation(id) : (Situation) al.get(0);
        }
        return t;
    }
    public static Situation findbytid(int id) throws SQLException
    {
    	ArrayList list= find(" and situationId="+id+" order by id desc", 0, 1);
    	return list.size()>0?(Situation)list.get(0):new Situation(0);
    }
    private static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if(sql.contains(" AND n."))
            sb.append(" INNER JOIN id n ON n.id=tc.id");

        return sb.toString();
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT id,situationId,ctime,situation FROM Situation t  WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Situation t = new Situation(rs.getInt(i++));
                t.situationId = rs.getInt(i++);
                t.ctime=rs.getDate(i++);
                t.situation = rs.getString(i++);
                c.put(t.id,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM Situation t WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("INSERT INTO Situation(id,situationId,ctime,situation)" +
            		"VALUES(" + id + ","+situationId+"," + DbAdapter.cite(ctime) + "," + DbAdapter.cite(situation)+")");
            if(j < 1)
                db.executeUpdate("UPDATE Situation SET situationId ="+situationId+",ctime=" + DbAdapter.cite(ctime) + ",situation=" + DbAdapter.cite(situation) + " WHERE id=" + id);
        } finally
        {
        	c.remove(id);
            db.close();
        }

    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("delete from Situation  WHERE id=" + id);
        c.remove(id);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE Situation SET " + f + "=" + DbAdapter.cite(v) + " WHERE id=" + id);
        c.remove(id);
    }
}
