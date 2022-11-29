package tea.entity.locoso;

import java.sql.*;

import tea.db.*;

public class Category
{
    String id;
    String html;
    boolean exists;
    private Category(String id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static Category find(String id) throws SQLException
    {
        return new Category(id);
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter(Locoso.ON);
        try
        {
            db.executeQuery("SELECT html FROM category WHERE id=" + db.cite(id));
            if (db.next())
            {
                html = db.getText(1);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(String id, String html) throws SQLException
    {
        DbAdapter db = new DbAdapter(Locoso.ON);
        try
        {
            db.executeUpdate("INSERT INTO category(id,html)VALUES(" + db.cite(id) + "," + db.cite(html) + ")");
        } finally
        {
            db.close();
        }
    }

    public String getId()
    {
        return id;
    }

    public String getHtml()
    {
        return html;
    }

    public boolean isExists()
    {
        return exists;
    }
}
