<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.net.*"%><%@ page import="java.util.*"%><%@ page import="java.text.*"%><%@ page import="java.security.*"%><%@ page import="com.capinfo.crypt.*"%><%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%><%@ page import="java.math.*"%><%@ page import="tea.entity.csvclub.alipay.*"%><%@ page import="tea.entity.csvclub.encrypt.*" %><%@ page import="tea.entity.admin.mov.*" %><%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.league.*" %><%@ page import="tea.db.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.admin.erp.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
StringBuffer param=new StringBuffer();
StringBuffer sql=new StringBuffer();

param.append("?community="+teasession._strCommunity);

String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}


Date datenew = new Date();
Calendar cc = Calendar.getInstance();
cc.setTime(datenew);
int year=0,month=0,date=0,date1=0;
year=cc.get(cc.YEAR);
month=cc.get(cc.MONTH);

Date myDate=new Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
String mDate="";
long myTime=(myDate.getTime()/1000)+60*60*24;
myDate.setTime(myTime*1000);
mDate=formatter.format(myDate);

//
date1=cc.get(cc.DATE);
if(month==12)
{
  month=1;
}
else
{
  month=month+1;
}
String datek=String.valueOf(year-1)+"-"+String.valueOf(month)+"-"+cc.get(date);
String datej=mDate;

int shenhe=0;
if(teasession.getParameter("shenhe")!=null && teasession.getParameter("shenhe").length()>0)
{
  shenhe = Integer.parseInt(teasession.getParameter("shenhe"));
  int type = Integer.parseInt(teasession.getParameter("type"));
  int liid = Integer.parseInt(teasession.getParameter("liid"));
  int lsid = Integer.parseInt(teasession.getParameter("lsid"));
  LeagueShopImprest objimprest = LeagueShopImprest.find(liid);
  BigDecimal oldmoney = objimprest.getYfmoney();
  if(shenhe==2)
  {
    LeagueShopImprest.setAudittype(liid);
  }
  response.sendRedirect("/jsp/leagueshop/LeagueShopImprestList2.jsp?lsid="+lsid+"&num=0");
  return;
}
int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);

int lsid = 0;
if(teasession.getParameter("lsid")!=null && teasession.getParameter("lsid").length()>0)
{
  lsid =Integer.parseInt(teasession.getParameter("lsid"));
  sql.append(" and lsid=").append(lsid);
  param.append("&lsid=").append(lsid);
}else
{
  AdminUsrRole adminobj = AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());
  lsid= LeagueShop.findid(adminobj.getUnit());
  sql.append(" and lsid=").append(lsid);
  param.append("&lsid=").append(lsid);
}
String time_k="",time_j="";
if(teasession.getParameter("time_k")!=null && teasession.getParameter("time_k").length()>0)
{
  time_k= teasession.getParameter("time_k");
  datek=time_k;
  sql.append("  and  zzdate>").append(DbAdapter.cite(time_k));
  param.append("&time_k=").append(time_k);
}
else
{
  time_k= datek;
  sql.append("  and  zzdate>").append(DbAdapter.cite(time_k));
  param.append("&time_k=").append(time_k);

}
if(teasession.getParameter("time_j")!=null && teasession.getParameter("time_j").length()>0)
{
  time_j= teasession.getParameter("time_j");
  datej=time_j;
  sql.append("  and  zzdate<").append(DbAdapter.cite(time_j));
  param.append("&time_j=").append(time_j);
}
else
{
  time_j= datej;
  sql.append("  and  zzdate<").append(DbAdapter.cite(time_j));
  param.append("&time_j=").append(time_j);
}



boolean falg=false;
int num=0;
if(teasession.getParameter("num")!=null && teasession.getParameter("num").length()>0)
{
  num =Integer.parseInt(teasession.getParameter("num"));
  param.append("&num=").append(num);
  if(num!=0)
  {
    AdminUsrRole adminobj = AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());
    if(LeagueShop.findid(adminobj.getUnit())==0)
    {
      response.sendRedirect("/jsp/leagueshop/LeagueShopInfoOver.jsp");
      return;
    }
    LeagueShop leaobjfg = LeagueShop.find(LeagueShop.findid(adminobj.getUnit()));
    leaobjfg.getLstype();
    lsid=leaobjfg.getId();
    if(leaobjfg.isExists())
    {
    }
    else
    {
      response.sendRedirect("/jsp/leagueshop/LeagueShopInfoOver.jsp");
      return;
    }
    falg=true;
  }
}
LeagueShop obj = LeagueShop.find(lsid);
BigDecimal sum = new BigDecimal("0");
BigDecimal txsum =  Paidinfull.pfsum(teasession._strCommunity,"  and supplname="+lsid,"total_2",0);

