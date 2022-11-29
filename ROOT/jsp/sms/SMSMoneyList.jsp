<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}

String community=teasession._strCommunity;


r.add("/tea/resource/SMS");

String member=teasession._rv.toString();

%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function fc(obj,value)
{
  for(var index=0;index<obj.length;index++)
  {
    if(obj.options[index].value==value)
    {
      obj.options[index].selected=true;
      break;
    }
  }
}
</script>
</head>
<body>

<h1><%=r.getString(teasession._nLanguage, "SMS")%> 充值计录</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr"><td></td>
<TD><%=r.getString(teasession._nLanguage, "StartTime")%></TD>
<TD><%=r.getString(teasession._nLanguage, "EndTime")%></TD>
<TD><%=r.getString(teasession._nLanguage, "AddMoney")%></TD>
<TD><%=r.getString(teasession._nLanguage, "1172546531118")%></TD>
<TD><%=r.getString(teasession._nLanguage, "Balance")%></TD>
<td></td>
</tr>
<%
java.util.Enumeration enumer= SMSMoney.findByMember(member,community);
for(int index=1;enumer.hasMoreElements();index++)
{
  int id=((Integer)enumer.nextElement()).intValue();
  SMSMoney obj=SMSMoney.find(id);

  %>
 <tr onmouseover="bgColor='#BCD1E9'" onmouseout="bgColor=''" >
       <td width="1"><%=index%></td>
         <td><%=obj.getStarttimeToString()%></td>

         <td><%= obj.getEndtimeToString()%></td>
<td><%= obj.getMoney()%></td>
<td><%= obj.getPayout()%></td>
<td><%=SMSMoney.df.format(obj.getBalance())%></td>

 </tr>
  <%
}
     %>


  </table>

<br>
<div id="head6"><img height="6" src="about:blank"></div>

<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>

</body>
</html>

