<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.node.*" %>
<%@ include file="/jsp/Header.jsp" %>
<%
String community=node.getCommunity();

String member=teasession._rv.toString();
tea.entity.member.Profile profile_obj=tea.entity.member.Profile.find(member);

%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<body>
<DIV ID="edit_BodyDiv"><span style="float:left;color:#FF0000;font-weight:bold;"><img SRC="/tea/image/score/0001.jpg">　历史六个月的差点指数</span>
<span style="float:right;color:#FF0000;font-weight:bold;">你好：<%=profile_obj.getName(teasession._nLanguage)%></span>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<%
java.util.Calendar calendar=java.util.Calendar.getInstance();
java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyy-MM");
StringBuffer sb=new StringBuffer();
for(int index=0;index<6;index++)
{
  calendar.add(java.util.Calendar.MONTH ,-1);
  out.print("<td align=center>"+sdf.format(calendar.getTime())+"</td>");
  sb.append("<td align=center style=color:#FF0000;font-weight:bold>");
  if(Score.getMonth(member,calendar.getTime())==-10000)
  {
	  sb.append("无");
  }else
  {
	  sb.append(Score.getMonth(member,calendar.getTime()));
  }
  sb.append("</td>");
}
%>
</tr> 
<tr><%=sb.toString()%></tr>
</table><br><br>
希望通过上面的数字，您可以看到自己的成绩在不停的提高！
</DIV>

</body>
</html>
