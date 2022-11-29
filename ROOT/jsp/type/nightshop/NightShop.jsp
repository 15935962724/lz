<%@page import="tea.entity.member.WomenOptions"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.Entity"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.node.NightShop"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.ui.TeaSession" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
String community=teasession._strCommunity;
java.util.Date date = new java.util.Date();


if(teasession._rv==null)
{
	out.println("您还没有登录，没有权限查看，请登录");
	return;
}

//获取省市参数
String provinceid="0";
if(request.getParameter("provinceid")!=null){
	provinceid=request.getParameter("provinceid");
}
String cityid="0";
if(request.getParameter("cityid")!=null){
	cityid=request.getParameter("cityid");
}

String album = teasession.getParameter("album");
String nexturl =  request.getRequestURI()+"?"+request.getQueryString();

StringBuffer sql=new StringBuffer(" and n.type =45  and n.community = ").append(DbAdapter.cite(community));
StringBuffer param=new StringBuffer();

param.append("?community="+teasession._strCommunity);
param.append("&id=").append(request.getParameter("id"));
param.append("&album=").append(album);
sql.append(" and exists (select ns.node from NightShop ns where n.node = ns.node)");

String subject = teasession.getParameter("subject");
if(subject!=null && subject.length()>0)
{
	subject = subject.trim();
	sql.append(" and exists(select nl.node from NodeLayer nl where n.node = nl.node and nl.subject like "+DbAdapter.cite("%"+subject+"%")+")");
	param.append("&subject=").append(URLEncoder.encode(subject,"UTF-8"));
}

int pos=0,size = 20;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);


int count = Node.count(sql.toString(),provinceid,cityid," NightShop ");

sql.append(" order by n.time desc ");

%>
<html>
<HEAD>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<link href="/tea/CssJs/Home.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</HEAD>
<body>
<script type="text/javascript">
function f_delete(igd)
{
  if(confirm('确认删除'))
  {
    sendx("/jsp/admin/edn_ajax.jsp?act=deleteNightShop&node="+igd,
    function(data)
    {
      alert('信息删除成功');
      window.location.reload();
    }
    );
  }
}
</script>
<h1>夜店管理</h1>

<form name="form2" action="?" method="POST">
<input type="hidden" name="id" value="<%=request.getParameter("id") %>">
<input type="hidden" name="album" value="<%=album %>" >
<input id="provinceidhidden" name="provinceid" type="hidden" value="<%=provinceid %>"/>
<input id="cityidhidden" name="cityid" type="hidden" value="<%=cityid %>"/>

<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
<tr>
  <td>夜店名称：<input type="text" name="subject" value="<%=Entity.getNULL(subject)%>"></td>
  <td colspan="10" align="left"><input type="submit" value="查询" /></td>
</tr>
</table>
</form>

<h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="2"><%=count%></font>&nbsp;个夜店&nbsp;)</h2>
<span id ="newnsid" style="display:none"></span>

<form name="form1" action="?" method="GET">

<input type="hidden" name="act" >
<input type="hidden" name="album" value="<%=album %>" >

<input type="hidden" name="node" value="<%=teasession._nNode %>" >




<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
 <tr id="tableonetr">
   <td nowrap>类别</td>
   <td nowrap>夜店名称</td>
   <td nowrap>联系电话</td>
   <td nowrap>创建时间 </td>
   <td nowrap>操作</td>
</tr>
<%
java.util.Enumeration eu = Node.find(sql.toString(),pos,size,provinceid,cityid," NightShop ");
if(!eu.hasMoreElements())
{
  out.print("<tr><td colspan=20 align=center>暂无记录</td></tr>");
}
for(int i=0;eu.hasMoreElements();i++)
{
  int nid = ((Integer)eu.nextElement()).intValue();
  Node nobj = Node.find(nid);
  //NightShop nsobj = NightShop.find(nid,teasession._nLanguage,provinceid,cityid);
  NightShop nsobj = NightShop.find(nid,teasession._nLanguage);
%>
  <tr onMouseOver=bgColor="#BCD1E9" onMouseOut=bgColor="">
    <td nowrap="nowrap"><%
    		 WomenOptions wobj = WomenOptions.find(nsobj.getNstype1(),teasession._nLanguage);
    WomenOptions wobj2 = WomenOptions.find(nsobj.getNstype2(),teasession._nLanguage);
    out.print(Entity.getNULL(wobj.getWoname())+"&nbsp;"+Entity.getNULL(wobj2.getWoname()));
    %></td>
    <td nowrap="nowrap"><a href="/html/nightshop/<%=nid%>-<%=teasession._nLanguage%>.htm" target="_blank"><%=nobj.getSubject(teasession._nLanguage) %></a></td>
    <td nowrap="nowrap"><%=nsobj.getPhone()%></td>
 	<td><%=Entity.getNULL(nobj.getTime()) %></td>
    <td nowrap>
    <%
    if(nsobj.getAlbum()==0)
    {
  		%>
  		<a href="###" onclick="window.open('/jsp/type/album/EditAlbum.jsp?nightshopid=<%=nid%>&NewNode=ON&Type=95&node=<%=album%>&nexturl=<%=nexturl%>','_self');">上传组图</a>&nbsp;
  		<%}else{ %>
  		<a href="###" onclick="window.open('/jsp/type/album/EditAlbum.jsp?nightshopid=<%=nid%>&EditNode=ON&node=<%=nsobj.getAlbum()%>&nexturl=<%=nexturl%>','_self');">修改组图</a>&nbsp;

  		<%} %>
      <a href="###"  onclick="window.open('/jsp/type/nightshop/EditNightShop.jsp?node=<%=nid%>&nexturl=<%=nexturl%>','_self');">编辑</a>&nbsp;
      <a href="###"  onClick="f_delete('<%=nid%>');" >删除</a>&nbsp;
    </td>
  </tr>
<%
}
if(count>size)
{
%>
  <tr><td colspan="20"  align="center" style="padding-right:5px;"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%></td></tr>
<%
}
%>
</table>

<input type="button" id="newbuttonid" value="创建夜店" onclick="window.open('/jsp/general/EditNode.jsp?NewNode=ON&Type=45&node=<%=teasession._nNode%>&nexturl=<%=nexturl%>&provinceid=<%=provinceid%>&cityid=<%=cityid%>','_self')">
</form>

</body>
</html>
