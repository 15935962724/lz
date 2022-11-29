<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.*" %>
<%@ page import="tea.ui.TeaSession" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int id=0;
if(request.getParameter("id")!=null)
id=Integer.parseInt(request.getParameter("id"));
SMSPhoneBook smspb=SMSPhoneBook.find(id);

Resource r=new Resource("/tea/resource/Group");

String nexturl=request.getParameter("nexturl");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function fload()
{
  form1.name.focus();
<%
String info=request.getParameter("info");
if(info!=null)
{
  out.print("alert(\""+info+"\");document.getElementById('"+request.getParameter("focus")+"').focus();");
}
%>
}
</script>
</head>
<body onLoad="fload();">
<h1><%=r.getString(teasession._nLanguage, "编辑朋友")%></h1>
<div id="head6"><img height="6" alt=""></div>
<br>

<form name=form1 method=post action="/servlet/EditContact" onSubmit="return submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&submitText(this.gid, '<%=r.getString(teasession._nLanguage, "无效所属组")%>');">
<input type=hidden name="community" value="<%=teasession._strCommunity%>">
<input type=hidden name=id value="<%=id%>">
<input type=hidden name=nexturl value="<%=nexturl%>" >
<input type=hidden name="act" value="communityeditphonebook">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td ><%=r.getString(teasession._nLanguage,"Name")%></td>
      <td><input type=text size=40  name=name  value="<%if(smspb.getName()!=null)out.print(smspb.getName());%>" maxlength=20 ></td>
    <tr>
      <td ><%=r.getString(teasession._nLanguage,"mobile")%></td>
      <td ><input type=text size=40  name=mobile value="<%if(smspb.getMobile()!=null)out.print(smspb.getMobile());%>" maxlength=11 ></td>
    <tr>
      <td  ><%=r.getString(teasession._nLanguage,"phone")%></td>
      <td  ><input type=text size=40  name=telephone value="<%if(smspb.getTelephone()!=null)out.print(smspb.getTelephone());%>"maxlength=18 ></td>
    </tr>
    <tr>
      <td > Email</td>
      <td ><input type=text size=40  name="email"  value="<%if(smspb.getEmail()!=null)out.print(smspb.getEmail());%>" maxlength=30 ></td>
    <tr>
      <td ><%=r.getString(teasession._nLanguage,"MemberId")%></td>
      <td ><input type=text size=40  name="memberx"  value="<%if(smspb.getMemberx()!=null)out.print(smspb.getMemberx());%>" maxlength=30 ></td>
    <tr>
      <td ><%=r.getString(teasession._nLanguage,"GroupType")%></td>
      <td><select name=gid size=1 >
<option value="" >-----------</option>
<%
java.util.Enumeration enumer=SMSGroup.findByMember(teasession._strCommunity,Entity.DEFAULT_MEMBER);
while(enumer.hasMoreElements())
{
  SMSGroup smsg=SMSGroup.find(((Integer)enumer.nextElement()).intValue());
  out.print("<option value="+smsg.getId());
  if(smspb.getGroupid()==smsg.getId())
  out.print(" SELECTED ");
  out.print(">"+smsg.getName());
} %>
        </select></td>
    </tr>
    <tr>
      <td height=45 colspan=6 align=center><input type="submit" name="Submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
        <input type="button" name="Submit2" onClick="history.back();" value="<%=r.getString(teasession._nLanguage,"CBBack")%>">
      </td>
    </tr>
</table>
  </form>
  
<br/>
<div id="head6"><img height="6" alt=""></div>
<br>
</body>
</html>
