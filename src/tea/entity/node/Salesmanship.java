package tea.entity.node;

import tea.entity.*;
import tea.db.DbAdapter;
import java.sql.SQLException;

public class Salesmanship
{
    private int waiter;
    private int trade;
    private static Cache _cache = new Cache(100);
    private boolean exists;

    public Salesmanship(int waiter,int trade) throws SQLException
    {
        this.waiter = waiter;
        this.trade = trade;
        loadBasic();
    }

    public static Salesmanship find(int waiter,int trade) throws SQLException
    {
        Salesmanship obj = (Salesmanship) _cache.get(waiter + ":" + trade);
        if(obj == null)
        {
            obj = new Salesmanship(waiter,trade);
            _cache.put(waiter + ":" + trade,obj);
        }
        return obj;
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            // db.executeUpdate("SalesmanshipEdit " + (waiter) + "," + trade);
            db.executeQuery("SELECT waiter FROM Salesmanship WHERE waiter=" + waiter + " AND trade=" + trade);
            if(!db.next())
            {
                db.executeUpdate("INSERT INTO Salesmanship (waiter, trade)VALUES (" + waiter + ", " + trade + ")");
            }
        } finally
        {
            db.close();
        }
        _cache.remove(waiter + ":" + trade);
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT waiter FROM Salesmanship WHERE waiter= " + (waiter) + " AND trade=" + trade);
            if(db.next())
            {
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

    /*
     * private static java.util.Enumeration find(int waiter,java.util.Date from,java.util.Date to) throws SQLException { java.util.Vector vector=new java.util.Vector(); DbAdapter db = new DbAdapter(); try { StringBuilder sql=new StringBuilder(); if(waiter!=0) sql.append(" AND waiter="+waiter); if(from!=null) sql.append(" AND come>="+DbAdapter.cite(from)); if(to!=null) sql.append(" AND to<"+DbAdapter.cite(to)); db.executeQuery("SELECT COUNT(waiter),SUM(gathering) FROM
     * Salesmanship,Trade WHERE status=7" +sql.toString()+" GROUP BY waiter"); while (db.next()) {
     *  } } finally { db.close(); } }
     */

    public int getWaiter()
    {
        return waiter;
    }

    public int getTrade()
    {
        return trade;
    }

    public boolean isExists()
    {
        return exists;
    }
}
