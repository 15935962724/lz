<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
int category=h.getInt("category");
sql.append(" AND category="+category);
par.append("&category="+category);

String model=h.get("model","");
if(model.length()>0)
{
  sql.append(" AND model liek"+Database.cite("%"+model+"%"));
  par.append("&model="+h.enc(model));
}

int pos=h.getInt("pos");
int sum=ShopProductModel.count(sql.toString());
par.append("&pos=");

String nexturl = h.get("nexturl");

ShopCategory c=ShopCategory.find(category);

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1><%=c.name[h.language]%></h1>
<form name="form1" action="/ShopCategorys.do" method="post" target="_ajax">
<input type="hidden" name="category" value="<%=category%>"/>
<input type="hidden" name="nexturl" value="/jsp/yl/shop/ShopProductModels.jsp?category=<%=category%>&nexturl=<%=nexturl%>"/>
<input type="hidden" name="act" value="setAttribute"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td width="10%">属性名称</td>
    <td width="30%"><input name="attribute" alt="属性名称" value="<%=MT.f(c.attribute)%>"/><span style="color:red;">&nbsp;&nbsp;如：粒子活度</span></td>
    <td><button class="btn btn-primary" type="submit">提交</button>&nbsp;&nbsp;<button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button></td>
  </tr>
</table>
<br/>

</form>

<%
if(MT.f(c.attribute)!=null&&MT.f(c.attribute).length()>0)
{
%>

<form name="form2" action="/ShopProductModels.do" method="post" target="_ajax">
<input type="hidden" name="category" value="<%=category%>"/>
<input type="hidden" name="modelId"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td width="15"><input type="checkbox" onclick="mt.select(form2.modelIds,checked)"/></td>
  <td>规格/型号</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=ShopProductModel.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    ShopProductModel t=(ShopProductModel)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><input type="checkbox" name="modelIds" value="<%=t.getId()%>"/></td>
    <td><%=t.getModel()%></td>
    <td>
    	<button type="button" class="btn btn-link" onclick="f_act('edit',<%=t.getId()%>)">编辑</button>
    	<button type="button" class="btn btn-link" onclick="f_act('del',<%=t.getId()%>)">删除</button>
    </td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<button class="btn btn-primary" type="button" name="multi" onclick="f_act('del',0)">批量删除</button>&nbsp;&nbsp;&nbsp;&nbsp;
<button class="btn btn-primary" type="button" onclick="f_act('edit',0)">添加</button>&nbsp;&nbsp;&nbsp;&nbsp;
</form>
<%
}
%>
<script>
mt.disabled(form2.modelIds);
form2.nexturl.value=location.pathname+location.search;
function f_act(a,id,b)
{
  form2.act.value=a;
  form2.modelId.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='edit')
  {
    form2.action='/jsp/yl/shop/ShopProductModelEdit.jsp';form2.target='_self';form2.method='get';form2.submit();
  }
}
</script>
</body>
</html>
