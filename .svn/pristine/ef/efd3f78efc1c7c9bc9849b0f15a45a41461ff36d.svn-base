package tea.entity.admin;


import java.sql.*;
import java.util.*;
import java.util.Date;
import tea.ui.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.site.*;
import tea.html.*;
import tea.entity.node.*;
import tea.entity.util.*;

public class Supply extends Entity
{
    private int node;
    private String subject; //主题
    private int newstype; //信息类别
    private int industrytype1; //所属行业一级类别
    private int industrytype2; //所属行业二级类别
    private int city; //城市类别
    private int city1; //
    private int term; //有效期
    private String picname; //图片名称
    private String picpath; //图片路径
    private String website; //连接网址
    private String content; //内容
    private int hidden; //供求信息表示 是否显示 0不显示 1 显示
    private Date times; //添加时间
    private int company; //添加用户名的公司
    private String member; //添加的用户
    private String community; //社区
    private int language;
    private Date audittime; //审核时间

    private boolean exists;
    private static Cache _cache = new Cache(100);

    public static String NEWS_TYPE[] =
            {"供应","求购","招投标","合作"};
    public static String TERM[] =
            {"三天","一周","一个月","三个月"};

    public Supply(int node) throws SQLException
    {
        this.node = node;
        load();
    }

    public Supply(String community,int node) throws SQLException
    {
        this.community = community;
        this.node = node;
        load2();
    }

    public static Supply find2(String community,int node) throws SQLException
    {
        return new Supply(community,node);
    }

