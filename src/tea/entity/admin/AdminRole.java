package tea.entity.admin;

import java.sql.SQLException;
import java.util.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.node.Node;

public class AdminRole implements Cloneable
{
    public static Cache _cache = new Cache(100);
    public static final String ROLE_TYPE[] =
            {"--","普通","默认"};
    public int id;
    public String community;
    public String name;
    public int type;
    public int status;
    public int sequence;
    public Date startdate;
    public Date enddate;
    public String content;
    public String adminfunction = "|";
    public String consign = "|";
    public String ethernet = "|"; //内网权限
    public String contentfunction; //内容菜单管理权限
    public int levels; //角色等级
    public boolean distinguish; //区分内外网
    public boolean exists;
    public Date time;
    public AdminRole(int id) throws SQLException
    {
        this.id = id;
    }

    public static AdminRole find(int id) throws SQLException
    {
        AdminRole t = (AdminRole) _cache.get(new Integer(id));
        if(t == null)
        {
            ArrayList al = find(" AND id=" + id,0,1);
            t = al.size() < 1 ? new AdminRole(id) : (AdminRole) al.get(0);
        }
        return t;
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM AdminRole WHERE 1=1" + sql);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate(id,"DELETE FROM AdminRole WHERE id=" + id);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
    }

    public void set() throws SQLException
    {
        String sql;
        if(id < 1)
            sql = "INSERT INTO AdminRole(id,community,status,type,content,startdate,enddate,adminfunction,ethernet,consign,name,levels,sequence,distinguish,time)VALUES(" + (id = Seq.get()) + "," + DbAdapter.cite(community) + "," + status + "," + (type) + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(startdate) + "," + DbAdapter.cite(enddate) + ",'/','/','/'," + DbAdapter.cite(name) + "," + levels + "," + sequence + "," + DbAdapter.cite(distinguish) + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE AdminRole SET name=" + DbAdapter.cite(name) + ",type=" + (type) + ",content=" + DbAdapter.cite(content) + ",startdate=" + DbAdapter.cite(startdate) + ",enddate=" + DbAdapter.cite(enddate) + ",levels=" + levels + ",sequence=" + sequence + ",distinguish=" + DbAdapter.cite(distinguish) + ",time=" + DbAdapter.cite(time) + " WHERE id=" + id;
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate(id,sql);
        } finally
        {
            db.close();
        }
    }

    public void set(String name,int type,Date startdate,Date enddate,String community) throws SQLException
    {
        if(exists)
        {
            DbAdapter db = new DbAdapter(1);
            try
            {
                db.executeUpdate(id,"UPDATE AdminRole SET name=" + DbAdapter.cite(name) + ",type=" + (type) + ",startdate=" + db.cite(startdate) + ",enddate=" + db.cite(enddate) + " WHERE id=" + id);
            } finally
            {
                db.close();
            }
            this.name = name;
            this.type = type;
            this.startdate = startdate;
            this.enddate = enddate;
        } else
        {
            create(community,status,type,startdate,enddate,name);
        }
    }

    public static int create(String community,int status,int type,Date startdate,Date enddate,String name) throws SQLException
    {
        int id = 0;
        String sql = "INSERT INTO AdminRole(id,community,status,type,startdate,enddate,adminfunction,ethernet,consign,name)VALUES(" + (id = Seq.get()) + "," + DbAdapter.cite(community) + "," + status + "," + (type) + "," + DbAdapter.cite(startdate) + "," + DbAdapter.cite(enddate) + ",'/','/','/'," + DbAdapter.cite(name) + ")";
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate(id,sql);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
        return id;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT id,community,status,name,type,content,startdate,enddate,adminfunction,ethernet,consign,contentfunction,levels,sequence,distinguish,time FROM AdminRole WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                int j = 1;
                AdminRole t = new AdminRole(db.getInt(j++));
                t.community = db.getString(j++);
                t.status = db.getInt(j++);
                t.name = db.getVarchar(1,1,j++);
                t.type = db.getInt(j++);
                t.content = db.getString(j++);
                t.startdate = db.getDate(j++);
                t.enddate = db.getDate(j++);
                t.adminfunction = db.getString(j++);
                t.ethernet = db.getText(j++);
                t.consign = db.getString(j++);
                t.contentfunction = db.getString(j++);
                t.levels = db.getInt(j++);
                t.sequence = db.getInt(j++);
                t.distinguish = db.getInt(j++) != 0;
                t.time = db.getDate(j++);
                t.exists = true;
                _cache.put(t.id,t);
                al.add(t);
            }
        } finally
        {
            db.close();
        }
        return al;
    }

    public static Enumeration find1ByCommunity(String community,int status) throws SQLException
    {
        StringBuilder sql = new StringBuilder();
        sql.append(" AND community=").append(DbAdapter.cite(community));
        if(status != -1)
        {
            sql.append(" AND status=").append(status);
        }
        return find1(sql.toString(),0,Integer.MAX_VALUE);
    }

    public static Enumeration find1(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT id FROM AdminRole WHERE 1=1" + sql,pos,size);
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

    public static int findByName(String name,String community) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT id FROM AdminRole WHERE community=" + DbAdapter.cite(community) + " AND name=" + DbAdapter.cite(name));
            if(db.next())
            {
                id = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return(id);
    }

    public static Enumeration findByType(String community,int type) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT id FROM AdminRole WHERE community=" + db.cite(community) + " AND type=" + type);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public void set(String field,String value) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate(id,"UPDATE AdminRole SET " + field + "=" + DbAdapter.cite(value) + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
        this.exists = true;
        _cache.remove(id);
    }

    public void setAdminfunction(String adminfunction,String ethernet) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate(id,"UPDATE AdminRole SET adminfunction=" + DbAdapter.cite(adminfunction) + ",ethernet=" + DbAdapter.cite(ethernet) + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
        this.adminfunction = adminfunction;
        this.ethernet = ethernet;
    }

    //内容菜单管理权限添加
    public void setContentfunction(String contentfunction) throws SQLException
    {
        set("contentfunction",contentfunction);
        this.contentfunction = contentfunction;
    }

    //修改角色等级
    public void setLevels(int levels) throws SQLException
    {
        set("levels",String.valueOf(levels));
        this.levels = levels;
    }

    public void setConsign(String consign) throws SQLException
    {
        set("consign",consign);
        this.consign = consign;
    }

    //获取是否有菜单权限显示
    public static boolean isEx(String role,int node,String member) throws SQLException
    {

        boolean f = false;

        if(role != null && role.length() > 0)
        {
            for(int i = 1;i < role.split("/").length;i++)
            {
                AdminRole arobj = AdminRole.find(Integer.parseInt(role.split("/")[i]));

                if(arobj.getContentfunction() != null && arobj.getContentfunction().indexOf("/" + node + "/") != -1)
                {
                    f = true;
                    break;
                }

            }
        }
        if(!f) //如果角色没有
        {
            AdminUsrRole arobj = AdminUsrRole.find(Node.find(node).getCommunity(),member);
            if(arobj.getContentfunction() != null && arobj.getContentfunction().indexOf("/" + node + "/") != -1)
            {
                f = true;
            }
        }

        return f;
    }

    public static boolean isEx2(String role,int node) throws SQLException
    {

        boolean f = false;
        if(Node.find(node).getType() == 1)
        {
            if(role != null && role.length() > 0)
            {
                for(int i = 1;i < role.split("/").length;i++)
                {
                    AdminRole arobj = AdminRole.find(Integer.parseInt(role.split("/")[i]));

                    if(arobj.getContentfunction() != null && arobj.getContentfunction().indexOf("/" + node + "/") != -1)
                    {
                        f = true;
                        break;
                    }

                }
            }
        } else
        {
            f = true;
        }
        return f;
    }

    public int getId()
    {
        return id;
    }

    public String getName()
    {
        return name;
    }

    public int getType()
    {
        return type;
    }

    public Date getStartdate()
    {
        return startdate;
    }

    public Date getEnddate()
    {
        return enddate;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getAdminfunction()
    {
        return adminfunction;
    }

    public String getEthernet()
    {
        return ethernet;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getStatus()
    {
        return status;
    }

    public String getConsign()
    {
        if(consign == null)
        {
            consign = "/";
        }
        return consign.replace('|','/');
    }

    public String getContentfunction()
    {
        if(contentfunction == null)
        {
            contentfunction = "/";
        }
        return contentfunction;
    }

    public int getLevels()
    {
        return levels;
    }

    //
    public static String getConsign(AdminUsrRole aur) throws SQLException
    {
        StringBuilder sb = new StringBuilder("|");
        Iterator it = AdminRole.find(" AND id IN(" + aur.getRole().substring(1).replace('/',',') + "0)",0,Integer.MAX_VALUE).iterator();
        while(it.hasNext())
        {
            AdminRole t = (AdminRole) it.next();
            sb.append(t.consign.substring(1));
        }
        return sb.toString();
    }

    public static String f(String roles) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        Iterator it = AdminRole.find(" AND id IN(" + roles.substring(1).replace('/',',') + "0)",0,Integer.MAX_VALUE).iterator();
        while(it.hasNext())
        {
            AdminRole r = (AdminRole) it.next();
            sb.append(r.name).append("；");
        }
        return sb.toString();
    }

    public AdminRole clone() throws CloneNotSupportedException
    {
        AdminRole t = (AdminRole)super.clone();
        t.id = 0;
        return t;
    }

    public static String options(String sql,int value) throws SQLException
    {
        StringBuilder htm = new StringBuilder();
        ArrayList al = AdminRole.find(sql,0,Integer.MAX_VALUE);
        for(int i = 0;i < al.size();i++)
        {
            AdminRole r = (AdminRole) al.get(i);
            htm.append("<option value=" + r.id);
            if(value == r.id)
                htm.append(" selected");
            htm.append(">" + r.name);
        }
        return htm.toString();
    }

    public String toString()
    {
        StringBuilder sb = new StringBuilder();
        try
        {
            sb.append("{id:" + id);
            sb.append(",name:" + Attch.cite(name));
            sb.append("}");
        } catch(Throwable ex)
        {
            ex.printStackTrace();
        }
        return sb.toString();
    }
}
