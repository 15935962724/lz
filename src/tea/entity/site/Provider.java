package tea.entity.site;

import java.util.Enumeration;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.Entity;
import java.sql.SQLException;
import java.sql.SQLException;

public class Provider extends Entity
{

    private Provider(String s,String s1)
    {
        _strCommunity = s;
        _strMember = s1;
    }

    public static void create(String s,String s1,int i,int j) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            // db.executeUpdate("ProviderCreate " + DbAdapter.cite(s) + ", " +
            // DbAdapter.cite(s1) + ", " + i + ", " + j);
            db.executeQuery("SELECT community  FROM Provider	WHERE community=" + DbAdapter.cite(s) + "  AND member=" + DbAdapter.cite(s1));
            if(db.next())
            {
                db.executeUpdate("UPDATE Provider  SET providers0=" + i + ",   providers1=" + j + " WHERE community=" + DbAdapter.cite(s) + "  AND member=" + DbAdapter.cite(s1));
            } else
            {
                db.executeUpdate("INSERT INTO Provider (community, member, providers0, providers1)VALUES (" + DbAdapter.cite(s) + ", " + DbAdapter.cite(s1) + ", " + i + ", " + j + ")");
            }
        } finally
        {
            db.close();
        }
    }

    public static boolean isProvider(String community,String member,int type) throws SQLException
    {
        boolean flag;
        flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            if(type == 31 || type == 63) // ||type==63是我添加的 63=download
            {
                flag = true;
            } else
            {
                if(type < 32)
                {
                    db.executeQuery("SELECT community  FROM Provider  WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member) + " AND providers0&" + (1 << type % 32) + "<>0");
                } else
                {
                    db.executeQuery("SELECT community  FROM Provider  WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member) + " AND providers1&" + (1 << type % 32) + "<>0");
                }
                flag = db.next();
            }
        } finally
        {
            db.close();
        }
        return flag;
    }

    public static void deleteByCommunity(String s) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Provider  WHERE community=" + DbAdapter.cite(s));
        } finally
        {
            db.close();
        }
    }

    public int getProviders0()
    {
        return _nProviders0;
    }

    public static int count(String s) throws SQLException
    {
        int i;
        i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.getInt("SELECT COUNT(community)  FROM Provider  WHERE community=" + DbAdapter.cite(s));
        } finally
        {
            db.close();
        }
        return i;
    }

    public static Provider find(String s,String s1) throws SQLException
    {
        Provider provider;
        provider = new Provider(s,s1);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT providers0, providers1 FROM Provider  WHERE community=" + DbAdapter.cite(s) + " AND member=" + DbAdapter.cite(s1));
            if(db.next())
            {
                provider._nProviders0 = db.getInt(1);
                provider._nProviders1 = db.getInt(2);
                provider.exists = true;
            } else
            {
                provider.exists = false;
            }
        } finally
        {
            db.close();
        }
        return provider;
    }

    public static Enumeration find(String s,int i,int j) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member FROM Provider  WHERE community=" + DbAdapter.cite(s) + " ORDER BY member ",i,j);
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

    public static void delete(String s,String s1) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Provider  WHERE community=" + DbAdapter.cite(s) + " AND member=" + DbAdapter.cite(s1));
        } finally
        {
            db.close();
        }
    }

    public int getProviders1()
    {
        return _nProviders1;
    }

    public boolean isExists()
    {
        return exists;
    }

    private String _strCommunity;
    private String _strMember;
    private int _nProviders0;
    private int _nProviders1;
    private boolean exists;
}
