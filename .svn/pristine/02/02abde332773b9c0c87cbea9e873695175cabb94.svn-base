package tea.entity.node;

import tea.db.DbAdapter;
import java.util.*;
import java.sql.SQLException;

public class Listinghide implements Cloneable
{
    public int listing;
    public int node;
    public int hiden = -1;// 0在本树隐藏 1在子节点隐藏 2在该节点隐藏 3不隐藏

    public Listinghide(int listing,int node)
    {
        this.listing = listing;
        this.node = node;
    }

    public static Listinghide find(int listing,int node)
    {
        return new Listinghide(listing,node);
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT hiden FROM listinghide WHERE listing=" + listing + " AND node=" + node);
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

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT listing,node,hiden FROM listinghide WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                Listinghide t = new Listinghide(db.getInt(1),db.getInt(2));
                t.hiden = db.getInt(3);
            }
        } finally
        {
            db.close();
        }
        return al;
    }

    public static Enumeration findNodeByListing(int listing) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM listinghide WHERE listing=" + listing);
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

    public void set(int hiden) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(hiden == 3)
            {
                db.executeUpdate(listing,"DELETE FROM listinghide WHERE node=" + node + " AND listing=" + listing);
            } else
            {
                int j = db.executeUpdate(listing,"UPDATE listinghide SET hiden=" + hiden + " WHERE node=" + node + " AND listing=" + listing);
                if(j < 1)
                {
                    db.executeUpdate(listing,"INSERT INTO listinghide(node,listing,hiden)VALUES(" + node + ", " + listing + ", " + hiden + ")");
                }
            }
        } finally
        {
            db.close();
        }
        this.hiden = hiden;
    }

    public int getListing()
    {
        return listing;
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

    public Listinghide clone() throws CloneNotSupportedException
    {
        Listinghide t = (Listinghide)super.clone();
        return t;
    }

}
