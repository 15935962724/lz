package tea.entity.admin.erp.icard;

import java.sql.SQLException;
import java.util.*;
import tea.db.*;

//卡类型管理
public class ICardType
{
    public static String MODE_TYPE[] =
            {"-----------","会员储值","会员卡","储值卡"};
    int icardtype;
    String community;
    String name; //卡类型名
    int modes; //运行模式
    float integral; //积分
    int discount; //折扣
    Date time; //最后一次修改日期
    int lstypeid;//分店类型
    boolean exists;
    public ICardType(int icardtype) throws SQLException
    {
        this.icardtype = icardtype;
        load();
    }

    public static ICardType find(int icardtype) throws SQLException
    {
        return new ICardType(icardtype);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,name,modes,integral,discount,lstypeid FROM ICardType WHERE icardtype=" + icardtype);
            if(db.next())
            {
                community = db.getString(1);
                name = db.getString(2);
                modes = db.getInt(3);
                integral = db.getFloat(4);
                discount = db.getInt(5);
                lstypeid=db.getInt(6);
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

    public static void create(String community,String name,int modes,float integral,int discount,int lstypeid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO ICardType(community,name,modes,integral,discount,time,lstypeid)VALUES(" + db.cite(community) + "," + db.cite(name) + "," + modes + "," +
            		"" + integral + "," + discount + "," + db.cite(new Date()) + ","+lstypeid+")");
        } finally
        {
            db.close();
        }
    }

    public void set(String name,int modes,float integral,int discount,int lstypeid) throws SQLException
    {
        time = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE ICardType SET name=" + db.cite(name) + ",modes=" + modes + ",integral=" + integral + ",discount=" + discount + ",time=" + db.cite(time) + ",lstypeid="+lstypeid+" WHERE icardtype=" + icardtype);
        } finally
        {
            db.close();
        }
        this.name = name;
        this.modes = modes;
        this.integral = integral;
        this.discount = discount;
        this.lstypeid =lstypeid;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM ICardType WHERE icardtype=" + icardtype);
        } finally
        {
            db.close();
        }
    }

    public static int count(String community,String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM ICardType WHERE community= " + db.cite(community) + sql);
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

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT icardtype FROM ICardType WHERE community= " + db.cite(community) + sql,pos,size);
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

    public static String toHtml(String community,int dv) throws SQLException
    {
        StringBuilder h = new StringBuilder();
        h.append("<select name='icardtype'><option value=''>--------------");
        Enumeration e = find(community,"",0,200);
        while(e.hasMoreElements())
        {
            int id = ((Integer) e.nextElement()).intValue();
            h.append("<option value='").append(id).append("'");
            if(dv == id)
            {
                h.append(" selected='true'");
            }
            h.append(">").append(ICardType.find(id).getName());
        }
        h.append("</select>");
        return h.toString();
    }

    public int getICardType()
    {
        return icardtype;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getDiscount()
    {
        return discount;
    }

    public boolean isExists()
    {
        return exists;
    }

    public float getIntegral()
    {
        return integral;
    }

    public int getMode()
    {
        return modes;
    }

    public String getName()
    {
        return name;
    }
    public int getLstypeid()
    {
    	return lstypeid;
    }


}
