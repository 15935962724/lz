package tea.entity.node;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;
import java.sql.ResultSet;

public class PickFrom extends Entity
{
    public static Cache _cache = new Cache(200);
    public static final String FROM_STYLE[] =
            {"ThisCommunity","AllCommunities","ThisNode","ThisTree"};
    public static final int FROMS_THISCOMMUNITY = 0;
    public static final int FROMS_ALLCOMMUNITIES = 1;
    public static final int FROMS_THISNODE = 2;
    public static final int FROMS_THISTREE = 3;
    public int pickfrom;
    public int listing;
    public int fromstyle;
    public String fromCommunity;
    public int fromNode;

    public void set(int i,String s,int j) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(pickfrom,"UPDATE PickFrom SET fromstyle=" + i + ", fromcommunity=" + DbAdapter.cite(s) + ",fromnode=" + j + " WHERE pickfrom=" + pickfrom);
        } finally
        {
            db.close();
        }
        fromstyle = i;
        fromCommunity = s;
        fromNode = j;
		_cache.remove(listing);
    }

    public static int count(String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt("SELECT COUNT(*) FROM PickFrom WHERE 1=1" + sql);
        } finally
        {
            db.close();
        }
        return j;
    }

    public PickFrom(int pickfrom)
    {
        this.pickfrom = pickfrom;
    }

    public static void create(int listing,int j,String s,int k) throws SQLException
    {
        int newid = Seq.get();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(newid,"INSERT INTO PickFrom(pickfrom,listing,fromstyle,fromcommunity,fromnode) VALUES(" + newid + "," + listing + "," + j + "," + DbAdapter.cite(s) + "," + k + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(listing);
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            ResultSet rs = db.executeQuery("SELECT pickfrom,listing,fromstyle,fromcommunity,fromnode FROM PickFrom WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                PickFrom t = new PickFrom(rs.getInt(1));
                t.listing = db.getInt(2);
                t.fromstyle = db.getInt(3);
                t.fromCommunity = db.getString(4);
                t.fromNode = db.getInt(5);
                al.add(t);
            }
        } finally
        {
            db.close();
        }
        return al;
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

    public int getListing() throws SQLException
    {
        return listing;
    }


    public String getFromCommunity() throws SQLException
    {
        return fromCommunity;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(pickfrom,"DELETE FROM PickFrom WHERE pickfrom=" + pickfrom);
        } finally
        {
            db.close();
        }
        _cache.remove(listing);
    }

    public static PickFrom find(int pickfrom) throws SQLException
    {
        ArrayList al = find(" AND pickfrom=" + pickfrom,0,1);
        return al.size() < 1 ? new PickFrom(pickfrom) : (PickFrom) al.get(0);
    }

    public int getFromNode() throws SQLException
    {
        return fromNode;
    }

    public int getFromStyle() throws SQLException
    {
        return fromstyle;
    }
}
