package tea.entity.site;

import java.sql.*;
import java.util.*;
import java.util.regex.*;
import tea.db.*;
import tea.entity.*;

public class Dynamic extends Entity
{
    private static Cache _cache = new Cache(100);
    private Hashtable _htLayer;
    private int dynamic;
    private String community;
    private String type;
    private int sort; // 0:动态类,1:合同,2:oa表单
    private String dtfb; //事务名称,这是存的是DynamicType的主键
    private int dtst; //事务结束时间,同上
    private String bindfc; //绑定,文件中心的那个字段//格式:/字段名:dt的主键/...
    private boolean exists;
    class Layer
    {
        private boolean layerExists;
        private String name;
        private String template;
    }


    public Dynamic(int dynamic) throws SQLException
    {
        this.dynamic = dynamic;
        _htLayer = new Hashtable();
        load();
    }

    public static Dynamic find(int dynamic) throws SQLException
    {
        Dynamic node = (Dynamic) _cache.get(new Integer(dynamic));
        if(node == null)
        {
            node = new Dynamic(dynamic);
            _cache.put(new Integer(dynamic),node);
        }
        return node;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,type,sort,dtfb,dtst,bindfc FROM Dynamic WHERE dynamic=" + dynamic);
            if(db.next())
            {
                community = db.getString(1);
                type = db.getString(2);
                sort = db.getInt(3);
                dtfb = db.getString(4);
                dtst = db.getInt(5);
                bindfc = db.getString(6);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
        if(dtfb == null)
        {
            dtfb = "/";
        }
    }

    public static Enumeration find(String sql) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT dynamic FROM Dynamic WHERE 1=1" + sql + " ORDER BY sort");
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

    public static Enumeration findByCommunity(String community,int sort) throws SQLException
    {
        CLicense cl = CLicense.find(community);
        String type = cl.getType();
        StringBuffer sb = new StringBuffer();
        sb.append(" AND dynamic IN (").append(type.replaceAll("/",",").substring(1,type.length() - 1)).append(")");
        if(sort != -1)
        {
            sb.append(" AND sort=").append(sort);
        }
        return find(sb.toString());
    }

    public static Enumeration findBy(String community,int sort) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            //db.executeQuery("SELECT dynamic FROM Dynamic WHERE community=" + DbAdapter.cite(community) + " AND sort=" + sort);
            db.executeQuery("SELECT dynamic FROM Dynamic WHERE community=" + DbAdapter.cite(community));
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

    public static int create(String community,String type,int sort,int language,String name,String template) throws SQLException
    {
        int dynamic = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Dynamic (community,type,sort,dtfb,bindfc)VALUES (" + DbAdapter.cite(community) + "," + DbAdapter.cite(type) + "," + sort + ",'/','/')");
            dynamic = db.getInt("SELECT MAX(dynamic) FROM Dynamic");
            db.executeUpdate("INSERT INTO DynamicLayer (dynamic, language, name,template)VALUES (" + dynamic + ", " + language + ", " + DbAdapter.cite(name) + ", " + DbAdapter.cite(template) + ")");
        } finally
        {
            db.close();
        }
        CLicense.find(community).add(dynamic);
        return dynamic;
    }

