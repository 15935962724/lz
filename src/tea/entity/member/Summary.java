package tea.entity.member;

import tea.db.DbAdapter;
import java.sql.SQLException;
import java.sql.SQLException;

public class Summary
{
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
    public Summary()
    {
    }

    public static Summary find(String member,int language) throws SQLException
    {
        return new Summary(member,language);
    }

    public Summary(String member,int language) throws SQLException
    {
        this.member = member;
        this.language = language;
        loadBasic();
    }

    public boolean isExists() throws SQLException
    {
        return exists;
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int bit_hasAbroad = hasAbroad == false ? 0 : 1;
            if(this.isExists())
            {
                db.executeUpdate("SummaryEdit " +
                                 DbAdapter.cite(member) + "," +
                                 language + "," +
                                 (nowTrade) + "," +
                                 DbAdapter.cite(nowMainCareer) + "," +
                                 DbAdapter.cite(nowCareerLevel) + "," +
                                 (experience) + "," +
                                 (bit_hasAbroad) + "," +
                                 DbAdapter.cite(salarySum) + "," +
                                 (expectWorkKind) + "," +
                                 DbAdapter.cite(expectTrade) + "," +
                                 DbAdapter.cite(expectCareer) + "," +
                                 DbAdapter.cite(expectCity) + "," +
                                 DbAdapter.cite(expectSalarySum) + "," +
                                 DbAdapter.cite(joinDateType) + "," +
                                 DbAdapter.cite(selfValue) + "," +
                                 DbAdapter.cite(selfAim)
                        );
            } else
            {
                create();
            }
        } finally
        {
            db.close();
        }
    }

    public void create() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int bit_hasAbroad = hasAbroad == false ? 0 : 1;
            db.executeUpdate("SummaryCreate " +
                             DbAdapter.cite(member) + "," +
                             language + "," +
                             (nowTrade) + "," +
                             DbAdapter.cite(nowMainCareer) + "," +
                             DbAdapter.cite(nowCareerLevel) + "," +
                             (experience) + "," +
                             (bit_hasAbroad) + "," +
                             DbAdapter.cite(salarySum) + "," +
                             (expectWorkKind) + "," +
                             DbAdapter.cite(expectTrade) + "," +
                             DbAdapter.cite(expectCareer) + "," +
                             DbAdapter.cite(expectCity) + "," +
                             DbAdapter.cite(expectSalarySum) + "," +
                             DbAdapter.cite(joinDateType) + "," +
                             DbAdapter.cite(selfValue) + "," +
                             DbAdapter.cite(selfAim)
                    );

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
            db.executeUpdate("DELETE FROM Summary WHERE member=" + this.member + " and language=" + this.language);
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
        //if (!_blLoaded)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT  NowTrade	,NowMainCareer	,NowCareerLevel	,Experience	,HasAbroad	,SalarySum	,ExpectWorkKind	,ExpectTrade	,ExpectCareer	,ExpectCity	,ExpectSalarySum	,JoinDateType,SelfValue,SelfAim	 FROM Summary  WHERE member=" + DbAdapter.cite(this.member) + " and language=" + this.language);
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
                    exists = true;
                } else
                {
                    hasAbroad =
                            exists = false;
//                    nowTrade =
                    nowMainCareer =
                            nowCareerLevel =
//                        experience =
                                    salarySum =
//                        expectWorkKind =
//                        expectTrade =
                                            expectCareer =
                            expectCity =
                                    expectSalarySum =
                                            selfValue =
                            selfAim =
                                    joinDateType = "";
                }
            } finally
            {
                db.close();
            }
            //  _blLoaded = true;
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
}
