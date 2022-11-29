<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="org.apache.lucene.index.*"%>
<%@ page import="org.apache.lucene.search.*"%>
<%@ page import="tea.entity.util.*"%>
<%@ page import="tea.entity.node.*"%>
<%@ page import="tea.db.*"%>
<%@page import="org.apache.lucene.queryParser.*" %>
<%@page import="org.apache.lucene.analysis.standard.*" %>
<%@ page import="java.util.*"%>
<%@page import="java.net.URLEncoder"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);


tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Company");

Node obj=Node.find(teasession._nNode);
if(obj.getType()==34)//如果当前节点是产品，则找到产品所对应的公司
{
	Goods g=Goods.find(teasession._nNode);
	teasession._nNode=g.getCompany();
	obj=Node.find(teasession._nNode);
}
Company c=Company.find(teasession._nNode);

String pic=c.getPicture(teasession._nLanguage);
if(pic==null||pic.length()<1)
	pic="/tea/image/eyp/company_no_photo.jpg";

%><html>
<head>

<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body  id="companysrhbody" >

<table width="100%" border="0" cellpadding="0" cellspacing="0" style=" margin-top:10px">
  <tr>
    <td rowspan="8" align="center"><span id="companybasicphoto"><img src="<%=pic%>" width="120px" height="120px"></span></td>
    <td colspan="2"><b><%=obj.getSubject(teasession._nLanguage)%></b>　<a href="#">黄页</a></td>
  </tr>
  <tr>
    <td>地址:</td>
    <td><%=c.getAddress(teasession._nLanguage)%>　<a href="#">地图</a></td>
  </tr>
  <tr>
    <td>联系人:</td>
    <td><%=c.getContact(teasession._nLanguage)%></td>
  </tr>
  <tr>
    <td>传真:</td>
    <td><%=c.getFax(teasession._nLanguage)%></td>
  </tr>
  <tr>
    <td>电话:</td>
    <td><%=c.getTelephone(teasession._nLanguage)%></td>
  </tr>
  <tr>
    <td>电子邮箱:</td>
    <td><%=c.getEmail(teasession._nLanguage)%></td>
  </tr>
  <tr>
    <td>网址:</td>
    <td><%=c.getWebPage(teasession._nLanguage)%></td>
  </tr>
    <tr>
    <td colspan="2">浏览统计<%=obj.getClick()%>次　<a href="#">收藏企业</a></td>
  </tr>
</table>
</body>
</html>
