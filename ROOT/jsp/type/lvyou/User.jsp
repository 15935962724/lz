<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.lvyou.*"%>
<%@page import="tea.resource.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.Entity"%>
<%@page import="tea.entity.member.*"%>
<%
     request.setCharacterEncoding("UTF-8");
     TeaSession teasession = new TeaSession(request);
      
     int  jid = 0;
     String member="";
   
     if(teasession.getParameter("member")!=null && teasession.getParameter("member").length()>0)
     {
         member = teasession.getParameter("member");
      
     }
     
     ProfileLvyou plv=new ProfileLvyou();
    
     plv=plv.find(member);
     Profile profile=Profile.find(member);
     ArrayList<LvyouCity> provinces = LvyouCity.find1();
     ArrayList<LvyouJobCatagory> cats = LvyouJobCatagory.find();
     ArrayList<LvyouModels> models= LvyouModels.find();
     if("POST".equals(request.getMethod()))
     { 
    	 if(teasession.getParameter("act").equals("edit")){
    		 String name=teasession.getParameter("name");
    		String sex=teasession.getParameter("sex");
    		 String mobile=teasession.getParameter("mobile");
    		 String birth=teasession.getParameter("birth");
    		 
				profile.setFirstName(name, 1);
				profile.setSex(sex.trim().equals("1"));
				profile.setMobile(mobile);
				Date today =new Date();
				profile.setTime(today);
				if (!birth.equals(""))
				profile.setBirth(Entity.sdf.parse(birth));
    	
        int province=Integer.parseInt(teasession.getParameter("province"));
        int city=Integer.parseInt(teasession.getParameter("city"));
        int jobcatagory=Integer.parseInt(teasession.getParameter("jobcatagory"));
        int state=Integer.parseInt(teasession.getParameter("state"));
    	String introduction=teasession.getParameter("introduction");
    	int certification=Integer.parseInt(teasession.getParameter("certification"));
    	String years=teasession.getParameter("years");
    	String mods="/";
    			String ms[]= teasession.getParameterValues("models");
  	  for(int j=0;j<ms.length;j++)
  	     {
  	    	 mods=mods+ms[j]+"/";
  	     }
    	plv.set(member, province, city, certification, years, jobcatagory, mods, introduction, state);
    	response.sendRedirect("/jsp/type/lvyou/Apps.jsp?jid="+jid+"&member="+member);
    	 }
    
     }

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<title>用户信息</title>
</head>
<script>
function getcities(id){  //保留两位小数点  
	   var url = "/jsp/type/lvyou/getcities.jsp?id="+id; 
//alert(url);
	    if (window.XMLHttpRequest){ 
	      req = new XMLHttpRequest(); 
	     }else if (window.ActiveXObject) 
	     { 
	      req = new ActiveXObject("Microsoft.XMLHTTP"); 
	     } 
	     if(req) 
	     { 
	      req.open("GET",url, true); 
	      req.onreadystatechange = complete;
	      req.send(null); 
	     } 
	    }  
	   function complete(){ 
	     if (req.readyState == 4) 
	     { 
	      if (req.status == 200){ 
	   	   var content = req.responseText; 
	  // 	  alert(content);
	   document.getElementById('span_city').innerHTML=content;
	   	  
	      } 
	     } 
	   } 
	   function CheckAll()
	   {
	   	var checkname=document.getElementsByName("checkall");
	   	var fname=document.getElementsByName("jid");
	   	var lname="";
	   	if(checkname[0].checked){
	   	    for(var i=0; i<fname.length; i++){
	   	      fname[i].checked=true;
	   	  }
	   	}else{
	   	   for(var i=0; i<fname.length; i++){
	   	      fname[i].checked=false;
	   	   }
	   	}


	  
	   }
 </script>
