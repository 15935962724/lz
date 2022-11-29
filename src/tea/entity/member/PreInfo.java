package tea.entity.member;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.Date;
import tea.db.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.entity.site.*;


public class PreInfo extends Entity
{
    private static Cache _cache = new Cache(100);
    private String member;
    private int count;
    private String totelNum;

    public PreInfo()
    {}

    private PreInfo(String member) throws SQLException
    {
        this.member = member;

        load();
    }

    public static PreInfo find(String member) throws SQLException
    {
        PreInfo obj = (PreInfo) _cache.get(member);
        if (obj == null)
        {
            obj = new PreInfo(member);
            _cache.put(member, obj);
        }
        return obj;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member,pronum,totelnum FROM preinfo WHERE member=" + member);
            if (db.next())
            {
                member = db.getString(1);
                count = db.getInt(2);
                totelNum = db.getString(3);
            }
        } finally
        {
            db.close();
        }
    }

    public static boolean isExist(String member) throws SQLException
    {
        boolean flag = false;

        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("select member from preinfo where member=" + db.cite(member));
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }

    public static void upInfo(String member, int count, String totelNum) throws SQLException
    {
        DbAdapter db = new DbAdapter();

        try
        {
            db.executeUpdate("update preinfo set pronum=" + count + ", totelnum=" + db.cite(totelNum) + " where member=" + db.cite(member));
        } finally
        {
            db.close();
        }
        _cache.clear();

    }

    public static String getNum(String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
String num = "";
        try
        {
            db.executeQuery("select totelnum from preinfo where member="+db.cite(member));
            while(db.next()){
                num = db.getString(1);
            }
        } finally
        {
            db.close();
        }
        return num;

    }


    public static void addInfo(String member, int count, String totelNum) throws SQLException
    {
        DbAdapter db = new DbAdapter();

        try
        {
            db.executeUpdate("insert into preinfo values(" + db.cite(member) + ", " + count + ", " + db.cite(totelNum) + ")");
        } finally
        {
            db.close();
        }
    }

    public String getMember()
    {
        return member;
    }

    public int getCount()
    {
        return count;
    }

    public String getTotelNum()
    {
        return totelNum;
    }


}
