<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>

<%
  int id = 0;
  if (request.getParameter("id") != null) {
    id = Integer.parseInt(request.getParameter("id"));
  }
  Power power = Power.find(id);
  if (request.getMethod().equals("POST")) {
    JspRuntimeLibrary.introspect(power, request);
    //    power.setId((request.getParameter("type") + request.getParameter("code")));
    power.setType(Integer.parseInt(request.getParameter("type")));
    if (request.getParameter("edit") == null && power.isExists())
      response.sendRedirect("/jsp/error/Error.sjp");
    power.set();
    response.sendRedirect("/jsp/access/EditPower.jsp");
    return;
  }
  boolean editbool = false;
  if (request.getParameter("edit") != null)
    editbool = true;
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Add")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>


<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td COLSPAN=10 align="left">权限</td>
    </tr>
    <tr>
      <td class="listing">
        <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr>
            <td scope="row">编号</TD>
            <TD>类型</TD>
            <TD>描述</TD>
            <TD>            </TD>
          </tr>
        <%
          java.util.Enumeration enumeration = power.find();
          Power powerobj;
          while (enumeration.hasMoreElements()) {
            powerobj = Power.find(((Integer) (enumeration.nextElement())).intValue());
        %>
          <tr>
            <td><%=powerobj.getId()%>            </td>
            <td><%=r.getString(teasession._nLanguage,node.NODE_TYPE[powerobj.getType()])%>            </td>
            <td><%=powerobj.getName()%>            </td>
            <td>
              <input type="button" onclick="window.open('EditPower.jsp?id=<%=powerobj.getId()%>&edit=ON','_self')" value="编辑"/>
              <input type="button" onclick="EditPower.jsp?id=<%=powerobj.getId()%>&edit=ON" value="删除"/>
            </td>
          </tr>
        <%}        %>
        </table>
      </td>
    </tr>
  </table>
<form action="" method="POST">
<%
  if (editbool)
    out.print("<input type=\"hidden\" value=\"edit\" name=\"edit\" />");
%>
  <br>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td COLSPAN=10 align="left">添加</td>
    </tr>
    <tr>
    <tr>
      <td scope="row">类型</td>
      <td>
        <select name="type">
        <%for (int count = 0; count < node.NODE_TYPE.length; count++) {        %>
          <option value="<%=count%>" <%=getSelect(count==power.getType())%>><%=r.getString(teasession._nLanguage,node.NODE_TYPE[count])%>          </option>
        <%}        %>
        </select>
      </td>
    </tr>
    <tr>
      <td scope="row">描述</td>
      <td>
        <input type="text" name="name" class="edit_input"  value="<%=power.getName()%>"/>
      </td>
    </tr>
  </table>
  <input type="submit" ID="CBNew" CLASS="CB" name="Submit" value="提交"/>
</form>


<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%>  </div>
</body>
</html>




