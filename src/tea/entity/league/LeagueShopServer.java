package tea.entity.league;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;


public class LeagueShopServer extends Entity
{
    private int id;
    private int lstypeid; //加盟店类型  唯美度，奥瑞拉
    private String lssname; //红宝石真情
    private String lssarea; //营业面积
    private String lssmoney; //加盟店赴约金

    public static LeagueShopServer find(int id) throws SQLException
    {
        return new LeagueShopServer(id);
    }

    public LeagueShopServer(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id,lstypeid,lssname,lssarea,lssmoney from LeagueShopServer where id=" + id);
            if(db.next())
            {
                int j = 1;
                id = db.getInt(j++);
                lstypeid = db.getInt(j++);
                lssname = db.getString(j++);
                lssarea = db.getString(j++);
                lssmoney = db.getString(j++);
            }
        } finally
        {
            db.close();
        }
    }

    public static void set(int id,int lstypeid,String lssname,String lssarea,String lssmoney) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id,lstypeid,lssname,lssarea,lssmoney from LeagueShopServer where id=" + id);
            if(db.next())
            {
                db.executeUpdate("Update LeagueShopServer set lstypeid=" + lstypeid + ",lssname=" + db.cite(lssname) + ",lssarea=" + db.cite(lssarea) + ",lssmoney=" + db.cite(lssmoney) + " where id=" + id);
            } else
            {
                db.executeUpdate("Insert into  LeagueShopServer(lstypeid,lssname,lssarea,lssmoney)values(" + lstypeid + "," + db.cite(lssname) + "," + db.cite(lssarea) + "," + db.cite(lssmoney) + ")");
            }
        } finally
        {
            db.close();
        }
    }

    public static Enumeration findByCommunity(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();

        try
        {
            db.executeQuery("SELECT id FROM LeagueShopServer WHERE 1=1 " + sql,pos,size);
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
            db.executeQuery("Select count(id) from LeagueShopServer where 1=1 " + sql);
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
            db.executeUpdate("Delete  LeagueShopServer where id= " + id);

        } finally
        {
            db.close();
        }
    }

    //判断加盟店类型是否可以被删除
    public static int pdDeletetype(int lstypeid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id from LeagueShopServer where  lstypeid=" + lstypeid);
            if(db.next())
            {
                return 0;
            } else
            {
                return 1;
            }
        } finally
        {
            db.close();
        }
    }

    public static int find(String community,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int num = 0;
        try
        {
            db.executeQuery("Select id from LeagueShopServer where 1=1 " + sql);
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

    public int getId()
    {
        return id;
    }

    public String getLssarea()
    {
        return lssarea;
    }

    public String getLssmoney()
    {
        return lssmoney;
    }

    public String getLssname()
    {
        return lssname;
    }

    public int getLstypeid()
    {
        return lstypeid;
    }


}
