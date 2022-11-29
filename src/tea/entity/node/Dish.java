package tea.entity.node;

import java.math.*;
import java.sql.*;
import java.util.Date;
import tea.db.*;import tea.ui.*;
import tea.entity.*;
import tea.entity.bpicture.*;
import tea.html.*;
import java.util.Vector;


/***
 * 2008年12月24日11:17:48唐嗣达 餐饮 菜品
 * **************/

public class Dish extends Entity
{
    private static Cache _cache = new Cache(100);
    private int _nNode;
    private int language;
    private String _nName; //菜品名称
    private String _nPrimarydata; //主要原料
    private String _nCuisines; //菜系
    private String _nTaste; //味道
    private String _ncountry; //国别
    private String _nNutrient; //营养成分
    private String _nEfficacity; //功效
    private String _nmethod; //制作方法
    private String _mouthfeel; //口感描述
    private String content; //详细内容
    private String picture; //图片
    private BigDecimal dishprice; //菜品的价格


    //node,name,primarydata,cuisines,taste,country,nutrient,efficacity,method,mouthfeel,content,dishprice
    public static String PRIMARYDATA[] =
            {"猪肉","牛肉羊","肉　","畜类","鸡　肉　","鸭肉","禽蛋","禽类","鱼类虾类","蟹类","水　产","蔬菜","瓜果","菌藻根茎","干货","豆品","粮面","其它"};
    public static String CUISINES[] =
            {"鲁菜","川菜","粤菜","苏菜　","湘菜　","徽菜","浙菜闽菜","京菜","鄂菜","沪菜","东北菜","家常菜","清真","其它菜系"};
    public static String TASTE[] =
            {"咸鲜","香辣","麻辣","酸辣","清淡","酱香","香甜","酥脆","酸甜","咸甜","酸味","海鲜","火锅","烧烤","其它"};
    public static String COUNTRY[] =
            {"日本料理","韩国料理","意大利","俄罗斯","土耳其　","法国　　","德国　","东南亚","其它西餐"};
    public static String METHOD[] =
            {"炒","炸","爆","烩","熘","煎","蒸","烧","煨","炖　","煮　","焖　","扒","卤","氽","烤","焗","煸","熏","腌","拌","冻","冰镇","拔丝","微波","其它"};

    public static Dish find(int node) throws SQLException
    {

        return new Dish(node);

    }

