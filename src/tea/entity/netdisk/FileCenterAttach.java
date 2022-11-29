package tea.entity.netdisk;

import java.io.*;
import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;
import tea.resource.*;

public class FileCenterAttach extends Entity
{
    public static Cache _cache = new Cache(100);
    private int filecenterattach;
    private int filecenter;
    private int filesize;
    private String member;
    private String name;
    private String ex;
    private String path;
    private boolean exists;

    public FileCenterAttach(int filecenterattach) throws SQLException
    {
        this.filecenterattach = filecenterattach;
        load();
    }

    public static FileCenterAttach find(int filecenterattach) throws SQLException
    {
        FileCenterAttach obj = (FileCenterAttach) _cache.get(new Integer(filecenterattach));
        if(obj == null)
        {
            obj = new FileCenterAttach(filecenterattach);
            _cache.put(new Integer(filecenterattach),obj);
        }
        return obj;
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT filecenter,filesize,member,name,ex,path FROM FileCenterAttach WHERE filecenterattach=" + filecenterattach);
            if(db.next())
            {
                filecenter = db.getInt(1);
                filesize = db.getInt(2);
                member = db.getString(3);
                name = db.getString(4);
                ex = db.getString(5);
                path = db.getString(6);
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

    public static void create(int filecenter,String member,String name,String ex,String path) throws SQLException
    {
        int filesize = (int)new File(Common.REAL_PATH + path).length();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO FileCenterAttach (filecenter,filesize,member,name,ex,path)VALUES(" + filecenter + "," + filesize + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(ex) + "," + DbAdapter.cite(path) + ")");
        } finally
        {
            db.close();
        }
    }

    public void clone(int newfc) throws SQLException
    {
        File f = new File(Common.REAL_PATH + path);
        File f2 = new File(f.getParentFile(),newfc + "_" + f.getName());
        if(f.exists())
        {
            try
            {
                byte by[] = new byte[(int) f.length()];
                FileInputStream fis = new FileInputStream(f);
                fis.read(by);
                fis.close();

                FileOutputStream fos = new FileOutputStream(f2);
                fos.write(by);
                fos.close();

                FileCenterAttach.create(newfc,member,name,ex,f2.getAbsolutePath().substring(Common.REAL_PATH.length() - 1));
            } catch(IOException ex)
            {
                ex.printStackTrace();
            }
        }
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT filecenterattach FROM FileCenterAttach WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                al.add(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return al;
    }

    public static Enumeration findByFileCenter(int filecenter) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT filecenterattach FROM FileCenterAttach WHERE filecenter=" + filecenter);
            while(db.next())
            {
                v.add(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public void set(int filesize,String name,String ex,String path) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE FileCenterAttach SET filesize=" + filesize + ",name=" + DbAdapter.cite(name) + ",ex=" + DbAdapter.cite(ex) + ",path=" + DbAdapter.cite(path) + " WHERE filecenterattach=" + filecenterattach);
        } finally
        {
            db.close();
        }
        this.filesize = filesize;
        this.name = name;
        this.ex = ex;
        this.path = path;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM FileCenterAttach WHERE filecenterattach=" + filecenterattach);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(filecenterattach));
    }

    public static void delete(int fileid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM FileCenterAttach WHERE filecenter=" + fileid);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(fileid));
    }

    public String getPath()
    {
        return path;
    }

    public String getName()
    {
        return name;
    }

    public int getFileSize()
    {
        return filesize;
    }

    public int getFileCenterAttach()
    {
        return filecenterattach;
    }

    public int getFileCenter()
    {
        return filecenter;
    }

    public boolean isExists()
    {
        return exists;
    }

    //检查path是否存在///////
    public static boolean isExists(int filecenter,String path) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT filecenterattach FROM FileCenterAttach WHERE filecenter IN(SELECT filecenter FROM FileCenter WHERE father=" + filecenter + ") AND path=" + DbAdapter.cite(path));
            return db.next();
        } finally
        {
            db.close();
        }
    }

    public String getEx()
    {
        return ex;
    }

    public String getMember()
    {
        return member;
    }
}
