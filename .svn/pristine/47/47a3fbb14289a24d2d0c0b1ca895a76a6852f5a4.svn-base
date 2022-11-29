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
String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}
int lsid = 0;
if(teasession.getParameter("lsid")!=null && teasession.getParameter("lsid").length()>0)
{
  lsid=Integer.parseInt(teasession.getParameter("lsid"));
}
int liid=0;
if(teasession.getParameter("liid")!=null && teasession.getParameter("liid").length()>0)
{
  liid = Integer.parseInt(teasession.getParameter("liid"));
}

LeagueShopImprest lsiobj = LeagueShopImprest.find(liid);

if(lsiobj.getLsid()!=0)
{
  lsid=lsiobj.getLsid();
}
int type=0;
if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0)
{
  type=Integer.parseInt(teasession.getParameter("type"));
}
if(lsiobj.isExists())
{
  type = lsiobj.getType();
}

LeagueShop objshop = LeagueShop.find(lsid);
BigDecimal bb =objshop.getSummoney();
int lsistatic=0;
if(teasession.getParameter("lsistatic")!=null && teasession.getParameter("lsistatic").length()>0)
{
  lsistatic=Integer.parseInt(teasession.getParameter("lsistatic"));
  if(lsiobj.isExists())
  {
    lsistatic=lsiobj.getLsistatic();
  }
}
else
{
  if(lsiobj.isExists())
  {
    lsistatic=lsiobj.getLsistatic();
  }
}
Date dd = new Date();
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
<script type="">
function sub_finds()
{
  if(form1.yfmoney.value=="")
  {
    document.form1.yfmoney.focus();
    alert("转账金额不能为空！！");
    return false;
  }
  if(form1.zzdate.value=="")
  {
    document.form1.zzdate.focus();
    alert("转账时间不能为空！");
    return false;
  }

  if(form1.payment.value=="" ||form1.payment.value=="0"  )
  {
    document.form1.payment.focus();
    alert("支付方式不能为空！");
    return false;
  }

//  if(form1.lsistatic.value!="2" && form1.type.value=="1" &&((parseInt(document.form1.yfmoney.value))>(parseInt(document.form1.bb.value))))
//  {
//    alert("退款金额不能超过账户余额！");
//    return false;
//  }
  if(form1.lsistatic.value=="2" && form1.type.value=="1" &&((parseInt(document.form1.yfmoney.value))>(parseInt(document.form1.bb.value))))
  {
    alert("冻结金额不能超过账户余额！");
    return false;
  }
  return true;
}
</script>
<title>分店财务管理</title>
</head>
<body>
<h1>分店财务管理</h1>
<%
if(lsistatic==0&&type==0)/** 0应付金额，1进货单，2冻结金额，3配送金额，4返还金额，5运费金额,6实付金额   lsistatic; ********/
{
  %><h2>添加分店应付款</h2><%
  }else if(type==1&&lsistatic==0)
  {
    %><h2>扣除分店应付款</h2><%
  }
  else if(type==1&&lsistatic==6)
  {
    %><h2>退还分店实付金额</h2><%
  }else if(lsistatic==2&&type==1)
  {
    %><h2>冻结分店应付款</h2><%
  }
  else if(lsistatic==3&&type==0)
  {
    %><h2>分店配送金额</h2><%
  }else if(lsistatic==3&&type==1)
  {
    %><h2>扣除分店配送金额</h2><%
  }
  else if(lsistatic==4)
  {
    %><h2>分店返还金额</h2><%
  }
  else if(lsistatic==5)
  {
    %><h2>分店运费</h2><%
  }else if(lsistatic==6)
  {
    %><h2>添加分店实付金额</h2><%
  }
  %>
  <form name="form1" action="/servlet/EditLeagueShop" method="POST" enctype="multipart/form-data">
  <input type="hidden" value="<%=lsid%>"   name="lsid"/>
  <input type="hidden" value="<%=liid%>"   name="idss"/>
  <input type="hidden" value="<%=type%>"   name="type"/>
  <input type="hidden" value="<%=lsistatic%>"   name="lsistatic"/>
  <input type="hidden" value="<%=bb.intValue()%>"   name="bb"/>
  <input type="hidden" value="EditLeagueShopImprest"   name="act"/>
  <TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
    <tr><td nowrap align="right">分店名称：</td><td nowrap><%if(objshop.getLsname()!=null)out.print(objshop.getLsname());%></td></tr>
    <tr><td nowrap align="right">摘要：</td>
      <td nowrap><input name="summary" value="<%
      if(lsiobj.getSummary()!=null)
      {out.print(lsiobj.getSummary());}
      else
      {
        if(lsistatic==0 && type==0)/** 0应付金额，1进货单，2冻结金额，3配送金额，4返还金额，5运费金额,6实付金额   lsistatic; ********/
        {
          %>添加应付款金额<%
          }else if(type==1 && lsistatic==0)
          {
            %>退还应付款金额<%
          }
          else if(type==1 && lsistatic==6)
          {
            %>退还实收金额<%
          }else if(lsistatic==2)
          {
            %>冻结应付款<%
          }
          else if(lsistatic==3&&type==0)
          {
            %>添加配送金额<%
          }else if(lsistatic==3&&type==1)
          {
            %>退还配送金额<%
          }
          else if(lsistatic==4)
          {
            %>返还金额<%
          }
          else if(lsistatic==5)
          {
            %>运费<%
          }else if(lsistatic==6&&type==0)
          {
            %>添加实收金额<%
          }
        }
          %>" />
      </td>
