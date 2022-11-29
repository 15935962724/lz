<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.net.*"%><%@ page import="java.util.*"%><%@ page import="java.text.*"%><%@ page import="java.security.*"%><%@ page import="com.capinfo.crypt.*"%><%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%><%@ page import="java.math.*"%><%@ page import="tea.entity.csvclub.alipay.*"%><%@ page import="tea.entity.csvclub.encrypt.*" %><%@ page import="tea.entity.admin.mov.*" %><%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.league.*" %><%@ page import="tea.db.*" %>
<%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
StringBuffer param=new StringBuffer();
StringBuffer sql=new StringBuffer("  and  lsstatic=0");

param.append("?id=").append(request.getParameter("id"));


String lsname = "",lsbuyname="",time_k="",time_j="";
if(teasession.getParameter("lsname")!=null && teasession.getParameter("lsname").length()>0)
{
  lsname= teasession.getParameter("lsname");
  sql.append("  and  lsname like ").append(DbAdapter.cite("%"+lsname+"%"));
  param.append("&lsname=").append(lsname);
}
if(teasession.getParameter("lsbuyname")!=null && teasession.getParameter("lsbuyname").length()>0)
{
  lsbuyname= teasession.getParameter("lsbuyname");
  sql.append("  and  lsbuyname=").append(DbAdapter.cite(lsbuyname));
  param.append("&lsbuyname=").append(lsname);
}
if(teasession.getParameter("time_k")!=null && teasession.getParameter("time_k").length()>0)
{
  time_k= teasession.getParameter("time_k");
  sql.append("  and  adddate>").append(DbAdapter.cite(time_k));
  param.append("&time_k=").append(time_k);
}
if(teasession.getParameter("time_j")!=null && teasession.getParameter("time_j").length()>0)
{
  time_j= teasession.getParameter("time_j");
  sql.append("  and  adddate<").append(DbAdapter.cite(time_j));
  param.append("&time_j=").append(time_j);
}
int lstype=0,lsstype=0,lsstatic=0,csarea =0,s1=0,s2=0,lsstatic2=1111;

if(teasession.getParameter("lsstatic2")!=null && teasession.getParameter("lsstatic2").length()>0)
{
  lsstatic2=Integer.parseInt(teasession.getParameter("lsstatic2"));

  if(lsstatic2==1111)
  {

  }
  else
  {
    sql.append("  and  lsstatic2=").append(lsstatic2);
    param.append("&lsstatic2=").append(lsstatic2);

  }
}
if(teasession.getParameter("lstype")!=null && teasession.getParameter("lstype").length()>0)
{
  lstype=Integer.parseInt(teasession.getParameter("lstype"));

  if(lstype==0)
  {
  }
  else
  {
    sql.append("  and  lstype=").append(lstype);
    param.append("&lstype=").append(lstype);
  }
}
if(teasession.getParameter("lsstype")!=null && teasession.getParameter("lsstype").length()>0)
{
  lsstype=Integer.parseInt(teasession.getParameter("lsstype"));
  if(lsstype==0)
  {

  }
  else
  {
    sql.append("  and  lsstype=").append(lsstype);
    param.append("&lsstype=").append(lsstype);
  }
}
if(teasession.getParameter("lsstatic")!=null && teasession.getParameter("lsstatic").length()>0)
{
  lsstatic=Integer.parseInt(teasession.getParameter("lsstatic"));

  if(lsstatic==1111)
  {

  }
  else
  {
    sql.append("  and  lsstatic=").append(lsstatic);
    param.append("&lsstatic=").append(lsstatic);
  }
}
if(teasession.getParameter("s1")!=null && teasession.getParameter("s1").length()>0)
{
  s1=Integer.parseInt(teasession.getParameter("s1"));
  sql.append("  and  province=").append(s1);
  param.append("&s1=").append(s1);
}
if(teasession.getParameter("s2")!=null && teasession.getParameter("s2").length()>0)
{
  s2=Integer.parseInt(teasession.getParameter("s2"));
  sql.append("  and  city=").append(s2);
  param.append("&s2=").append(s2);
}
if(teasession.getParameter("csarea")!=null && teasession.getParameter("csarea").length()>0)
{
  csarea=Integer.parseInt(teasession.getParameter("csarea"));

  if(csarea==0)
  {

  }
  else
  {
  sql.append("  and  csarea=").append(csarea);
  param.append("&csarea=").append(csarea);
  }
}

