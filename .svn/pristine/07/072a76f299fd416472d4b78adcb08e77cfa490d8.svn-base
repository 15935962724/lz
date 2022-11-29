<%@page import="tea.entity.site.Communityintegral"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.admin.*"%><%@ page import="tea.entity.member.*"%><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.node.*" %><%@ page import="java.util.*" %><%@ page import="tea.ui.*" %><%@ page import="tea.html.*" %><%@page import="tea.entity.admin.mov.*"%>
<%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
} 

Resource r=new Resource();
r.add("/tea/resource/Classes");
String nexturl = request.getRequestURI()+"?"+request.getQueryString();
Communityintegral cobj = Communityintegral.find(teasession._strCommunity);

if("POST".equals(request.getMethod()))
{
     float regpoint=0;//注册积分
     float invitepoint=0;//邀请积分
     float cluepoint=0;//线索积分
     float buspoint=0;//商机积分
     float pollpoint=0;//调查积分 
     
     if(teasession.getParameter("regpoint")!=null && teasession.getParameter("regpoint").length()>0)
     {
    	 regpoint = Float.parseFloat(teasession.getParameter("regpoint"));
     }
     if(teasession.getParameter("invitepoint")!=null && teasession.getParameter("invitepoint").length()>0)
     {
    	 invitepoint = Float.parseFloat(teasession.getParameter("invitepoint"));
     }
     if(teasession.getParameter("cluepoint")!=null && teasession.getParameter("cluepoint").length()>0)
     {
    	 cluepoint = Float.parseFloat(teasession.getParameter("cluepoint"));
     }
     if(teasession.getParameter("buspoint")!=null && teasession.getParameter("buspoint").length()>0)
     {
    	 buspoint = Float.parseFloat(teasession.getParameter("buspoint"));
     }
     if(teasession.getParameter("pollpoint")!=null && teasession.getParameter("pollpoint").length()>0)
     {
    	 pollpoint = Float.parseFloat(teasession.getParameter("pollpoint"));
     }
     
     
      
     if(cobj.isExists())
     {
    	 cobj.set(teasession._strCommunity,teasession._rv.toString(),new Date(),regpoint,invitepoint,cluepoint,buspoint,pollpoint);
     }else
     {
    	 cobj.create(teasession._strCommunity,teasession._rv.toString(),new Date(),regpoint,invitepoint,cluepoint,buspoint,pollpoint);
     }
     out.print("<script  language='javascript'>alert('积分设置成功');window.location.href='"+nexturl+"';</script> ");
   
     return;
     
     
      
}



%>
<html> 
<head>
<title>履友积分设置</title>

<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="text/javascript">

</script>
</head>
<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" scroll="yes">
<h1>履友积分设置</h1>
<form name="form1" method="POST" action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=teasession.getParameter("id") %>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td align="right" nowrap>会员注册所获积分：</td>
    <td><input type="text" name="regpoint" value="<%=cobj.getRegpoint() %>" ></td>
  </tr>
    <tr>
    <td align="right" nowrap>邀请注册积分：</td>
    <td><input type="text" name="invitepoint" value="<%=cobj.getInvitepoint() %>" ></td>
  </tr>
   <tr>
    <td align="right" nowrap>线索积分：</td>
    <td><input type="text" name="cluepoint" value="<%=cobj.getCluepoint() %>" ></td>
  </tr>
   <tr>
    <td align="right" nowrap>商机成交积分：</td>
    <td><input type="text" name="buspoint" value="<%=cobj.getBuspoint() %>" ></td>
  </tr>
  <tr>
    <td align="right" nowrap>调查积分：</td>
    <td><input type="text" name="pollpoint" value="<%=cobj.getPollpoint() %>" ></td>
  </tr>
</table>
 
<br>
<input type="submit" id="buttonid" value="提交" >

</form>
</body>
</html>
