package tea.entity.node;

import tea.db.DbAdapter;
import java.sql.SQLException;
import java.sql.SQLException;
import java.io.*;

public class EntSearch
{
    private String cctgr;
    private String skrCity;
    private int industry;
    private String jobCategory;
    private String tgtCity;
    private String skrdeg;
    private int majorCategory;
    private boolean exists;
    private int language = 1;
    private String name;
    private int skrInd;
    private String skrOcc;

    public static EntSearch find(String name, int language) throws SQLException
    {
        return new EntSearch(name, language);
    }

    public EntSearch(String name, int language) throws SQLException
    {
        this.name = name;
        this.language = language;
        loadBasic();
    }

    public boolean isExists() throws SQLException
    {
        return exists;
    }

    public void set() throws SQLException
    {
        if (this.isExists())
        {
            DbAdapter dbadapter = new DbAdapter();
            try
            {
               /* dbadapter.executeUpdate("EntSearchEdit " +
                                        DbAdapter.cite(name) + ",'" +
                                        (skrInd) + "'," +
                                        DbAdapter.cite(skrOcc) + "," +
                                        DbAdapter.cite(cctgr) + "," +
                                        DbAdapter.cite(skrCity) + ",'" +
                                        (industry) + "'," +
                                        DbAdapter.cite(jobCategory) + "," +
                                        DbAdapter.cite(tgtCity) + "," +
                                        DbAdapter.cite(skrdeg) + ",'" +
                                        (majorCategory) + "'," +
                                        this.language);
                                        */
            	dbadapter.executeUpdate("UPDATE EntSearch  SET skrind	="+(skrInd)+",skrocc="+ DbAdapter.cite(skrOcc)+",cctgr ="+DbAdapter.cite(cctgr)+",skrcity 	="+ DbAdapter.cite(skrCity)+" 	,industry 	="+(industry)+" 	,jobcategory 	="+DbAdapter.cite(jobCategory)+" 	,tgtcity 	="+DbAdapter.cite(tgtCity)+" 	,skrdeg 		="+DbAdapter.cite(skrdeg)+",majorcategory	="+(majorCategory)+"WHERE  name="+DbAdapter.cite(name)+"  	AND language="+language);

            } finally
            {
                dbadapter.close();
            }
        } else
            create();
    }

