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

public class LvyouJob
{
	private int id;
	private String member; 
	private String name; 
	private int province; 
	private int city; 
 	private int jobcatagory; 
    private int pcount;
	private String introduction; 
	private int state;
	private Date issuetime;
	
   
	public LvyouJob()
    {
   
    } 

    public static LvyouJob find(int id) throws SQLException
    {
         
            DbAdapter db = new DbAdapter();
            LvyouJob lvyoujob=new LvyouJob();
            try
            {
                db.executeQuery("SELECT	id,member,name,jobcatagory, province,city, pcount, introduction,state,issuetime  FROM lvyoujob WHERE id=" + id);
                if(db.next())
                {int i=1;
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
                } else
                {
                	 lvyoujob.setId(0);
                     lvyoujob.setMember("");
                     lvyoujob.setName("");
                     lvyoujob.setJobcatagory(0);
                     lvyoujob.setProvince(0);
                     lvyoujob.setCity(0);
                     lvyoujob.setPcount(0);
                     lvyoujob.setIntroduction("");
                     lvyoujob.setState(0);
                }
            } finally
            {
                db.close();
            }
         
       return lvyoujob;
    }
    public static ArrayList<LvyouJob> find(String keyword,int province,int city,int catagory,int days,int page,int size) throws SQLException
    {
    	ArrayList<LvyouJob> al = new ArrayList<LvyouJob>();
        DbAdapter db = new DbAdapter();
        StringBuffer sb=new StringBuffer();
        try
        {
        	sb.append("SELECT	id,member,name,jobcatagory, province,city, pcount, introduction,state ,issuetime FROM lvyoujob WHERE state=1 ");
        	if(!keyword.trim().equals(""))
        	sb.append(" and (name like '%" +keyword+"%' or introduction like  '%" +keyword+"%')");
        	if(province!=0)
        	sb.append(" and province="+province);
        	if(city!=0)
            sb.append(" and city="+city);
        	if(catagory!=0)
            sb.append(" and jobcatagory="+catagory);
        	switch(days)
        	{
        	case 1:   sb.append(" AND TO_DayS(NOW())- TO_DayS(issuetime) <=3");   break;         //三天          
        	case 2:   sb.append(" AND TO_DayS(NOW())- TO_DayS(issuetime) <=7");   break;        // 一周
            case 3:   sb.append(" AND TO_DayS(NOW())- TO_DayS(issuetime) <=30");   break;        //一个月
            case 4:   sb.append(" AND TO_DayS(NOW())- TO_DayS(issuetime) <=91");   break;      //三个月
        	}
        	System.out.println(sb.toString());
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
    
    public static ArrayList<LvyouJob> find(String keyword,int province,int city,int catagory,int days,int state,String orderby,String ordertype,String latitude,String longitude,int page,int size) throws SQLException
    {
    	ArrayList<LvyouJob> al = new ArrayList<LvyouJob>();
        DbAdapter db = new DbAdapter();
        StringBuffer sb=new StringBuffer();
        try
        {
        	sb.append("SELECT	job.id,job.member,job.name,job.jobcatagory, job.province,job.city, job.pcount, job.introduction,job.state ,job.issuetime FROM lvyoujob job, profilelvyou plv  WHERE plv.member=job.member   ");
        	if(!keyword.trim().equals(""))
        	sb.append(" and (job.name like '%" +keyword+"%' or job.introduction like  '%" +keyword+"%')");
        	if(province!=0)
        	sb.append(" and job.province="+province);
        	if(city!=0)
            sb.append(" and job.city="+city);
        	if(catagory!=0)
            sb.append(" and job.jobcatagory="+catagory);
        	if(state!=-1)
                sb.append(" and job.state="+state);
        	switch(days)
        	{
        	case 1:   sb.append(" AND TO_DayS(NOW())- TO_DayS(job.issuetime) <=3");   break;         //三天          
        	case 2:   sb.append(" AND TO_DayS(NOW())- TO_DayS(job.issuetime) <=7");   break;        // 一周
            case 3:   sb.append(" AND TO_DayS(NOW())- TO_DayS(job.issuetime) <=30");   break;        //一个月
            case 4:   sb.append(" AND TO_DayS(NOW())- TO_DayS(job.issuetime) <=91");   break;      //三个月
        	}
        	
          	 if(orderby.equals("dist")&& !latitude.equals("-1")&&!longitude.equals("-1"))
          		 sb.append(" order by  mydistance("+latitude+","+longitude+",plv.latitude,plv.longitude)");
                else  
            	   sb.append(" order by  job.issuetime ");
                sb.append(ordertype);
                
        	System.out.println(sb.toString());
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
    		int catagory,int state,String day1,String day2,int page,int size) throws SQLException
    {
     int count=0;
        DbAdapter db = new DbAdapter();
        StringBuffer sb=new StringBuffer();
        try
        {
        	sb.append("SELECT	count(job.id) " +
        			"FROM lvyoujob job,Profile p,ProfileLayer pl,profilelvyou plv  " +
        			"WHERE p.member=pl.member and job.member=p.member and plv.member=p.member ");
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
    public static ArrayList<LvyouJob> find(String name,String companyname,int province,int city,
    		int catagory,int state,String day1,String day2,int page,int size) throws SQLException
    {
    	ArrayList<LvyouJob> al = new ArrayList<LvyouJob>();
        DbAdapter db = new DbAdapter();
        StringBuffer sb=new StringBuffer();
        try
        {
        	sb.append("SELECT	job.id,job.member,job.name,job.jobcatagory, job.province,job.city, job.pcount, job.introduction,job.state,job.issuetime " +
        			"FROM lvyoujob job,Profile p,ProfileLayer pl,profilelvyou plv  " +
        			"WHERE p.member=pl.member and job.member=p.member and plv.member=p.member    ");
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
    public static ArrayList<LvyouJob> find(String member) throws SQLException
    {
    	ArrayList<LvyouJob> al = new ArrayList<LvyouJob>();
        DbAdapter db = new DbAdapter();
        try
        {
        	  db.executeQuery("SELECT	id,member,name,jobcatagory, province,city, pcount, introduction,state,issuetime  FROM lvyoujob WHERE state=1 and member=" + DbAdapter.cite(member));
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
    public static ArrayList<LvyouJob> find(String member,String ordertype,int state) throws SQLException
    {
    	ArrayList<LvyouJob> al = new ArrayList<LvyouJob>();
        DbAdapter db = new DbAdapter();
        String s="";
        if(state==0) s=" and state=1";
        try
        {
        	  db.executeQuery("SELECT	id,member,name,jobcatagory, province,city, pcount, introduction,state,issuetime " +
        	  		" FROM lvyoujob WHERE member=" + DbAdapter.cite(member)+s+" order by issuetime "+ordertype);

         
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
    
    
    public void set(int id,	String member,String name,	int province,int city,int jobcatagory, int pcount,String introduction,int state) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date today=new Date();
        try
        {
            int j = db.executeUpdate("UPDATE lvyoujob SET member=" + DbAdapter.cite(member) + 
            		                 ",name =" +DbAdapter.cite(name) + 
            		                 ",province=" + province+
            		                 ",city=" + city+
            		                  ",jobcatagory=" + jobcatagory+
            		                 ",pcount=" + pcount+
            		                 ",introduction=" + DbAdapter.cite(introduction)+
            		                  ",state=" + state+
            		                  ",issuetime=" + DbAdapter.cite(today)+
            		                 " WHERE id=" + id);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO lvyoujob (member,name,jobcatagory, province,city, pcount, introduction,state,issuetime )VALUES (" + DbAdapter.cite(member) + "," 
                		+ DbAdapter.cite(name) + ", " + jobcatagory + ", " +province + ", " + city + ","
                        + pcount + " ," + DbAdapter.cite(introduction) + " ," +state+ " ," + DbAdapter.cite(today)+ ")");
            }
        } finally
        {
            db.close();
        }
    
    }
    public static void delete(int id) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("delete from lvyoujob WHERE id=" + id);
           
        } finally
        {
            db.close();
        }
    
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getMember() {
		return member;
	}

	public void setMember(String member) {
		this.member = member;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getProvince() {
		return province;
	}

	public void setProvince(int province) {
		this.province = province;
	}

	public int getCity() {
		return city;
	}

	public void setCity(int city) {
		this.city = city;
	}

	public int getJobcatagory() {
		return jobcatagory;
	}

	public void setJobcatagory(int jobcatagory) {
		this.jobcatagory = jobcatagory;
	}

	public int getPcount() {
		return pcount;
	}

	public void setPcount(int pcount) {
		this.pcount = pcount;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public Date getIssuetime() {
		return issuetime;
	}

	public void setIssuetime(Date issuetime) {
		this.issuetime = issuetime;
	}

	public String getIssueToString() throws SQLException
    {
       
        if(issuetime == null)
        {
            return "";
        } else
        {
            return Entity.sdf.format(issuetime);
        }
    }
    

}