    public void set(String type,int language,String name,String template) throws SQLException
    {
        StringBuffer sql = new StringBuffer();
        sql.append("UPDATE DynamicLayer SET name=" + DbAdapter.cite(name));
        if(template != null)
        {
            sql.append(",template=").append(DbAdapter.cite(template));
        }
        sql.append(" WHERE dynamic=" + dynamic + " AND language=" + language);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Dynamic SET type=" + DbAdapter.cite(type) + " WHERE dynamic=" + dynamic);
            int j = db.executeUpdate(sql.toString());
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO DynamicLayer (dynamic, language, name)VALUES (" + dynamic + ", " + language + ", " + DbAdapter.cite(name) + ")");
            }
        } finally
        {
            db.close();
        }
        this.type = type;
        _htLayer.clear();
    }

    public void delete(int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM DynamicLayer WHERE dynamic=" + dynamic + "   AND language=" + language);
            db.executeQuery("SELECT dynamic FROM DynamicLayer WHERE dynamic=" + dynamic);
            if(!db.next())
            {
                db.executeUpdate("DELETE FROM Dynamic WHERE dynamic=" + dynamic);
            }
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(dynamic));
    }

    private Layer getLayer(int i) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(i));
        if(layer == null)
        {
            layer = new Layer();
            int j = this.getLanguage(i);
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT name,template FROM DynamicLayer WHERE dynamic=" + dynamic + " AND language=" + j);
                if(db.next())
                {
                    layer.name = db.getVarchar(j,i,1);
                    layer.template = db.getString(2);
                    layer.layerExists = j == i;
                }
            } finally
            {
                db.close();
            }
            _htLayer.put(new Integer(i),layer);
        }
        return layer;
    }

    public void clone(int language) throws SQLException
    {
        int newid = Dynamic.create(community,type,sort,language,"『复件』 " + getName(language),getTemplate(language));
        Enumeration e = DynamicType.findByDynamic(dynamic);
        while(e.hasMoreElements())
        {
            int dt = ((Integer) e.nextElement()).intValue();
            DynamicType t = DynamicType.find(dt);
            DynamicType.create(newid,t.getType(),t.getSequence(),t.isHidden(),t.isNeed(),t.isQrc(),t.getDefaultvalue(),t.getFilecenter(),t.getBinding(),t.isSync(),t.isMulti(),t.getWidth(),t.getHeight(),0,t.getQuantity(),t.getColumns(),t.getColumnAfter(),t.isSeparate(),t.isExport(),language,t.getName(language),t.getContent(language),t.getBefore(language),t.getAfter(language));
        }
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM DynamicLayer WHERE dynamic=" + dynamic);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        if(v.indexOf(new Integer(language)) != -1)
        {
            return language;
        } else
        {
            if(language == 1)
            {
                if(v.indexOf(new Integer(2)) != -1)
                {
                    return 2;
                }
            } else if(language == 2)
            {
                if(v.indexOf(new Integer(1)) != -1)
                {
                    return 1;
                }
            }
            if(v.size() < 1)
            {
                return 0;
            }
        }
        return((Integer) v.elementAt(0)).intValue();
    }

    public int getDynamic()
    {
        return dynamic;
    }

    public String getCommunity()
    {
        return community;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getType()
    {
        return type;
    }

    public int getSort()
    {
        return sort;
    }

    public String getDtfb()
    {
        return dtfb;
    }

    public int getDtst()
    {
        return dtst;
    }

    public int getBindfc(String field)
    {
        int i = 0;
        Matcher m = Pattern.compile("/" + field + ":(\\d+)/").matcher(bindfc);
        if(m.find())
        {
            i = Integer.parseInt(m.group(1));
        }
        return i;
    }

    public String getBindfc(int fc)
    {
        String rs = null;
        Matcher m = Pattern.compile("/([^/]+):" + fc + "/").matcher(bindfc);
        if(m.find())
        {
            rs = m.group(1);
        }
        return rs;
    }

    public String getName(int language) throws SQLException
    {
        return getLayer(language).name;
    }

    public String getTemplate(int language) throws SQLException
    {
        return getLayer(language).template;
    }

    public boolean isLayerExists(int language) throws SQLException
    {
        return getLayer(language).layerExists;
    }

    public void setDtfb(String dtfb) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Dynamic SET dtfb=" + DbAdapter.cite(dtfb) + " WHERE dynamic=" + dynamic);
        } finally
        {
            db.close();
        }
        this.dtfb = dtfb;
    }

    public void setDtst(int dtst) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Dynamic SET dtst=" + dtst + " WHERE dynamic=" + dynamic);
        } finally
        {
            db.close();
        }
        this.dtst = dtst;
    }

    //字段,值
    public void setBindfc(String field,int fc) throws SQLException
    {
        if(bindfc == null || bindfc.length() < 1)
        {
            bindfc = "/";
        } else
        {
            bindfc = bindfc.replaceFirst("/" + field + ":[\\d]+/","/").replaceFirst("/[^/]+:" + fc + "/","/");
        }
        bindfc = bindfc + field + ":" + fc + "/";
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Dynamic SET bindfc=" + db.cite(bindfc) + " WHERE dynamic=" + dynamic);
        } finally
        {
            db.close();
        }
    }

    //获取某个节点的编号
    public String getCode(int node) throws SQLException
    {
        String code = null;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT dv.value FROM DynamicType dt INNER JOIN DynamicValue dv ON dv.dynamictype=dt.dynamictype WHERE dt.dynamic=" + dynamic + " AND dt.type='code' AND dv.node=" + node);
            if(db.next())
            {
                code = db.getString(1);
            }
        } finally
        {
            db.close();
        }
        return code;
    }

}
