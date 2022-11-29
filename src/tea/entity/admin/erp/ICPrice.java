package tea.entity.admin.erp;

import java.sql.SQLException;
import java.util.*;
import java.awt.*;
import tea.db.*;
import tea.entity.*;

//走势图-价位
public class ICPrice extends Entity
{
    public static final Color COLOR_TYPE[] =
            {new Color(0x46,0x84,0xEE),new Color(0xDC,0x39,0x12),new Color(0xFF,0x99,0x00),new Color(0x00,0x80,0x00),new Color(0x49,0x42,0xCC)};
    private int icprice;
    private String community;
    private int startprice; //
    private int endprice; //
    private boolean exists;
    public ICPrice(int icprice) throws SQLException
    {
        this.icprice = icprice;
        load();
    }

    private ICPrice(int icprice,String community,int startprice,int endprice) throws SQLException
    {
        this.icprice = icprice;
        this.community = community;
        this.startprice = startprice;
        this.endprice = endprice;
        this.exists = true;
    }


    public static boolean create(String community,int startprice,int endprice) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return db.executeUpdate("INSERT INTO ICPrice(community,startprice,endprice)VALUES(" + db.cite(community) + "," + startprice + "," + endprice + ")") > 0;
        } finally
        {
            db.close();
        }
    }

    public static ICPrice find(int icprice) throws SQLException
    {
        return new ICPrice(icprice);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,startprice,endprice FROM ICPrice WHERE icprice=" + icprice);
            if(db.next())
            {
                community = db.getString(1);
                startprice = db.getInt(2);
                endprice = db.getInt(3);
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

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT icprice,startprice,endprice FROM ICPrice WHERE community=" + db.cite(community) + sql,pos,size);
            while(db.next())
            {
                int icprice = db.getInt(1);
                int startprice = db.getInt(2);
                int endprice = db.getInt(3);
                v.addElement(new ICPrice(icprice,community,startprice,endprice));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM ICPrice WHERE icprice=" + icprice);
        } finally
        {
            db.close();
        }
    }

    public void set(int startprice,int endprice) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE ICPrice SET startprice=" + startprice + ",endprice=" + endprice + " WHERE icprice=" + icprice);
        } finally
        {
            db.close();
        }
        this.startprice = startprice;
        this.endprice = endprice;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getEndPrice()
    {
        return endprice;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getICPrice()
    {
        return icprice;
    }

    public int getStartPrice()
    {
        return startprice;
    }
}
