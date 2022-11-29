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
     if(teasession.getParameter("member")!=null && teasession.getParameter("member").length()>0)
     {
         member = teasession.getParameter("member");
         p=p.find(member);
     }
     
     if("POST".equals(request.getMethod()))
     {
        if(teasession.getParameter("act").equals("edit")){
    	String companyname=teasession.getParameter("companyname");
    	String companyperson=teasession.getParameter("companyperson");
    	String companytelephone=teasession.getParameter("companytelephone");
    	String companyinfo=teasession.getParameter("companyinfo");
    	p.set(member, companyname, companyperson, companytelephone, companyinfo);
    	response.sendRedirect("/jsp/type/lvyou/Jobs.jsp");
        }
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
 </script>
<body id="bodynone">
  
 
  <form action="/jsp/type/lvyou/Company.jsp" name="form1" method="POST">
    <input type="hidden" name="member" value="<%=member%>">
    <input type="hidden" name="jid" value="<%=jid%>">
    <input type="hidden" name="act" value="edit">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
    <td colspan=4>
    <input type="button" name="name" value="公司基本信息"  onClick="window.open('/jsp/type/lvyou/Company.jsp?jid=<%=jid%>&member=<%=member%>','_self');">
<input type="button" name="name" value="职位列表"  onClick="window.open('/jsp/type/lvyou/JobDetails.jsp?jid=<%=jid%>&member=<%=member%>','_self');">
</td>
   </tr>
     <tr>
    <td colspan=4>公司基本信息</td>
   </tr>
    <tr>
   
    <td>公司名称</td><td><input type="text" name="companyname" value="<%=p.getCompanyname() %>"></td>
     <td>联系人</td><td><input type="text" name="companyperson" value="<%=p.getCompanyperson() %>"></td>
   </tr>
   <tr>
   <td>联系电话</td><td colspan="3"><input type="text" name="companytelephone" value="<%=p.getCompanytelephone() %>"></td>
    </tr>
  <tr>
   <td>公司简介</td><td colspan="3"><textarea name="companyinfo" cols="50" rows="5"><%=p.getCompanyinfo() %></textarea></td>
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