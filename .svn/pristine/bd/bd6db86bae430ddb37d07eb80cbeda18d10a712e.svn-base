package tea.entity.netdisk;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.Date;
import java.net.*;
import tea.db.*;
import tea.entity.*;
import tea.ui.TeaSession;
import tea.resource.*;

public class NetDisk extends Entity
{
    public static Cache _cache = new Cache(100);
    private String community;
    private String path;
    private boolean extend; //true:继承,false:不继承
    private String member;
    private boolean type; //false:文件夹,true:文件
    private String name;
    private String content;
    private int filesize;
    private Date time;
    private String prefix;
    private boolean exists;

    public NetDisk(String community, String path) throws SQLException
    {
        this.community = community;
        this.path = path;
        this.prefix = "/res/" + community + "/netdisk";
        load();
    }

    public static NetDisk find(String community, String path) throws SQLException
    {
        NetDisk obj = (NetDisk) _cache.get(community + ":" + path);
        if (obj == null)
        {
            obj = new NetDisk(community, path);
            _cache.put(community + ":" + path, obj);
        }
        return obj;
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT extend,member,type,name,content,filesize,time FROM NetDisk WHERE community=" + DbAdapter.cite(community) + " AND path=" + DbAdapter.cite(path));
            if (db.next())
            {
                extend = db.getInt(1) != 0;
                member = db.getString(2);
                type = db.getInt(3) != 0;
                name = db.getString(4);
                content = db.getString(5);
                filesize = db.getInt(6);
                time = db.getDate(7);
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

    public static void create(String community, String path, String member, boolean type, String content, int filesize) throws SQLException, IOException
    {
        String name = type ? path : path.substring(0, path.length() - 1);
        name = name.substring(name.lastIndexOf("/") + 1);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO NetDisk (community,path,extend,member,type,name,content,filesize,time)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(path) + ",1," + DbAdapter.cite(member) + "," + DbAdapter.cite(type) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(content) + "," + filesize + "," + db.citeCurTime() + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(community + ":" + path);
    }

    public void move(String newpath) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT path FROM NetDisk WHERE");
        if (isType())
        {
            sb.append(" path=").append(DbAdapter.cite(path));
        } else
        {
            sb.append(" path LIKE ").append(DbAdapter.cite(path + "%"));
        }
        //PATH中除去name的长度
        int len = getParent().length();
        DbAdapter db = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        try
        {
            db.executeQuery(sb.toString());
            while (db.next())
            {
                String old = db.getString(1);
                db2.executeUpdate("UPDATE NetDisk SET path=" + db2.cite(newpath + old.substring(len)) + " WHERE community=" + DbAdapter.cite(community) + " AND path=" + DbAdapter.cite(old));
            }
        } catch (SQLException ex)
        {
            ex.printStackTrace();
        } finally
        {
            db.close();
            db2.close();
        }
        this.path = newpath;
        _cache.clear();
    }

    public String getParent()
    {
        if ("/".equals(path))
        {
            return "/";
        }
        return path.substring(0, path.lastIndexOf("/", path.length() - 2) + 1);
    }

    public void clone(String newpath) throws SQLException, IOException
    {
        File f = new File(Common.REAL_PATH + prefix + path);
        File f2 = new File(Common.REAL_PATH + prefix + newpath);
        byte by[] = null;
        if (isType())
        {
            by = new byte[(int) f.length()];
            FileInputStream fis = new FileInputStream(f);
            fis.read(by);
            fis.close();
            FileOutputStream fos = new FileOutputStream(f2);
            fos.write(by);
            fos.close();
        }
        NetDisk.create(newpath, community, member, isType(), content, (int) f.length());
    }

    public void set(String name, String content) throws SQLException
    {
        String newpath = this.getParent() + name;
        if (!isType())
        {
            newpath = newpath + "/";
        }
        DbAdapter db = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE NetDisk SET path=" + DbAdapter.cite(newpath) + ",name=" + DbAdapter.cite(name) + ",content=" + DbAdapter.cite(content) + " WHERE community=" + DbAdapter.cite(community) + " AND path=" + DbAdapter.cite(path));
            if (!isType())
            {
                db.executeQuery("SELECT path FROM NetDisk WHERE community=" + DbAdapter.cite(community) + " AND path LIKE " + DbAdapter.cite(path + "%"));
                while (db.next())
                {
                    String old = db.getString(1);
                    db2.executeUpdate("UPDATE NetDisk SET path=" + DbAdapter.cite(newpath + old.substring(path.length())) + " WHERE community=" + DbAdapter.cite(community) + " AND path=" + DbAdapter.cite(old));
                }
            }
        } finally
        {
            db.close();
            db2.close();
        }
        this.name = name;
        this.content = content;
        _cache.clear();
    }

