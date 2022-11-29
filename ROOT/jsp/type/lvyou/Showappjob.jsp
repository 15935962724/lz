<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.lvyou.*"%>
<%@page import="tea.resource.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.member.*"%>
<%
     request.setCharacterEncoding("UTF-8");
     TeaSession teasession = new TeaSession(request);
     String name="";
     ProfileLvyou p =new ProfileLvyou();
     int  jid = 0;
     String member="";
     if(teasession.getParameter("jid")!=null && teasession.getParameter("jid").length()>0)
     {
         jid = Integer.parseInt(teasession.getParameter("jid"));
         
     }
     LvyouJob job=LvyouJob.find(jid);
     LvyouCity pro=LvyouCity.find(job.getProvince());
 	LvyouCity cit=LvyouCity.find(job.getCity());
 	LvyouJobCatagory cat=LvyouJobCatagory.find(job.getJobcatagory());
     if(teasession.getParameter("member")!=null && teasession.getParameter("member").length()>0)
     {
         member = teasession.getParameter("member");
         p=p.find(member);
     }
     
    
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<title>职位信息</title>
</head>
<script>
 </script>
<body id="bodynone">
  
 
  <form action="/jsp/type/lvyou/Company.jsp" name="form1" method="POST">
    <input type="hidden" name="member" value="<%=member%>">
    <input type="hidden" name="jid" value="<%=jid%>">
    <input type="hidden" name="act" value="edit">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
    <td colspan=4><b>公司基本信息</b></td>
   </tr>
    <tr>
   
    <td>公司名称</td><td><%=p.getCompanyname() %></td>
     <td>联系人</td><td><%=p.getCompanyperson() %></td>
   </tr>
   <tr>
   <td>联系电话</td><td colspan="3"><%=p.getCompanytelephone() %></td>
    </tr>
  <tr>
   <td>公司简介</td><td colspan="3"><%=p.getCompanyinfo() %></td>
    </tr>
    <tr>
    <td colspan=4><b>职位信息</b></td>
   </tr>  
     <tr>
     <td>职位类别</td><td><%=cat.getName() %></td>
     <td>工作地点</td><td><%=pro.getName()+cit.getName() %></td>
     </tr>
      <tr>
     <td>职位名称</td><td><%=job.getName() %></td>
     <td>招聘人数</td><td><%=job.getPcount() %></td>
     </tr>
      <tr>
   <td>职位简介</td><td colspan="3"><%=job.getIntroduction() %></td>
    </tr>
      <tr>
    <td colspan="4"> 
    <input type="button" name="name" value="返回"  onClick="window.open('/jsp/type/lvyou/Findappjobs.jsp?member=<%=member %>','_self');">
   </td>
    </tr>
     </table>
  </form>

</body>
</html>