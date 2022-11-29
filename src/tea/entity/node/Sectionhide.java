package tea.entity.node;

import java.util.*;
import java.sql.SQLException;
import tea.db.DbAdapter;

public class Sectionhide implements Cloneable
{
    public int section;
    public int node;
    public int hiden = -1; // 0在本树隐藏 1在子节点隐藏 2在该节点隐藏 3不隐藏

    public Sectionhide(int section,int node)
    {
        this.section = section;
        this.node = node;
    }

    public static Sectionhide find(int section,int node) throws SQLException
    {
        return new Sectionhide(section,node);
    }

    public void set(int hiden) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(hiden == 3)
            {
                db.executeUpdate(section,"DELETE FROM sectionhide WHERE node=" + node + " AND section=" + section);
            } else
            {
                int j = db.executeUpdate(section,"UPDATE sectionhide SET hiden=" + hiden + " WHERE node=" + node + " AND section=" + section);
                if(j < 1)
                {
                    db.executeUpdate(section,"INSERT INTO sectionhide(node,section,hiden)VALUES (" + node + ", " + section + ", " + hiden + ")");
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
            db.executeQuery("SELECT hiden FROM sectionhide WHERE section=" + section + " AND node=" + node);
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

    public int getSection()
    {
        return section;
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

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT section,node,hiden FROM sectionhide WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                Sectionhide t = new Sectionhide(db.getInt(1),db.getInt(2));
                t.hiden = db.getInt(3);
            }
        } finally
        {
            db.close();
        }
        return al;
    }

    public static Enumeration findNodeBySection(int section) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM sectionhide WHERE section=" + section);
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

    public Sectionhide clone() throws CloneNotSupportedException
    {
        Sectionhide t = (Sectionhide)super.clone();
        return t;
    }
}
