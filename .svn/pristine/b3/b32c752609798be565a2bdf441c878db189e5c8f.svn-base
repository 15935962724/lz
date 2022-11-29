package tea.entity.node;

import java.math.BigDecimal;
import tea.ui.*;
import tea.ui.member.profile.newcaller;
import tea.db.DbAdapter;
import tea.entity.*;
import tea.entity.city.CityList;
import tea.entity.member.WomenOptions;

import java.sql.SQLException;
import tea.html.*;
import java.sql.SQLException;
import java.util.ArrayList;

public class Service
{
    private String unit;
    private String synopsis;
    private BigDecimal price;
    private String quality;
    private int point;
    private String picture;
    private String time;
    private String thing;
    private String tools;
    private int node;
    private int language;
    private String type;
    private boolean exists;
    public String serShops;
    public int cityid;
    public String locationid;
    public String commericial;
    public String landmark;
    public int nstype1; // 类型1
    public int nstype2; // 类型2
    private static Cache _cache = new Cache(100);
    private String picture2;
    private int minimum;

    public Service(int _nNode,int _nLanguage) throws SQLException
    {
        node = _nNode;
        language = _nLanguage;
        loadBasic();
    }
    public Service(int _nNode) throws SQLException
    {
        node = _nNode;
        
    }
    public static void create(int node,int language,int minimum,String unit,String synopsis,java.math.BigDecimal price,String quality,int point,String picture,String picture2,String time,String thing,String tools,String type,String serShops,int cityid,String locationid,String commericial,String landmark,int nstype1,int nstype2) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            /*
             * db.getInt("ServiceCreate " + node + "," + language + "," + minimum + "," + DbAdapter.cite(unit) + "," + DbAdapter.cite(synopsis) + "," + (price.toString()) + "," + DbAdapter.cite(quality) + "," + (point) + "," + DbAdapter.cite(picture) + "," + DbAdapter.cite(picture2) + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(thing) + "," + DbAdapter.cite(tools) + "," + DbAdapter.cite(type));
             */
            db.executeUpdate("INSERT INTO Service (node,language   ,minimum    ,unit    ,synopsis,price   ,quality ,point   ,picture ,picture2 ,time    ,thing   ,tools   ,type,serShops,cityid,locationid,commericial,landmark,nstype1,nstype2) VALUES (" + node + "," + language + "  ," + minimum + "   ," + DbAdapter.cite(unit) + "      ," + DbAdapter.cite(synopsis) + "  ," + (price.toString()) + "     ," + DbAdapter.cite(quality) + "   ," + (point) + "     ," + DbAdapter.cite(picture) + "   ," + DbAdapter.cite(picture2) + " ," + DbAdapter.cite(time)
                             + "      ," + DbAdapter.cite(thing) + "     ," + DbAdapter.cite(tools) + "     ," + DbAdapter.cite(type)+ "     ," + DbAdapter.cite(serShops) +","+cityid+","+DbAdapter.cite(locationid)+","+DbAdapter.cite(commericial)+","+DbAdapter.cite(landmark)+","+nstype1+","+nstype2+ ")");
            db.getInt("SELECT @@IDENTITY");
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }

    public void set(int minimum,String unit,String synopsis,java.math.BigDecimal price,String quality,int point,String picture,String picture2,String time,String thing,String tools,String type,String serShops,int cityid,String locationid,String commericial,String landmark,int nstype1,int nstype2) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            /*
             * db.executeUpdate("ServiceEdit " + node + "," + language + "," + minimum + "," + DbAdapter.cite(unit) + "," + DbAdapter.cite(synopsis) + "," + (price.toString()) + "," + DbAdapter.cite(quality) + "," + (point) + "," + DbAdapter.cite(picture) + "," + DbAdapter.cite(picture2) + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(thing) + "," + DbAdapter.cite(tools) + "," + DbAdapter.cite(type));
             */
            db.executeUpdate("UPDATE Service  SET minimum =" + minimum + "   ,unit    =" + DbAdapter.cite(unit) + "      ,synopsis=" + DbAdapter.cite(synopsis) + "  ,price   =" + (price.toString()) + "     ,quality =" + DbAdapter.cite(quality) + "   ,point   =" + point + "     ,picture =" + DbAdapter.cite(picture) + "   ,picture2 =" + DbAdapter.cite(picture2) + "   ,time    =" + DbAdapter.cite(time) + "      ,thing   =" + DbAdapter.cite(thing) + "     ,tools   =" + DbAdapter.cite(tools)
                             + "      ,type=" + DbAdapter.cite(type) + "     ,serShops=" + DbAdapter.cite(serShops) +",cityid="+cityid+",locationid="+DbAdapter.cite(locationid)+",commericial="+DbAdapter.cite(commericial)+",landmark="+DbAdapter.cite(landmark)+",nstype1="+nstype1+",nstype2="+nstype2+ "  WHERE language=" + language + " AND node=" + node);
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }

    public boolean isExists() throws SQLException
    {
        return exists;
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT minimum,unit ,synopsis,price   ,quality ,point   ,picture ,time    ,thing   ,tools,type,picture2,serShops,cityid,locationid,commericial,landmark,nstype1,nstype2 FROM Service  WHERE node=" + node + " AND language=" + language);
            if(db.next())
            {
                minimum = db.getInt(1);
                unit = db.getVarchar(1,language,2);
                synopsis = db.getVarchar(1,language,3);
                price = db.getBigDecimal(4,2); // new java.math.BigDecimal(db.getVarchar(1, language, 3));
                quality = db.getVarchar(1,language,5);
                point = db.getInt(6);
                picture = db.getVarchar(1,language,7);
                time = db.getVarchar(1,language,8);
                thing = db.getVarchar(1,language,9);
                tools = db.getVarchar(1,language,10);
                type = db.getVarchar(1,language,11);
                picture2 = db.getVarchar(1,language,12);
                serShops=db.getVarchar(1,language,13);
                cityid=db.getInt(14);
                locationid=db.getString(15);
                commericial=db.getString(16);
                landmark=db.getString(17);
                nstype1=db.getInt(18);
                nstype2=db.getInt(19);
                exists = true;
            } else
            {
                exists = false;
                price = new java.math.BigDecimal("0.00");
            }
        } finally
        {
            db.close();
        }
    }
    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Service SET " + f + "=" + DbAdapter.cite(v) + " WHERE node=" + node);
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }
    public static Service find(int _nNode,int _nLanguage) throws SQLException
    {
        Service objService = (Service) _cache.get(_nNode + ":" + _nLanguage);
        if(objService == null)
        {
            objService = new Service(_nNode,_nLanguage);
            _cache.put(_nNode + ":" + _nLanguage,objService);
        }
        return objService;
    }
    public static String f(String str) throws NumberFormatException,SQLException
	{
		StringBuilder qua = new StringBuilder();
		String[] arr = str.split("[|]");
		for(int i = 1;i < arr.length;i++)
		{
			Service q = Service.find(Integer.parseInt(arr[i]),1);
			Node n=Node.find(Integer.parseInt(arr[i]));
			qua.append("<span id='_q" + q.node + "' path=''><input type='hidden' name='serviceNode' value='" + q.node + "' />" + n.getSubject(1) + "<img src='/tea/image/d7.gif' onclick='mt.fdel(this)' /></span>");
		}
		return qua.toString();
	}
    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT node,language,minimum,unit ,synopsis,price   ,quality ,point   ,picture ,time    ,thing   ,tools,type,picture2,serShops,cityid,locationid,commericial,landmark,nstype1,nstype2 FROM Service  WHERE 1=1"+sql,pos,size);
            while(db.next())
            {
            	int i=1;
            	int node=db.getInt(i++);
            	int language=db.getInt(i++);
            	Service s=new Service(node,language);
                s.minimum = db.getInt(i++);
                s.unit = db.getString(i++);
                s.synopsis = db.getString(i++);
                s.price = db.getBigDecimal(i++,2); // new java.math.BigDecimal(db.getVarchar(1, language, 3));
                s.quality = db.getString(i++);
                s.point = db.getInt(i++);
                s.picture = db.getString(i++);
                s.time = db.getString(i++);
                s.thing = db.getString(i++);
                s.tools = db.getString(i++);
                s.type = db.getString(i++);
                s.picture2 = db.getString(i++);
                s.serShops=db.getString(i++);
                s.cityid=db.getInt(i++);
                s.locationid=db.getString(i++);
                s.commericial=db.getString(i++);
                s.landmark=db.getString(i++);
                s.nstype1=db.getInt(i++);
                s.nstype2=db.getInt(i++);
                s.exists = true;
                al.add(s);
                _cache.put(node + ":" + language,s);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }
    public static String getDetail(Node node,Http h,int listing,String target) throws SQLException
    {
        Span span = null;
        StringBuilder sb = new StringBuilder();
        Service obj = Service.find(node._nNode,h.language);
        ListingDetail detail = ListingDetail.find(listing,65,h.language);
        java.util.Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
            {
                continue;
            }
            if(name.equals("code"))
            {
                value = String.valueOf(obj.getNode());
            } else if(name.equals("Subject"))
            {
                value = (node.getSubject(h.language));
            } else if(name.equals("minimum"))
            {
                value = String.valueOf(obj.getMinimum());
            } else if(name.equals("unit"))
            {
                value = (obj.getUnit());
            } else if(name.equals("synopsis"))
            {
                value = (obj.getSynopsis());
            } else if(name.equals("price"))
            {
                value = (obj.getPrice().toString());
            } else if(name.equals("quality"))
            {
                value = (obj.getQuality());
            } else if(name.equals("point"))
            {
                value = String.valueOf(obj.getPoint());
            } else if(name.equals("destine"))
            {
                // value=(node._nNode);
                sb.append(detail.getBeforeItem(name) + node._nNode + detail.getAfterItem(name));
                continue;
                // value=(new tea.html.Button("","","window.location='/jsp/type/sorder/EditSOrder.jsp?destine="+node._nNode+"'").toString());
            } else if(name.equals("picture"))
            {
                if(obj.getPicture() != null && obj.getPicture().length() > 0)
                {
                    value = (new tea.html.Image(obj.getPicture()).toString());
                } else
                {
                    value = ("");
                }
            } else if(name.equals("picture2"))
            {
                if(obj.getPicture2() != null && obj.getPicture2().length() > 0)
                {
                    value = (new tea.html.Image(obj.getPicture2()).toString());
                } else
                {
                    value = ("");
                }
            } else if(name.equals("text"))
            {
                value = (node.getText2(h.language));
            } else if(name.equals("time"))
            {
                value = (obj.getTime());
            }else if(name.equals("shop"))
            {
            	StringBuffer sbf=new StringBuffer();
            	String shops[]=obj.serShops.split("[|]");
            	for(int i=1;i<shops.length;i++){
            		sbf.append("<a href='/html/nightshop/"+shops[i]+"-1.htm'>"+Node.find(Integer.parseInt(shops[i])).getSubject(h.language)+"</a>");
            	}
                value = sbf.toString();
            } else if(name.equals("type"))
            {
                value = WomenOptions.find(obj.nstype1, h.language).getWoname()+" "+WomenOptions.find(obj.nstype2, h.language).getWoname();
            } else if(name.equals("thing"))
            {
                value = (obj.getThing());
            } else if(name.equals("tools"))
            {
                value = (obj.getTools());
            } else
            {
                continue;
            }
            if(istype == 2 && (value == null || value.length() < 1))
            {
                continue;
            }
            int dq = detail.getQuantity(name);
            if(value != null && dq > 0 && value.length() > dq)
            {
                value = value.substring(0,dq) + " ...";
            }
            if(detail.getAnchor(name) != 0)
            {
                Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/service/" + node._nNode + "-" + h.language + ".htm",value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("ServiceID" + name);
            sb.append(detail.getBeforeItem(name)).append(span).append(detail.getAfterItem(name));
        }
        return sb.toString();
    }

    public String getUnit()
    {
        return unit;
    }

    public String getSynopsis()
    {
        return synopsis;
    }

    public BigDecimal getPrice()
    {
        return price;
    }

    public String getQuality()
    {
        return quality;
    }

    public int getPoint()
    {
        return point;
    }

    public String getPicture()
    {
        return picture;
    }

    public String getTime()
    {
        return time;
    }

    public String getType()
    {

        return type;
    }

    public String getThing()
    {
        return thing;
    }

    public String getTools()
    {
        return tools;
    }

    public int getNode()
    {
        return node;
    }

    public int getLanguage()
    {
        return language;
    }

    public String getPicture2()
    {
        return picture2;
    }

    public int getMinimum()
    {
        return minimum;
    }
}
