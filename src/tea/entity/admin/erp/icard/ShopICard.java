package tea.entity.admin.erp.icard;

import java.sql.SQLException;
import java.util.*;
import tea.db.*;
import tea.entity.*;

//加盟店领卡记录
public class ShopICard extends Entity
{
    int shopicard;
    int leagueshop; //加盟店
    int icardtype; //卡类型
    int quantity; //张数
    String startcode; //起始卡号
    String endcode; //结束卡号
    Date time;
    boolean exists;
    public ShopICard(int shopicard) throws SQLException
    {
        this.shopicard = shopicard;
        load();
    }

    public static ShopICard find(int icardtype) throws SQLException
    {
        return new ShopICard(icardtype);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT leagueshop,icardtype,quantity,startcode,endcode,time FROM ShopICard WHERE shopicard=" + shopicard);
            if(db.next())
            {
                leagueshop = db.getInt(1);
                icardtype = db.getInt(2);
                quantity = db.getInt(3);
                startcode = db.getString(4);
                endcode = db.getString(5);
                time = db.getDate(6);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(int leagueshop,int icardtype,int quantity,Date time) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO ShopICard(leagueshop,icardtype,quantity,time)VALUES(" + leagueshop + "," + icardtype + "," + quantity + "," + db.cite(time) + ")");
            j = db.getInt("SELECT MAX(shopicard) FROM ShopICard");
            //记录加盟店领卡
            String startcode = null,endcode = null;
            Enumeration e = ICard.find(icardtype," AND shopicard=0",0,quantity);
            for(int i = 0;e.hasMoreElements();i++)
            {
                endcode = (String) e.nextElement();
                if(i == 0)
                {
                    startcode = endcode;
                }
                ICard.setShopICard(endcode,j);
            }
            db.executeUpdate("UPDATE ShopICard SET startcode=" + db.cite(startcode) + ",endcode=" + db.cite(endcode) + " WHERE shopicard=" + j);
        } finally
        {
            db.close();
        }

    }

//    public void set(String startcode,int mode,float integral,int discount) throws SQLException
//    {
//        DbAdapter db = new DbAdapter();
//        try
//        {
//            db.executeUpdate("UPDATE ShopICard SET name=" + db.cite(name) + ",mode=" + mode + ",integral=" + integral + ",discount=" + discount + " WHERE icardtype=" + icardtype);
//        } finally
//        {
//            db.close();
//        }
//    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM ShopICard WHERE shopicard=" + shopicard);
            db.executeUpdate("UPDATE ICard SET shopicard=0 WHERE shopicard=" + shopicard);
        } finally
        {
            db.close();
        }
    }

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT shopicard FROM ShopICard WHERE icardtype IN(SELECT icardtype FROM ICardType WHERE community=" + db.cite(community) + ")" + sql,pos,size);
            while(db.next())
            {
                v.add(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int count(String community,String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(shopicard) FROM ShopICard WHERE icardtype IN(SELECT icardtype FROM ICardType WHERE community=" + db.cite(community) + ")" + sql);
            if(db.next())
            {
                j = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return j;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        return Entity.sdf.format(time);
    }

    public String getStartCode()
    {
        return startcode;
    }

    public int getShopICard()
    {
        return shopicard;
    }

    public int getLeagueshop()
    {
        return leagueshop;
    }

    public int getQuantity()
    {
        return quantity;
    }

    public int getICardType()
    {
        return icardtype;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getEndCode()
    {
        return endcode;
    }


}
