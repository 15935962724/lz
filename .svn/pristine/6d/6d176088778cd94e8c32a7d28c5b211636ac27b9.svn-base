package tea.entity.admin;

import java.util.*;

import tea.db.*;
import tea.entity.*;
import java.io.*;
import java.sql.SQLException;

public class NetDiskSize extends Entity implements Serializable
{
    private static Cache _cache = new Cache(100);
    private Date startdate;
    private Date enddate;
    private boolean exists;
    private int adminrole;
    private int single; // 单个文件大小
    private int sumfile; // 文件总数
    private int sumsize; // 总空间
    static
    {
        try
        {
            Enumeration e = (Enumeration) AdminRole.find(" AND id NOT IN(SELECT adminrole FROM NetDiskSize)",0,200);
            while(e.hasMoreElements())
            {
                int id = ((Integer) e.nextElement()).intValue();
                NetDiskSize.create(id,10240,100,51200,new Date(System.currentTimeMillis() + 31536000000L));
            }
        } catch(Exception ex)
        {
        }
    }

    public NetDiskSize(int adminrole) throws SQLException
    {
        this.adminrole = adminrole;
        load();
    }

    public static NetDiskSize find(int adminrole) throws SQLException
    {
        NetDiskSize obj = (NetDiskSize) _cache.get(new Integer(adminrole));
        if(obj == null)
        {
            obj = new NetDiskSize(adminrole);
            _cache.put(new Integer(adminrole),obj);
        }
        return obj;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from NetDiskSize where adminrole=" + adminrole);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(adminrole));
    }

    public void set(int single,int sumfile,int sumsize,Date enddate) throws SQLException
    {
        if(exists)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate("UPDATE NetDiskSize SET single=" + (single) + ",sumfile=" + (sumfile) + ",sumsize=" + (sumsize) + ",enddate=" + DbAdapter.cite(enddate) + " WHERE adminrole=" + adminrole);
            } finally
            {
                db.close();
            }
            _cache.remove(new Integer(adminrole));
        } else
        {
            create(adminrole,single,sumfile,sumsize,enddate);
        }

    }

    public static int create(int adminrole,int single,int sumfile,int sumsize,Date enddate) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO NetDiskSize(adminrole,single,sumfile,sumsize,enddate)VALUES(" + adminrole + "," + single + "," + sumfile + "," + sumsize + "," + DbAdapter.cite(enddate) + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(adminrole));
        return adminrole;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT single,sumfile,sumsize,enddate FROM NetDiskSize WHERE adminrole=" + adminrole);
            if(db.next())
            {
                single = db.getInt(1);
                sumfile = db.getInt(2);
                sumsize = db.getInt(3);
                enddate = db.getDate(4);
                exists = true;
            } else
            {
                // single = 1024 * 10;
                // sumfile = Integer.MAX_VALUE;
                // sumsize = 1024 * 50;
                Calendar c = Calendar.getInstance();
                c.set(Calendar.YEAR,c.get(Calendar.YEAR) + 1);
                enddate = c.getTime();
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public static Date getEnddateByMember(String community,String member) throws SQLException
    {
        AdminUsrRole aur = AdminUsrRole.find(community,member);
        String role = aur.getRole();
        Date enddate = new Date();
        if(role.length() > 2)
        {
            role = role.substring(1,role.length() - 1).replace('/',',');
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT MAX(nds.enddate) FROM NetDiskSize nds WHERE nds.adminrole IN (" + role + ")");
                if(db.next())
                {
                    enddate = db.getDate(1);
                }
            } finally
            {
                db.close();
            }
        }
        return enddate;
    }

    public static int getSizeByMember(String community,String member) throws SQLException
    {
        AdminUsrRole aur = AdminUsrRole.find(community,member);
        String role = aur.getRole();
        int sumsize = 0;
        if(role.length() > 2)
        {
            role = role.substring(1,role.length() - 1).replace('/',',');
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT MAX(nds.sumsize) FROM NetDiskSize nds WHERE nds.adminrole IN (" + role + ")");
                if(db.next())
                {
                    sumsize = db.getInt(1);
                }
            } finally
            {
                db.close();
            }
        }
        return sumsize;
    }

    public static int getSumByMember(String community,String member) throws SQLException
    {
        AdminUsrRole aur = AdminUsrRole.find(community,member);
        String role = aur.getRole();
        int sumfile = 0;
        if(role.length() > 2)
        {
            role = role.substring(1,role.length() - 1).replace('/',',');
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT MAX(nds.sumfile) FROM NetDiskSize nds WHERE nds.adminrole IN (" + role + ")");
                if(db.next())
                {
                    sumfile = db.getInt(1);
                }
            } finally
            {
                db.close();
            }
        }
        return sumfile;
    }

    public static int getSingleByMember(String community,String member) throws SQLException
    {
        AdminUsrRole aur = AdminUsrRole.find(community,member);
        String role = aur.getRole();
        int single = 0;
        if(role.length() > 2)
        {
            role = role.substring(1,role.length() - 1).replace('/',',');

            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT MAX(nds.single) FROM NetDiskSize nds WHERE nds.adminrole IN (" + role + ")");
                if(db.next())
                {
                    single = db.getInt(1);
                }
            } finally
            {
                db.close();
            }
        }
        return single;
    }

    /*
     * public static Enumeration findByType(int type) throws SQLException { DbAdapter db = new DbAdapter(); Vector vector = new Vector(); try { db.executeQuery("SELECT id FROM NetDiskSize WHERE type=" + type); while (db.next()) { vector.addElement(new Integer(db.getInt(1))); } } catch (SQLException ex) { throw new tea.entity.SQLException(ex.getMessage()); } finally { db.close(); } return vector.elements(); }
     */

    public Date getStartdate()
    {
        return startdate;
    }

    public Date getEnddate()
    {
        return enddate;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getAdminrole()
    {
        return adminrole;
    }

    public int getSingle()
    {
        return single;
    }

    public int getSum()
    {
        return sumfile;
    }

    public int getSize()
    {
        return sumsize;
    }

    public static int getUseSize(File file) throws IOException
    {
        return(int) (getUseSize(file,0L) / 1024);
    }

    private static long getUseSize(File file,long len) throws IOException
    {
        File fs[] = file.listFiles();
        if(fs != null)
        {
            for(int i = 0;i < fs.length;i++)
            {
                if(fs[i].isFile())
                {
                    len += fs[i].length();
                } else
                {
                    len = getUseSize(fs[i],len);
                }
            }
        }
        return len;
    }
}