int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count =LeagueShop.count(teasession._strCommunity,sql.toString());
String o=request.getParameter("o");
if(o==null)
{
  o="lsname";
}
boolean aq=Boolean.parseBoolean(request.getParameter("aq"));
sql.append(" ORDER BY ").append(o).append(" ").append(aq?"DESC":"ASC");
param.append("&o=").append(o).append("&aq=").append(aq);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script> if(parent.lantk) { document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; } </script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
<META HTTP-EQUIV="Expires" CONTENT="0"/>
<script type="">
function f_order(v)
{
  var aq=form3.aq.value=="true";
  if(form3.o.value==v)
  {
    form3.aq.value=!aq;
  }else
  {
    form3.o.value=v;
  }
  form3.action="?";
  form3.submit();
}
var obj;
function f_ajax(v,n)
{
  obj=document.all(n).options;
  while(obj.length>1)obj[1]=null;
  if(v=="0")v="1111111111";
  sendx("/servlet/Ajax?act=leagueshop&value="+v,f_change);
}
function f_change(d)
{
  d=eval(d);
  for(var i=0;i<d.length;i++)
  {
    obj[i+1]=new Option(d[i][1],d[i][0]);
  }
  switch(obj.name)
  {
    case "lsstype":
    form3.lsstype.value="<%=lsstype%>";
    break;
  }
}
function f_load()
{
  form3.lstype.onchange();
}
</script>
<title>分店预付款管理</title>
</head>
<body onload="return f_load()">
<h1>分店预付款管理</h1>
<h2>查询</h2>
<form name="form3" action="/jsp/leagueshop/LeagueShopImprestList.jsp" method="get" >
<input type="hidden" name="o" VALUE="<%=o%>">
<input type="hidden" name="aq" VALUE="<%=aq%>">
<input type="hidden" name="id" value="<%=request.getParameter("id")%>" >
<input type="hidden" name="act"  value="" >
<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
  <tr><td nowrap="nowrap" align="right">分店名称：</td><td><input name="lsname"  value="<%if(lsname!=null){out.print(lsname);}%>"/></td><td nowrap="nowrap" align="right">所在区域：</td><td>
    <script src="/tea/card.js" type=""></script>
    <script type="">
    var delcct=new Array();
    function f_area(objcct)
    {
      var rscct=area[parseInt(objcct.value)][1];
      var op=form3.s1.options;
      for(var i=0;i<delcct.length;i++)
      {
        op[op.length]=new Option(delcct[i][0],delcct[i][1]);
      }
      delcct=new Array();
      for(var i=0;i<op.length;i++)
      {
        if(rscct.indexOf(op[i].value)==-1)
        {
          delcct[delcct.length]=new Array(op[i].text,op[i].value);
          op[i--]=null;
        }
      }
    }
    document.write("<select name='csarea' onchange=f_area(this)>");



    for(var i=0;i<area.length;i++)
    {
      document.write("<option value="+i+">"+area[i][0]+"</option>");
    }

    document.write("</select>　");
    selectcard("s1","s2",null,"<%=s2%>");
    form3.csarea.value="<%=csarea%>";
    form3.csarea.onchange();
    </script>


</td>  </tr>
<tr><td nowrap="nowrap" align="right">加盟商姓名：</td><td><input name="lsbuyname" value="<%if(lsbuyname!=null)out.print(lsbuyname);%>"  /></td><td nowrap="nowrap" align="right">加盟时间：</td>
  <td>&nbsp;从&nbsp;
    <input name="time_k" size="7"  value="<%if(time_k!=null)out.print(time_k);%>"><A href="###"><img onclick="showCalendar('form3.time_k');" src="/tea/image/public/Calendar2.gif" align="top"/></a>&nbsp;到&nbsp;
      <input name="time_j" size="7"  value="<%if(time_j!=null)out.print(time_j);%>"><A href="###"><img onclick="showCalendar('form3.time_j');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
  </td>

</tr>
<tr><td nowrap="nowrap" align="right">分店类型：</td><td><select  name="lstype" onChange="f_ajax(value,'lsstype')"><option  value="0">-------</option>
<%
Enumeration eu = LeagueShopType.findByCommunity(teasession._strCommunity,"",0,8);
for(int i=0;eu.hasMoreElements();i++)
{
  int idtt= Integer.parseInt(String.valueOf(eu.nextElement()));
  LeagueShopType objty = LeagueShopType.find(idtt);
  out.print("<option value="+idtt);
        if(lstype==idtt)
        {
          out.print(" selected ");
        }
    out.print(">"+objty.getLstypename()+"</option>");
  }
  %>
  </select>　

