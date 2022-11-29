<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %>
<%@page  import="tea.entity.node.*" %><%@page  import="tea.entity.site.*" %><%@ page import="java.util.*" %><%@ page import="java.io.*" %>
<%@ page import="tea.ui.*" %><%@ page import="tea.html.*" %>
<%@ page import="tea.htmlx.*"%><%@ page import="tea.entity.admin.*"%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);
Node node = Node.find(teasession._nNode);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}



%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1>售票点编辑</h1>
<div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv"> </div>
  <form name="form1" method="post" action="/servlet/EditPerform"  ENCtype=multipart/form-data  onSubmit="return f_submit();">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

    <tr>
      <td align="right" nowrap>售票点名称:</td>
      <td >
        <input type="text" size="60" class="edit_input" name="" value=""  maxlength="60">&nbsp;*&nbsp;
      </td>
    </tr>
    <TR><td align="right" nowrap>售票员名称:<input type="hidden" size="1000" name="optionsvalue"></td>
      <TD colspan="3">
      <table>
      <tr align="center">
         <td >选中售票员</td>

      <td >&nbsp;</td>
     <td >备选售票员</td>
      </tr>
      <tr><td>
      <input type="hidden" name="role" >
      <select name="role1" size="8" multiple style="WIDTH:140px;"  ondblclick="move(form1.role1,form1.role2,true);">

    </select>
    </td>
    <td>
    <input type="button" value=" ← " onClick="move(form1.role2,form1.role1,true);" >
    <br>
    <input type="button" value=" → "  onClick="move(form1.role1,form1.role2,true);">    </td>
    <td>
    <select name="role2" ondblclick="move(form1.role2,form1.role1,true);" multiple style="WIDTH:140px;" size="8">
      <%
           java.util.Enumeration e = AdminUsrRole.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
           while(e.hasMoreElements())
           {
             String member = ((String)e.nextElement());
             AdminUsrRole arobj = AdminUsrRole.find(teasession._strCommunity,member);
             String membername = member;
           tea.entity.member.Profile pobj =  tea.entity.member.Profile.find(member);
             if((pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage))!=null)
             {
               membername = pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage);
             }
             out.print("<option  value="+member);
             out.print(">"+membername);
             out.print("</option>");
           }
      %>
    </select>
    </td>
    </tr>
  </table>
    <tr>
      <td align="right" nowrap>售票折扣:</td>
      <td >
        <input type="text" size="8" class="edit_input" name="" value=""  maxlength="8">
      </td>
    </tr>
    <tr>
      <td align="right" nowrap>联系人名称:</td>
      <td >
        <input type="text" size="11" class="edit_input" name="" value=""  maxlength="11">
      </td>
    </tr>
    <tr>
      <td align="right" nowrap>售票点电话:</td>
      <td >
        <input type="text" size="11" class="edit_input" name="" value=""  maxlength="12">
      </td>
    </tr>
    <tr>
      <td align="right" nowrap>售票点地址:</td>
      <td >
        <input type="text" size="60" class="edit_input" name="" value=""  maxlength="60">
      </td>
    </tr>

  </table>
  <br>
  <INPUT TYPE=SUBMIT NAME="GoBack"  ID="edit_GoFinish" class="edit_button" VALUE="添加">&nbsp;

    <input type=button value="返回" onClick="javascript:history.back()">&nbsp;

  </form>


  <div id="head6"><img height="6" src="about:blank"></div>


</body>
</html>

