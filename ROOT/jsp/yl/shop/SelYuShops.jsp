<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&menu="+menu);

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND( sname LIKE "+Database.cite("%"+name+"%")+")");
  par.append("&name="+h.enc(name));
}


int pos=h.getInt("pos");
int sum=YuShop.count(sql.toString());
par.append("&pos=");

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<form name="form1" action="/jsp/yl/shop/YuShops.jsp">
<table id="tablecenter" cellspacing="0">
<tr>
  <td>名称:<input name="name" value="<%=name%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<form name="form2" action="/jsp/yl/shop/YuShopEdit.jsp" method="post" target="_ajax">
<input type="hidden" name="sid"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
<td></td>
  <td>序号</td>
  <td>logo</td>
  <td>编号</td>
  <td>中文名称</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=YuShop.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
	  YuShop t=(YuShop)it.next();
    int id=t.sid;
  %>
  <tr>
  <td><input type="radio" name="selche" value="<%= id %>" onclick="selone(this);" /></td>
    <td><%=i%></td>
    <td><img id="view" width="100" src="<%=t.slogo%>" /></td>
    <td><%=MT.f(t.scode)%></td>
    <td><input name="shopname" type="hidden" value="<%=MT.f(t.sname)%>"></input><%=MT.f(t.sname)%></td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new Page(h.language, par.toString(), pos, sum,20));
}%>
<tr>
	<td colspan="5"><input value="提交" type="button" onclick="subform()" /></td>
</tr>
</table>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
function f_act(a,id,b)
{
  form2.act.value=a;
  form2.sid.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='edit')
  {
    form2.action='/jsp/yl/shop/YuShopEdit.jsp';form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='alldel'){
	  if(chedel()){
		  mt.show('你确定要删除吗？',2,'form2.submit()');
	  }else{
		  mt.show('请选择商户！');
	  }
  }
}
var flag = false;
function selall(){
	var af;
	var che = document.getElementsByName("selche");
	for(var i=0;i<che.length;i++){
		if(flag){
			che[i].checked = false;
			af = false;
		}else{
			che[i].checked = true;
			af = true;
		}
	};
	flag = af;
};
function selone(obj){
	if(!obj.checked){
		document.getElementById("selq").checked = false;
		flag = false;
	}
}
function chedel(){
	var che = document.getElementsByName("selche");
	for(var i=0;i<che.length;i++){
		if(che[i].checked){
			return true;
		}
	}
	return false;
}
function subform(){
	var ipt = document.getElementsByName("selche");
	var shopname = document.getElementsByName("shopname");
	for(var i=0;i<ipt.length;i++){
		if(ipt[i].checked){
			parent.form2.shopid.value = ipt[i].value;
			parent.form2.shopname.value = shopname[i].value;
			parent.mt.close();
			return;
		}
	}
	alert("请选择商家");
	return;
}
</script>
</body>
</html>