</td><td nowrap="nowrap" align="right">分店级别：</td><td><select name="lsstype" ><option value="0" >-------</option>
</select>　　加盟点状态：　<select name="lsstatic2"><option  value="1111" selected="selected">--------</option>
     <%
     for(int i=0;i<LeagueShop.LSSTATIC2.length;i++)
     {
       out.print("<option value="+i);
       if(lsstatic2==i)
       {
         out.print("  selected ");
       }
       out.print(">"+LeagueShop.LSSTATIC2[i]+"</option>");
     }
     %>
    </select>　<input type="submit" value="查询" /></td></tr>
</table>
</form>


<form action="/servlet/EditLeagueShopExcel"  name="form2">
<input type="hidden" name="action" value="LeagueShopImprestList">
<input type="hidden" name="sql" value="<%=sql.toString()%>">
<input type="hidden" name="files" value="LeagueShopImprestList">
<input type="hidden" name="count" value="<%=count%>">

<h2>分店数量（<%=count%>）</h2>
<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
  <tr  id="tableonetr" ><td nowrap><a href="javascript:f_order('lsname');">分店名称</a>
  <%
  if(o.equals("lsname"))
  {
    if(aq)
    out.print("↓");
    else
    out.print("↑");
  }
  %></td><td nowrap><a href="javascript:f_order('csarea');">所在区域</a>
  <%
  if(o.equals("csarea"))
  {
    if(aq)
    out.print("↓");
    else
    out.print("↑");
  }
  %></td><td nowrap><a href="javascript:f_order('adddate');">加盟时间</a>
  <%
  if(o.equals("adddate"))
  {
    if(aq)
    out.print("↓");
    else
    out.print("↑");
  }
  %></td><td nowrap><a href="javascript:f_order('tel');">营业电话</a>
  <%
  if(o.equals("tel"))
  {
    if(aq)
    out.print("↓");
    else
    out.print("↑");
  }
  %></td><td nowrap><a href="javascript:f_order('lsbuyname');">加盟商姓名</a>
  <%
  if(o.equals("lsbuyname"))
  {
    if(aq)
    out.print("↓");
    else
    out.print("↑");
  }
  %></td><td nowrap><a href="javascript:f_order('lsstype');">加盟级别</a>
  <%
  if(o.equals("lsstype"))
  {
    if(aq)
    out.print("↓");
    else
    out.print("↑");
  }
  %></td><td nowrap>账户可用金额</td><td nowrap>冻结余额</td><td></td></tr>
 <%
Enumeration euls = LeagueShop.findByCommunity(teasession._strCommunity,sql.toString(),pos,10);
if(!euls.hasMoreElements())
{
  out.print("<tr><td nowrap colspan=8>暂无信息</td></tr>");
}
for(int i=0;euls.hasMoreElements();i++)
{
  int lsid = Integer.parseInt(String.valueOf(euls.nextElement()));
  LeagueShop objlist = LeagueShop.find(lsid);
  LeagueShopServer objserver = LeagueShopServer.find(objlist.getLsstype());
  LeagueShopType objtype = LeagueShopType.find(objlist.getLstype());
  %>
    <tr>
      <td nowrap><%=objlist.getLsname()%></td>
      <td nowrap><%=LeagueShop.CSAREA[objlist.getCsarea()]%></td>
      <td nowrap><%=objlist.getAdddateToString()%></td>
      <td nowrap><%if(objlist.getTel()!=null)out.print(objlist.getTel());%></td>
      <td nowrap><%if(objlist.getLsbuyname()!=null)out.print(objlist.getLsbuyname()); %></td>
      <td nowrap><%=objtype.getLstypename()+"："%><%=objserver.getLssname()%></td>
      <td nowrap><%=objlist.getSummoney()%>　元</td>
      <td nowrap><%=LeagueShopImprest.SumMoney(" and lsid="+lsid+" and lsistatic=2")%>　元</td>
      <td nowrap="nowrap"><input type="button" value="财务管理" onclick="window.open('/jsp/leagueshop/LeagueShopImprestList2.jsp?lsid=<%=lsid%>&num=0','_self')" />　
        <!--input type="button" value="添加预付信息" onclick="window.open('/jsp/leagueshop/EditLeagueShopImprest.jsp?lsid=<%=lsid%>','_self')" /--></td></tr>
  <%
}
%>
 <tr><td colspan="8"  align="center" style="padding-right:5px;"> <%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td></tr>
</table>
</form>
</body>
</html>

