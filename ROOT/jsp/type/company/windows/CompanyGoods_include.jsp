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

Node obj=Node.find(teasession._nNode);
if(obj.getType()==34)//如果当前节点是产品，则找到产品所对应的公司
{
	Goods g=Goods.find(teasession._nNode);
	teasession._nNode=g.getCompany();
//	obj=Node.find(teasession._nNode);
}

tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Company");



%><html>
<head>

<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body  id="companysrhbody" >
<table border="0" cellpadding="0" cellspacing="0">
<%
Enumeration e=Goods.findByCompany(teasession._nNode);
for(int i=0;i<10&&e.hasMoreElements();i++)
{
	  int id=((Integer)e.nextElement()).intValue();
	  Node n=Node.find(id);
	  Goods g=Goods.find(id,teasession._nLanguage);
	  if(i%4==0)out.print("</tr><tr>");
  %>
  <td valign="top">
<table border="0" cellpadding="0" cellspacing="0" id="goodslist"><tr><td id="goodssmallpicturespan"><a href="/servlet/Node?node=<%=id%>"><img onerror="if(this.src.indexOf('goods_no_photo.jpg')==-1)this.src='/tea/image/eyp/goods_no_photo.jpg';" id=goodssmallpicture src="<%=g.getSmallpicture()%>"></a></td></tr><tr><td id="goodsname"><a href="/servlet/Node?node=<%=id%>"><%=n.getSubject(teasession._nLanguage)%></a></td></tr></table>	  
  </td>
<%
}%>
</table>
<script>
var gsp=document.all('goodssmallpicture');
if(gsp)
{
    if(!gsp.length)gsp=new Array(gsp);
	for(var i=0;i<gsp.length;i++)
	{
		if(gsp[i].width>gsp[i].height)
		{
		   gsp[i].width=80;
		}else
		{
		   gsp[i].height=80;
		}
	}
}
</script>
</body>
</html>
