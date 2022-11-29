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

public class LvyouApply
{
   
    public int id;
    public int jobid;
    public String member;
    public Date apptime;
    public LvyouApply()
    {
   
    }
    public static void set(String member,int jobid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int count=0;
        db.executeQuery(" SELECT COUNT(id) FROM lvyouapply where  jobid="+jobid+" and member="+ DbAdapter.cite(member));
        System.out.println(" SELECT COUNT(id) FROM lvyouapply where  jobid="+jobid+" and member="+ DbAdapter.cite(member));
        
        if(db.next())
        {
        	  
            count= db.getInt(1);
            
        }
        Date today=new Date();
        try
        {
             if(count==0)
            {
                db.executeUpdate("INSERT INTO lvyouapply (member,jobid,apptime)VALUES (" 
                   + DbAdapter.cite(member) + ","  +jobid+ "," + DbAdapter.cite(today)+")");
                
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
         db.executeUpdate("delete from lvyouapply where  jobid="+jobid+" and member="+ DbAdapter.cite(member));
          } finally
        {
            db.close();
        }
    
    }
    
    public static  LvyouApply find(String member,int jobid) throws SQLException
    {
    	LvyouApply apply=new LvyouApply();
    	DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id,jobid,member,apptime FROM lvyouapply  where member="+DbAdapter.cite(member)+" and jobid="+jobid);
            while(db.next())
            {
             
            	 apply.setId(db.getInt(1));
            	 apply.setJobid(db.getInt(2));
            	 apply.setMember(db.getString(3));
            	 apply.setApptime(db.getDate(4));
                
            }
        } finally
        {
            db.close();
        }
        return apply;
    }
    
