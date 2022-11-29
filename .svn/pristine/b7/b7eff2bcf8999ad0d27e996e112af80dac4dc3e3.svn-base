package tea.entity.admin;

import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class Worklinkman extends Entity
{
    private static Cache _cache = new Cache(100);
    private int worklinkman;
    private String ftel;
    private String blog;
    private String email;
    private String fpostcode;
    private String name;
    private String content;
    private boolean exists;
    private String community;
    private boolean sex;
    private Date birthday;
    private String worktel;
    private String mobile;
    private String qicq;
    private String msn;
    private String job;
    private String love;
    private String faddress;
    private int workproject;
    private String member;

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

    private String othertel;
    private String unit;
    private String assistant;
    private String assistanttel;

    private Date times;

    public Worklinkman(String community,String member) throws SQLException
    {
        this.community = community;
        this.member = member;
        load();
    }

    public static Worklinkman find(String community,String member) throws SQLException
    {
        Worklinkman obj = (Worklinkman) _cache.get(community + ":" + member);
        if(obj == null)
        {
            obj = new Worklinkman(community,member);
            _cache.put(community + ":" + member,obj);
        }
        return obj;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT worklinkman,workproject,member,sex,birthday,fpostcode,worktel,ftel,mobile,email,qicq     ,msn      ,blog     ,name     ,job      ,love     ,faddress ,content ,country,postcode,state,city,street,country2,postcode2,state2,city2,street2,fax,origin,hometel,othertel,unit,assistant,assistanttel,times  FROM Worklinkman WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
            if(db.next())
            {
                worklinkman = db.getInt(1);
                workproject = db.getInt(2);
                // community = db.getString(2);
                // member = db.getString(3);
                sex = db.getInt(4) != 0;
                birthday = db.getDate(5);
                fpostcode = db.getString(6);
                worktel = db.getString(7);
                ftel = db.getString(8);
                mobile = db.getString(9);
                email = db.getString(10);
                qicq = db.getString(11);
                msn = db.getString(12);
                blog = db.getString(13);
                name = db.getString(14);
                job = db.getString(15);
                love = db.getString(16);
                faddress = db.getString(17);
                content = db.getString(18);
                country = db.getString(19);
                postcode = db.getString(20);
                state = db.getString(21);
                city = db.getString(22);
                street = db.getString(23);
                country2 = db.getString(24);
                postcode2 = db.getString(25);
                state2 = db.getString(26);
                city2 = db.getString(27);
                street2 = db.getString(28);
                fax = db.getString(29);
                origin = db.getInt(30);
                hometel = db.getString(31);
                othertel = db.getString(32);
                unit = db.getString(33);
                assistant = db.getString(34);
                assistanttel = db.getString(35);
                times = db.getDate(36);
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

    public static void create(int workproject,String community,String member,boolean sex,Date birthday,String fpostcode,String worktel,String ftel,String mobile,String email,String qicq,String msn,String blog,String name,String job,String love,String faddress,String content,int origin,String hometel,String othertel,String unit,String assistant,String assistanttel,String country,String postcode,String state,String city,String street,String country2,String postcode2,
                              String state2,String city2,String street2,String fax) throws SQLException
    {
        Date times = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Worklinkman(workproject,community,member,sex      ,birthday ,fpostcode,worktel  ,ftel     ,mobile   ,email    ,qicq     ,msn      ,blog     ,name     ,job      ,love     ,faddress ,content,origin,hometel,othertel,unit,assistant,assistanttel,country,postcode,state,city,street,country2,postcode2,state2,city2,street2,fax,times)VALUES(" + workproject + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(sex) + "," + DbAdapter.cite(birthday) + ","
                             + DbAdapter.cite(fpostcode) + "," + DbAdapter.cite(worktel) + "," + DbAdapter.cite(ftel) + "," + DbAdapter.cite(mobile) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(qicq) + "," + DbAdapter.cite(msn) + "," + DbAdapter.cite(blog) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(job) + "," + DbAdapter.cite(love) + "," + DbAdapter.cite(faddress) + "," + DbAdapter.cite(content) + "," + origin + "," + DbAdapter.cite(hometel) + "," + DbAdapter.cite(othertel) + "," + DbAdapter.cite(unit) + "," + DbAdapter.cite(assistant) + "," + DbAdapter.cite(assistanttel) + "," + DbAdapter.cite(country) + ","
                             + DbAdapter.cite(postcode) + "," + DbAdapter.cite(state) + "," + DbAdapter.cite(city) + "," + DbAdapter.cite(street) + "," + DbAdapter.cite(country2) + "," + DbAdapter.cite(postcode2) + "," + DbAdapter.cite(state2) + "," + DbAdapter.cite(city2) + "," + DbAdapter.cite(street2) + "," + DbAdapter.cite(fax) + " ," + DbAdapter.cite(times) + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(community + ":" + member);
    }

    public void set(int workproject,boolean sex,Date birthday,String fpostcode,String worktel,String ftel,String mobile,String email,String qicq,String msn,String blog,String name,String job,String love,String faddress,String content,int origin,String hometel,String othertel,String unit,String assistant,String assistanttel,String country,String postcode,String state,String city,String street,String country2,String postcode2,String state2,String city2,
                    String street2,String fax) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Worklinkman SET workproject=" + workproject + ",sex=" + DbAdapter.cite(sex) + ",birthday=" + DbAdapter.cite(birthday) + ",fpostcode=" + DbAdapter.cite(fpostcode) + ",worktel=" + DbAdapter.cite(worktel) + ",ftel=" + DbAdapter.cite(ftel) + ",mobile=" + DbAdapter.cite(mobile) + ",email=" + DbAdapter.cite(email) + ",qicq=" + DbAdapter.cite(qicq) + ",msn=" + DbAdapter.cite(msn) + ",blog=" + DbAdapter.cite(blog) + ",name=" + DbAdapter.cite(name) + ",job=" + DbAdapter.cite(job) + ",love=" + DbAdapter.cite(love) + ",faddress=" + DbAdapter.cite(faddress)
                             + ",content=" + DbAdapter.cite(content) + ",origin=" + origin + ", hometel=" + DbAdapter.cite(hometel) + ", othertel=" + DbAdapter.cite(othertel) + ",unit=" + DbAdapter.cite(unit) + " ,  assistant=" + DbAdapter.cite(assistant) + ",  assistanttel=" + DbAdapter.cite(assistanttel) + ", country=" + DbAdapter.cite(country) + ", postcode=" + DbAdapter.cite(postcode) + ", state=" + DbAdapter.cite(state) + ", city=" + DbAdapter.cite(city) + ", street=" + DbAdapter.cite(street) + ", country2=" + DbAdapter.cite(country2) + ", postcode2=" + DbAdapter.cite(postcode2)
                             + ", state2=" + DbAdapter.cite(state2) + ", city2=" + DbAdapter.cite(city2) + ", street2=" + DbAdapter.cite(street2) + ", fax=" + DbAdapter.cite(fax) + "  WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
        this.workproject = workproject;
        // this.member = member;
        this.sex = sex;
        this.birthday = birthday;
        this.fpostcode = fpostcode;
        this.worktel = worktel;
        this.ftel = ftel;
        this.mobile = mobile;
        this.email = email;
        this.qicq = qicq;
        this.msn = msn;
        this.blog = blog;
        this.name = name;
        this.job = job;
        this.love = love;
        this.faddress = faddress;
        this.content = content;

        this.country = country;
        this.postcode = postcode;
        this.state = state;
        this.city = city;
        this.street = street;
        // /////////其他地址
        this.country2 = country2;
        this.postcode2 = postcode2;
        this.state2 = state2;
        this.city2 = city2;
        this.street2 = street2;

        this.fax = fax;
        this.origin = origin;
        this.hometel = hometel;

        this.othertel = othertel;
        this.unit = unit;
        this.assistant = assistant;
        this.assistanttel = assistanttel;

    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            count = db.getInt("SELECT COUNT(wl.member) FROM Worklinkman wl WHERE wl.community=" + DbAdapter.cite(community) + sql);
            // count = db.getInt("SELECT COUNT(wl.member) FROM Worklinkman wl
            // INNER JOIN Profile p ON p.member=wl.member AND p.community=" +
            // DbAdapter.cite(community) + " AND wl.community=" +
            // DbAdapter.cite(community) + " WHERE 1=1 " + sql);
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
            db.executeUpdate("DELETE Worklinkman WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
        this.exists = false;
        _cache.remove(community + ":" + member);
    }

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        { // db.executeQuery("SELECT wl.member FROM Worklinkman wl INNER JOIN Profile p ON p.member=wl.member AND p.community=" + DbAdapter.cite(community) + " AND wl.community="
            // + DbAdapter.cite(community) + " WHERE 1=1 " + sql);
            db.executeQuery("SELECT wl.member FROM Worklinkman wl WHERE wl.community=" + DbAdapter.cite(community) + sql,pos,size);
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

    public int getWorklinkman()
    {
        return worklinkman;
    }

    public String getFtel()
    {
        return ftel;
    }

    public String getEmail()
    {
        return email;
    }

    public String getFpostcode()
    {
        return fpostcode;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getCommunity()
    {
        return community;
    }

    public boolean isSex()
    {
        return sex;
    }

    public Date getBirthday()
    {
        return birthday;
    }

    public String getWorktel()
    {
        return worktel;
    }

    public String getMobile()
    {
        return mobile;
    }

    public String getQicq()
    {
        return qicq;
    }

    public String getMsn()
    {
        return msn;
    }

    public String getJob(int language)
    {
        return job;
    }

    public String getLove(int language)
    {
        return love;
    }

    public String getFaddress(int language)
    {
        return faddress;
    }

    public String getBlog()
    {
        return blog;
    }

    public int getWorkproject()
    {
        return workproject;
    }

    public String getMember()
    {
        return member;
    }

    public String getAssistant()
    {
        return assistant;
    }

    public String getAssistanttel()
    {
        return assistanttel;
    }

    public String getCity()
    {
        return city;
    }

    public String getCity2()
    {
        return city2;
    }

    public String getCountry()
    {
        return country;
    }

    public String getCountry2()
    {
        return country2;
    }

    public String getFax()
    {
        return fax;
    }

    public String getHometel()
    {
        return hometel;
    }

    public int getOrigin()
    {
        return origin;
    }

    public String getOthertel()
    {
        return othertel;
    }

    public String getPostcode()
    {
        return postcode;
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

    public String getUnit()
    {
        return unit;
    }

    public String getName()
    {
        return name;
    }

    public String getJob()
    {
        return job;
    }

    public String getFaddress()
    {
        return faddress;
    }

    public String getContent()
    {
        return content;
    }

    public String getBirthdayToString()
    {
        if(birthday == null)
        {
            return "";
        }
        return sdf.format(birthday);
    }

    public String getName(int language)
    {
        return name;
    }

    public String getContent(int language)
    {
        return content;
    }

    public Date getTimes()
    {
        return times;
    }
}
