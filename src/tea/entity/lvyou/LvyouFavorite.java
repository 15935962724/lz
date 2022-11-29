package tea.entity.lvyou;

import java.io.*;
import java.sql.SQLException;
import java.util.*;
import java.text.*;
import jxl.*;
import jxl.write.*;
import tea.db.*;
import tea.entity.*;
import tea.resource.*;

public class LvyouFavorite
{
   
    public int id;
    public int jobid;
    public String member;

    public LvyouFavorite()
    {
   
    }
    public static void set(String member,int jobid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int count=0;
        db.executeQuery(" SELECT COUNT(id) FROM lvyoufavorite where  jobid="+jobid+" and member="+ DbAdapter.cite(member));
        System.out.println(" SELECT COUNT(id) FROM lvyoufavorite where  jobid="+jobid+" and member="+ DbAdapter.cite(member));
        
        if(db.next())
        {
        	  
            count= db.getInt(1);
            
        }
        try
        {
             if(count==0)
            {
                db.executeUpdate("INSERT INTO lvyoufavorite (member,jobid)VALUES (" 
                   + DbAdapter.cite(member) + ","  +jobid+ ")");
                System.out.println("INSERT INTO lvyoufavorite (member,jobid)VALUES (" 
                        + DbAdapter.cite(member) + ","  +jobid+ ")");
            }
        } finally
        {
            db.close();
        }
    
    }
    public static void delete(String member,int jobid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
       
        try
        {
         db.executeUpdate("delete from lvyoufavorite where  jobid="+jobid+" and member="+ DbAdapter.cite(member));
          } finally
        {
            db.close();
        }
    
    }

    public static ArrayList<LvyouJob> find(String member,String orderby,String ordertype,String latitude,String longitude) throws SQLException
    {
     	ArrayList<LvyouJob> al = new ArrayList<LvyouJob>();
        DbAdapter db = new DbAdapter();
        try
        {
        	StringBuffer sb=new StringBuffer();
            
            sb.append("SELECT job.id,job.member,job.name,job.jobcatagory, job.province,job.city, job.pcount, job.introduction,job.state " +
            		" FROM lvyoufavorite app,lvyoujob job  ,profilelvyou plv  where plv.member=app.member   and app.jobid=job.id and app.member="+DbAdapter.cite(member));
           
            if(orderby.equals("dist"))
          	   sb.append(" order by  mydistance("+latitude+","+longitude+",plv.latitude,plv.longitude)");
              else  
          	   sb.append(" order by  app.id ");
              sb.append(ordertype);
           System.out.print(sb.toString());
              db.executeQuery(sb.toString());
            while(db.next())
            {
            	 int i=1;
                 LvyouJob lvyoujob = new LvyouJob();
                 lvyoujob.setId(db.getInt(i++));
                 lvyoujob.setMember(db.getString(i++));
                 lvyoujob.setName(db.getString(i++));
                 lvyoujob.setJobcatagory(db.getInt(i++));
                 lvyoujob.setProvince(db.getInt(i++));
                 lvyoujob.setCity(db.getInt(i++));
                 lvyoujob.setPcount(db.getInt(i++));
                 lvyoujob.setIntroduction(db.getString(i++));
                 lvyoujob.setState(db.getInt(i++));
                 al.add(lvyoujob);
            }
        } finally
        {
            db.close();
        }
        return al;
    }
    
    public static ArrayList<LvyouJob> find(String member) throws SQLException
    {
     	ArrayList<LvyouJob> al = new ArrayList<LvyouJob>();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT job.id,job.member,job.name,jobcatagory, province,city, pcount, introduction,state " +
            		" FROM lvyoufavorite app,lvyoujob job  where app.jobid=job.id   and app.member="+DbAdapter.cite(member));
            while(db.next())
            {
            	 int i=1;
                 LvyouJob lvyoujob = new LvyouJob();
                 lvyoujob.setId(db.getInt(i++));
                 lvyoujob.setMember(db.getString(i++));
                 lvyoujob.setName(db.getString(i++));
                 lvyoujob.setJobcatagory(db.getInt(i++));
                 lvyoujob.setProvince(db.getInt(i++));
                 lvyoujob.setCity(db.getInt(i++));
                 lvyoujob.setPcount(db.getInt(i++));
                 lvyoujob.setIntroduction(db.getString(i++));
                 lvyoujob.setState(db.getInt(i++));
                 al.add(lvyoujob);
            }
        } finally
        {
            db.close();
        }
        return al;
    }
    public static ArrayList<ProfileLvyou> find(int jobid) throws SQLException
    {
     	ArrayList<ProfileLvyou> al = new ArrayList<ProfileLvyou>();
        DbAdapter db = new DbAdapter();
        try
        {
        	 db.executeQuery("SELECT	plv.member, plv.province, plv.city, plv.certification, 	" +
             		"plv.years, plv.jobcategory, plv.models, plv.introduction, 	plv.companyname," +
             		"plv.companyperson, plv.companytelephone,plv.companyinfo,plv.headpic,pl.firstname,p.sex,p.birth" +
             		" FROM profilelvyou plv,Profile p,ProfileLayer pl,lvyoufavorite app " +
             		" WHERE plv.member=p.member and pl.member=p.member and app.member=p.member   and app.jobid="+jobid);
            while(db.next())
            {
            	 int i=1;
            	 ProfileLvyou profilelvyou=new ProfileLvyou();
            	 profilelvyou.setMember(db.getString(i++));
                 profilelvyou.setProvince(db.getInt(i++));
                 profilelvyou.setCity(db.getInt(i++));
                 profilelvyou.setCertification(db.getInt(i++));
                 profilelvyou.setYears(db.getString(i++));
                 profilelvyou.setJobcategory(db.getInt(i++));
                 profilelvyou.setModels(db.getString(i++));
                 profilelvyou.setIntroduction(db.getString(i++));
                 profilelvyou.setCompanyname(db.getString(i++));
                 profilelvyou.setCompanyperson(db.getString(i++));
                 profilelvyou.setCompanytelephone(db.getString(i++));
                 profilelvyou.setCompanyinfo(db.getString(i++));
                 profilelvyou.setHeadpic(db.getString(i++));
                 profilelvyou.setName(db.getString(i++));
                 profilelvyou.setSex(db.getInt(i++));
                 profilelvyou.setBirth(db.getDate(i++));
                 al.add(profilelvyou);
            }
        } finally
        {
            db.close();
        }
        return al;
    }
    
    public static int count(int jobid) throws SQLException
    {
     int count=0;
        DbAdapter db = new DbAdapter();
        try
        {
        	 db.executeQuery(" SELECT COUNT(member) FROM lvyoufavorite where  jobid="+jobid);
            if(db.next())
            {
            	  
                count= db.getInt(1);
                
            }
        } finally
        {
            db.close();
        }
        return count;
    }
    public static int count(String member) throws SQLException
    {
     int count=0;
        DbAdapter db = new DbAdapter();
        try
        {
        	 db.executeQuery("SELECT COUNT(jobid) FROM lvyoufavorite where  member="+DbAdapter.cite(member));
            if(db.next())
            {
            	  
                count= db.getInt(1);
                
            }
        } finally
        {
            db.close();
        }
        return count;
    }
    
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getJobid() {
		return jobid;
	}

	public void setJobid(int jobid) {
		this.jobid = jobid;
	}

	public String getMember() {
		return member;
	}

	public void setMember(String member) {
		this.member = member;
	}


  

  

}
