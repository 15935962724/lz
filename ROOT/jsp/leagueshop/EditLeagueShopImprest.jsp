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
    alert("??????????????????????????????");
    return false;
  }
  if(form1.zzdate.value=="")
  {
    document.form1.zzdate.focus();
    alert("???????????????????????????");
    return false;
  }

  if(form1.payment.value=="" ||form1.payment.value=="0"  )
  {
    document.form1.payment.focus();
    alert("???????????????????????????");
    return false;
  }

//  if(form1.lsistatic.value!="2" && form1.type.value=="1" &&((parseInt(document.form1.yfmoney.value))>(parseInt(document.form1.bb.value))))
//  {
//    alert("???????????????????????????????????????");
//    return false;
//  }
  if(form1.lsistatic.value=="2" && form1.type.value=="1" &&((parseInt(document.form1.yfmoney.value))>(parseInt(document.form1.bb.value))))
  {
    alert("???????????????????????????????????????");
    return false;
  }
  return true;
}
</script>
<title>??????????????????</title>
</head>
<body>
<h1>??????????????????</h1>
<%
if(lsistatic==0&&type==0)/** 0???????????????1????????????2???????????????3???????????????4???????????????5????????????,6????????????   lsistatic; ********/
{
  %><h2>?????????????????????</h2><%
  }else if(type==1&&lsistatic==0)
  {
    %><h2>?????????????????????</h2><%
  }
  else if(type==1&&lsistatic==6)
  {
    %><h2>????????????????????????</h2><%
  }else if(lsistatic==2&&type==1)
  {
    %><h2>?????????????????????</h2><%
  }
  else if(lsistatic==3&&type==0)
  {
    %><h2>??????????????????</h2><%
  }else if(lsistatic==3&&type==1)
  {
    %><h2>????????????????????????</h2><%
  }
  else if(lsistatic==4)
  {
    %><h2>??????????????????</h2><%
  }
  else if(lsistatic==5)
  {
    %><h2>????????????</h2><%
  }else if(lsistatic==6)
  {
    %><h2>????????????????????????</h2><%
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
    <tr><td nowrap align="right">???????????????</td><td nowrap><%if(objshop.getLsname()!=null)out.print(objshop.getLsname());%></td></tr>
    <tr><td nowrap align="right">?????????</td>
      <td nowrap><input name="summary" value="<%
      if(lsiobj.getSummary()!=null)
      {out.print(lsiobj.getSummary());}
      else
      {
        if(lsistatic==0 && type==0)/** 0???????????????1????????????2???????????????3???????????????4???????????????5????????????,6????????????   lsistatic; ********/
        {
          %>?????????????????????<%
          }else if(type==1 && lsistatic==0)
          {
            %>?????????????????????<%
          }
          else if(type==1 && lsistatic==6)
          {
            %>??????????????????<%
          }else if(lsistatic==2)
          {
            %>???????????????<%
          }
          else if(lsistatic==3&&type==0)
          {
            %>??????????????????<%
          }else if(lsistatic==3&&type==1)
          {
            %>??????????????????<%
          }
          else if(lsistatic==4)
          {
            %>????????????<%
          }
          else if(lsistatic==5)
          {
            %>??????<%
          }else if(lsistatic==6&&type==0)
          {
            %>??????????????????<%
          }
        }
          %>" />
      </td>
</tr>
    <tr><td nowrap align="right">?????????</td><td nowrap><input value="<%if(lsiobj.getYfmoney()!=null)out.print(lsiobj.getYfmoney());%>" name="yfmoney"  mask="float"/>???
    <%
    if( lsistatic==2 || lsistatic==0 )
    {
      if(objshop.getSummoney()!=null)
      {
        out.print("???????????????<font color=red>"+objshop.getSummoney()+"</font>");
      }
      else
      {
        out.print("???????????????<font color=red>0.00</font>");
      }
    }
    %>
     <%
    if( lsistatic==3 )
    {
      if(objshop.getDispatchmoney()!=null)
      {
        out.print("???????????????<font color=red>"+objshop.getDispatchmoney()+"</font>");
      }
      else
      {
        out.print("???????????????<font color=red>0.00</font>");
      }
    }
     if( lsistatic==6 )
    {
      if(objshop.getCostmoney()!=null)
      {
        out.print("???????????????<font color=red>"+objshop.getCostmoney()+"</font>");
      }
      else
      {
        out.print("???????????????<font color=red>0.00</font>");
      }
    }
    %>

    </td></tr>
    <%if(lsistatic==6)
    {
      %>
      <tr><td nowrap align="right">???????????????</td><td nowrap> <input name="zzdate" size="7"  value="<%if(lsiobj.getZzdatetoString()!=null)out.print(lsiobj.getZzdatetoString());%>"><A href="###"><img onclick="showCalendar('form1.zzdate');" src="/tea/image/public/Calendar2.gif" align="top"/></a></td></tr>
         <tr>
          <td nowrap="nowrap" align="right">???????????????</td>
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

        <tr><td nowrap="nowrap" align="right">?????????</td><td><textarea name="info" cols="18" rows="4"><%if(lsiobj.getInfo()!=null)out.print(lsiobj.getInfo());%></textarea></td></tr>
        <tr><td nowrap colspan="3" align="center"><input type="submit" value="??????" onclick="return sub_finds();" />???<input type=button value="??????" onClick="javascript:history.back()"/></td></tr>
</table>
  </form>
  <%@include file="/jsp/include/Canlendar4.jsp" %>
</body>
</html>

