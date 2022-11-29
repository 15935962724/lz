<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.member.*"%>
<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);
String name = teasession._rv._strV;
int node = teasession._nNode;

tea.entity.node.Node obj=tea.entity.node.Node.find(Integer.parseInt(request.getParameter("companyname")));
String companyName = obj.getSubject(teasession._nLanguage);

String myCompany = "";
        InCarteMethod  icm = new InCarteMethod();

%>
<html>
<head>
<script type="text/javascript">

</script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js" type=""></script>
<title>
信息提示页
</title>
</head>
<body bgcolor="#ffffff">
<table align="center"  id="tablecenter">
<% java.util.Enumeration e = icm.findCompanye(name, companyName);
if(!e.hasMoreElements()){
tea.db.DbAdapter db = new tea.db.DbAdapter();
try
{
  db.executeQuery("select rcreator from node where node=" + node);
  while(db.next()){
    myCompany = db.getString(1);
  }
  icm.insertCarte(name, companyName);

}  catch (java.sql.SQLException ex)
{
  ex.getStackTrace();
}finally{
  db.close();
}
%>
<tr>
  <td align="center"><%=name %>　您好：<br />　　您的企业管理中心已收到<br />　　来自【<%=companyName %>】的公司名片！</td>
</tr><%}else{ %>
<tr>
  <td align="center"><%=name %>　您好：<br />　　您的企业管理中心名片库中该公司名片已存在！</td>
</tr><%}
%>
  <tr>
    <td colspan="2" align="center"><input type="button" value="确定" onclick="javascript:window.close()"/></td>
  </tr>
</table>
</body>
</html>
