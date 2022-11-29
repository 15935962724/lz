<%@page contentType="text/html;charset=UTF-8" import="java.util.*" %>
<%@page import="tea.html.*" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@ page import="tea.http.RequestHelper"%>
<%@ page import = "tea.resource.Resource" %>
<%@ page import = "tea.entity.node.Sms" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="java.io.*" %>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.util.*"%>
<%
TeaSession teasession = new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r = new Resource();
  int id = 0;
  if(teasession.getParameter("id")!=null && teasession.getParameter("id").length()>0)
     id = Integer.parseInt(teasession.getParameter("id"));

String nexturl = request.getRequestURI()+"?"+request.getContextPath();
String role = teasession.getParameter("role");
 StringBuffer sql = new StringBuffer(" and hidden=1 and type = 21 ");
  StringBuffer param = new StringBuffer("?community=" + teasession._strCommunity);

param.append("&role=").append(role);
param.append("&id=").append(id);

String member = request.getParameter("member");
if(member!=null && member.length()>0)
{
  sql.append(" and rcreator like ").append(" ").append(DbAdapter.cite("%"+member+"%"));
  param.append("&member=").append(java.net.URLEncoder.encode(member,"UTF-8"));
}
String gs = request.getParameter("gs");
if(gs!=null && gs.length()>0)
{
  sql.append(" and node in (select node from NodeLayer  where  subject like "+DbAdapter.cite("%"+gs+"%")+" ) ");
  param.append("&gs=").append(java.net.URLEncoder.encode(gs,"UTF-8"));
}
String time_k = request.getParameter("time_k");
if(time_k!=null && time_k.length()>0)
{
  sql.append(" and time >= ").append(" ").append(DbAdapter.cite(time_k));
  param.append("&time_k=").append(time_k);
}
String time_j = request.getParameter("time_j");
if(time_j!=null && time_j.length()>0)
{
  sql.append(" and time <= ").append(" ").append(DbAdapter.cite(time_j));
  param.append("&time_j=").append(time_j);
}

 int pos = 0, pageSize = 20, count = 0;
  if (request.getParameter("pos") != null) {
    pos = Integer.parseInt(request.getParameter("pos"));
  }
  count = Node.count(sql.toString());

  sql.append(" order by node desc ");




%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

<script type="">
function f_aditing(igd)
{
   form1.node.value = igd;
   form1.action ='/jsp/user/CompanyShow.jsp';
   form1.submit();
}
</script>
<h1>公司审核</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>搜索</h2>
<FORM name=form2 METHOD=get action="?" >
<input type="hidden" name="id" value="<%=id%>"/>
<input type="hidden" name="role" value="<%=role%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td>用 户 名:<input type="text" name="member" value="<%if(member!=null)out.print(member);%>"/></td>
<td>注册时间:<input name="time_k" size="7"  value="<%if(time_k!=null)out.print(time_k);%>"><A href="###"><img onClick="showCalendar('form2.time_k');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
至<input name="time_j" size="7"  value="<%if(time_j!=null)out.print(time_j);%>"><A href="###"><img onClick="showCalendar('form2.time_j');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
</td>

</tr>
<tr>
<td>公司名称:<input type="text" name="gs" value="<%if(gs!=null)out.print(gs);%>"/></td>
<td><input type="submit"  value="搜索"> </td>
</tr>
</table>
</form>
<h2>列表</h2>
<FORM name=form1 METHOD=POST action="?" >
<input type="hidden" name="node"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="role" value="<%=role%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
       <td>用户名</td>
       <td>公司名称</td>
       <td>注册时间</td>
       <td>操作</td>
    </tr>

  <%

  java.util.Enumeration e = Node.find(sql.toString(),pos,pageSize);
  if(!e.hasMoreElements())
  {
    out.print(" <tr><td colspan=10 align=center>暂无记录</td></tr>");
  }

  while (e.hasMoreElements())
  {
    int node = ((Integer)e.nextElement()).intValue();
    Node nobj = Node.find(node);


  %>
 <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td><%=nobj.getCreator()._strR %></td>
  <td><%=nobj.getSubject(teasession._nLanguage) %></td>
  <td><%=nobj.getTimeToString() %></td>
  <td><input type="button" value="审核" onClick="f_aditing('<%=node%>');"/></td>
  </tr>
  <%} %>
<tr>
  <%if (count > pageSize) {  %>
    <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td>
  <%}  %>
  </tr>
  </table>

</FORM>





<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
