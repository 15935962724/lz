package tea.entity.member;

import java.util.Enumeration;
import java.util.Vector;
import tea.db.DbAdapter;
import tea.entity.Entity;
import java.sql.SQLException;

public class CouponMember extends Entity
{

    public static void create(int i,String s) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            // db.executeUpdate("CouponMemberCreate " + i + ", " + DbAdapter.cite(s));
            db.executeQuery("SELECT coupon  FROM CouponMember	WHERE coupon=" + i + "  AND member=" + DbAdapter.cite(s));
            if(db.next())
            {
                db.executeUpdate("INSERT INTO CouponMember (coupon, member)VALUES (" + i + ", " + DbAdapter.cite(s) + ")");
            }
        } finally
        {
            db.close();
        }
    }

    public CouponMember()
    {
    }

    public static boolean isExisted(int coupon,String member) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member   FROM CouponMember  WHERE coupon=" + coupon + " AND member=" + DbAdapter.cite(member));
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }

    public static void delete(int i,String s) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM CouponMember  WHERE coupon=" + i + " AND member=" + DbAdapter.cite(s));
        } finally
        {
            db.close();
        }
    }

    public static Enumeration find(int i,int j,int k) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member  FROM CouponMember  WHERE coupon=" + i,j,k);
            while(db.next())
            {
                vector.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static int count(int i) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt("SELECT COUNT(member)  FROM CouponMember  WHERE coupon=" + i);
        } finally
        {
            db.close();
        }
        return j;
    }
}
