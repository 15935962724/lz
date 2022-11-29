<%@page import="tea.entity.admin.Recommend"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);

int menuid=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");


int pos=h.getInt("pos");
int sum=Recommend.count(sql.toString());
par.append("&pos=");

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>商品展示</h1>



<h2>列表 <%=sum%></h2>
<form name="form2" action="/KeywordsEdit.jsp" method="post" target="_ajax">
<input type="hidden" name="keywords"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>类型名</td>
  <!-- <td>结果数量</td> -->
  <td>显示数量</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  sql.append("");
  Iterator it=Recommend.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
	  Recommend t=(Recommend)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=MT.f(t.name)%></td>
    <td><%=MT.f(t.shownum)%></td>
    <td><a href='javascript:void(0);' onclick="updatenum('<%= t.id%>');">修改数量</a></td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
</form>
<script type="text/javascript">
	function updatenum(sid){
		var nexturl = location.pathname+location.search;
		mt.show("/jsp/yl/shop/RecommendEdit.jsp?nexturl="+nexturl+"&sid="+sid,2,"商品展示",300,100);
	}
</script>
</body>
</html>
