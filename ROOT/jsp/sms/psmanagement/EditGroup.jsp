<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.*" %><%@page import="tea.resource.Resource"%>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int id=0;
if(request.getParameter("id")!=null)
id=Integer.parseInt(request.getParameter("id"));

SMSGroup smsg=SMSGroup.find(id);
if(id!=0&&!smsg.getPhonenumber().equals(teasession._rv.toString()))
{
  response.sendError(403);
  return ;
}
Resource r=new Resource("/tea/resource/Group");

String nexturl=request.getParameter("nexturl");

%><html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body onload="document.getElementById('name').focus();">

<h1><%=r.getString(teasession._nLanguage,"GroupManages")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>

<form method=post action="/servlet/EditContact" onsubmit="return submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')" >
<input type=hidden name="community" value="<%=teasession._strCommunity%>">
<input type=hidden name="id" value="<%=id%>">
<input type=hidden name="act" value="editgroup">
<input type=hidden name=nexturl value="<%=nexturl%>">
  
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage,"GroupName")%></td>
      <td ><input type=text size=14 value="<%if(smsg.getName()!=null)out.print(smsg.getName());%>"  name="name" maxlength=20></td>
      <td ><%=r.getString(teasession._nLanguage,"Desc")%></td>
      <td ><input type=text size=30 value="<%if(smsg.getDiscript()!=null)out.print(smsg.getDiscript());%>"  name="descript"  maxlength=80>
      </td>

    </tr>

    <tr>
      <td><input type="submit" name="Submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
        <input type="button" name="Submit2" onclick="history.back();" value="<%=r.getString(teasession._nLanguage,"CBBack")%>"> </td>

    </tr>
</table>
  </form>
  
<br/><br/>
<div id="head6"><img height="6" alt=""></div>
</body>
</html>
