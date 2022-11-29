package tea.entity.admin.sales;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class SalesLinkman extends Entity
{
    private static Cache _cache = new Cache(100);
    public static final String CLIENT_TYPE[] =
                                               {"-----------","分析师","竞争对手","客户","集成商","投资商","合作伙伴","大众媒体","潜在客户","转售商","其它"};

    private int saleslinkman;
    private String community;
    private String member;
    private String name;
    private String tel;
    private String mobile;
    private String email;
    private int client; // 客户
    private boolean clienttype; //true:客户,false:潜在客户
    private int supervisor; // 直属上司
    private String job;
    // /////////邮寄地址
    private String country;
    private String postcode;
    private String state;
    private String city;
    private String street;
    // /////////其他地址
    private String country2;
    private String postcode2;
    private String state2;
    private String city2;
    private String street2;

    private String fax;
    private int origin;
    private String hometel;
    private Date birth;
    private String othertel;
    private String unit;
    private String assistant;
    private String assistanttel;

    private String content;

    private Date time; // 创建时间
    private Date utime; // 修改时间
    private Date vtime; // 查看时间
    private boolean exists;

    public SalesLinkman(int saleslinkman) throws SQLException
    {
        this.saleslinkman = saleslinkman;
        load();
    }

    public static SalesLinkman find(int saleslinkman) throws SQLException
    {
        SalesLinkman obj = (SalesLinkman) _cache.get(new Integer(saleslinkman));
        if(obj == null)
        {
            obj = new SalesLinkman(saleslinkman);
            _cache.put(new Integer(saleslinkman),obj);
        }
        return obj;
    }

    public static int findByName(String name) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT saleslinkman FROM SalesLinkman WHERE name=" + DbAdapter.cite(name));
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
            db.executeQuery("SELECT saleslinkman FROM SalesLinkman WHERE tel=" + DbAdapter.cite(tel));
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
            db
                    .executeQuery("SELECT community, member, name, tel, mobile, email, client, clienttype, supervisor, job, country, postcode, state, city, street, country2, postcode2, state2, city2, street2, fax, origin, hometel, birth, othertel, unit, assistant, assistanttel, content, time, utime, vtime FROM SalesLinkman WHERE saleslinkman="
                                  + saleslinkman);
            if(db.next())
            {
                community = db.getString(1);
                member = db.getString(2);
                name = db.getString(3);
                tel = db.getString(4);
                mobile = db.getString(5);
                email = db.getString(6);
                client = db.getInt(7); // 客户
                clienttype = db.getInt(8) != 0;
                supervisor = db.getInt(9); // 直属上司
                job = db.getString(10);
                country = db.getString(11);
                postcode = db.getString(12);
                state = db.getString(13);
                city = db.getString(14);
                street = db.getString(15);
                country2 = db.getString(16);
                postcode2 = db.getString(17);
                state2 = db.getString(18);
                city2 = db.getString(19);
                street2 = db.getString(20);

                fax = db.getString(21);
                origin = db.getInt(22);
                hometel = db.getString(23);
                birth = db.getDate(24);
                othertel = db.getString(25);
                unit = db.getString(26);
                assistant = db.getString(27);
                assistanttel = db.getString(28);

                content = db.getString(29);

                time = db.getDate(30); // 创建时间
                utime = db.getDate(31); // 修改时间
                vtime = db.getDate(32); // 查看时间
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

    public static void create(String community,String member,String name,String tel,String mobile,String email,int client,boolean clienttype,int supervisor,String job,String country,
                              String postcode,String state,String city,String street,String country2,String postcode2,String state2,String city2,String street2,String fax,int origin,String hometel,
                              Date birth,String othertel,String unit,String assistant,String assistanttel,String content) throws SQLException
    {
        Date time = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db
                    .executeUpdate("INSERT INTO SalesLinkman(community, member, name, tel, mobile, email, client, clienttype, supervisor, job, country, postcode, state, city, street, country2, postcode2, state2, city2, street2, fax, origin, hometel, birth, othertel, unit, assistant, assistanttel, content, time, utime, vtime)VALUES("
                                   + DbAdapter.cite(community)
                                   + ","
                                   + DbAdapter.cite(member)
                                   + ","
                                   + DbAdapter.cite(name)
                                   + ","
                                   + DbAdapter.cite(tel)
                                   + ","
                                   + DbAdapter.cite(mobile)
                                   + ","
                                   + DbAdapter.cite(email)
                                   + ","
                                   + (client)
                                   + ","
                                   + DbAdapter.cite(clienttype)
                                   + ","
                                   + supervisor
                                   + ","
                                   + DbAdapter.cite(job)
                                   + ","
                                   + DbAdapter.cite(country)
                                   + ","
                                   + DbAdapter.cite(postcode)
                                   + ","
                                   + DbAdapter.cite(state)
                                   + ","
                                   + DbAdapter.cite(city)
                                   + ","
                                   + DbAdapter.cite(street)
                                   + ","
                                   + DbAdapter.cite(country2)
                                   + ","
                                   + DbAdapter.cite(postcode2)
                                   + ","
                                   + DbAdapter.cite(state2)
                                   + ","
                                   + DbAdapter.cite(city2)
                                   + ","
                                   + DbAdapter.cite(street2)
                                   + ","
                                   + DbAdapter.cite(fax)
                                   + ","
                                   + (origin)
                                   + ","
                                   + DbAdapter.cite(hometel)
                                   + ","
                                   + DbAdapter.cite(birth)
                                   + ","
                                   + DbAdapter.cite(othertel)
                                   + ","
                                   + DbAdapter.cite(unit)
                                   + ","
                                   + DbAdapter.cite(assistant)
                                   + ","
                                   + DbAdapter.cite(assistanttel) + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(time) + " )");
        } finally
        {
            db.close();
        }
    }

    public void set(String name,String tel,String mobile,String email,int client,boolean clienttype,int supervisor,String job,String country,String postcode,String state,String city,
                    String street,String country2,String postcode2,String state2,String city2,String street2,String fax,int origin,String hometel,Date birth,String othertel,String unit,
                    String assistant,String assistanttel,String content) throws SQLException
    {
        this.utime = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE SalesLinkman SET name=" + DbAdapter.cite(name) + ",tel=" + DbAdapter.cite(tel) + ",mobile=" + DbAdapter.cite(mobile) + ",email=" + DbAdapter.cite(email)
                             + ",client=" + client + ",clienttype=" + DbAdapter.cite(clienttype) + ",supervisor=" + supervisor + ",job=" + DbAdapter.cite(job) + ",country=" + DbAdapter.cite(country)
                             + ",postcode=" + DbAdapter.cite(postcode) + ",state=" + DbAdapter.cite(state) + ",city=" + DbAdapter.cite(city) + ",street=" + DbAdapter.cite(street) + ",country2="
                             + DbAdapter.cite(country2) + ",postcode2=" + DbAdapter.cite(postcode2) + ",state2=" + DbAdapter.cite(state2) + ",city2=" + DbAdapter.cite(city2) + ",street2="
                             + DbAdapter.cite(street2) + ",fax=" + DbAdapter.cite(fax) + ",origin=" + origin + ",hometel=" + DbAdapter.cite(hometel) + ",birth=" + DbAdapter.cite(birth) + ",othertel="
                             + DbAdapter.cite(othertel) + ",unit=" + DbAdapter.cite(unit) + ",assistant=" + DbAdapter.cite(assistant) + ",assistanttel=" + DbAdapter.cite(assistanttel) + ",content="
                             + DbAdapter.cite(content) + ",utime=" + DbAdapter.cite(utime) + " WHERE saleslinkman=" + saleslinkman);
        } finally
        {
            db.close();
        }
        this.name = name;
        this.tel = tel;
        this.mobile = mobile;
        this.email = email;
        this.client = client; // 客户
        this.clienttype = clienttype;
        this.supervisor = supervisor; // 直属上司
        this.job = job;
        this.country = country;
        this.postcode = postcode;
        this.state = state;
        this.city = city;
        this.street = street;
        this.country2 = country2;
        this.postcode2 = postcode2;
        this.state2 = state2;
        this.city2 = city2;
        this.street2 = street2;

        this.fax = fax;
        this.origin = origin;
        this.hometel = hometel;
        this.birth = birth;
        this.othertel = othertel;
        this.unit = unit;
        this.assistant = assistant;
        this.assistanttel = assistanttel;

        this.content = content;

    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            count = db.getInt("SELECT COUNT(saleslinkman) FROM SalesLinkman WHERE community=" + DbAdapter.cite(community) + sql);
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
            db.executeUpdate("DELETE SalesLinkman WHERE saleslinkman=" + saleslinkman);
        } finally
        {
            db.close();
        }
        this.exists = false;
        _cache.remove(new Integer(saleslinkman));
    }

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT saleslinkman FROM SalesLinkman WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
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

    public int getSalesLinkman()
    {
        return saleslinkman;
    }

    public String getTel()
    {
        return tel;
    }

    public String getFax()
    {
        return fax;
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

    public Date getUtime()
    {
        return utime;
    }

    public String getUtimeToString()
    {
        return sdf.format(utime);
    }

    public Date getVtime()
    {
        return vtime;
    }

    public String getVtimeToString()
    {
        return sdf.format(vtime);
    }

    public String getAssistant()
    {
        return assistant;
    }

    public String getAssistanttel()
    {
        return assistanttel;
    }

    public Date getBirth()
    {
        return birth;
    }

    public String getBirthToString()
    {
        if(birth == null)
        {
            return "";
        }
        return sdf.format(birth);
    }

    public int getClient()
    {
        return client;
    }

    public boolean isClienttype()
    {
        return clienttype;
    }

    public String getHometel()
    {
        return hometel;
    }

    public String getJob()
    {
        return job;
    }

    public String getMember()
    {
        return member;
    }

    public String getMobile()
    {
        return mobile;
    }

    public int getOrigin()
    {
        return origin;
    }

    public String getOthertel()
    {
        return othertel;
    }

    public int getSaleslinkman()
    {
        return saleslinkman;
    }

    public int getSupervisor()
    {
        return supervisor;
    }

    public String getUnit()
    {
        return unit;
    }

}
