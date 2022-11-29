package tea.entity.member;

import java.io.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class SMSProfile extends Entity
{
    class Layer
    {
        public Layer()
        {
        }

        private String signature;
    }


    private static Cache _cache = new Cache(100);
    private String member;
    private String community;
    private boolean states = true; // false禁止发送短信
    private boolean exists;
    private boolean autor;
    private Hashtable _htLayer;
    private int code;
    private String password;


    public SMSProfile(String member, String community) throws SQLException
    {
        this.member = member;
        this.community = community;
        _htLayer = new Hashtable();
        load();
    }

    public static SMSProfile find(String member, String community) throws SQLException
    {
        SMSProfile obj = (SMSProfile) _cache.get(member + ":" + community);
        if (obj == null)
        {
            obj = new SMSProfile(member, community);
            _cache.put(member + ":" + community, obj);
        }
        return obj;
    }

    public static void create(String member, String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO SMSProfile(member,community)VALUES(" + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(member + ":" + community);
    }

    public void set(int code, String password) throws SQLException
    {
        if (!exists)
        {
            create(member, community);
        }
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE SMSProfile SET code=" + (code) + ",password=" + DbAdapter.cite(password) + getWhereSql(member, community));
        } finally
        {
            db.close();
        }
        this.code = code;
        this.password = password;
    }

    public void set(boolean states, String signature, int code, String password) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE SMSProfile SET states=" + DbAdapter.cite(states) + ",signature=" + DbAdapter.cite(signature) + ",autor=" + DbAdapter.cite(autor) + ",code=" + code
                                     + ",password=" + DbAdapter.cite(password) + " WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
            if (j < 1)
            {
                db.executeUpdate("INSERT SMSProfile(member,community,states,signature,autor,code,password)VALUES(" + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + ","
                                 + DbAdapter.cite(states) + ",signature=" + DbAdapter.cite(signature) + ",autor=" + DbAdapter.cite(autor) + ",code=" + code + ",password=" +
                                 DbAdapter.cite(password) + ")");
            }
        } finally
        {
            db.close();
        }
        this.states = states;
        this.code = code;
        this.password = password;
        _htLayer.clear();
    }

    private void load() throws SQLException
    {
        if (member == RV.SYS._strV)
        {
            states = true;
            autor = false;
            code = 0000;
            password = "0000";
            exists = true;
        } else
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT states,autor,code,password FROM SMSProfile " + getWhereSql(member, community));
                if (db.next())
                {
                    states = db.getInt(1) != 0;
                    autor = db.getInt(2) != 0;
                    code = db.getInt(3);
                    password = db.getString(4);
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
    }

    private Layer getLayer(int i) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(i));
        if (layer == null)
        {
            layer = new Layer();
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT signature FROM SMSProfile " + getWhereSql(member, community));
                if (db.next())
                {
                    layer.signature = db.getVarchar(1, i, 1);
                } else
                {
                    layer.signature = "";
                }
            } finally
            {
                db.close();
            }
            _htLayer.put(new Integer(i), layer);
        }
        return layer;
    }

    public static Enumeration findByAuto() throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT s.member,s.community FROM SMSProfile s,Profile p WHERE p.member=s.member AND p.community=s.community AND p.validate=1 AND s.autor=1");
            while (db.next())
            {
                vector.addElement(new tea.entity.RV(db.getString(1), db.getString(2)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public String getMember()
    {
        return member;
    }

    public boolean isStates()
    {
        return states;
    }

    public String getSignature(int language) throws SQLException
    {
        return getLayer(language).signature;
    }

    public boolean isExists()
    {
        return exists;
    }

    public boolean isAutor()
    {
        return autor;
    }

    public int getCode()
    {
        return code;
    }

    public String getPassword()
    {
        return password;
    }

    public String getCommunity()
    {
        return community;
    }

    public void setAutor(boolean autor) throws SQLException
    {
        if (!exists)
        {
            create(member, community);
        }
        try
        {
            java.io.InputStream is = new java.net.URL("http://sms.redcome.com/servlet/SetReverse?subcode=" + code + "&password=" + password + "&reverse=" + (autor ? "1" : "0")).openStream();
            is.read();
            is.close();
        } catch (IOException ex)
        {
            throw new SQLException(ex.toString());
        }
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE SMSProfile SET autor=" + (autor ? "1" : "0") + getWhereSql(member, community));
        } finally
        {
            db.close();
        }
        this.autor = autor;
    }

    private String getWhereSql(String member, String community)
    {
        StringBuilder sql = new StringBuilder(" WHERE member=");
        sql.append(DbAdapter.cite(member));
        // if (!"webmaster".equals(member))
        {
            sql.append(" AND community=");
            sql.append(DbAdapter.cite(community));
        }
        return sql.toString();
    }
}
