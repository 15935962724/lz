package tea.entity.node;

import java.math.BigDecimal;
import java.util.Enumeration;
import java.util.Vector;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class StockQuote extends Entity
{
    private String _strSymbol;
    private String _strSuffix;
    private BigDecimal _bdLast;
    private BigDecimal _bdChange;
    private BigDecimal _bdChangePercent;
    private int _nVolume;
    private BigDecimal _bdOpen;
    private BigDecimal _bdLow;
    private BigDecimal _bdHigh;
    private boolean _blLoaded;
    private static Cache _cache = new Cache(100);
    public static final int SORT_INCREASE = 0;
    public static final int SORT_DECREASE = 1;
    public static final int SORT_LOWHIGH = 2;
    public static final int SORT_VOLUME = 3;
    public static final int SORT_VOLUMELAST = 4;

    public void set(BigDecimal bigdecimal,BigDecimal bigdecimal1,BigDecimal bigdecimal2,int i,BigDecimal bigdecimal3,BigDecimal bigdecimal4,BigDecimal bigdecimal5) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE StockQuote SET last=" + bigdecimal + ",changes=" + bigdecimal1 + ",changepercent=" + bigdecimal2 + ",volume=" + i + ",open=" + bigdecimal3 + ",low=" + bigdecimal4 + ",high=" + bigdecimal5 + " WHERE symbol=" + DbAdapter.cite(_strSymbol) + " AND suffix=" + DbAdapter.cite(_strSuffix));
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO StockQuote (symbol,suffix,last,changes,changepercent,volume,open,low,high)VALUES( " + DbAdapter.cite(_strSymbol) + "," + DbAdapter.cite(_strSuffix) + "," + bigdecimal + "," + bigdecimal1 + "," + bigdecimal2 + "," + i + "," + bigdecimal3 + "," + bigdecimal4 + "," + bigdecimal5 + ")");
            }
        } finally
        {
            db.close();
        }
        _bdLast = bigdecimal;
        _bdChange = bigdecimal1;
        _bdChangePercent = bigdecimal2;
        _nVolume = i;
        _bdOpen = bigdecimal3;
        _bdLow = bigdecimal4;
        _bdHigh = bigdecimal5;
    }

    public BigDecimal getOpen() throws SQLException
    {
        load();
        return _bdOpen;
    }

    private StockQuote(String s,String s1)
    {
        _strSymbol = s;
        _strSuffix = s1;
        _blLoaded = false;
    }

    public BigDecimal getLast() throws SQLException
    {
        load();
        return _bdLast;
    }

    public BigDecimal getChange() throws SQLException
    {
        load();
        return _bdChange;
    }

    public int getVolume() throws SQLException
    {
        load();
        return _nVolume;
    }

    public BigDecimal getHigh() throws SQLException
    {
        load();
        return _bdHigh;
    }

    public BigDecimal getChangePercent() throws SQLException
    {
        load();
        return _bdChangePercent;
    }

    private void load() throws SQLException
    {
        if(!_blLoaded)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT last, changes, volume, [open], low, high FROM StockQuote  WHERE symbol=" + DbAdapter.cite(_strSymbol) + (_strSymbol.startsWith("^") ? "" : " AND suffix=" + DbAdapter.cite(_strSuffix)));
                if(db.next())
                {
                    _bdLast = db.getBigDecimal(1,4);
                    _bdChange = db.getBigDecimal(2,4);
                    _nVolume = db.getInt(3);
                    _bdOpen = db.getBigDecimal(4,4);
                    _bdLow = db.getBigDecimal(5,4);
                    _bdHigh = db.getBigDecimal(6,4);
                }
            } finally
            {
                db.close();
            }
            _blLoaded = true;
        }
    }

    public BigDecimal getLow() throws SQLException
    {
        load();
        return _bdLow;
    }

    public static StockQuote find(String s,String s1)
    {
        StockQuote stockquote = (StockQuote) _cache.get(s + ":" + s1);
        if(stockquote == null)
        {
            stockquote = new StockQuote(s,s1);
            _cache.put(s + ":" + s1,stockquote);
        }
        return stockquote;
    }

    public static StockQuote find(String s)
    {
        int i = s.indexOf(".");
        if(i != -1)
        {
            return find(s.substring(0,i),s.substring(i + 1));
        } else
        {
            return find(s,"");
        }
    }

    public static Enumeration find(String s,int i,int j,int k) throws SQLException
    {
        String s1 = null;
        switch(i)
        {
        case 0: // '\0'
            s1 = "SELECT symbol FROM StockQuote WHERE suffix=" + DbAdapter.cite(s) + " ORDER BY changepercent DESC ";
            break;
        case 1: // '\001'
            s1 = "SELECT symbol FROM StockQuote WHERE suffix=" + DbAdapter.cite(s) + " ORDER BY changepercent ASC ";
            break;
        case 2: // '\002'
            s1 = "SELECT symbol FROM StockQuote WHERE suffix=" + DbAdapter.cite(s) + " ORDER BY (high-low)/open DESC ";
            break;
        case 3: // '\003'
            s1 = "SELECT symbol FROM StockQuote WHERE suffix=" + DbAdapter.cite(s) + " ORDER BY volume DESC ";
            break;
        case 4: // '\004'
            s1 = "SELECT symbol FROM StockQuote WHERE suffix=" + DbAdapter.cite(s) + " ORDER BY volume*last DESC ";
            break;
        }
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(s1,j,k);
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

}