</tr>
    <tr><td nowrap align="right">金额：</td><td nowrap><input value="<%if(lsiobj.getYfmoney()!=null)out.print(lsiobj.getYfmoney());%>" name="yfmoney"  mask="float"/>　
    <%
    if( lsistatic==2 || lsistatic==0 )
    {
      if(objshop.getSummoney()!=null)
      {
        out.print("账户余额：<font color=red>"+objshop.getSummoney()+"</font>");
      }
      else
      {
        out.print("账户余额：<font color=red>0.00</font>");
      }
    }
    %>
     <%
    if( lsistatic==3 )
    {
      if(objshop.getDispatchmoney()!=null)
      {
        out.print("配送余额：<font color=red>"+objshop.getDispatchmoney()+"</font>");
      }
      else
      {
        out.print("配送余额：<font color=red>0.00</font>");
      }
    }
     if( lsistatic==6 )
    {
      if(objshop.getCostmoney()!=null)
      {
        out.print("实付金额：<font color=red>"+objshop.getCostmoney()+"</font>");
      }
      else
      {
        out.print("实付金额：<font color=red>0.00</font>");
      }
    }
    %>

    </td></tr>
    <%if(lsistatic==6)
    {
      %>
      <tr><td nowrap align="right">转账时间：</td><td nowrap> <input name="zzdate" size="7"  value="<%if(lsiobj.getZzdatetoString()!=null)out.print(lsiobj.getZzdatetoString());%>"><A href="###"><img onclick="showCalendar('form1.zzdate');" src="/tea/image/public/Calendar2.gif" align="top"/></a></td></tr>
         <tr>
          <td nowrap="nowrap" align="right">支付方式：</td>
          <td>
            <select name="payment"></option>
            <%
            for(int i =0;i<LeagueShopImprest.PAYMENT.length;i++)
            {
              out.print("<option  value="+i);
              if(lsiobj.getPayment()==i)
              {
                out.print("   and selected ");
              }
              out.print(">"+LeagueShopImprest.PAYMENT[i]+"</option>");
            }
            %>
            </select></td>
        </tr>
      <%
      }else
      {
        %>
        <input type="hidden" name="zzdate" size="7"  value="<%=LeagueShopImprest.sdf.format(dd)%>">
        <input type="hidden" name="payment" value="0">
        <%
        }
        %>

        <tr><td nowrap="nowrap" align="right">备注：</td><td><textarea name="info" cols="18" rows="4"><%if(lsiobj.getInfo()!=null)out.print(lsiobj.getInfo());%></textarea></td></tr>
        <tr><td nowrap colspan="3" align="center"><input type="submit" value="提交" onclick="return sub_finds();" />　<input type=button value="返回" onClick="javascript:history.back()"/></td></tr>
</table>
  </form>
  <%@include file="/jsp/include/Canlendar4.jsp" %>
</body>
</html>