    public Dish(int node) throws SQLException
    {
        this._nNode = node;
        load();
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT language FROM Interlocution WHERE node=" + _nNode);
            while(dbadapter.next())
            {
                v.addElement(new Integer(dbadapter.getInt(1)));
            }
        } finally
        {
            dbadapter.close();
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

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select node,name,primarydata,cuisines,taste,country,nutrient,efficacity,method,mouthfeel,content,dishprice,picture from Dish where node=" + _nNode);
            if(db.next())
            {
                int j = 1;
                _nNode = db.getInt(j++);
                _nName = db.getString(j++);
                _nPrimarydata = db.getString(j++);
                _nCuisines = db.getString(j++);
                _nTaste = db.getString(j++);
                _ncountry = db.getString(j++);
                _nNutrient = db.getString(j++);
                _nEfficacity = db.getString(j++);
                _nmethod = db.getString(j++); //制作方法
                _mouthfeel = db.getString(j++); //口感描述
                content = db.getString(j++); //详细内容
                dishprice = db.getBigDecimal(j++,2); //菜品的价格
                picture = db.getString(j++);
            }
        } finally
        {
            db.close();
        }
    }

    public static void set(int node,String primarydata,String cuisines,String taste,String country,String nutrient,String efficacity,String method,String mouthfeel,BigDecimal dishprice,String picture) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select node from Dish where node=" + node);
            if(db.next())
            {
                db.executeUpdate("Update Dish set primarydata=" + db.cite(primarydata) + ",cuisines=" + db.cite(cuisines) + ",taste=" + db.cite(taste) + ",country=" + db.cite(country) + ",nutrient=" + db.cite(nutrient) + ",efficacity=" + db.cite(efficacity) + ",method=" + db.cite(method) + ",mouthfeel=" + db.cite(mouthfeel) + ",dishprice=" + dishprice + ",picture=" + db.cite(picture) + " where node=" + node);
            } else
            {
                db.executeUpdate("Insert into Dish(node,primarydata,cuisines,taste,country,nutrient,efficacity,method,mouthfeel,dishprice,picture) values (" + node + "," + db.cite(primarydata) + "," + db.cite(cuisines) + "," + db.cite(taste) + "," + db.cite(country) + "," + db.cite(nutrient) + "," + db.cite(efficacity) + "," + db.cite(method) + "," + db.cite(mouthfeel) + "," + dishprice + "," + db.cite(picture) + ")");
            }
        } finally
        {
            db.close();
        }
    }

    public int getLanguage()
    {
        return language;
    }

    public BigDecimal getDishprice()
    {
        return dishprice;
    }

    public String getContent()
    {
        return content;
    }

    public String get_nTaste()
    {
        return _nTaste;
    }

    public String get_nPrimarydata()
    {
        return _nPrimarydata;
    }

    public String get_nNutrient()
    {
        return _nNutrient;
    }

    public int get_nNode()
    {
        return _nNode;
    }

    public String get_nName()
    {
        return _nName;
    }

    public String get_nmethod()
    {
        return _nmethod;
    }

    public String get_nEfficacity()
    {
        return _nEfficacity;
    }

    public String get_nCuisines()
    {
        return _nCuisines;
    }

    public String get_ncountry()
    {
        return _ncountry;
    }

    public String get_mouthfeel()
    {
        return _mouthfeel;
    }

    public String getPicture()
    {
        return picture;
    }

    public String getDetail(Node node,Http h,int listing,String target) throws SQLException
    {
        StringBuilder htm = new StringBuilder();
        int _nNode = node._nNode;
        Span span = null;
        String subject = node.getSubject(h.language);
        String pic = "/res/" + node.getCommunity() + "/picture/" + _nNode + ".jpg";
        ListingDetail detail = ListingDetail.find(listing,88,h.language);
        java.util.Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
            {
                continue;
            }
            if(name.equals("index"))
            {
                value = String.valueOf(_nNode);
            } else if(name.equals("subject"))
            {
                value = (node.getSubject(h.language));
            }
//            else if(name.equals("_nName"))
//            {
//                value = (this.get_nName());
//            }
            else if(name.equals("_nPrimarydata"))
            {
                value = (this.get_nPrimarydata());
            } else if(name.equals("_nCuisines"))
            {
                value = (this.get_nCuisines());
            } else if(name.equals("_nTaste"))
            {
                value = (this.get_nTaste());
            } else if(name.equals("_ncountry"))
            {
                value = (this.get_ncountry());
            } else if(name.equals("_nNutrient"))
            {
                value = (this.get_nNutrient());
            } else if(name.equals("_nEfficacity"))
            {
                value = (this.get_nEfficacity());
            } else if(name.equals("_nmethod"))
            {
                value = (this.get_nmethod());
            } else if(name.equals("picture"))
            {
                if(this.getPicture() != null)
                {
                    value = ("<img name=picture" + node._nNode + " src='" + this.getPicture() + "' >");
                }
            } else if(name.equals("_mouthfeel"))
            {
                value = (this.get_mouthfeel());
            }

            else if(name.equals("content"))
            {
                value = (node.getText(h.language));
            }

            else if(name.equals("_nmethod"))
            {
                value = (this.getPicture());
            }

            else if(name.equals("dishprice"))
            {
                value = (String.valueOf(this.getDishprice()));
            } else if(name.equals("IssueTime"))
            {
                value = (node.getTimeToString());
            }
            if(detail.getAnchor(name) != 0)
            {
                Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/dish/" + node._nNode + "-" + h.language + ".htm",value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("DishID" + name);
            htm.append(detail.getBeforeItem(name)).append(span).append(detail.getAfterItem(name));
        }
        //System.out.print(h.toString());
        return htm.toString();
    }
}
