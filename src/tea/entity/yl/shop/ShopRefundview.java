package tea.entity.yl.shop;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.DbAdapter;
import tea.entity.Seq;

/**
 * 退货记录
 * @author Administrator
 *
 */
public class Refundview {
	protected static Cache c = new Cache(50);
	public int rid;
	public String rcont;//内容
	public Date rdate;//发生时间
	public int trade;//1显示
	public int tstate;//流程状态
	public static String[] TSTATE_TYPE = {"默认", "等待审核", "通过审核", "未通过审核", "已退款"};
	public int member;

	public Refundview(int rid)
    {
        this.rid = rid;
    }

    public static Refundview find(int rid) throws SQLException
    {
    	Refundview t = (Refundview) c.get(rid);
        if (t == null)
        {
            ArrayList al = find(" AND rid=" + rid, 0, 1);
            t = al.size() < 1 ? new Refundview(rid) : (Refundview) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("select [rid],[rcont],[rdate],[trade],tstate,member from Refundview where 1=1 " + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                Refundview t = new Refundview(rs.getInt(i++));
                t.rcont = rs.getString(i++);
                t.rdate = db.getDate(i++);
                t.trade = rs.getInt(i++);
                t.tstate = rs.getInt(i++);
                t.member = rs.getInt(i++);
                c.put(t.rid, t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM Refundview  WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if (rid < 1){
        	int seq = Seq.get();
        	rid = seq;
        	sql = "INSERT INTO Refundview([rid],[rcont],[rdate],[trade],tstate,member) values("+seq+","+DbAdapter.cite(rcont)+","+DbAdapter.cite(rdate)+","+trade+","+tstate+","+member+")";
        }
        else
            sql = "UPDATE Refundview SET [rcont] = "+DbAdapter.cite(rcont)+",[rdate] = "+DbAdapter.cite(rdate)+",[trade] = "+trade+",tstate="+tstate+",member="+member+" WHERE rid=" + rid;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(rid, sql);
        } finally
        {
            db.close();
        }
        c.remove(rid);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(rid, "DELETE FROM refundview WHERE rid=" + rid);
        } finally
        {
            db.close();
        }
        c.remove(rid);
    }

    public void set(String f, String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(rid, "UPDATE refundview SET " + f + "=" + DbAdapter.cite(v) + " WHERE rid=" + rid);
        } finally
        {
            db.close();
        }
        c.remove(rid);
    }

}
