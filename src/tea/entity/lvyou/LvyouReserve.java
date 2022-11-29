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

public class LvyouReserve
{
   
    public int id;
    public String reserve;
    public String member;

    public LvyouReserve()
    {
   
    }
    public static void set(String member,String reserve) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int count=0;
        db.executeQuery(" SELECT COUNT(id) FROM lvyoureserve where  reserve="+DbAdapter.cite(reserve)+" and member="+ DbAdapter.cite(member));
       
        if(db.next())
        {
        	  
            count= db.getInt(1);
            
        }
        try
        {
             if(count==0)
            {
                db.executeUpdate("INSERT INTO lvyoureserve (member,reserve)VALUES (" 
                   + DbAdapter.cite(member) + ","  +DbAdapter.cite(reserve)+ ")");
               
            }
        } finally
        {
            db.close();
        }
    
    }
    public static void delete(String member,String reserve) throws SQLException
    {
        DbAdapter db = new DbAdapter();
       
        try
        {
         db.executeUpdate("delete from lvyoureserve where  reserve="+DbAdapter.cite(reserve)+" and member="+ DbAdapter.cite(member));
          } finally
        {
            db.close();
        }
    
    }

    
    public static ArrayList<ProfileLvyou> find(String member) throws SQLException
    {
     	ArrayList<ProfileLvyou> al = new ArrayList<ProfileLvyou>();
        DbAdapter db = new DbAdapter();
        try
        {
        	 db.executeQuery("SELECT	plv.member, plv.province, plv.city, plv.certification, 	" +
             		"plv.years, plv.jobcategory, plv.models, plv.introduction, 	plv.companyname," +
             		"plv.companyperson, plv.companytelephone,plv.companyinfo,plv.headpic,pl.firstname,p.sex,p.birth,plv.latitude,plv.longitude" +
             		" FROM profilelvyou plv,Profile p,ProfileLayer pl,lvyoureserve rev" +
             		" WHERE plv.member=p.member and pl.member=p.member and rev.reserve=p.member   and rev.member="+DbAdapter.cite(member));
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
                 profilelvyou.setLatitude(db.getString(i++));
                 profilelvyou.setLongitude(db.getString(i++));
                 al.add(profilelvyou);
            }
        } finally
        {
            db.close();
        }
        return al;
    }
    
    public static ArrayList<ProfileLvyou> find(String member,String orderby,String ordertype,String latitude,String longitude) throws SQLException
    {
     	ArrayList<ProfileLvyou> al = new ArrayList<ProfileLvyou>();
        DbAdapter db = new DbAdapter();
        try
        {        	StringBuffer sb=new StringBuffer();
            
            sb.append("SELECT	plv.member, plv.province, plv.city, plv.certification, 	" +
             		"plv.years, plv.jobcategory, plv.models, plv.introduction, 	plv.companyname," +
             		"plv.companyperson, plv.companytelephone,plv.companyinfo,plv.headpic,pl.firstname,p.sex,p.birth,plv.latitude,plv.longitude" +
             		" FROM profilelvyou plv,Profile p,ProfileLayer pl,lvyoureserve rev" +
             		" WHERE plv.member=p.member and pl.member=p.member and rev.reserve=p.member   and rev.member="+DbAdapter.cite(member));
           
            if(orderby.equals("dist"))
          	   sb.append(" order by  mydistance("+latitude+","+longitude+",plv.latitude,plv.longitude)");
              else  
          	   sb.append(" order by  rev.id ");
              sb.append(ordertype);
         
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
                 profilelvyou.setLatitude(db.getString(i++));
                 profilelvyou.setLongitude(db.getString(i++));
                 al.add(profilelvyou);
            }
        } finally
        {
            db.close();
        }
        return al;
    }
    
    public static int count(String member) throws SQLException
    {
     int count=0;
        DbAdapter db = new DbAdapter();
        try
        {
        	 db.executeQuery("SELECT COUNT(reserve) FROM lvyoureserve where  member="+DbAdapter.cite(member));
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

	 

	public String getReserve() {
		return reserve;
	}
	public void setReserve(String reserve) {
		this.reserve = reserve;
	}
	public String getMember() {
		return member;
	}

	public void setMember(String member) {
		this.member = member;
	}


  

  

}
