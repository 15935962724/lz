package tea.entity.node;

import java.sql.*;
import tea.ui.*;
import tea.db.*;
import tea.entity.*;
import tea.html.*;

public class Link extends Entity
{
    public static Cache _cache = new Cache(100);
    public static String CLASSES_TYPE[] =
            {"网络技术","网络编程","电脑硬件","电脑软件","网页制作","网络资源","电脑游戏","新闻政治","社会科学","生活时尚","军事国防","文化教育","天文地理","医药保健","经济商业","个人情感","摄影美术","娱乐影视","文学艺术","另类其它"};
    public int node;
    public int language;
    public String name;
    public String email;
    public String password;
    public boolean type;
    public int classes;
    public String ip;
    public boolean exists;
    public Link(int node,int language) throws SQLException
    {
        this.node = node;
        this.language = language;
        load();
    }

    public static Link find(int node,int language) throws SQLException
    {
        Link obj = (Link) _cache.get(node + ":" + language);
        if(obj == null)
        {
            obj = new Link(node,language);
            _cache.put(node + ":" + language,obj);
        }
        return obj;
    }

    private void load() throws SQLException
    {
        int j = Node.getLanguage(node,language);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT name,email,password,type,classes,ip FROM Link WHERE node=" + node + " AND language=" + j);
            if(db.next())
            {
                name = db.getVarchar(language,j,1);
                email = db.getString(2);
                password = db.getString(3);
                type = db.getInt(4) != 0;
                classes = db.getInt(5);
                ip = db.getString(6);
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

    public void set() throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        sb.append("UPDATE Link SET name=" + DbAdapter.cite(name));
        sb.append(",email=").append(DbAdapter.cite(email));
        sb.append(",password=").append(DbAdapter.cite(password));
        sb.append(",type=").append(type ? "1" : "0");
        sb.append(",classes=").append(classes);
        sb.append(",ip=").append(DbAdapter.cite(ip));
        sb.append(" WHERE node=").append(node).append(" AND language=").append(language);
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate(node,sb.toString());
            if(j < 1)
                db.executeUpdate(node,"INSERT INTO Link(node,language,name,email,password,type,classes,ip)VALUES(" + node + "," + language + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(password) + "," + (type ? "1" : "0") + "," + classes + "," + DbAdapter.cite(ip) + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Link WHERE node=" + node + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }

    public static String getDetail(Node node,Http h,int listing,String target,tea.resource.Resource r) throws SQLException
    {
        StringBuilder htm = new StringBuilder();
        String subject = node.getSubject(h.language);
        ListingDetail detail = ListingDetail.find(listing,78,h.language);;
        java.util.Iterator e = detail.keys();
        while(e.hasNext())
        {
            Anchor anchor = null;
            String name = (String) e.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
                continue;
            if(name.equals("getSubject"))
            {
                value = subject;
            } else if(name.equals("getText2"))
            {
                if((node.getOptions() & 0x40L) == 0)
                {
                    value = (tea.html.Text.toHTML(node.getText2(h.language)));
                } else
                {
                    value = (node.getText2(h.language));
                }
            } else if(name.equals("getLogo"))
            {
                value = node.getPicture(h.language);
                if(value != null && value.length() > 0)
                    value = "<img src='" + value + "' alt='" + MT.f(subject) + "' />";
            } else if(name.equals("url"))
            {
                value = node.getClickUrl(h.language);
            } else
            {
                Link obj = Link.find(node._nNode,h.language);
                if(name.equals("isType"))
                {
                    value = (r.getString(h.language,obj.isType() ? "LogoLink" : "CharLink"));
                } else if(name.equals("getLink"))
                {
                    if(obj.isType())
                    {
                        Image img = new Image(node.getPicture(h.language),subject);
                        String id = "AmityLinkIDgetLinkN" + node._nNode + "L" + listing;
                        img.setId(id);
                        img.setWidth(100);
                        img.setHeight(32);
                        value = (img.toString()); // +"<script>setSize(document.all['"+id+"'],100,32)</script>");
                    } else
                    {
                        value = subject;
                    }
                } else if(name.equals("getEmail"))
                {
                    value = (obj.getEmail());
                    anchor = new Anchor("mailto:" + obj.getEmail(),obj.getEmail());
                } else
                {
                    try
                    {
                        Class c = obj.getClass();
                        java.lang.reflect.Method m = c.getMethod(name,(java.lang.Class[])null);
                        value = ((String) m.invoke(obj,(Object[])null));
                    } catch(Exception ex)
                    {
                        ex.printStackTrace();
                    }
                }
            }
            if(detail.getAnchor(name) != 0)
                value = "<a href='" + node.getClickUrl(h.language) + "' target='_blank' title=\"" + subject.replace('"','\'') + "\">" + value + "</a>";
            htm.append(detail.getBeforeItem(name)).append("<span id='AmityLinkID" + name + "'>" + value + "</span>").append(detail.getAfterItem(name));
        }
        return htm.toString();
    }

    public int getNode()
    {
        return node;
    }

    public int getLanguage()
    {
        return language;
    }

    public String getName()
    {
        return name;
    }

    public String getEmail()
    {
        return email;
    }

    public String getPassword()
    {
        return password;
    }

    public boolean isType()
    {
        return type;
    }

    public int getClasses()
    {
        return classes;
    }

    public String getIp()
    {
        return ip;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getIpBlur()
    {
        String blur;
        int index = ip.lastIndexOf(".");
        blur = ip.substring(0,index + 1) + "*";
        return blur;
    }
}
