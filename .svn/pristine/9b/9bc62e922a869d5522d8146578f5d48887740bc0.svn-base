package tea.entity.node;

import tea.db.DbAdapter;
import java.sql.SQLException;
import java.util.*;

public class Cssjshide
{
    private int cssjs;
    private int node;
    private int hiden = -1; // 0在本树隐藏 1在子节点隐藏 2在该节点隐藏 3不隐藏

    public Cssjshide(int cssjs,int node)
    {
        this.cssjs = cssjs;
        this.node = node;
    }

    public static Cssjshide find(int cssjs,int node) throws SQLException
    {
        return new Cssjshide(cssjs,node);
    }

    public void set(int hiden) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(hiden == 3)
            {
                db.executeUpdate(cssjs,"DELETE FROM CssJsHide WHERE node=" + node + " AND cssjs=" + cssjs);
            } else
            {
                int j = db.executeUpdate(cssjs,"UPDATE CssJsHide SET hiden=" + hiden + " WHERE node=" + node + " AND cssjs=" + cssjs);
                if(j < 1)
                {
                    db.executeUpdate(cssjs,"INSERT INTO CssJsHide(node,cssjs,hiden)VALUES (" + node + ", " + cssjs + ", " + hiden + ")");
                }
            }
        } finally
        {
            db.close();
        }
        this.hiden = hiden;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT hiden FROM CssJsHide WHERE cssjs=" + cssjs + " AND node=" + node);
            if(db.next())
            {
                hiden = db.getInt(1);
            } else
            {
                hiden = 3;
            }
        } finally
        {
            db.close();
        }
    }

    public static Enumeration findNodeByCssjs(int cssjs) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM CssJsHide WHERE cssjs=" + cssjs);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public int getCssjs()
    {
        return cssjs;
    }

    public int getNode()
    {
        return node;
    }

    public int getHiden() throws SQLException
    {
        if(hiden == -1)
        {
            load();
        }
        return hiden;
    }
}
