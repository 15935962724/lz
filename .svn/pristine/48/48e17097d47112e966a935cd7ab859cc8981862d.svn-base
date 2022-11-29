package tea.entity.node;

import java.util.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.htmlx.*;
import java.sql.SQLException;

public class Admin extends Entity
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

    public Admin()
    {
    }

    public static Admin find(int node,int language) throws SQLException
    {
        Admin obj = (Admin) _cache.get(node + ":" + language);
        if(obj == null)
        {
            obj = new Admin(node,language);
            _cache.put(node + ":" + language,obj);
        }
        return obj;
    }

    public Admin(int node,int language) throws SQLException
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
        int bit_hasAbroad = hasAbroad == false ? 0 : 1;
        if(this.isExists())
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate("UPDATE Admin SET name=" + DbAdapter.cite(name) + ",member=" + DbAdapter.cite(member) + ",NowTrade=" + (nowTrade) + ",NowMainCareer=" + DbAdapter.cite(nowMainCareer) + ",NowCareerLevel=" + DbAdapter.cite(nowCareerLevel) + ",Experience=" + (experience) + ",HasAbroad=" + (bit_hasAbroad) + ",SalarySum=" + DbAdapter.cite(salarySum) + ",ExpectWorkKind=" + (expectWorkKind) + ",ExpectTrade=" + DbAdapter.cite(expectTrade) + ",ExpectCareer="
                                 + DbAdapter.cite(expectCareer) + ",ExpectCity=" + DbAdapter.cite(expectCity) + ",ExpectSalarySum=" + DbAdapter.cite(expectSalarySum) + ",JoinDateType=" + DbAdapter.cite(joinDateType) + ",SelfValue=" + DbAdapter.cite(selfValue) + ",SelfAim=" + DbAdapter.cite(selfAim) + ",other=" + DbAdapter.cite(this.other) + " WHERE node=" + (node) + " language=" + language + "");
                /*
                 * db.executeUpdate("AdminEdit " + (node) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(member) + "," + language + "," + (nowTrade) + "," + DbAdapter.cite(nowMainCareer) + "," + DbAdapter.cite(nowCareerLevel) + "," + (experience) + "," + (bit_hasAbroad) + "," + DbAdapter.cite(salarySum) + "," + (expectWorkKind) + "," + DbAdapter.cite(expectTrade) + "," + DbAdapter.cite(expectCareer) + "," + DbAdapter.cite(expectCity) + "," + DbAdapter.cite(expectSalarySum) + "," +
                 * DbAdapter.cite(joinDateType) + "," + DbAdapter.cite(selfValue) + "," + DbAdapter.cite(selfAim) + "," + DbAdapter.cite(this.other) );
                 */
            } finally
            {
                db.close();
            }
            _cache.remove(node + ":" + language);
        } else
        {
            create();
        }
    }

    public void create() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int bit_hasAbroad = hasAbroad == false ? 0 : 1;
            db.executeUpdate("INSERT INTO Admin (node,name,member,language,NowTrade,NowMainCareer,NowCareerLevel,Experience,HasAbroad,SalarySum,ExpectWorkKind,ExpectTrade,ExpectCareer,ExpectCity,ExpectSalarySum,JoinDateType,SelfValue,SelfAim,other) " + "VALUES(" + (node) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(member) + "," + language + "," + (nowTrade) + "," + DbAdapter.cite(nowMainCareer) + "," + DbAdapter.cite(nowCareerLevel) + "," + (experience) + "," + (bit_hasAbroad) + ","
                             + DbAdapter.cite(salarySum) + "," + (expectWorkKind) + "," + DbAdapter.cite(expectTrade) + "," + DbAdapter.cite(expectCareer) + "," + DbAdapter.cite(expectCity) + "," + DbAdapter.cite(expectSalarySum) + "," + DbAdapter.cite(selfValue) + "," + DbAdapter.cite(selfValue) + "," + DbAdapter.cite(selfAim) + "," + DbAdapter.cite(this.other) + ")");
            /*
             * db.executeUpdate("AdminCreate " + (node) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(member) + "," + language + "," + (nowTrade) + "," + DbAdapter.cite(nowMainCareer) + "," + DbAdapter.cite(nowCareerLevel) + "," + (experience) + "," + (bit_hasAbroad) + "," + DbAdapter.cite(salarySum) + "," + (expectWorkKind) + "," + DbAdapter.cite(expectTrade) + "," + DbAdapter.cite(expectCareer) + "," + DbAdapter.cite(expectCity) + "," + DbAdapter.cite(expectSalarySum) + "," +
             * DbAdapter.cite(joinDateType) + "," + DbAdapter.cite(selfValue) + "," + DbAdapter.cite(selfAim) + "," + DbAdapter.cite(this.other));
             */
            _cache.remove(node + ":" + language);
        } finally
        {
            db.close();
        }
    }

    public void delete()
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Admin WHERE node=" + this.node + " and language=" + this.language);
            _cache.remove(node + ":" + language);
        } catch(SQLException ex)
        {
            ex.printStackTrace();
        } finally
        {
            db.close();
        }
    }

    private void loadBasic() throws SQLException
    {
        // if (!_blLoaded)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT  NowTrade	,NowMainCareer	,NowCareerLevel	,Experience	,HasAbroad	,SalarySum	,ExpectWorkKind	,ExpectTrade	,ExpectCareer	,ExpectCity	,ExpectSalarySum	,JoinDateType,SelfValue,SelfAim,name,member,other	 FROM Admin  WHERE node=" + (this.node) + "  and language=" + this.language);
                if(db.next())
                {
                    nowTrade = db.getInt(1);
                    nowMainCareer = db.getVarchar(1,this.language,2);
                    nowCareerLevel = db.getVarchar(1,this.language,3);
                    experience = db.getInt(4);
                    hasAbroad = db.getInt(5) != 0;
                    salarySum = db.getVarchar(1,this.language,6);
                    expectWorkKind = db.getInt(7);
                    expectTrade = db.getVarchar(1,this.language,8);
                    expectCareer = db.getVarchar(1,this.language,9);
                    expectCity = db.getVarchar(1,this.language,10);
                    expectSalarySum = db.getVarchar(1,this.language,11);
                    joinDateType = db.getVarchar(1,this.language,12);
                    selfValue = db.getVarchar(1,this.language,13);
                    selfAim = db.getVarchar(1,this.language,14);
                    (name) = db.getVarchar(1,this.language,15);
                    member = db.getVarchar(1,this.language,16);
                    this.other = db.getVarchar(1,this.language,17);
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
                db.close();
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

    public static java.util.Enumeration getNode(String member,int language) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT Admin.node FROM Admin,Node WHERE Admin.node=Node.node AND member=" + DbAdapter.cite(member) + " AND language=" + language);
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
        Node obj = Node.find(node);
        Admin job = Admin.find(node,language);
        if(job.isExists())
        {
            ListingDetail ld = ListingDetail.find(listing,52,language);
            java.util.Iterator e = ld.keys();
            Profile profile = Profile.find(obj.getCreator()._strR);
            while(e.hasNext())
            {
                String name = (String) e.next();
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
                    StringBuilder sb2 = new StringBuilder();
                    java.util.Enumeration enumeration = Educate.find(node,language);
                    while(enumeration.hasMoreElements())
                    {
                        Educate educate = Educate.find(((Integer) enumeration.nextElement()).intValue());
                        sb2.append(tea.htmlx.MajorSelection.getMajor(educate.getMajorCategory()) + " ");
                    }
                    value = (sb2.toString());
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
                    sb.append(ld.getBeforeItem(name)).append(value).append(ld.getAfterItem(name));
                }
            }
        }
        return sb.toString();
    }
}
