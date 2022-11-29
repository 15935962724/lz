package tea.entity.admin;

import java.math.*;
import java.util.*;
import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class SubsidyYear
{
    class Layer
    {
        Layer()
        {
        }

        private String extendMonth;
        private String text;
    }


    public static java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("MM/yyyy");
    private Hashtable _htLayer;
    private static tea.entity.Cache _cache = new tea.entity.Cache(100);
    private int formsyear;
    private boolean exists;
    private BigDecimal balance;
    private BigDecimal subsidy;
    private BigDecimal total;
    private int subsidyMenu;
    private int useper;

    public SubsidyYear(int formsyear,int subsidyMenu) throws SQLException
    {
        _htLayer = new Hashtable();
        this.formsyear = formsyear;
        this.subsidyMenu = subsidyMenu;
        load();
    }

    public static SubsidyYear find(int formsyear,int subsidymenu) throws SQLException
    {
        SubsidyYear obj = (SubsidyYear) _cache.get(formsyear + ":" + subsidymenu);
        if(obj == null)
        {
            obj = new SubsidyYear(formsyear,subsidymenu);
            _cache.put(formsyear + ":" + subsidymenu,obj);
        }
        return obj;
    }

    public void delete() throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM SubsidyYear WHERE formsyear=" + formsyear);
            _cache.remove(formsyear + ":" + subsidyMenu);
        } finally
        {
            db.close();
        }
    }

    public void setUseper(int useper) throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        try
        {
            db.executeUpdate("UPDATE SubsidyYear SET useper=" + useper + " WHERE formsyear=" + formsyear + " AND subsidymenu=" + subsidyMenu);
            this.useper = useper;
        } finally
        {
            db.close();
        }
    }

    public void set(java.math.BigDecimal balance,java.math.BigDecimal subsidy,java.math.BigDecimal total) throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE SubsidyYear SET balance=" + balance + ",subsidy=" + subsidy + ",total=" + total + " WHERE formsyear=" + formsyear + " AND subsidymenu=" + subsidyMenu);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO SubsidyYear(formsyear,subsidymenu,balance,subsidy,total)VALUES(" + formsyear + "," + subsidyMenu + "," + balance + "," + subsidy + "," + total + ")");
            }
        } finally
        {
            db.close();
        }
        this.balance = balance;
        this.subsidy = subsidy;
        this.total = total;
        _htLayer.clear();
    }

    public static void create(int subsidyMenu,int useper,String month,java.math.BigDecimal earning,java.math.BigDecimal totalearning,java.math.BigDecimal payout,java.math.BigDecimal totalpayout,java.math.BigDecimal reality,String text,int language) throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        try
        {
            db.executeUpdate("SubsidyYearCreate " + subsidyMenu + "," + useper + "," + earning + "," + totalearning + "," + payout + "," + totalpayout + "," + reality + "," + DbAdapter.cite(month) + "," + DbAdapter.cite(text) + "," + language);
        } finally
        {
            db.close();
        }
    }

    public static java.util.Enumeration findByFormsMonth(java.util.Date formsmonth) throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        java.util.Vector vector = new java.util.Vector();
        try
        {
            db.executeQuery("SELECT formsyear FROM SubsidyYear WHERE DATEDIFF(mm, formsmonth," + DbAdapter.cite(formsmonth) + ")=0");
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

    public static java.util.Enumeration find() throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        java.util.Vector vector = new java.util.Vector();
        try
        {
            db.executeQuery("SELECT DISTINCT formsmonth FROM SubsidyYear ORDER BY formsmonth");
            while(db.next())
            {
                vector.addElement(db.getDate(1));
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
            db.executeQuery("SELECT         balance    ,            subsidy    ,            total,useper     FROM SubsidyYear WHERE formsyear=" + formsyear + " AND subsidymenu=" + subsidyMenu);
            if(db.next())
            {
                balance = db.getBigDecimal(1,2);
                subsidy = db.getBigDecimal(2,2);
                total = db.getBigDecimal(3,2);
                useper = db.getInt(4);
                this.exists = true;
            } else
            {
                useper = 90;
                balance = subsidy = total = new java.math.BigDecimal(0D);
                this.exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public String getExtendMonth(int language) throws SQLException
    {
        return getLayer(language).extendMonth;
    }

    public String getText(int language) throws SQLException
    {
        return getLayer(language).text;
    }

    private Layer getLayer(int language) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(language));
        if(layer == null)
        {
            layer = new Layer();
            DbAdapter db = new DbAdapter();
            try
            {
                int j = db.getInt("SubsidyYearGetLanguage " + formsyear + ", " + language);
                db.executeQuery("SELECT extendmonth,text FROM SubsidyYearLayer  WHERE formsyear=" + formsyear + " AND language=" + j);
                if(db.next())
                {
                    layer.extendMonth = db.getVarchar(j,language,1);
                    layer.text = db.getVarchar(j,language,2);
                } else
                {
                    layer.extendMonth = dateFormat.format(new java.util.Date());
                }
            } finally
            {
                db.close();
            }
            _htLayer.put(new Integer(language),layer);
        }
        return layer;
    }

    public boolean isExists()
    {
        return exists;
    }

    public BigDecimal getBalance()
    {
        return balance;
    }

    public BigDecimal getSubsidy()
    {
        return subsidy;
    }

    public BigDecimal getTotal()
    {
        return total;
    }

    public int getSubsidyMenu()
    {
        return subsidyMenu;
    }

    public int getUseper()
    {
        return useper;
    }
    /*
     * public void setUseper(int useper) throws SQLException { tea.db.DbAdapter db = new tea.db.DbAdapter(); try { db.executeUpdate("UPDATE SubsidyYear SET useper=" + useper + " WHERE id=" + id); this.useper = useper;} finally { db.close(); } }
     */
}
