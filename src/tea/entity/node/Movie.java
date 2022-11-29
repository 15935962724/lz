package tea.entity.node;

import java.math.*;
import java.sql.*;
import tea.ui.*;
import tea.db.*;
import tea.entity.*;
import tea.html.*;

public class Movie extends Entity
{
    private int node; //node,mvpic,performer,direct,country,mvtype,mvmaking,mvgrade,publisher,mvyear,mvaward,behindcontent,feature,languagetype,mvprice
//    private String mvname;//
    private String mvpic; //影片海报
    private String performer; //主要演员
    private String direct; //导演
    private String country; //国家
    private String mvtype; //影片类型
    private String mvmaking; //影片长度
    private String mvgrade; //影片级别
    private String publisher; //发行公司
    private int mvyear; //出品年代
    private String mvaward; //所获奖项
//    private String mvcontent; //影片详解
    private String behindcontent; //幕后内容
    private String feature; //有趣花絮
    private String languagetype; //语言类型
    private String mvpath; //影片地址
    private BigDecimal mvprice; //影片价格

    public static String MVTYPE[] =
            {"故事片","美术片","纪录片","科教片","喜剧（闹剧）","悲剧片","舞台艺术片","工业片","农村片","体育片","历史片","言情（爱情）片","伦理（生活）片","儿童（童话）片","传记片","战争片","功夫（武侠）片","推理（侦探）片","警匪（枪战）片","惊险（恐怖）片","灾难片","悬念片","神话片","科幻片","电视片","电影电视片","电视剧","电视连续剧"};

    public Movie(int node) throws SQLException
    {
        this.node = node;
        load();
    }