int count=LeagueShopImprest.count(teasession._strCommunity,sql.toString());

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script>if(parent.lantk) {document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; }</script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
<META HTTP-EQUIV="Expires" CONTENT="0"/>
<title>分店预付款管理</title>
</head>
<body>
<h1>分店预付款管理</h1>

<h2>分店预付款添加记录</h2>
<h2>查询 <%=obj.getLsname()%></h2>
<form name="form2"  action="?" method="POST">
<input type="hidden" name="num"  value="<%=num%>"/>
<input type="hidden" name="lsid"  value="<%=lsid%>"/>
<input type="hidden" name="id"  value="<%=menu_id%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>转账时间：&nbsp;从&nbsp;
      <input name="time_k" size="7"  value="<%if(time_k!=null)out.print(time_k);%>"><A href="###"><img onclick="showCalendar('form2.time_k');" src="/tea/image/public/Calendar2.gif" align="top"/></a>&nbsp;到&nbsp;
        <input name="time_j" size="7"  value="<%if(time_j!=null)out.print(time_j);%>"><A href="###"><img onclick="showCalendar('form2.time_j');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
    </td>
    <td><input type="submit" value="查询"/></td>
  </tr>
</table>
</form>
<h2>列表(<%=count%>)</h2>
<form action="/servlet/EditLeagueShopExcel" name="form1" method="POST">
<input type="hidden" name="action" value="LeagueShopImprestList2">
<input type="hidden" name="sql" value="<%=sql.toString()%>">
<input type="hidden" name="files" value="LeagueShopImprestList2">
<input type="hidden" name="count" value="<%=count%>">
<input type="hidden" name="num"  value="<%=num%>"/>
<input type="hidden" name="lsid"  value="<%=lsid%>"/>
<input type="hidden" name="datek"  value="<%=datek%>"/>
<input type="hidden" name="datej"  value="<%=datej%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap>时间</td>
    <td nowrap>摘要</td>
    <td nowrap>实收金额//退还实收金额</td>
    <td nowrap>应付金额//退还应付金额</td>
    <td nowrap>支付运费</td>
    <td nowrap>发货金额//退货金额</td>
    <td nowrap>应付配送金额</td>
    <td nowrap>配送金额</td>
    <td nowrap>冻结金额</td>

    <td nowrap>支付方式</td>
    <td nowrap>备注</td>
    <td nowrap>支付状态</td>
    <td>&nbsp;</td>
  </tr>
  <%
  Enumeration euls = LeagueShopImprest.findByCommunity(teasession._strCommunity,sql.toString()+" order by LeagueShopImprest.id desc ",pos,15);
  if(!euls.hasMoreElements())
  {
    out.print("<tr><td nowrap colspan=13>暂无信息</td></tr>");
  }
  for(int i=0;euls.hasMoreElements();i++)
  {
    int liid = Integer.parseInt(String.valueOf(euls.nextElement()));
    LeagueShopImprest lsiobj= LeagueShopImprest.find(liid);
    sum=sum.add(lsiobj.getYfmoney());
    %>
    <tr>
      <td nowrap><%=lsiobj.getZzdatetoString()%></td>
      <td nowrap><%if(lsiobj.getSummary()!=null)out.print(lsiobj.getSummary());%></td>
      <td nowrap>
      <%//实收金额
      if(lsiobj.getLsistatic()==6&&lsiobj.getType()==0)
      {
        if(lsiobj.getType()==0)
        {
          out.print("<font color=red>"+lsiobj.getYfmoney()+"</font>");
        }else
        {
          out.print("<font color=green>"+lsiobj.getYfmoney()+"</font>");
        }
      }
      %>
       <%//退还实付金额
      if(lsiobj.getLsistatic()==6&&lsiobj.getType()==1)
      {
        if(lsiobj.getType()==0){out.print("<font color=red>"+lsiobj.getYfmoney()+"</font>");}else{out.print("<font color=green>"+lsiobj.getYfmoney()+"</font>");}
      }
      %>
      </td>
      <td nowrap>
      <%//应付金额
      if(lsiobj.getLsistatic()==0&&lsiobj.getType()==0 || lsiobj.getLsistatic()==4)
      {
        if(lsiobj.getType()==0){out.print("<font color=red>"+lsiobj.getYfmoney()+"</font>");}else{out.print("<font color=green>"+lsiobj.getYfmoney()+"</font>");}
      }else if(lsiobj.getLsistatic()==0&&lsiobj.getType()==1)
      {
        if(lsiobj.getType()==1){out.print("<font color=green>"+lsiobj.getYfmoney()+"</font>");}
      }
      %>
      </td>
      <td nowrap>
      <%//支付运费
      if(lsiobj.getLsistatic()==5)
      {
        if(lsiobj.getType()==0){out.print("<font color=red>"+lsiobj.getYfmoney()+"</font>");}else{out.print("<font color=green>"+lsiobj.getYfmoney()+"</font>");}
      }
      %>
      </td>
      <td nowrap>
      <%//发货金额
      if(lsiobj.getLsistatic()==1&&lsiobj.getType()==1)
      {
        if(lsiobj.getType()==0){out.print("<font color=red>"+lsiobj.getYfmoney()+"</font>");}else{out.print("<font color=green>"+lsiobj.getYfmoney()+"</font>");}
      }
       if(lsiobj.getLsistatic()==1&&lsiobj.getType()==0)
      {
        if(lsiobj.getType()==0){out.print("<font color=red>"+lsiobj.getYfmoney()+"</font>");}else{out.print("<font color=green>"+lsiobj.getYfmoney()+"</font>");}
      }
      %>
      </td>
       <td nowrap>
      <%//应付配送金额
      if(lsiobj.getLsistatic()==3&&lsiobj.getType()==0)
      {
        if(lsiobj.getType()==0){out.print("<font color=red>"+lsiobj.getYfmoney()+"</font>");}else{out.print("<font color=green>"+lsiobj.getYfmoney()+"</font>");}
      }
      %>
      </td>
      <td nowrap>
      <%//配送金额
      if(lsiobj.getLsistatic()==3&&lsiobj.getType()==1)
      {
        if(lsiobj.getType()==0){out.print("<font color=red>"+lsiobj.getYfmoney()+"</font>");}else{out.print("<font color=green>"+lsiobj.getYfmoney()+"</font>");}
      }
      %>
      </td>
      <td nowrap>
      <%//冻结金额
      if(lsiobj.getLsistatic()==2)
      {
        if(lsiobj.getType()==0){out.print("<font color=red>"+lsiobj.getYfmoney()+"</font>");}else{out.print("<font color=green>"+lsiobj.getYfmoney()+"</font>");}
      }
      %>
      </td>
      <td nowrap><%=LeagueShopImprest.PAYMENT[lsiobj.getPayment()]%></td>
      <td nowrap><%=lsiobj.getInfo()%></td>
      <td nowrap><%=LeagueShopImprest.AUDITTYPE[lsiobj.getAudittype()]%></td>
      <td nowrap="nowrap">
      <%
      if(num==1)
      {
      }
      else
      {
        if(lsiobj.getAudittype()==0)
        {
          %><input type="button" value="编辑" onclick="window.open('/jsp/leagueshop/EditLeagueShopImprest.jsp?liid=<%=liid%>&lsid=<%=lsid%>','_self')" />            <%
          %><input type="button" value="审核" onclick="if(confirm('确认财务审核？')){window.open('/jsp/leagueshop/LeagueShopImprestList2.jsp?shenhe=2&type=<%=lsiobj.getType()%>&liid=<%=liid%>&lsid=<%=lsid%>', '_self');this.disabled=true;};" />              <%
        }
        else if(lsiobj.getLsistatic()==2&&lsiobj.getAudittype()==1)
        {
          %><input type="button" value="解除冻结金额" onclick="if(confirm('确认解除冻结金额？')){window.open('/jsp/leagueshop/LeagueShopImprestList2.jsp?shenhe=2&type=<%=lsiobj.getType()%>&liid=<%=liid%>&lsid=<%=lsid%>', '_self');this.disabled=true;};" />        <%
        }else
        {
        }
        %>
        </td>
    </tr>
    <%
    }
  }
  %>
  <tr>
    <td nowrap>　</td>
    <td nowrap>合计：</td>
    <td nowrap><font color=red><%=LeagueShopImprest.SumMoney(" and lsid="+lsid+" and  audittype=1  and lsistatic=6 and type=0 "+sql.toString())%></font>
    /<font color=green><%=LeagueShopImprest.SumMoney(" and lsid="+lsid+" and  audittype=1  and lsistatic=6 and type=1 "+sql.toString())%></font>
    </td><!--实收金额-->
    <td nowrap><font color="red"><%=LeagueShopImprest.SumMoney(" and lsid="+lsid+" and  audittype=1  and (lsistatic=0 or lsistatic=4) and type=0 "+sql.toString())%></font>/
