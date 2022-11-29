package tea.entity.node;

import java.io.*;
import java.math.*;
import java.util.*;
import java.sql.SQLException;
import tea.entity.admin.*;
import tea.db.*;
import tea.entity.*;

public class BuyPrice extends Entity implements Serializable
{
    private int commodity;
    private int _nCurrency;
    private BigDecimal _bdSupply;
    private BigDecimal _bdList;
    private BigDecimal _bdPrice;
    private BigDecimal _bdPrice1; // 1级代理商价格
    private BigDecimal _bdPrice2; // 2级代理商价格
    private BigDecimal _bdPrice3; // 3级代理商价格
    private int _nOptions;
    private BigDecimal _bdPoint;
    private int _nConvertCurrency;
    private boolean _blLoaded;
    private static Cache _cache = new Cache(100);
    private boolean exists;

    public void set(BigDecimal _bdSupply,BigDecimal _bdList,BigDecimal _bdPrice,BigDecimal _bdPrice1,BigDecimal _bdPrice2,BigDecimal _bdPrice3,int _nOptions,BigDecimal _bdPoint,int _nConvertCurrency) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.executeUpdate("UPDATE BuyPrice SET supply=" + _bdSupply + ",  list=" + _bdList + ",  price=" + _bdPrice + ",price1=" + _bdPrice1 + ",price2=" + _bdPrice2 + ",price3=" + _bdPrice3 + ", options=" + _nOptions + ",  point=" + _bdPoint + ", convertcurrency=" + _nConvertCurrency + " WHERE commodity=" + commodity + "  AND currency=" + _nCurrency + "");
        } finally
        {
            db.close();
        }
        if(j < 1)
        {
            create(commodity,_nCurrency,_bdSupply,_bdList,_bdPrice,_bdPrice1,_bdPrice2,_bdPrice3,_nOptions,_bdPoint,_nConvertCurrency);
            exists = true;
        }
        this._bdSupply = _bdSupply;
        this._bdList = _bdList;
        this._bdPrice = _bdPrice;
        this._bdPrice1 = _bdPrice1;
        this._bdPrice2 = _bdPrice2;
        this._bdPrice3 = _bdPrice3;
        this._nOptions = _nOptions;
        this._bdPoint = _bdPoint;
        this._nConvertCurrency = _nConvertCurrency;
    }

    private BuyPrice(int commodity,int _nCurrency)
    {
        this.commodity = commodity;
        this._nCurrency = _nCurrency;
        _blLoaded = false;
        exists = false;
    }

    public static void create(int commodity,int currency,BigDecimal supply,BigDecimal list,BigDecimal price,BigDecimal price1,BigDecimal price2,BigDecimal price3,int options,BigDecimal point,int convertcurrency) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO BuyPrice (commodity, currency, supply, list, price,price1,price2,price3, options, point, convertcurrency) VALUES (" + commodity + ", " + currency + ", " + supply + ", " + list + ", " + price + "," + price1 + "," + price2 + "," + price3 + ", " + options + ", " + point + ", " + convertcurrency + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(commodity + ":" + currency);
    }

    public BigDecimal getList() throws SQLException
    {
        load();
        return _bdList;
    }

    public BigDecimal getEPrice() throws SQLException
    {
        load();
        BigDecimal pd = _bdPrice;
        Commodity c = Commodity.find(commodity);
        Goods g = Goods.find(c.getGoods());
        long lo = System.currentTimeMillis();
        SupplierBrandDiscounts sbd = SupplierBrandDiscounts.find(c.getSupplier(),g.getBrand());
        if(sbd.getDiscounts() > 0F && sbd.getStartTime().getTime() < lo && sbd.getStopTime().getTime() > lo) // 打折后的价格
        {
            BigDecimal temp = new BigDecimal(sbd.getDiscounts()).divide(new BigDecimal(10),4);
            pd = _bdList.multiply(temp).setScale(2,4);
            // pd.floatValue()*(/10F)
        }
        return pd;
    }

    public BigDecimal getPrice() throws SQLException
    {
        load();
        return _bdPrice;
    }

    public BigDecimal getPrice1() throws SQLException
    {
        load();
        return _bdPrice1;
    }

    public BigDecimal getPrice2() throws SQLException
    {
        load();
        return _bdPrice2;
    }

    public BigDecimal getPrice3() throws SQLException
    {
        load();
        return _bdPrice3;
    }

    public BigDecimal getPoint() throws SQLException
    {
        load();
        return _bdPoint;
    }

    public int getOptions() throws SQLException
    {
        load();
        return _nOptions;
    }

    public int getConvertCurrency() throws SQLException
    {
        load();
        return _nConvertCurrency;
    }

    private void load() throws SQLException
    {
        if(!_blLoaded)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT supply,list,price,options,point,convertcurrency,price1,price2,price3 FROM BuyPrice WHERE commodity=" + commodity + " AND currency=" + _nCurrency);
                if(db.next())
                {
                    _bdSupply = db.getBigDecimal(1,2);
                    _bdList = db.getBigDecimal(2,2);
                    _bdPrice = db.getBigDecimal(3,2);
                    _nOptions = db.getInt(4);
                    _bdPoint = db.getBigDecimal(5,2);
                    _nConvertCurrency = db.getInt(6);
                    _bdPrice1 = db.getBigDecimal(7,2);
                    _bdPrice2 = db.getBigDecimal(8,2);
                    _bdPrice3 = db.getBigDecimal(9,2);
                    exists = true;
                } else
                {
                    exists = false;
                }
                if(_bdPoint == null)
                {
                    _bdPoint = BigDecimal.ZERO;
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
            db.executeUpdate("DELETE FROM BuyPrice WHERE commodity=" + commodity + " AND currency=" + _nCurrency);
        } finally
        {
            db.close();
        }
        _cache.remove(commodity + ":" + _nCurrency);
    }

    public static BuyPrice find(int _nCommodity,int _nCurrency)
    {
        BuyPrice buyprice = (BuyPrice) _cache.get(_nCommodity + ":" + _nCurrency);
        if(buyprice == null)
        {
            buyprice = new BuyPrice(_nCommodity,_nCurrency);
            _cache.put(_nCommodity + ":" + _nCurrency,buyprice);
        }
        return buyprice;
    }

    public static Enumeration find(int commodity) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT currency FROM BuyPrice WHERE commodity=" + commodity);
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

    public void set(BigDecimal _bdList,BigDecimal _bdPrice) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE BuyPrice SET list=" + _bdList + ",price=" + _bdPrice + " WHERE commodity=" + commodity + "  AND currency=" + _nCurrency);
        } finally
        {
            db.close();
        }
        this._bdList = _bdList;
        this._bdPrice = _bdPrice;
    }

    public BigDecimal getSupply() throws SQLException
    {
        load();
        return _bdSupply;
    }

    public boolean isExists() throws SQLException
    {
        load();
        return exists;
    }
}
