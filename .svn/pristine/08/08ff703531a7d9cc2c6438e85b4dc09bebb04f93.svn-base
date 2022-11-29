<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.weibo.*"%><%

Http h=new Http(request,response);
TeaSession ts = new TeaSession(request);
if (ts._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node=" + h.node);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?community="+h.community);

String manufacturer=h.get("manufacturer","");
if(manufacturer.length()>0)
{
  sql.append(" AND manufacturer LIKE "+Database.cite("%"+manufacturer+"%"));
  par.append("&manufacturer="+h.enc(manufacturer));
}

String product=h.get("product","");
if(product.length()>0)
{
  sql.append(" AND product LIKE "+Database.cite("%"+product+"%"));
  par.append("&product="+h.enc(product));
}

String version=h.get("version","");
if(version.length()>0)
{
  sql.append(" AND version LIKE "+Database.cite("%"+version+"%"));
  par.append("&version="+h.enc(version));
}

String deviceid=h.get("deviceid","");
if(deviceid.length()>0)
{
  sql.append(" AND deviceid LIKE "+Database.cite("%"+deviceid+"%"));
  par.append("&deviceid="+h.enc(deviceid));
}

String number=h.get("number","");
if(number.length()>0)
{
  sql.append(" AND number LIKE "+Database.cite("%"+number+"%"));
  par.append("&number="+h.enc(number));
}

String display=h.get("display","");
if(display.length()>0)
{
  sql.append(" AND display LIKE "+Database.cite("%"+display+"%"));
  par.append("&display="+h.enc(display));
}


int pos=h.getInt("pos");
int sum=WMobile.count(sql.toString());
par.append("&pos=");

%><html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>客户端统计</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<table id="tablecenter" cellspacing="0">
<tr>
  <td>制造商:<input name="manufacturer" value="<%=manufacturer%>"/></td>
  <td>型号:<input name="product" value="<%=product%>"/></td>
  <td>固件版本:<input name="version" value="<%=version%>"/></td>
  <td>设备ID:<input name="deviceid" value="<%=deviceid%>"/></td>
  <td>手机号:<input name="number" value="<%=number%>"/></td>
  <td>分辨率:<input name="display" value="<%=display%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/WMobileEdit.jsp" method="post" target="_ajax">
<input type="hidden" name="wmobile"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>制造商</td>
  <td>型号</td>
  <td>版本</td>
  <td>设备ID</td>
  <td>手机号</td>
  <td>分辨率</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=WMobile.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    WMobile t=(WMobile)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=MT.f(t.manufacturer)%></td>
    <td><%=MT.f(t.product)%></td>
    <td><%=MT.f(t.version)%></td>
    <td><%=MT.f(t.deviceid)%></td>
    <td><%=MT.f(t.number)%></td>
    <td><%=MT.f(t.display)%></td>
    <td><a href="javascript:mt.act('view',<%=t.wmobile%>)">查看</a></td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language,par.toString(), pos, sum,20));
}%>
</table>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.wmobile.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='view')
  {
    form2.action='/jsp/weibo/WMobileView.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