<font color="green"><%=LeagueShopImprest.SumMoney(" and lsid="+lsid+" and  audittype=1  and lsistatic=0  and type=1 "+sql.toString())%></font>
</td><!--应付金额-->
    <td nowrap><%=LeagueShopImprest.SumMoney(" and lsid="+lsid+" and  audittype=1  and lsistatic=5 and type=1 "+sql.toString())%></td><!--支付运费-->
    <td nowrap><%=LeagueShopImprest.SumMoney(" and lsid="+lsid+" and  audittype=1  and lsistatic=1 and type=1 "+sql.toString())%></td><!--发货金额-->
    <td nowrap><%=LeagueShopImprest.SumMoney(" and lsid="+lsid+" and  audittype=1  and lsistatic=3 and type=0 "+sql.toString())%></td><!--应付配送金额-->
    <td nowrap><%=LeagueShopImprest.SumMoney(" and lsid="+lsid+" and  audittype=1  and lsistatic=3 and type=1 "+sql.toString())%></td><!--配送金额-->
    <td nowrap><%=LeagueShopImprest.SumMoney(" and lsid="+lsid+" and  audittype=1  and lsistatic=2 and type=1 "+sql.toString())%></td><!--冻结金额-->
    <td nowrap></td>
    <td nowrap></td>
    <td nowrap></td>
    <td>&nbsp;</td>
  </tr>
  <%
  if(count>10)
  {
    %>      <tr><td colspan="13"  align="center" style="padding-right:5px;"> <%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,15)%></td></tr>      <%
  }
  if(num==1)
  {
    %>        <tr><td colspan="13" align="center">          <input type="button" value="查询提货记录" onclick="window.open('/jsp/erp/ShopstockMember.jsp?lsid=<%=lsid%>','_self')" /> 　</td>        </tr>        <%
  }
  else
  {
    %>
    <tr><td colspan="13" align="center">
      <input type="button" value="添加实收金额" onclick="window.open('/jsp/leagueshop/EditLeagueShopImprest.jsp?lsistatic=6&type=0&lsid=<%=lsid%>','_self')" /> 　
      <input type="button" value="添加应付金额" onclick="window.open('/jsp/leagueshop/EditLeagueShopImprest.jsp?lsistatic=0&type=0&lsid=<%=lsid%>','_self')" /> 　
      <input type="button" value="添加配送金额" onclick="window.open('/jsp/leagueshop/EditLeagueShopImprest.jsp?lsistatic=3&type=0&lsid=<%=lsid%>','_self')" /> 　
      <input type="button" value="添加返还金额" onclick="window.open('/jsp/leagueshop/EditLeagueShopImprest.jsp?lsistatic=4&type=0&lsid=<%=lsid%>','_self')" /> 　
      <input type="button" value="添加运费金额" onclick="window.open('/jsp/leagueshop/EditLeagueShopImprest.jsp?lsistatic=5&type=1&lsid=<%=lsid%>','_self')" /> 　
      <input type="button" value="冻结金额"    onclick="window.open('/jsp/leagueshop/EditLeagueShopImprest.jsp?lsistatic=2&type=1&lsid=<%=lsid%>','_self')" /> 　
      <br><br>
      <input type="button" value="退还实收金额" onclick="window.open('/jsp/leagueshop/EditLeagueShopImprest.jsp?lsistatic=6&type=1&lsid=<%=lsid%>','_self')" /> 　
      <input type="button" value="扣除应付金额" onclick="window.open('/jsp/leagueshop/EditLeagueShopImprest.jsp?lsistatic=0&type=1&lsid=<%=lsid%>','_self')" /> 　
      <input type="button" value="扣除配送金额" onclick="window.open('/jsp/leagueshop/EditLeagueShopImprest.jsp?lsistatic=3&type=1&lsid=<%=lsid%>','_self')" /> 　
      　<br><br>
      <input type="button" value="查询提货记录" onclick="window.open('/jsp/erp/ShopstockMember.jsp?lsid=<%=lsid%>','_self')" />　
      <input type="submit" value="导出"/> 　
      <input type=button value="返回" onClick="javascript:history.back()"/>
    </td>
    </tr>
    <%
    }
    %>

</table>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>应付账户余额：</td><td colspan="3">
    <%
    BigDecimal bbsum =  new BigDecimal("2000");
    if(obj.getSummoney()!=null)
    {
      if(bbsum.compareTo(obj.getSummoney())==1)
      {
        out.print("<font color=red>"+obj.getSummoney()+"</font>");
      }
      else
      {
        out.print(obj.getSummoney().abs());
      }
    }
    else
    {
      out.print("0.00");
    }
    %>　元 　　
    <%
    if(num==1)
    {
    }
    else
    {
      %>

      <%
      }
      %>
      </td>
  </tr>
  <tr>
    <td>应付配送余额：</td><td><%=LeagueShopImprest.dispatchMoney(" and lsid="+lsid)%>　元</td>
  </tr>
</table>
<%@include file="/jsp/include/Canlendar4.jsp"%>
</body>
</html>