    public void setExtend(boolean extend) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE NetDisk SET extend=" + DbAdapter.cite(extend) + " WHERE community=" + DbAdapter.cite(community) + " AND path=" + DbAdapter.cite(path));
        } finally
        {
            db.close();
        }
        this.extend = extend;
    }

    //不接受继承的父路径///////////////////////////////
    public String getParentEx() throws SQLException
    {
        String p = null;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT MAX(path) FROM NetDisk WHERE type=0 AND extend=0 AND " + DbAdapter.cite(path) + " LIKE " + db.concat("path", "'%'") + " AND path<=" + DbAdapter.cite(path));
            if (db.next())
            {
                p = db.getString(1);
            }
        } finally
        {
            db.close();
        }
        return p;
    }

    public boolean isExtend()
    {
        return extend;
    }

    public void delete() throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        sb.append("DELETE FROM NetDisk WHERE community=" + DbAdapter.cite(community) + " AND");
        if (isType())
        {
            sb.append(" path=").append(DbAdapter.cite(path));
        } else
        {
            sb.append(" path LIKE ").append(DbAdapter.cite(path + "%"));
        }
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sb.toString());
        } finally
        {
            db.close();
        }
        _cache.remove(community + ":" + path);
    }

    //base: 说明:null=没有链接
    public String getAncestor(String base) throws SQLException
    {
        boolean bool = base != null;
        StringBuilder a = new StringBuilder("/ ");
        StringBuilder p = new StringBuilder();
        String bp = path;
        try
        {
            if (bool)
            {
                bp = path.substring(base.length());
                p.append(base).append("/");
                base = java.net.URLEncoder.encode(base, "UTF-8");
                a.append("<a href=\"?community=" + community + "&base=" + base + "&path=" + base + "%2F\">");
            }
            a.append("根目录</a>");
            StringTokenizer st = new StringTokenizer(bp, "/");
            while (st.hasMoreTokens())
            {
                String label = st.nextToken();
                a.append(" / ");
                if (bool)
                {
                    p.append(label).append("/");
                    a.append("<a href=?community=" + community + "&base=" + base + "&path=" + java.net.URLEncoder.encode(p.toString(), "UTF-8") + ">");
                }
                a.append(label + "</a>");
            }
        } catch (UnsupportedEncodingException ex)
        {
        }
        return a.toString();
    }

    public static Enumeration findByPath(String community, String path, String order, boolean asc) throws SQLException
    {
        return find(community, " AND path LIKE " + DbAdapter.cite(path + "_%") + " AND path NOT LIKE " + DbAdapter.cite(path + "%/_%"), order, asc);
    }

    public static Enumeration find(String community, String sql, String order, boolean asc) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT path FROM NetDisk WHERE community=").append(DbAdapter.cite(community));
        sb.append(sql);
        if (order != null)
        {
            sb.append(" ORDER BY type,").append(order).append(asc ? " DESC" : " ASC");
        }
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(sb.toString());
            while (db.next())
            {
                v.add(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public void refresh(File f) throws SQLException, IOException
    {
        if ("/".equals(path) && !isExists())
        {
            NetDisk.create(community, path, "webmaster", false, "", 0);
            f.mkdirs();
        }
        File fs[] = f.listFiles();
        if (fs != null)
        {
            for (int i = 0; i < fs.length; i++)
            {
                String newpath = path + fs[i].getName();
                boolean type = fs[i].isFile();
                if (!type)
                {
                    newpath = newpath + "/";
                }
                NetDisk nd = NetDisk.find(community, newpath);
                if (!nd.isExists())
                {
                    NetDisk.create(community, newpath, member, type, "", (int) fs[i].length());
                }
            }
        }
    }

    public boolean isType()
    {
        return type;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        if (time == null)
        {
            return "";
        }
        return sdf2.format(time);
    }

    public String getPath()
    {
        return path;
    }

    public String getName()
    {
        return name;
    }

    public String getEx()
    {
        String ex = "dir";
        if (isType())
        {
            ex = name.substring(name.lastIndexOf(".") + 1);
        }
        return ex;
    }


    public String getMember()
    {
        return member;
    }

    public int getFileSize()
    {
        return filesize;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getContent()
    {
        return content;
    }

    public String getContentToHtml()
    {
        return "时间:" + getTimeToString() + "&#13;" + "大小:" + getFileSize() + "&#13;路径:" + getPath() + "&#13;" + "描述:" + getContent();
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getPrefix()
    {
        return prefix;
    }


    public String getTreeToHtml(TeaSession teasession, int step) throws SQLException
    {
        StringBuilder h = new StringBuilder();
        try
        {
            tree(teasession, step, h);
        } catch (UnsupportedEncodingException ex)
        {
        }
        return h.toString();
    }

    private void tree(TeaSession teasession, int step, StringBuilder h) throws SQLException, UnsupportedEncodingException
    {
        Enumeration e = NetDisk.find(teasession._strCommunity, " AND type=0 AND path LIKE " + DbAdapter.cite(path + "_%") + " AND path NOT LIKE " + DbAdapter.cite(path + "%/_%"), null, false);
        while (e.hasMoreElements())
        {
            String path = (String) e.nextElement();
            String id = URLEncoder.encode(path, "UTF-8");
            NetDisk obj = NetDisk.find(teasession._strCommunity, path);
            for (int loop = 1; loop < step; loop++)
            {
                h.append("<img src=/tea/image/tree/tree_line.gif align=absmiddle>");
            }
            if (step > 0)
            {
                h.append("　 ");
            }
            h.append("<SPAN id=leftuptree" + step + " >");
            h.append("<a href=### onclick=f_ex('" + id + "'," + step + "); ID=a" + step + "><IMG SRC=/tea/image/tree/tree_plus.gif align=absmiddle ID=img" + id + " /></a> ");
            h.append("<a href=### onclick=f_open('" + id + "');>" + obj.getName() + "</a>");
            h.append("<br></SPAN>");
            h.append("<Div id=divid" + id + " style=display:none>");
            //obj.tree(teasession, popedom, step + 1, def, h);
            h.append("</Div>");
        }
    }
}
