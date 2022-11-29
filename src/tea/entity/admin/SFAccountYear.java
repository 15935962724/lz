package tea.entity.admin;

import java.math.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class SFAccountYear
{
    class Layer
    {
        Layer()
        {
        }

        private String text;
        private String picture;
    }


    private Hashtable _htLayer;
    private static tea.entity.Cache _cache = new tea.entity.Cache(100);
    private int formsyear;
    private boolean exists;
    private BigDecimal balance;

    private int sfaccount;

    public SFAccountYear(int formsyear,int sfaccount) throws SQLException
    {
        _htLayer = new Hashtable();
        this.formsyear = formsyear;
        this.sfaccount = sfaccount;
        load();
    }

    public static SFAccountYear find(int formsyear,int sfaccount) throws SQLException
    {
        SFAccountYear obj = (SFAccountYear) _cache.get(formsyear + ":" + sfaccount);
        if(obj == null)
        {
            obj = new SFAccountYear(formsyear,sfaccount);
            _cache.put(formsyear + ":" + sfaccount,obj);
        }
        return obj;
    }

    public void delete() throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM SFAccountYear WHERE formsyear=" + formsyear);
            _cache.remove(formsyear + ":" + sfaccount);
        } finally
        {
            db.close();
        }
    }

    public void set(java.math.BigDecimal balance) throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        try
        {
            // db.executeUpdate("SFAccountYearEdit " +
            // formsyear + "," +
            // sfaccount + "," +
            // (balance));
            db.executeQuery("SELECT formsyear FROM SFAccountYear WHERE sfaccount=" + sfaccount + " AND formsyear=" + formsyear);
            if(db.next())
            {
                db.executeUpdate("UPDATE SFAccountYear   SET  balance =" + balance + " WHERE sfaccount=" + sfaccount + " AND formsyear=" + formsyear);
            } else
            {
                db.executeUpdate("INSERT INTO SFAccountYear(formsyear,sfaccount,balance)VALUES(" + formsyear + "," + sfaccount + "," + balance + ")");
            }

            this.balance = balance;
        } finally
        {
            db.close();
        }
    }

    public void set(java.math.BigDecimal balance,String text,String picture,int language) throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        try
        {
            db.executeQuery("SELECT sfaccount FROM SFAccountYearLayer WHERE sfaccount=" + sfaccount + " AND language=" + language);
            if(db.next())
            {
                db.executeUpdate("UPDATE SFAccountYearLayer  SET text=" + DbAdapter.cite(text) + "	,picture=" + DbAdapter.cite(picture) + "	 WHERE sfaccount=" + sfaccount + " AND formsyear=" + formsyear + "	   AND language=" + language);
            } else
            {
                db.executeUpdate("INSERT INTO SFAccountYearLayer (formsyear,sfaccount, language, text,picture)VALUES (" + formsyear + "," + sfaccount + ", " + language + ", " + DbAdapter.cite(text) + "," + DbAdapter.cite(picture) + ")");
            }
        } finally
        {
            db.close();
        }
        this.balance = balance;
        _htLayer.clear();
    }

    /*
     * public static void create(int sfaccount, int useper, String month, java.math.BigDecimal earning, java.math.BigDecimal totalearning, java.math.BigDecimal payout, java.math.BigDecimal totalpayout, java.math.BigDecimal reality, String text, int language) throws SQLException { tea.db.DbAdapter
     * db = new tea.db.DbAdapter(); try { db.executeUpdate("SFAccountYearCreate " + sfaccount + "," + useper + "," + earning + "," + totalearning + "," + payout + "," + totalpayout + "," + reality + "," + DbAdapter.cite(month) + "," + DbAdapter.cite(text) + "," + language ); } catch
     * (SQLException ex) { throw new tea.entity.SQLException(ex.toString()); } finally { db.close(); } }
     */

    public static java.util.Enumeration findByFormsMonth(java.util.Date formsmonth) throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        java.util.Vector vector = new java.util.Vector();
        try
        {
            db.executeQuery("SELECT formsyear FROM SFAccountYear WHERE DATEDIFF(mm, formsmonth," + DbAdapter.cite(formsmonth) + ")=0");
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

    private void load() throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        try
        {
            db.executeQuery("SELECT    balance    FROM SFAccountYear WHERE formsyear=" + formsyear + " AND sfaccount=" + sfaccount);
            if(db.next())
            {
                balance = db.getBigDecimal(1,2);
                this.exists = true;
            } else
            {
                balance = new java.math.BigDecimal(0D);
                this.exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    /*
     * public String getExtendMonth(int language) throws SQLException { return getLayer(language).extendMonth; }
     *
     * public String getText(int language) throws SQLException { return getLayer(language).text; }
     *
     * private Layer getLayer(int language) throws SQLException { Layer layer = (Layer) _htLayer.get(new Integer(language)); if (layer == null) { layer = new Layer(); DbAdapter db = new DbAdapter(); try { int j = db.getInt("SFAccountYearGetLanguage " + formsyear + ", " + language);
     * db.executeQuery("SELECT extendmonth,text FROM SFAccountYearLayer WHERE formsyear=" + formsyear + " AND language=" + j); if (db.next()) { layer.extendMonth = db.getVarchar(j, language, 1); layer.text = db.getVarchar(j, language, 2); } else { layer.extendMonth = dateFormat.format(new
     * java.util.Date()); }} finally { db.close(); } _htLayer.put(new Integer(language), layer); } return layer; }
     */

    public boolean isExists()
    {
        return exists;
    }

    public String getPicture(int language) throws SQLException
    {
        return getLayer(language).picture;
    }

    public void setPicture(String picture,int language) throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        try
        {
            db.executeUpdate("SFAccountYearEdit " + formsyear + "," + sfaccount + "," + (balance) + "," + DbAdapter.cite(getText(language)) + "," + DbAdapter.cite(picture) + "," + language);
            _htLayer.clear();
        } finally
        {
            db.close();
        }

    }

    public String getText(int language) throws SQLException
    {
        return getLayer(language).text;
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
                // int j = db.getInt("SFAccountYearGetLanguage " + formsyear + "," + sfaccount + ", " + i);
                int j = this.getLanguage(i);
                db.executeQuery("SELECT text, picture FROM SFAccountYearLayer  WHERE formsyear=" + formsyear + " AND sfaccount=" + sfaccount + " AND language=" + j);
                if(db.next())
                {
                    layer.text = db.getVarchar(j,i,1);
                    layer.picture = db.getString(2);
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
            db.executeQuery("SELECT language FROM SFAccountYearLayer WHERE sfaccount=" + sfaccount + " and formsyear=" + formsyear);
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

    public BigDecimal getBalance()
    {
        return balance;
    }

    /*
     * public BigDecimal getSubsidy() { return subsidy; }
     *
     *
     * public BigDecimal getTotal() { return total; }
     *
     *
     * public int getUseper() { return useper; }
     */

    public int getSfaccount()
    {
        return sfaccount;
    }

    /*
     * public void setUseper(int useper) throws SQLException { tea.db.DbAdapter db = new tea.db.DbAdapter(); try { db.executeUpdate("UPDATE SFAccountYear SET useper=" + useper + " WHERE id=" + id); this.useper = useper; } catch (SQLException ex) { throw new
     * tea.entity.SQLException(ex.toString()); } finally { db.close(); } }
     */
}
