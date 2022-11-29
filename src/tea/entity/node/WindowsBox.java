package tea.entity.node;

import java.sql.*;

import tea.db.*;
import tea.entity.*;
import java.util.*;
import tea.resource.*;

public class WindowsBox
{
    private static Cache _cache = new Cache(100);
    private Hashtable _htLayer = new Hashtable();
    private int node;
    private int code;
    private boolean hidden;
    private boolean exists;
    class Layer
    {
        String name;
    }


    public static WindowsBox find(int node, int code) throws SQLException
    {
        WindowsBox obj = (WindowsBox) _cache.get(node + ":" + code);
        if (obj == null)
        {
            obj = new WindowsBox(node, code);
            _cache.put(node + ":" + code, obj);
        }
        return obj;
    }

    public WindowsBox(int node, int code) throws SQLException
    {
        this.node = node;
        this.code = code;
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT hidden FROM WindowsBox WHERE node=" + node + " AND code=" + code);
            if (db.next())
            {
                hidden = db.getInt(1) != 0;
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

    private Layer getLayer(int i) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(i));
        if (layer == null)
        {
            layer = new Layer();
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT name FROM WindowsBoxLayer WHERE node=" + node + " AND code=" + code + " AND language=" + i);
                if (db.next())
                {
                    layer.name = db.getVarchar(i, i, 1);
                } else
                {
                    Resource r = new Resource("/tea/resource/Windows");
                    switch (code)
                    {
                    case 0:
                        layer.name = r.getString(i, "fj0vgqwb"); // "公告板";
                        break;
                        //
                    case 1:
                        layer.name = r.getString(i, "fj0vgqw4"); //"公司简介";
                        break;
                    case 2:
                        layer.name = r.getString(i, "fj0vgqw8"); //"公司概况";
                        break;
                    case 3:
                        layer.name = r.getString(i, "fj0vgqw9"); // "公司资质";
                        break;
                    case 4:
                        layer.name = r.getString(i, "fj0vgqw7"); // "联系我们";
                        break;
                        //
                    case 5:
                        layer.name = r.getString(i, "fj0vgqwl"); //"焦点要闻";
                        break;
                        //
                    case 6:
                        layer.name = r.getString(i, "fj0vgqwm"); //"公司新闻";
                        break;
                    case 7:
                        layer.name = r.getString(i, "fj0vgqwd"); //"企业文化";
                        break;
                    case 8:
                        layer.name = r.getString(i, "fj0vgqwb"); // "企业文化";
                        break;
                        //
                    case 9:
                        layer.name = r.getString(i, "fj0vgqw5"); // "在线招聘";
                        break;
                    case 10:
                        layer.name = r.getString(i, "fj0vgqwb"); // "AD";
                        break;
                    case 11:
                        layer.name = r.getString(i, "fj0vgqwb"); // "AD";
                        break;
                    case 12:
                        layer.name = r.getString(i, "fj0vgqwb"); // "AD";
                        break;
                    case 13:
                        layer.name = r.getString(i, "fj0vgqwb"); //"AD";
                        break;
                        //
                    case 14:
                        layer.name = r.getString(i, "fj0vgqw3"); //"产品服务";
                        break;
                    case 15:
                        layer.name = r.getString(i, "fj0vgqwn"); //"最近更新的第一站";
                        break;
                    case 16:
                        layer.name = r.getString(i, "fj0vgqwi"); // "最近访客";
                        break;
                    case 17:
                        layer.name = r.getString(i, "fj0vgqwe"); //"合作伙伴/客户";
                        break;
                    case 18:
                        layer.name = r.getString(i, "fj0vgqw2"); // "新闻中心";
                        break;
                    case 19:
                        layer.name = r.getString(i, "fj0vgqw4"); // "公司简介"; //频道中的
                        break;
                    case 20:
                        layer.name = r.getString(i, "fj0vgqw6"); //"售后服务";
                        break;
                    }
                }
            } finally
            {
                db.close();
            }
            _htLayer.put(new Integer(i), layer);
        }
        return layer;
    }

    public void set(boolean hidden, int language, String name) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE WindowsBox SET hidden=" + DbAdapter.cite(hidden) + " WHERE node=" + node + " AND code=" + code);
            if (j < 1)
            {
                db.executeUpdate("INSERT INTO WindowsBox(node,code,hidden)VALUES(" + node + "," + code + "," + DbAdapter.cite(hidden) + ")");
            }
            if (language != -1)
            {
                j = db.executeUpdate("UPDATE WindowsBoxLayer SET name=" + DbAdapter.cite(name) + " WHERE node=" + node + " AND code=" + code + " AND language=" + language);
                if (j < 1)
                {
                    db.executeUpdate("INSERT INTO WindowsBoxLayer(node,code,language,name)VALUES(" + node + "," + code + "," + language + "," + DbAdapter.cite(name) + ")");
                }
                _htLayer.clear();
            }
        } finally
        {
            db.close();
        }
        this.hidden = hidden;
    }


    public int getNode()
    {
        return node;
    }

    public int getCode()
    {
        return code;
    }

    public boolean isHidden()
    {
        return hidden;
    }

    public String getName(int language) throws SQLException
    {
        return getLayer(language).name;
    }

    public boolean isExists()
    {
        return exists;
    }

    public void setHidden(boolean hidden) throws SQLException
    {
        set(hidden, -1, null);
    }
}
