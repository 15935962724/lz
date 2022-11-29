package tea.entity.node;

import java.math.*;
import java.util.*;
import tea.db.*;
import tea.entity.*;
import java.text.*;
import tea.html.*;
import java.sql.SQLException;

public class StockList extends Entity
{
    private static Cache _cache = new Cache(100);
    public static DecimalFormat df = new DecimalFormat("0.00");

    private int _nNode;
    private String stockName;
    private int _stockid;
    private BigDecimal _bdChangePercent;
    private int _nVolume;
    private BigDecimal _bdOpen;
    private BigDecimal _bdLow;
    private BigDecimal _bdHigh;
    private java.util.Date time;
    private float dateData;
    private float closingPrice;
    private String estockName;

    private boolean _blLoaded;

    public void set(int node,java.util.Date time,String stockname,float datedata,float openingprice,float high,float low,float closingprice,float percentchange,int volume,String estockname) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE StockList SET stockname=" + DbAdapter.cite(stockname) + ",datedata=" + datedata + ",openingprice=" + openingprice + ",high=" + (high) + ",low=" + low + ",closingprice=" + closingprice + ",percentchange=" + percentchange + ",volume=" + volume + ",estockname=" + DbAdapter.cite(estockname) + " WHERE node=" + node + " AND time=" + DbAdapter.cite(time,true));
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO StockList(node,time,stockname,datedata,openingprice,high,low,closingprice,percentchange,volume,estockname)VALUES(" + node + "," + DbAdapter.cite(time,true) + "," + DbAdapter.cite(stockname) + "," + datedata + "," + openingprice + "," + (high) + "," + low + "," + closingprice + "," + percentchange + "," + volume + "," + DbAdapter.cite(estockname) + ")");
            }
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(_stockid));
        _blLoaded = false;
    }

    private StockList(int i)
    {
        _stockid = i;
        _blLoaded = false;
    }

    private void load() throws SQLException
    {
        if(!_blLoaded)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT stockname,time,datedata,openingprice,high,low,closingprice,percentchange,volume,estockname,node FROM StockList WHERE id=" + _stockid);
                if(db.next())
                {
                    stockName = db.getVarchar(1,1,1);
                    time = db.getDate(2);
                    dateData = db.getFloat(3);
                    _bdOpen = db.getBigDecimal(4,2);
                    _bdHigh = db.getBigDecimal(5,2);
                    _bdLow = db.getBigDecimal(6,2);
                    closingPrice = db.getFloat(7);
                    _bdChangePercent = db.getBigDecimal(8,2);
                    _nVolume = db.getInt(9);
                    estockName = db.getString(10);
                    _nNode = db.getInt(11);
                }
            } finally
            {
                db.close();
            }
            _blLoaded = true;
        }
    }

    public int getVolume() throws SQLException
    {
        load();
        return _nVolume;
    }

    public int getNode() throws SQLException
    {
        load();
        return _nNode;
    }

    public BigDecimal getHigh() throws SQLException
    {
        load();
        return _bdHigh;
    }

    public BigDecimal getOpen() throws SQLException
    {
        load();
        return _bdOpen;
    }

    public BigDecimal getChangePercent() throws SQLException
    {
        load();
        return _bdChangePercent;
    }

    public BigDecimal getLow() throws SQLException
    {
        load();
        return _bdLow;
    }

    public int getId() throws SQLException
    {
        load();
        return _stockid;
    }

    public String getStockName(int language) throws SQLException
    {
        load();
        if(language == 1)
        {
            return stockName;
        } else
        {
            return estockName;
        }
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM StockList WHERE id =" + this._stockid);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(_stockid));
    }

    public static int count() throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.getInt("SELECT COUNT(symbol)  FROM StockList ");
        } finally
        {
            db.close();
        }
        return i;
    }

    public static StockList find(int _stockid)
    {
        StockList stock = (StockList) _cache.get(new Integer(_stockid));
        if(stock == null)
        {
            stock = new StockList(_stockid);
            _cache.put(new Integer(_stockid),stock);
        }
        return stock;
    }

    public static StockList find(int node,java.util.Date time) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        StringBuilder sb = new StringBuilder("SELECT id FROM StockList WHERE node=");
        sb.append(node);
        if(time != null)
        {
            sb.append(" AND time=" + DbAdapter.cite(time));
        } else
        {
            sb.append(" ORDER BY time DESC");
        }
        try
        {
            return find(db.getInt(sb.toString()));
        } finally
        {
            db.close();
        }
    }

    public static String find(int i,int j) throws SQLException
    {
        StringBuilder stringbuffer = new StringBuilder();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT symbol, suffix  FROM StockList ");
            for(int k = 0;k < i + j && db.next();k++)
            {
                if(k >= i)
                {
                    String s = db.getString(1);
                    String s1 = db.getString(2);
                    if(s.startsWith("^"))
                    {
                        stringbuffer.append(s);
                    } else
                    {
                        stringbuffer.append(s + s1);
                    }
                    stringbuffer.append("+");
                }
            }
        } finally
        {
            db.close();
        }
        return stringbuffer.toString();
    }

    public static Enumeration find() throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT distinct(stockid) from StockList");
            for(;db.next();vector.addElement(db.getString(1)))
            {
                ;
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static Vector find(int node,Date date1,Date date2) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            String sql = "SELECT id from StockList where node =" + node;
            if(date1 != null)
            {
                sql += " AND time>=" + DbAdapter.cite(date1);
            }
            if(date2 != null)
            {
                sql += " AND time<=" + DbAdapter.cite(date2);
            }
            sql += " ORDER BY time DESC";
            db.executeQuery(sql);
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector;
    }

    public static int count_s(int node,Date date1,Date date2) throws SQLException
    {
        int c_s;
        DbAdapter db = new DbAdapter();
        try
        {
            String sql = "SELECT COUNT(*) FROM StockList WHERE node=" + node;
            if(date1 != null)
            {
                sql += " AND time>=" + DbAdapter.cite(date1);
            }
            if(date2 != null)
            {
                sql += " AND time<=" + DbAdapter.cite(date2);
            }
            c_s = db.getInt(sql);
        } finally
        {
            db.close();
        }
        return c_s;
    }

