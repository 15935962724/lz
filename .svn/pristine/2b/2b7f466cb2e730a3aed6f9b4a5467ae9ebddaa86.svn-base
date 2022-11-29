<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.Http"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.ShopCategory"%>
<%@page import="tea.entity.admin.AdminFunction"%>
<%@page import="tea.entity.yl.shop.ShopProduct_data"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}
String act=h.get("act","");
String nexturl = h.get("nexturl");
if(request.getMethod().equals("POST")){
	if("hidden".equals(act)){
		int sid=h.getInt("sid");
		ShopProduct_data sd = ShopProduct_data.find(sid);
		sd.hidden=(sd.hidden==1?0:1);
		sd.set();
		response.sendRedirect(nexturl);
	}
}
StringBuffer sql=new StringBuffer(),par=new StringBuffer();
int menuid=h.getInt("id");
par.append("?id="+menuid);
ShopCategory root = ShopCategory.getRoot();
int category=root.category;
sql.append(" AND category = "+category);
par.append("&category = "+category);

sql.append(" AND type=0");
par.append("&type=0");

int pos=h.getInt("pos");
par.append("&pos=");
int size=20;

String title=h.get("title","");
if(title.length()>0)
{
  sql.append(" and title like "+DbAdapter.cite("%"+title+"%"));
  par.append("&title="+h.enc(title));
}
int sum=ShopProduct_data.count(sql.toString());

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>

</head>
<body>
<h1><%=AdminFunction.find(menuid).getName(h.language)%></h1><!--列表-->
<div id="head6"></div>

<div class="newbtn"><%-- 列表&nbsp;（<%=count%>） --%><button class="btn btn-primary" type="button" onclick="mt.act('edit',0)">创建</button></div>
<form name="form1" action="?" method="post">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="category" value="<%=category %>"/>
<input type="hidden" name="nexturl" value="<%=nexturl %>"/>
</form>
<form name="form2" action="/ShopProductDatas.do" method="post">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="category" value="<%=category %>"/>
<input type="hidden" name="nexturl" value="<%=nexturl %>"/>
<input type="hidden" name="act"/>
<input type="hidden" name="sid"/>

<input type="hidden" name="id" value=<%=menuid %>/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
<td width="10" align="center"></td>
  <td width="30" align="center">序号</td>
  <!-- <td align="center">详情logo</td> -->
  <td align="center">详情标题</td>
		<td align="center">移动</td>
		<td align="center">操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='20' align='center'>暂无记录!</td></tr>");
}else
{
	sql.append(" order by sort asc");
  ArrayList list = ShopProduct_data.find(sql.toString(),pos,size);
	for (int i = 0; i<list.size(); i++) {
		ShopProduct_data sd = (ShopProduct_data)list.get(i);
  %>
  <tr>
    <td><input type="checkbox" name="sids" value="<%=sd.id%>"/></td>
    <td align="center"><%=pos+i+1 %></td>
    <%-- <td align="center"><img width="40px" height="40px" src="<%=sd.logo>0?Attch.find(sd.logo).path:"/tea/mt/blank.gif"%>" onerror="javascript:this.src='/tea/image/404.jpg'"></img></td> --%>
		<td align="center"><%out.print(sd.hidden==1?"<s>"+sd.title+"</s>":sd.title); %></td>
		<td align="center"><img name="sequence" src="/tea/mt/move.gif" id="<%=sd.id%>" value="<%=sd.sort%>"/></td>
		<td align="center">
		<button type="button" class="btn btn-link" onclick=mt.act('edit',"<%=sd.id %>")>编辑</button>
		<button type="button" class="btn btn-link" onclick=mt.act('del',"<%=sd.id %>")>删除</button>
		<button type="button" class="btn btn-link" onclick=mt.act('hidden',"<%=sd.id %>")><%=sd.hidden==1?"显示":"隐藏" %></button>
		<%-- <%
		if(sd.type==1)out.print("<button type=\"button\" class=\"btn btn-link\" onclick=mt.act('relevant',"+sd.id+")>相关</button>");
		%> --%>
		</td>
  </tr>
  <%
  }
  if(sum>size)out.print("<td colspan='20' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,size));
}%>
</table>
<br/>
<button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button>
</form>
<script>

mt.sequence(form2.sids,<%=pos%>);
mt.act=function(a,id){
	form2.nexturl.value=location.pathname+location.search;
	form2.action='/ShopProductDatas.do';
	form2.target='_ajax';
	form2.act.value=a;
	form2.sid.value=id;
	if(a=="del"){
		mt.show('你确定要删除吗？',2,'form2.submit()');
		return;
	}else if(a=='edit'){
		form2.action=("/jsp/surgiplan/shop/AboutEdit.jsp");
	}else if(a=='relevant'){
		  form2.action='/jsp/yl/shop/ShopProduct_Rlist.jsp';
	}else if(a=='hidden'){
		  form2.action='/jsp/surgiplan/shop/Abouts.jsp';
		  form2.target='_self';form2.method='post';form2.submit();
		  return;
	}
	form2.target='_self';form2.method='get';form2.submit();
}

</script>
</body>
</html>
