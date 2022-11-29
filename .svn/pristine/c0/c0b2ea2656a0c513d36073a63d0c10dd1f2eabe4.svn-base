package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.util.*;

public class Outside
{
    protected static Cache c = new Cache(50);
    public int node; //校外机构
    public int language;
    public String member = "|"; //管理员
    public int city; //城市
    public String website; //网址
    public String tel; //电话
    public String qq;
    public String address; //地址
    public String bus; //乘车路线
    public String map; //地图

    public Outside(int node,int language)
    {
        this.node = node;
        this.language = language;
    }

    public static Outside find(int node,int language) throws SQLException
    {
        Outside t = (Outside) c.get(node + ":" + language);
        if(t == null)
        {
            ArrayList al = find(" AND node=" + node + " AND language=" + language,0,1);
            t = al.size() < 1 ? new Outside(node,language) : (Outside) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT node,language,member,city,website,tel,qq,address,bus,map FROM outside WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Outside t = new Outside(rs.getInt(i++),rs.getInt(i++));
                t.member = rs.getString(i++);
                t.city = rs.getInt(i++);
                t.website = rs.getString(i++);
                t.tel = rs.getString(i++);
                t.qq = rs.getString(i++);
                t.address = rs.getString(i++);
                t.bus = rs.getString(i++);
                t.map = rs.getString(i++);
                c.put(t.node,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM outside WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate("INSERT INTO outside(node,language,member,city,website,tel,qq,address,bus,map)VALUES(" + node + "," + language + "," + DbAdapter.cite(member) + "," + city + "," + DbAdapter.cite(website) + "," + DbAdapter.cite(tel) + "," + DbAdapter.cite(qq) + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(bus) + "," + DbAdapter.cite(map) + ")");
            if(i < 1)
            {
                db.executeUpdate("UPDATE outside SET node=" + node + ",language=" + language + ",member=" + DbAdapter.cite(member) + ",city=" + city + ",website=" + DbAdapter.cite(website) + ",tel=" + DbAdapter.cite(tel) + ",qq=" + DbAdapter.cite(qq) + ",address=" + DbAdapter.cite(address) + ",bus=" + DbAdapter.cite(bus) + ",map=" + DbAdapter.cite(map) + " WHERE node=" + node);
            }
        } finally
        {
            db.close();
        }
        c.remove(node);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM outside WHERE node=" + node);
        c.remove(node);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE outside SET " + f + "=" + DbAdapter.cite(v) + " WHERE node=" + node);
        c.remove(node);
    }

    //
    public String getDetail(Node n,Http h,int listing,String target) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        String subject = n.getSubject(h.language);
        ListingDetail detail = ListingDetail.find(listing,100,h.language);
        Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
                continue;

            String url = "/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/outside/" + node + "-" + h.language + ".htm";
            String bi = detail.getBeforeItem(name),ai = detail.getAfterItem(name);
            //int dq = detail.getQuantity(name);
            if(name.equals("subject"))
            {
                value = subject;
            } else if(name.equals("content"))
                value = n.getText(h.language);
            else if(name.equals("city"))
                value = Card.find(city).toString();
            //else if(name.equals("picture"))
            //    value = picture == null ? null : "<img src='" + picture + "' />";
            else if(name.equals("map"))
            {
                if(map != null && map.length() > 0)
                    value = "<iframe src='/jsp/admin/map/ViewGMap.jsp?node=" + n._nNode + "&point=" + map + "' frameborder='0' scrolling='no' width='600' height='500'></iframe>";
                else if(istype == 2)
                    continue;
            } else
            {
                try
                {
                    Object tmp = Class.forName("tea.entity.node.Outside").getField(name).get(this);
                    if(tmp != null)
                    {
                        if(tmp instanceof Date)
                            value = MT.f((Date) tmp);
                        else
                            value = tmp.toString();
                    }
                } catch(Exception ex)
                {
                }
            }

            if(value == null)
                value = "";
            if(istype == 2 && value.length() < 1)
                continue;

            //限制字数
            value = detail.getOptionsToHtml(name,n,value);

            //显示连接的地方
            if(detail.getAnchor(name) != 0)
            {
                value = "<a href='" + url + "' target='" + target + "' title=\"" + subject.replace('"','\'') + "\">" + value + "</a>";
            }
            sb.append(bi).append("<span id='OutsideID" + name + "'>" + value + "</span>").append(ai);
        }
        return sb.toString();
    }

}
