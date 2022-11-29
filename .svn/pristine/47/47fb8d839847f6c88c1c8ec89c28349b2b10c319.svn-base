<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%@page import="tea.entity.admin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");

int menuid=h.getInt("id");
par.append("?id="+menuid);

String act=h.get("act");
if("action".equals(act))
{
  out.print("oper,audit,");
  return;
}

String acts=h.get("acts","");
int remind=acts.contains("audit,")?LmsPrice.count(sql.toString()+" AND status=1"):0;
if("remind".equals(act))
{
  out.print(remind);
  return;
}

int lmsplan=h.getInt("lmsplan");
if(lmsplan>0)
{
  sql.append(" AND lmsplan="+lmsplan);
  par.append("&lmsplan="+lmsplan);
}

int city=h.getInt("city");
if(city>0)
{
  sql.append(" AND city="+city);
  par.append("&city="+city);
}

int lmsorg=h.getInt("lmsorg");
if(lmsorg>0)
{
  sql.append(" AND lmsorg LIKE "+DbAdapter.cite("%"+lmsorg+"%"));
  par.append("&lmsorg="+lmsorg);
}

float price1=h.getFloat("price1");
if(price1>0)
{
  sql.append(" AND price1 LIKE "+DbAdapter.cite("%"+price1+"%"));
  par.append("&price1="+price1);
}

float price2=h.getFloat("price2");
if(price2>0)
{
  sql.append(" AND price2 LIKE "+DbAdapter.cite("%"+price2+"%"));
  par.append("&price2="+price2);
}
int tab=h.getInt("tab");
par.append("&tab="+tab);

int pos=h.getInt("pos");
par.append("&pos=");


%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
</head>
<body>
<h1><%=menuid<1?"财务管理":AdminFunction.find(menuid).getName(h.language)%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <th>考试计划:</th><td><select name="lmsplan"><option value="">--<%=LmsPlan.options(" AND father=0 AND status IN(2,4)",lmsplan)%></select></td>
  <th>省:</th><td><script>mt.city("city",null,null,"<%=city%>");</script></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h3>
<%
if(acts.contains("oper,"))
{
  out.print("<input type='button' value='添加' onclick=mt.act(null,'edit') />");
}
%>
</h3>

<h2>列表</h2>
<form name="form2" action="/LmsPrices.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmsprice"/>
<input type="hidden" name="father"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="status"/>
<%
out.print("<div class='switch'>");
for(int i=0;i<LmsPrice.STATUS_TYPE.length;i++)
{
  out.print("<a href='javascript:mt.tab("+i+")' class='"+(tab==i?"current":"")+"'>"+(i<1?"全部":LmsPrice.STATUS_TYPE[i])+"("+LmsPrice.count(sql.toString()+(i<1?"":" AND lp.status="+i))+")</a>");
}
out.print("</div>");
%>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>考试计划</td>
  <td>培训费</td>
  <td>考试费</td>
  <td>管理费</td>
  <td>操作</td>
</tr>
<%
if(tab>0)
{
  sql.append(" AND lp.status="+tab);
}
int sum=LmsPrice.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  sql.append(" ORDER BY lmsplan DESC,city");
  Iterator it=LmsPrice.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    LmsPrice t=(LmsPrice)it.next();
    if(t.father>0)
    {
      out.print("<tbody style='background-color:#F6F6F6'>");
    }
  %>
  <tr id="<%=MT.enc(t.lmsprice)%>">
    <td><%=i%></td>
    <td><%=t.father<1?LmsPlan.find(t.lmsplan).name:"　　<script>mt.city('"+MT.f(t.city)+"')</script>"%></td>
    <td><%=MT.f(t.price[4])%></td>
    <td><%=MT.f(t.price[5])%></td>
    <td><%=MT.f(t.price[6])%></td>
    <td><%
    out.println("<a href=### onclick=mt.act(this,'view')>查看</a>");
    if(acts.contains("oper,"))
    {
      if(t.father<1)out.println("<a href=### onclick=mt.act(this,'edit',"+t.lmsprice+") title='如果某省的报考费用特殊，需单独对该省进行报考费用设置。'>添加</a>");
      if(t.status!=2)
      {
        out.println("<a href=### onclick=mt.act(this,'edit')>编辑</a>");
        out.println("<a href=### onclick=mt.act(this,'del')>删除</a>");
      }
    }
    if(acts.contains("audit,"))
    {
      if(t.status==1)out.println("<a href=### onclick=mt.act(this,'status')>审核</a>");
    }
    %></td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(t,a,b)
{
  form2.act.value=a;
  form2.lmsprice.value=t?mt.ftr(t).id:"";
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='status')
  {
    mt.show("状态：<input type='radio' name='_state' value='2' id='_state_2' checked /><label for='_state_2'>通过</label>　<input type='radio' name='_state' value='3' id='_state_3' /><label for='_state_3'>不通过</label>",2,"form2.status.value=$$('_state_2').checked?2:3;form2.submit()");
  }else
  {
    if(a=='view')
      form2.action='/jsp/lms/LmsPriceView.jsp';
    else if(a=='edit')
    {
      if(b)
      {
        form2.father.value=b;
        form2.lmsprice.value="";
      }
      form2.action='/jsp/lms/LmsPriceEdit.jsp';
    }
    form2.target=form2.method='';
    form2.submit();
  }
};
edn.remind(<%=remind%>);
</script>
</body>
</html>
