package tea.entity.cio;


import java.sql.*;

import tea.db.*;
import tea.entity.*;

public class CioCustomList extends Entity
{
    private int id;
    private String community;
    private String showlist;
    private String changelist;
    private String pagelist;
    private boolean exists;

    public static CioCustomList find(int id) throws SQLException
    {
        return new CioCustomList(id);
    }

    public CioCustomList(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static CioCustomList find(String pagelist) throws SQLException
    {
        return new CioCustomList(pagelist);
    }

    public CioCustomList(String pagelist) throws SQLException
    {
        this.pagelist = pagelist;
        load_list();
    }


    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id,community,showlist,changelist,pagelist from CioCustomList where id=" + id);
            if(db.next())
            {
                id = db.getInt(1);
                community = db.getString(2);
                showlist = db.getString(3);
                changelist = db.getString(4);
                pagelist = db.getString(5);
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

    public void load_list() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id,community,showlist,changelist,pagelist  from CioCustomList where pagelist=" + pagelist);
            if(db.next())
            {
                id = db.getInt(1);
                community = db.getString(2);
                showlist = db.getString(3);
                changelist = db.getString(4);
                pagelist = db.getString(5);
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


    public static void create(String community,String showlist,String changelist,String pagelist) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into CioCustomList (community,showlist,changelist,pagelist)values(" + db.cite(community) + "," + db.cite(showlist) + "," + db.cite(changelist) + "," + db.cite(pagelist) + ")");
        } finally
        {
            db.close();
        }
    }

    public static String Csvcheckbox(String str,int values,String hipid)
    {
        boolean falg = false;

        if(falg && str.length() > 0)
        {
            String charflag[] = str.split(",");
            if(charflag != null)
            {
                for(int i = 0;i < charflag.length;i++)
                {
                    if(Integer.parseInt(charflag[i]) == values)
                    {
                        return "checked=checked";
                    }
                }
            }
        }
        return "";
    }

    public static void set(int id,String community,String showlist,String changelist,String pagelist) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update CioCustomList set showlist=" + db.cite(showlist) + ",changelist=" + db.cite(changelist) + " where pagelist=" + db.cite(pagelist) + " and id=" + id);
        } finally
        {
            db.close();
        }
    }

    public static String Setlist(String listname,String pagelist,String listnum) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update CioCustomlist set " + listname + "=" + db.cite(listnum) + " where pagelist=" + db.cite(pagelist));
        } finally
        {
            db.close();
        }
        return "";
    }

    public String getChangelist()
    {
        return changelist;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getId()
    {
        return id;
    }

    public String getPagelist()
    {
        return pagelist;
    }

    public String getShowlist()
    {
        return showlist;
    }

    public boolean isExists()
    {
        return exists;
    }
}
