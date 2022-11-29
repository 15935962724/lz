<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.csvclub.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.admin.*" %>
<jsp:directive.page import="tea.resource.Common"/><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}


Resource r=new Resource();
String member = request.getParameter("member");

Profile probj = Profile.find(member);
//ProfileCsv procsv = ProfileCsv.find(member);

Csvdoghouse houobj = Csvdoghouse.find(member,teasession._strCommunity);

houobj.getTypefi();//1
houobj.getDoghouseC();

AdminUsrRole userobj = AdminUsrRole.find(teasession._strCommunity,member);
userobj.isExists();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js"></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>会员详细信息</h1>
<br>
<div id="head6"><img height="6"></div>


     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
	      <td>会员ID:</td>
	      <td><%=member %></td>
    </tr>
    <tr>
      <td>性别:</td>
      <td><%if(probj.isSex()==true)out.print("男");else if(probj.isSex()==false)out.print("女"); %></td>
    </tr>
    <tr>
      <td colspan="2"><a href="/home/<%=member%>/">犬舍展示</a></td>
    </tr>
    <%
    if(houobj.getTypefi()==1)
    {
      %>
      <tr>
        <td>犬舍中文名:</td>
        <td><%if(houobj.getDoghouseC()!=null)out.print(houobj.getDoghouseC()); %></td>
      </tr>
      <%
    }
    %>
    <tr>
      <td>省（洲）:</td>
      <td><%out.print(Common.CSVCITYS[probj.getProvince(teasession._nLanguage)][1]); %></td>
    </tr>
    <tr>
      <td>县市:</td>
      <td><%if(probj.getCity(teasession._nLanguage)!=null)out.print(probj.getCity(teasession._nLanguage)); %></td>
    </tr>
</table>
<br>
<div id="head6"><img height="6"></div>
</body>
</html>



