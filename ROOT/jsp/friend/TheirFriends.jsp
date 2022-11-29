<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<!-- 朋友圈列表 -->
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
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
<h1><%=r.getString(teasession._nLanguage, "TheirFriends")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2><%=r.getString(teasession._nLanguage, "TheirFriends")%></h2>
<table cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td>姓名</td>
    <td>性别</td>
  </tr>
  <%
int groupid=0;
if(request.getParameter("groupid")!=null)
groupid=Integer.parseInt(request.getParameter("groupid"));
int type=0;
if(request.getParameter("type")!=null)
type=Integer.parseInt(request.getParameter("type"));
java.util.Enumeration enumer=tea.entity.member.FriendList.findByMember(teasession._rv._strR);//,groupid,type);
while(enumer.hasMoreElements())
{
  int id=((Integer)enumer.nextElement()).intValue();
  tea.entity.member.FriendList fl=tea.entity.member.FriendList.find(id);
  java.util.Enumeration enumer_their=tea.entity.member.FriendList.findByMember(fl.getMember2());//,groupid,type);
  while(enumer_their.hasMoreElements())
  {
    id=((Integer)enumer_their.nextElement()).intValue();
    tea.entity.member.FriendList fl_their=tea.entity.member.FriendList.find(id);
    tea.entity.member.Profile profile=tea.entity.member.Profile.find(fl_their.getMember());
%>
  <tr>
    <td><%=ts.getRvDetail(new tea.entity.RV(fl_their.getMember(),teasession._strCommunity), teasession._nLanguage)%></td>
    <td><%=profile.isSex()%>
      <input type="button" value="编辑" onclick="window.location='EditFriend.jsp?friendlist=<%=id%>';"/></td>
  </tr>
  <%}
}%>
</table>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

