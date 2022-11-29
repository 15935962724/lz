<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="java.util.Date"%>

<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}


String nexturl = teasession.getParameter("nexturl");

StringBuffer sql = new StringBuffer(" and node = "+teasession._nNode);
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession._strCommunity);
param.append("&node=").append(teasession._nNode);

int pos = 0, pageSize = 20, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = PerformStreak.count(teasession._strCommunity,sql.toString());


tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);
sql.append(" order by times desc ");
%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>演出管理--场次设置</title>
</head>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<script>
//基本信息
function f_Add(igd)
{
  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:557px;dialogHeight:457px;';
  var url = '/jsp/type/perform/EditPerformStreak.jsp?community='+form1.community.value+"&node="+form1.node.value+"&psid="+igd;
  var rs = window.showModalDialog(url,self,y);
  if(rs==1)
  {
   // window.open(location.href+"&t="+new Date().getTime(),window.name);
    window.open('/jsp/type/perform/PerformStreak.jsp?community='+form1.community.value+'&node='+form1.node.value,'_self ');
  }
}
//价格设置
function f_Price(igd)
{
	window.open('/jsp/type/perform/Priceindex.jsp?psid='+igd+'&community='+form1.community.value,'_blank');
}
//设置票种
function f_setVote(igd)
{
  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:757px;dialogHeight:605px;';
  var url = '/jsp/type/perform/EditVote.jsp?community='+form1.community.value+"&node="+form1.node.value+"&psid="+igd;
  var rs = window.showModalDialog(url,self,y);
  if(rs==1)
  {
    //window.open(location.href+"&t="+new Date().getTime(),window.name);
    window.open('/jsp/type/perform/PerformStreak.jsp?community='+form1.community.value+'&node='+form1.node.value,'_self ');
  }
}
/*
//打折设置
function f_setDiscoun(igd)
{
  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:757px;dialogHeight:605px;';
  var url = '/jsp/type/perform/EditDiscoun.jsp?community='+form1.community.value+"&node="+form1.node.value+"&psid="+igd;
  var rs = window.showModalDialog(url,self,y);
  if(rs==1)
  {
    window.open(location.href+"&t="+new Date().getTime(),window.name);
  }
}
*/

//删除
function f_delete(igd)
{
	form1.psid.value=igd;
	form1.act.value='delete';
	form1.nexturl.value=location.pathname+location.search;
	form1.action='/jsp/type/perform/EditPerformStreak.jsp';
	form1.submit();
}
</script>
<body id="bodynone"  >

<h1>演出管理--场次设置</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1">
  <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
  <input type="hidden" name="act">
  <input type="hidden" name="node" value="<%=teasession.getParameter("node") %>" >
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="psid">


  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap >序号</td>
      <TD nowrap>场次名称</TD>
      <TD nowrap>演出场馆</TD>
      <TD nowrap>演出时间</TD>
      <TD nowrap>开始出票时间</TD>
      <TD nowrap>结束出票时间</TD>
      <TD nowrap>结束退票时间</TD>
      <TD nowrap>网上订票开始</TD>
      <TD nowrap>网上订票结束</TD>
      <TD nowrap>操作</TD>
    </tr>
    <%

    java.util.Enumeration  e = PerformStreak.find(teasession._strCommunity,sql.toString(),pos,pageSize);
    if(!e.hasMoreElements())
    {
      out.print("<tr><td colspan=10 align=center>暂无演出信息</td></tr>");
    }

    for(int i =1;e.hasMoreElements();i++)
    {
      int psid =((Integer)e.nextElement()).intValue();
      PerformStreak psobj = PerformStreak.find(psid);
      Node nobj = Node.find(psobj.getVenues());

            // hobj.setQuantity(hobj.getQuantity()+1);
      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td width="1"><%=i+pos %></td>
        <td nowrap><a href="#" onclick="f_Add('<%=psid %>');" ><%=psobj.getPsname()%></a></td>
        <td nowrap><%=nobj.getSubject(teasession._nLanguage) %></td>
        <td nowrap><%=psobj.getPftimeToString() %></td>
		<td nowrap><%=psobj.getStardrawtimeToString() %></td>
        <td nowrap><%=psobj.getEnddrawtimeToString() %></td>
		<td nowrap><%=psobj.getEndbouncetimeToString() %></td>
		<td nowrap><%=psobj.getStartonlinetimeToString() %></td>
	    <td nowrap><%=psobj.getEndonlinetimeToString() %></td>
        <td nowrap>
		<a href="#"  onclick="f_Add('<%=psid %>');">基本信息</a>
		<a href="#"  onclick="f_Price('<%=psid %>');">价格设置</a>
		<a href="#"  onclick="f_setVote('<%=psid %>');">票种设置</a>
		<!-- <a href="#"  onclick="f_setDiscoun('<%=psid %>');">打折设置</a> -->
		<a href="#"  onclick="f_delete('<%=psid %>');">删除</a>

        </td>
      </tr>
      <%} %>
      <%if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>
<br>
  <input type="button" value="添加场次" onclick="f_Add('0');"/>&nbsp;
  <input type=button value="返回" onClick="javascript:history.back()">
  </form>


  <div id="head6"><img height="6" src="about:blank"></div>
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>
</html>
