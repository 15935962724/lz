package tea.entity.yl.shop;

import java.sql.SQLException;
import java.util.ArrayList;
import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;


public class ShopProduct_data_list
{
    protected static Cache c = new Cache(50);
    public int id;
    public int data_id; //详情id
    public int sort;       //顺序
    public int logo;//详情
    public int attch;//详情附件
    public String title;   //标题
    public String brief;   //摘要
    public String content; //详细
    
    public ShopProduct_data_list(int id)
    {
        this.id = id;
    }

    public static ShopProduct_data_list find(int id) throws SQLException
    {
        ShopProduct_data_list t = (ShopProduct_data_list) c.get(id);
        if (t == null)
        {
            ArrayList al = find(" AND id=" + id, 0, 1);
            t = al.size() < 1 ? new ShopProduct_data_list(id) : (ShopProduct_data_list) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT id,data_id,sort,logo,attch,title,brief,content FROM ShopProduct_data_list WHERE 1=1" + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                ShopProduct_data_list t = new ShopProduct_data_list(rs.getInt(i++));
                t.data_id = rs.getInt(i++);
                t.sort = rs.getInt(i++);
                t.logo = rs.getInt(i++);
                t.attch = rs.getInt(i++);
                t.title = rs.getString(i++);
                t.brief = rs.getString(i++);
                t.content = rs.getString(i++);
                c.put(t.id, t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM ShopProduct_data_list WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if (id < 1)
            sql = "INSERT INTO ShopProduct_data_list(id,data_id,sort,logo,attch,title,brief,content)VALUES(" + (id = Seq.get()) + ","+data_id + ","+sort +","+logo+ ","+attch +","+DbAdapter.cite(title) +","+DbAdapter.cite(brief) +","+DbAdapter.cite(content) + ")";
        else
            sql = "UPDATE ShopProduct_data_list SET data_id="+data_id + ",sort="+sort +",logo="+logo + ",attch="+attch + ",title="+DbAdapter.cite(title) + ",brief="+DbAdapter.cite(brief) + ",content="+DbAdapter.cite(content) + " WHERE id=" + id;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id, sql);
        } finally
        {
            db.close();
        }
        c.remove(id);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id, "DELETE FROM ShopProduct_data_list WHERE id=" + id);
        } finally
        {
            db.close();
        }
        c.remove(id);
    }

    public void set(String f, String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id, "UPDATE ShopProduct_data_list SET " + f + "=" + DbAdapter.cite(v) + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
        c.remove(id);
    }

    
}
