package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.resource.Common;

public class Animal extends Entity
{
    public int node;
    public static String[] ANIMAL_TYPE =
            {"--","兽类","鸟类"};
    public int type; //种类
    public String picture; //图片数
    public int wzdm; //关链:b_img.b_id
    public String code; //物种代码
    public String name;
    public String latin; //拉丁名字
    public String cites; //中国动物CITES公约名录等级
    public String iucn; //世界自然保护联盟
    public String alevel; //保护级别
    public String rlevel; //红色名录等级
    public String city; //分布省份
    public String reserve; //保护区分布
    public String range; //分布山脉
    public String endanger; //濒危因素
    public String environment; //生长环境
    public String feature; //特征
    public String genus; //属名
    public String family; //科名
    public String order1; //目名
    public int iattch; //红外相机 首选图
    private int album; //关联组图类
    public Animal(int node)
    {
        this.node = node;
    }

    public int getAlbum() {
		return album;
	}

	public void setAlbum(int album) {
		this.album = album;
	}

	public static Animal find(int node) throws SQLException
    {
        Animal t = (Animal) _cache.get(node);
        if(t == null)
        {
            ArrayList al = find(" AND node=" + node,0,1);
            t = al.size() < 1 ? new Animal(node) : (Animal) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT node,type,picture,wzdm,code,name,latin,cites,iucn,alevel,rlevel,city,reserve,range,endanger,environment,feature,genus,family,order1,iattch,album FROM animal WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Animal t = new Animal(rs.getInt(i++));
                t.type = rs.getInt(i++);
                t.picture = rs.getString(i++);
                t.wzdm = rs.getInt(i++);
                t.code = rs.getString(i++);
                t.name = rs.getString(i++);
                t.latin = rs.getString(i++);
                t.cites = rs.getString(i++);
                t.iucn = rs.getString(i++);
                t.alevel = rs.getString(i++);
                t.rlevel = rs.getString(i++);
                t.city = rs.getString(i++);
                t.reserve = rs.getString(i++);
                t.range = rs.getString(i++);
                t.endanger = rs.getString(i++);
                t.environment = rs.getString(i++);
                t.feature = rs.getString(i++);
                t.genus = rs.getString(i++);
                t.family = rs.getString(i++);
                t.order1 = rs.getString(i++);
                t.iattch = rs.getInt(i++);
                t.album = rs.getInt(i++);
                _cache.put(t.node,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM animal WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate("INSERT INTO animal(node,type,picture,wzdm,code,name,latin,cites,iucn,alevel,rlevel,city,reserve,range,endanger,environment,feature,genus,family,order1,iattch,album)VALUES(" + node + "," + type + "," + DbAdapter.cite(picture) + "," + wzdm + "," + DbAdapter.cite(code) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(latin) + "," + DbAdapter.cite(cites) + "," + DbAdapter.cite(iucn) + "," + DbAdapter.cite(alevel) + "," + DbAdapter.cite(rlevel) + "," + DbAdapter.cite(city) + "," + DbAdapter.cite(reserve) + "," + DbAdapter.cite(range) + "," + DbAdapter.cite(endanger) + "," + DbAdapter.cite(environment) + "," + DbAdapter.cite(feature) + "," + DbAdapter.cite(genus) + "," + DbAdapter.cite(family) + "," + DbAdapter.cite(order1) + "," + iattch +","+ album+")");
            if(i < 1)
            {
                db.executeUpdate("UPDATE animal SET node=" + node + ",type=" + type + ",picture=" + DbAdapter.cite(picture) + ",wzdm=" + wzdm + ",code=" + DbAdapter.cite(code) + ",name=" + DbAdapter.cite(name) + ",latin=" + DbAdapter.cite(latin) + ",cites=" + DbAdapter.cite(cites) + ",iucn=" + DbAdapter.cite(iucn) + ",alevel=" + DbAdapter.cite(alevel) + ",rlevel=" + DbAdapter.cite(rlevel) + ",city=" + DbAdapter.cite(city) + ",reserve=" + DbAdapter.cite(reserve) + ",range=" + DbAdapter.cite(range) + ",endanger=" + DbAdapter.cite(endanger) + ",environment=" + DbAdapter.cite(environment) + ",feature=" + DbAdapter.cite(feature) + ",genus=" + DbAdapter.cite(genus) + ",family=" + DbAdapter.cite(family) + ",order1=" + DbAdapter.cite(order1) + ",iattch=" + iattch + ",album="+album+" WHERE node=" + node);
            }
        } finally
        {
            db.close();
        }
        _cache.remove(node);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM animal WHERE node=" + node);
        _cache.remove(node);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE animal SET " + f + "=" + DbAdapter.cite(v) + " WHERE node=" + node);
        _cache.remove(node);
    }

    //
    public static String getDetail(Node n,Http h,int listing,String target) throws SQLException,IOException
    {
        StringBuilder htm = new StringBuilder();
        String subject = n.getSubject(h.language);
        ListingDetail detail = ListingDetail.find(listing,103,h.language);
        Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
                continue;

            String url = "/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/animal/" + n._nNode + "-" + h.language + ".htm";
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
                if(picture != null && picture.length() > 1)
                {
                    int aid = Integer.parseInt(picture.split("[|]")[1]);
                    Attch a = Attch.find(aid);
                    value = "<img src='" + a.path2 + "' />";
                }
            } else if(name.equals("specimen")) //标本列表
            {
                StringBuilder sb = new StringBuilder();
                Iterator it = Specimen.find(" AND species1=" + DbAdapter.cite(subject),0,200).iterator();
                while(it.hasNext())
                {
                    Specimen s = (Specimen) it.next();
                    sb.append("<a href='/html/" + h.community + "/specimen/" + s.node + "-" + h.language + ".htm'>" + subject + "<span class='time'>[" + MT.f(s.ctime) + "]</span></a>");
                }
                value = sb.toString();
            } else if(name.equals("infrared")) //红外相机列表
            {
                StringBuilder sb = new StringBuilder();
                Iterator it = Infrared.find(" AND wzname=" + DbAdapter.cite(subject),0,200).iterator();
                while(it.hasNext())
                {
                    Infrared s = (Infrared) it.next();
                    sb.append("<a href='/html/" + h.community + "/infrared/" + s.node + "-" + h.language + ".htm'>" + subject + "<span class='time'>[" + MT.f(s.pstime) + "]</span></a>");
                }
                value = sb.toString();
            } else if(name.equals("map")) //标本地图
            {
                value = "<iframe src='/jsp/type/specimen/GMapView.jsp?species=" + Http.enc(subject) + "' frameborder='0' scrolling='no' width='600' height='500'></iframe>";
            } else
            {
                Animal t = Animal.find(n._nNode);
                if(name.equals("type")){
                    value = Animal.ANIMAL_TYPE[t.type];}
                else if("album".equals(name))
                {
                    //关联组图
                    if(t.getAlbum() > 0)
                    {
                        value = "<script>var a_node=" + t.getAlbum() + ",a_father=" + Node.find(t.getAlbum()).getFather() + ";</script>" + Filex.read(Common.REAL_PATH + "/jsp/type/album/AlbumModule.htm","utf-8");

                    }
                }else
                    try
                    {
                        Object tmp = Class.forName("tea.entity.node.Animal").getField(name).get(t);
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
            htm.append(bi).append("<span id='AnimalID" + name + "'>" + value + "</span>").append(ai);
        }
        return htm.toString();
    }
}
