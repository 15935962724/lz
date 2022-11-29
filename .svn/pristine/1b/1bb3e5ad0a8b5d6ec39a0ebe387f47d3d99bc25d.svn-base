package tea.entity.node;

import java.math.BigDecimal;
import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class AccessPrice extends Entity
{
    private int _nNode;
    private int _nCurrency;
    private BigDecimal _bdPrice;
    private Vector _vLayer;
    private boolean _blLoaded;
    private static Cache _cache = new Cache(100);
    public void set(BigDecimal bigdecimal) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE AccessPrice SET price=" + bigdecimal + " WHERE node=" + _nNode + " AND currency=" + _nCurrency);
        } finally
        {
            db.close();
        }
        _bdPrice = bigdecimal;
    }

    private AccessPrice(int _nNode,int _nCurrency)
    {
        this._nNode = _nNode;
        this._nCurrency = _nCurrency;
        _blLoaded = false;
    }

    public static void create(int _nNode,int _nCurrency,BigDecimal bigdecimal) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO AccessPrice (node, currency, price)VALUES(" + _nNode + ", " + _nCurrency + ", " + bigdecimal + ")");
        } finally
        {
            db.close();
        }
    }

    public BigDecimal getPrice() throws SQLException
    {
        load();
        return _bdPrice;
    }

    private void load() throws SQLException
    {
        if(!_blLoaded)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT price FROM AccessPrice WHERE node=" + _nNode + " AND currency=" + _nCurrency);
                if(db.next())
                {
                    _bdPrice = db.getBigDecimal(1,2);
                }
            } finally
            {
                db.close();
            }
            _blLoaded = true;
        }
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM AccessPrice WHERE node=" + _nNode + " AND currency=" + _nCurrency);
        } finally
        {
            db.close();
        }
        _cache.remove(_nNode + ":" + _nCurrency);
    }

    public static AccessPrice find(int _nNode,int _nCurrency)
    {
        AccessPrice accessprice = (AccessPrice) _cache.get(_nNode + ":" + _nCurrency);
        if(accessprice == null)
        {
            accessprice = new AccessPrice(_nNode,_nCurrency);
            _cache.put(_nNode + ":" + _nCurrency,accessprice);
        }
        return accessprice;
    }

    public static Enumeration find(int i) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT currency FROM AccessPrice WHERE node=" + i);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }


}
