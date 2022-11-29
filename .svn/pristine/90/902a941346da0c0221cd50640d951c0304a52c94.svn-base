package tea.entity.node;

import java.math.BigDecimal;
import java.util.*;
import java.sql.SQLException;
import tea.db.DbAdapter;
import tea.entity.*;

//购物车里的项
public class Buy extends Entity
{
    private static Cache _cache = new Cache(100);
    public static final int BUY_PENDING = 0; // 在购物车中
    public static final int BUY_PENDING_BG = 1;
    public static final int BUY_PROCESSED = 2;
    private int _nBuy;
    private int _nNode;
    private RV _rv;
    private int _nStatus;
    private Date _time;
    private int _nCurrency;
    private BigDecimal _bdPrice;
    private BigDecimal list;
    private int _nQuantity;
    private int _nNodex;
    private boolean _blLoaded;
    private int commodity;
    private String community;

    public RV getMember() throws SQLException
    {
        load();
        return _rv;
    }

    public static int countBuys(RV rv, String community) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.getInt("SELECT COUNT(DISTINCT(b.buy)) FROM Buy b INNER JOIN Node n ON b.node=n.node WHERE n.community=" + DbAdapter.cite(community) + " AND b.rmember=" + DbAdapter.cite(rv._strR) + " AND b.vmember=" + DbAdapter.cite(rv._strV) + " AND b.status=" + 0);
        } finally
        {
            db.close();
        }
        return i;
    }
    //电话订购 生成在购物车的商品添加
        public static int create(String community, String rmember, int node, int commodity, int currency, int quantity,String lurumember) throws SQLException
        {
                int i1 = 0;
               Date  time =new Date();
                DbAdapter db = new DbAdapter();
                try
                {
                        db.executeUpdate("INSERT INTO Buy (community,rmember,vmember,node,commodity,currency,quantity,status,time,lurumember) VALUES (" + DbAdapter.cite(community) + ", " + DbAdapter.cite(rmember) + ", " + DbAdapter.cite(rmember) + ", " + node + ", " + commodity + "," + currency + "," + quantity + ",0,"
                                        + DbAdapter.cite(time)+ ","+db.cite(lurumember)+")");
                        i1 = db.getInt("SELECT @@IDENTITY");
                }  finally
                {
                        db.close();
                }
                return i1;
        }


    public static BigDecimal sumBuys(RV rv, String community, int currency) throws SQLException
    {
        BigDecimal bd = BigDecimal.ZERO;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT b.commodity,b.quantity FROM Buy b INNER JOIN Node n ON b.node=n.node WHERE n.community=" + DbAdapter.cite(community) + " AND b.rmember=" + DbAdapter.cite(rv._strR) + " AND b.vmember=" + DbAdapter.cite(rv._strV) + " AND b.status=0 AND b.currency=" + currency);
            while (db.next())
            {
                BuyPrice bp = BuyPrice.find(db.getInt(1), db.getInt(2));
                if (bp.getPrice() != null)
                {
                    bd = bd.add(bp.getPrice().multiply(db.getBigDecimal(2, 0)));
                }
            }
        } finally
        {
            db.close();
        }
        return bd;
    }

    // 查找货币种类
    public static Enumeration findCarts(RV rv, String community, int status) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT n.rcreator, b.currency  FROM Node n INNER JOIN Buy b ON n.node=b.node WHERE n.community=" + DbAdapter.cite(community) + " AND b.rmember=" + DbAdapter.cite(rv._strR) + " AND b.vmember=" + DbAdapter.cite(rv._strV) + " AND b.status=" + status
                            + " GROUP BY n.rcreator, b.currency ");
            Cart cart;
            for (; db.next(); v.addElement(cart))
            {
                cart = new Cart();
                cart._strVendor = db.getString(1);
                cart._nCurrency = db.getInt(2);
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    // 修改数量
    public void set(int i) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Buy SET quantity=" + i + " WHERE buy=" + _nBuy);
        } finally
        {
            db.close();
        }
        _nQuantity = i;
    }

    private Buy(int i)
    {
        _nBuy = i;
        _blLoaded = false;
    }

    public static int create(String community, RV rv, int node, int commodity, int currency, BigDecimal price, int quantity) throws SQLException
    {
        int i1 = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Buy (community,rmember,vmember,node,commodity,currency,price,quantity,status,time) VALUES (" + DbAdapter.cite(community) + ", " + DbAdapter.cite(rv._strR) + ", " + DbAdapter.cite(rv._strV) + ", " + node + ", " + commodity + "," + currency + "," + price + "," + quantity + ",0," + db.citeCurTime() + ")");
            i1 = db.getInt("SELECT MAX(buy) FROM Buy");
        } finally
        {
            db.close();
        }
        return i1;
    }

    public int getNode() throws SQLException
    {
        load();
        return _nNode;
    }

    public int getNodex() throws SQLException
    {
        load();
        return _nNodex;
    }

    public Date getTime() throws SQLException
    {
        load();
        return _time;
    }

    public BigDecimal getPrice() throws SQLException
    {
        load();
        return _bdPrice;
    }

    public BigDecimal getList() throws SQLException
    {
        load();
        return list;
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
                db.executeQuery("SELECT community,rmember,vmember,node,commodity,currency,price,quantity,status,time FROM Buy WHERE buy=" + _nBuy);
                if (db.next())
                {
                    community = db.getString(1);
                    _rv = new RV(db.getString(2), db.getString(3));
                    _nNode = db.getInt(4);
                    commodity = db.getInt(5);
                    _nCurrency = db.getInt(6);
                    _bdPrice = db.getBigDecimal(7, 2);
                    _nQuantity = db.getInt(8);
                    _nStatus = db.getInt(9);
                    _time = db.getDate(10);
                }
            } finally
            {
                db.close();
            }
            _blLoaded = true;
        }
    }

    public int getStatus() throws SQLException
    {
        load();
        return _nStatus;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Buy WHERE buy=" + _nBuy + " AND( status=0 OR status=1 )");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(_nBuy));
    }

    public static Buy find(int i)
    {
        Buy buy = (Buy) _cache.get(new Integer(i));
        if (buy == null)
        {
            buy = new Buy(i);
            _cache.put(new Integer(i), buy);
        }
        return buy;
    }

    // 查找是否存在相同的商品
    public static int find(RV rv, int node, int commodity, int currency) throws SQLException
    {
        int buy = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT buy FROM Buy WHERE rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV) + " AND node=" + node + " AND commodity=" + commodity + " AND currency=" + currency + " AND status=0");
            if (db.next())
            {
                buy = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return buy;
    }
    public static int find(RV rv, int node) throws SQLException
       {
           int buy = 0;
           DbAdapter db = new DbAdapter();
           try
           {
               db.executeQuery("SELECT buy FROM Buy WHERE rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV) + " AND node=" + node );
               if (db.next())
               {
                   buy = db.getInt(1);
               }
           } finally
           {
               db.close();
           }
           return buy;
    }
    public static Enumeration find(int i, RV rv) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT buy  FROM Buy  WHERE node=" + i + " AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV) + " ORDER BY time DESC ");
            while (db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static Enumeration find(int i, String s) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT rmember, vmember, lasttime=MAX(time), sumquantity=SUM(quantity)  FROM Buy  WHERE node=" + i + " AND status=" + 2 + " GROUP BY rmember, vmember " + " ORDER BY " + s);
            BuyGroup buygroup;
            for (; db.next(); vector.addElement(buygroup))
            {
                buygroup = new BuyGroup();
                buygroup._rv = new RV(db.getString(1), db.getString(2));
                buygroup._lastTime = db.getDate(2);
                buygroup._nSumQuantity = db.getInt(3);
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    // 购物车中的商品
    public static Enumeration findInCart(Cart cart, RV rv, int status) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT buy FROM Buy WHERE node IN(SELECT node FROM Node WHERE rcreator=" + DbAdapter.cite(cart._strVendor) + " ) " + " AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV) + " AND currency=" + cart._nCurrency + " AND status=" + status
                            + " ORDER BY time ");
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

    public static Enumeration findBuys(RV rv, String community) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT(b.buy) FROM Buy b INNER JOIN Node n ON b.node=n.node WHERE n.community=" + DbAdapter.cite(community) + " AND b.rmember=" + DbAdapter.cite(rv._strR) + " AND b.vmember=" + DbAdapter.cite(rv._strV) + " AND b.status=" + 0);
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

    public int getCurrency() throws SQLException
    {
        return _nCurrency;
    }

    public int getCommodity() throws SQLException
    {
        load();
        return commodity;
    }

    public String getCommunity()
    {
        return community;
    }
}
