package tea.entity.member;

import java.util.*;
import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class YellowPageInfo
{
    private static Cache _cache = new Cache(100);
    private String member;
    private String[] domain;
    private String name;
    private String catchword;
    private String logo;
    private String hue;
    private String style;
    private String function;
    private String lang;
    private String request;
    private String[] consult;
    private String mailbox;
    private String item;
    private String linkman;
    private boolean exists;
    private Date time;

    public YellowPageInfo(String member) throws SQLException
    {
        this.member = member;
        domain = new String[3];
        consult = new String[3];
        loadBasic();
    }

    public static YellowPageInfo find(String member) throws SQLException
    {
        YellowPageInfo node = (YellowPageInfo) _cache.get(member);
        if(node == null)
        {
            node = new YellowPageInfo(member);
            _cache.put(member,node);
        }
        return node;
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT domain   ,domain2  ,domain3  ,name     ,catchword,logo     ,hue      ,style    ,[function] ,lang     ,request  ,consult  ,consult2 ,consult3 ,mailbox  ,item     ,linkman,time   FROM YellowPageInfo  WHERE member=" + DbAdapter.cite(member));
            if(db.next())
            {
                for(int index = 0;index < 3;index++)
                {
                    domain[index] = db.getVarchar(1,1,index + 1);
                }
                name = db.getVarchar(1,1,4);
                catchword = db.getVarchar(1,1,5);
                logo = db.getVarchar(1,1,6);
                hue = db.getVarchar(1,1,7);
                style = db.getVarchar(1,1,8);
                function = db.getVarchar(1,1,9);
                lang = db.getVarchar(1,1,10);
                request = db.getVarchar(1,1,11);
                for(int index = 12;index < 15;index++)
                {
                    consult[index - 12] = db.getVarchar(1,1,index);
                }
                mailbox = db.getString(15);
                item = db.getVarchar(1,1,16);
                linkman = db.getVarchar(1,1,17);
                time = db.getDate(18);
                this.exists = true;
            } else
            {
                this.exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public void set(String domain[],String name,String catchword,String logo,String hue,String style,String function,String lang,String request,String consult[],String mailbox,String item,String linkman) throws SQLException
    {
        if(exists)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate("UPDATE YellowPageInfo SET domain=" + DbAdapter.cite(domain[0]) + ",domain2=" + DbAdapter.cite(domain[1]) + ",domain3=" + DbAdapter.cite(domain[2]) + ",name=" + DbAdapter.cite(name) + ",catchword=" + DbAdapter.cite(catchword) + ",logo=" + DbAdapter.cite(logo) + ",hue=" + DbAdapter.cite(hue) + ",style=" + DbAdapter.cite(style) + ",function=" + DbAdapter.cite(function) + ",lang=" + DbAdapter.cite(lang) + ",request=" + DbAdapter.cite(request) + ",consult="
                                 + DbAdapter.cite(consult[0]) + ",consult2=" + DbAdapter.cite(consult[1]) + ",consult3=" + DbAdapter.cite(consult[2]) + ",mailbox=" + DbAdapter.cite(mailbox) + ",item=" + DbAdapter.cite(item) + ",linkman=" + DbAdapter.cite(linkman) + " WHERE member=" + DbAdapter.cite(member));
            } finally
            {
                db.close();
            }
        } else
        {
            create(member,domain,name,catchword,logo,hue,style,function,lang,request,consult,mailbox,item,linkman);
        }
        _cache.remove(member);
    }

    public static void create(String member,String domain[],String name,String catchword,String logo,String hue,String style,String function,String lang,String request,String consult[],String mailbox,String item,String linkman) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO YellowPageInfo(member,domain   ,domain2  ,domain3  ,name     ,catchword,logo     ,hue      ,style    ,[function] ,lang     ,request  ,consult  ,consult2 ,consult3 ,mailbox  ,item     ,linkman  )VALUES(" + DbAdapter.cite(member) + "," + DbAdapter.cite(domain[0]) + "," + DbAdapter.cite(domain[1]) + "," + DbAdapter.cite(domain[2]) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(catchword) + "," + DbAdapter.cite(logo) + "," + DbAdapter.cite(hue)
                             + "," + DbAdapter.cite(style) + "," + DbAdapter.cite(function) + "," + DbAdapter.cite(lang) + "," + DbAdapter.cite(request) + "," + DbAdapter.cite(consult[0]) + "," + DbAdapter.cite(consult[1]) + "," + DbAdapter.cite(consult[2]) + "," + DbAdapter.cite(mailbox) + "," + DbAdapter.cite(item) + "," + DbAdapter.cite(linkman) + ")");
        } finally
        {
            db.close();
        }
    }

    public static java.util.Enumeration find() throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member FROM YellowPageInfo");
            while(db.next())
            {
                vector.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public String getMember()
    {
        return member;
    }

    public String[] getDomain()
    {
        return domain;
    }

    public String getName()
    {
        return name;
    }

    public String getCatchword()
    {
        return catchword;
    }

    public String getLogo()
    {
        return logo;
    }

    public String getHue()
    {
        return hue;
    }

    public String getStyle()
    {
        return style;
    }

    public String getFunction()
    {
        return function;
    }

    public String getLang()
    {
        return lang;
    }

    public String getRequest()
    {
        return request;
    }

    public String[] getConsult()
    {
        return consult;
    }

    public String getMailbox()
    {
        return mailbox;
    }

    public String getItem()
    {
        return item;
    }

    public String getLinkman()
    {
        return linkman;
    }

    public boolean isExists()
    {
        return exists;
    }

    public Date getTime()
    {
        return time;
    }
}
