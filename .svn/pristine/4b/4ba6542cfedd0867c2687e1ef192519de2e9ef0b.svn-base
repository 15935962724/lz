<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.ui.TeaSession"%>
<%@page import="org.apache.lucene.index.*"%>
<%@page import="org.apache.lucene.search.*"%>
<%@page import="tea.entity.util.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.db.*"%>
<%@page import="org.apache.lucene.queryParser.*" %>
<%@page import="org.apache.lucene.analysis.standard.*" %>
<%@page import="java.util.*"%>
<%@page import="java.net.URLEncoder"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);


tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Company");

Node obj=Node.find(teasession._nNode);
if(obj.getType()==34)//如果当前节点是产品，则找到产品所对应的公司
{
  Goods g=Goods.find(teasession._nNode);
  if(g.getCompany()==0)
  return;
  teasession._nNode=g.getCompany();
  obj=Node.find(teasession._nNode);
}
Company c=Company.find(teasession._nNode);

String pic=c.getPicture(teasession._nLanguage);
if(pic==null||pic.length()<1)
	pic="/tea/image/eyp/company_no_photo.jpg";

String map=c.getMap(teasession._nLanguage);
String eyp=c.getEyp(teasession._nLanguage);

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="text/javascript">
function winopen()
{
  var me = document.form1.comname.value
  window.open('/jsp/profile/loginfo.jsp?companyname='+ me,'anyname','width=500,height=200');
}
</script>
</head>
<body id="companysrhbody" onmousedown="parent.dl_down(event,window);">

<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:10px;">
  <tr>
    <td rowspan="8" align="center" valign="top" style="width:130px;"><span id="companybasicphoto"><img src="<%=pic%>" width="120" height="120"></span><br />

    <td colspan="2" valign="top"><b><%=obj.getSubject(teasession._nLanguage)%></b>　<%if(eyp!=null&&eyp.length()>0)out.print("<a href="+eyp+">黄页</a>");%></td>
  </tr>
  <tr>
    <td id="td_001" nowrap="nowrap">地　址:</td>
    <td id="td_002"><%=c.getAddress(teasession._nLanguage)%>　<%if(map!=null&&map.length()>0)out.print("<a href="+map+">地图</a>");%></td>
  </tr>
  <tr>
    <td id="td_001" nowrap="nowrap">联系人:</td>
    <td id="td_002"><%=c.getContact(teasession._nLanguage)%></td>
  </tr>
  <tr>
    <td  id="td_001" nowrap="nowrap">传　真:</td>
    <td id="td_002"><%=c.getFax(teasession._nLanguage)%></td>
  </tr>
  <tr>
    <td id="td_001" nowrap="nowrap">电　话:</td>
    <td id="td_002"><%=c.getTelephone(teasession._nLanguage)%></td>
  </tr>
  <tr>
    <td id="td_001" nowrap="nowrap">E-mail:</td>
    <td id="td_002"><%=c.getEmail(teasession._nLanguage)%></td>
  </tr>
  <tr>
    <td id="td_001" nowrap="nowrap">网　址:</td>
    <td id="td_002"><%="<a href="+c.getWebPage(teasession._nLanguage)+" target=_blank>"+c.getWebPage(teasession._nLanguage)+"</a>"%></td>
  </tr>
</table>

</body>
</html>
