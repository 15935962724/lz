package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.util.*;
import tea.resource.Common;

//102
public class Reserve
{
    protected static Cache c = new Cache(50);
    public int node;
    public int language;
    public String code;
    public static String[] LEVEL_TYPE =
            {"---","国家级","省级","县市级"};
    public int level; //级别
    public static String[] RESERVE_TYPE =
            {"---","森林生态","草原草甸","荒漠生态","湿地生态","海洋海岸","野生动物","野生植物","地质遗迹","古生物遗迹"};
    public int type; //类型
    public static String[] DEPT_TYPE =
            {"---","林业部门","环保部门","农业部门","海洋部门","地质部门","水利部门","国土部门","其他部门"};
    public int dept; //所属部门
    public int city; //地区
    public String adminarea; //行政区域
    public String protect; //主要保护对象
    public String map; //地图
    public float area; //总面积
    public int years; //批建时间
    public double longitude; //经度
    public double latitude; //纬度
    private int album; //关联组图类

    public int getAlbum() {
		return album;
	}

	public void setAlbum(int album) {
		this.album = album;
	}

	public Reserve(int node,int language)
    {
        this.node = node;
        this.language = language;
    }

    public static Reserve find(int node,int language) throws SQLException
    {
        Reserve t = (Reserve) c.get(node + ":" + language);
        if(t == null)
        {
            ArrayList al = find(" AND node=" + node + " AND language=" + language,0,1);
            t = al.size() < 1 ? new Reserve(node,language) : (Reserve) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT node,language,code,level,type,dept,city,adminarea,protect,map,area,years,longitude,latitude,album FROM reserve WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Reserve t = new Reserve(rs.getInt(i++),rs.getInt(i++));
                t.code = rs.getString(i++);
                t.level = rs.getInt(i++);
                t.type = rs.getInt(i++);
                t.dept = rs.getInt(i++);
                t.city = rs.getInt(i++);
                t.adminarea = rs.getString(i++);
                t.protect = rs.getString(i++);
                t.map = rs.getString(i++);
                t.area = rs.getFloat(i++);
                t.years = rs.getInt(i++);
                t.longitude = rs.getDouble(i++);
                t.latitude = rs.getDouble(i++);
                t.album = rs.getInt(i++);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM reserve WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate("INSERT INTO reserve(node,language,code,level,type,dept,city,adminarea,protect,map,area,years,longitude,latitude,album)VALUES(" + node + "," + language + "," + DbAdapter.cite(code) + "," + level + "," + type + "," + dept + "," + city + "," + DbAdapter.cite(adminarea) + "," + DbAdapter.cite(protect)+ "," + DbAdapter.cite(map) + "," + area + "," + years + "," + longitude + "," + latitude +","+album+ ")");
            if(i < 1)
            {
                db.executeUpdate("UPDATE reserve SET code=" + DbAdapter.cite(code) + ",level=" + level + ",type=" + type + ",dept=" + dept + ",city=" + city + ",adminarea=" + DbAdapter.cite(adminarea) + ",protect=" + DbAdapter.cite(protect)+ ",map=" + DbAdapter.cite(map) + ",area=" + area + ",years=" + years + ",longitude=" + longitude + ",latitude=" + latitude + ",album="+album+" WHERE node=" + node + " AND language=" + language);
            }
        } finally
        {
            db.close();
        }
        c.remove(node);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM reserve WHERE node=" + node + " AND language=" + language);
        c.remove(node + ":" + language);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE reserve SET " + f + "=" + DbAdapter.cite(v) + " WHERE node=" + node + " AND language=" + language);
        c.remove(node + ":" + language);
    }

    //
    public static String getDetail(Node n,Http h,int listing,String target) throws SQLException,IOException
    {
        StringBuilder sb = new StringBuilder();
        String subject = n.getSubject(h.language);
        ListingDetail detail = ListingDetail.find(listing,102,h.language);
        Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
                continue;

            String url = "/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/reserve/" + n._nNode + "-" + h.language + ".htm";
            String bi = detail.getBeforeItem(name),ai = detail.getAfterItem(name);
            //int dq = detail.getQuantity(name);
            if(name.equals("subject"))
            {
                value = subject;
            }else if(name.equals("content"))
                value = n.getText(h.language);
            else if(name.equals("picture"))
            {
                String picture = n.getPicture(h.language);
                value = picture == null ? null : "<img src='" + picture + "' />";
            } else
            {
                Reserve t = Reserve.find(n._nNode,h.language);
                if(name.equals("level"))
                {
                    value = LEVEL_TYPE[t.level];
                }else if("album".equals(name))
                {
                    //关联组图
                    if(t.getAlbum() > 0)
                    {
                    	if(h.status==1){
                    		value="<include src='/jsp/leo/album/reserveAlbum.jsp'/>";
                    	}else{
                    			value = "<script>var a_node=" + t.getAlbum() + ",a_father=" + Node.find(t.getAlbum()).getFather() + ";</script>" + Filex.read(Common.REAL_PATH + "/jsp/type/album/AlbumModule.htm","utf-8");
                    	}

                    }
                } else if(name.equals("map"))
                {
                    String map = t.map;

                    /*if(map != null && map.length() > 0)
                    {
                        String url1 = "/jsp/admin/map/ViewGMap.jsp?node=" + n._nNode + "&amp;point=" + map;
                        value = "<iframe src=" + url1 + " frameborder='0' scrolling='no' width='500' height='500'></iframe>";
                    }*/
                    if(map != null && map.length() > 0)
                    {
                        String url1 = "/jsp/admin/map/BViewMap.jsp?node=" + n._nNode + "&amp;point=" + map.trim();
                        value = "<iframe src=" + url1 + " frameborder='0' scrolling='no' width='600' height='450'></iframe>";
                    }

                } else if(name.equals("type"))
                {
                    value = RESERVE_TYPE[t.type];
                } else if(name.equals("dept"))
                {
                    value = DEPT_TYPE[t.dept];
                } else if(name.equals("city"))
                {
                    value = Card.find(t.city).toString();
                } else
                    try
                    {
                        Object tmp =Class.forName("tea.entity.node.Reserve").getField(name).get(t);
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
            sb.append(bi).append("<span id='ReserveID" + name + "'>" + value + "</span>").append(ai);
        }
        return sb.toString();
    }

    public static double f(String str)
    {
        double d = 0;
        if(str.length() < 1)
            return d;
        try
        {
            d = Double.parseDouble(str);
        } catch(NumberFormatException ex)
        {}
        return d;
    }

    //名称 转 node.id
    public static int conv(String name) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT n.node FROM Node n INNER JOIN NodeLayer nl ON n.node=nl.node WHERE n.type=102 AND " + DbAdapter.cite(name) + " LIKE nl.subject+'%'");
            return db.next() ? db.getInt(1) : 0;
        } finally
        {
            db.close();
        }
    }
}
