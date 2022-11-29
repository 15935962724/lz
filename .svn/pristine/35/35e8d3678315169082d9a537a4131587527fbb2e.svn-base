<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page  import="tea.htmlx.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;

Resource r=new Resource("/tea/resource/Workreport");

String nexturl=request.getParameter("nexturl");

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onLoad="form1.file.focus();">
<h1><%=r.getString(teasession._nLanguage,"步骤 2（共 3 步）：上载您的文件")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<form action="/jsp/admin/sales/import3.jsp" METHOD=post enctype="multipart/form-data" name=form1 onSubmit="return submitText(this.file,'<%=r.getString(teasession._nLanguage,"InvalidFile")%>')">
  <input type=hidden name="community" value="<%=community%>"/>
  <input type=hidden name="nexturl" value="<%=nexturl%>"/>

  <h2>客户信息</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage,"1.单击“浏览”并选择要导入的文件：")%></td>
    </tr>
    <tr>
      <td><input type=file name="file" size="40"></td>
    </tr>
		<tr><td>&nbsp;</td></tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"2.以下选项设置为默认值。只有当导入文件的字符编码不相同时，才需要改写此默认值.")%></td>
    </tr>
    <tr>
      <td><select name="charset" >
          <option value="GBK" >GBK
          <option value="BIG5" >Big5
          <option value="UTF-8" >UTF-8
        </select>
      </td>
    </tr>
		<tr><td>&nbsp;</td></tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"3.客户匹配类型")%></td>
    </tr>
    <tr>
      <td>
      <input name="identity" type="radio" value="name" checked >客户名
      <input name="identity" type="radio" value="tel" >电话</td>
    </tr>
  </table>
  <input type="button" value="<%=r.getString(teasession._nLanguage,"上一步")%>" onClick="window.open('/jsp/admin/sales/import1.jsp?community=<%=teasession._strCommunity%>','_self');" >
  <input type="submit" value="<%=r.getString(teasession._nLanguage,"下一步")%>" >
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



