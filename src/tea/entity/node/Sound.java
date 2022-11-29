package tea.entity.node;

import tea.db.DbAdapter;
import tea.ui.*;
import tea.entity.*;
import java.util.*;
import tea.html.Span;
import tea.html.Anchor;
import tea.html.Text;
import java.sql.SQLException;

public class Sound
{
    private static Cache _cache = new Cache(100);
    private int node;
    private int language;
    private String pingpai;
    private String code;
    private String medium;
    private String dishcount;
    private String types;
    private String polt;
    private String trait;
    private String synopsis;
    private String direct;
    private String produce;
    private String area;
    private String caption;
    private String isrc;
    private float price;
    private float price2;
    private float price3;
    private String integral;
    private String other;
    private String player;
    private boolean exist;
    private String bigtype;
    private String smalltype;
    public String BIGTYPE[] =
            {"电 影","电视剧","音 乐","卡 通","曲 艺","百 科","经典纪录"};

    public Sound()
    {
    }

    public Sound(int node,int language) throws SQLException
    {
        this.node = node;
        this.language = language;
        loadBase();
    }

    public void loadBase() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db
                    .executeQuery("SELECT pingpai,code,medium,dishcount,types,polt,trait,synopsis,player,direct,produce,area,caption,isrc,price,price2,price3,integral,other,bigtype,smalltype FROM Sound WHERE node="
                                  + node + " AND language=" + language);
            if(db.next())
            {
                pingpai = db.getVarchar(1,1,1);
                code = db.getVarchar(1,1,2);
                medium = db.getVarchar(1,1,3);
                dishcount = db.getVarchar(1,1,4);
                types = db.getVarchar(1,1,5);
                polt = db.getVarchar(1,1,6);
                trait = db.getVarchar(1,1,7);
                synopsis = db.getVarchar(1,1,8);
                player = db.getVarchar(1,1,9);
                direct = db.getVarchar(1,1,10);
                produce = db.getVarchar(1,1,11);
                area = db.getVarchar(1,1,12);
                caption = db.getVarchar(1,1,13);
                isrc = db.getVarchar(1,1,14);
                price = db.getFloat(15);
                price2 = db.getFloat(16);
                price3 = db.getFloat(17);
                integral = db.getVarchar(1,1,18);
                other = db.getVarchar(1,1,19);
                bigtype = db.getVarchar(1,1,20);
                smalltype = db.getVarchar(1,1,21);
                exist = true;
            } else
            {
                exist = false;
                pingpai = code = medium = dishcount = types = polt = trait = synopsis = player = direct = produce = area = caption = isrc = integral = smalltype = bigtype = other = "";
            }
        } finally
        {
            db.close();
        }
    }

    public void create() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db
                    .executeUpdate("INSERT INTO Sound(node,language,bigtype,smalltype,pingpai,code,medium,dishcount,types,polt,trait,synopsis,player,direct,produce,area,caption,isrc,price,price2,price3,integral,other)VALUES("
                                   + node
                                   + "," + language
                                   + "," + DbAdapter.cite(bigtype)
                                   + "," + DbAdapter.cite(smalltype)
                                   + "," + DbAdapter.cite(pingpai)
                                   + "," + DbAdapter.cite(code)
                                   + "," + DbAdapter.cite(medium)
                                   + "," + DbAdapter.cite(dishcount)
                                   + "," + DbAdapter.cite(types)
                                   + "," + DbAdapter.cite(polt)
                                   + "," + DbAdapter.cite(trait)
                                   + "," + DbAdapter.cite(synopsis)
                                   + "," + DbAdapter.cite(player)
                                   + "," + DbAdapter.cite(direct)
                                   + "," + DbAdapter.cite(produce)
                                   + "," + DbAdapter.cite(area)
                                   + "," + DbAdapter.cite(caption)
                                   + "," + DbAdapter.cite(isrc)
                                   + "," + (price)
                                   + "," + (price2)
                                   + "," + (price3)
                                   + "," + DbAdapter.cite(integral)
                                   + "," + DbAdapter.cite(other)
                                   + ")");
        } finally
        {
            db.close();
        }
        this.exist = true;
        _cache.remove(node + ":" + language);
    }

    public void set() throws SQLException
    {
        if(this.exist)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate("UPDATE Sound SET bigtype=" + DbAdapter.cite(bigtype) + ",smalltype=" + DbAdapter.cite(smalltype) + ",pingpai=" + DbAdapter.cite(pingpai) + ",code="
                                 + DbAdapter.cite(code) + ",medium=" + DbAdapter.cite(medium) + ",dishcount=" + DbAdapter.cite(dishcount) + ",types=" + DbAdapter.cite(types) + ",polt=" + DbAdapter.cite(polt)
                                 + ",trait=" + DbAdapter.cite(trait) + ",synopsis=" + DbAdapter.cite(synopsis) + ",player=" + DbAdapter.cite(player) + ",direct=" + DbAdapter.cite(direct) + ",produce="
                                 + DbAdapter.cite(produce) + ",area=" + DbAdapter.cite(area) + ",caption=" + DbAdapter.cite(caption) + ",isrc=" + DbAdapter.cite(isrc) + ",price=" + (price) + ",price2="
                                 + (price2) + ",price3=" + (price3) + ",integral=" + DbAdapter.cite(integral) + ",other=" + DbAdapter.cite(other) + " WHERE node=" + node + " AND language=" + language);
            } catch(Exception ex)
            {
                ex.printStackTrace();
            } finally
            {
                db.close();
            }
            this.exist = true;
            _cache.remove(node + ":" + language);
        } else
        {
            create();
        }
    }

    public static Sound find(int node,int language) throws SQLException
    {
        Sound objPerform = (Sound) _cache.get(node + ":" + language);
        if(objPerform == null)
        {
            objPerform = new Sound(node,language);
            _cache.put(node + ":" + language,objPerform);
        }
        return objPerform;
    }

    public static String getDetail(Node node,Http h,int listing,String target) throws SQLException
    {
        tea.html.Span span = null;
        StringBuilder sb = new StringBuilder();

        Sound financing = Sound.find(node._nNode,h.language);
        ListingDetail detail = ListingDetail.find(listing,56,h.language);
        Iterator e = detail.keys();
        while(e.hasNext())
        {
            String itemname = (String) e.next(),value = null;
            int istype = detail.getIstype(itemname);
            if(istype == 0)
            {
                continue;
            }
            if(itemname.equals("subject"))
            {
                value = (node.getSubject(h.language));
            } else if(itemname.equals("text"))
            {
                value = (node.getText2(h.language));
            } else if(itemname.equals("IssueTime"))
            {
                value = (node.getTimeToString());
            } else if(itemname.equals("bigtype"))
            {
                value = (financing.getBigtype());
            } else if(itemname.equals("smalltype"))
            {
                value = (financing.getSmalltype());
            } else if(itemname.equals("pingpai"))
            {
                value = (financing.getPingpai());
            } else if(itemname.equals("code"))
            {
                value = (financing.getCode());
            } else if(itemname.equals("medium"))
            {
                value = (financing.getMedium());
            } else if(itemname.equals("dishcount"))
            {
                value = (financing.getDishcount());
            } else if(itemname.equals("types"))
            {
                value = (financing.getTypes());
            } else if(itemname.equals("polt"))
            {
                value = (financing.getPolt());
            } else if(itemname.equals("trait"))
            {
                value = (financing.getTrait());
            } else if(itemname.equals("synopsis"))
            {
                value = (financing.getSynopsis());
            } else if(itemname.equals("player"))
            {
                value = (financing.getPlayer());
            } else if(itemname.equals("direct"))
            {
                value = (financing.getDirect());
            } else if(itemname.equals("produce"))
            {
                value = (financing.getProduce());
            } else if(itemname.equals("area"))
            {
                value = (financing.getArea());
            } else if(itemname.equals("caption"))
            {
                value = (financing.getCaption());
            } else if(itemname.equals("isrc"))
            {
                value = (financing.getIsrc());
            } else if(itemname.equals("price"))
            {
                value = (String.valueOf(financing.getPrice()));
            } else if(itemname.equals("price2"))
            {
                value = (String.valueOf(financing.getPrice2()));
            } else if(itemname.equals("price3"))
            {
                value = (String.valueOf(financing.getPrice3()));
            } else if(itemname.equals("integral"))
            {
                value = (financing.getIntegral());
            } else if(itemname.equals("other"))
            {
                value = (financing.getOther());
            }
            if(detail.getAnchor(itemname) != 0)
            {
                Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/sound/" + node._nNode + "-" + h.language + ".htm",value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("SoundID" + itemname);
            sb.append(detail.getBeforeItem(itemname)).append(span).append(detail.getAfterItem(itemname));
        }
        return sb.toString();
    }

    public void setNode(int node)
    {
        this.node = node;
    }

    public void setLanguage(int language)
    {
        this.language = language;
    }

    public void setPingpai(String pingpai)
    {
        this.pingpai = pingpai;
    }

    public void setCode(String code)
    {
        this.code = code;
    }

    public void setMedium(String medium)
    {
        this.medium = medium;
    }

    public void setDishcount(String dishcount)
    {
        this.dishcount = dishcount;
    }

    public void setTypes(String types)
    {
        this.types = types;
    }

    public void setPolt(String polt)
    {
        this.polt = polt;
    }

    public void setTrait(String trait)
    {
        this.trait = trait;
    }

    public void setSynopsis(String synopsis)
    {
        this.synopsis = synopsis;
    }

    public void setDirect(String direct)
    {
        this.direct = direct;
    }

    public void setProduce(String produce)
    {
        this.produce = produce;
    }

    public void setArea(String area)
    {
        this.area = area;
    }

    public void setCaption(String caption)
    {
        this.caption = caption;
    }

    public void setIsrc(String isrc)
    {
        this.isrc = isrc;
    }

    public void setPrice(float price)
    {
        this.price = price;
    }

    public void setPrice2(float price2)
    {
        this.price2 = price2;
    }

    public void setPrice3(float price3)
    {
        this.price3 = price3;
    }

    public void setIntegral(String integral)
    {
        this.integral = integral;
    }

    public void setOther(String other)
    {
        this.other = other;
    }

    public void setPlayer(String player)
    {
        this.player = player;
    }

    public void setBigtype(String bigtype)
    {
        this.bigtype = bigtype;
    }

    public void setSmalltype(String smalltype)
    {
        this.smalltype = smalltype;
    }

    public int getNode()
    {
        return node;
    }

    public int getLanguage()
    {
        return language;
    }

    public String getPingpai()
    {
        return pingpai;
    }

    public String getCode()
    {
        return code;
    }

    public String getMedium()
    {
        return medium;
    }

    public String getDishcount()
    {
        return dishcount;
    }

    public String getTypes()
    {
        return types;
    }

    public String getPolt()
    {
        return polt;
    }

    public String getTrait()
    {
        return trait;
    }

    public String getSynopsis()
    {
        return synopsis;
    }

    public String getDirect()
    {
        return direct;
    }

    public String getProduce()
    {
        return produce;
    }

    public String getArea()
    {
        return area;
    }

    public String getCaption()
    {
        return caption;
    }

    public String getIsrc()
    {
        return isrc;
    }

    public float getPrice()
    {
        return price;
    }

    public float getPrice2()
    {
        return price2;
    }

    public float getPrice3()
    {
        return price3;
    }

    public String getIntegral()
    {
        return integral;
    }

    public String getOther()
    {
        return other;
    }

    public String getPlayer()
    {
        return player;
    }

    public boolean isExist()
    {
        return exist;
    }

    public String getBigtype()
    {
        return bigtype;
    }

    public String getSmalltype()
    {
        return smalltype;
    }
}
