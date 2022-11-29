package tea.entity.node;

import java.math.*;
import java.sql.*;
import tea.ui.*;
import tea.db.*;
import tea.entity.*;
import tea.html.Anchor;
import tea.html.Span;

public class House extends Entity
{
    private int node; //node,huxing,sizes,parcel,zhuangxiu,toward,floor,address,price,average,,huxingpic,impactpic,facilities,xiaoqu
    private String huxing; //户型
    private String sizes; //大小
    private String parcel; //小区名称
    private String zhuangxiu; //装修情况
    private String toward; ///朝向
    private String floor; //楼层
    private String address; //地址
    private BigDecimal price; //售价
    private BigDecimal average; //均价
    private String huxingpic; //户型图
    private String impactpic; //效果图
    private String facilities; //配套设施
    private String xiaoqu; //小区介绍

    public House(int node) throws SQLException
    {
        this.node = node;
        load();
    }

    public static House find(int node) throws SQLException
    {
        return new House(node);
    }


    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(" select node,huxing,sizes,parcel,zhuangxiu,toward,floor,address,price,average,huxingpic,impactpic,facilities,xiaoqu from House where node=" + node);
            if(db.next())
            {
                int j = 1;
                node = db.getInt(j++);
                huxing = db.getString(j++);
                sizes = db.getString(j++);
                parcel = db.getString(j++);
                zhuangxiu = db.getString(j++);
                toward = db.getString(j++);
                floor = db.getString(j++);
                address = db.getString(j++);
                price = db.getBigDecimal(j++,2);
                average = db.getBigDecimal(j++,2);
                huxingpic = db.getString(j++);
                impactpic = db.getString(j++);
                facilities = db.getString(j++);
                xiaoqu = db.getString(j++);
            }
        } finally
        {
            db.close();
        }
    }

    public static void set(int node,String huxing,String sizes,String parcel,String zhuangxiu,String toward,String floor,String address,BigDecimal price,BigDecimal average,String huxingpic,String impactpic,String facilities,String xiaoqu) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(" select node from House where node=" + node);
            if(db.next())
            {
                db.executeUpdate("Update House set   node=" + node + ",huxing=" + db.cite(huxing) + ",sizes=" + db.cite(sizes) + ",parcel=" + db.cite(parcel) + ",zhuangxiu=" + db.cite(zhuangxiu) + ",toward=" + db.cite(toward) + ",floor=" + db.cite(floor) + ",address=" + db.cite(address) + ",price=" + price + ",average=" + average + ",huxingpic=" + db.cite(huxingpic) + ",impactpic=" + db.cite(impactpic) + ",facilities=" + db.cite(facilities) + ",xiaoqu=" + db.cite(xiaoqu) + "  where node=" + node);
            } else
            {
                db.executeUpdate("Insert into House (node,huxing,sizes,parcel,zhuangxiu,toward,floor,address,price,average,huxingpic,impactpic,facilities,xiaoqu)values(" + node + "," + db.cite(huxing) + "," + db.cite(sizes) + "," + db.cite(parcel) + "," + db.cite(zhuangxiu) + "," + db.cite(toward) + "," + db.cite(floor) + "," + db.cite(address) + "," + price + "," + average + "," + db.cite(huxingpic) + "," + db.cite(impactpic) + "," + db.cite(facilities) + "," + db.cite(xiaoqu) + ")");
            }
        } finally
        {
            db.close();
        }
    }

    public String getZhuangxiu()
    {
        return zhuangxiu;
    }

    public String getXiaoqu()
    {
        return xiaoqu;
    }

    public String getToward()
    {
        return toward;
    }

    public String getSizes()
    {
        return sizes;
    }

    public BigDecimal getPrice()
    {
        return price;
    }

    public String getParcel()
    {
        return parcel;
    }

    public int getNode()
    {
        return node;
    }

    public String getImpactpic()
    {
        return impactpic;
    }

    public String getHuxingpic()
    {
        return huxingpic;
    }

    public String getHuxing()
    {
        return huxing;
    }

    public String getFloor()
    {
        return floor;
    }

    public String getFacilities()
    {
        return facilities;
    }

    public BigDecimal getAverage()
    {
        return average;
    }

    public String getAddress()
    {
        return address;
    }

    public String getDetail(Node node,Http h,int listing,String target) throws SQLException
    {
        StringBuilder htm = new StringBuilder();
        int _nNode = node._nNode;
        Span span = null;
        String subject = node.getSubject(h.language);
        String pic = "/res/" + node.getCommunity() + "/picture/" + _nNode + ".jpg";
        ListingDetail detail = ListingDetail.find(listing,91,h.language);
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
            } else if(name.equals("huxing"))
            {
                value = (this.getHuxing());
            } else if(name.equals("sizes"))
            {
                value = (this.getSizes());
            } else if(name.equals("parcel"))
            {
                value = (this.getParcel());
            } else if(name.equals("zhuangxiu"))
            {
                value = (this.getZhuangxiu());
            } else if(name.equals("toward"))
            {
                value = (this.getToward());
            } else if(name.equals("floor"))
            {
                value = (this.getFloor());
            } else if(name.equals("address"))
            {
                value = (this.getAddress());
            } else if(name.equals("price"))
            {
                value = (String.valueOf(this.getPrice()));
            } else if(name.equals("average"))
            {
                value = (String.valueOf(this.getAverage()));
            } else if(name.equals("huxingpic"))
            {
                if(this.getHuxingpic() != null)
                {
                    value = ("<img name=picture" + node._nNode + " src='" + this.getHuxingpic() + "' >");
                }
            } else if(name.equals("impactpic"))
            {
                StringBuffer str = new StringBuffer("");
                if(this.getImpactpic() != null)
                {
                    String sp[] = this.getImpactpic().split(",");

                    if(sp.length != -1)
                    {
                        for(int i = 1;i < sp.length;i++)
                        {
                            value = ("<img name=picture" + i + " src='" + sp[i] + "' >");
                            str.append(value);
                        }
                    }
                }
                value = str.toString();
            } else if(name.equals("facilities"))
            {
                value = (this.getFacilities());
            } else if(name.equals("xiaoqu"))
            {
                value = (this.getXiaoqu());
            } else if(name.equals("content"))
            {
                value = (node.getText(h.language));
            } else if(name.equals("IssueTime"))
            {
                value = (node.getTimeToString());
            }
            if(detail.getAnchor(name) != 0)
            {
                Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/house/" + node._nNode + "-" + h.language + ".htm",value);
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
