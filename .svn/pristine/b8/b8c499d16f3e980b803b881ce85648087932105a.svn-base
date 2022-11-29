package tea.entity.league;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;


public class LeagueShopType extends Entity
{
    private int id; //id,lstypename,registered,regmember,updatedate,updatemember,community
    private String lstypename; // 唯美度，奥瑞拉名字
    private Date registered;
    private String regmember;
    private Date updatedate;
    private String updatemember;
    private String community;
    private String brands; //关联品牌
    private String bgstyle; //卡管理公告样式
    private String fgstyle; //卡前台公告样式
    public static LeagueShopType find(int id) throws SQLException
    {
        return new LeagueShopType(id);
    }


    public LeagueShopType(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id,lstypename,registered,regmember,updatedate,updatemember,community,brands,bgstyle,fgstyle FROM LeagueShopType WHERE id=" + id);
            if(db.next())
            {
                int j = 1;
                id = db.getInt(j++);
                lstypename = db.getString(j++);
                registered = db.getDate(j++);
                regmember = db.getString(j++);
                updatedate = db.getDate(j++);
                updatemember = db.getString(j++);
                community = db.getString(j++);
                brands = db.getString(j++);
                bgstyle = db.getText(j++);
                fgstyle = db.getText(j++);
            }
        } finally
        {
            db.close();
        }
    }


    public static void set(int id,String lstypename,Date registered,String regmember,Date updatedate,String updatemember,String community,String brands) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            Date date = new Date();
            db.executeQuery("Select id from LeagueShopType where id=" + id);
            if(db.next())
            {
                db.executeUpdate("Update LeagueShopType set lstypename=" + db.cite(lstypename) + ",updatedate=" + db.cite(date) + ",updatemember=" + db.cite(updatemember) + ",community=" + db.cite(community) + ",brands = " + db.cite(brands) + " where id=" + id);
            } else
            {
                db.executeUpdate("Insert into LeagueShopType (lstypename,registered,regmember,updatedate,updatemember,community,brands) values(" + db.cite(lstypename) + "," + db.cite(date) + "," + db.cite(regmember) + "," + db.cite(date) + "," + db.cite(regmember) + "," + db.cite(community) + "," + db.cite(brands) + ")");
            }
        } finally
        {
            db.close();
        }
    }

    public void set(String bgstyle,String fgstyle) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE LeagueShopType SET bgstyle=" + db.cite(bgstyle) + ",fgstyle=" + db.cite(fgstyle) + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
        this.bgstyle = bgstyle;
        this.fgstyle = fgstyle;
    }

    public static Enumeration findByCommunity(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();

        try
        {
            db.executeQuery("SELECT id FROM LeagueShopType WHERE community=" + db.cite(community) + "  " + sql,pos,size);
            while(db.next())
            {
                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int count(String community,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int num = 0;
        try
        {
            db.executeQuery("Select count(id) from LeagueShopType where 1=1 " + sql);
            if(db.next())
            {
                num = db.getInt(1);
                return num;
            } else
            {
                return num;
            }
        } finally
        {
            db.close();
        }
    }

    public static int findid(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int num = 0;
        try
        {
            db.executeQuery("Select id from LeagueShopType where 1=1 " + sql);
            if(db.next())
            {
                num = db.getInt(1);
                return num;
            } else
            {
                return num;
            }
        } finally
        {
            db.close();
        }
    }

    public static void delete(int id) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete  LeagueShopType where id=" + id);
        } finally
        {
            db.close();
        }

    }

    public String getUpdatemember()
    {
        return updatemember;
    }

    public Date getUpdatedate()
    {
        return updatedate;
    }

    public String getRegmember()
    {
        return regmember;
    }

    public Date getRegistered()
    {
        return registered;
    }

    public String getRegisteredtoString()
    {
        if(registered != null)
        {
            return LeagueShopType.df.format(registered);
        } else
        {
            return "";
        }
    }


    public String getLstypename()
    {
        return lstypename;
    }

    public int getId()
    {
        return id;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getBrands()
    {
        return brands;
    }

    public String getFgStyle()
    {
        return fgstyle;
    }

    public String getBgStyle()
    {
        return bgstyle;
    }
}
