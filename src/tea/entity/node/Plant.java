package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class Plant
{
    protected static Cache c = new Cache(50);
    public int node;
    public String[] species = new String[2]; //种名
    public String[] family = new String[2]; //科名
    public String genus; //属名
    public String mutation; //种下名称
    public String author; //命名人
    public String latin; //拉丁名
    public String endangered; //濒危
    public String endanger; //濒危因素
    public String ndistribution; //国内分布
    public String idistribution; //国外分布
    public String altitude; //高度
    public String zyglm; //资源归类码

    public Plant(int node)
    {
        this.node = node;
    }

    public static Plant find(int node) throws SQLException
    {
        Plant t = (Plant) c.get(node);
        if(t == null)
        {
            ArrayList al = find(" AND node=" + node,0,1);
            t = al.size() < 1 ? new Plant(node) : (Plant) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT node,species1,species0,family1,family0,genus,mutation,author,latin,endangered,endanger,ndistribution,idistribution,altitude,zyglm FROM plant WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Plant t = new Plant(rs.getInt(i++));
                t.species[1] = rs.getString(i++);
                t.species[0] = rs.getString(i++);
                t.family[1] = rs.getString(i++);
                t.family[0] = rs.getString(i++);
                t.genus = rs.getString(i++);
                t.mutation = rs.getString(i++);
                t.author = rs.getString(i++);
                t.latin = rs.getString(i++);
                t.endangered = rs.getString(i++);
                t.endanger = rs.getString(i++);
                t.ndistribution = rs.getString(i++);
                t.idistribution = rs.getString(i++);
                t.altitude = rs.getString(i++);
                t.zyglm = rs.getString(i++);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM plant WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate("INSERT INTO plant(node,species1,species0,family1,family0,genus,mutation,author,latin,endangered,endanger,ndistribution,idistribution,altitude,zyglm)VALUES(" + node + "," + DbAdapter.cite(species[1]) + "," + DbAdapter.cite(species[0]) + "," + DbAdapter.cite(family[1]) + "," + DbAdapter.cite(family[0]) + "," + DbAdapter.cite(genus) + "," + DbAdapter.cite(mutation) + "," + DbAdapter.cite(author) + "," + DbAdapter.cite(latin) + "," + DbAdapter.cite(endangered) + "," + DbAdapter.cite(endanger) + "," + DbAdapter.cite(ndistribution) + "," + DbAdapter.cite(idistribution) + "," + DbAdapter.cite(altitude) + "," + DbAdapter.cite(zyglm) + ")");
            if(i < 1)
            {
                db.executeUpdate("UPDATE plant SET species1=" + DbAdapter.cite(species[1]) + ",species0=" + DbAdapter.cite(species[0]) + ",family1=" + DbAdapter.cite(family[1]) + ",family0=" + DbAdapter.cite(family[0]) + ",genus=" + DbAdapter.cite(genus) + ",mutation=" + DbAdapter.cite(mutation) + ",author=" + DbAdapter.cite(author) + ",latin=" + DbAdapter.cite(latin) + ",endangered=" + DbAdapter.cite(endangered) + ",endanger=" + DbAdapter.cite(endanger) + ",ndistribution=" + DbAdapter.cite(ndistribution) + ",idistribution=" + DbAdapter.cite(idistribution) + ",altitude=" + DbAdapter.cite(altitude) + ",zyglm=" + DbAdapter.cite(zyglm) + " WHERE node=" + node);
            }
        } finally
        {
            db.close();
        }
        c.remove(node);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM plant WHERE node=" + node);
        c.remove(node);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE plant SET " + f + "=" + DbAdapter.cite(v) + " WHERE node=" + node);
        c.remove(node);
    }

    //
    public static String getDetail(Node n,Http h,int listing,String target) throws SQLException
    {
        StringBuilder htm = new StringBuilder();
        String subject = n.getSubject(h.language);
        ListingDetail detail = ListingDetail.find(listing,104,h.language);
        Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
                continue;

            String url = "/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/plant/" + n._nNode + "-" + h.language + ".htm";
            String bi = detail.getBeforeItem(name),ai = detail.getAfterItem(name);
            //int dq = detail.getQuantity(name);
            if(name.equals("subject"))
            {
                value = subject;
            } else if(name.equals("content"))
                value = n.getText(h.language);
            else if(name.equals("picture"))
            {
                String picture = n.getPicture(h.language);
                value = picture == null ? null : "<img src='" + picture + "' />";
            } else if(name.equals("specimen")) //标本列表
            {
                StringBuilder sb = new StringBuilder();
                Iterator it = Specimen.find(" AND species1=" + DbAdapter.cite(subject),0,100).iterator();
                while(it.hasNext())
                {
                    Specimen s = (Specimen) it.next();
                    sb.append("<a href='/html/" + h.community + "/specimen/" + s.node + "-" + h.language + ".htm'>" + subject + "<span class='time'>[" + MT.f(s.ctime) + "]</span></a>");
                }
                value = sb.toString();
            } else if(name.equals("map")) //标本地图
            {
                value = "<iframe src='/jsp/type/specimen/GMapView.jsp?species=" + Http.enc(subject) + "' frameborder='0' scrolling='no' width='600' height='500'></iframe>";
            } else
            {
                Plant t = Plant.find(n._nNode);
                if(name.equals("species0"))
                    value = t.species[0];
                else if(name.equals("species1"))
                    value = t.species[1];
                else if(name.equals("family0"))
                    value = t.family[0];
                else if(name.equals("family1"))
                    value = t.family[1];
                else
                    try
                    {
                        Object tmp = Class.forName("tea.entity.node.Plant").getField(name).get(t);
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
            htm.append(bi).append("<span id='PlantID" + name + "'>" + value + "</span>").append(ai);
        }
        return htm.toString();
    }
}
