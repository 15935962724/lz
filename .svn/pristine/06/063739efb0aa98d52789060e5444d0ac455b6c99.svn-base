package tea.entity.yl.shop;

import java.sql.SQLException;
import java.util.ArrayList;
import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.MT;
import tea.entity.Seq;

public class ShopAttrib
{
    protected static Cache c = new Cache(50);
    public int attrib; //属性
    public int category; //分类
    public static String[] TYPE_NAME =
            {"文本框", "文本域", "复选框", "单选框", "下拉框"};
    public int type; //类型
    public boolean need; //必填
    public boolean query; //查询
    public String[] name = new String[2]; //名称
    public String[] content = new String[2]; //内容
    public int sequence;
    public ShopAttrib(int attrib)
    {
        this.attrib = attrib;
    }

    public static ShopAttrib find(int attrib) throws SQLException
    {
        ShopAttrib t = (ShopAttrib) c.get(attrib);
        if (t == null)
        {
            ArrayList al = find(" AND attrib=" + attrib, 0, 1);
            t = al.size() < 1 ? new ShopAttrib(attrib) : (ShopAttrib) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT attrib,category,type,need,query,name0,name1,content0,content1,sequence FROM shopattrib WHERE 1=1" + sql + " ORDER BY sequence", pos, size);
            while (rs.next())
            {
                int i = 1;
                ShopAttrib t = new ShopAttrib(rs.getInt(i++));
                t.category = rs.getInt(i++);
                t.type = rs.getInt(i++);
                t.need = rs.getBoolean(i++);
                t.query = rs.getBoolean(i++);
                t.name[0] = rs.getString(i++);
                t.name[1] = rs.getString(i++);
                t.content[0] = rs.getString(i++);
                t.content[1] = rs.getString(i++);
                t.sequence = rs.getInt(i++);
                c.put(t.attrib, t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM shopattrib WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if (attrib < 1)
            sql = "INSERT INTO shopattrib(attrib,category,type,need,query,name0,name1,content0,content1,sequence)VALUES(" + (attrib = Seq.get()) + "," + category + "," + type + "," + DbAdapter.cite(need) + "," + DbAdapter.cite(query) + "," + DbAdapter.cite(name[0]) + "," + DbAdapter.cite(name[1]) + "," + DbAdapter.cite(content[0]) + "," + DbAdapter.cite(content[1]) + "," + sequence + ")";
        else
            sql = "UPDATE shopattrib SET category=" + category + ",type=" + type + ",need=" + DbAdapter.cite(need) + ",query=" + DbAdapter.cite(query) + ",name0=" + DbAdapter.cite(name[0]) + ",name1=" + DbAdapter.cite(name[1]) + ",content0=" + DbAdapter.cite(content[0]) + ",content1=" + DbAdapter.cite(content[1]) + ",sequence=" + sequence + " WHERE attrib=" + attrib;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(attrib, sql);
        } finally
        {
            db.close();
        }
        c.remove(attrib);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(attrib, "DELETE FROM shopattrib WHERE attrib=" + attrib);
        } finally
        {
            db.close();
        }
        c.remove(attrib);
    }

    public void set(String f, String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(attrib, "UPDATE shopattrib SET " + f + "=" + DbAdapter.cite(v) + " WHERE attrib=" + attrib);
        } finally
        {
            db.close();
        }
        c.remove(attrib);
    }

    //
    public String getHtm(int lang, int product) throws SQLException
    {
        String v = product > 0 ? AValue.find(product, attrib).value[lang] : "";
        String[] tag =
                {"text", "textarea", "checkbox", "radio", "select"};
        StringBuilder sb = new StringBuilder();
        if (type == 0)
        {
            sb.append("<input name='a" + attrib + "'");
            if (need)
                sb.append(" alt='" + name[lang] + "'");
            sb.append(" value='" + MT.f(v) + "' size='50'>");
        } else if (type == 1)
        {
            sb.append("<textarea name='a" + attrib + "'");
            if (need)
                sb.append(" alt='" + name[lang] + "'");
            sb.append(" cols='50' rows='5'>" + MT.f(v) + "</textarea>");
        } else
        {
            String[] arr = content[lang].split("[|]");
            if (type == 4)
            {
                sb.append("<select name='a" + attrib + "'");
                if (need)
                    sb.append(" alt='" + name[lang] + "'");
                sb.append("><option value=''>------");
                for (int i = 1; i < arr.length; i++)
                {
                    sb.append("<option value=" + arr[i]);
                    if (arr[i].equals(v))
                        sb.append(" selected");
                    sb.append(">" + arr[i]);
                }
                sb.append("</select>");
            } else
            {
                for (int i = 1; i < arr.length; i++)
                {
                    sb.append("<input type='" + tag[type] + "' name='a" + attrib + "' value='" + arr[i] + "'");
                    if (arr[i].equals(v) || (type == 3 && i == 1))
                        sb.append(" checked");
                    sb.append(" id='_a" + attrib + "_" + i + "'><label for='_a" + attrib + "_" + i + "'>" + arr[i] + "</label> ");
                }
            }
        }
        return sb.toString();
    }
}
