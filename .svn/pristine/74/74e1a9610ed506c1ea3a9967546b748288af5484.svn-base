<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page  import="tea.htmlx.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@include file="/jsp/include/Canlendar4.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


String nexturl = request.getRequestURI()+"?"+request.getContextPath();
StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));


String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND time >=").append(DbAdapter.cite(time_c));
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND time <=").append(DbAdapter.cite(time_d));
  param.append("&time_d=").append(time_d);
}

//客户
String workproject=teasession.getParameter("workproject");
if(workproject!=null && workproject.length()>0)
{
    sql.append(" AND name LIKE ").append(DbAdapter.cite("%"+workproject+"%"));
    param.append("&workproject=").append(java.net.URLEncoder.encode(workproject,"UTF-8"));

}



int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}

count = Workproject.count(teasession._strCommunity,sql.toString());
sql.append(" ORDER BY time DESC");
%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body >
<script type="">
window.name='tar';
function f_xz(igd)
{
  window.returnValue=igd;
  window.close();
}
</script>

<h1>客户查询</h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <h2>查询</h2>
  <form name=form1 method="POST" action="?"  target="tar">

     <input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td>客户名称：</td>
        <td><input type="text" name="workproject" value="<%if(workproject!=null)out.print(workproject);%>"> </td>
        <td>创建日期：</td>
        <td>
        从&nbsp;
        <input name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar('<%=tea.entity.site.Community.getYear(10,"-")%>', '<%=tea.entity.site.Community.getYear(10,"+")%>', 0,'yyyy-MM-dd').show(time_c);" alt="" />
        &nbsp;到&nbsp;
        <input name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar('<%=tea.entity.site.Community.getYear(10,"-")%>', '<%=tea.entity.site.Community.getYear(10,"+")%>', 0,'yyyy-MM-dd').show(time_d);" alt="" />
        </td>
        <td><input type="submit" value="查询"/></td>
      </tr>
    </table>
    <h2>列表(共有客户&nbsp;<%=count %>&nbsp;位)</h2>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr id="tableonetr">
        <td nowrap>客户名称</td>
        <td nowrap>创建日期</td>
      </tr>
      <%

      java.util.Enumeration e=Workproject.find(teasession._strCommunity,sql.toString(),pos,pageSize);
      if(!e.hasMoreElements())
      {
        out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
      }
      while(e.hasMoreElements())
      {
        int wkid=((Integer)e.nextElement()).intValue();
        Workproject wobj=Workproject.find(wkid);
        %>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" onclick="f_xz('<%=wkid%>');">
          <td><%=wobj.getName(teasession._nLanguage)%></td>
          <td><%=wobj.getTimeToString()%></td>

        </tr>
        <%} %>
         <%if (count > pageSize) { %>
   <tr> <td colspan="10" id="tdpage"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
       <%} %>
    </table>
    <br>
   <input type="button" value="关闭"  onClick="javascript:window.close();">

</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<script>
var as=document.getElementById("tdpage");
if(as)
{
  as=as.getElementsByTagName("A");

  for(var i=0;i<as.length;i++)
  {
    as[i].setAttribute("target","tar");
  }
}

</script>
</body>
</html>



