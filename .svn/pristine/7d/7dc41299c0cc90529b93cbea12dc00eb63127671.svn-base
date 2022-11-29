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
StringBuffer sql=new StringBuffer(" and ( lsstatic=1  or lsstatic=0)");

param.append("?id=").append(request.getParameter("id"));



int updatetype=0,updatelsid=0;
if(teasession.getParameter("updatelsid")!=null &&  teasession.getParameter("updatelsid").length()>0)
{
  updatelsid = Integer.parseInt(teasession.getParameter("updatelsid"));
  if(teasession.getParameter("updatetype")!=null && teasession.getParameter("updatetype").length()>0)
  {
    updatetype = Integer.parseInt(teasession.getParameter("updatetype"));
  }
  LeagueShop.updatestatic(updatelsid,updatetype,teasession._rv.toString());
}
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
int lstype=0,lsstype=0,lsstatic2=1111,csarea =0,s1=0,s2=0;
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
<META HTTP-EQUIV="Expires" CONTENT="0"/>
<title>总部对分店状态修改</title>
</head>
<body onLoad="f_load()">
<h1>总部对分店状态修改</h1>
<h2>查询</h2>
<form name="form3" action="/jsp/leagueshop/LeagueShopStatic.jsp" method="get" >

<input type="hidden" name="o" VALUE="<%=o%>">
<input type="hidden" name="aq" VALUE="<%=aq%>">
<input type="hidden" name="id" value="<%=request.getParameter("id")%>" >
<input type="hidden" name="act"  value="" >
<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
  <tr><td nowrap="nowrap">分店名称：</td>
    <td><input name="lsname"  value="<%if(lsname!=null){out.print(lsname);}%>"/></td>
      <td nowrap="nowrap">所在区域：</td><td colspan="3">
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
</td>
</tr>
<tr><td>加盟商姓名：</td><td><input name="lsbuyname" value="<%if(lsbuyname!=null)out.print(lsbuyname);%>"  /></td><td>加盟时间：</td>
  <td colspan="3">&nbsp;从&nbsp;
    <input name="time_k" size="7"  value="<%if(time_k!=null)out.print(time_k);%>"><A href="###"><img onclick="showCalendar('form3.time_k');" src="/tea/image/public/Calendar2.gif" align="top"/></a>&nbsp;到&nbsp;
      <input name="time_j" size="7"  value="<%if(time_j!=null)out.print(time_j);%>"><A href="###"><img onclick="showCalendar('form3.time_j');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
  </td>
</tr>
<tr>
  <td>分店状态：</td>
  <td>
    <select name="lsstatic2"><option  value="1111" selected="selected">--------</option>
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
    </select>
  </td>  <td nowrap="nowrap">分店类型：</td><td><select  name="lstype" onChange="f_ajax(value,'lsstype')"><option  value="0">-------</option>
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

</td> <td colspan="2">分店级别：<select name="lsstype" ><option value="0" >-------</option><option value="5000">其他</option>
</select>　<input type="submit" value="查询" /></td></tr>
</table>
</form>
<h2>分店数量（<%=count%>）</h2>

<form action="/servlet/EditLeagueShopExcel"  name="form2">
<input type="hidden" name="action" value="LeagueShopStatic">
<input type="hidden" name="sql" value="<%=sql.toString()%>">
<input type="hidden" name="files" value="LeagueShopStatic">
<input type="hidden" name="count" value="<%=count%>">


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
  %></td><td nowrap><a href="javascript:f_order('adddate');">加盟时间</a>
  <%
  if(o.equals("adddate"))
  {
    if(aq)
    out.print("↓");
    else
    out.print("↑");
  }
  %></td><td nowrap><a href="javascript:f_order('lsstatic');">分店状态</a>
  <%
  if(o.equals("lsstatic2"))
  {
    if(aq)
    out.print("↓");
    else
    out.print("↑");
  }
  %></td><td></td></tr>
  <%
  Enumeration euls = LeagueShop.findByCommunity(teasession._strCommunity,sql.toString(),pos,10);
  if(!euls.hasMoreElements())
  {
    out.print("<tr><td nowrap colspan=6>暂无信息</td></tr>");
  }
  for(int i=0;euls.hasMoreElements();i++)
  {
    int lsid = Integer.parseInt(String.valueOf(euls.nextElement()));
    LeagueShop objlist = LeagueShop.find(lsid);
    LeagueShopServer objserver = LeagueShopServer.find(objlist.getLsstype());
    LeagueShopType objtype = LeagueShopType.find(objlist.getLstype());
    %>
    <tr>
      <td nowrap><%if(objlist.getLsname()!=null)out.print(objlist.getLsname());%></td>
      <td nowrap><%=LeagueShop.CSAREA[objlist.getCsarea()]%></td>
      <td nowrap><%if(objlist.getTel()!=null)out.print(objlist.getTel());%></td>
      <td nowrap><%if(objlist.getLsbuyname()!=null)out.print(objlist.getLsbuyname());%></td>
      <td nowrap><%=objtype.getLstypename()+"："%><%=objserver.getLssname()%></td>
       <td nowrap><%=objlist.getAdddateToString()%></td>
      <td nowrap><%=LeagueShop.LSSTATIC[objlist.getLsstatic()]%>：<%=LeagueShop.LSSTATIC2[objlist.getLsstatic2()]%></td>
      <td nowrap="nowrap">
      <input  type="button" value="编辑分店状态" onClick="window.open('/jsp/leagueshop/EditLeagueShopStatic.jsp?ids=<%=lsid%>', '_self');" >
      </td>
    </tr>
    <%
    }
    %>
     <tr><td colspan="7"  align="center" style="padding-right:5px;"> <%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td></tr>
    <tr><td nowrap colspan="7" align="center"><input type="submit" value="导出Excel" /></td>
</tr>
</table>
</form>
</body>
</html>

