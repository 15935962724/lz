<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="tea.entity.node.Book"%>
<%@page import="tea.entity.node.Node"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.sup.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.admin.*"%>
<script src="/tea/mt.js" type="text/javascript"></script><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}
String act=h.get("act","");
StringBuffer sql=new StringBuffer(),par=new StringBuffer();
int menuid=h.getInt("id");
par.append("?id="+menuid);
sql.append(" AND n.type=12 and hidden=0 AND finished=1");
String text = h.get("subject","");
if (text.length()>0) {
	sql.append(" AND nl.subject like "
			+ DbAdapter.cite("%" + text + "%"));
	par.append("&subject=" + text);
}
String subtitle = h.get("subtitle","");
if (subtitle.length()>0) {
	sql.append(" AND bl.subtitle like "
			+ DbAdapter.cite("%" + subtitle + "%"));
	par.append("&subtitle=" + subtitle);
}
int pos=h.getInt("pos");
par.append("&pos=");
if("POST".equals(request.getMethod())){
	int node=h.getInt("node", 0);
	Node n=Node.find(node);
	if("del".equals(act)){
		n.delete(h.language);
		out.print("<script>mt.show('图书删除成功！')</script>");
	}
	if("recommended".equals(act)){
		
		n.set("recommended", String.valueOf(n.getRecommended()==0?1:0));
	}
}
int count =Node.count(sql.toString());


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>

<script src="/tea/city.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
</head>
<body>
<h1>图书列表</h1><!--列表-->
<div id="head6"><img height="6" src="about:blank"></div>

<!-- <h2>查询</h2> -->
<form name="form1" action="?" style="display:none">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="pos" value="<%=pos%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">书名：</td><td><input name="subject" value=""/></td>
  <td class="th">作者：</td><td><input name="subtitle" value=""/></td>
  <td class="th">价格：</td><td><input name="name" value=""/></td>
</tr>
<tr>
 
  <td class="th">ISBN：</td><td><input name="org" value=""/></td>
  <td class="th">分类：</td><td><input name="org" value=""/></td>
<%
out.print("<td class='th'></td><td><input type='submit' value='查询' />");
/* if(isMy)
	out.print("<td class='th'></td><td><input type='submit' value='查询' />");
else
out.print("<td class='th'>所属单位：</td><td><select name='qdept'>"+SupSupplier.options(qdept)+"</select>　　<input type='submit' value='查询' /></td>"); */
%>
</tr>
</table>
</form>
<script>
sup.hquery();
</script>

<h2>列表&nbsp;（<%=count%>） </h2>
<form name="form2" action="?" method="post" >
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="pos" value="<%=pos%>"/>
<input type="hidden" name="node"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<%-- <%
out.print("<div class='switch'>");
for(int i=0;i<TAB.length;i++)
{ 
  out.print("<a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"（"+SupExpert.count(sql.toString()+SQL[i])+"）</a>");
}
out.print("</div>");
%> --%>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td></td>
  <td>序号</td>
  <td nowrap style="padding-left:0px;padding-right:0px;">&nbsp;ISBN&nbsp;</td>
  <td nowrap style="padding-left:0px;padding-right:0px;">&nbsp;书名&nbsp;</td>
  <td nowrap style="padding-left:0px;padding-right:0px;">&nbsp;作者&nbsp;</td>
  <td nowrap style="padding-left:0px;padding-right:0px;">&nbsp;价格(元)&nbsp;</td>
  <td nowrap style="padding-left:0px;padding-right:0px;">&nbsp;出版社&nbsp;</td>
  <td nowrap style="padding-left:0px;padding-right:0px;">&nbsp;出版日期&nbsp;</td>
  <td nowrap style="padding-left:0px;padding-right:0px;">&nbsp;分类&nbsp;</td>
  <td nowrap style="padding-left:0px;padding-right:0px;">操作</td>
</tr>
<%
//sql.append(SQL[tab]);

int sum=Node.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='20' align='center'>暂无记录!</td></tr>");
}else
{
	sql.append(" order by time desc");
  Enumeration e=Node.find(sql.toString(),pos,20);
  for(int i=1+pos;e.hasMoreElements();i++)
  {
	  int node=(Integer)e.nextElement();
	  Node n=Node.find(node);
      Book b=Book.find(n._nNode);
  %>
  <tr>
    <td align="center"><input type="checkbox" name="experts" value=""/></td>
    <td align="center"><%=i %></td>
    <td align="center"><%=b.getISBN()%></td>
    <td align="center"><%=n.getSubject(h.language)%><%=n.getRecommended()==1?"<font color='red'>[推荐]</font>":"" %></td>
    <td align="center"><%=b.getSubTitle(h.language)%></td>
    <td align="center"><%=MT.f(b.getPrice().doubleValue(),2)%></td>
    <td align="center"><%=b.getPublisher(h.language)%></td>
    <td align="center"><%=MT.f(b.getPublishDate())%></td>
    <td align="center"><%=SupQualification.find(b.getType()).getName(1) %></td>
    
    <td nowrap>
    <%
    //<a href='###' onMouseOver='mt.more(this)'>操作</a><div style='display:none'>
    //out.println("<a href=javascript:mt.act('view',"+t.expert+")>查看</a>");
    String msg=n.getRecommended()==1?"取消推荐":"推荐";
    out.println("<a href=javascript:mt.act('recommended',"+node+")>"+msg+"</a>");
    out.println("<a href=javascript:mt.act('edit',"+node+")>编辑</a>");
    out.println("<a href=javascript:mt.act('del',"+node+")>删除</a>");
    //</div>
    %>
    </td>
  </tr>
  <%
  }
  out.print("<tr><td><input type='checkbox' onclick='mt.select(form2.experts,checked)' id='sel'/><label for='sel'>全选</label>");
  out.print("<td colspan='20' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<!-- <input type="button" value="移动" name="multi" onClick="mt.act('move','0')"/> -->
<input type="button" value="添加" onClick="mt.act('edit',14010055)"/>
<!-- <input type="button" value="导出" onClick="form3.submit()"/> -->
</form>

<form name="form3" action="/SupExports.do/专家管理列表.xls" method="post">
<input type="hidden" name="act" value="export" />
<input type="hidden" name="key" value="<%=MT.enc(sql.toString())%>"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id)
{
	form2.node.value=id;
  form2.act.value=a;
  form2.nexturl.value="/jsp/book/BookList.jsp";
  if(a=='del')
  {
    mt.show('您确定要删除吗？',2,'form2.submit()');
    return;
  }
  if(a=='edit'){
	  form2.action='/jsp/book/EditBook.jsp'; 
  }
  if(a=='recommended'){
	  form2.submit();
	  return;
  }
  form2.target=form2.method='';
  form2.submit();
};
mt.receive=function(a,b)
{
  form2.type.value=a;
  form2.dept.value=b;
  form2.submit();
};

setFreeze(document.getElementsByTagName('TABLE')[1],0,1);
</script>
</body>
</html>
