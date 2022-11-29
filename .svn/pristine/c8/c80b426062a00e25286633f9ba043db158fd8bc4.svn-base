package tea.entity.admin.office;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Cachet
{
    private static Cache _cache = new Cache(100);
    private int cachet;
    private String community;
    private String name;
    private String type;
    private String password;
    private boolean esp; //false:图片,true:ESP章
    private String picture;
    private int sequence;
    private Date time;
    private boolean exists;

    public Cachet(int cachet) throws SQLException
    {
        this.cachet = cachet;
        load();
    }

    public static Cachet find(int cachet) throws SQLException
    {
        Cachet obj = (Cachet) _cache.get(new Integer(cachet));
        if(obj == null)
        {
            obj = new Cachet(cachet);
            _cache.put(new Integer(cachet),obj);
        }
        return obj;
    }

    public static void create(String community,String name,String type,String password,boolean esp,String picture) throws SQLException
    {
        int sequence = (int) (System.currentTimeMillis() / 1000);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Cachet (community,name,type,password,esp,picture,sequence,time)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(type) + "," + DbAdapter.cite(password) + "," + db.cite(esp) + "," + DbAdapter.cite(picture) + "," + sequence + "," + db.citeCurTime() + ")");
        } finally
        {
            db.close();
        }
    }

    public void set(String name,String type,String password,String picture) throws SQLException
    {
        StringBuffer sb = new StringBuffer();
        sb.append("UPDATE Cachet SET name=").append(DbAdapter.cite(name));
        sb.append(",type=").append(DbAdapter.cite(type));
        if(picture != null)
        {
            sb.append(",password=").append(DbAdapter.cite(password)); //密码和文件必须同时被修改
            this.password = password;
            sb.append(",picture=").append(DbAdapter.cite(picture));
            this.picture = picture;
        }
        sb.append(" WHERE cachet=").append(cachet);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sb.toString());
        } finally
        {
            db.close();
        }
        this.name = name;
        this.type = type;
    }

    public void setSequence(int sequence) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Cachet SET sequence=" + sequence + " WHERE cachet=" + cachet);
        } finally
        {
            db.close();
        }
        this.sequence = sequence;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Cachet WHERE cachet=" + cachet);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(cachet));
    }

    public static int count(String community,String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM Cachet WHERE community=" + db.cite(community) + sql);
            while(db.next())
            {
                i = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return i;
    }

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT cachet FROM Cachet WHERE community=" + db.cite(community) + sql + " ORDER BY sequence");
            for(int k = 0;k < pos + size && db.next();k++)
            {
                if(k >= pos)
                {
                    v.addElement(new Integer(db.getInt(1)));
                }
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,name,type,password,esp,picture,sequence,time FROM Cachet WHERE cachet=" + cachet);
            if(db.next())
            {
                community = db.getString(1);
                name = db.getString(2);
                type = db.getString(3);
                password = db.getString(4);
                esp = db.getInt(5) != 0;
                picture = db.getString(6);
                sequence = db.getInt(7);
                time = db.getDate(8);
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

    public String getType()
    {
        return type;
    }

    public Date getTime()
    {
        return time;
    }

    public String getName()
    {
        return name;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getCachet()
    {
        return cachet;
    }

    public String getPicture()
    {
        return picture;
    }

    public int getSequence()
    {
        return sequence;
    }

    public boolean isEsp()
    {
        return esp;
    }

    public String getPassword()
    {
        return password;
    }
}
