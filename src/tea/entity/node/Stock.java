package tea.entity.node;

import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.ui.*;
import tea.entity.*;
import java.text.SimpleDateFormat;

public class Stock
{
    protected static Cache c = new Cache(50);
    public int node; //节点号
    public String code; //股票代码

    public Stock(int node)
    {
        this.node = node;
    }

    public static Stock find(int node) throws SQLException
    {
        Stock t = (Stock) c.get(node);
        if(t == null)
        {
            ArrayList al = find(" AND node=" + node,0,1);
            t = al.size() < 1 ? new Stock(node) : (Stock) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT node,code FROM stock WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Stock t = new Stock(rs.getInt(i++));
                t.code = rs.getString(i++);
                if(t.code.length() == 5)
                    t.prefix = "hk";
                else if(t.code.length() == 6)
                    t.prefix = t.code.charAt(0) == '6' ? "sh" : "sz"; //6上海
                c.put(t.node,t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM stock WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate("INSERT INTO stock(node,code)VALUES(" + node + "," + DbAdapter.cite(code) + ")");
            if(i < 1)
            {
                db.executeUpdate("UPDATE stock SET node=" + node + ",code=" + DbAdapter.cite(code) + " WHERE node=" + node);
            }
        } finally
        {
            db.close();
        }
        c.remove(node);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM stock WHERE node=" + node);
        c.remove(node);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE stock SET " + f + "=" + DbAdapter.cite(v) + " WHERE node=" + node);
        c.remove(node);
    }

//	java.math.BigDecimal bd = obj.getChangePercent();
//	if(bd.doubleValue() > 0)
//	{
//		value = "<FONT color=\"#FF0000\">" + df.format(bd) + "</FONT>";
//	} else
//	{
//		value = "<FONT color=\"#00FF00\">" + df.format(bd) + "</FONT>";
//	}
    //
    public String prefix;
    public static void start()
    {
        new Thread()
        {
            public void run()
            {
                while(true)
                {
                    try
                    {
                        this.sleep(1000 * 60 * 20);
                        Calendar c = Calendar.getInstance();
                        if(c.get(c.HOUR_OF_DAY) > 16)
                            continue;
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
                        Iterator it = Stock.find(" AND code!=''",0,Integer.MAX_VALUE).iterator();
                        while(it.hasNext())
                        {
                            Stock t = (Stock) it.next();
                            String h = (String) Entity.open("http://qt.gtimg.cn/r=" + Math.random() + "&q=" + (t.prefix.equals("hk") ? "r_" : "") + t.prefix + t.code);
                            String[] arr = h.split("~");
                            Date time = sdf.parse(arr[30].replaceAll("[-/ :]",""));
                            String name = arr[1];
                            float closing = Float.parseFloat(arr[4]);
                            float opening = Float.parseFloat(arr[5]);
                            float high = Float.parseFloat(arr[33]);
                            float low = Float.parseFloat(arr[34]);
                            float price = Float.parseFloat(arr[3]);
                            float change = Float.parseFloat(arr[32]);
                            int volume = Integer.parseInt(arr[36]);
                            StockList.find(t.node,time).set(t.node,time,name,closing,opening,high,low,price,change,volume,"");
                        }
                    } catch(Exception ex)
                    {
                        ex.printStackTrace();
                    }
                }
            }
        }.start();
    }

    public static String getDetail(Node node,Http h,int listing,String target) throws SQLException
    {
        boolean flag = false;
        StringBuilder sb = new StringBuilder();
        Stock t = Stock.find(node._nNode);
        ListingDetail detail = ListingDetail.find(listing,15,h.language);
        Iterator e = detail.keys();
        while(e.hasNext())
        {
            String itemname = (String) e.next(),value = null;
            int istype = detail.getIstype(itemname);
            if(istype == 0)
            {
                continue;
            }
            if(itemname.equals("subject"))
            {
                value = (node.getSubject(h.language));
            } else if(itemname.equals("code"))
            {
                value = MT.f(t.code);
            } else if(itemname.equals("graphhour"))
            {
                value = "<img src='" + ("hk".equals(t.prefix) ? "http://image.sinajs.cn/newchart/hk_stock/min/" + t.code + ".gif" : "http://image2.sinajs.cn/newchart/min/n/" + t.prefix + t.code + ".gif") + "'/>";
            } else if(itemname.equals("graphday"))
            {
                value = "<img src='" + ("hk".equals(t.prefix) ? "http://image.sinajs.cn/newchart/hk_stock/daily/" + t.code + ".gif" : "http://image2.sinajs.cn/newchart/daily/n/" + t.prefix + t.code + ".gif") + "'/>";
            } else if(itemname.equals("graphweek"))
            {
                value = "<img src='" + ("hk".equals(t.prefix) ? "http://image.sinajs.cn/newchart/hk_stock/weekly/" + t.code + ".gif" : "http://image2.sinajs.cn/newchart/weekly/n/" + t.prefix + t.code + ".gif") + "'/>";
            } else if(itemname.equals("graphmonth"))
            {
                value = "<img src='" + ("hk".equals(t.prefix) ? "http://image.sinajs.cn/newchart/hk_stock/monthly/" + t.code + ".gif" : "http://image2.sinajs.cn/newchart/monthly/n/" + t.prefix + t.code + ".gif") + "'/>";
            } else if(itemname.equals("handicap"))
            {
                value = "<table cellspacing='0' cellpadding='0'><tr><td>卖⑤</td><td>--</td><td align='right'>--</td></tr><tr><td>卖④</td><td>--</td><td align='right'>--</td></tr><tr><td>卖③</td><td>--</td><td align='right'>--</td></tr><tr><td>卖②</td><td>--</td><td align='right'>--</td></tr><tr><td>卖①</td><td>--</td><td align='right'>--</td></tr><tr id='currentprice' sizset='371'><td>成交</td><td>--</td><td align='right'> </td></tr><tr><td>买①</td><td>--</td><td align='right'>--</td></tr><tr><td>买②</td><td>--</td><td align='right'>--</td></tr><tr><td>买③</td><td>--</td><td align='right'>--</td></tr><tr><td>买④</td><td>--</td><td align='right'>--</td></tr><tr><td>买⑤</td><td>--</td><td align='right'>--</td></tr></table>";
            } else if(itemname.equals("search"))
            {
                value = ("<include src=\"/jsp/type/stock/StockDetail_search.jsp\"/>");
            } else
            {
                flag = true;
                value = "--";
            }
            if(detail.getAnchor(itemname) != 0)
                value = "<a href='/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/stock/" + node._nNode + "-" + h.language + ".htm' target='" + target + "'>" + value + "</a>";
            sb.append(detail.getBeforeItem(itemname)).append("<span id='" + t.prefix + t.code + "_" + itemname + "'>").append(value).append("</span>").append(detail.getAfterItem(itemname));
        }
        if(flag)
            sb.append("<script src='/jsp/type/stock/Refresh.jsp?node=" + t.node + "'></script>");
        return sb.toString();
    }

}
