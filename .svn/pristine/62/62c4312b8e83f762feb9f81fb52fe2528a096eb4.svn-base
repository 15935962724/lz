<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
int friendlist=Integer.parseInt(request.getParameter("friendlist"));
tea.entity.member.FriendList flobj=tea.entity.member.FriendList.find(friendlist);
if(request.getMethod().equals("POST"))
{
  if(!flobj.getMember().equals(teasession._rv._strR))
  {
    response.sendError(403);
  }else
  {
    if(request.getParameter("delete")!=null)
    flobj.delete();
    else
    flobj.set(Integer.parseInt(request.getParameter("type")),Integer.parseInt(request.getParameter("gid")));
    response.sendRedirect("TheirFriends.jsp");
    return;
  }
}
%>
<html>
<head>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function SelectType(selectobj)
{
  window.location='<%=request.getRequestURI()%>?type='+selectobj.options[selectobj.selectedIndex].value;
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBEditContact")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form action="" method="POST">
<input type="hidden" name="friendlist" value="<%=friendlist%>" />
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=flobj.getMember2()%>
      </td>
      <td colspan="20">
         <select name=gid size=1 >
        <option value=0>请选择</option>
<%
java.util.Enumeration enumer=tea.entity.node.SMSGroup.findByMember(teasession._rv.toString(),teasession._strCommunity) ;
while(enumer.hasMoreElements())
{
  tea.entity.node.SMSGroup smsg=tea.entity.node.SMSGroup.find(((Integer)enumer.nextElement()).intValue());
  out.print("<option value="+smsg.getId());
  if(flobj.getGroupid()==smsg.getId())
  out.print(" SELECTED ");
  out.print(">"+smsg.getName());
} %></select>
<a href="/jsp/sms/psmanagement/GroupManage.jsp" >组管理</a>
<select  name="type">
        <option value="0" selected>选择亲密度</option>
        <option value="1" <%=getSelect(flobj.getType()==1)%>>未见过面</option>
        <option value="2" <%=getSelect(flobj.getType()==2)%>>认识而已</option>
        <option value="3" <%=getSelect(flobj.getType()==3)%>>一般朋友</option>
        <option value="4" <%=getSelect(flobj.getType()==4)%>>好朋友</option>
        <option value="5" <%=getSelect(flobj.getType()==5)%>>挚友</option>
</select>
</tr>
</table>
<input type="submit" name="delete" value="断绝关系" onClick="return (confirm('确认 断绝关系?'))"/>
<input type="submit" value="提交"/>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

