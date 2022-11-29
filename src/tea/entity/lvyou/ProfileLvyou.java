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

public class ProfileLvyou
{
   
	private String member; 
	private int province; 
	private int city; 
	private int certification; 
	private String years; 
	private int jobcategory; 
	private String models; 
	
	private String introduction; 
	private String companyname; 
	private String companyperson; 
	private String companytelephone; 
	private String companyinfo;
    private String headpic;
	
    private String name;
    private Date birth;
    private int sex;
    private int state;
   
    
	private String latitude;
	private String longitude;
	
	public ProfileLvyou()
    {
   
    }
    public static ArrayList<ProfileLvyou> find(String keyword,int province,int city,int catagory,int sex,String day1,String day2,String models,int page,int size) throws SQLException
    {
     	ArrayList<ProfileLvyou> al = new ArrayList<ProfileLvyou>();
        DbAdapter db = new DbAdapter();
        try
        { StringBuffer sb=new StringBuffer();
         sb.append("SELECT	plv.member, plv.province, plv.city, plv.certification, 	" +
             		"plv.years, plv.jobcategory, plv.models, plv.introduction, 	plv.companyname," +
             		"plv.companyperson, plv.companytelephone,plv.companyinfo,plv.headpic,pl.firstname,p.sex,p.birth,plv.longitude,plv.latitude" +
             		" FROM profilelvyou plv,Profile p,ProfileLayer pl" +
             		" WHERE plv.member=p.member and pl.member=p.member  ");
         if(!keyword.trim().equals(""))
         	sb.append(" and (pl.firstname like '%" +keyword+"%' or plv.introduction like  '%" +keyword+"%')");
         	if(province!=0)
         	sb.append(" and plv.province="+province);
         	if(city!=0)
             sb.append(" and plv.city="+city);
         	if(catagory!=0)
             sb.append(" and plv.jobcategory="+catagory);
         	if(sex!=-1)
             sb.append(" and p.sex="+sex);
         	if((!day1.trim().equals(""))&&(!day2.trim().equals("")))
         	 sb.append(" and (p.time between "+DbAdapter.cite(day1)+" and "+DbAdapter.cite(day2)+")");	 
         	StringTokenizer st = new StringTokenizer(models,"/");
         	int first=0;
			 	while( st.hasMoreElements() ){
			 	String model=st.nextToken().trim();
			 	if(!model.equals("")){
			       if(first==0)
			       { first=1;
			        sb.append(" and (plv.models like '%/"+model+"/%'");
			        }
			       else
			       { sb.append("  or plv.models like '%/"+model+"/%'");}
				}
				}
			 if(first==1) sb.append(")");
          
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
    public static ArrayList<ProfileLvyou> find(String keyword,int province,int city,int catagory,int sex,String day1,String day2,String models,int state,String orderby,String ordertype,String latitude,String longitude,int page,int size) throws SQLException
    {
     	ArrayList<ProfileLvyou> al = new ArrayList<ProfileLvyou>();
        DbAdapter db = new DbAdapter();
        try
        { StringBuffer sb=new StringBuffer();
         sb.append("SELECT	plv.member, plv.province, plv.city, plv.certification, 	" +
             		"plv.years, plv.jobcategory, plv.models, plv.introduction, 	plv.companyname," +
             		"plv.companyperson, plv.companytelephone,plv.companyinfo,plv.headpic,pl.firstname,p.sex,p.birth,plv.longitude,plv.latitude" +
             		" FROM profilelvyou plv,Profile p,ProfileLayer pl" +
             		" WHERE plv.member=p.member and pl.member=p.member     ");
         if(!keyword.trim().equals(""))
         	sb.append(" and (pl.firstname like '%" +keyword+"%' or plv.introduction like  '%" +keyword+"%')");
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
         	StringTokenizer st = new StringTokenizer(models,"/");
         	int first=0;
			 	while( st.hasMoreElements() ){
			 	String model=st.nextToken().trim();
			 	if(!model.equals("")){
			       if(first==0)
			       { first=1;
			        sb.append(" and (plv.models like '%/"+model+"/%'");
			        }
			       else
			       { sb.append("  or plv.models like '%/"+model+"/%'");}
				}
				}
			 if(first==1) sb.append(")");
          
			 if(orderby.equals("dist")&& !latitude.equals("-1")&&!longitude.equals("-1"))
          		 sb.append(" order by  mydistance("+latitude+","+longitude+",plv.latitude,plv.longitude)");
                else  
            	   sb.append(" order by  p.time ");
                sb.append(ordertype);
                System.out.print(sb.toString());
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
    public static ArrayList<ProfileLvyou> find(String keyword,int province,int city,int catagory,int sex,int days,String models,int state,String orderby,String ordertype,String latitude,String longitude,int page,int size) throws SQLException
    {
     	ArrayList<ProfileLvyou> al = new ArrayList<ProfileLvyou>();
        DbAdapter db = new DbAdapter();
        try
        { StringBuffer sb=new StringBuffer();
         sb.append("SELECT	plv.member, plv.province, plv.city, plv.certification, 	" +
             		"plv.years, plv.jobcategory, plv.models, plv.introduction, 	plv.companyname," +
             		"plv.companyperson, plv.companytelephone,plv.companyinfo,plv.headpic,pl.firstname,p.sex,p.birth,plv.longitude,plv.latitude" +
             		" FROM profilelvyou plv,Profile p,ProfileLayer pl" +
             		" WHERE plv.member=p.member and pl.member=p.member     ");
         if(!keyword.trim().equals(""))
         	sb.append(" and (pl.firstname like '%" +keyword+"%' or plv.introduction like  '%" +keyword+"%')");
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
        	/*
         	if((!day1.trim().equals(""))&&(!day2.trim().equals("")))
         	 sb.append(" and (p.time between "+DbAdapter.cite(day1)+" and "+DbAdapter.cite(day2)+")");	 
         	*/
         	switch(days)
        	{
        	case 1:   sb.append(" AND TO_DayS(NOW())- TO_DayS(p.time) <=3");   break;         //三天          
        	case 2:   sb.append(" AND TO_DayS(NOW())- TO_DayS(p.time) <=7");   break;        // 一周
            case 3:   sb.append(" AND TO_DayS(NOW())- TO_DayS(p.timee) <=30");   break;        //一个月
            case 4:   sb.append(" AND TO_DayS(NOW())- TO_DayS(p.time) <=91");   break;      //三个月
        	}
         	
         	StringTokenizer st = new StringTokenizer(models,"/");
         	int first=0;
			 	while( st.hasMoreElements() ){
			 	String model=st.nextToken().trim();
			 	if(!model.equals("")){
			       if(first==0)
			       { first=1;
			        sb.append(" and (plv.models like '%/"+model+"/%'");
			        }
			       else
			       { sb.append("  or plv.models like '%/"+model+"/%'");}
				}
				}
			 if(first==1) sb.append(")");
          
			 if(orderby.equals("dist")&& !latitude.equals("-1")&&!longitude.equals("-1"))
          		 sb.append(" order by  mydistance("+latitude+","+longitude+",plv.latitude,plv.longitude)");
                else  
            	   sb.append(" order by  p.time ");
                sb.append(ordertype);
                System.out.print(sb.toString());
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
    public static ArrayList<ProfileLvyou> find(String name,String mobile,int province,int city,int catagory,int sex,String day1,String day2,int state,int page,int size) throws SQLException
    {
     	ArrayList<ProfileLvyou> al = new ArrayList<ProfileLvyou>();
        DbAdapter db = new DbAdapter();
        try
        { StringBuffer sb=new StringBuffer();
         sb.append("SELECT	plv.member, plv.province, plv.city, plv.certification, 	" +
             		"plv.years, plv.jobcategory, plv.models, plv.introduction, 	plv.companyname," +
             		"plv.companyperson, plv.companytelephone,plv.companyinfo,plv.headpic,pl.firstname,p.sex,p.birth,plv.longitude,plv.latitude" +
             		" FROM profilelvyou plv,Profile p,ProfileLayer pl" +
             		" WHERE plv.member=p.member and pl.member=p.member   ");
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
    
    public static int count(String name,String mobile,int province,int city,int catagory,int sex,String day1,String day2,int state) throws SQLException
    {
     int count=0;
        DbAdapter db = new DbAdapter();
        
        try
        { StringBuffer sb=new StringBuffer();
         sb.append("SELECT	 count(plv.member) FROM profilelvyou plv,Profile p,ProfileLayer pl" +
             		" WHERE plv.member=p.member and pl.member=p.member   ");
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
    
    public  static ProfileLvyou find(String member) throws SQLException
    {
         
            DbAdapter db = new DbAdapter();
            ProfileLvyou profilelvyou=new ProfileLvyou();
            try
            {
                db.executeQuery("SELECT	plv.member, plv.province, plv.city, plv.certification, 	" +
                		"plv.years, plv.jobcategory, plv.models, plv.introduction, 	plv.companyname," +
                		"plv.companyperson, plv.companytelephone,plv.companyinfo,plv.headpic,pl.firstname,p.sex,p.birth,plv.state,plv.longitude,plv.latitude" +
                		" FROM profilelvyou plv,Profile p,ProfileLayer pl " +
                		" WHERE plv.member=p.member and pl.member=p.member and p.member=" + DbAdapter.cite(member));
                if(db.next())
                {int i=1;
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
                  profilelvyou.setState(db.getInt(i++));
                  profilelvyou.setLongitude(db.getString(i++));
                  profilelvyou.setLatitude(db.getString(i++));
                } 
            } finally
            {
                db.close();
            }
         
       return profilelvyou;
    }
    public ProfileLvyou finduser(String member) throws SQLException
    {
         
            DbAdapter db = new DbAdapter();
            ProfileLvyou profilelvyou=new ProfileLvyou();
            try
            {
                db.executeQuery("SELECT	member, province, city, certification, 	" +
                		"years, jobcategory, models, introduction,headpic,state ,longitude,latitude" +
                		"  FROM profilelvyou WHERE member=" + DbAdapter.cite(member));
                if(db.next())
                {int i=1;
                  profilelvyou.setMember(db.getString(i++));
                  profilelvyou.setProvince(db.getInt(i++));
                  profilelvyou.setCity(db.getInt(i++));
                  profilelvyou.setCertification(db.getInt(i++));
                  profilelvyou.setYears(db.getString(i++));
                  profilelvyou.setJobcategory(db.getInt(i++));
                  profilelvyou.setModels(db.getString(i++));
                  profilelvyou.setIntroduction(db.getString(i++));
                  profilelvyou.setHeadpic(db.getString(i++));
                  profilelvyou.setState(db.getInt(i++));
                  profilelvyou.setLongitude(db.getString(i++));
                  profilelvyou.setLatitude(db.getString(i++));
                }
            } finally
            {
                db.close();
            }
         
       return profilelvyou;
    }
    public ProfileLvyou findcompany(String member) throws SQLException
    {
         
            DbAdapter db = new DbAdapter();
            ProfileLvyou profilelvyou=new ProfileLvyou();
            try
            {
                db.executeQuery("SELECT	member,companyname," +
                		"companyperson, companytelephone,companyinfo,longitude,latitude FROM profilelvyou WHERE member=" + DbAdapter.cite(member));
                if(db.next())
                {int i=1;
                  profilelvyou.setMember(db.getString(i++));
                 
                  profilelvyou.setCompanyname(db.getString(i++));
                  profilelvyou.setCompanyperson(db.getString(i++));
                  profilelvyou.setCompanytelephone(db.getString(i++));
                  profilelvyou.setCompanyinfo(db.getString(i++));
                  profilelvyou.setLongitude(db.getString(i++));
                  profilelvyou.setLatitude(db.getString(i++));
                } else
                {
                	  profilelvyou.setMember("");
                      profilelvyou.setCompanyname("");
                      profilelvyou.setCompanyperson("");
                      profilelvyou.setCompanytelephone("");
                      profilelvyou.setCompanyinfo("");
                }
            } finally
            {
                db.close();
            }
         
       return profilelvyou;
    }
    public static void delete(String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from profilelvyou WHERE member=" + DbAdapter.cite(member));
            db.executeUpdate("delete from lvyoujob WHERE member=" + DbAdapter.cite(member));
            db.executeUpdate("delete from lvyouapply WHERE member=" + DbAdapter.cite(member));
            db.executeUpdate("delete from lvyoufavorite WHERE member=" + DbAdapter.cite(member));
            db.executeUpdate("delete from lvyoureserve WHERE member=" + DbAdapter.cite(member) +" or reserve=" + DbAdapter.cite(member));
           
        } finally
        {
            db.close();
        }
    
    }

    
    public void set(String member, int province,int city,int certification,String years, int jobcategory, String models, String introduction,int state) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE profilelvyou SET province=" + province + 
            		                 ",city =" +city + 
            		                 ",certification=" + certification+
            		                 ",jobcategory=" + jobcategory+
            		                 ",state=" + state+
            		                 ",models=" + DbAdapter.cite(models)+
            		                 ",years=" + DbAdapter.cite(years)+
            		                 ",introduction=" + DbAdapter.cite(introduction)+
            		                 " WHERE member=" + DbAdapter.cite(member));
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO profilelvyou (member, province, city, certification," +
                		"years, jobcategory, models, introduction,state)VALUES (" + DbAdapter.cite(member) + "," 
                		+ province + ", " + city + ", " +certification + ", " + DbAdapter.cite(years) + ","
                        + jobcategory + " ,"+ DbAdapter.cite(models) + " ," + DbAdapter.cite(introduction) + ", " + state+ ")");
            }
        } finally
        {
            db.close();
        }
    
    }
    public static void set(String member,  String headpic) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
        db.executeUpdate("UPDATE profilelvyou SET  headpic=" + DbAdapter.cite(headpic)+
            		                 " WHERE member=" + DbAdapter.cite(member));
             
        } finally
        {
            db.close();
        }
    
    }
    public static void set(String member,  String longitude,String latitude) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
        db.executeUpdate("UPDATE profilelvyou SET  longitude=" + DbAdapter.cite(longitude)+
        		                     ",latitude="+ DbAdapter.cite(latitude)+
            		                 " WHERE member=" + DbAdapter.cite(member));
             
        } finally
        {
            db.close();
        }
    
    }
    public void set(String member,String companyname,String companyperson,String companytelephone,String companyinfo) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE profilelvyou SET companyname=" + DbAdapter.cite(companyname)+
            		                 ",companyperson=" + DbAdapter.cite(companyperson)+
            		                 ",companytelephone=" + DbAdapter.cite(companytelephone)+
            		                 ",companyinfo=" + DbAdapter.cite(companyinfo)+
            		                 " WHERE member=" + DbAdapter.cite(member));
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO profilelvyou (member,companyname,companyperson, companytelephone,companyinfo)VALUES (" 
                 + DbAdapter.cite(member) + "," + DbAdapter.cite(companyname) + ","+ DbAdapter.cite(companyperson) 
                 + "," + DbAdapter.cite(companytelephone) + ","+ DbAdapter.cite(companyinfo)+ ")");
            }
        } finally
        {
            db.close();
        }
    
    }
    
	public String getMember() {
		return member;
	}

	
	

	public void setMember(String member) {
		this.member = member;
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


	public int getCertification() {
		return certification;
	}


	public void setCertification(int certification) {
		this.certification = certification;
	}


	public String getYears() {
		return years;
	}


	public void setYears(String years) {
		this.years = years;
	}


	public int getJobcategory() {
		return jobcategory;
	}


	public void setJobcategory(int jobcategory) {
		this.jobcategory = jobcategory;
	}


	public String getModels() {
		return models;
	}


	public void setModels(String models) {
		this.models = models;
	}


	public String getIntroduction() {
		return introduction;
	}


	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}


	public String getCompanyname() {
		return companyname;
	}


	public void setCompanyname(String companyname) {
		this.companyname = companyname;
	}


	public String getCompanyperson() {
		return companyperson;
	}


	public void setCompanyperson(String companyperson) {
		this.companyperson = companyperson;
	}


	public String getCompanytelephone() {
		return companytelephone;
	}


	public void setCompanytelephone(String companytelephone) {
		this.companytelephone = companytelephone;
	}


	public String getCompanyinfo() {
		return companyinfo;
	}


	public void setCompanyinfo(String companyinfo) {
		this.companyinfo = companyinfo;
	}

  
	 public String getHeadpic() {
			return headpic;
		}

		public void setHeadpic(String headpic) {
			this.headpic = headpic;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public Date getBirth() {
			return birth;
		}
		
		public String getBirthToString() throws SQLException
	    {
	       
	        if(birth == null)
	        {
	            return null;
	        } else
	        {
	            return Entity.sdf.format(birth);
	        }
	    }

		public void setBirth(Date birth) {
			this.birth = birth;
		}

		public int getSex() {
			return sex;
		}

		public void setSex(int sex) {
			this.sex = sex;
		}
		public int getState() {
			return state;
		}
		public void setState(int state) {
			this.state = state;
		}
		public String getLatitude() {
			return latitude;
		}
		public void setLatitude(String latitude) {
			this.latitude = latitude;
		}
		public String getLongitude() {
			return longitude;
		}
		public void setLongitude(String longitude) {
			this.longitude = longitude;
		}

  

}
