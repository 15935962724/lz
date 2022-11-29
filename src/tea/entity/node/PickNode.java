package tea.entity.node;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class PickNode extends Entity implements Cloneable
{
    public static Cache _cache = new Cache(200);
    public static final String NODE_STYLE[] =
            {"Self","Father","Son","GrandSon"};
    public static final int NODES_SELF = 0;
    public static final int NODES_FATHER = 1;
    public static final int NODES_SON = 2;
    public static final int NODES_GRANDSON = 3;
    public static final String CREATOR_STYLE[] =
            {"DoNotCare","Real","Virtual","Both"};
    public static final int CREATORS_DONOTCARE = 0;
    public static final int CREATORS_REAL = 1;
    public static final int CREATORS_VIRTUAL = 2;
    public static final int CREATORS_BOTH = 3;
    public static final String TERM_STYLE[] =
            {"DoNotCare","UntilCurrent","OverCurrent"};
    public static final int TERMS_DONOTCARE = 0;
    public static final int TERMS_BEFORE = 1;
    public static final int TERMS_AFTER = 2;
    public int picknode;
    public int listing;
    public int nodeStyle;
    public int type;
    public int creatorStyle;
    public String rcreator;
    public String vcreator;
    public int startStyle;
    public int startTerm;
    public int stopStyle;
    public int stopTerm;
    public int detail;
    public int bbstype;
    public String parameter; //参数名

    // 保存具体的细节
    public void set(int detail) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE PickNode SET detail=" + detail + " WHERE picknode=" + picknode);
        } finally
        {
            db.close();
        }
        detail = detail;
    }

    public void set(int i,int j,int l,String s,String s1,int i1,int j1,int k1,int l1,String parameter) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(picknode,"UPDATE PickNode SET nodestyle=" + i + ",type=" + j + ",creatorstyle=" + l + ",rcreator=" + DbAdapter.cite(s) + ",vcreator=" + DbAdapter.cite(s1) + ",startstyle=" + i1 + ",startterm=" + j1 + ",stopstyle=" + k1 + ",stopterm=" + l1 + ",parameter=" + DbAdapter.cite(parameter) + " WHERE picknode=" + picknode);
        } finally
        {
            db.close();
        }
        if(type != 255 && j == 255)
        {
            ListingDetail.delete(listing,type);
        }
        nodeStyle = i;
        type = j;
        creatorStyle = l;
        rcreator = s;
        vcreator = s1;
        startStyle = i1;
        startTerm = j1;
        stopStyle = k1;
        stopTerm = l1;
        this.parameter = parameter;
        _cache.remove(listing);
    }

    public void set(String field,String value) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(picknode,"UPDATE PickNode SET " + field + "=" + DbAdapter.cite(value) + " WHERE picknode=" + picknode);
        } finally
        {
            db.close();
        }
        _cache.remove(listing);
    }

    public static int countByListing(int i) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt("SELECT COUNT(picknode)  FROM PickNode  WHERE listing=" + i);
        } finally
        {
            db.close();
        }
        return j;
    }

    public PickNode(int i)
    {
        picknode = i;
    }

    public static int create(int listing,int nodestyle,int type,int creatorstyle,String rcreator,String vcreator,int startstyle,int startterm,int stopstyle,int stopterm,String parameter) throws SQLException
    {
        int picknode = Seq.get();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(picknode,"INSERT INTO PickNode(picknode,listing,nodestyle,type,creatorstyle,rcreator,vcreator,startstyle,startterm,stopstyle,stopterm,parameter)VALUES(" + picknode + "," + listing + "," + nodestyle + "," + type + "," + creatorstyle + "," + DbAdapter.cite(rcreator) + "," + DbAdapter.cite(vcreator) + "," + startstyle + "," + startterm + "," + stopstyle + "," + stopterm + "," + DbAdapter.cite(parameter) + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(listing);
        return picknode;
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

    public static boolean isPickMine(int i) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT picknode  FROM PickNode  WHERE listing=" + i + " AND rcreator='' " + " AND vcreator='' ");
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT picknode,listing,nodestyle,type,creatorstyle,rcreator,vcreator,startstyle,startterm,stopstyle,stopterm,parameter,bbstype FROM PickNode WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                int j = 1;
                PickNode t = new PickNode(db.getInt(j++));
                t.listing = db.getInt(j++);
                t.nodeStyle = db.getInt(j++);
                t.type = db.getInt(j++);
                t.creatorStyle = db.getInt(j++);
                t.rcreator = db.getString(j++);
                t.vcreator = db.getString(j++);
                t.startStyle = db.getInt(j++);
                t.startTerm = db.getInt(j++);
                t.stopStyle = db.getInt(j++);
                t.stopTerm = db.getInt(j++);
                t.parameter = db.getString(j++);
                t.bbstype = db.getInt(j++);
                // detail=db.getInt(j++);
                al.add(t);
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
            db.executeUpdate(picknode,"DELETE FROM PickNode WHERE picknode=" + picknode);
        } finally
        {
            db.close();
        }
        if(type != 255)
        {
            ListingDetail.delete(listing,type);
        }
        _cache.remove(listing);
    }

    public static PickNode find(int picknode) throws SQLException
    {
        ArrayList al = find(" AND picknode=" + picknode,0,1);
        return al.size() < 1 ? new PickNode(picknode) : (PickNode) al.get(0);
    }

    public PickNode clone() throws CloneNotSupportedException
    {
        PickNode t = (PickNode)super.clone();
        t.picknode = 0;
        return t;
    }
//    public String getVCreator() throws SQLException
//    {
//        return vcreator;
//    }
//
//    public int getStartStyle() throws SQLException
//    {
//        return startStyle;
//    }
//
//    public int getStopStyle() throws SQLException
//    {
//        return stopStyle;
//    }
//
//    public String getRCreator() throws SQLException
//    {
//        load();
//        return rcreator;
//    }
//
//    public int getListing() throws SQLException
//    {
//        load();
//        return listing;
//    }
//
//    public int getBbstype() throws SQLException
//    {
//        load();
//        return bbstype;
//    }
//
//    public int getCreatorStyle() throws SQLException
//    {
//        load();
//        return creatorStyle;
//    }
//
//    public int getNodeStyle() throws SQLException
//    {
//        load();
//        return nodeStyle;
//    }
//
//    public int getStartTerm() throws SQLException
//    {
//        load();
//        return startTerm;
//    }
//
//    public int getStopTerm() throws SQLException
//    {
//        load();
//        return stopTerm;
//    }
//
//    public int getType() throws SQLException
//    {
//        load();
//        return type;
//    }
//
//    public int getDetail() throws SQLException
//    {
//        load();
//        return detail;
//    }
}