    public static ArrayList<LvyouJob> find(String member) throws SQLException
    {
     	ArrayList<LvyouJob> al = new ArrayList<LvyouJob>();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT job.id,job.member,job.name,jobcatagory, province,city, pcount, introduction,state " +
            		" FROM lvyouapply app,lvyoujob job  where app.jobid=job.id and app.member="+DbAdapter.cite(member));
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
        public static ArrayList<LvyouJob> find(String member,String orderby,String ordertype,String latitude,String longitude) throws SQLException
    {
     	ArrayList<LvyouJob> al = new ArrayList<LvyouJob>();
        DbAdapter db = new DbAdapter();
        try
        {StringBuffer sb=new StringBuffer();
        
            sb.append("SELECT job.id,job.member,job.name,job.jobcatagory, job.province,job.city, job.pcount, job.introduction,job.state " +
            		" FROM lvyouapply app,lvyoujob job,profilelvyou plv  where plv.member=app.member and app.jobid=job.id and app.member="+DbAdapter.cite(member));
            if(orderby.equals("dist"))
         	   sb.append(" order by  mydistance("+latitude+","+longitude+",plv.latitude,plv.longitude)");
             else  
         	   sb.append(" order by  app.apptime ");
             sb.append(ordertype);
          // System.out.print(sb.toString());
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
    
    public static ArrayList<LvyouJob> find(String name,String companyname,int province,int city,
    		int catagory,int state,String day1,String day2,String member,int page,int size) throws SQLException
    {
    	ArrayList<LvyouJob> al = new ArrayList<LvyouJob>();
        DbAdapter db = new DbAdapter();
        StringBuffer sb=new StringBuffer();
        try
        {
        	sb.append("SELECT	job.id,job.member,job.name,job.jobcatagory, job.province,job.city, job.pcount, job.introduction,job.state,job.issuetime " +
        			"FROM lvyoujob job,Profile p,ProfileLayer pl,profilelvyou plv,lvyouapply app  " +
        			"WHERE p.member=pl.member and job.member=p.member and plv.member=p.member  and app.jobid=job.id and app.member="+DbAdapter.cite(member));
        	if(!name.trim().equals(""))
        	sb.append(" and (plv.companyperson like '%" +name+"%')");
        	if(!companyname.trim().equals(""))
            	sb.append(" and (plv.companyname like '%" +companyname+"%')");
        	if(province!=0)
        	sb.append(" and job.province="+province);
        	if(city!=0)
            sb.append(" and job.city="+city);
        	if(catagory!=0)
            sb.append(" and job.jobcatagory="+catagory);
        	if(state!=-1)
            sb.append(" and job.state="+state);
        	 
        	if((!day1.trim().equals(""))&&(!day2.trim().equals("")))
            	 sb.append(" and (job.issuetime between "+DbAdapter.cite(day1)+" and "+DbAdapter.cite(day2)+")");	
        	db.executeQuery(sb.toString(),page,size); 
        	
        	  while(db.next())
            {  int i=1;
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
               lvyoujob.setIssuetime(db.getDate(i++));
               al.add(lvyoujob);
            }
        } finally
        {
            db.close();
        }
        return al;
    }
    public static int count(String name,String companyname,int province,int city,
    		int catagory,int state,String day1,String day2,String member ) throws SQLException
    {
    	int count=0;
        DbAdapter db = new DbAdapter();
        StringBuffer sb=new StringBuffer();
        try
        {
        	sb.append("select count(job.id) " +
        			"FROM lvyoujob job,Profile p,ProfileLayer pl,profilelvyou plv,lvyouapply app  " +
        			"WHERE p.member=pl.member and job.member=p.member and plv.member=p.member and app.jobid=job.id and app.member="+DbAdapter.cite(member));
        	if(!name.trim().equals(""))
        	sb.append(" and (plv.companyperson like '%" +name+"%')");
        	if(!companyname.trim().equals(""))
            	sb.append(" and (plv.companyname like '%" +companyname+"%')");
        	if(province!=0)
        	sb.append(" and job.province="+province);
        	if(city!=0)
            sb.append(" and job.city="+city);
        	if(catagory!=0)
            sb.append(" and job.jobcatagory="+catagory);
        	if(state!=-1)
            sb.append(" and job.state="+state);
        	 
        	if((!day1.trim().equals(""))&&(!day2.trim().equals("")))
            	 sb.append(" and (job.issuetime between "+DbAdapter.cite(day1)+" and "+DbAdapter.cite(day2)+")");	
        	db.executeQuery(sb.toString()); 
        	
        	if (db.next())
            {  count=db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }
    
    
    public static ArrayList<ProfileLvyou> find(String name,String mobile,int province,int city,int catagory,int sex,String day1,String day2,int state,int jobid,int page,int size) throws SQLException
    {
     	ArrayList<ProfileLvyou> al = new ArrayList<ProfileLvyou>();
        DbAdapter db = new DbAdapter();
        try
        { StringBuffer sb=new StringBuffer();
         sb.append("SELECT	plv.member, plv.province, plv.city, plv.certification, 	" +
             		"plv.years, plv.jobcategory, plv.models, plv.introduction, 	plv.companyname," +
             		"plv.companyperson, plv.companytelephone,plv.companyinfo,plv.headpic,pl.firstname,p.sex,p.birth" +
             		" FROM profilelvyou plv,Profile p,ProfileLayer pl,lvyouapply app" +
             		" WHERE plv.member=p.member and pl.member=p.member and app.member=p.member  and app.jobid="+jobid);
         if(!name.trim().equals(""))
         	sb.append(" and (pl.firstname like '%" +name+"%')");
         if(!mobile.trim().equals(""))
          	sb.append(" and (p.mobile like '%" +mobile+"%')");
         	if(province!=0)
         	sb.append(" and plv.province="+province);
         	if(city!=0)
             sb.append(" and plv.city="+city);
         	if(catagory!=0)
             sb.append(" and plv.jobcategory="+catagory);
         	if(sex!=-1)
             sb.append(" and p.sex="+sex);
         	if(state!=-1)
                sb.append(" and plv.state="+state);
         	if((!day1.trim().equals(""))&&(!day2.trim().equals("")))
         	 sb.append(" and (p.time between "+DbAdapter.cite(day1)+" and "+DbAdapter.cite(day2)+")");	 
         
         db.executeQuery(sb.toString(),page,size);
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
    public static int count(String name,String mobile,int province,int city,int catagory,int sex,String day1,String day2,int state,int jobid) throws SQLException
    {
      int count=0;
        DbAdapter db = new DbAdapter();
        try
        { StringBuffer sb=new StringBuffer();
         sb.append("SELECT	count(plv.member) FROM profilelvyou plv,Profile p,ProfileLayer pl,lvyouapply app" +
             		" WHERE plv.member=p.member and pl.member=p.member and app.member=p.member and app.jobid="+jobid);
         if(!name.trim().equals(""))
         	sb.append(" and (pl.firstname like '%" +name+"%')");
         if(!mobile.trim().equals(""))
          	sb.append(" and (p.mobile like '%" +mobile+"%')");
         	if(province!=0)
         	sb.append(" and plv.province="+province);
         	if(city!=0)
             sb.append(" and plv.city="+city);
         	if(catagory!=0)
             sb.append(" and plv.jobcategory="+catagory);
         	if(sex!=-1)
             sb.append(" and p.sex="+sex);
         	if(state!=-1)
                sb.append(" and plv.state="+state);
         	if((!day1.trim().equals(""))&&(!day2.trim().equals("")))
         	 sb.append(" and (p.time between "+DbAdapter.cite(day1)+" and "+DbAdapter.cite(day2)+")");	 
         
         db.executeQuery(sb.toString());
          if(db.next())
            {
            	 count=db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
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
             		" FROM profilelvyou plv,Profile p,ProfileLayer pl,lvyouapply app " +
             		" WHERE plv.member=p.member and pl.member=p.member and app.member=p.member and app.jobid="+jobid);
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
    
    public static ArrayList<ProfileLvyou> find(int jobid,String orderby,String ordertype,String latitude,String longitude) throws SQLException
    {
     	ArrayList<ProfileLvyou> al = new ArrayList<ProfileLvyou>();
        DbAdapter db = new DbAdapter();
        try
        {   StringBuffer sb=new StringBuffer();
               sb.append("SELECT	plv.member, plv.province, plv.city, plv.certification, 	" +
             		"plv.years, plv.jobcategory, plv.models, plv.introduction, 	plv.companyname," +
             		"plv.companyperson, plv.companytelephone,plv.companyinfo,plv.headpic,pl.firstname,p.sex,p.birth,plv.latitude,plv.longitude" +
             		" FROM profilelvyou plv,Profile p,ProfileLayer pl,lvyouapply app " +
             		" WHERE plv.member=p.member and pl.member=p.member and app.member=p.member   and app.jobid="+jobid);
           
               if(orderby.equals("dist"))
            	   sb.append(" order by  mydistance("+latitude+","+longitude+",plv.latitude,plv.longitude)");
                else  
            	   sb.append(" order by  app.apptime ");
                sb.append(ordertype);
              // System.out.println(sb.toString());
               db.executeQuery(sb.toString());
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
                 profilelvyou.setLongitude(db.getString(i++));
                 profilelvyou.setLatitude(db.getString(i++));
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
        	 db.executeQuery(" SELECT COUNT(member) FROM lvyouapply where  jobid="+jobid);
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
        	 db.executeQuery("SELECT COUNT(jobid) FROM lvyouapply where  member="+DbAdapter.cite(member));
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
	public Date getApptime() {
		return apptime;
	}
	public void setApptime(Date apptime) {
		this.apptime = apptime;
	}
	public void setMember(String member) {
		this.member = member;
	}


	public String getApptimeToString() throws SQLException
    {
       
        if(apptime == null)
        {
            return null;
        } else
        {
            return Entity.sdf.format(apptime);
        }
    }
  

  

}
