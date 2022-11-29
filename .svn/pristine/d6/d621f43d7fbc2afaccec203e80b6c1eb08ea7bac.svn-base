package tea.entity.yl.shop;

import java.sql.SQLException;
import java.util.ArrayList;
import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;


public class ShopProduct_data_cate
{
    protected static Cache c = new Cache(50);
    public int id;
    public int cate_id; //详情id
    public int sort;       //顺序
    public int attch;//详情附件
    public String title;   //标题
    public String brief;   //摘要
    public String content; //详细
    
    public ShopProduct_data_cate(int id)
    {
        this.id = id;
    }

    public static ShopProduct_data_cate find(int id) throws SQLException
    {
        ShopProduct_data_cate t = (ShopProduct_data_cate) c.get(id);
        if (t == null)
        {
            ArrayList al = find(" AND id=" + id, 0, 1);
            t = al.size() < 1 ? new ShopProduct_data_cate(id) : (ShopProduct_data_cate) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT id,cate_id,sort,attch,title,brief,content FROM ShopProduct_data_cate WHERE 1=1" + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                ShopProduct_data_cate t = new ShopProduct_data_cate(rs.getInt(i++));
                t.cate_id = rs.getInt(i++);
                t.sort = rs.getInt(i++);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM ShopProduct_data_cate WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if (id < 1)
            sql = "INSERT INTO ShopProduct_data_cate(id,cate_id,sort,attch,title,brief,content)VALUES(" + (id = Seq.get()) + ","+cate_id + ","+sort+ ","+attch +","+DbAdapter.cite(title) +","+DbAdapter.cite(brief) +","+DbAdapter.cite(content) + ")";
        else
            sql = "UPDATE ShopProduct_data_cate SET cate_id="+cate_id + ",sort="+sort+ ",attch="+attch + ",title="+DbAdapter.cite(title) + ",brief="+DbAdapter.cite(brief) + ",content="+DbAdapter.cite(content) + " WHERE id=" + id;
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
            db.executeUpdate(id, "DELETE FROM ShopProduct_data_cate WHERE id=" + id);
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
            db.executeUpdate(id, "UPDATE ShopProduct_data_cate SET " + f + "=" + DbAdapter.cite(v) + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
        c.remove(id);
    }

    
}
