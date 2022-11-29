package tea.entity.node;

import java.math.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.htmlx.*;

public class Client
{
    private static Cache _cache = new Cache(100);
    private String member;
    private int language;
    private int nowTrade;
    private String nowMainCareer;
    private String nowCareerLevel;
    private int experience;
    private boolean hasAbroad;
    private String salarySum;
    private int expectWorkKind;
    private String expectTrade;
    private String expectCareer;
    private String expectCity;
    private String expectSalarySum;
    private String joinDateType;
    private boolean exists;
    private String selfValue;
    private String selfAim;
    private String name;
    private int node;
    private String other;
    private BigDecimal price;
    private int age;
    private boolean sex;

    public Client()
    {
    }

    public static Client find(int node,int language) throws SQLException
    {
        Client obj = (Client) _cache.get(node + ":" + language);
        if(obj == null)
        {
            obj = new Client(node,language);
            _cache.put(node + ":" + language,obj);
        }
        return obj;
    }

    public static Client find(String member) throws SQLException
    {
        tea.db.DbAdapter dbadapter = new tea.db.DbAdapter();
        try
        {
            return find(dbadapter.getInt("SELECT node FROM Node WHERE rcreator=" + DbAdapter.cite(member)),1);
        } finally
        {
            dbadapter.close();
        }
    }

    public Client(int node,int language) throws SQLException
    {
        // this.member = member;
        this.node = node;
        this.language = language;
        // this.name =name;
        loadBasic();
    }

    public boolean isExists() throws SQLException
    {
        return exists;
    }