    public static Supply find(int node) throws SQLException
    {
        return new Supply(node);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT subject,newstype,industrytype1,industrytype2,city,term,picname,picpath,website,content,hidden,times,company,member,community,city1,language,audittime FROM Supply WHERE node=" + node);
            if(db.next())
            {
                subject = db.getString(1);
                newstype = db.getInt(2);
                industrytype1 = db.getInt(3);
                industrytype2 = db.getInt(4);
                city = db.getInt(5);
                term = db.getInt(6);
                picname = db.getString(7);
                picpath = db.getString(8);
                website = db.getString(9);
                content = db.getString(10);
                hidden = db.getInt(11);
                times = db.getDate(12);
                company = db.getInt(13);
                member = db.getString(14);
                community = db.getString(15);
                city1 = db.getInt(16);
                language = db.getInt(17);
                audittime = db.getDate(18);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public void load2() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT subject,newstype,industrytype1,industrytype2,city,term,picname,picpath,website,content,hidden,times,company,member,community,city1,node,language,audittime FROM Supply WHERE   node =" + node);
//         System.out.print("SELECT subject,newstype,industrytype1,industrytype2,city,term,picname,picpath,website,content,hidden,times,company,member,community,city1,node,language FROM Supply WHERE community ="+db.cite(community)+" and node ="+node);
            if(db.next())
            {
                subject = db.getString(1);
                newstype = db.getInt(2);
                industrytype1 = db.getInt(3);
                industrytype2 = db.getInt(4);
                city = db.getInt(5);
                term = db.getInt(6);
                picname = db.getString(7);
                picpath = db.getString(8);
                website = db.getString(9);
                content = db.getString(10);
                hidden = db.getInt(11);
                times = db.getDate(12);
                company = db.getInt(13);
                member = db.getString(14);
                community = db.getString(15);
                city1 = db.getInt(16);
                node = db.getInt(17);
                language = db.getInt(18);
                audittime = db.getDate(19);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(String subject,int newstype,int industrytype1,int industrytype2,int city,int term,String picname,String picpath,String website,String content,int hidden,int company,String member,String community,int city1,int node,int language) throws SQLException
    {
        Date times = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Supply(subject,newstype,industrytype1,industrytype2,city,term,picname,picpath,website,content,hidden,company,member,community,times,city1,node,language) VALUES(" + db.cite(subject) + "," + newstype + "," + industrytype1 + "," + industrytype2 + "," + city + "," + term + "," + db.cite(picname) + "," + db.cite(picpath) + "," + db.cite(website) + "," + db.cite(content) + "," + hidden + "," + company + "," + db.cite(member) + "," + db.cite(community) + "," + db.cite(times) + "," + city1 + "," + node + "," + language + "  )");
        } finally
        {
            db.close();
        }

    }

    public void set(String subject,int newstype,int industrytype1,int industrytype2,int city,int term,String picname,String picpath,String website,String content,int hidden,int city1,int company,int node) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Supply SET subject=" + db.cite(subject) + ",newstype=" + newstype + ",industrytype1=" + industrytype1 + ",industrytype2=" + industrytype2 + ",city=" + city + ",term=" + term + ",picname=" + db.cite(picname) + ",picpath=" + db.cite(picpath) + ",website=" + db.cite(website) + ",content=" + db.cite(content) + ",hidden=" + hidden + ",city1=" + city1 + ",company=" + company + " WHERE node=" + node);
        } finally
        {
            db.close();
        }
    }

//添加审核时间
    public void setAuditTime() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date audittime = new Date();
        try
        {
            db.executeUpdate("UPDATE Supply SET audittime=" + db.cite(audittime) + "  WHERE node=" + node);
        } finally
        {
            db.close();
        }
    }

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM Supply WHERE community= " + db.cite(community) + sql,pos,size);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Supply WHERE node=" + node);
        } finally
        {
            db.close();
        }
    }


    public static int count(String community,String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter(1);
        try
        {
            i = db.getInt("SELECT COUNT(*) FROM Supply WHERE community=" + db.cite(community) + sql);
        } finally
        {
            db.close();
        }
        return i;
    }

    public int getCity()
    {
        return city;
    }

    public int getCity1()
    {
        return city1;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getLanguage()
    {
        return language;
    }

    public int getCompany()
    {
        return company;
    }

    public String getContent()
    {
        return content;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getHidden()
    {
        return hidden;
    }

    public int getIndustrytype1()
    {
        return industrytype1;
    }

    public int getIndustrytype2()
    {
        return industrytype2;
    }

    public String getMember()
    {
        return member;
    }

    public int getNewstype()
    {
        return newstype;
    }

    public String getPicname()
    {
        return picname;
    }

    public String getPicpath()
    {
        return picpath;
    }

    public String getSubject()
    {
        return subject;
    }

    public int getTerm()
    {
        return term;
    }

    public Date getTimes()
    {
        return times;
    }

    public String getTimesToString()
    {
        if(times == null)
        {
            return "";
        }
        return sdf.format(times);
    }

    public String getWebsite()
    {
        return website;
    }

    public int getNode()
    {
        return node;
    }


    public static String getDetail(Node node,Http h,int listing,String target) throws SQLException
    {
        StringBuilder text = new StringBuilder();
        int _nNode = node._nNode;
        Supply obj = new Supply(node.getCommunity(),_nNode);
        String subject = node.getSubject(h.language);
        Span span = null;

        ListingDetail detail = ListingDetail.find(listing,32,h.language);
        java.util.Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            if(name.equals("name"))
            {
                value = subject;
            } else if(name.equals("NewsType")) //信息类别
            {
                value = Supply.NEWS_TYPE[obj.getNewstype()];
            } else if(name.equals("IndustryType1")) //所属行业
            {
                Node n = Node.find(obj.getIndustrytype1());
                value = n.getSubject(h.language);
            } else if(name.equals("City")) //所属地区
            {
                Card c = Card.find(obj.getCity());
                value = c.toString();
            } else if(name.equals("Term")) //有效期
            {
                value = Supply.TERM[obj.getTerm()];
            } else if(name.equals("PicPath")) //图片
            {
                String p = obj.getPicpath();
                if(p != null && p.length() > 0)
                {
                    value = "<IMG onerror=\"this.style.display='none';\" SRC=\"" + p + "\" />";
                } else
                {
                    // value = "暂无图片";
                    value = "<IMG onerror=\"this.style.display='none';\" SRC=\"/res/lib/u/0805/080561405.jpg\" />";
                }
            } else if(name.equals("WebSite"))
            {
                value = (obj.getWebsite());
            } else if(name.equals("Content"))
            {
                value = obj.getContent();
            } else if(name.equals("Company"))
            {
                Node n2 = Node.find(obj.getCompany());
                value = n2.getSubject(h.language);
            }
            int qu = detail.getQuantity(name);
            if(value != null && qu > 0 && value.length() > qu)
            {
                value = value.substring(0,qu) + " ...";
            }
            if(detail.getAnchor(name) != 0)
            {
                Anchor anchor = null;
                switch(detail.getAnchor(name)) ///主题连接
                {
                case 1:
                    anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/supply/" + _nNode + "-" + h.language + ".htm",value);
                    anchor.setTarget(target);
                    span = new Span(anchor);
                    break;
                case 2: //图片连接
                    String path = "/res/lib/u/0805/080561405.jpg";
                    if(obj.getPicpath() != null && obj.getPicpath().length() > 0)
                    {
                        path = obj.getPicpath();
                    }
                    anchor = new Anchor(path,value);
                    anchor.setTarget("_blank");
                    span = new Span(anchor);
                    break;
                case 3:
                    anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/company/" + obj.getCompany() + "-" + h.language + ".htm",value);
                    anchor.setTarget(target);
                    span = new Span(anchor);
                    break;
                }
            } else
            {
                span = new Span(value);
            }
            span.setId("SupplyID" + name);
            text.append(detail.getBeforeItem(name)).append(span).append(detail.getAfterItem(name));
        }
        return text.toString();
    }

}
