package tea.entity.admin.sales;

import java.sql.SQLException;
import java.util.ArrayList;

import tea.db.DbAdapter;
import tea.entity.Cache;


public class PriceSet
{
    protected static Cache c = new Cache(50);
    public int node;
    public int price; //

    public PriceSet(int node)
    {
        this.node = node;
    }

    public static PriceSet find(int node) throws SQLException
    {
        PriceSet t = (PriceSet) c.get(node);
        if(t == null)
        {
            ArrayList al = find(" AND node=" + node,0,1);
            t = al.size() < 1 ? new PriceSet(node) : (PriceSet) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT node,price FROM PriceSet WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                PriceSet t = new PriceSet(rs.getInt(i++));
               
                t.price = rs.getInt(i++);

                c.put(t.node,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM PriceSet WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("INSERT INTO PriceSet(node,price)VALUES(" + node + "," + price  + ")");
            if(j < 1)
                db.executeUpdate("UPDATE PriceSet SET price=" + price  + " WHERE node=" + node);
        } finally
        {
            db.close();
        }
        c.remove(node);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM PriceSet WHERE node=" + node);
        c.remove(node);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE PriceSet SET " + f + "=" + DbAdapter.cite(v) + " WHERE node=" + node);
        c.remove(node);
    }

    
}

