<%@page import="tea.entity.yl.shop.ShopProduct_data_list"%>
<%@page import="tea.entity.order.Order"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="tea.entity.node.Book"%>
<%@page import="tea.entity.node.Node"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.sup.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.admin.*"%><%

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
int data_id=h.getInt("sid");
int product=h.getInt("product");
sql.append(" and data_id="+data_id);
int pos=h.getInt("pos");
par.append("&pos=");
int size=20;

String title=h.get("title","");
if(title.length()>0)
{
  sql.append(" and title like "+DbAdapter.cite("%"+title+"%"));
  par.append("&title="+h.enc(title));
}
int count=ShopProduct_data_list.count(sql.toString());

String nexturl = h.get("nexturl");
nexturl += "&product="+product;
%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>

</head>
<body>
<h1>详情相关</h1><!--列表-->
<div id="head6"></div>
<!-- <h2> <button class="btn btn-primary" type="button" onclick="mt.act('edit',0)">创建</button></h2> -->

<form name="form2" action="/ShopProductDatalists.do" metdod="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl %>"/>
<input type="hidden" name="act"/>
<input type="hidden" name="data_id" value="<%=data_id%>"/>
<input type="hidden" name="sid"/>

<input type="hidden" name="id" value=<%=menuid %>/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
<td align="center"></td>
  <td align="center">序号</td>
  <td align="center">详情logo</td>
  <td align="center">详情附件</td>
  <td align="center">详情标题</td>
  <td align="center">移动</td>
  <td align="center">操作</td>
</tr>
<%

if(count<1)
{
  out.print("<tr><td colspan='20' align='center'>暂无记录!</td></tr>");
}else
{
	sql.append(" order by sort asc");
  ArrayList list = ShopProduct_data_list.find(sql.toString(),pos,size);
	for (int i = 0; i<list.size(); i++) {
		ShopProduct_data_list sdl = (ShopProduct_data_list)list.get(i);
  %>
  <tr>
    <td><input type="checkbox" name="sids" value="<%=sdl.id%>"/></td>
    <td align="center"><%=pos+i+1 %></td>
    <td align="center"><img width="40px" height="40px" src="<%=sdl.logo>0?Attch.find(sdl.logo).path:"/tea/mt/blank.gif"%>" onerror="javascript:this.src='/tea/image/404.jpg'"></img></td>
    <td align="center"><%if(sdl.attch != 0){ out.print("<a href="+Attch.find(sdl.attch).path+"  target=_blank>"+Attch.find(sdl.attch).name+"</a>");%><%} %></td>
		<td align="center"><%=sdl.title %></td>
		<td align="center"><img name="sequence" src="/tea/mt/move.gif" id="<%=sdl.id%>" value="<%=sdl.sort%>"/></td>
		<td align="center">
		<button type="button" class="btn btn-link" onclick=mt.act('edit',"<%=sdl.id %>")>编辑</button>
		<button type="button" class="btn btn-link" onclick=mt.act('del',"<%=sdl.id %>")>删除</button>
		</td>
  </tr>
  <%
  }
  if(count>size)out.print("<td colspan='20' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, count,size));
}%>
</table>
<div class="center mt15">
<button class="btn btn-primary" type="button" onclick="mt.act('edit',0)">添 加</button>&nbsp;&nbsp;&nbsp;&nbsp;
<button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button>
</div>
</form>
<script>

mt.sequence(form2.sids,<%=pos%>);
mt.act=function(a,id){
	form2.nexturl.value=location.pathname+location.search;
	form2.act.value=a;
	form2.sid.value=id;
	if(a=="del"){
		mt.show('你确定要删除吗？',2,'form2.submit()');
		return;
	}else if(a=='edit'){
		form2.action=("/jsp/yl/shop/ShopProduct_data_listEdit.jsp");
	}
	form2.target='_self';form2.method='get';form2.submit();
}

setFreeze(document.getElementsByTagName('TABLE')[1],0,1);
</script>
</body>
</html>