    public void create() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
          /* dbadapter.executeUpdate("EntSearchCreate " +
                                    DbAdapter.cite(name) + ",'" +
                                    (skrInd) + "'," +
                                    DbAdapter.cite(skrOcc) + "," +
                                    DbAdapter.cite(cctgr) + "," +
                                    DbAdapter.cite(skrCity) + ",'" +
                                    (industry) + "'," +
                                    DbAdapter.cite(jobCategory) + "," +
                                    DbAdapter.cite(tgtCity) + "," +
                                    DbAdapter.cite(skrdeg) + ",'" +
                                    (majorCategory) + "'," +
                                    this.language);
                                    */
        	dbadapter.executeUpdate("INSERT INTO EntSearch (name,skrind,skrocc,cctgr ,skrcity,industry,jobcategory,tgtcity ,skrdeg ,majorcategory,language	) VALUES("+DbAdapter.cite(name)+"		,"+(skrInd)+"		,"+ DbAdapter.cite(skrOcc) +"		,"+ DbAdapter.cite(cctgr)+" 		,"+ DbAdapter.cite(skrCity)+" 	,"+(industry)+" 	,"+DbAdapter.cite(jobCategory)+" 	,"+ DbAdapter.cite(tgtCity)+" 	,"+DbAdapter.cite(skrdeg)+" 	,"+(majorCategory)+" ,"+this.language+"	)");
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
            dbadapter.executeUpdate("DELETE FROM EntSearch WHERE name=" + DbAdapter.cite(this.name) + " and language=" + this.language);
        } catch (SQLException ex)
        {
            ex.printStackTrace();
        } finally
        {
            dbadapter.close();
        }
    }

    private void loadBasic() throws SQLException
    {
        //if (!_blLoaded)
        {
            DbAdapter dbadapter = new DbAdapter();
            try
            {
                dbadapter.executeQuery("SELECT  cctgr,	skrcity,	industry,	jobcategory,	tgtcity,	skrdeg,	majorcategory,skrind,skrocc	 FROM EntSearch WHERE name=" + DbAdapter.cite(this.name) + " AND language=" + this.language);
                if (dbadapter.next())
                {
                    cctgr = dbadapter.getVarchar(1, this.language, 1);
                    skrCity = dbadapter.getVarchar(1, this.language, 2);
                    industry = dbadapter.getInt(3); //dbadapter.getVarchar(1, this.language, 3);
                    jobCategory = dbadapter.getVarchar(1, this.language, 4);
                    tgtCity = dbadapter.getVarchar(1, this.language, 5);
                    skrdeg = dbadapter.getVarchar(1, this.language, 6);
                    majorCategory = dbadapter.getInt(7); //1, this.language, 7);
                    skrInd = dbadapter.getInt(8); // dbadapter.getVarchar(1, this.language, 8);
                    skrOcc = dbadapter.getVarchar(1, this.language, 9);
                    exists = true;
                } else
                {
                    exists = false;
//                    skrInd =
                    skrOcc =
                        cctgr =
                        skrCity =
                        //                      industry =
                        jobCategory =
                        tgtCity =
                        skrdeg = "";
//                        majorCategory
                }
            } finally
            {
                dbadapter.close();
            }
            //  _blLoaded = true;
        }
    }

    public static java.util.Enumeration find() throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT name,language FROM EntSearch");
            while (dbadapter.next())
                vector.addElement(dbadapter.getVarchar(1, dbadapter.getInt(2), 1));
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    public static java.util.Vector findEntItems(tea.ui.TeaSession teasession)
    {
        tea.db.DbAdapter dbadapter = new tea.db.DbAdapter();
        java.util.Vector vector = new java.util.Vector();
        try
        {
            StringBuilder sb = new StringBuilder();
            String str = teasession.getParameter("skr_cctgr_id"); //现职位级别
            if (str != null && str.length() > 0)
                sb.append(" NowCareerLevel=" + DbAdapter.cite(str));

            //teasession.getParameter("skr_cctgr_id");//现地区
            str = teasession.getParameter("skr_loc_city_id"); //现地区
            if (str != null && str.length() > 0)
                sb.append(" AND ExpectTrade like " + DbAdapter.cite(str));

            str = teasession.getParameter("ExpectIndustry"); //期望从事行业
            if (str != null && str.length() > 0)
                sb.append(" AND ExpectTrade like " + str);

            str = teasession.getParameter("ExpectJobCategory"); //期望从事职业
            if (str != null && str.length() > 0)
                sb.append(" AND ExpectCareer like " + str);

            str = teasession.getParameter("tgt_loc_city_id"); //期望地区
            if (str != null && str.length() > 0)
                sb.append(" AND ExpectCity like " + str);
            str = teasession.getParameter("skr_deg_id"); //学历
            if (str != null && str.length() > 0)
            {
                sb.append(" AND Educate.degree=" + str); //degree        //Educate
            } //                sb.append(" AND ExpectCity like " + str);

//            teasession.getParameter("degreeup"); //含更高学历

            str = teasession.getParameter("MajorCategory"); //所学专业类别
            if (str != null && str.length() > 0)
                sb.append(" AND Educate.majorcategory=" + str);
//            teasession.getParameter("skr_wrk_year"); //工作经验
            teasession.getParameter("keyword"); //关键词
            //现行业//现职业
            dbadapter.executeQuery("SELECT Summary.member FROM Summary,Educate WHERE language=" + teasession._nLanguage + " and NowTrade=" + DbAdapter.cite(teasession.getParameter("skr_ind_id")) + " AND NowMainCareer=" + DbAdapter.cite(teasession.getParameter("skr_occ_id")) + sb.toString());
            while (dbadapter.next())
                vector.addElement(dbadapter.getString(1));
        } catch (SQLException ex)
        {
            ex.printStackTrace();
        } finally
        {
            dbadapter.close();
        }
        return vector;
    }

    public void setCctgr(String cctgr)
    {
        this.cctgr = cctgr;
    }

    public void setSkrCity(String skrCity)
    {
        this.skrCity = skrCity;
    }

    public void setIndustry(int industry)
    {
        this.industry = industry;
    }

    public void setJobCategory(String jobCategory)
    {
        this.jobCategory = jobCategory;
    }

    public void setTgtCity(String tgtCity)
    {
        this.tgtCity = tgtCity;
    }

    public void setSkrdeg(String skrdeg)
    {
        this.skrdeg = skrdeg;
    }

    public void setMajorCategory(int majorCategory)
    {
        this.majorCategory = majorCategory;
    }

    public void setLanguage(int language)
    {
        this.language = language;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public void setSkrInd(int skrInd)
    {
        this.skrInd = skrInd;
    }

    public void setSkrOcc(String skrOcc)
    {
        this.skrOcc = skrOcc;
    }

    public String getCctgr()
    {
        return cctgr;
    }

    public String getSkrCity()
    {
        return skrCity;
    }

    public int getIndustry()
    {
        return industry;
    }

    public String getJobCategory()
    {
        return jobCategory;
    }

    public String getTgtCity()
    {
        return tgtCity;
    }

    public String getSkrdeg()
    {
        return skrdeg;
    }

    public int getMajorCategory()
    {
        return majorCategory;
    }

    public int getLanguage()
    {
        return language;
    }

    public String getName()
    {
        try
        {
            return new String(name.getBytes("ISO-8859-1"));
        } catch (UnsupportedEncodingException ex)
        {
            return "";
        }
    }

    public int getSkrInd()
    {
        return skrInd;
    }

    public String getSkrOcc()
    {
        return skrOcc;
    }
}