//
//    public static String getDetail(Node node,int language,int listing,String target) throws SQLException
//    {
//        Span span = null;
//        StringBuilder sb = new StringBuilder();
//        Stock obj = Stock.find(node._nNode,null);
//        Stock2 obj2 = Stock2.find(node._nNode);
//        ListingDetail detail = ListingDetail.find(listing,15,language);
//        java.util.Iterator e = detail.keys();
//        while(e.hasNext())
//        {
//            String itemname = (String) e.next(),value = null;
//            int istype = detail.getIstype(itemname);
//            if(istype == 0)
//            {
//                continue;
//            }
//            if(itemname.equals("subject"))
//            {
//                value = (node.getSubject(language));
//            } else if(itemname.equals("stockname"))
//            {
//                value = (obj.getStockName(language));
//            } else if(itemname.equals("date"))
//            {
//                value = (obj.getDateToString());
//            } else if(itemname.equals("datedata"))
//            {
//                value = (String.valueOf(obj.getDateData()));
//            } else if(itemname.equals("openingprice"))
//            {
//                value = (String.valueOf(obj.getOpen()));
//            } else if(itemname.equals("high"))
//            {
//                value = (String.valueOf(obj.getHigh()));
//            } else if(itemname.equals("low"))
//            {
//                value = (String.valueOf(obj.getLow()));
//            } else if(itemname.equals("closingprice"))
//            {
//                value = (df.format(obj.getClosingPrice()));
//            } else if(itemname.equals("percentchange"))
//            {
//                java.math.BigDecimal bd = obj.getChangePercent();
//                if(bd.doubleValue() > 0)
//                {
//                    value = "<FONT color=\"#FF0000\">" + df.format(bd) + "</FONT>";
//                } else
//                {
//                    value = "<FONT color=\"#00FF00\">" + df.format(bd) + "</FONT>";
//                }
//            } else if(itemname.equals("volume"))
//            {
//                value = String.valueOf(obj.getVolume());
//            } else
//            // //////////////////////////指数////////////////////////////////////
//            if(itemname.equals("stockname2"))
//            {
//                value = (obj2.getStockName(language)); //
//            } else if(itemname.equals("datedata2"))
//            {
//                value = (String.valueOf(obj2.getdatedata()));
//            } else if(itemname.equals("openingprice2"))
//            {
//                value = (String.valueOf(obj2.getOpen()));
//            } else if(itemname.equals("high2"))
//            {
//                value = (String.valueOf(obj2.getHigh()));
//            } else if(itemname.equals("low2"))
//            {
//                value = (String.valueOf(obj2.getLow()));
//            } else if(itemname.equals("closingprice2"))
//            { // _bdclosingprice
//                value = (String.valueOf(obj2.getclosingprice()));
//            } else if(itemname.equals("percentchange2"))
//            {
//                value = (String.valueOf(obj2.getPercentchange()));
//            } else if(itemname.equals("graphweek"))
//            {
//                value = (new tea.html.Image(obj2.getGraphWeek()).toString());
//            } else if(itemname.equals("graphmonth"))
//            {
//                value = (new tea.html.Image(obj2.getGraphMonth()).toString());
//            } else if(itemname.equals("graphyear"))
//            {
//                value = (new tea.html.Image(obj2.getGraphYear()).toString());
//            } else if(itemname.equals("graphyet"))
//            {
//                value = (new tea.html.Image(obj2.getGraphYet()).toString());
//            } else if(itemname.equals("search"))
//            {
//                value = ("<include src=\"/jsp/type/stock/StockDetail_search.jsp\"/>");
//            }
//            if(detail.getAnchor(itemname) != 0)
//            {
//                Anchor anchor = new Anchor("/servlet/Stock?node=" + node._nNode + "&language=" + language,value);
//                anchor.setTarget(target);
//                span = new Span(anchor);
//            } else
//            {
//                span = new Span(value);
//            }
//            span.setId("StockID" + itemname);
//            sb.append(detail.getBeforeItem(itemname)).append(span).append(detail.getAfterItem(itemname));
//        }
//        return sb.toString();
//    }

    public Date getDate() throws SQLException
    {
        load();
        return time;
    }

    public float getDateData() throws SQLException
    {
        load();
        return dateData;
    }

    public float getClosingPrice() throws SQLException
    {
        load();
        return closingPrice;
    }

    public String getDateToString() throws SQLException
    {
        load();
        if(time == null)
        {
            return "";
        }
        return sdf.format(time);
    }

}
