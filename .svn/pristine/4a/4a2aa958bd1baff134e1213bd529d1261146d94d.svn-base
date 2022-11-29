<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menu=h.getInt("id");
par.append("?menu="+menu);



int pos=h.getInt("pos");
int sum=Showimg.count(sql.toString());
par.append("&pos=");
 sql.append("  order by seq "); 

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>首页焦点图</h1>


<h2>列表 <%=sum%></h2>
<form name="form2" action="/Imgs.do" method="post" target="_ajax">
<input type="hidden" name="sid"/>
<input type="hidden" name="product"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>图片</td>
  <td>链接</td>
  <td>顺序</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=Showimg.find(sql.toString(),pos,200).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
	  Showimg t=(Showimg)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%><input type="checkbox" name="imgs" value="<%= t.sid %>" style="display:none"/></td>
    <td><img height='100' src='<%= Attch.find(t.imgid).path %>' /></td>
    <td><%= t.shref %></td>
    <td><img name="sequence" src="/tea/mt/move.gif" /></td>
    <td><input type="button" value="删除" onclick="f_act('delshowimg',<%= t.sid%>)"/></td>
  </tr>
  <%}
  //if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="添加" onclick="f_act('indexshow','0')"/>
</form>

<script>
mt.sequence(form2.imgs);
form2.nexturl.value=location.pathname+location.search;
function f_act(a,id,b)
{
  form2.act.value=a;
  form2.sid.value=id;
  if(a=='delshowimg')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='indexshow')
  {
    mt.show("/jsp/yl/shop/UpdateImg.jsp?nexturl="+form2.nexturl.value,2,"上传图片",300,200);
  }
}
mt.receive=function(v,n,h)
{
  form2.product.value=v;
  form2.submit();
}
</script>
</body>
</html>
