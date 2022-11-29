package tea.entity.member;

import tea.db.DbAdapter;
import tea.entity.Cache;
import java.sql.SQLException;
import java.util.*;

public class NetDiskShare
{
    private static Cache _cache = new Cache(100);
    private int id;
    private int name;
    private String path;
    private String member;
    private int type; // 0:通讯录中的组,1:通讯录中的会员
    private int purview;
    private boolean exists;

    public static NetDiskShare find(int id) throws SQLException
    {
        NetDiskShare obj = (NetDiskShare) _cache.get(new Integer(id));
        if(obj == null)
        {
            obj = new NetDiskShare(id);
            _cache.put(new Integer(id),obj);
        }
        return obj;
    }

    public static NetDiskShare find(String path,int name,int type) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM NetDiskShare WHERE path=" + DbAdapter.cite(path) + " AND name=" + name + " AND type=" + type);
            if(db.next())
            {
                id = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return find(id);
    }

    public NetDiskShare(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public int getId()
    {
        return id;
    }

    public static void create(int name,String path,int purview,int type,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO NetDiskShare(name,path,purview,type,member)VALUES(" + (name) + "," + DbAdapter.cite(path) + "," + purview + "," + type + "," + DbAdapter.cite(member) + ")");
        } finally
        {
            db.close();
        }
    }

    public static void delete(String path) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM NetDiskShare WHERE path=" + DbAdapter.cite(path));
        } finally
        {
            db.close();
        }
        _cache.clear();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT name,path,purview,type,member FROM NetDiskShare WHERE id=" + id);
            if(db.next())
            {
                name = db.getInt(1);
                path = db.getString(2);
                purview = db.getInt(3);
                type = db.getInt(4);
                member = db.getString(5);
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

    public static java.util.Enumeration findPath(String path) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM NetDiskShare WHERE path=" + DbAdapter.cite(path));
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

    public static NetDiskShare find(String name,String communtiy,String path) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT NetDiskShare.id FROM NetDiskShare,SMSgroup,SMSPhoneBook WHERE( (NetDiskShare.type=0 AND SMSgroup.id=NetDiskShare.name AND SMSPhoneBook.groupid=NetDiskShare.name)OR (NetDiskShare.type=1 AND SMSPhoneBook.id=NetDiskShare.name ))AND SMSPhoneBook.memberx="
                            + DbAdapter.cite(name) + " AND " + DbAdapter.cite(path) + " LIKE '/res/" + communtiy + "/netdiskmember/'+NetDiskShare.member+NetDiskShare.path+'%' ORDER BY NetDiskShare.purview DESC");
            if(db.next())
            {
                return find(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return find(0);
    }

    public static int countByMember(String community,String member) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db
                    .executeQuery("SELECT COUNT( DISTINCT NetDiskShare.path ) FROM NetDiskShare,SMSgroup,SMSPhoneBook WHERE( (NetDiskShare.type=0 AND SMSgroup.id=NetDiskShare.name AND SMSPhoneBook.groupid=NetDiskShare.name)OR (NetDiskShare.type=1 AND SMSPhoneBook.id=NetDiskShare.name ))AND SMSPhoneBook.memberx="
                                  + DbAdapter.cite(member) + " AND SMSPhoneBook.community=" + DbAdapter.cite(community));
            if(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }

    /*
     * public static java.util.Enumeration findPath(String path) throws SQLException { java.util.Vector vector = new java.util.Vector(); DbAdapter db = new DbAdapter(); try {
     *
     * SELECT NetDiskShare.member,NetDiskShare.path FROM NetDiskShare,SMSgroup,SMSPhoneBook WHERE ( (NetDiskShare.type=0 AND SMSgroup.id=NetDiskShare.id AND SMSPhoneBook.groupid=NetDiskShare.id) OR (NetDiskShare.type=1 AND SMSPhoneBook.id=NetDiskShare.id ) ) AND SMSPhoneBook.name='webmaster' ORDER
     * BY NetDiskShare.member
     *
     *
     * db.executeQuery("SELECT id FROM NetDiskShare WHERE path= " +DbAdapter.cite( path)); while (db.next()) { vector.addElement(new Integer(db.getInt(1))); } } finally { db.close(); }
     * return vector.elements(); }
     */

    public int getName()
    {
        return name;
    }

    public String getPath()
    {
        return path;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getMember()
    {
        return member;
    }

    public int getType()
    {
        return type;
    }

    public int getPurview()
    {
        return purview;
    }

}
