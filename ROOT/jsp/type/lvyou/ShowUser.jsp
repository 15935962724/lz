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
     int jobid=0;
     if(teasession.getParameter("jobid")!=null && teasession.getParameter("jobid").length()>0)
     {
    	 jobid = Integer.parseInt(teasession.getParameter("jobid"));
       
     }
     if(teasession.getParameter("member")!=null && teasession.getParameter("member").length()>0)
     {
         member = teasession.getParameter("member");
      
     }
     
     ProfileLvyou plv=new ProfileLvyou();
    
     plv=plv.find(member);
     Profile profile=Profile.find(member);
     
     LvyouCity pro=LvyouCity.find(plv.getProvince());
  	LvyouCity cit=LvyouCity.find(plv.getCity());
  	LvyouJobCatagory cat=LvyouJobCatagory.find(plv.getJobcategory());
     

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<title>用户信息</title>
</head>

<body id="bodynone">
  
 
  <form action="/jsp/type/lvyou/User.jsp" name="form1" method="POST">
    <input type="hidden" name="member" value="<%=member%>">
    <input type="hidden" name="act" value="edit">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  
    <tr>
    <td>姓名</td><td><%=plv.getName() %></td>
    <td>手机</td><td><%=profile.getMobile() %></td>
   </tr>
   
    <tr>
    <td>性别</td><td><%=plv.getSex()==0?"女":"男" %></td>
    <td>出生年月</td><td><%=plv.getBirthToString() %>
   </td>
   </tr>
   
    <tr>
   
    
     <td>工作地点</td><td>
    <%=pro.getName()+cit.getName() %>
 
</td>
<td>是否有上岗证</td><td> <%=plv.getCertification()==1?"有":"无" %> </td>
  
    
   </tr>
   <tr>
    <td>操作年限</td><td><%=plv.getYears() %></td>
   <td>职位类别</td>
      <td>
 <%=cat.getName() %>
</td>
 </tr>
   <tr>
    <td>机种</td>
    <td>
    <%
    String models=plv.getModels();
	StringTokenizer st = new StringTokenizer(models,"/");
 	while( st.hasMoreElements() ){
 	String sjobid=st.nextToken().trim();
 	if(!sjobid.equals("")){
	 int mid=Integer.parseInt(sjobid);
	 LvyouModels model=LvyouModels.find(mid); 
	 out.print(model.getName()+"&nbsp;&nbsp;");
	}
	}
   
    %>
    </td>
     <td colspan=3 align="center">&nbsp;</td>
   </tr>
  <tr>
   <td>个人简介</td><td colspan="3"><%=plv.getIntroduction() %></td>
    </tr>
   <tr>
    <td colspan=4>
 
  <input type="button" name="name" value="返回"  onClick="window.open('/jsp/type/lvyou/Findappusers.jsp?jobid=<%=jobid %>','_self');">
    
    </td>
   </tr>
   </table>
  </form>

</body>
</html>