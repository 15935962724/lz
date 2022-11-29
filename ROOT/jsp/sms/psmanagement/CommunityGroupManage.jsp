<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><%@page import="tea.entity.*"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}

String _strId=request.getParameter("id");
Resource r=new Resource("/tea/resource/Group");
int count=SMSGroup.countByMember(teasession._strCommunity,Entity.DEFAULT_MEMBER);

%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="">
function selectAll(form,check)
{
  for(index=0;index<form.elements.length;index++)
  {
    if(form.elements[index].type=='checkbox')
    {
      form.elements[index].checked=check.checked;
    }
  }
}
function submitCheck(form)
{
  if(form.id.checked)
  return true;
  for(var index=0;index<form.id.length;index++)
  {
    if(form.id[index].checked)
    {
      return true;
    }
  }
  alert('<%=r.getString(teasession._nLanguage,"InvalidSelect")%>');
  return false;
}
</script>
</head>
<body>

<h1><%=r.getString(teasession._nLanguage,"GroupManages")+" ( "+count+" )"%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>

<form name="form1" action="/servlet/EditContact" method="get">
<input type=hidden name="community" value="<%=teasession._strCommunity%>">
<script>document.write("<input type=hidden name=nexturl value="+document.location+" >");</script>
<input type=hidden name="act" value="communitydeletegroup">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr  id="tableonetr">
  <td><br></td>
  <td><%=r.getString(teasession._nLanguage,"GroupName")%></td>
  <td><%=r.getString(teasession._nLanguage,"Desc")%></td>
  <td><%=r.getString(teasession._nLanguage,"人数")%></td>
  <td><%=r.getString(teasession._nLanguage,"operation")%></td>
</tr>
 <%
 java.util.Enumeration enumer=SMSGroup.findByMember(teasession._strCommunity,Entity.DEFAULT_MEMBER);
 while(enumer.hasMoreElements())
 {
   int id=((Integer)enumer.nextElement()).intValue() ;
   SMSGroup smsg=SMSGroup.find(id);
   
 %>
 <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
   <td width="1"><input type="CHECKBOX" name=id value='<%=id%>'></td>
   <td><A href="/jsp/sms/psmanagement/CommunityPhoneBookManage.jsp?community=<%=teasession._strCommunity%>&groupid=<%=id%>"><%=smsg.getName()%></A></td>
   <td><%=smsg.getDiscript()%>　</td>
   <td><%=SMSPhoneBook.countByGroup(id)%></td>
   <td><input type="button" onclick="window.open('/jsp/sms/psmanagement/CommunityEditGroup.jsp?community=<%=teasession._strCommunity%>&id=<%=id%>&nexturl='+encodeURIComponent(document.location),'_self');" value="<%=r.getString(teasession._nLanguage,"CBEdit")%>"></td>
 </tr>
<%}%>
<tr>
<td colspan="4">
<input type="CHECKBOX" onclick="selectAll(form1,this)" value="0"><%=r.getString(teasession._nLanguage,"SelectAll")%>  <input name="delete" onclick="return (submitCheck(form1)&&confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>'));" type="submit" value="<%=r.getString(teasession._nLanguage,"Delete")%>">
<input  onclick="window.open('/jsp/sms/psmanagement/CommunityEditGroup.jsp?community=<%=teasession._strCommunity%>&nexturl='+encodeURIComponent(document.location),'_self');" type="button" value="<%=r.getString(teasession._nLanguage,"Add")%>">
</td></tr>
</table>
</form>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
</body>
</html>