    public static Movie find(int node) throws SQLException
    {
        return new Movie(node);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select node,mvpic,performer,direct,country,mvtype,mvmaking,mvgrade,publisher,mvyear,mvaward,behindcontent,feature,languagetype,mvprice,mvpath from Movie where node=" + node);
            if(db.next())
            {
                int j = 1;
                node = db.getInt(j++);
                mvpic = db.getString(j++); //影片海报
                performer = db.getString(j++); //主要演员
                direct = db.getString(j++); //导演
                country = db.getString(j++); //国家
                mvtype = db.getString(j++); //影片类型
                mvmaking = db.getString(j++); //影片长度
                mvgrade = db.getString(j++); //影片级别
                publisher = db.getString(j++); //发行公司
                mvyear = db.getInt(j++); //出品年代
                mvaward = db.getString(j++); //所获奖项
                behindcontent = db.getString(j++); //幕后内容
                feature = db.getString(j++); //有趣花絮
                languagetype = db.getString(j++); //语言类型
                mvprice = db.getBigDecimal(j++,2); //影片价格
                mvpath = db.getString(j++);
            }
        } finally
        {
            db.close();
        }
    }

    public static void set(int node,String mvpic,String performer,String direct,String country,String mvtype,String mvmaking,String mvgrade,String publisher,int mvyear,String mvaward,String behindcontent,String feature,String languagetype,BigDecimal mvprice,String mvpath) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select node from Movie where node=" + node);
            if(db.next())
            {
                db.executeUpdate("Update Movie set node=" + node + ",mvpic=" + db.cite(mvpic) + ",performer=" + db.cite(performer) + ",direct=" + db.cite(direct) + ",country=" + db.cite(country) + ",mvtype=" + db.cite(mvtype) + ",mvmaking=" + db.cite(mvmaking) + ",mvgrade=" + db.cite(mvgrade) + ",publisher=" + db.cite(publisher) + ",mvyear=" + mvyear + ",mvaward=" + db.cite(mvaward) + ",behindcontent=" + db.cite(behindcontent) + ",feature=" + db.cite(feature) + ",languagetype=" + db.cite(languagetype) + ",mvprice=" + mvprice + ",mvpath=" + db.cite(mvpath) + " where node=" + node);
            } else
            {
                db.executeUpdate("insert into Movie (node,mvpic,performer,direct,country,mvtype,mvmaking,mvgrade,publisher,mvyear,mvaward,behindcontent,feature,languagetype,mvprice,mvpath) values(" + node + "," + db.cite(mvpic) + "," + db.cite(performer) + "," + db.cite(direct) + "," + db.cite(country) + "," + db.cite(mvtype) + "," + db.cite(mvmaking) + "," + db.cite(mvgrade) + "," + db.cite(publisher) + "," + mvyear + "," + db.cite(mvaward) + "," + db.cite(behindcontent) + "," + db.cite(feature) + "," + db.cite(languagetype) + "," + mvprice + "," + db.cite(mvpath) + ")");
            }
        } finally
        {
            db.close();
        }
    }


    public String getPublisher()
    {
        return publisher;
    }

    public String getPerformer()
    {
        return performer;
    }

    public int getMvyear()
    {
        return mvyear;
    }

    public int getNode()
    {
        return node;
    }

    public String getMvtype()
    {
        return mvtype;
    }

    public BigDecimal getMvprice()
    {
        return mvprice;
    }

    public String getMvpic()
    {
        return mvpic;
    }

    public String getMvmaking()
    {
        return mvmaking;
    }

    public String getMvgrade()
    {
        return mvgrade;
    }

    public String getMvaward()
    {
        return mvaward;
    }

    public String getLanguagetype()
    {
        return languagetype;
    }

    public String getFeature()
    {
        return feature;
    }

    public String getDirect()
    {
        return direct;
    }

    public String getCountry()
    {
        return country;
    }

    public String getBehindcontent()
    {
        return behindcontent;
    }

    public String getMvpath()
    {
        return mvpath;
    }

    public String getDetail(Node node,Http h,int listing,String target) throws SQLException
    {
        StringBuilder htm = new StringBuilder();
        int _nNode = node._nNode;
        Span span = null;
        String subject = node.getSubject(h.language);
        ListingDetail detail = ListingDetail.find(listing,89,h.language);
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
            } else if(name.equals("name"))
            {
                value = (subject);
            } else if(name.equals("mvpic"))
            {
                if(this.getMvpic() != null)
                {
                    value = ("<img name=picture" + node._nNode + " src='" + this.getMvpic() + "' >");
                }
            } else if(name.equals("performer"))
            {
                value = (this.getPerformer());
            } else if(name.equals("direct"))
            {
                value = (this.getDirect());
            } else if(name.equals("country"))
            {
                value = (this.getCountry());
            } else if(name.equals("mvtype"))
            {
                value = (this.getMvtype());
            } else if(name.equals("mvmaking"))
            {
                value = (this.getMvmaking());
            } else if(name.equals("mvgrade"))
            {
                value = (this.getMvgrade());
            } else if(name.equals("publisher"))
            {
                value = (this.getPublisher());
            } else if(name.equals("mvyear"))
            {
                value = (String.valueOf(this.getMvyear()));
            } else if(name.equals("mvaward"))
            {
                value = (this.getMvaward());
            }

            else if(name.equals("mvcontent"))
            {
                value = (node.getText(h.language));
            }

            else if(name.equals("behindcontent"))
            {
                value = (this.getBehindcontent());
            } else if(name.equals("feature"))
            {
                value = (this.getFeature());
            } else if(name.equals("languagetype"))
            {
                value = (this.getLanguagetype());
            } else if(name.equals("mvprice"))
            {
                value = (String.valueOf(this.mvprice));
            } else if(name.equals("mvpath"))
            {
                value = (this.getMvpath());
            }

            else if(name.equals("IssueTime"))
            {
                value = (node.getTimeToString());
            }

            if(detail.getAnchor(name) != 0)
            {
                Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/movie/" + node._nNode + "-" + h.language + ".htm",value);
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
