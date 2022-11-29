<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.admin.orthonline.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Date"%>
<%@page import ="java.sql.SQLException" %>
<%@page import="java.math.BigDecimal"%>
<%@page import="tea.entity.admin.mov.*" %>


<%



TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}
 
 Resource r = new Resource("tea/htmlx/HtmlX");
DbAdapter db=new DbAdapter(3);

try
{
 // db.executeQuery(" select email,name,password,gender,age,city,country,industry,job,information,createdate,newsletter,abstracts from WO_USERINFO ");
  db.executeQuery(" select email,name,password,gender,age,city,country,industry,job,information,createdate,newsletter,abstracts from WO_USERINFO WHERE email is not null ");
  int i =1;
  while(db.next())
  {  
	 
	 		String email = db.getString(1);//用户名
	 		String name = db.getString(2);//姓名
	 		String password = db.getString(3);//密码
	 		int gender = db.getInt(4);//性别 男 0，女 1
	 		String age = db.getString(5);//年龄 String 存储
	 		String city=db.getString(6); //城市
	 		
	 		String country_s=db.getString(7); //国家 直接 存 国家名称
	 		
	 		String industry_s=db.getString(8); //行业 直接存 工作英文
	 		
	 		String job_s=db.getString(9); //工作 直接存 工作英文

	 		String information = db.getString(10); //订阅信息 直接用“，”分开

	 		Date createdate = db.getDate(11); //创建日期
	 		int newsletter = db.getInt(12); //是否订阅电子报  1 yes ，0 no
	 		int abstracts = db.getInt(13); //订阅学术论文摘要 1 yes ，0 no
	 		
	 		
	 		 
	 		
	 		//性别
	 		int sex = 1;//男
	 		if(gender==0)
	 		{
	 			sex = 1;
	 		}else if(gender==1){
	 			sex = 0;
	 		}
	 		
	 		boolean b = true;
         	if(sex==1)
         	{
         		b= false;
         	}
         	//年龄
         	int ageid = 0;
         	if(age!=null && age.length()>0){
	         	if("under20".equals(age))
	         	{
	         		ageid =1;
	         	}else if("21-25".equals(age))
	         	{
	         		ageid =2;
	         	}else if("26-30".equals(age))
	         	{
	         		ageid =3;
	         	}else if("31-40".equals(age))
	         	{
	         		ageid =4;
	         	}else if("41-50".equals(age))
	         	{
	         		ageid =5;
	         	}else if("radiobutton".equals(age))
	         	{
	         		ageid =6;
	         	}
	         	else if("51-60".equals(age))
	         	{
	         		ageid =7;
	         	}
         	}
         	
         	
         	//国家
         	String country = "CN";
         	for (int loop = 0; loop < tea.htmlx.CountrySelection.COUNTRY_TYPE.length; loop++)
			{
				String s = r.getString(0,"Country." + tea.htmlx.CountrySelection.COUNTRY_TYPE[loop]);
				if(s.equals(country_s))
				{
					country = tea.htmlx.CountrySelection.COUNTRY_TYPE[loop];
				}
			}
         	
         	
         	//
	 		// 行业
	 		int  industry = 0;
         	if(industry_s!=null && industry_s.length()>0)
         	{
         		  for(int is=0;is<Profile.INDUSTRY.length;is++)
                  {
         			 if(Profile.INDUSTRY[is].equals(industry_s))
         			 {
         				industry = is;
         			 }
                  }
         	}
         	
         	//工作
         	int job = 0;
         	if(job_s!=null && job_s.length()>0){
         		
	         	 for(int ij=0;ij<Profile.JOB.length;ij++)
	             {
	                 if(Profile.JOB[ij].equals(job_s)){
	                	 job = ij;
	                 }
	             }
         	}
         	//if(information!=null && information.length()>0)
         	 // System.out.println("i:"+i+"--"+information);
         	//订阅栏目
         	
         	
         	
         	 StringBuffer sp = new StringBuffer("/");
         	
         	
         	if(information!=null && information.length()>0){
         		information = ","+information+",";
         		//System.out.println("i:"+i+"--"+information);
         	
         			
         		 //System.out.println("i:"+i+"--"+information);
                  
                  for(int iss =1;iss<information.split(",").length;iss++)
                  {
                	  String infs = information.split(",")[iss];//一级目录
                	
                	   
                	
                	  if(infs.indexOf("-")==-1 )//说明只有一级菜单
                	  {
                		  java.util.Enumeration e = WomenOptions.find(teasession._strCommunity, " and type= 0 ", 0, Integer.MAX_VALUE);
                          
                          while (e.hasMoreElements()) {
                              int wid = ((Integer) e.nextElement()).intValue();
                              WomenOptions obj = WomenOptions.find(wid);
                              
                              if( infs.equals(obj.getWoname())){
                		 		 sp.append(String.valueOf(wid)).append("/");
                              } 
                          }
                	  }else if(infs.indexOf("-")!=-1){//二级菜单
                		  
                		  String ej = infs.substring(infs.lastIndexOf("-"),infs.length());
                		  java.util.Enumeration e2 = WomenOptions.find(teasession._strCommunity, " and type= 1 ", 0, Integer.MAX_VALUE);
                          
                          while (e2.hasMoreElements()) {
                              int wid2 = ((Integer) e2.nextElement()).intValue();
                              WomenOptions obj2= WomenOptions.find(wid2);
                              
                              if(ej.equals(obj2.getWoname())){
                            	  sp.append(String.valueOf(wid2)).append("/");
                              }
                              
                          }
                	  }
                	  
                  }
         		 
             }
         
         	
         	//System.out.println(sp.toString());
         	
         	MemberOrder.create(2, 0,  email, teasession._strCommunity, 3, 0, 0);
         	
         	MemberOrder mobj = MemberOrder.find(MemberOrder.getMemberOrder(teasession._strCommunity, 2, email));
         	
            mobj.setNewsletter(newsletter);
            
            mobj.setAbstracts(abstracts);
            mobj.setTime(createdate);
            
            Profile pobj = Profile.find(email);
            //添加
            if(!pobj.isExisted(email))
            {
                Profile.create(email,teasession._strCommunity, password, null,b,null,0,name,email,1,null);
            }
             
            pobj.setSex(b);
            pobj.setAgent(ageid);
            pobj.setCity(city,1);
            pobj.setCountry(country, 1);
            
            pobj.setIndustry(industry);
            pobj.setJob(job);
            
            pobj.setEmail(email);
            pobj.setWoid(sp.toString()); 
            pobj.setTime(createdate);
             
         	System.out.println ("i:"+i+"--"+email);
         	

	 		i++;
  }
}finally
{
  db.close();
}

%>

