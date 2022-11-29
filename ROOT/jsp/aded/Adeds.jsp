<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="util.DateUtil"%><%@page import="tea.entity.*"%>
<%@include file="/jsp/Header.jsp"%>
<%
Http h=new Http(request,response);
r.add("/tea/ui/node/aded/Adeds");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js"></script>
<script src="/tea/mt.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBAdeds")%></h1>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id=tableonetr>
<td><%=r.getString(teasession._nLanguage, "Ading")%></td>
<td><%=r.getString(teasession._nLanguage, "AdingNode")%></td>
<td>终端位置</td>
<td><%=r.getString(teasession._nLanguage, "Picture")%></td>
<td>图片尺寸</td>
<td>起始时间</td>
<td>截止时间</td>
<td>剩余天数</td>
<!-- <td><%=r.getString(teasession._nLanguage, "ExpectedImpression")%></td> -->
<td><%=r.getString(teasession._nLanguage, "ClickCount")%></td>
<td><%=r.getString(teasession._nLanguage, "ImpressionCount")%></td>
<td>操作</td>
</tr>
<%
Enumeration e = Aded.find(teasession._nNode, teasession._rv);
while(e.hasMoreElements())
{
  int i = ((Integer)e.nextElement()).intValue();
  Aded aded = Aded.find(i);
  int j = aded.getAding();
  RV rv = aded.getCreator();
  int k = aded.getStatus();
  int l = aded.getExpectedImpression();
  String url=aded.getPicture(teasession._nLanguage);
  AdedCounter adedcounter = AdedCounter.find(i);
  int i1 = adedcounter.getClick();
  int j1 = adedcounter.getImpression();
  Ading ading = Ading.find(j);
  int k1 = ading.getNode();
  int l1 = ading.getStyle();
  String s = ading.getName(teasession._nLanguage);
  String imgSize = ading.getImgSize(teasession._nLanguage);
  %>
<tr class='imgtr'>
  <td><%=s%></td>
  <td><%=Node.find(k1).getAnchor(teasession._nLanguage)%></td>
  <td><%=(ading.status==0?"电脑端":"手机端")%></td>
  <td class='imgtd'><img src="<%=url%>" style="<%=aded.status==1?"":"filter:gray;filter:grayscale(100%)"%>" maxheight="100" maxwidth="100"/></td>
  <td><%=imgSize%></td>
  <td><%=MT.f(aded.getStartTime())%></td>
  <td><%=MT.f(aded.getStopTime()) %></td>
  <td><%=aded.getStartTime()==null?"永远显示":DateUtil.datesub2(aded.getStopTime(),new Date())+"天"%></td>
  <!-- <td><%=Integer.toString(l)%></td> -->

<%
boolean flag = rv._strR.equals(teasession._rv._strR) && rv.isAdManager();
//if(flag || Node.find(k1).isCreator(teasession._rv))
//{
  out.print("<td>"+i1);
  out.print("<td>"+j1);
//}
//if(flag)
//{
  out.println("<td><a href=javascript:; onClick=window.open('/jsp/aded/EditAded.jsp?node="+teasession._nNode+"&aded="+i+"','_self'); >"+r.getString(teasession._nLanguage, "CBEdit")+"</a>");
  out.println("<a href=javascript:; onclick=mt.post('/servlet/EditAded?act=status&status="+(aded.status==1?0:1)+"&aded="+i+"')>"+(aded.status==1?"隐藏":"显示")+"</a>");
  if(h.member == 14100001){
  	out.print("<a href=javascript:; onClick=if(confirm('"+r.getString(teasession._nLanguage, "ConfirmDelete")+"')){window.open('/servlet/DeleteAded?node="+teasession._nNode+"&aded="+i+"','_self');}>"+r.getString(teasession._nLanguage, "CBDelete")+"</a></td></tr>");
  }
  //}
}

%>
</table>

<%
if(teasession._rv.isAdManager())
{

	if(h.member == 14100001){
  		out.println("<input class='btn btn-primary' type='button' value="+r.getString(teasession._nLanguage, "CBNew")+" ID='CBNew' CLASS='CB' onClick=window.open('/jsp/aded/NewAded.jsp?node="+teasession._nNode+"','_self'); />");
	}
}
if(node.isCreator(teasession._rv))
{
  //out.println("<input type='button' value="+r.getString(teasession._nLanguage, "CBRequests")+" ID='CBRequests' CLASS='CB' onClick=window.open('/jsp/request/AdRequests.jsp?node="+teasession._nNode+"','_self'); />");
}
%>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
