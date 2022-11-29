package tea.entity.site;

import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;

public class Mark
{
    private static Cache c = new Cache(100);
    public int mark;
    public String community;
    public int type;
    public String name;
    private boolean exists;
    private Mark(int mark)
    {
        this.mark = mark;
    }

    public Mark(int mark,String community,int type,String name)
    {
        this.mark = mark;
        this.community = community;
        this.type = type;
        this.name = name;
        this.exists = true;
    }

    public static Mark find(int mark) throws SQLException
    {
        Mark t = (Mark) c.get(mark);
        if(t == null)
        {
            ArrayList e = find(" AND mark=" + mark,0,1);
            t = e.size() > 0 ? (Mark) e.get(0) : new Mark(mark);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList v = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT mark,community,type,name FROM Mark WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                Mark t = new Mark(db.getInt(1));
                t.community = db.getString(2);
                t.type = db.getInt(3);
                t.name = db.getString(4);
                c.put(t.mark,t);
                v.add(t);
            }
        } finally
        {
            db.close();
        }
        return v;
    }

    public static int count(String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM Mark WHERE 1=1" + sql);
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

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(mark,"DELETE FROM Mark WHERE mark=" + mark);
        } finally
        {
            db.close();
        }
        c.remove(mark);
    }

    public void set() throws SQLException
    {
        String sql;
        if(mark < 1)
            sql = "INSERT INTO Mark(mark,community,type,name)VALUES(" + (mark = Seq.get()) + "," + DbAdapter.cite(community) + "," + type + "," + DbAdapter.cite(name) + ")";
        else
            sql = "UPDATE Mark SET type=" + type + ",name=" + DbAdapter.cite(name) + " WHERE mark=" + mark;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(mark,sql);
        } finally
        {
            db.close();
        }
        this.type = type;
        this.name = name;
    }

    public static String toHtml(String community,int type,String dv) throws SQLException
    {
        String sql = " AND community=" + DbAdapter.cite(community);
        if(type != -1)
        {
            sql += " AND type IN(255," + type + ")";
        }
        StringBuilder h = new StringBuilder();
        ArrayList e = find(sql,0,Integer.MAX_VALUE);
        for(int i = 0;i < e.size();i++)
        {
            Mark m = (Mark) e.get(i);
            h.append("<input name='mark' type='checkbox' value='").append(m.mark).append("' id='mark").append(m.mark).append("'");
            if(dv != null && dv.indexOf("/" + m.mark + "/") != -1)
            {
                h.append(" checked='true'");
            }
            h.append("/><label for='mark").append(m.mark).append("'>").append(m.name).append("</label> ");
        }
        return h.toString();
    }


    public boolean isExists()
    {
        return exists;
    }

    public int getMark()
    {
        return mark;
    }

    public String getName()
    {
        return name;
    }

    public int getType()
    {
        return type;
    }


}