    public void set() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            int bit_hasAbroad = hasAbroad == false ? 0 : 1;
            if(this.isExists())
            {
                /*
                 * dbadapter.executeUpdate("ClientEdit " + (node) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(member) + "," + language + "," + (nowTrade) + "," + DbAdapter.cite(nowMainCareer) + "," +
                 *
                 * DbAdapter.cite(nowCareerLevel) + "," +
                 *
                 * (experience) + "," + (bit_hasAbroad) + "," + DbAdapter.cite(salarySum) + "," + (expectWorkKind) + "," +
                 *
                 * DbAdapter.cite(expectTrade) + "," + DbAdapter.cite(expectCareer) + "," + DbAdapter.cite(expectCity) + "," +
                 *
                 * DbAdapter.cite(expectSalarySum) + "," + DbAdapter.cite(joinDateType) + "," + DbAdapter.cite(selfValue) + "," + DbAdapter.cite(selfAim) + "," + DbAdapter.cite(this.other) + "," + (this.age) + "," + DbAdapter.cite(this.sex ? "1" : "0") + "," + (this.price != null ? this.price.toString() : "0") );
                 */
                dbadapter.executeUpdate("UPDATE  Client  SET   name=" + DbAdapter.cite(name) + ",member	=" + DbAdapter.cite(member) + ",NowTrade	=" + (nowTrade) + "	,NowMainCareer	=" + DbAdapter.cite(nowMainCareer) + "	,NowCareerLevel	=" + DbAdapter.cite(nowCareerLevel) + "	,Experience	=" + (experience) + "	,HasAbroad	=" + (bit_hasAbroad) + "	,SalarySum	=" + DbAdapter.cite(salarySum) + "	,ExpectWorkKind	=" + (expectWorkKind) + "	,ExpectTrade	=" + DbAdapter.cite(expectTrade) + "	,ExpectCareer	="
                                        + DbAdapter.cite(expectCareer) + "	,ExpectCity	=" + DbAdapter.cite(expectCity) + "	,ExpectSalarySum	=" + DbAdapter.cite(expectSalarySum) + ",JoinDateType	=" + DbAdapter.cite(joinDateType) + "	,SelfValue	=" + DbAdapter.cite(selfValue) + "	,SelfAim	=" + DbAdapter.cite(selfAim) + ",other=" + DbAdapter.cite(this.other) + ",age=" + (this.age) + ",sex=" + DbAdapter.cite(this.sex ? "1" : "0") + ",price=" + (this.price != null ? this.price.toString() : "0") + " WHERE node="
                                        + node + " and language =" + language + "");

            } else
            {
                create();
            }
            _cache.remove(node + ":" + language);
        } finally
        {
            dbadapter.close();
        }
    }

    public void create() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            int bit_hasAbroad = hasAbroad == false ? 0 : 1;
            /*
             * dbadapter.executeUpdate("ClientCreate " + (node) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(member) + "," + language + "," + (nowTrade) + "," + DbAdapter.cite(nowMainCareer) + "," + DbAdapter.cite(nowCareerLevel) + "," + (experience) + "," + (bit_hasAbroad) + "," + DbAdapter.cite(salarySum) + "," + (expectWorkKind) + "," + DbAdapter.cite(expectTrade) + "," + DbAdapter.cite(expectCareer) + "," + DbAdapter.cite(expectCity) + "," + DbAdapter.cite(expectSalarySum) + "," +
             * DbAdapter.cite(joinDateType) + "," + DbAdapter.cite(selfValue) + "," + DbAdapter.cite(selfAim) + "," + DbAdapter.cite(this.other) + "," + (this.age) + "," + DbAdapter.cite(this.sex ? "1" : "0") + "," + (price != null ? this.price.toString() : "0") );
             */
            dbadapter.executeUpdate("INSERT INTO Client (node,name,member		,language	,NowTrade	,NowMainCareer	,NowCareerLevel	,Experience	,HasAbroad,SalarySum	,ExpectWorkKind,ExpectTrade,ExpectCareer,ExpectCity,ExpectSalarySum,JoinDateType,SelfValue	,SelfAim,other,age,sex,price) VALUES(" + node + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(member) + "," + language + "," + (nowTrade) + "	," + DbAdapter.cite(nowMainCareer) + "	," + DbAdapter.cite(nowCareerLevel) + "	," + (experience) + "	,"
                                    + (bit_hasAbroad) + "	," + DbAdapter.cite(salarySum) + "	," + (expectWorkKind) + "	," + DbAdapter.cite(expectTrade) + "	," + DbAdapter.cite(expectCareer) + "	," + DbAdapter.cite(expectCity) + "	," + DbAdapter.cite(expectSalarySum) + "	," + DbAdapter.cite(joinDateType) + "	," + DbAdapter.cite(selfValue) + "	," + DbAdapter.cite(selfAim) + "," + DbAdapter.cite(this.other) + "," + (this.age) + "," + DbAdapter.cite(this.sex ? "1" : "0") + ","
                                    + (price != null ? this.price.toString() : "0") + ")");
            _cache.remove(node + ":" + language);
        } finally
        {
            dbadapter.close();
        }
    }

    public void delete()
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("DELETE FROM Client WHERE node=" + this.node + " and language=" + this.language);
            _cache.remove(node + ":" + language);
        } catch(SQLException ex)
        {
            ex.printStackTrace();
        } finally
        {
            dbadapter.close();
        }
    }

    private void loadBasic() throws SQLException
    {
        // if (!_blLoaded)
        {
            DbAdapter dbadapter = new DbAdapter();
            try
            {
                dbadapter.executeQuery("SELECT  NowTrade	,NowMainCareer	,NowCareerLevel	,Experience	,HasAbroad	,SalarySum	,ExpectWorkKind	,ExpectTrade	,ExpectCareer	,ExpectCity	,ExpectSalarySum	,JoinDateType,SelfValue,SelfAim,name,member,other,price,age,sex	 FROM Client  WHERE node=" + (this.node) + "  and language=" + this.language);
                if(dbadapter.next())
                {
                    nowTrade = dbadapter.getInt(1);
                    nowMainCareer = dbadapter.getVarchar(1,this.language,2);
                    nowCareerLevel = dbadapter.getVarchar(1,this.language,3);
                    experience = dbadapter.getInt(4);
                    hasAbroad = dbadapter.getInt(5) != 0;
                    salarySum = dbadapter.getVarchar(1,this.language,6);
                    expectWorkKind = dbadapter.getInt(7);
                    expectTrade = dbadapter.getVarchar(1,this.language,8);
                    expectCareer = dbadapter.getVarchar(1,this.language,9);
                    expectCity = dbadapter.getVarchar(1,this.language,10);
                    expectSalarySum = dbadapter.getVarchar(1,this.language,11);
                    joinDateType = dbadapter.getVarchar(1,this.language,12);
                    selfValue = dbadapter.getVarchar(1,this.language,13);
                    selfAim = dbadapter.getVarchar(1,this.language,14);
                    (name) = dbadapter.getVarchar(1,this.language,15);
                    member = dbadapter.getVarchar(1,this.language,16);
                    this.other = dbadapter.getVarchar(1,this.language,17);
                    price = dbadapter.getBigDecimal(18,4);
                    age = dbadapter.getInt(19);
                    sex = dbadapter.getInt(20) != 0;
                    exists = true;
                } else
                {
                    hasAbroad = exists = false;
                    // nowTrade =
                    nowMainCareer = nowCareerLevel =
                            // experience =
                            salarySum =
                                    // expectWorkKind =
                                    // expectTrade =
                                    expectCareer = expectCity = expectSalarySum = selfValue = selfAim = joinDateType = "";
                }
            } finally
            {
                dbadapter.close();
            }
            // _blLoaded = true;
        }
    }

    public void setMember(String member)
    {
        this.member = member;
    }

    public void setLanguage(int language)
    {
        this.language = language;
    }

    public void setNowTrade(int nowTrade)
    {
        this.nowTrade = nowTrade;
    }

    public void setNowMainCareer(String nowMainCareer)
    {
        this.nowMainCareer = nowMainCareer;
    }

    public void setNowCareerLevel(String nowCareerLevel)
    {
        this.nowCareerLevel = nowCareerLevel;
    }

    public void setExperience(int experience)
    {
        this.experience = experience;
    }

    public void setHasAbroad(boolean hasAbroad)
    {
        this.hasAbroad = hasAbroad;
    }

    public void setSalarySum(String salarySum)
    {
        this.salarySum = salarySum;
    }

    public void setExpectWorkKind(int expectWorkKind)
    {
        this.expectWorkKind = expectWorkKind;
    }

    public void setExpectTrade(String expectTrade)
    {
        this.expectTrade = expectTrade;
    }

    public void setExpectCareer(String expectCareer)
    {
        this.expectCareer = expectCareer;
    }

    public void setExpectCity(String expectCity)
    {
        this.expectCity = expectCity;
    }

    public void setExpectSalarySum(String expectSalarySum)
    {
        this.expectSalarySum = expectSalarySum;
    }

    public void setJoinDateType(String joinDateType)
    {
        this.joinDateType = joinDateType;
    }

    public void setSelfValue(String selfValue)
    {
        this.selfValue = selfValue;
    }

    public void setSelfAim(String selfAim)
    {
        this.selfAim = selfAim;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public void setNode(int node)
    {
        this.node = node;
    }

    public void setOther(String other)
    {
        this.other = other;
    }

    public void setPrice(BigDecimal price) throws SQLException
    {

        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("UPDATE Client SET price=" + price.toString() + " WHERE node=" + this.node + " AND language=" + language);
            this.price = price;
        } finally
        {
            dbadapter.close();
        }
    }

    public void setAge(int age)
    {
        this.age = age;
    }

    public void setSex(boolean sex)
    {
        this.sex = sex;
    }

    public String getMember()
    {
        return member;
    }

    public int getLanguage()
    {
        return language;
    }

    public int getNowTrade()
    {
        return nowTrade;
    }

    public String getNowMainCareer()
    {
        return nowMainCareer;
    }

    public String getNowCareerLevel()
    {
        return nowCareerLevel;
    }

    public int getExperience()
    {
        return experience;
    }

    public boolean isHasAbroad()
    {
        return hasAbroad;
    }

    public String getSalarySum()
    {
        return salarySum;
    }

    public int getExpectWorkKind()
    {
        return expectWorkKind;
    }

    public String getExpectTrade()
    {
        return expectTrade;
    }

    public String getExpectCareer()
    {
        return expectCareer;
    }

    public String getExpectCity()
    {
        return expectCity;
    }

    public String getExpectSalarySum()
    {
        return expectSalarySum;
    }

    public String getJoinDateType()
    {
        return joinDateType;
    }

    public String getSelfValue()
    {
        return selfValue;
    }

    public String getSelfAim()
    {
        return selfAim;
    }

    public String getName()
    {
        return name;
    }

    public int getNode()
    {
        return node;
    }

    public String getOther()
    {
        return other;
    }

    public BigDecimal getPrice()
    {
        return price;
    }

    public int getAge()
    {
        return age;
    }

    public boolean isSex()
    {
        return sex;
    }

    public static java.util.Enumeration getNode(String member,int language) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT Client.node FROM Client,Node WHERE Client.node=Node.node AND member=" + DbAdapter.cite(member) + " AND language=" + language);
            while(dbadapter.next())
            {
                vector.addElement(new Integer(dbadapter.getInt(1)));
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    /**
     * getDetail
     *
     * @param i
     *            int
     * @param listing
     *            int
     * @param iLanguage
     *            int
     * @return Enumeration
     */
    public Enumeration getDetail(int node,int listing,int language)
    {
        java.util.Vector vector = new java.util.Vector();
        Node obj = Node.find(node);
        try
        {
            Client job = Client.find(node,language);
            if(job.isExists())
            {
                Profile profile = Profile.find(obj.getCreator()._strR);
                ListingDetail ld = ListingDetail.find(listing,52,language);;
                Iterator e = ld.keys();
                while(e.hasNext())
                {
                    String name=(String)e.next();
                    String value = null;
                    if(name.equals("name"))
                    {
                        value = (profile.getFirstName(language) + profile.getLastName(language));
                    } else if(name.equals("Sex"))
                    {
                        if(profile.isSex())
                        {
                            value = ("男");
                        } else
                        {
                            value = ("女");
                        }
                    } else if(name.equals("Birth"))
                    {
                        if(profile.getBirth() != null)
                        {
                            value = (new java.text.SimpleDateFormat("yyyy/MM").format(profile.getBirth()));
                        }
                    } else if(name.equals("State"))
                    {
                        value = (profile.getState(language));
                    } else if(name.equals("Degree"))
                    {
                        value = (DegreeSelection.getDegree(profile.getDegree(language)));
                    } else if(name.equals("NowTrade"))
                    {
                        value = String.valueOf(job.getNowTrade());
                    } else if(name.equals("Experience"))
                    {
                        value = String.valueOf(job.getExperience());
                    } else if(name.equals("ExpectCity"))
                    {
                        value = (job.getExpectCity());
                    } else if(name.equals("EmailAddress"))
                    {
                        value = (profile.getEmail());
                    } else if(name.equals("Checkbox"))
                    {
                        value = ("<input type=checkbox name=" + node + "/ >");
                    } else if(name.equals("MajorCategory"))
                    {
                        StringBuilder sb = new StringBuilder();
                        java.util.Enumeration enumeration = Educate.find(node,language);
                        while(enumeration.hasMoreElements())
                        {
                            Educate educate = Educate.find(((Integer) enumeration.nextElement()).intValue());
                            sb.append(tea.htmlx.MajorSelection.getMajor(educate.getMajorCategory()) + " ");
                        }
                        value = (sb.toString());
                    } else if(name.equals("Mobile"))
                    {
                        value = (profile.getMobile());
                    } else if(name.equals("Photo"))
                    {
                        value = ("<img src=\"/servlet/PhotoPicture?member=" + job.getMember() + "\" />");
                    } else if(name.equals("Address"))
                    {
                        value = (profile.getAddress(language));
                    } else if(name.equals("NowTrade"))
                    {
                        value = String.valueOf(job.getNowTrade());
                    } else if(name.equals("NowMainCareer"))
                    {
                        value = (job.getNowMainCareer());
                    } else if(name.equals("NowCareerLevel"))
                    {
                        value = (job.getNowCareerLevel());
                    } else if(name.equals("Experience"))
                    {
                        value = String.valueOf(job.getExperience());
                    } else if(name.equals("HasAbroad"))
                    {
                        value = (job.isHasAbroad() ? "是" : "否");
                    } else if(name.equals("SalarySum"))
                    {
                        value = (job.getSalarySum());
                    } else if(name.equals("ExpectWorkKind"))
                    {
                        value = String.valueOf(job.getExpectWorkKind());
                    } else if(name.equals("ExpectTrade"))
                    {
                        value = (job.getExpectTrade());
                    } else if(name.equals("ExpectCareer"))
                    {
                        value = (job.getExpectCareer());
                    } else if(name.equals("ExpectSalarySum"))
                    {
                        value = (job.getExpectSalarySum());
                    } else if(name.equals("JoinDateType"))
                    {
                        value = (job.getJoinDateType());
                    } else if(name.equals("SelfValue"))
                    {
                        value = (job.getSelfValue());
                    } else if(name.equals("SelfAim"))
                    {
                        value = (job.getSelfAim());
                    }
                    // if (value != null && value.length() > 0)
                    {
                        vector.addElement(value);
                    }
                }
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
        return vector.elements();
    }
}
