package tea.entity.admin;

import java.math.*;
import java.util.*;
import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class SubsidyMonth
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
    private int subsidymonth;
    private boolean exists;
    private int useper;
    private BigDecimal earning;
    private BigDecimal totalearning;
    private BigDecimal payout;
    private BigDecimal totalpayout;
    private BigDecimal reality;
    private Date formsMonth;
    private Date time;
    private int subsidyMenu;
    private String member;

    public SubsidyMonth()
    {
    }

    public SubsidyMonth(int subsidymonth) throws SQLException
    {
        _htLayer = new Hashtable();
        this.subsidymonth = subsidymonth;
        load();
    }

    public static SubsidyMonth find(int subsidymonth) throws SQLException
    {
        SubsidyMonth obj = (SubsidyMonth) _cache.get(new Integer(subsidymonth));
        if(obj == null)
        {
            obj = new SubsidyMonth(subsidymonth);
            _cache.put(new Integer(subsidymonth),obj);
        }
        return obj;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM SubsidyMonth WHERE subsidymonth=" + subsidymonth);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(subsidymonth));
    }

    public void set(int subsidyMenu,java.util.Date formsMonth,int useper,String month,java.math.BigDecimal earning,java.math.BigDecimal totalearning,java.math.BigDecimal payout,java.math.BigDecimal totalpayout,java.math.BigDecimal reality,String member,String text,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE SubsidyMonth SET  useper=" + (useper) + ",earning=" + (earning) + ",totalearning=" + (totalearning) + ",payout=" + (payout) + ",totalpayout=" + (totalpayout) + ",reality=" + (reality) + ",member=" + DbAdapter.cite(member) + " WHERE subsidymonth=" + subsidymonth);
            int j = db.executeUpdate("UPDATE SubsidyMonthLayer	SET extendmonth=" + DbAdapter.cite(month) + ",text=" + DbAdapter.cite(text) + " WHERE subsidymonth=" + subsidymonth + " AND language=" + language);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO SubsidyMonthLayer(subsidymonth,language,extendmonth,text)VALUES (" + subsidymonth + "," + language + "," + DbAdapter.cite(month) + "," + DbAdapter.cite(text) + ")");
            }
        } finally
        {
            db.close();
        }
        this.subsidyMenu = subsidyMenu;
        this.formsMonth = formsMonth;
        this.useper = useper;
        this.earning = earning;
        this.totalearning = totalearning;
        this.payout = payout;
        this.totalpayout = totalpayout;
        this.reality = reality;
        _htLayer.clear();
    }

    private void setLayer(String month,String text,int language) throws SQLException
    {
    }

    public static int create(int subsidymenu,int useper,String month,java.math.BigDecimal earning,java.math.BigDecimal totalearning,java.math.BigDecimal payout,java.math.BigDecimal totalpayout,java.math.BigDecimal reality,String text,int language) throws SQLException
    {
        int subsidymonth = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO SubsidyMonth(useper,earning     ,totalearning,payout      ,totalpayout ,reality  ,formsmonth,subsidymenu   )VALUES(" + useper + "," + earning + "," + totalearning + "," + payout + "," + totalpayout + "," + reality + "," + db.citeCurTime() + "," + subsidymenu + ")");
            subsidymonth = db.getInt("SELECT MAX(subsidymonth) FROM SubsidyMonth");
            db.executeUpdate("INSERT INTO SubsidyMonthLayer(subsidymonth,language,extendmonth,text)VALUES (" + subsidymonth + "," + language + "," + DbAdapter.cite(month) + "," + DbAdapter.cite(text) + ")");
        } finally
        {
            db.close();
        }
        return subsidymonth;
    }

    public static SubsidyMonth find(int subsidymenu,java.util.Date formsmonth) throws SQLException
    {
        int subsidymonth = 0;

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT subsidymonth FROM SubsidyMonth WHERE subsidymenu=" + subsidymenu + sql("formsmonth",formsmonth));
            if(db.next())
            {
                subsidymonth = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return find(subsidymonth);
    }

    private static String sql(String f,Date v)
    {
        StringBuilder sb = new StringBuilder();
        Calendar c = Calendar.getInstance();
        c.setTime(v);
        c.set(Calendar.DAY_OF_MONTH,1);
        Date start = c.getTime();
        c.add(Calendar.MONTH,1);
        Date end = c.getTime();
        sb.append(" AND ").append(f).append(">=").append(DbAdapter.cite(start)).append(" AND ").append(f).append("<").append(DbAdapter.cite(end));
        return sb.toString();
    }

    public static java.util.Enumeration findByFormsMonth(java.util.Date formsmonth) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        java.util.Vector vector = new java.util.Vector();
        try
        {
            db.executeQuery("SELECT subsidymonth FROM SubsidyMonth WHERE 1=1" + sql("formsmonth",formsmonth));
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
        DbAdapter db = new DbAdapter();
        java.util.Vector vector = new java.util.Vector();
        try
        {
            db.executeQuery("SELECT DISTINCT formsmonth FROM SubsidyMonth ORDER BY formsmonth");
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
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT useper,  earning ,totalearning,payout,totalpayout ,reality,formsmonth,time,subsidymenu,member FROM SubsidyMonth WHERE subsidymonth=" + subsidymonth);
            if(db.next())
            {
                useper = db.getInt(1);
                earning = db.getBigDecimal(2,2);
                totalearning = db.getBigDecimal(3,2);
                payout = db.getBigDecimal(4,2);
                totalpayout = db.getBigDecimal(5,2);
                reality = db.getBigDecimal(6,2);
                formsMonth = db.getDate(7);
                time = db.getDate(8);
                subsidyMenu = db.getInt(9);
                member = db.getString(10);
                exists = true;
            } else
            {
                useper = 90;
                earning = totalearning = payout = totalpayout = reality = new java.math.BigDecimal(0D);
                exists = false;
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
            int j = getLanguage(language);
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT extendmonth,text FROM SubsidyMonthLayer  WHERE subsidymonth=" + subsidymonth + " AND language=" + j);
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

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM SubsidyMonthLayer WHERE subsidymonth=" + subsidymonth);
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

    public boolean isExists()
    {
        return exists;
    }

    public int getUseper()
    {
        return useper;
    }

    public BigDecimal getEarning()
    {
        return earning;
    }

    public BigDecimal getTotalearning()
    {
        return totalearning;
    }

    public BigDecimal getPayout()
    {
        return payout;
    }

    public BigDecimal getTotalpayout()
    {
        return totalpayout;
    }

    public BigDecimal getReality()
    {
        return reality;
    }

    public Date getFormsMonth()
    {
        return formsMonth;
    }

    public Date getTime()
    {
        return time;
    }

    public int getSubsidyMenu()
    {
        return subsidyMenu;
    }

    public String getMember()
    {
        return member;
    }
    /*
     * public void setUseper(int useper) throws SQLException { DbAdapter db = new DbAdapter(); try { db.executeUpdate("UPDATE SubsidyMonth SET useper=" + useper + " WHERE id=" + id); this.useper = useper;} finally { db.close(); } }
     */
}
