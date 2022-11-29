<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.weixin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  out.print("<script>top.location='/servlet/StartLogin?bg=1&node="+h.node+"'</script>");
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menu=h.getInt("id");
par.append("?id="+menu);

//sql.append(" AND community="+DbAdapter.cite(h.community));

String code=h.get("code","");
if(code.length()>0)
{
  sql.append(" AND code LIKE "+DbAdapter.cite("%"+code+"%"));
  par.append("&code="+h.enc(code));
}

int pos=h.getInt("pos");
par.append("&pos=");

int sum=WxCoupon.count(sql.toString());
String acts=h.get("acts","");

%>
<!DOCTYPE html>
<html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>优惠券</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>序列号:<input name="code" value="<%=code%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/WxCoupons.do?repository=wxcoupon" enctype="multipart/form-data" method="post" target="_ajax">
<input type="hidden" name="wxcoupon"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>序列号</td>
  <td>类型</td>
  <td>金额</td>
  <td>结束日期</td>
  <td>领取</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=WxCoupon.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    WxCoupon t=(WxCoupon)it.next();
    WxUser wu=WxUser.find(h.community,t.wxuser);
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=t.code%></td>
    <td><%=t.type%></td>
    <td><%=t.money%></td>
    <td><%=MT.f(t.stoptime,1)%></td>
    <td><a href="/jsp/weixin/WxUserView.jsp?wxuser=<%=wu.wxuser%>"><%=wu.wxuser<1?"--":wu.nickname%></a></td>
    <td><%
    //out.println("<a href=javascript:mt.act('edit',"+t.wxcoupon+")>编辑</a>");
    out.println("<a href=javascript:mt.act('del',"+t.wxcoupon+")>删除</a>");
    %></td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,20));
}%>
</table>
<br/>
<input type="file" name="file" value="导入" onchange="mt.act('imp','0')"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.wxcoupon.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='imp')
  {
    mt.show(null,0);
    form2.submit();
  }else
  {
    if(a=='view')
      form2.action='/WxCouponView.jsp';
    else if(a=='edit')
      form2.action='/jsp/weixin/WxCouponEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
