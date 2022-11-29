package tea.entity.node;

import java.io.*;
import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;
import tea.resource.*;
import tea.entity.site.*;

public class CssJs extends Entity implements Cloneable
{
    public static Cache _cache = new Cache(100);
    private Hashtable _htLayer;
    public int cssjs;
    public int status;
    public int style;
    public int styletype;
    public int stylecategory;
    public int node;
    public int sequence;
    public String name;
    public boolean theme;
    public String picture;
    public boolean exists;
    public String prefix;
    class Layer
    {
        private String css;
        private String js;
        private String cssPath;
        private String jsPath;
        private boolean layerExisted;
    }


    public CssJs(int cssjs) throws SQLException
    {
        this.cssjs = cssjs;
        _htLayer = new Hashtable();
    }

    public int getCssJs()
    {
        return cssjs;
    }

    public int getStyle()
    {
        return style;
    }

    public int getNode()
    {
        return node;
    }

    public String getName(int language)
    {
        return name;
    }

    public boolean isExists()
    {
        return exists;
    }

    private static int create(int status,int style,int styletype,int stylecategory,int node,boolean theme,String picture,int language,String name,String css,String js) throws SQLException
    {
        int cssjs = Seq.get();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO CssJs(cssjs,status,style,styletype,stylecategory,node,sequence,name,theme,picture)VALUES(" + cssjs + "," + status + "," + style + "," + styletype + "," + stylecategory + "," + node + "," + (System.currentTimeMillis() / 1000) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(theme) + "," + DbAdapter.cite(picture) + ")");
        } finally
        {
            db.close();
        }
        CssJs obj = CssJs.find(cssjs);
        obj.setLayer(language,css,js);
        return cssjs;
    }

    public void set() throws SQLException
    {
        String sql;
        if(cssjs < 1)
        {
            prefix = "/res/" + Node.find(node).getCommunity() + "/cssjs/";
            sql = "INSERT INTO CssJs(cssjs,status,style,styletype,stylecategory,node,sequence,name,theme,picture)VALUES(" + (cssjs = Seq.get()) + "," + status + "," + style + "," + styletype + "," + stylecategory + "," + node + "," + (System.currentTimeMillis() / 1000) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(theme) + "," + DbAdapter.cite(picture) + ")";
        } else
            sql = "UPDATE CssJs SET style=" + style + ",styletype=" + styletype + ",stylecategory=" + stylecategory + ",name=" + DbAdapter.cite(name) + ",theme=" + DbAdapter.cite(theme) + ",picture=" + DbAdapter.cite(picture) + " WHERE cssjs=" + cssjs;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(cssjs,sql);
        } finally
        {
            db.close();
        }
    }

    private void set(int style,int styletype,int stylecategory,boolean theme,String picture,int language,String name,String _strCss,String _strJs) throws SQLException
    {
        String sql = "UPDATE CssJs SET style=" + style + ",styletype=" + styletype + ",stylecategory=" + stylecategory + ",theme=" + DbAdapter.cite(theme);
        if(picture != null)
        {
            sql += ",picture=" + DbAdapter.cite(picture);
            this.picture = picture;
        }
        sql += ",name=" + DbAdapter.cite(name) + " WHERE cssjs=" + cssjs;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(cssjs,sql);
        } finally
        {
            db.close();
        }
        setLayer(language,_strCss,_strJs);
        this.style = style;
        this.styletype = styletype;
        this.stylecategory = stylecategory;
        this.theme = theme;
        _cache.clear();
    }

    public void setLayer(int language,String css,String js)
    {
        File f = new File(Common.REAL_PATH + prefix);
        if(!f.exists())
        {
            f.mkdirs();
        }
        try
        {
            //css
            ArrayList al = Attch.find(" AND node=" + cssjs + " AND type='css'",0,1);
            Attch a = al.size() < 1 ? new Attch(Seq.get()) : (Attch) al.get(0);
            a.node = cssjs;
            a.type = "css";
            a.path = prefix + cssjs + "L" + language + ".css";
            Filex.write(Common.REAL_PATH + a.path,css);
            a.set();
            //js
            al = Attch.find(" AND node=" + cssjs + " AND type='js'",0,1);
            a = al.size() < 1 ? new Attch(Seq.get()) : (Attch) al.get(0);
            a.node = cssjs;
            a.type = "js";
            a.path = prefix + cssjs + "L" + language + ".js";
            Filex.write(Common.REAL_PATH + a.path,js);
            a.set();
        } catch(Throwable ex)
        {
            ex.printStackTrace();
        }
        _htLayer.clear();
    }

    // 把cssjsCode复制到nodeCode节点上.
    public CssJs clone(int newnode,int status) throws SQLException,IOException,CloneNotSupportedException
    {
        CssJs t = clone();
        t.node = newnode;
        t.status = status;
        t.set();

        // 复制隐藏方式
        Cssjshide ch = Cssjshide.find(cssjs,node);
        Cssjshide newch = Cssjshide.find(t.cssjs,node);
        newch.set(ch.getHiden());
        // 文件复制
        for(int i = 0;i < Common.LANGUAGE.length;i++)
        {
            File css = new File(Common.REAL_PATH + prefix + cssjs + "L" + i + ".css");
            if(css.canRead())
            {
                t.setLayer(i,Filex.read(css.getPath(),"utf-8"),Filex.read(Common.REAL_PATH + prefix + cssjs + "L" + i + ".js","utf-8"));
            }
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            //db.executeQuery("SELECT cssjs FROM CssJs WHERE 1=1" + sql + " ORDER BY sequence",pos,size);
            db.executeQuery("SELECT c.cssjs,c.style,c.styletype,c.stylecategory,c.node,c.status,c.sequence,c.name,c.theme,c.picture FROM CssJs c INNER JOIN Node n ON c.node=n.node WHERE " + sql.substring(4),pos,size);
            while(db.next())
            {
                int j = 1;
                CssJs t = new CssJs(db.getInt(j++));
                t.style = db.getInt(j++);
                t.styletype = db.getInt(j++);
                t.stylecategory = db.getInt(j++);
                t.node = db.getInt(j++);
                t.status = db.getInt(j++);
                t.sequence = db.getInt(j++);
                t.name = db.getVarchar(1,1,j++);
                t.theme = db.getInt(j++) != 0;
                t.picture = db.getString(j++);
                t.prefix = "/res/" + Node.find(t.node).getCommunity() + "/cssjs/";
                t.exists = true;
                _cache.put(t.cssjs,t);
                al.add(t);
            }
        } finally
        {
            db.close();
        }
        return al;
    }

    public static Enumeration findByNode(int node) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT cssjs FROM CssJs WHERE node=" + node + " AND (style=0 OR style=1 OR style=2) ORDER BY sequence");
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

    public void delete(int language) throws SQLException
    {
        _htLayer.clear();
        if(language == 1)
        {
            File file = new File(Common.REAL_PATH + prefix + cssjs + ".css");
            if(file.exists())
            {
                file.delete();
            }
            file = new File(Common.REAL_PATH + prefix + cssjs + ".js");
            if(file.exists())
            {
                file.delete();
            }
        }
        File file = new File(Common.REAL_PATH + prefix + cssjs + "L" + language + ".css");
        if(file.exists())
        {
            file.delete();
        }
        file = new File(Common.REAL_PATH + prefix + cssjs + "L" + language + ".js");
        if(file.exists())
        {
            file.delete();
        }
        // 判断其它语言层是否存在.
        file = new File(Common.REAL_PATH + prefix + cssjs + ".css");
        if(file.exists())
        {
            return;
        }
        for(int i = 0;i < Common.CHATSET.length;i++)
        {
            file = new File(Common.REAL_PATH + prefix + cssjs + "L" + i + ".css");
            if(file.exists())
            {
                return;
            }
        }
        // 如果其它语言层不存在,则删除此条记录
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(cssjs,"DELETE FROM CssJs WHERE cssjs=" + cssjs);
        } finally
        {
            db.close();
        }
        this.exists = false;
        _cache.remove(new Integer(cssjs));
    }

    public static CssJs find(int cssjs) throws SQLException
    {
        CssJs t = (CssJs) _cache.get(new Integer(cssjs));
        if(t == null)
        {
            ArrayList al = find(" AND c.cssjs=" + cssjs,0,1);
            t = al.size() < 1 ? new CssJs(cssjs) : (CssJs) al.get(0);
        }
        return t;
    }

    public Vector getLanguages() throws SQLException
    {
        Vector v = new Vector();
        for(int index = 0;index < Common.CHATSET.length;index++)
        {
            File file = new File(Common.REAL_PATH + prefix + cssjs + "L" + index + ".css");
            if(file.isFile())
            {
                v.addElement(new Integer(index));
            }
        }
        return v;
    }

    public String getCss(int language) throws IOException
    {
        return getLayer(language).css;
    }

    private Layer getLayer(int language) throws IOException
    {
        Layer l = (Layer) _htLayer.get(new Integer(language));
        if(l == null && exists)
        {
            l = new Layer();
            File f = new File(Common.REAL_PATH + prefix + cssjs + "L" + language + ".css");
            l.layerExisted = f.exists();
            if(!f.exists())
            {
                File tmp = f;
                if(language == 1)
                {
                    tmp = new File(Common.REAL_PATH + prefix + cssjs + "L2.css");
                } else if(language == 2)
                {
                    tmp = new File(Common.REAL_PATH + prefix + cssjs + "L1.css");
                }
                for(int i = 0;!tmp.exists() && i < Common.CHATSET.length;i++)
                {
                    tmp = new File(Common.REAL_PATH + prefix + cssjs + "L" + i + ".css"); //
                }
                if(tmp.exists())
                {
                    f = tmp;
                }
            }
            // css
            String cssap = f.getAbsolutePath();
            l.cssPath = prefix + f.getName();
            try
            {
                FileInputStream fis = new FileInputStream(f);
                byte by[] = new byte[(int) f.length()];
                fis.read(by);
                fis.close();
                l.css = new String(by,"UTF-8");
            } catch(FileNotFoundException ex)
            {
                l.css = "/* 该文件已丢失 */";
            }
            // js
            f = new File(cssap.substring(0,cssap.length() - 3) + "js");
            l.jsPath = prefix + f.getName();
            try
            {
                FileInputStream fis = new FileInputStream(f);
                byte by[] = new byte[(int) f.length()];
                fis.read(by);
                fis.close();
                l.js = new String(by,"UTF-8");
            } catch(FileNotFoundException ex)
            {
                l.js = "/* 该文件已丢失 */";
            }
            //_htLayer.put(new Integer(language), l);
        }
        return l;
    }

    public String getJs(int language) throws IOException
    {
        return getLayer(language).js;
    }

    public String getJsPath(int language) throws IOException
    {
        return getLayer(language).jsPath;
    }

    public boolean isTheme()
    {
        return theme;
    }

    public String getPicture()
    {
        return picture;
    }

    public int getStatus()
    {
        return status;
    }

    public int getSequence()
    {
        return sequence;
    }

    public int getStyleType()
    {
        return styletype;
    }

    public int getStyleCategory()
    {
        return stylecategory;
    }

    public boolean isLayerExisted(int language) throws IOException
    {
        return getLayer(language).layerExisted;
    }

    public String getCssPath(int language) throws IOException
    {
        return getLayer(language).cssPath;
    }

    public static ArrayList find(Node node,int status,boolean flag) throws SQLException
    {
        StringBuilder sql = new StringBuilder();
        sql.append(" AND c.status=" + status + " AND (");
        //本节点///////////////////////////////////////////////
        sql.append("(");
        if(flag)
        {
            sql.append(" c.style=0 AND");
        }
        sql.append(" c.node=").append(node._nNode).append(")");
        //本树,类型为...///////////////////////////////////////////////
        sql.append(" OR ( c.style=2 AND ( c.styletype=255 OR ( c.styletype=").append(node.getType());
        if(node.getType() == 1)
        {
            Category c = Category.find(node._nNode);
            sql.append(" AND c.stylecategory=" + c.getCategory());
        }
        sql.append(" ) ) AND '" + node.getPath() + "' LIKE " + DbAdapter.concat("n.path","'%'"));
        sql.append(")");
        //
        sql.append(")");
        if(flag)
        {
            sql.append(" AND c.cssjs NOT IN (SELECT DISTINCT s.cssjs FROM CssJs s, CssJsHide sh ,Node n WHERE s.cssjs=sh.cssjs AND n.node=sh.node ");
            sql.append(" AND (( sh.hiden=0 AND ").append(DbAdapter.cite(node.getPath())).append(" LIKE ").append(DbAdapter.concat("n.path","'%'")).append(")").append(" OR (sh.hiden=2 AND ").append(DbAdapter.cite(node.getPath())).append(" LIKE n.path ) ").append(" OR ( sh.hiden=1 AND (").append(DbAdapter.cite(node.getPath())).append(" LIKE ").append(DbAdapter.concat("n.path","'%'")).append(") AND ( ").append(DbAdapter.cite(node.getPath())).append(" NOT LIKE n.path))))");
        }
        sql.append(" ORDER BY c.sequence");
        return find(sql.toString(),0,200);
    }

    public void setSequence(int sequence) throws SQLException
    {
        DbAdapter.execute("UPDATE cssjs SET sequence=" + sequence + " WHERE cssjs=" + cssjs);
        this.sequence = sequence;
    }

    //
    public CssJs clone() throws CloneNotSupportedException
    {
        CssJs t = (CssJs)super.clone();
        t.cssjs = 0;
        return t;
    }
}
