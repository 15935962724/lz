package tea.entity.node;

import java.util.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.htmlx.*;
import java.sql.SQLException;

public class Waiter
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
    private int adminUnit;
    private String code;
    private boolean figure;

    public Waiter()
    {
    }

    public static Waiter find(int node,int language) throws SQLException
    {
        Waiter obj = (Waiter) _cache.get(node + ":" + language);
        if(obj == null)
        {
            obj = new Waiter(node,language);
            _cache.put(node + ":" + language,obj);
        }
        return obj;
    }

    public static Enumeration find(String community) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT Node.node FROM Waiter,Node WHERE Node.node=Waiter.node AND community=" + DbAdapter.cite(community));
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

    public static Enumeration findByZone(int zone) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT Node.node FROM Waiter,Node WHERE Node.node=Waiter.node AND adminunit=" + zone);
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

    public Waiter(int node,int language) throws SQLException
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

    public static int findByCode(String code) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT w.node FROM Waiter w WHERE w.code=" + DbAdapter.cite(code));
            if(db.next())
            {
                j = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return j;
    }

    public void set() throws SQLException
    {
        int bit_hasAbroad = hasAbroad == false ? 0 : 1;
        if(this.isExists())
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate("UPDATE Waiter SET name=" + DbAdapter.cite(name) + ",member=" + DbAdapter.cite(member) + ",NowTrade=" + (nowTrade) + ",NowMainCareer=" + DbAdapter.cite(nowMainCareer) + ",NowCareerLevel=" + DbAdapter.cite(nowCareerLevel) + ",Experience=" + (experience) + ",HasAbroad=" + (bit_hasAbroad) + ",SalarySum=" + DbAdapter.cite(salarySum) + ",ExpectWorkKind=" + (expectWorkKind) + ",ExpectTrade=" + DbAdapter.cite(expectTrade) + ",ExpectCareer="
                                 + DbAdapter.cite(expectCareer) + ",ExpectCity=" + DbAdapter.cite(expectCity) + ",ExpectSalarySum=" + DbAdapter.cite(expectSalarySum) + ",JoinDateType=" + DbAdapter.cite(joinDateType) + ",SelfValue=" + DbAdapter.cite(selfValue) + ",SelfAim=" + DbAdapter.cite(selfAim) + ",other=" + DbAdapter.cite(this.other) + ",adminunit=" + (this.adminUnit) + ",code=" + DbAdapter.cite(this.code) + ",figure=" + (figure ? "1" : "0") + " WHERE node=" + node + " AND language=" + language);
            } finally
            {
                db.close();
            }
        } else
        {
            create();
        }
        _cache.remove(node + ":" + language);
    }

    public void create() throws SQLException
    {
        int bit_hasAbroad = hasAbroad == false ? 0 : 1;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Waiter (node,name,member,language,NowTrade,NowMainCareer,NowCareerLevel,Experience,HasAbroad,SalarySum,ExpectWorkKind,ExpectTrade,ExpectCareer,ExpectCity,ExpectSalarySum,JoinDateType,SelfValue,SelfAim,other,adminunit,code,figure)VALUES(" + (node) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(member) + "," + language + "," + (nowTrade) + "," + DbAdapter.cite(nowMainCareer) + "," + DbAdapter.cite(nowCareerLevel) + "," + (experience) + ","
                             + (bit_hasAbroad) + "," + DbAdapter.cite(salarySum) + "," + (expectWorkKind) + "," + DbAdapter.cite(expectTrade) + "," + DbAdapter.cite(expectCareer) + "," + DbAdapter.cite(expectCity) + "," + DbAdapter.cite(expectSalarySum) + "," + DbAdapter.cite(joinDateType) + "," + DbAdapter.cite(selfValue) + "," + DbAdapter.cite(selfAim) + "," + DbAdapter.cite(this.other) + "," + (this.adminUnit) + "," + DbAdapter.cite(this.code) + "," + (figure ? "1" : "0") + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }

    public void delete()
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Waiter WHERE node=" + this.node + " and language=" + this.language);
        } catch(SQLException ex)
        {
            ex.printStackTrace();
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT NowTrade,NowMainCareer,NowCareerLevel,Experience,HasAbroad,SalarySum,ExpectWorkKind,ExpectTrade,ExpectCareer,ExpectCity,ExpectSalarySum,JoinDateType,SelfValue,SelfAim,name,member,other,code,adminunit,figure FROM Waiter WHERE node=" + node + " AND language=" + language);
            if(db.next())
            {
                nowTrade = db.getInt(1);
                nowMainCareer = db.getVarchar(1,language,2);
                nowCareerLevel = db.getVarchar(1,language,3);
                experience = db.getInt(4);
                hasAbroad = db.getInt(5) != 0;
                salarySum = db.getVarchar(1,language,6);
                expectWorkKind = db.getInt(7);
                expectTrade = db.getVarchar(1,language,8);
                expectCareer = db.getVarchar(1,language,9);
                expectCity = db.getVarchar(1,language,10);
                expectSalarySum = db.getVarchar(1,language,11);
                joinDateType = db.getVarchar(1,language,12);
                selfValue = db.getText(1,language,13); //
                selfAim = db.getText(1,language,14);
                name = db.getVarchar(1,language,15);
                member = db.getVarchar(1,language,16);
                other = db.getText(1,language,17);
                code = db.getString(18);
                adminUnit = db.getInt(19);
                figure = db.getInt(20) != 0;
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
                                expectCareer = expectCity = expectSalarySum = selfValue = selfAim = joinDateType = code = "";
            }
        } finally
        {
            db.close();
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

    public void setOther(String other)
    {
        this.other = other;
    }

    public void setAdminUnit(int adminUnit)
    {
        this.adminUnit = adminUnit;
    }

    public void setCode(String code)
    {
        this.code = code;
    }

    public void setFigure(boolean figure)
    {
        this.figure = figure;
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

    public int getAdminUnit()
    {
        return adminUnit;
    }

    public String getCode()
    {
        return code;
    }

    public boolean isFigure()
    {
        return figure;
    }

    public static Enumeration getNode(String member,int language) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT Waiter.node FROM Waiter,Node WHERE Waiter.node=Node.node AND member=" + DbAdapter.cite(member) + " AND language=" + language);
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

    public String getDetail(int node,int listing,int language) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        Waiter job = Waiter.find(node,language);
        if(job.isExists())
        {
            Profile profile = Profile.find(job.getMember());
            ListingDetail detail = ListingDetail.find(listing,52,language);
            Iterator it = detail.keys();
            while(it.hasNext())
            {
                String itemname = (String) it.next(),value = null;
                int istype = detail.getIstype(itemname);
                if(istype == 0)
                {
                    continue;
                }
                if(itemname.equals("name"))
                {
                    value = (profile.getFirstName(language) + profile.getLastName(language));
                } else if(itemname.equals("Sex"))
                {
                    if(profile.isSex())
                    {
                        value = ("男");
                    } else
                    {
                        value = ("女");
                    }
                } else if(itemname.equals("Birth"))
                {
                    if(profile.getBirth() != null)
                    {
                        value = (new java.text.SimpleDateFormat("yyyy/MM").format(profile.getBirth()));
                    }
                } else if(itemname.equals("State"))
                {
                    value = (profile.getState(language));
                } else if(itemname.equals("Degree"))
                {
                    value = (DegreeSelection.getDegree(profile.getDegree(language)));
                } else if(itemname.equals("NowTrade"))
                {
                    value = String.valueOf(job.getNowTrade());
                } else if(itemname.equals("Experience"))
                {
                    value = String.valueOf(job.getExperience());
                } else if(itemname.equals("ExpectCity"))
                {
                    value = (job.getExpectCity());
                } else if(itemname.equals("EmailAddress"))
                {
                    value = (profile.getEmail());
                } else if(itemname.equals("Checkbox"))
                {
                    value = ("<input type=checkbox name=" + node + "/ >");
                } else if(itemname.equals("MajorCategory"))
                {
                    StringBuilder sb2 = new StringBuilder();
                    Enumeration enumeration = Educate.find(node,language);
                    while(enumeration.hasMoreElements())
                    {
                        Educate educate = Educate.find(((Integer) enumeration.nextElement()).intValue());
                        sb2.append(tea.htmlx.MajorSelection.getMajor(educate.getMajorCategory()) + " ");
                    }
                    value = (sb2.toString());
                } else if(itemname.equals("Mobile"))
                {
                    value = (profile.getMobile());
                } else if(itemname.equals("Photo"))
                {
                    value = ("<img src=\"/servlet/PhotoPicture?member=" + job.getMember() + "\" />");
                } else if(itemname.equals("Address"))
                {
                    value = (profile.getAddress(language));
                } else if(itemname.equals("NowTrade"))
                {
                    value = String.valueOf(job.getNowTrade());
                } else if(itemname.equals("NowMainCareer"))
                {
                    value = (job.getNowMainCareer());
                } else if(itemname.equals("NowCareerLevel"))
                {
                    value = (job.getNowCareerLevel());
                } else if(itemname.equals("Experience"))
                {
                    value = String.valueOf(job.getExperience());
                } else if(itemname.equals("HasAbroad"))
                {
                    value = (job.isHasAbroad() ? "是" : "否");
                } else if(itemname.equals("SalarySum"))
                {
                    value = (job.getSalarySum());
                } else if(itemname.equals("ExpectWorkKind"))
                {
                    value = String.valueOf(job.getExpectWorkKind());
                } else if(itemname.equals("ExpectTrade"))
                {
                    value = (job.getExpectTrade());
                } else if(itemname.equals("ExpectCareer"))
                {
                    value = (job.getExpectCareer());
                } else if(itemname.equals("ExpectSalarySum"))
                {
                    value = (job.getExpectSalarySum());
                } else if(itemname.equals("JoinDateType"))
                {
                    value = (job.getJoinDateType());
                } else if(itemname.equals("SelfValue"))
                {
                    value = (job.getSelfValue());
                } else if(itemname.equals("SelfAim"))
                {
                    value = (job.getSelfAim());
                }
                // if (value != null && value.length() > 0)
                {
                    sb.append(detail.getBeforeItem(itemname)).append(value).append(detail.getAfterItem(itemname));
                }
            }
        }
        return sb.toString();
    }
}