<body id="bodynone">
  
 
  <form action="/jsp/type/lvyou/User.jsp" name="form1" method="POST">
    <input type="hidden" name="member" value="<%=member%>">
    <input type="hidden" name="act" value="edit">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    
   
     <tr>
    <td colspan=4 align="center">
    <input type="radio" name="state" value="1" <%=plv.getState()==1?"checked":"" %>> 发布&nbsp;
    <input type="radio" name="state" value="0" <%=plv.getState()==0?"checked":"" %>> 暂不发布 </td>
   </tr>
    <tr>
    <td>姓名</td><td><input type="text" name="name" value="<%=plv.getName() %>"></td>
    <td>手机</td><td><input type="text" name="mobile" value="<%=profile.getMobile() %>"></td>
   </tr>
   
    <tr>
    <td>性别</td><td><select name="sex">
    <option value="-1">------------</option>
    <option value="0" <%if(plv.getSex()==0) out.print(" selected"); %>>男</option>
    <option value="1" <%if(plv.getSex()==1) out.print(" selected"); %>>女</option>
    </select></td>
    <td>出生年月</td><td> <input type="text" name="birth" value="<%=plv.getBirthToString() %>" size=10 style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.birth');">
   </td>
   </tr>
   
    <tr>
   
    
     <td>工作地点</td><td>
    <select name="province" onchange="getcities(this.value)" style="width:150px;">
    <option value="0">------------</option>
    <%
    for (int i = 0; i < provinces.size(); i++) {
		LvyouCity prov = (LvyouCity) provinces.get(i);
		out.print("<option value='"+prov.getId()+"'");
		   if(prov.getId()==plv.getProvince()) out.print(" selected"); 
		out.print(">"+ prov.getName() + "</option>");
	}
    %>
	</select>-
	<span id="span_city">
	 <select name="city" style="width:150px;">
     <option value="0">------------</option>
     <% 
     ArrayList<LvyouCity> citis = LvyouCity.find2(plv.getProvince());
     for (int i = 0; i < citis.size(); i++) {
 		LvyouCity cit = (LvyouCity) citis.get(i);
 		out.print("<option value='"+cit.getId()+"'");
		   if(cit.getId()==plv.getCity()) out.print(" selected"); 
		out.print(">"+ cit.getName() + "</option>");
 	}
     %>
     </select>
	</span>
</td>
<td>是否有上岗证</td><td><select name="certification">
    <option value="-1">------------</option>
    <option value="1" <%if(plv.getCertification()==1) out.print(" selected"); %>>有</option>
    <option value="0" <%if(plv.getCertification()==0) out.print(" selected"); %>>无</option>
    </select></td>
  
    
   </tr>
   <tr>
    <td>操作年限</td><td><input type="text" name="years" value="<%=plv.getYears() %>"></td>
   <td>职位类别</td>
      <td>
 <select name="jobcatagory" >
    <option value="0">------------</option>
    <%
    int catagory=plv.getJobcategory();
    for (int i = 0; i < cats.size(); i++) {
    	LvyouJobCatagory cat = (LvyouJobCatagory) cats.get(i);
    	
		out.print("<option value='"+cat.getId()+"'");
	    if(cat.getId()==catagory) out.print(" selected") ;
		out.print(">"+ cat.getName() + "</option>");
	} 
	%>
	</select>
</td>
 </tr>
   <tr>
    <td>机种</td>
    <td colspan=3 align="center">
    <%
    for (int i = 0; i < models.size(); i++) {
		LvyouModels model = (LvyouModels) models.get(i);
		out.print("<input name='models' type='checkbox' value='"+model.getId()+"'");
		   if(("/"+plv.getModels()+"/").contains("/"+String.valueOf(model.getId())+"/")) out.print(" checked"); 
		out.print(" />"+  model.getName()+"&nbsp;");
	}
    %>
   </tr>
  <tr>
   <td>个人简介</td><td colspan="3"><textarea name="introduction" cols="50" rows="5"><%=plv.getIntroduction() %></textarea></td>
    </tr>
   <tr>
    <td colspan=4>
    <input type="submit" name="name" value="确认">
    <input type="button" name="name" value="返回"  onClick="window.open('/jsp/type/lvyou/Jobs.jsp','_self');">
    
    </td>
   </tr>
   </table>
  </form>

</body>
</html>