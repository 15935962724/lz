<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.women.*"%><%

Http h=new Http(request,response);

int menuid=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&community="+h.community+"&id="+menuid);

String invoice=h.get("invoice","");
if(invoice.length()>0)
{
  sql.append(" AND invoice LIKE "+DbAdapter.cite("%"+invoice+"%"));
  par.append("&invoice="+h.enc(invoice));
}

String province=h.get("province","");
if(province.length()>0)
{
  sql.append(" AND province="+DbAdapter.cite("<无>".equals(province)?"":province));
  par.append("&province="+h.enc(province));
}

Date dt0=h.getDate("dt0");
if(dt0!=null)
{
  sql.append(" AND dtime>"+DbAdapter.cite(dt0));
  par.append("&dt0="+MT.f(dt0));
}
Date dt1=h.getDate("dt1");
if(dt1!=null)
{
  sql.append(" AND dtime<"+DbAdapter.cite(dt1));
  par.append("&dt1="+MT.f(dt1));
}

String donors=h.get("donors","");
if(donors.length()>0)
{
  sql.append(" AND donors LIKE "+DbAdapter.cite("%"+donors+"%"));
  par.append("&donors="+h.enc(donors));
}

float money=h.getFloat("money");
if(money>0)
{
  sql.append(" AND money LIKE "+DbAdapter.cite("%"+money+"%"));
  par.append("&money="+money);
}

String address=h.get("address","");
if(address.length()>0)
{
  sql.append(" AND address LIKE "+DbAdapter.cite("%"+address+"%"));
  par.append("&address="+h.enc(address));
}

String zip=h.get("zip","");
if(zip.length()>0)
{
  sql.append(" AND zip LIKE "+DbAdapter.cite("%"+zip+"%"));
  par.append("&zip="+h.enc(zip));
}

String tel=h.get("tel","");
if(tel.length()>0)
{
  sql.append(" AND tel LIKE "+DbAdapter.cite("%"+tel+"%"));
  par.append("&tel="+h.enc(tel));
}


int pos=h.getInt("pos");
int sum=Donation.count(sql.toString());
par.append("&pos=");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
</head>
<body>
<h1>捐赠信息管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>发票编号:<input name="invoice" value="<%=invoice%>"/></td>
  <td>捐赠时间:<input name="dt0" value="<%=MT.f(dt0)%>" size="12" onclick="new Calendar().show('form1.dt0');"/>-<input name="dt1" value="<%=MT.f(dt1)%>" size="12" onclick="new Calendar().show('form1.dt1');"/></td>
  <td>捐赠者:<input name="donors" value="<%=donors%>"/></td>
<%--
  <td>捐赠金额 :<input name="money" value="<%=money%>"/></td>
  <td>地址:<input name="address" value="<%=address%>"/></td>
  <td>邮编:<input name="zip" value="<%=zip%>"/></td>
  <td>电话:<input name="tel" value="<%=tel%>"/></td>--%>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/Donations.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="donation"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="key" value="<%=MT.enc(sql.toString())%>" disabled="disabled"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>发票编号</td>
  <td>捐赠时间</td>
  <td>捐赠者</td>
  <td>捐赠金额 </td>
  <td>落实省</td>
  <td>邮编</td>
  <td>电话</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  sql.append(" ORDER BY donation DESC");
  Iterator it=Donation.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    Donation t=(Donation)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=MT.f(t.invoice)%></td>
    <td><%=MT.f(t.dtime)%></td>
    <td><%=MT.f(t.donors)%></td>
    <td><%=MT.f(t.money)%></td>
    <td><%=MT.f(t.province)%></td>
    <td><%=MT.f(t.zip)%></td>
    <td><%=MT.f(t.tel)%></td>
    <td><input type="button" value="编辑" onclick="f_act('Edit',<%=t.donation%>)"/> <input type="button" value="删除" onclick="f_act('del',<%=t.donation%>)"/></td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="添加" onclick="f_act('Edit',0)"/>
<input type="button" value="导出捐赠信息" onclick="f_act('expdon',0)"/>
<input type="button" value="导入捐赠信息" onclick="f_act('Imp','don')"/>

<input type="button" value="导出落实信息" onclick="f_act('exppra',0)"/>
<input type="button" value="导入落实信息" onclick="f_act('Imp','par')"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
function f_act(a,id,b)
{
  form2.act.value=a;
  form2.donation.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a.indexOf('exp')==0)
  {
    form2.key.disabled=false;
    mt.show('你确定要导出“<%=sum%>”条数据吗？',2,'form2.submit()');
  }else
  {
    form2.action='/jsp/type/women/Donation'+a+'.jsp';form2.target='_self';form2.method='get';form2.submit();
  }
}
</script>
</body>
</html>
