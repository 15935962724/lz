<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="java.util.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.math.BigDecimal" %>
<%@page import="java.io.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);
TeaSession teasession = new TeaSession(request);

Bperson b = Bperson.findmember(teasession._rv._strR);
%>
<HTML>
  <HEAD>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <title>B-picture</title>


  <style>
  #table005{width:95%;margin-top:15px;}
  #table005 td{background:#eee;padding:6px;}
  </style>
</head>
<body style="margin:0;">
<div id="wai">
<div id="li_biao"><a href="http://bp.redcome.com" target="_top">首页</a>&nbsp;>&nbsp;<a href="http://bp.redcome.com/jsp/bpicture/" target="_top">管理中心</a>&nbsp;>&nbsp;付款信息</div>

  <h1>付款信息</h1>
  <table cellpadding="0" cellspacing="2" id="table005">

    <tr>
      <td colspan="2">您的付款信息 - <input type="button" value="更改" onclick="window.open('/jsp/bpicture/saler/ChangePayDetail.jsp','_self');" id="link">
</td>
    </tr>

    <tr>
      <td width="200" align="right">
      付款方法
      </td>
      <td>
      <%if(b.getPayStyle()==0){
        out.print("支票");
      }else if(b.getPayStyle()==1){
        out.print("转帐");
      }else{
        out.print("&nbsp;");
      }%>
      </td>
    </tr>
    <!--<tr>
    <td>
    货币类型
    </td>
    <td>
    <%if(b.getMoneytype()==1){
        out.print("人民币");
      }else if(b.getMoneytype()==2){
        out.print("美元");
      }else if(b.getMoneytype()==3){
        out.print("英镑");
      }else if(b.getMoneytype()==4){
        out.print("欧元");
      }else{
        out.print("其他");
      }
      %>
    </td>
    </tr>-->
    <tr>
    <td colspan="2" height="5"></td>
    </tr>
    </table>

    <div id="cheque" <%if(b.getPayStyle()!=0){out.print("style=\"display:none;\"");}%>>
    <h2>支票信息</h2>
    <table cellpadding="0" cellspacing="2" id="table005">
    <tr>
      <td width="200" align="right">
      支票收款人
      </td>
      <td><%if(b.getChequePayee()!=null)out.print(b.getChequePayee());%></td>
    </tr>
    <tr>
      <td align="right">发送支票地址</td>
      <td><%if(b.getChequeCounty()!=null)out.print(b.getChequeCounty());%></td>
    </tr>
    <tr>
      <td>　</td>
      <td><%if(b.getChequeCity()!=null)out.print(b.getChequeCity());%></td>
    </tr>
    <tr>
      <td>　</td>
      <td><%if(b.getChequeAddr()!=null)out.print(b.getChequeAddr());%></td>
    </tr>
    <tr>
      <td align="right">邮编</td>
      <td><%if(b.getChequeZip()!=null)out.print(b.getChequeZip());%></td>
    </tr>

  </table>
  </div>

  <div id="transfer" <%if(b.getPayStyle()!=1){out.print("style=\"display:none;\"");}%>>
    <h2>转帐信息</h2>
    <table cellpadding="0" cellspacing="2" id="table005">
    <tr>
      <td width="200" align="right">
      开户行
      </td>
      <td><%if(b.getBank()!=null)out.print(b.getBank());%></td>
    </tr>
    <tr>
      <td align="right">户名</td>
      <td><%if(b.getAccount()!=null)out.print(b.getAccount());%></td>
    </tr>
    <tr>
      <td align="right">帐号</td>
      <td><%if(b.getAccountnum()!=0)out.print(b.getAccountnum());%></td>
    </tr>
  </table>
  </div>

  <div id="invoice" <%if(b.getInvmen()!=null){out.print("style=\"\"");}else{out.print("style=\"display:none;\"");}%>>
    <h2>发票信息</h2>
    <table cellpadding="0" cellspacing="2" id="table005">
    <tr>
      <td width="200" align="right">
      收件人
      </td>
      <td><%if(b.getInvmen()!=null)out.print(b.getInvmen());%></td>
    </tr>
    <tr>
      <td align="right">地址</td>
      <td><%if(b.getInvaddr()!=null)out.print(b.getInvaddr());%></td>
    </tr>
    <tr>
      <td align="right">邮编</td>
      <td><%if(b.getInvzip()!=null)out.print(b.getAccountnum());%></td>
    </tr>
    <tr>
      <td align="right">公司名</td>
      <td><%if(b.getInvcomname()!=null)out.print(b.getInvcomname());%></td>
    </tr>
  </table>
  </div>

  </div>
  </body>
</HTML>

