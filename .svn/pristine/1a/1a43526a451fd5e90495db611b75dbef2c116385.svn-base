package tea.entity.weixin;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.site.*;

public class WxMenu extends Entity implements Cloneable
{
    public int menu; //微信菜单
    public String community; //社区
    public int father; //父菜单
    public String name; //菜单标题
    //scancode_push:扫码(停留) scancode_waitmsg:扫码  pic_sysphoto:发图(拍照) pic_photo_or_album:发图(菜单) pic_weixin:发图(相册)
    public static String[] MENU_TYPE =
            {"--","页面","事件","节点","扫一扫","图片","位置"};
    static String[] MENU_CODE =
            {"--","view","click","click","scancode_waitmsg","pic_photo_or_album","location_select"};
    public int type; //类型
    public String eventkey; //菜单KEY值，用于消息接口推送，不超过128字节
    public String url; //网页链接，用户点击菜单可打开链接，不超过256字节
    public boolean hidden; //显示/隐藏
    public int sequence; //顺序

    public WxMenu(int menu)
    {
        this.menu = menu;
    }

    public static WxMenu find(int menu) throws SQLException
    {
        WxMenu t = (WxMenu) _cache.get(menu);
        if(t == null)
        {
            ArrayList al = find(" AND menu=" + menu,0,1);
            t = al.size() < 1 ? new WxMenu(menu) : (WxMenu) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT menu,community,father,name,type,eventkey,url,hidden,sequence FROM wxmenu WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                WxMenu t = new WxMenu(rs.getInt(i++));
                t.community = rs.getString(i++);
                t.father = rs.getInt(i++);
                t.name = rs.getString(i++);
                t.type = rs.getInt(i++);
                t.eventkey = rs.getString(i++);
                t.url = rs.getString(i++);
                t.hidden = rs.getBoolean(i++);
                t.sequence = rs.getInt(i++);
                _cache.put(t.menu,t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM wxmenu WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(menu < 1)
            sql = "INSERT INTO wxmenu(menu,community,father,name,type,eventkey,url,hidden,sequence)VALUES(" + (menu = Seq.get()) + "," + DbAdapter.cite(community) + "," + father + "," + DbAdapter.cite(name) + "," + type + "," + DbAdapter.cite(eventkey) + "," + DbAdapter.cite(url) + "," + DbAdapter.cite(hidden) + "," + sequence + ")";
        else
            sql = "UPDATE wxmenu SET community=" + DbAdapter.cite(community) + ",father=" + father + ",name=" + DbAdapter.cite(name) + ",type=" + type + ",eventkey=" + DbAdapter.cite(eventkey) + ",url=" + DbAdapter.cite(url) + ",hidden=" + DbAdapter.cite(hidden) + ",sequence=" + sequence + " WHERE menu=" + menu;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(menu,sql);
        } finally
        {
            db.close();
        }
        _cache.remove(menu);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(menu,"DELETE FROM wxmenu WHERE menu=" + menu);
        } finally
        {
            db.close();
        }
        _cache.remove(menu);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(menu,"UPDATE wxmenu SET " + f + "=" + DbAdapter.cite(v) + " WHERE menu=" + menu);
        } finally
        {
            db.close();
        }
        _cache.remove(menu);
    }

    //
    public static WxMenu getRoot(String community,int type) throws SQLException
    {
        Iterator it = find(" AND father=0 AND type=" + type + " AND community=" + DbAdapter.cite(community),0,1).iterator();
        if(it.hasNext())
        {
            return(WxMenu) it.next();
        }
        WxMenu ro = new WxMenu(0);
        ro.community = community;
        ro.name = "菜单管理";
        ro.type = type;
        ro.set();
        return ro;
    }

    public String toString()
    {
        StringBuilder sb = new StringBuilder("{'button':[");
        try
        {
            ArrayList ali = WxMenu.find(" AND father=" + menu + " AND hidden=0 ORDER BY sequence",0,200);
            for(int i = 0;i < ali.size();i++)
            {
                WxMenu t = (WxMenu) ali.get(i);
                if(i > 0)
                    sb.append(",");
                sb.append("{'name':'" + t.name + "'");
                ArrayList alj = WxMenu.find(" AND father=" + t.menu + " AND hidden=0 ORDER BY sequence",0,200);
                if(alj.size() < 1)
                {
                    sb.append(",'type':'" + MENU_CODE[t.type] + "'");
                    sb.append(",'key':'" + t.menu + "'");
                    sb.append(",'url':'" + f(t.url) + "'");
                } else
                {
                    sb.append(",'sub_button':[");
                    for(int j = 0;j < alj.size();j++)
                    {
                        t = (WxMenu) alj.get(j);
                        if(j > 0)
                            sb.append(",");
                        sb.append("{'name':'" + t.name + "'");
                        sb.append(",'type':'" + MENU_CODE[t.type] + "'");
                        sb.append(",'key':'" + t.menu + "'");
                        sb.append(",'url':'" + f(t.url) + "'}");
                    }
                    sb.append("]");
                }
                sb.append("}");
            }
        } catch(Throwable ex)
        {
            ex.printStackTrace();
        }
        return sb.append("]}").toString().replace('\'','"');
    }

    //网址转为绝对
    String f(String url) throws SQLException
    {
        if(type == 1 && url.startsWith("/"))
            url = "http://" + Community.find(community).webName + url;
        return url;
    }

    public String options(int v) throws SQLException
    {
        StringBuilder htm = new StringBuilder();
        Iterator it = find(" AND father=" + menu,0,200).iterator();
        while(it.hasNext())
        {
            WxMenu t = (WxMenu) it.next();
            htm.append("<option value=" + t.menu);
            if(v == t.menu)
                htm.append(" selected");
            htm.append(">" + t.name);
        }
        return htm.toString();
    }

    public WxMenu clone() throws CloneNotSupportedException
    {
        WxMenu t = (WxMenu)super.clone();
        t.menu = 0;
        return t;
    }

    public WxMenu clone(int father) throws CloneNotSupportedException,SQLException
    {
        WxMenu f = clone();
        f.father = father;
        f.set();
        Iterator it = find(" AND father=" + menu,0,200).iterator();
        while(it.hasNext())
        {
            WxMenu t = (WxMenu) it.next();
            t.clone(f.menu);
        }
        return f;
    }

}
