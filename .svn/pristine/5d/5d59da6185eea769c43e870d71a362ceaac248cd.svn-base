package tea.entity.site;

import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class Frame
{
    private static Cache _cache = new Cache(100);
    private String community;
    private String beforeheader;
    private String afterheader;
    private String beforebody1;
    private String afterbody1;
    private String beforebody2;
    private String afterbody2;
    private String beforebody3;
    private String afterbody3;
    private String beforefooter;
    private String afterfooter;

    public Frame(String community) throws SQLException
    {
        this.community = community;
        loadBasic();
    }

    public static Frame find(String community) throws SQLException
    {
        Frame obj = (Frame) _cache.get(community);
        if (obj == null)
        {
            obj = new Frame(community);
            _cache.put(community, obj);
        }
        return obj;
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT beforeheader,afterheader ,beforebody1 ,afterbody1  ,beforebody2 ,afterbody2  ,beforebody3 ,afterbody3  ,beforefooter,afterfooter  FROM Frame WHERE community=" + DbAdapter.cite(community));
            if (db.next())
            {
                beforeheader = db.getString(1);
                afterheader = db.getString(2);
                beforebody1 = db.getString(3);
                afterbody1 = db.getString(4);
                beforebody2 = db.getString(5);
                afterbody2 = db.getString(6);
                beforebody3 = db.getString(7);
                afterbody3 = db.getString(8);
                beforefooter = db.getString(9);
                afterfooter = db.getString(10);
            } else
            {
                beforeheader = "<div id=\"Body\"><div id=\"Header\">";
                afterheader = "</div>\r\n<div id=\"Content\">";
                beforebody1 = "<div id=\"Content1\">";
                afterbody1 = "</div>\r\n";
                beforebody2 = "<div id=\"Content2\">";
                afterbody2 = "</div>\r\n";
                beforebody3 = "<div id=\"Content3\">";
                afterbody3 = "</div>\r\n";
                beforefooter = "</div>\r\n<div id=\"Footer\">";
                afterfooter = "</div>\r\n</div>\r\n";
            }
        } finally
        {
            db.close();
        }
    }

    public void set(String beforeheader, String afterheader, String beforebody1, String afterbody1, String beforebody2, String afterbody2, String beforebody3, String afterbody3, String beforefooter, String afterfooter) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community FROM Frame WHERE community=" + DbAdapter.cite(community));
            if (db.next())
            {
                db.executeUpdate("UPDATE Frame SET beforeheader=" + DbAdapter.cite(beforeheader) + ",afterheader =" + DbAdapter.cite(afterheader) + " ,beforebody1 =" + DbAdapter.cite(beforebody1) + " ,afterbody1  =" + DbAdapter.cite(afterbody1) + "  ,beforebody2 =" + DbAdapter.cite(beforebody2) + " ,afterbody2  =" + DbAdapter.cite(afterbody2) + "  ,beforebody3 =" + DbAdapter.cite(beforebody3) + " ,afterbody3  =" + DbAdapter.cite(afterbody3) + "  ,beforefooter="
                                 + DbAdapter.cite(beforefooter) + ",afterfooter =" + DbAdapter.cite(afterfooter) + "  WHERE community=" + DbAdapter.cite(community));
            } else
            {
                db.executeUpdate("INSERT INTO Frame(community, beforeheader, afterheader , beforebody1 , afterbody1  , beforebody2 , afterbody2  , beforebody3 , afterbody3  , beforefooter, afterfooter )VALUES (" + DbAdapter.cite(community) + ", " + DbAdapter.cite(beforeheader) + ", " + DbAdapter.cite(afterheader) + " , " + DbAdapter.cite(beforebody1) + " , " + DbAdapter.cite(afterbody1) + "  ," + DbAdapter.cite(beforebody2) + " , " + DbAdapter.cite(afterbody2) + "  , "
                                 + DbAdapter.cite(beforebody3) + ", " + DbAdapter.cite(afterbody3) + "  , " + DbAdapter.cite(beforefooter) + ", " + DbAdapter.cite(afterfooter) + " )");
            }
        } finally
        {
            db.close();
        }
        this.beforeheader = beforeheader;
        this.afterheader = afterheader;
        this.beforebody1 = beforebody1;
        this.afterbody1 = afterbody1;
        this.beforebody2 = beforebody2;
        this.afterbody2 = afterbody2;
        this.beforebody3 = beforebody3;
        this.afterbody3 = afterbody3;
        this.beforefooter = beforefooter;
        this.afterfooter = afterfooter;
        _cache.remove(community);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Frame WHERE community=" + DbAdapter.cite(community));
        } finally
        {
            db.close();
        }
        _cache.remove(community);
    }

    public static void create(String community, String beforeheader, String afterheader, String beforebody1, String afterbody1, String beforebody2, String afterbody2, String beforebody3, String afterbody3, String beforefooter, String afterfooter) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community FROM Frame WHERE community=" + DbAdapter.cite(community));
            if (db.next())
            {
                db.executeUpdate("UPDATE Frame SET beforeheader=" + DbAdapter.cite(beforeheader) + ",afterheader =" + DbAdapter.cite(afterheader) + " ,beforebody1 =" + DbAdapter.cite(beforebody1) + " ,afterbody1  =" + DbAdapter.cite(afterbody1) + "  ,beforebody2 =" + DbAdapter.cite(beforebody2) + " ,afterbody2  =" + DbAdapter.cite(afterbody2) + "  ,beforebody3 =" + DbAdapter.cite(beforebody3) + " ,afterbody3  =" + DbAdapter.cite(afterbody3) + "  ,beforefooter="
                                 + DbAdapter.cite(beforefooter) + ",afterfooter =" + DbAdapter.cite(afterfooter) + "  WHERE community=" + DbAdapter.cite(community));
            } else
            {
                db.executeUpdate("INSERT INTO Frame(community, beforeheader, afterheader , beforebody1 , afterbody1  , beforebody2 , afterbody2  , beforebody3 , afterbody3  , beforefooter, afterfooter )VALUES (" + DbAdapter.cite(community) + ", " + DbAdapter.cite(beforeheader) + ", " + DbAdapter.cite(afterheader) + " , " + DbAdapter.cite(beforebody1) + " , " + DbAdapter.cite(afterbody1) + "  ," + DbAdapter.cite(beforebody2) + " , " + DbAdapter.cite(afterbody2) + "  , "
                                 + DbAdapter.cite(beforebody3) + ", " + DbAdapter.cite(afterbody3) + "," + DbAdapter.cite(beforefooter) + "," + DbAdapter.cite(afterfooter) + " )");
            }
        } finally
        {
            db.close();
        }
    }

    public String getCommunity()
    {
        return community;
    }

    public String getBeforeheader()
    {
        return beforeheader;
    }

    public String getAfterheader()
    {
        return afterheader;
    }

    public String getBeforebody1()
    {
        return beforebody1;
    }

    public String getAfterbody1()
    {
        return afterbody1;
    }

    public String getBeforebody2()
    {
        return beforebody2;
    }

    public String getAfterbody2()
    {
        return afterbody2;
    }

    public String getBeforebody3()
    {
        return beforebody3;
    }

    public String getAfterbody3()
    {
        return afterbody3;
    }

    public String getBeforefooter()
    {
        return beforefooter;
    }

    public String getAfterfooter()
    {
        return afterfooter;
    }
}
