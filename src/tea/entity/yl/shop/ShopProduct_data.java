package tea.entity.yl.shop;

import java.sql.SQLException;
import java.util.ArrayList;
import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;

//商品价格
public class ShopProduct_data
{
    protected static Cache c = new Cache(50);
    public int id;
    public int product_id; //商品id
    public int sort;       //顺序
    public int logo;//详情logo
    public String title;   //标题
    public String brief;   //详情摘要
    public String content; //详情详细
    public int type;       //0,文章1,列表
    public int category; //类别id
    public int showtype;//分类显示类别  0在类里 1在产品
    public int hidden;
    
    public ShopProduct_data(int id)
    {
        this.id = id;
    }

    public static ShopProduct_data find(int id) throws SQLException
    {
        ShopProduct_data t = (ShopProduct_data) c.get(id);
        if (t == null)
        {
            ArrayList al = find(" AND id=" + id, 0, 1);
            t = al.size() < 1 ? new ShopProduct_data(id) : (ShopProduct_data) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT id,product_id,sort,logo,title,brief,content,type,category,showtype,hidden FROM shopProduct_data WHERE 1=1" + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                ShopProduct_data t = new ShopProduct_data(rs.getInt(i++));
                t.product_id = rs.getInt(i++);
                t.sort = rs.getInt(i++);
                t.logo = rs.getInt(i++);
                t.title = rs.getString(i++);
                t.brief = db.getString(i++);
                t.content = db.getString(i++);
                t.type = rs.getInt(i++);
                t.category = rs.getInt(i++);
                t.showtype = rs.getInt(i++);
                t.hidden = rs.getInt(i++);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM shopProduct_data WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if (id < 1)
            sql = "INSERT INTO shopProduct_data(id,product_id,sort,logo,title,brief,content,type,category,showtype,hidden)VALUES(" + (id = Seq.get()) + ","+product_id + ","+sort+ ","+logo +","+DbAdapter.cite(title) +","+DbAdapter.cite(brief) +","+DbAdapter.cite(content)+ ","+type + ","+category+","+showtype+","+hidden+")";
        else
            sql = "UPDATE shopProduct_data SET product_id="+product_id + ",sort="+sort+ ",logo="+logo + ",title="+DbAdapter.cite(title) + ",brief="+DbAdapter.cite(brief) + ",content="+DbAdapter.cite(content)+ ",type="+type + ",category="+category+",showtype="+showtype+",hidden="+hidden+" WHERE id=" + id;
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
            db.executeUpdate(id, "DELETE FROM shopProduct_data WHERE id=" + id);
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
            db.executeUpdate(id, "UPDATE shopProduct_data SET " + f + "=" + DbAdapter.cite(v) + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
        c.remove(id);
    }

    
}
