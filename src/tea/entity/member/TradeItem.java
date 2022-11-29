package tea.entity.member;

import java.math.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class TradeItem extends Entity
{
    private int _nTradeItem;
    private String _strTrade;
    private Date _time;
    private int _nNode;
    private String _strSubject;
    private BigDecimal _bdPrice;
    private int _nQuantity;
    private boolean _blLoaded;
    private static Cache _cache = new Cache(100);
    /*******csv*********/
    private int _type; //赠品标示

    /*
     * private int _nSQuantity; private int _nSubjectx; private BigDecimal agent0; //管理员的利润 private BigDecimal agent1; //1级代理的利润 private BigDecimal agent2; //2级代理的利润 private BigDecimal agent3; //3级代理的利润
     */
    public void set(int quantity) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE tradeitem SET quantity=" + quantity + " WHERE tradeitem=" + _nTradeItem);
        } finally
        {
            db.close();
        }
        this._nQuantity = quantity;
    }

    private TradeItem(int i)
    {
        _nTradeItem = i;
        _blLoaded = false;
    }

    public static BigDecimal sumByTrade(String trade) throws SQLException
    {
        BigDecimal bd = BigDecimal.ZERO;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT SUM(price*quantity) FROM tradeitem WHERE trade=" + DbAdapter.cite(trade));
            if (db.next())
            {
                bd = db.getBigDecimal(1, 2);
            }
        } finally
        {
            db.close();
        }
        return bd;
    }

    public static Enumeration findByTrade(String trade) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT tradeitem FROM tradeitem WHERE trade=" + DbAdapter.cite(trade));
            while (db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public Date getTime() throws SQLException
    {
        load();
        return _time;
    }

    public String getTimeToString() throws SQLException
    {
        load();
        return sdf2.format(_time);
    }

    public BigDecimal getPrice() throws SQLException
    {
        load();
        return _bdPrice;
    }

    public int getQuantity() throws SQLException
    {
        load();
        return _nQuantity;
    }

    private void load() throws SQLException
    {
        if (!_blLoaded)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT trade,time,node,subject,price,quantity FROM tradeitem WHERE tradeitem=" + _nTradeItem);
                if (db.next())
                {
                    _strTrade = db.getString(1);
                    _time = db.getDate(2);
                    _nNode = db.getInt(3);
                    _strSubject = db.getString(4);
                    _bdPrice = db.getBigDecimal(5, 2);
                    _nQuantity = db.getInt(6);
                }
            } catch (Exception exception1)
            {
                throw new SQLException(exception1.toString());
            } finally
            {
                db.close();
            }
            _blLoaded = true;
        }
    }

    public static TradeItem find(int i)
    {
        TradeItem tradeitem = (TradeItem) _cache.get(new Integer(i));
        if (tradeitem == null)
        {
            tradeitem = new TradeItem(i);
            _cache.put(new Integer(i), tradeitem);
        }
        return tradeitem;
    }

    public int getNode() throws SQLException
    {
        load();
        return _nNode;
    }

    public String getSubject() throws SQLException
    {
        load();
        return _strSubject;
    }
    /*******csv********/
    private void load_csv() throws SQLException
    {
        if (!_blLoaded)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT trade,time,node,subject,price,quantity,type FROM tradeitem WHERE tradeitem=" + _nTradeItem);
                if (db.next())
                {
                    _strTrade = db.getString(1);
                    _time = db.getDate(2);
                    _nNode = db.getInt(3);
                    _strSubject = db.getString(4);
                    _bdPrice = db.getBigDecimal(5, 2);
                    _nQuantity = db.getInt(6);
                    _type =db.getInt(7);
                }
            } catch (Exception exception1)
            {
                throw new SQLException(exception1.toString());
            } finally
            {
                db.close();
            }
            _blLoaded = true;
        }
    }

    public int getType()throws SQLException
    {
        load_csv();
        return _type;
    }

}
