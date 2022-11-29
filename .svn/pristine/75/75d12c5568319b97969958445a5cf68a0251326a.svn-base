<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
  function SelectType(selectobj)
  {
window.location='<%=request.getRequestURI()%>?type='+selectobj.options[selectobj.selectedIndex].value+'&<%=request.getQueryString()%>';
  }
   function SelectGid(selectobj)
  {
window.location='<%=request.getRequestURI()%>?groupid='+selectobj.options[selectobj.selectedIndex].value+'&<%=request.getQueryString()%>';
  }
  </script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Contact")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<table cellspacing="0" id="tablecenter">
  <tr>
    <td colspan="20"> 组:
      <select name=gid size=1 onchange="SelectGid(this)">
        <option value=0>------------</option>
        <%
            int groupid=0;
    if(request.getParameter("groupid")!=null)
    groupid=Integer.parseInt(request.getParameter("groupid"));
        int type=0;
    if(request.getParameter("type")!=null)
    type=Integer.parseInt(request.getParameter("type"));

java.util.Enumeration enumer=tea.entity.node.SMSGroup.findByMember(teasession._rv.toString(),node.getCommunity()) ;
while(enumer.hasMoreElements())
{
  tea.entity.node.SMSGroup smsg=tea.entity.node.SMSGroup.find(((Integer)enumer.nextElement()).intValue());
  out.print("<option value="+smsg.getId());
  if(groupid==smsg.getId())
  out.print(" SELECTED ");
  out.print(">"+smsg.getName()) ;
} %>
      </select>
      <a href="/jsp/sms/psmanagement/GroupManage.jsp" >组管理</a> 亲密度:
      <select  onchange="SelectType(this)" 		name="type">
        <option value="0" selected>------------</option>
        <option value="1" <%=getSelect(type==1)%>>未见过面</option>
        <option value="2" <%=getSelect(type==2)%>>认识而已</option>
        <option value="3" <%=getSelect(type==3)%>>一般朋友</option>
        <option value="4" <%=getSelect(type==4)%>>好朋友</option>
        <option value="5" <%=getSelect(type==5)%>>挚友</option>
      </select>
    </td>
  </tr>
  <tr>
    <td>姓名</td>
  </tr>
  <%


    enumer=tea.entity.member.FriendList.find(teasession._rv._strR,groupid,type);
while(enumer.hasMoreElements())
{
  int id=((Integer)enumer.nextElement()).intValue();
  tea.entity.member.FriendList fl=tea.entity.member.FriendList.find(id);
%>
  <tr>
    <td><%=ts.getRvDetail(new tea.entity.RV(fl.getMember2(),node.getCommunity()), teasession._nLanguage)%></td>
  </tr>
  <%}%>
</table>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

