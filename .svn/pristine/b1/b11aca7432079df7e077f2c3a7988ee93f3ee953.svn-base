package tea.entity.node;

import tea.db.*;
import tea.entity.*;
import tea.entity.site.*;
import java.sql.SQLException;
import java.util.*;
import java.io.*;
import tea.resource.*;

public class Category extends Entity
{
    public static Cache _cache = new Cache(100);
    private int node;
    private int category;
    private int template;
    private boolean _blLoaded;
    private int clewtype;
    private String clewcontent;
    private int permissions; //审核权限
    private boolean exists;

    private Category(int node)
    {
        this.node = node;
        this.category = 39; //默认类别:新闻资讯
        _blLoaded = false;
    }

    public static Category find(int node)
    {
        Category obj = (Category) _cache.get(new Integer(node));
        if(obj == null)
        {
            obj = new Category(node);
            _cache.put(new Integer(node),obj);
        }
        return obj;
    }

    public static int find(String community,int type) throws SQLException
    {
        int k = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            k = db.getInt("SELECT c.node FROM Node n INNER JOIN Category c ON n.node=c.node WHERE n.path LIKE '/" + Community.find(community).getNode() + "/%' AND c.category=" + type + " ORDER BY c.node");
        } finally
        {
            db.close();
        }
        return k;
    }

    public static ArrayList find(String community,int type,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT c.node FROM Node n INNER JOIN Category c ON n.node=c.node WHERE n.path LIKE '/" + Community.find(community).getNode() + "/%' AND c.category=" + type,pos,size);
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


    public void set(int category,int template,int clewtype,String clewcontent,int permissions) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM Category WHERE node=" + node);
            if(db.next())
            {
                db.executeUpdate(node,"UPDATE Category SET category=" + category + ",template=" + template + ",clewtype=" + clewtype + ",clewcontent =" + DbAdapter.cite(clewcontent) + ",permissions=" + permissions + " WHERE node=" + node);
            } else
            {
                db.executeUpdate(node,"INSERT INTO Category(node,category,template,permissions)VALUES(" + node + "," + category + "," + template + "," + permissions + ")");
            }
        } finally
        {
            db.close();
        }
        int lang = 1;
        if(this.category != category)
        {
            if(this.category == 39 && category == 41)//新闻转文件
            {
                Node n = Node.find(node);
                Enumeration e = Node.find(" AND father=" + node,0,1000);
                while(e.hasMoreElements())
                {
                    int nodeid = ((Integer) e.nextElement()).intValue();
                    Report r = Report.find(nodeid);
                    String pic = r.getPicture(lang);
                    if(pic != null && pic.length() > 0)
                    {
                        File f = new File(Common.REAL_PATH + pic);
                        f.renameTo(new File(Common.REAL_PATH + "/res/" + n.getCommunity() + "/files/" + nodeid + "_" + lang + ".doc"));
                        pic = pic.substring(pic.lastIndexOf('/') + 1);
                    }
                    //  Files fs = Files.find(nodeid,lang);
                    // fs.set(r.getClasses(),"",pic,r.getAuthor(lang),r.getLocus(lang),r.getLogograph(lang));
                }
            }
        }
        this.category = category;
        this.template = template;
        this.clewtype = clewtype;
        this.clewcontent = clewcontent;
        this.permissions = permissions;
    }


    public void set(int category,int _nTypeAlias,int template) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM Category WHERE node=" + node);
            if(db.next())
            {
                db.executeUpdate("UPDATE Category SET category=" + category + ", template=" + template + " WHERE node=" + node);
            } else
            {
                db.executeUpdate("INSERT INTO Category (node, category,template) VALUES (" + node + ", " + category + ", " + template + ")");
            }
        } finally
        {
            db.close();
        }
        this.category = category;
        this.template = template;
    }


    private void load() throws SQLException
    {
        if(!_blLoaded)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT category, template,clewtype,clewcontent,permissions  FROM Category  WHERE node=" + node);
                if(db.next())
                {
                    category = db.getInt(1);
                    template = db.getInt(2);
                    clewtype = db.getInt(3);
                    clewcontent = db.getString(4);
                    permissions = db.getInt(5);
                    exists = true;
                } else
                {
                    exists = false;
                }
            } finally
            {
                db.close();
            }
            _blLoaded = true;
        }
    }

    public int getCategory() throws SQLException
    {
        load();
        return category;
    }


    public int getTemplate() throws SQLException
    {
        load();
        return template;
    }


    public boolean isExists() throws SQLException
    {
        load();
        return exists;
    }

    public int getClewtype() throws SQLException
    {
        load();
        return clewtype;
    }

    public String getClewcontent() throws SQLException
    {
        load();
        return clewcontent;
    }

    public int getPermissions() throws SQLException
    {
        load();
        return permissions;
    }


    /**
     * 判断有几个选项是勾选的
     * zjs
     */
    public int getPermissions(int p) throws SQLException
    {
        int perint = 0;

        //判断当前勾选的下一个勾选
        if(p == 0 && (this.getPermissions() & 1) != 0)
        {
            perint = 0;
        } else if(p == 1 && (this.getPermissions() & 2) != 0)
        {
            perint = 1;
        } else if(p == 2 && (this.getPermissions() & 4) != 0)
        {
            perint = 2;
        } else if(p == 3 && (this.getPermissions() & 8) != 0)
        {
            perint = 3;
        }
        return perint;
    }

    public int getPermissionsAll(int p) throws SQLException
    {
        int perint = 0;
        for(int i = (p + 1);i < 5;i++)
        {
            if(getPermissions(i) > 0)
            {
                perint = getPermissions(i);
                break;
            }

        }

        return perint;
    }


}
