<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.yl.shop.*"%>
<%@page import="tea.entity.sup.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.sub.*"%>
<%@page import="tea.entity.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
/*
String act=h.get("act");
if("action".equals(act))
{
  out.print("oper");
  return;
}*/
StringBuffer sql=new StringBuffer(),par=new StringBuffer();


int menuid=h.getInt("id");
par.append("?community="+h.community+"&id="+menuid);
/*
String name = h.get("name");
if(!"".equals(name) && name != null){
	sql.append(" AND name like'%" + name + "%'");
	par.append("&name="+name);
}
*/

sql.append(" AND member="+h.member);
par.append("&member="+h.member);

int pos=h.getInt("pos");
par.append("&pos=");

int sum=ShopMyPoints.count(sql.toString());
String acts=h.get("acts","");

%>
<!doctype html>
<html>
<head>
<!-- <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
 --><script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
	  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}

</script>
</head>
<body>
<!-- <h1>我的积分</h1>
 --><!-- <div id="head6"><img height="6" src="about:blank"></div>
 -->
<div class="results">
<form name="form1" action="?" style="display:none">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
	<tr>
  	</tr>
  	<tr>
  		<td colspan="4" align="center"><input type="submit" value="查询"/></td>
	</tr>
</table>
</form>
<script>
sup.hquery();
</script>

<form name="form2" action="/ShopMyPointss.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>时间</td>
  <td>积分</td>
  <td>订单</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='6' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=ShopMyPoints.find(sql.toString(),pos,15).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    ShopMyPoints sh=(ShopMyPoints)it.next();
  %>
  <tr>
    <td align="center"><%=i%></td>
    <td><%=MT.f(sh.getCreateTime())%></a></td>
    <td><%=sh.getIntegral()%></a></td>
    <td><%=MT.f(sh.getOrderId())%></a></td>
    <td nowrap><%
      out.println("<a href=javascript:mt.act('del',"+sh.getId()+")>删除</a>");
    %></td>
  </tr>
  <%
  }
  if(sum>15)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,15));
}%>
</table>
</div></form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.id.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='view')
      form2.action='';
    else if(a=='edit')
      form2.action='/jsp/yl/shop/ShopHospitalsEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
mt.fit();
</script>
</body>
</html>
