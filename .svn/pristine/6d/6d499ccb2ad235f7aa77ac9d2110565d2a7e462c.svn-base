package tea.entity.admin.ig;

import java.io.*;
import java.util.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.admin.*;
import tea.entity.member.*;
import java.sql.SQLException;

public class Igtab extends Entity implements Serializable
{
    private static Cache _cache = new Cache(100);
    private int igtab;
    private String community;
    private String member;
    private String name;
    private String mp;
    private boolean _blLoaded;
    private String mz;
    private String mc;

    public Igtab(int igtab) throws SQLException
    {
        this.igtab = igtab;
        _blLoaded = false;
        // load();
    }

    private void load() throws SQLException
    {
        if (!_blLoaded)
        {
            DbAdapter db = new DbAdapter(1);
            try
            {
                db.executeQuery("SELECT community, member, name,mp,mz,mc FROM Igtab WHERE igtab=" + igtab);
                if (db.next())
                {
                    community = db.getString(1);
                    member = db.getString(2);
                    name = db.getString(3);
                    mp = db.getString(4);
                    mz = db.getString(5);
                    mc = db.getString(6);
                } else
                {
                }
            } finally
            {
                db.close();
            }
            _blLoaded = true;
        }
    }

    public static Igtab find(int _nIgtab) throws SQLException
    {
        Igtab obj = (Igtab) _cache.get(new Integer(_nIgtab));
        if (obj == null)
        {
            obj = new Igtab(_nIgtab);
            _cache.put(new Integer(_nIgtab), obj);
        }
        return obj;
    }

    public static int create(String member, String name) throws SQLException
    {
        return create(member, name, "", null, null);
    }

    public static int create(String member, String name, String mp, String mz, String mc) throws SQLException
    {
        int j2 = 0;
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("INSERT INTO Igtab (member, name,mp,mz,mc)VALUES(" + DbAdapter.cite(member) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(mp) + "," + DbAdapter.cite(mz) + "," + DbAdapter.cite(mc) + ")");
            j2 = db.getInt("SELECT igtab FROM Igtab ORDER BY igtab DESC");
        } finally
        {
            db.close();
        }
        return j2;
    }

    public void set(String name) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("UPDATE Igtab SET name=" + DbAdapter.cite(name) + " WHERE igtab=" + igtab);
        } finally
        {
            db.close();
        }
        this.name = name;
    }

    public void setMp(String mp) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("UPDATE Igtab SET mp=" + DbAdapter.cite(mp) + " WHERE igtab=" + igtab);
        } finally
        {
            db.close();
        }
        this.mp = mp;
    }

    public void setMz(String mz) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("UPDATE Igtab SET mz=" + DbAdapter.cite(mz) + " WHERE igtab=" + igtab);
        } finally
        {
            db.close();
        }
        this.mz = mz;
    }

    public void setMc(String mc) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("UPDATE Igtab SET mc=" + DbAdapter.cite(mc) + " WHERE igtab=" + igtab);
        } finally
        {
            db.close();
        }
        this.mc = mc;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("DELETE FROM Igtab WHERE igtab=" + igtab);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(igtab));
    }

    public static Enumeration findByMember(String member) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT igtab FROM Igtab WHERE member=" + DbAdapter.cite(member));
            while (db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        if (vector.size() < 1)
        {
            if (member.startsWith(DEFAULT_MEMBER))
            {
                int id = create(member, "&#20027;&#39029;");
                vector.add(new Integer(id));
            } else
            {
                Profile p = Profile.find(member);
                String role = null;
                AdminUsrRole r = AdminUsrRole.find(p.getCommunity(), member);
                java.util.regex.Matcher m = java.util.regex.Pattern.compile("/(\\d+)/").matcher(r.getRole());
                if (m.find())
                {
                    role = m.group(1);
                } else
                {
                    Enumeration e = AdminRole.findByType(p.getCommunity(), 1);
                    if (e.hasMoreElements())
                    {
                        role = ((Integer) e.nextElement()).toString();
                    }
                }
                Enumeration e = findByMember(DEFAULT_MEMBER + role);
                while (e.hasMoreElements())
                {
                    int id = ((Integer) e.nextElement()).intValue();
                    Igtab obj = Igtab.find(id);
                    int newid = create(member, obj.getName(), obj.getMp(), obj.getMz(), obj.getMc());
                    vector.add(new Integer(newid));
                }
            }
        }
        return vector.elements();
    }

    private void readObject(ObjectInputStream ois) throws IOException, ClassNotFoundException
    {
        ois.defaultReadObject();
    }

    private void writeObject(ObjectOutputStream oos) throws IOException
    {
        oos.defaultWriteObject();
    }

    public int getIgtab()
    {
        return igtab;
    }

    public String getCommunity() throws SQLException
    {
        load();
        return community;
    }

    public String getMember() throws SQLException
    {
        load();
        return member;
    }

    public String getName() throws SQLException
    {
        load();
        return name;
    }

    public String getMp() throws SQLException
    {
        load();
        return mp;
    }

    public String getMz()
    {
        return mz;
    }

    public String getMc()
    {
        return mc;
    }
}
