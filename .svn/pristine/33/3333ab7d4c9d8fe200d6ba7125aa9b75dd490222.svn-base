<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.csvclub.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import ="tea.entity.member.*" %>
<%@ page import="tea.entity.integral.*"%>
<jsp:directive.page import="java.math.BigDecimal"/>
<jsp:directive.page import="java.net.URLEncoder"/>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
Resource r=new Resource();
StringBuffer param=new StringBuffer();
StringBuffer sql=new StringBuffer("");
int pos=0;
String member = null;///这个是用户 ，
if(teasession.getParameter("member")!=null)
{
member = teasession.getParameter("member");
}
int id=0;
int add_int = 0;
int minus_int =0;
String remarks = "";
if(teasession.getParameter("ids")!=null && teasession.getParameter("ids").length()>0)
{
  id=Integer.parseInt(teasession.getParameter("ids"));
  IntegralUpdate obj = IntegralUpdate.find(id);
  member = obj.getUsers();
  add_int = obj.getAdd_int();
  minus_int = obj.getMinus_int();
  remarks = obj.getRemarks();
}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body bgcolor="#ffffff">
<h1>积分手工修改
</h1>
<form action="/servlet/EditIntegralManage" method="POST" name="form1">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="Node" value="<%=teasession._nNode%>"/>
<input  type="hidden" name="act" value="integralupdate"/>
<input type="hidden" name="id" value="<%=id%>" />
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>用户ID：</td><td><input type="text"  size="15" name="user" value="<%=member%>" readonly="readonly"/></td></tr>
<tr><td>添加积分：</td><td><input type="text"  size="15" name="add_int" value="<%=add_int%>"/></td></tr>
<tr><td>扣除积分：</td><td><input type="text" size="15" name="minus_int"  value="<%=minus_int%>"/></td></tr>
<tr><td>原因：</td><td><textarea cols="25" rows="3" name="remarks" ><%=remarks%></textarea></td>
</tr>
<tr><td colspan="2" align="center"><input type="submit" value="提交" /> <input type="button" name="Submit2" value="返回" onClick="window.history.back();"></td></tr>
</table>
</form>
</body>
</html>

