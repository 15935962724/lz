package tea.entity.node;

import java.util.*;
import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class PickManual extends Entity implements Cloneable
{
    public static Cache _cache = new Cache(100);
    public static String CLASSES_TYPE[] =
            {"News","Reported"};
    public int pickmanual;
    public int listing;
    public String community = "";
    public int type = 255;
//    private int typeAlias;
    public int classes;

    public static PickManual find(int pickmanual) throws SQLException
    {
        PickManual t = (PickManual) _cache.get(pickmanual);
        if(t == null)
        {
            ArrayList al = find(" AND pickmanual=" + pickmanual,0,1);
            t = al.size() < 1 ? new PickManual(pickmanual) : (PickManual) al.get(0);
        }
        return t;
    }

//    public void set(String community,int type,int classes) throws SQLException
//    {
//        DbAdapter db = new DbAdapter();
//        try
//        {
//            db.executeUpdate("UPDATE PickManual  SET community=" + DbAdapter.cite(community) + ",type=" + type + ",classes=" + classes + " WHERE pickmanual=" + pickmanual);
//        } finally
//        {
//            db.close();
//        }
//        if(type != 255 && type == 255)
//        {
//            ListingDetail.delete(listing,type);
//        }
//        this.community = community;
//        this.type = type;
//        this.classes = classes;
//    }

    public static int count(String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt("SELECT COUNT(pickmanual) FROM PickManual WHERE 1=1" + sql);
        } finally
        {
            db.close();
        }
        return j;
    }

    private PickManual(int i)
    {
        pickmanual = i;
    }

    public void set() throws SQLException
    {
        _cache.remove(new Integer(pickmanual));
        String sql;
        if(pickmanual < 1)
            sql = "INSERT INTO PickManual(pickmanual,listing,community,type,classes)VALUES(" + (pickmanual = Seq.get()) + "," + listing + "," + DbAdapter.cite(community) + "," + type + "," + classes + ")";
        else
            sql = "UPDATE PickManual SET community=" + DbAdapter.cite(community) + ",type=" + type + ",classes=" + classes + " WHERE pickmanual=" + pickmanual;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(pickmanual,sql);
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
            db.executeQuery("SELECT pickmanual,listing,community,type,classes FROM PickManual WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                int j = 1;
                PickManual pm = new PickManual(db.getInt(j++));
                pm.listing = db.getInt(j++);
                pm.community = db.getString(j++);
                pm.type = db.getInt(j++);
                pm.classes = db.getInt(j++);
                _cache.put(pm.pickmanual,pm);
                al.add(pm);
            }
        } finally
        {
            db.close();
        }
        return al;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(pickmanual,"DELETE FROM PickManual WHERE pickmanual=" + pickmanual);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(pickmanual));
    }

    //
    public PickManual clone() throws CloneNotSupportedException
    {
        PickManual t = (PickManual)super.clone();
        t.pickmanual = 0;
        return t;
    }
}
