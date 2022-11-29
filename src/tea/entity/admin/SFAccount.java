package tea.entity.admin;

import java.math.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class SFAccount
{
    private static Cache _cache = new Cache(100);
    private int sfaccount;
    private boolean type;
    private boolean exists;
    private BigDecimal balance;
    private int sequence;
    private int father;
    private String community;
    private Hashtable _htLayer;

    class Layer
    {
        private String picture;
        private String text;
        private String name;
    }


    public static int getRootId(String community) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt("SELECT sfaccount FROM SFAccount  WHERE community=" + DbAdapter.cite(community) + " AND father=0");
        } finally
        {
            db.close();
        }
        if(j == 0)
        {
            j = SFAccount.create("ROOT",false,0,0,community,1);
        }
        return j;
    }

    public static java.util.Enumeration findByFather(int father) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        java.util.Vector vector = new java.util.Vector();
        try
        {
            db.executeQuery("SELECT sfaccount FROM SFAccount WHERE father=" + (father) + " ORDER BY sequence");
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public SFAccount(int sfaccount) throws SQLException
    {
        _htLayer = new Hashtable();
        this.sfaccount = sfaccount;
        load();
    }

    public static SFAccount find(int sfaccount) throws SQLException
    {
        SFAccount obj = (SFAccount) _cache.get(new Integer(sfaccount));
        if(obj == null)
        {
            obj = new SFAccount(sfaccount);
            _cache.put(new Integer(sfaccount),obj);
        }
        return obj;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from SFAccount where sfaccount=" + sfaccount);
            _cache.remove(new Integer(sfaccount));
        } finally
        {
            db.close();
        }
    }

    // public void set(java.math.BigDecimal balance, java.math.BigDecimal subssfaccounty) throws SQLException
    public void set(String name,boolean type,int sequence,int father,String community,int language) throws SQLException

    {
        DbAdapter db = new DbAdapter();
        try
        {
            /*
             * db.executeUpdate("SFAccountEdit " + sfaccount + "," + (type ? "1" : "0") + "," + sequence + "," + father + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(name) + "," + language );
             */
            db.executeUpdate("UPDATE SFAccount  SET type     =" + (type ? "1" : "0") + "     ,sequence =" + sequence + " ,father   =" + father + "   ,community=" + DbAdapter.cite(community) + "	 WHERE sfaccount=" + sfaccount);
            db.executeQuery("SELECT sfaccount FROM SFAccountLayer WHERE sfaccount=" + sfaccount + " AND language=" + language);
            if(db.next())
            {
                db.executeUpdate("UPDATE SFAccountLayer SET name=" + DbAdapter.cite(name) + "	 WHERE sfaccount=" + sfaccount + "	 AND language=" + language);
            } else
            {
                db.executeUpdate("INSERT INTO SFAccountLayer (sfaccount, language, name)VALUES (" + sfaccount + ", " + language + ", " + DbAdapter.cite(name) + ")");
            }
            this.type = type;
            this.sequence = sequence;
            this.community = community;
            this.father = father;
            _htLayer.clear();
        } finally
        {
            db.close();
        }
    }

    public void set(String text,String picture,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE SFAccountLayer SET " + " picture=" + DbAdapter.cite(picture) + ",text=" + DbAdapter.cite(text) + " WHERE sfaccount=" + sfaccount + " AND language=" + language);
            _htLayer.clear();
        } finally
        {
            db.close();
        }
    }

    public static int create(String name,boolean type,int sequence,int father,String community,int language) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO SFAccount(type,sequence,father,community)VALUES( " + (type ? "1" : "0") + "," + sequence + " ," + father + ",        " + DbAdapter.cite(community) + ")");
            j = db.getInt("SELECT MAX(sfaccount) FROM SFAccount");
            db.executeUpdate("INSERT INTO SFAccountLayer (sfaccount,language,name)VALUES (" + j + ", " + language + ", " + DbAdapter.cite(name) + ")");
        } finally
        {
            db.close();
        }
        return j;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT type      ,sequence  ,father    ,community ,balance FROM SFAccount WHERE sfaccount=" + sfaccount);
            if(db.next())
            {
                type = db.getInt(1) != 0;
                sequence = db.getInt(2);
                father = db.getInt(3);
                community = db.getString(4);
                balance = db.getBigDecimal(5,2);
                this.exists = true;
            } else
            {
                this.exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public int getSubssfaccountymenu()
    {
        return sfaccount;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getSequence()
    {
        return sequence;
    }

    public int getFather()
    {
        return father;
    }

    public String getCommunity()
    {
        return community;
    }

    public BigDecimal getBalance()
    {
        return balance;
    }

    public int getSfaccount()
    {
        return sfaccount;
    }

    public boolean isType()
    {
        return type;
    }

    private Layer getLayer(int i) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(i));
        if(layer == null)
        {
            layer = new Layer();
            DbAdapter db = new DbAdapter();
            try
            {
                // int j = db.getInt("SFAccountGetLanguage " + sfaccount + ", " + i);
                int j = this.getLanguage(i);
                db.executeQuery("SELECT name, text, picture FROM SFAccountLayer  WHERE sfaccount=" + sfaccount + " AND language=" + j);
                if(db.next())
                {
                    layer.name = db.getVarchar(j,i,1);
                    layer.text = db.getVarchar(j,i,2);
                    layer.picture = db.getString(3);
                }
            } finally
            {
                db.close();
            }
            _htLayer.put(new Integer(i),layer);
        }
        return layer;
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM SFAccountLayer WHERE sfaccount=" + sfaccount);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        if(v.indexOf(new Integer(language)) != -1)
        {
            return language;
        } else
        {
            if(language == 1)
            {
                if(v.indexOf(new Integer(2)) != -1)
                {
                    return 2;
                }
            } else if(language == 2)
            {
                if(v.indexOf(new Integer(1)) != -1)
                {
                    return 1;
                }
            }
            if(v.size() < 1)
            {
                return 0;
            }
        }
        return((Integer) v.elementAt(0)).intValue();
    }

    public static java.util.Enumeration findSon(int father) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        java.util.Vector vector = new java.util.Vector();
        try
        {
            db.executeQuery("SELECT sfaccount FROM SFAccount WHERE father=" + (father) + " ORDER BY sequence");
            while(db.next())
            {
                int id = db.getInt(1);
                vector.addElement(new Integer(id));
                java.util.Enumeration enumer = findSon(id);
                while(enumer.hasMoreElements())
                {
                    vector.addElement(enumer.nextElement());
                }
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public String getPicture(int language) throws SQLException
    {
        return getLayer(language).picture;
    }

    public String getText(int language) throws SQLException
    {
        return getLayer(language).text;
    }

    public String getName(int language) throws SQLException
    {
        return getLayer(language).name;
    }

    public void setBalance(BigDecimal balance) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE SFAccount SET balance=" + balance + " WHERE sfaccount=" + sfaccount);
        } finally
        {
            db.close();
        }
        this.balance = balance;
    }
}
