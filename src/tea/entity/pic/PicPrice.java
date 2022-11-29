package tea.entity.pic;

import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class PicPrice
{
    protected static Cache c = new Cache(50);
    public int pic;
    public float price500;
    public float price3;
    public float price5;
    public float price15;
    public float price30;
    public float price50;

    public PicPrice(int pic)
    {
        this.pic = pic;
    }

    public static PicPrice find(int pic) throws SQLException
    {
        PicPrice t = (PicPrice) c.get(pic);
        if(t == null)
        {
            ArrayList al = find(" AND pic=" + pic,0,1);
            t = al.size() < 1 ? new PicPrice(pic) : (PicPrice) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT pic,price500,price3,price5,price15,price30,price50 FROM picprice WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                PicPrice t = new PicPrice(rs.getInt(i++));
                t.price500 = rs.getFloat(i++);
                t.price3 = rs.getFloat(i++);
                t.price5 = rs.getFloat(i++);
                t.price15 = rs.getFloat(i++);
                t.price30 = rs.getFloat(i++);
                t.price50 = rs.getFloat(i++);
                c.put(t.pic,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM picprice WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate("INSERT INTO picprice(pic,price500,price3,price5,price15,price30,price50)VALUES(" + pic + "," + price500 + "," + price3 + "," + price5 + "," + price15 + "," + price30 + "," + price50 + ")");
            if(i < 1)
            {
                db.executeUpdate("UPDATE picprice SET price500=" + price500 + ",price3=" + price3 + ",price5=" + price5 + ",price15=" + price15 + ",price30=" + price30 + ",price50=" + price50 + " WHERE pic=" + pic);
            }
        } finally
        {
            db.close();
        }
        c.remove(pic);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM picprice WHERE pic=" + pic);
        c.remove(pic);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE picprice SET " + f + "=" + DbAdapter.cite(v) + " WHERE pic=" + pic);
        c.remove(pic);
    }
}
