<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>

<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script><link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBManager")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%>  </div>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td colspan=4>组</td>
    </tr>
    <tr ID=TableHeader>
<td>名称</td>
<td>新建</td>
<td>编辑</td>
<td>删除</td>
</tr>
  <%
    java.util.Enumeration enumeration = Groups.find();
    while (enumeration.hasMoreElements()) {String groupname=enumeration.nextElement().toString();
  %>
    <tr>
      <td>
        <a href="EditGroups.jsp?group=<%=groupname%>"><img  src="/tea/image/group.gif"/><%=groupname%>        </a>
      </td>
      <td><INput  id="CHECKBOX" type="CHECKBOX" name="create"></td>
      <td><INput  id="CHECKBOX" type="CHECKBOX" name="create"></td>
      <td><INput  id="CHECKBOX" type="CHECKBOX" name="create"></td>
    </tr>
  <%}  %>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter"">
    <tr >
      <td colspan=4>用户</td>
    </tr>
        <tr ID=TableHeader>
<td>名称</td>
<td>新建</td>
<td>编辑</td>
<td>删除</td>
</tr>
  <%
    java.util.Enumeration enumerationuser = Profile.findByCommunity(teasession._strCommunity);
    while (enumerationuser.hasMoreElements()) {
      String name=(String)enumerationuser.nextElement();
  %>
    <tr>
      <td>
        <a href="#"><img  src="/tea/image/user.gif"/><%=name%>        </a>
      </td>
      <td><INput  id="CHECKBOX" type="CHECKBOX" name="<%=name%>_user_create"></td>
      <td><INput  id="CHECKBOX" type="CHECKBOX" name="<%=name%>_user_edit"></td>
      <td><INput  id="CHECKBOX" type="CHECKBOX" name="<%=name%>_user_del"></td>
    </tr>
  <%}  %>
  </table>
  

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%>  </div>
</body>
</html>



