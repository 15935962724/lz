package tea.entity.admin;

import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class Workproject extends Entity
{
    private static Cache _cache = new Cache(100);
    public static final String CLIENT_TYPE[] =
            {"-----------","分析师","竞争对手","客户","集成商","投资商","合作伙伴","大众媒体","潜在客户","转售商","其它"};
    private int workproject;
    private String community;
    private String member;
    private String tel;
    private String fax;
    private String url;
    private String email;


    private String name;
    private String content;
    private boolean exists;
    private Date time; // 创建时间
    private Date utime; // 修改时间
    private Date vtime; // 查看时间
    private int type;
    private int employee;
    private int calling;
    private String earning; // 年收入
    // /////////开单地址
    private String country;
    private String postcode;
    private String state;
    private String city;
    private String street;
    // /////////发货地址
    private String country2;
    private String postcode2;
    private String state2;
    private String city2;
    private String street2;
    private int laid; //说明这个是潜在客户的id


    public Workproject(int workproject) throws SQLException
    {
        this.workproject = workproject;
        load();
    }

    public static Workproject find(int workproject) throws SQLException
    {
        Workproject obj = (Workproject) _cache.get(new Integer(workproject));
        if(obj == null)
        {
            obj = new Workproject(workproject);
            _cache.put(new Integer(workproject),obj);
        }
        return obj;
    }

    public static int findByName(String name) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT workproject FROM Workproject WHERE name=" + DbAdapter.cite(name));
            if(db.next())
            {
                id = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return id;
    }

    public static int findByTel(String tel) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT workproject FROM Workproject WHERE tel=" + DbAdapter.cite(tel));
            if(db.next())
            {
                id = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return id;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,member,tel,fax,url,email,postcode,name,content,time,utime,vtime,type,employee,calling,earning,country,state,city,street,country2,postcode2,state2,city2,street2,laid FROM Workproject WHERE workproject=" + workproject);
            if(db.next())
            {
                community = db.getString(1);
                member = db.getString(2);
                tel = db.getString(3);
                fax = db.getString(4);
                url = db.getString(5);
                email = db.getString(6);
                postcode = db.getString(7);
                name = db.getString(8);
                content = db.getString(9);
                time = db.getDate(10);
                utime = db.getDate(11);
                vtime = db.getDate(12);
                type = db.getInt(13);
                employee = db.getInt(14);
                calling = db.getInt(15);
                earning = db.getString(16);
                country = db.getString(17);
                state = db.getString(18);
                city = db.getString(19);
                street = db.getString(20);
                country2 = db.getString(21);
                postcode2 = db.getString(22);
                state2 = db.getString(23);
                city2 = db.getString(24);
                street2 = db.getString(25);
                laid = db.getInt(26);

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

    public static int create(String community,String member,String tel,String fax,String url,String email,String name,String content,int type,int employee,int calling,String earning,String country,String postcode,String state,String city,String street,String country2,
                             String postcode2,String state2,String city2,String street2) throws SQLException
    {
        int workproject = 0;
        Date time = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Workproject(community,member,tel,fax,url,email,postcode,name,content,time,utime,vtime,type,employee,calling,earning,country,state,city,street,country2,postcode2,state2,city2,street2)VALUES(" + DbAdapter.cite(community) + ","
                             + DbAdapter.cite(member) + "," + DbAdapter.cite(tel) + "," + DbAdapter.cite(fax) + "," + DbAdapter.cite(url) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(postcode) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(time)
                             + "," + DbAdapter.cite(time) + "," + type + "," + employee + "," + calling + "," + DbAdapter.cite(earning) + "," + DbAdapter.cite(country) + "," + DbAdapter.cite(state) + "," + DbAdapter.cite(city) + "," + DbAdapter.cite(street) + "," + DbAdapter.cite(country2) + ","
                             + DbAdapter.cite(postcode2) + "," + DbAdapter.cite(state2) + "," + DbAdapter.cite(city2) + "," + DbAdapter.cite(street2) + " )");
            workproject = db.getInt("SELECT MAX(workproject) FROM Workproject");
        } finally
        {
            db.close();
        }
        return workproject;
    }

    public static void createOne(String community,String member,String email,String telephone,int calling,String corp) throws SQLException
    {
        int workproject = 0;
        Date time = new Date();

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Workproject(community,member,email,tel,calling,name,time)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(telephone) + "," + calling + "," + DbAdapter.cite(corp) + "," + DbAdapter.cite(Workproject.sdf.format(time)) + ")");

            workproject = db.getInt("SELECT MAX(workproject) FROM Workproject");
        } finally
        {
            db.close();
        }
    }

    //
    public static int createTemp() throws SQLException
    {
        int workproject = 0;
        Date time = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("");
            workproject = db.getInt("SELECT MAX(workproject) FROM Workproject");
        } finally
        {
            db.close();
        }
        return workproject;
    }


    public void set(String tel,String fax,String url,String email,String name,String content,int type,int employee,int calling,String earning,String country,String postcode,String state,String city,String street,String country2,String postcode2,String state2,String city2,
                    String street2) throws SQLException
    {
        this.utime = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Workproject SET tel=" + DbAdapter.cite(tel) + ",fax=" + DbAdapter.cite(fax) + ",url=" + DbAdapter.cite(url) + ",email=" + DbAdapter.cite(email) + ",postcode=" + DbAdapter.cite(postcode) + ",name=" + DbAdapter.cite(name) + ",content=" + DbAdapter.cite(content)
                             + ",utime=" + DbAdapter.cite(utime) + ",type=" + type + ",employee=" + employee + ",calling=" + calling + ",earning=" + DbAdapter.cite(earning) + ",country=" + DbAdapter.cite(country) + ",state=" + DbAdapter.cite(state) + ",city=" + DbAdapter.cite(city) + ",street="
                             + DbAdapter.cite(street) + ",country2=" + DbAdapter.cite(country2) + ",postcode2=" + DbAdapter.cite(postcode2) + ",state2=" + DbAdapter.cite(state2) + ",city2=" + DbAdapter.cite(city2) + ",street2=" + DbAdapter.cite(street2) + " WHERE workproject="
                             + workproject);
        } finally
        {
            db.close();
        }
        this.tel = tel;
        this.fax = fax;
        this.url = url;
        this.email = email;
        this.postcode = postcode;
        this.name = name;
        this.content = content;
        this.type = type;
        this.employee = employee;
        this.calling = calling;
        this.earning = earning;
        this.country = country;
        this.postcode = postcode;
        this.state = state;
        this.city = city;
        this.street = street;
        this.country2 = country2;
        this.postcode2 = postcode2;
        this.state2 = state2;
        this.city2 = city2;

    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            count = db.getInt("SELECT COUNT(workproject) FROM Workproject WHERE community=" + DbAdapter.cite(community) + sql);
        } finally
        {
            db.close();
        }
        return count;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE Workproject WHERE workproject=" + workproject);
        } finally
        {
            db.close();
        }
        this.exists = false;
    }

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT workproject FROM Workproject WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public void setLaid(int laid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Workproject SET laid =" + laid + " WHERE workproject=" + workproject);
        } finally
        {
            db.close();
        }
        this.laid = laid;
    }


    public String getTel()
    {
        return tel;
    }

    public String getFax()
    {
        return fax;
    }

    public String getUrl()
    {
        return url;
    }

    public String getEmail()
    {
        return email;
    }

    public String getPostcode()
    {
        return postcode;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getCommunity()
    {
        return community;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        return sdf.format(time);
    }

    public String getName(int language)
    {
        return name;
    }

    public String getContent(int language)
    {
        return content;
    }

    public int getCalling()
    {
        return calling;
    }

    public String getContent()
    {
        return content;
    }

    public String getCountry()
    {
        return country;
    }

    public String getCountry2()
    {
        return country2;
    }

    public String getCity()
    {
        return city;
    }

    public String getCity2()
    {
        return city2;
    }

    public String getEarning()
    {
        return earning;
    }

    public int getEmployee()
    {
        return employee;
    }

    public String getPostcode2()
    {
        return postcode2;
    }

    public String getState()
    {
        return state;
    }

    public String getState2()
    {
        return state2;
    }

    public String getStreet()
    {
        return street;
    }

    public String getStreet2()
    {
        return street2;
    }

    public int getType()
    {
        return type;
    }

    public Date getUtime()
    {
        return utime;
    }

    public Date getVtime()
    {
        return vtime;
    }

    public String getUtimeToString()
    {
        return sdf.format(utime);
    }

    public String getVtimeToString()
    {
        return sdf.format(vtime);
    }

    public String getMember()
    {
        return member;
    }


}
