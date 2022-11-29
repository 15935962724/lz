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
<body>
<h1><%=r.getString(teasession._nLanguage,"步骤 1（共 3 步）：创建导入文件")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<form name=form1 METHOD=get action="/jsp/admin/sales/import2.jsp" >
  <input type=hidden name="community" value="<%=community%>"/>
  <input type=hidden name="nexturl" value="<%=nexturl%>"/>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>大多数应用程序（包括 Goldmine、Palm Desktop、Microsoft Excel、Microsoft Access 和 FileMaker）允许将联系人数据导出为以逗号为分隔符的文本文件 (.csv)。要为贵组织的客户和联系人数据创建导入文件：</td>
    </tr>
    <tr>
      <td>1. 	将全部联系人信息导出并合并为一个 csv 文件。</td>
    </tr>
    <tr>
      <td>2. 	使用 Microsoft Excel 或类似产品以适当的字段名标记文件各列。</td>
    </tr>
    <tr>
      <td>3. 	用标记为“记录所有人”的特殊列，为每个联系人和客户记录指定所有人。</td>
    </tr>
    <tr>
      <td>4. 	将电子表格导出到一个 csv 文件。</td>
    </tr>
    <tr>
      <td>5. 	一旦创建 csv 文件后，单击“下一步”按钮。</td>
    </tr>
  </table>
  <input type="submit" value="<%=r.getString(teasession._nLanguage,"下一步")%>" >
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


