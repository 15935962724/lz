<%@page import="tea.entity.member.Profile"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&id="+menu);

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND realname LIKE "+Database.cite("%"+name+"%")+" ");
  par.append("&name="+h.enc(name));
}

int state=Integer.parseInt(h.get("state","-1"));

if(state!=-1)
{
  sql.append(" AND status = "+state);
  par.append("&state="+state);
}

sql.append(" AND p.deleted = 0 ");

int sum=ShopQualification.count(sql.toString());

int pos=h.getInt("pos");
par.append("&pos=");


%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>资质审核</h1>


<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<div class='radiusBox'>
<table id="tdbor" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='3' class='bornone'>查询</td></tr>
</thead>
<tr>
  <td>申请人姓名:<input name="name" value="<%=MT.f(name)%>"/></td>
  <td>审核状态:
  <select name="state">
  	<option value="-1" >全部</option>
  	<%
	  	for(int i=1;i<ShopQualification.STATUS_ARR.length;i++){
			out.print("<option value='"+i+"' "+(i==state?"selected='selected'":"")+" >"+ShopQualification.STATUS_ARR[i]+"</option>");
		}
  	%>
  </select>
  </td>
  <td class='bornone'><input type="submit" class="btn btn-primary" value="查询"/></td>
</tr>
</table>
</div>
</form>
<form name="form2" action="/ShopBrands.do" method="post" target="_ajax">
<input type="hidden" name="brand"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="lang"/>
<div class='radiusBox mt15'>
<table cellspacing="0" class='newTable'>
<thead><tr><td colspan='7'>列表 <%=sum%></td></tr></thead>
<tr>
  <th>序号</th>
  <th>申请人姓名</th>
  <th>申请用户</th>
  <th>所属医院</th>
  <th>到期时间</th>
  <th>状态</th>
  <th>操作</th>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' class='noCont'>暂无记录!</td></tr>");
}else
{
  Iterator it=ShopQualification.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
	  ShopQualification t=(ShopQualification)it.next();
  %>
  <tr>
    <td><%=i%></td>
    <td><%= MT.f(t.realname) %></td>
    <td><%=MT.f(Profile.find(t.member).member)%></td>
    <td><%=MT.f(ShopHospital.find(t.hospital_id).getName())%></td>
    <td><%= MT.f(Profile.find(t.member).validity) %></td>
    <td><%= ShopQualification.STATUS_ARR[t.status]  %></td>
    <td>
    <button type='button' class='btn btn-link' onclick='showqua(<%= t.id %>)'>查看详情</button>&nbsp;
    <%
    	if(t.status==1||t.status==5)
    	{
    		out.print("<button type='button' class='btn btn-link' onclick='showreturn("+t.id+")'>审核</button>&nbsp;");
    		//out.print("<a href='javascript:void(0);' onclick=showreturn("+ t.id +") >审核</a>&nbsp;");
    	}else if(t.status==3||t.status==6)
    	{
    		out.print("<button type='button' class='btn btn-link' onclick=mt.show(nextSibling.value)>退回原因</button><textarea style='display:none'>"+MT.f(t.returnv,"没有填写原因！").replaceAll("\r\n","<br/>")+"</textarea>");
    		//out.print("<a href='javascript:void(0);' onclick=mt.show(nextSibling.value)>退回原因</a><textarea style='display:none'>"+MT.f(t.returnv,"没有填写原因！").replaceAll("\r\n","<br/>")+"</textarea>");
    	}
    	if(t.status==2||t.status==4)
    	{
    		out.print("<button type='button' class='btn btn-link' onclick=updatetime("+ t.id +")>修改有效期</button>&nbsp;");
    		//out.print("<a href='javascript:void(0);' onclick=updatetime("+ t.id +") >修改有效期</a>&nbsp;");
    	}
    %>
    </td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
</div>
<div class='mt15'><input type="button" class="btn btn-primary" value="添加用户" onclick="addqua()"/></div>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
function f_act(a,id,b)
{
  /* form2.act.value=a;
  form2.brand.value=id;
  form2.lang.value=b;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='edit')
  {
    form2.action='/jsp/yl/shop/ShopBrandEdit.jsp';form2.target='_self';form2.method='get';form2.submit();
  } */
}
function showqua(num){
	mt.show("/jsp/yl/shop/ShowShopQualification.jsp?qid="+num,2,"资质详情",500,300);
}
function showreturn(num){
	location = "/jsp/yl/shop/ShowShopQualificationReturn.jsp?nexturl="+form2.nexturl.value+"&qid="+num;
	//mt.show("/jsp/yl/shop/ShowShopQualificationReturn.jsp?nexturl="+form2.nexturl.value+"&qid="+num,2,"审核",500,200);
}
function updatetime(num){
	location = "/jsp/yl/shop/ShowShopQualificationReturn.jsp?type=1&nexturl="+form2.nexturl.value+"&qid="+num;
	//mt.show("/jsp/yl/shop/ShowShopQualificationReturn.jsp?type=1&nexturl="+form2.nexturl.value+"&qid="+num,2,"修改有效期",500,200);
}
function addqua(){
	location = '/jsp/yl/shop/AddShopQualification.jsp?nexturl='+form2.nexturl.value;
}
</script>
</body>
</html>
