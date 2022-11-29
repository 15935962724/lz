package tea.entity.node;

import java.sql.*;
import java.util.*;
import tea.ui.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.node.*;

public class Perform extends Entity
{
    private static Cache _cache = new Cache(100);
    private int node;
    private int language;
    private String sort; //主要演员
    private String organise; //组织人
    private String linkman; //组织者联系方式
    private String corp; //组织者所属公司
    private String intropicture; //介绍图片路径
    private String intropicturename; //介绍图片名称
    private String direct; //导演
    private String pftime; //演出时间
    private String pfprice; //演出价格
    private boolean exist;

    public Perform(int node,int language) throws SQLException
    {
        this.node = node;
        this.language = language;
        loadBase();
    }

    public static Perform find(int node,int language) throws SQLException
    {
        Perform objPerform = (Perform) _cache.get(node + ":" + language);
        if(objPerform == null)
        {
            objPerform = new Perform(node,language);
            _cache.put(node + ":" + language,objPerform);
        }
        return objPerform;
    }

    private void loadBase() throws SQLException
    {

        int j = this.getLanguage(language);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT sort,organise,linkman,corp,intropicture,intropicturename,direct,pftime,pfprice FROM Perform WHERE node=" + node + " AND language=" + j);
            if(db.next())
            {
                sort = db.getString(1);
                organise = db.getString(2);
                linkman = db.getString(3);
                corp = db.getString(4);
                intropicture = db.getString(5);
                intropicturename = db.getString(6);
                direct = db.getString(7);
                pftime = db.getString(8);
                pfprice = db.getString(9);
                exist = true;
            } else
            {
                exist = false;
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            db.close();
        }
    }


    public static void create(int node,int language,String sort,String organise,String linkman,String corp,String intropicture,String intropicturename,String direct,String pftime,String pfprice) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Perform(node,language,sort,organise,linkman,corp,intropicture,intropicturename,direct,pftime,pfprice) VALUES(" + node + "," + language + ","
                             + " " + db.cite(sort) + "," + db.cite(organise) + "," + db.cite(linkman) + "," + db.cite(corp) + "," + db.cite(intropicture) + "," + db.cite(intropicturename) + "," + db.cite(direct) + "," + db.cite(pftime) + "," + db.cite(pfprice) + " )");

        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }


    public void set(String sort,String organise,String linkman,String corp,String intropicture,String intropicturename,String direct,String pftime,String pfprice) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Perform SET sort=" + db.cite(sort) + ",organise=" + db.cite(organise) + ",linkman=" + db.cite(linkman) + ",corp=" + db.cite(corp) + ","
                             + " intropicture=" + db.cite(intropicture) + ",intropicturename=" + db.cite(intropicturename) + ",direct=" + db.cite(direct) + ",pftime=" + db.cite(pftime) + ",pfprice=" + db.cite(pfprice) + " WHERE node=" + node + " AND language=" + language);
        } finally
        {
            db.close();
        }
        this.sort = sort;
        this.organise = organise;
        this.linkman = linkman;
        this.corp = corp;
        this.intropicture = intropicture;
        this.intropicturename = intropicturename;
        this.direct = direct;
        this.pftime = pftime;
        this.pfprice = pfprice;
        _cache.remove(node + ":" + language);
    }


    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM Perform WHERE node=" + node);
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

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM  Perform WHERE node = " + node + " and language=" + language);
        } finally
        {
            db.close();
        }
    }


    public String getCorp()
    {
        return corp;
    }

    public String getDirect()
    {
        return direct;
    }

    public boolean isExist()
    {
        return exist;
    }

    public String getIntropicture()
    {
        return intropicture;
    }

    public String getIntropicturename()
    {
        return intropicturename;
    }

    public String getLinkman()
    {
        return linkman;
    }

    public int getNode()
    {
        return node;
    }

    public String getOrganise()
    {
        return organise;
    }

    public String getSort()
    {
        return sort;
    }

    public String getPftime()
    {
        return pftime;
    }

    public String getPfprice()
    {
        return pfprice;
    }

    public String getDetail(Node node,Http h,int listing,String target,int psid) throws SQLException
    {
        StringBuilder text = new StringBuilder();
        int _nNode = node._nNode;
        String subject = node.getSubject(h.language);

        tea.entity.node.ListingDetail detail = tea.entity.node.ListingDetail.find(listing,55,h.language);
        java.util.Iterator e = detail.keys();
        Perform pfobj = Perform.find(_nNode,h.language);
        PerformStreak pfsobj = PerformStreak.find(psid);
        while(e.hasNext())
        {
            String name = (String) e.next(),value = "";
            int istype = detail.getIstype(name);
            if(istype == 0)
            {
                continue;
            }
            String bi = detail.getBeforeItem(name),ai = detail.getAfterItem(name);
            int dq = detail.getQuantity(name);

            if(name.equals("subject"))
            {
                value = (node.getSubject(h.language));
            } else if(name.equals("sort"))
            {
                value = pfobj.getSort();
            } else if(name.equals("intro"))
            {
                value = (node.getText(h.language));
            } else if(name.equals("organise"))
            {
                value = pfobj.getOrganise();
            } else if(name.equals("linkman"))
            {
                value = pfobj.getLinkman();
            } else if(name.equals("corp"))
            {
                value = pfobj.getCorp();
            } else if(name.equals("introPicture"))
            {
                if(pfobj.getIntropicture() != null && pfobj.getIntropicture().length() > 0)
                {
                    value = "<img  src=" + pfobj.getIntropicture() + ">";
                }
            } else if(name.equals("direct"))
            {
                value = pfobj.getDirect();
            } else if(name.equals("pftime")) //演出时间
            {
                value = pfobj.getPftime();
            } else if(name.equals("pfStreak")) //演出场次
            {

                //Node node2 = Node.find(pfsobj.getVenues());
                value = "<include src=\"/jsp/type/perform/PerformStreakList.jsp?node=" + _nNode + "\"/>";

            } else if(name.equals("price")) //演出票价
            {
                value = pfobj.getPfprice(); //PriceSubarea.getPriceSubareaPrice(psid, node.getCommunity());
            }

            /*
                 else if(name.equals("onlinepiao"))//在线订票按钮
                 {
                  value = "<input type=button name=zxdp value=在线订票 >";
                 } else if(name.equals("onlinezuo"))//在线订座按钮
                 {

                  value = "<input type=button name=zxdz value=在线订座  onclick=window.open('/jsp/type/perform/OnlineReservations.jsp?psid="+psid+"&community="+node.getCommunity()+"','_self');>";
                 }
             */

            if(value == null)
            {
                value = "";
            }
            if(istype == 2 && value.length() < 1)
            {
                continue;
            }
            String title = value.replace('"','_');

            //显示连接的地方
            value = detail.getOptionsToHtml(name,node,value);
            if(detail.getAnchor(name) != 0)
            {
                value = "<a href='/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/perform/" + _nNode + "-" + h.language + ".htm' target='" + target + "' title=\"" + subject + "\">" + value + "</a>";
            }
            text.append(bi).append("<span id='VenuesID" + name + "'>" + value + "</span>").append(ai);
        }
        return text.toString();
    }

    //    public String getTimeStartToString()
//    {
//        String strTime = new java.text.SimpleDateFormat("yyyy-MM-dd").format(timeStart);
//        String hhmm = new SimpleDateFormat("HH:mm").format(timeStart);
//        if(!hhmm.equals("00:00"))
//        {
//            return strTime + " " + hhmm;
//        }
//        return strTime;
//    }


}
