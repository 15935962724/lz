<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.resource.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.ui.*"%><%request.setCharacterEncoding("UTF-8");

String ip=request.getParameter("ip");

if(ip!=null&&(ip=ip.trim()).length()>0&&"brachylogy".equals(request.getParameter("act")))
{
  out.print(NodeAccessWhere.findByIp(ip));
  return;
}

Resource r = new Resource();
TeaSession teasession=new TeaSession(request);

String _strId=request.getParameter("id");

String myip=request.getRemoteAddr();

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "IP")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<form action="?">
<input type=hidden name=community value="<%=teasession._strCommunity%>">
<input type=hidden name=id value="<%=_strId%>">

<h2><%=r.getString(teasession._nLanguage, "1216103151974")%></h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>IP:</td>
      <td><input type="text" name="ip" value="<%if(ip!=null)out.print(ip);%>"></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="submit" name="Submit" value="<%=r.getString(teasession._nLanguage, "1216103415084")%>"></td>
    </tr>
    <%
 if(ip!=null)
{
String where=NodeAccessWhere.findByIp(ip);
%>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Address")%>:</td>
      <td><%=where%></td>
    </tr>
<%}%>
  </table>
</form>
<br>

<h2><%=r.getString(teasession._nLanguage, "1216103202568")%></h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>IP:</td>
      <td><%=myip%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Address")%>:</td>
      <td><%=NodeAccessWhere.findByIp(myip)%></td>
    </tr>
</table>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

