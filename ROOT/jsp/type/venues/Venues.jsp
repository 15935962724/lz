
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


String nexturl = request.getRequestURI()+"?"+request.getQueryString();
StringBuffer sql = new StringBuffer(" and type = 92 and hidden = 0 and community= "+DbAdapter.cite(teasession._strCommunity));
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession._strCommunity);

String subject = teasession.getParameter("subject");
if(subject!=null && subject.length()>0)
{
  subject = subject.trim();
  sql.append(" AND node in (SELECT node FROM NodeLayer WHERE subject LIKE "+DbAdapter.cite("%"+subject+"%")+")");
  param.append("&subject = ").append(java.net.URLEncoder.encode(subject,"UTF-8"));
}




int pos = 0, pageSize = 20, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = Node.count(sql.toString());

tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);

sql.append(" order by time desc ");


%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>场馆信息管理</title>
</head>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<body id="bodynone"  >
<script>
function f_edit(igd)
{
  form1.act.value='EditVenues';
  form1.node.value=igd;
  form1.action = '/jsp/type/venues/EditVenues.jsp';
  form1.submit();
}
function f_delete(igd,name)
{
  if(confirm('您确定要删除场馆【'+name+'】的信息吗?'))
  {
    form1.node.value=igd;
    form1.act.value='delete';
    form1.action = '/servlet/EditVenues';
    form1.submit();
  }
}
//设置座位
function f_seat(igd)
{
  window.open('/jsp/type/venues/Seatindex.jsp?nid='+form1.igd+'&community='+form1.community.value,'Seatindex','width=900,height=800,scrollbars=1,top=200,left=200');
}



</script>

<h1>场馆信息管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <h2>查询</h2>
  <form action="/jsp/type/venues/Venues.jsp" name="form2"  method="GET"><!--/servlet/EditDoctor-->
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>


  <input type="hidden" name="id" value="<%=request.getParameter("id")%>" >
  <table border="0" cellpadding="0" cellspacing="0" id="tableSearch">
    <tr>
      <td>场馆名称：　<input type="text" name="subject" value="<%if(subject!=null)out.print(subject);%>"/></td>

      <td><input type="submit" value="" class="SearchInput"/></td>
    </tr>
  </table>

  <h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;个场馆&nbsp;)</h2>
</form>
<form name="form1">
  <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
  <input type="hidden" name="act">
  <input type="hidden" name="node">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>


  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap >序号</td>
      <TD nowrap>场馆名称</TD>
      <TD nowrap>地址</TD>
      <TD nowrap>操作</TD>
    </tr>
    <%

    java.util.Enumeration  e =Node.find(sql.toString(),pos,pageSize);
    if(!e.hasMoreElements())
    {
      out.print("<tr><td colspan=10 align=center>暂无场馆信息</td></tr>");
    }

    for(int i =1;e.hasMoreElements();i++)
    {
      int nid =((Integer)e.nextElement()).intValue();
      Node nobj = Node.find(nid);
      Venues vobj = Venues.find(nid);

      // hobj.setQuantity(hobj.getQuantity()+1);
      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td width="1"><%=i+pos %></td>
        <td><a href="#" ><%=nobj.getSubject(teasession._nLanguage)%></a></td>
        <td><%=vobj.getAddress() %></td>
        <td>
	        <a href="javascript:f_edit('<%=nid%>');">基本信息</a>&nbsp;
	        <a href="#" onClick="window.open('/jsp/type/venues/EditGMap.jsp?community=<%=teasession._strCommunity%>&node=<%=nid%>','_self')">地图标点</a>&nbsp;
	        <a href="/jsp/type/venues/GMapPreview.jsp?community=<%=teasession._strCommunity%>&node=<%=nid%>"  target=_blank>地图预览</a>&nbsp;
	        <a href="/jsp/type/venues/Seatindex.jsp?node=<%=nid %>&community=<%=teasession._strCommunity%>" target="_blank">设置座位</a>&nbsp;
	        <a href="javascript:f_delete('<%=nid%>','<%=nobj.getSubject(teasession._nLanguage)%>');"  >删除</a>&nbsp;

        </td>
      </tr>
      <%} %>
      <%if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>
<br>
  <input type="button" value="" class="CreateInput" onClick="window.open('/jsp/type/venues/EditVenues.jsp?NewNode=ON&node=<%=teasession.getParameter("node") %>&community=<%=teasession._strCommunity%>&nexturl=<%=nexturl%>','_self');"/>
  </form>


  <div id="head6"><img height="6" src="about:blank"></div>
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>
</html>
