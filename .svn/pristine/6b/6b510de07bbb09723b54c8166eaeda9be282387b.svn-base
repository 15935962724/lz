<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.lvyou.*"%>
<%@page import="tea.resource.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.member.*"%>
<%response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); 
response.flushBuffer();%> 

<%
     request.setCharacterEncoding("UTF-8");
     TeaSession teasession = new TeaSession(request);
      
     int  jid = 0;
     String member="";
     if(teasession.getParameter("jid")!=null && teasession.getParameter("jid").length()>0)
     {
         jid = Integer.parseInt(teasession.getParameter("jid"));
         
    
     }
     if(teasession.getParameter("member")!=null && teasession.getParameter("member").length()>0)
     {
         member = teasession.getParameter("member");
      
     }
     
     LvyouJob job=LvyouJob.find(jid);
     ArrayList<LvyouCity> provinces = LvyouCity.find1();
     ArrayList<LvyouJobCatagory> cats = LvyouJobCatagory.find();
     
     if("POST".equals(request.getMethod()))
     {
    	 int id=Integer.parseInt(teasession.getParameter("jid"));
    	String name=teasession.getParameter("name");
        int province=Integer.parseInt(teasession.getParameter("province"));
        int city=Integer.parseInt(teasession.getParameter("city"));
        int jobcatagory=Integer.parseInt(teasession.getParameter("jobcatagory"));
        int pcount=Integer.parseInt(teasession.getParameter("pcount")); 
        int state=Integer.parseInt(teasession.getParameter("state"));
    	String introduction=teasession.getParameter("introduction");
    	job.set(id, member, name, province, city, jobcatagory, pcount, introduction, state);
    	response.sendRedirect("/jsp/type/lvyou/JobDetails.jsp?jid="+jid+"&member="+member);
     }

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<title>招聘信息管理</title>
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
  
 
  <form action="/jsp/type/lvyou/EditJob.jsp" name="form1" method="POST">
    <input type="hidden" name="member" value="<%=member%>">
    <input type="hidden" name="jid" value="<%=jid%>">
    <input type="hidden" name="act">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
    <td colspan=4>
    <input type="button" name="name" value="公司基本信息"  onClick="window.open('/jsp/type/lvyou/Company.jsp?jid=<%=jid%>&member=<%=member%>','_self');">
<input type="button" name="name" value="职位列表"  onClick="window.open('/jsp/type/lvyou/JobDetails.jsp?jid=<%=jid%>&member=<%=member%>','_self');">
</td>
   </tr>
   
     <tr>
    <td colspan=4 align="center">
    <input type="radio" name="state" value="1" <%=job.getState()==1?"checked":"" %>> 发布&nbsp;
    <input type="radio" name="state" value="0" <%=job.getState()==0?"checked":"" %>> 暂不发布 </td>
   </tr>
   
   
    <tr>
   
    <td>职位类别</td><td>
 <select name="jobcatagory" >
    <option value="0">------------</option>
    <%
    int catagory=job.getJobcatagory();
    for (int i = 0; i < cats.size(); i++) {
    	LvyouJobCatagory cat = (LvyouJobCatagory) cats.get(i);
    	
		out.print("<option value='"+cat.getId()+"'");
	    if(cat.getId()==catagory) out.print(" selected") ;
		out.print(">"+ cat.getName() + "</option>");
	} 
	%>
	</select>
</td>
     <td>工作地点</td><td>
    <select name="province" onchange="getcities(this.value)" style="width:150px;">
    <option value="0">------------</option>
    <%
    for (int i = 0; i < provinces.size(); i++) {
		LvyouCity prov = (LvyouCity) provinces.get(i);
		out.print("<option value='"+prov.getId()+"'");
		   if(prov.getId()==job.getProvince()) out.print(" selected"); 
		out.print(">"+ prov.getName() + "</option>");
	}
    %>
	</select>-
	<span id="span_city">
	 <select name="city" style="width:150px;">
     <option value="0">------------</option>
     <% 
     ArrayList<LvyouCity> citis = LvyouCity.find2(job.getProvince());
     for (int i = 0; i < citis.size(); i++) {
 		LvyouCity cit = (LvyouCity) citis.get(i);
 		out.print("<option value='"+cit.getId()+"'");
		   if(cit.getId()==job.getCity()) out.print(" selected"); 
		out.print(">"+ cit.getName() + "</option>");
 	}
     %>
     </select>
	</span>
</td>
   </tr>
     <tr>
    <td>职位名称</td><td><input type="text" name="name" value="<%=job.getName() %>"></td>
    <td>招聘人数</td><td><input type="text" name="pcount" value="<%=job.getPcount() %>"></td>
   </tr>
  <tr>
   <td>职位要求</td><td colspan="3"><textarea name="introduction" cols="50" rows="5"><%=job.getIntroduction() %></textarea></td>
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