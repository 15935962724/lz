<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.util.*"%>
<%@page import="tea.entity.weixin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?community="+h.community+"&id="+menuid);


String nickname=h.get("nickname","");
if(nickname.length()>0)
{
  sql.append(" AND wu.nickname LIKE "+DbAdapter.cite("%"+nickname+"%"));
  par.append("&nickname="+Http.enc(nickname));
}

int wxred=h.getInt("wxred");
if(wxred>0)
{
  sql.append(" AND wrg.wxred="+wxred);
  par.append("&wxred="+wxred);
}

int money=h.getInt("money",-1);
if(money!=-1)
{
  sql.append(" AND wrg.money"+(money==0?">":"=")+WxRed.PROBABILITY[money]);
  par.append("&money="+money);
}

Date time0=h.getDate("time0");
if(time0!=null)
{
  sql.append(" AND wrg.time>"+DbAdapter.cite(time0));
  par.append("&time0="+MT.f(time0));
}
Date time1=h.getDate("time1");
if(time1!=null)
{
  sql.append(" AND wrg.time<"+DbAdapter.cite(time1));
  par.append("&time1="+MT.f(time1));
}

int pos=h.getInt("pos");
par.append("&pos=");

int sum=WxRedGrab.count(sql.toString());
String acts=h.get("acts","");

String[] PROBABILITY={"已抢到","　 1","　 2","　 5","　10","　20","　50"};

%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>抢红包管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>红包:<select name="wxred"><option value="0">--</option><%=WxRed.options(" AND community="+DbAdapter.cite(h.community),wxred)%></select></td>
  <td>金额:<select name="money"><option value="-1">--<%=h.options(PROBABILITY,money)%></select>元</td>
  <td>用户:<input name="nickname" value="<%=nickname%>"/></td>
  <td>时间:<input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="date"/> - <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="date"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/WxRedGrabs.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="wxredgrab"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>红包</td>
  <td>用户</td>
  <td>金额</td>
  <td>时间</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  float total=WxRedGrab.sum(sql.toString());
  sql.append(" ORDER BY wrg.time DESC");
  Iterator it=WxRedGrab.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    WxRedGrab t=(WxRedGrab)it.next();
    int city=WxRed.find(t.wxred).city;
  %>
  <tr>
    <td><%=i%></td>
    <td><%=city<1?"全国":Card.find(city).name%></td>
    <td><%=WxUser.find(t.wxuser).getAnchor()%></td>
    <td><%=t.money==0?"--":MT.f(t.money)%></td>
    <td><%=MT.f(t.time,1)%></td>
    <td><%
    //out.println("<a href=javascript:mt.act('edit',"+t.wxredgrab+")>编辑</a>");
    //out.println("<a href=javascript:mt.act('del',"+t.wxredgrab+")>删除</a>");
    %></td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan=3 align='right'>"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,20)+"<td>"+total);
}%>
</table>
<br/>
<input type="button" value="导出" onclick="mt.post('/Attchs.do?act=excel&name=%E7%BA%A2%E5%8C%85&key=<%=MT.enc("SELECT CASE WHEN wr.city=0 THEN '全国' ELSE c.name END 地区,wu.avatar 头像,wu.nickname 昵称,wu.openid 用户标识,wrg.code 单号,wrg.money 红包,wrg.time 时间 FROM WxRedGrab wrg INNER JOIN WxRed wr ON wrg.wxred=wr.wxred INNER JOIN WxUser wu ON wrg.wxuser=wu.wxuser LEFT JOIN Card c ON wr.city=c.card WHERE 1=1"+sql.toString())%>')"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.wxredgrab.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='view')
      form2.action='/WxRedGrabView.jsp';
    else if(a=='edit')
      form2.action='/WxRedGrabEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
