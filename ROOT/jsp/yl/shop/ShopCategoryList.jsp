<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.admin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

int category=h.getInt("category");

ShopCategory t=ShopCategory.find(category);

int pos=h.getInt("pos");


%><!DOCTYPE html><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>分类管理</h1>

<form name="form2" action="/ShopCategorys.do" method="post" target="_ajax">
<input type="hidden" name="category"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="father" value="<%=category%>"/>
<input type="hidden" name="name1"/>
<input type="hidden" name="name0"/>
<input type="hidden" name="price"/>
<input type="hidden" name="hidden"/>

<%-- <%=t.getAncestor(h.language)%> --%>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td width="15"><input type="checkbox" onclick="mt.select(form2.categorys,checked)"/></td>
  <td>分类名称</td>
  <!-- <td>英文名称</td> -->
  <td>显示/隐藏</td>
  <td>开启/关闭购物车</td>
  <td>移动</td>
  <td>操作</td>
</tr>
<%
boolean isFatherCategory = false;
Iterator it=ShopCategory.find(" AND father="+category+" ORDER BY sequence",0,200).iterator();
if(!it.hasNext())
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  isFatherCategory = true;
  for(int i=1;it.hasNext();i++)
  {
    t=(ShopCategory)it.next();
    
    boolean functionFlag = false;
    boolean switchFlag = false;
    ArrayList scList = ShopCategory.find(" AND father="+t.category+" ORDER BY sequence",0,200);
    if(scList==null||scList.size()==0)
    	functionFlag = true;
    if(t.path.split("[|]").length==4)
    	switchFlag = true;
  %>
  <tr>
    <td><input type="checkbox" name="categorys" value="<%=t.category%>"/></td>
    <td><a href="?category=<%=t.category%>"><%=MT.f(t.name[1])%></a></td>
    <%-- <td><%=MT.f(t.name[0])%></td> --%>
    <td><%=t.hidden?"隐藏":"显示"%></td>
    <td><%=t.offswitch?"关闭":"开启"%></td>
    <td><img name="sequence" src="/tea/mt/move.gif" id="<%=t.category%>" value="<%=t.sequence%>"/>
    <td>
      <%
      out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('edit',"+t.category+")\">编辑</button>");
      if(functionFlag){
    	  out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('ShopCategoryBrand',"+t.category+")\">品牌</button>");
          out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('ShopProductModels',"+t.category+")\">规格/型号</button>");
      }
      out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('ShopProduct_DlistC',"+t.category+")\">类别详情</button>");
      out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('shopswitch',"+t.category+","+t.offswitch+")\">"+(t.offswitch?"开启":"关闭")+"购物车</button>");
      out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('del',"+t.category+")\">删除</button>");
      %>
    </td>
  </tr>
  <%}
}%>
</table>
<div class="center mt15">
<button class="btn btn-primary" type="button" name="multi" onclick="mt.act('del',0)">批量删除</button>&nbsp;&nbsp;&nbsp;&nbsp;
<button class="btn btn-primary" type="button" onclick="mt.act('edit','0','','')">添加</button></div>
</form>


<script>
var t=parent.category_tree;
if(<%=isFatherCategory%>&&t)t.tree(form2.father.value,true);

form2.nexturl.value=location.pathname+location.search;
mt.sequence(form2.categorys,<%=pos%>);
mt.disabled(form2.categorys);
mt.act=function(a,id,n1,n0,pr,hi)
{
  form2.act.value=a;
  form2.category.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='shopswitch')
  {
	  if(n1==0)
	  	mt.show('你确定要“关闭购物”吗？',2,'form2.submit()');
	  else
		mt.show('你确定要“开启购物”吗？',2,'form2.submit()');
  }else if(a=='edit')
  {
    mt.show("/jsp/yl/shop/ShopCategoryEdit.jsp?father="+form2.father.value+"&category="+id,2,"添加/编辑分类",500,220);
  }else
  {
    form2.action=a+'.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>

</body>
</html>
