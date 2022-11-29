package tea.entity.node;

import java.math.BigDecimal;
import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class BargainPrice extends Entity
{

    public void set(BigDecimal bigdecimal,BigDecimal bigdecimal1,BigDecimal bigdecimal2) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            // db.executeUpdate("BargainPriceCreate " + _nNode + ", " + _nCurrency + ", " + bigdecimal + ", " + bigdecimal1 + ", " + bigdecimal2);

            db.executeQuery("(SELECT node FROM BargainPrice WHERE node=" + _nNode + " AND currency=" + _nCurrency);
            if(db.next())
            {
                db.executeUpdate("UPDATE BargainPrice  SET supply=" + bigdecimal + ", list=" + bigdecimal1 + ",  ask=" + bigdecimal2 + " WHERE node=" + _nNode + " AND currency=" + _nCurrency + "");
            } else
            {
                db.executeUpdate("INSERT INTO BargainPrice(node, currency, supply, list, ask) VALUES (" + _nNode + ", " + _nCurrency + ", " + bigdecimal + ", " + bigdecimal1 + ", " + bigdecimal2 + ")");
            }
        } finally
        {
            db.close();
        }
        _bdSupply = bigdecimal;
        _bdList = bigdecimal1;
        _bdAsk = bigdecimal2;
    }

    public BigDecimal getAsk() throws SQLException
    {
        load();
        return _bdAsk;
    }

    private BargainPrice(int i,int j)
    {
        _nNode = i;
        _nCurrency = j;
        _blLoaded = false;
    }

    public static BargainPrice create(int i,int j,BigDecimal bigdecimal,BigDecimal bigdecimal1,BigDecimal bigdecimal2) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("BargainPriceCreate " + i + ", " + j + ", " + bigdecimal + ", " + bigdecimal1 + ", " + bigdecimal2);

            db.executeQuery("(SELECT node FROM BargainPrice WHERE node=" + i + " AND currency=" + j);
            if(db.next())
            {
                db.executeUpdate("UPDATE BargainPrice  SET supply=" + bigdecimal + ", list=" + bigdecimal1 + ",  ask=" + bigdecimal2 + " WHERE node=" + i + " AND currency=" + j + "");
            } else
            {
                db.executeUpdate("INSERT INTO BargainPrice(node, currency, supply, list, ask) VALUES (" + i + ", " + j + ", " + bigdecimal + ", " + bigdecimal1 + ", " + bigdecimal2 + ")");
            }
        } finally
        {
            db.close();
        }
        return find(i,j);
    }

    public BigDecimal getList() throws SQLException
    {
        load();
        return _bdList;
    }

    private void load() throws SQLException
    {
        if(!_blLoaded)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT supply, list, ask  FROM BargainPrice  WHERE node=" + _nNode + " AND currency=" + _nCurrency);
                while(db.next())
                {
                    _bdSupply = db.getBigDecimal(1,2);
                    _bdList = db.getBigDecimal(2,2);
                    _bdAsk = db.getBigDecimal(3,2);
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
            db.executeUpdate("DELETE FROM BargainPrice  WHERE node=" + _nNode + " AND currency=" + _nCurrency);
        } finally
        {
            db.close();
        }
        _cache.remove(_nNode + ":" + _nCurrency);
    }

    public static BargainPrice find(int i,int j)
    {
        BargainPrice bargainprice = (BargainPrice) _cache.get(i + ":" + j);
        if(bargainprice == null)
        {
            bargainprice = new BargainPrice(i,j);
            _cache.put(i + ":" + j,bargainprice);
        }
        return bargainprice;
    }

    public static Enumeration find(int i) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT currency FROM BargainPrice WHERE node=" + i);
            for(;db.next();vector.addElement(new Integer(db.getInt(1))))
            {
                ;
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public BigDecimal getSupply() throws SQLException
    {
        load();
        return _bdSupply;
    }

    private int _nNode;
    private int _nCurrency;
    private BigDecimal _bdSupply;
    private BigDecimal _bdList;
    private BigDecimal _bdAsk;
    private boolean _blLoaded;
    private static Cache _cache = new Cache(100);

}
