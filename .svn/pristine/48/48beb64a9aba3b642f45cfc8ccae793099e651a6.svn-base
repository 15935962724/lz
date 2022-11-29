<%@page contentType="text/html;charset=UTF-8" %><%@include file="/jsp/Header.jsp"%>
<%
String community=teasession._strCommunity;


if (!teasession._rv.isWebMaster() && !teasession._rv.isOrganizer(community))
{
  response.sendError(403);
  return;
}



String member=request.getParameter("member");
%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function flen(obj,text)
{
  if(obj.value<1||obj.value>1000)
  {
    alert(text);
    obj.focus();
    return false;
  }
  return true;
}
</script>
</head>

<body>

<div id="head6"><img height="6" src="about:blank"></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>
  <form action="">
  <%
  if(request.getParameter("id")!=null)
  {
    out.print("<input type=hidden name=id value="+request.getParameter("id")+"  />");
  }
  %>
  <input type="hidden"  name="Node" value="<%=teasession._nNode%>"/>
  <input type="hidden"  name="community" value="<%=community%>"/>
  <input type="text"  name="member"/><input type="submit" value="GO"/>
  </form>
</tr>
<tr ID=tableonetr>
<td>会员</td>
<td>余额</td>
</tr>
<%
int pos=0;
java.util.Enumeration enumer=ProfileMoney.find(community,member,pos,Integer.MAX_VALUE);
while(enumer.hasMoreElements())
{
  ProfileMoney obj=(ProfileMoney)enumer.nextElement();
%>
 <tr onmouseover="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
<td><%=obj.getMember()%></td>
<td><%=obj.getMoney()%></td>
</tr>
<%
}
%>
</table>
<div id="head6"><img height="6" alt=""></div>
</body>
</html>

