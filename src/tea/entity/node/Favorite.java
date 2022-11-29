package tea.entity.node;

import java.util.Enumeration;
import java.util.Vector;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class Favorite extends Entity
{
    public static void create(String community,RV rv,int node) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM Favorite WHERE node=" + node + " AND rmember=" + DbAdapter.cite(rv._strR) + "  AND vmember=" + DbAdapter.cite(rv._strV) + " AND community=" + DbAdapter.cite(community));
            if(!db.next())
            {
                db.executeUpdate("INSERT INTO Favorite (community, rmember, vmember,node)VALUES (" + DbAdapter.cite(community) + ", " + DbAdapter.cite(rv._strR) + ", " + DbAdapter.cite(rv._strV) + "," + node + ")");
            }
        } finally
        {
            db.close();
        }
    }

    public Favorite()
    {
    }

    public static int countNodes(String community,RV rv,int type) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.getInt("SELECT COUNT(f.node) " + getNodesSql(community,rv,type));
        } finally
        {
            db.close();
        }
        return i;
    }

    public static boolean isExisted(String community,RV rv,int node) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM Favorite WHERE community=" + DbAdapter.cite(community) + " AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV) + " AND node=" + node);
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }

    public static Enumeration findNodes(String community,RV rv,int type,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT f.node " + getNodesSql(community,rv,type),pos,size);
            while(db.next())
            {
                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static void delete(String community,RV rv,int node) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Favorite WHERE community=" + DbAdapter.cite(community) + " AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV) + " AND node=" + node);
        } finally
        {
            db.close();
        }
    }

    public static void delete_2(String community,RV rv) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Favorite WHERE community=" + DbAdapter.cite(community) + " AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV));
        } finally
        {
            db.close();
        }

    }

    private static String getNodesSql(String community,RV rv,int type)
    {
        return " FROM Favorite f INNER JOIN Node n ON f.node=n.node WHERE f.rmember=" + DbAdapter.cite(rv._strR) + " AND f.vmember=" + DbAdapter.cite(rv._strV) + " AND f.community=" + DbAdapter.cite(community) + " AND n.type=" + type;
    }

    //我的收藏
    private static String getNodesSql_cs(String community,RV rv,int type,String goodstype)
    {
        return " FROM Favorite f inner join Goods g on f.node=g.node INNER JOIN Node n ON f.node=n.node WHERE f.rmember=" + DbAdapter.cite(rv._strR) + " AND f.vmember=" + DbAdapter.cite(rv._strV) + " AND f.community="
                + DbAdapter.cite(community) + " AND n.type=" + type + " and g.goodstype like " + DbAdapter.cite("%" + goodstype + "%");
    }

    //我的收藏
    public static Enumeration findNodes_sc(String community,RV rv,int type,int pos,int size,String goodstype) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT f.node " + getNodesSql_cs(community,rv,type,goodstype),pos,size);
            while(db.next())
            {
                vector.addElement(Integer.valueOf(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    //我的收藏用的
    public static int countNodes(String community,RV rv,int type,String goodstype) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.getInt("SELECT COUNT(f.node) " + getNodesSql_cs(community,rv,type,goodstype));

        } finally
        {
            db.close();
        }
        return i;
    }


}
