<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&id="+menu);

sql.append(" AND isDelete=0");
par.append("&isDelete=0");

String member=h.get("member","");
if(member.length()>0)
{
  sql.append(" AND m.member LIKE "+Database.cite("%"+member+"%"));
  par.append("&member="+h.enc(member));
}

int isReply = h.getInt("isReply");
if(isReply>0){
	if(isReply==1){
		sql.append(" AND replyMember<1");
		par.append("&isReply=1");
	}else if(isReply==2){
		sql.append(" AND replyMember>0");
		par.append("&isReply=2");
	}
	
}

int sum=ShopAdvisory.count(sql.toString());

int pos=h.getInt("pos");
par.append("&pos=");

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>咨询管理</h1>

<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<div class='radiusBox'>
<table id="tdbor" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='5' class='bornone'>搜索</td></tr>
</thead>
<tr>
  <td width="20%">用户名:<input name="member" value="<%=MT.f(member)%>"/></td>
  <td width="15%">状态:<select name="isReply"><option value="0">全部状态</option><option value="1" <%=isReply==1?"selected":""%> >未回复</option><option value="2" <%=isReply==2?"selected":"" %> >已回复</option></select></td>
  <td class='bornone'><button class="btn btn-default" type="submit">查询</button></td>
</tr>
</table>
</div>
</form>
<form name="form2" action="/ShopAdvisorys.do" method="post" target="_ajax">
<input type="hidden" name="advisoryId"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<div class='radiusBox mt15'>
<table id="" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='10'>列表 <%=sum%></td></tr>
</thead>
<tr>
  <th width='60'>序号</th>
  <th>商品</th>
  <th>用户名</th>
  <th>咨询内容</th>
  <th>回复人</th>
  <th>回复内容</th>
  <th>状态</th>
  <th>创建时间</th>
  <th>回复时间</th>
  <th>操作</th>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' class='noCont'>暂无记录!</td></tr>");
}else
{
  Iterator it=ShopAdvisory.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
	  ShopAdvisory t=(ShopAdvisory)it.next();
      int id=t.getId();
      String uname = MT.f(Profile.find(t.getMember()).member);
      String replayuname = MT.f(Profile.find(t.getReplyMember()).member);
      String state = t.getReplyMember()>0?"已回复":"<a href='###' onclick=f_act('reply',"+id+")>未回复</a>";
  %>
  <tr>
    <td><%=i%></td>
    <td><%=ShopProduct.find(t.getProduct_id()).getAnchor(h.language)%></td>
    <td><%=uname%></td>
    <td><%=t.getDepict()!=null&&t.getDepict().length()>0?MT.f(t.getDepict().replaceAll("&nbsp;",""),20):""%></td>
    <td><%=replayuname%></td>
    <td><%=t.getReplycont()!=null&&t.getReplycont().length()>0?MT.f(t.getReplycont().replaceAll("&nbsp;",""),20):""%></td>
    <td><%=state%></td>
    <td><%=MT.f(t.getCreatedate(),1)%></td>
    <td><%=MT.f(t.getReplyTime(),1)%></td>
    <td>
    	<button type="button" class="btn btn-link" onclick="f_act('reply',<%=id%>)">回复</button>
    	<button type="button" class="btn btn-link" onclick="f_act('del',<%=id%>)">删除</button>
    </td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
</div>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
function f_act(a,id)
{
  form2.act.value=a;
  form2.advisoryId.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='reply')
  {
    form2.action='/jsp/yl/shop/ShopAdvisoryReply.jsp';form2.target='_self';form2.method='get';form2.submit();
  }
}
</script>
</body>
</html>
