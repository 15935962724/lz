package tea.entity.node;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class PickNews extends Entity
{
    public static Cache _cache = new Cache(100);
    public int picknews;
    public int listing;
    public int issueTerm;
    public PickNews(int i)
    {
        picknews = i;
    }

    public static PickNews find(int picknews) throws SQLException
    {
        ArrayList al = find(" AND picknews=" + picknews,0,1);
        return al.size() < 1 ? new PickNews(picknews) : (PickNews) al.get(0);
    }


    public static ArrayList findByListing(int listing) throws SQLException
    {
        ArrayList al = (ArrayList) _cache.get(listing);
        if(al == null)
        {
            al = find(" AND listing=" + listing,0,Integer.MAX_VALUE);
            _cache.put(listing,al);
        }
        return al;
    }

//    public int getListing() throws SQLException
//    {
//        load();
//        return listing;
//    }
//
//    public int getIssueTerm() throws SQLException
//    {
//        load();
//        return issueTerm;
//    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT picknews,listing,issueterm FROM PickNews WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                PickNews t = new PickNews(db.getInt(1));
                t.listing = db.getInt(2);
                t.issueTerm = db.getInt(3);
                al.add(t);
            }
        } finally
        {
            db.close();
        }
        return al;
    }

    public static int count(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return db.getInt("SELECT COUNT(picknews) FROM PickNews WHERE 1=1" + sql);
        } finally
        {
            db.close();
        }
    }

    public void set() throws SQLException
    {
        String sql;
        if(picknews < 1)
            sql = "INSERT INTO PickNews(picknews,listing,issueterm)VALUES(" + (picknews = Seq.get()) + "," + listing + "," + issueTerm + ")";
        else
            sql = "UPDATE PickNews SET issueterm=" + issueTerm + " WHERE picknews=" + picknews;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(picknews,sql);
        } finally
        {
            db.close();
        }
        _cache.remove(listing);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(picknews,"DELETE FROM PickNews WHERE picknews=" + picknews);
        } finally
        {
            db.close();
        }
        _cache.remove(listing);
    }


}
