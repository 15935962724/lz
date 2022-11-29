<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/Header.jsp"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.ui.TeaSession"%>
<%
  request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);
  DbAdapter db = new DbAdapter();
%>
<html>
<head>
<SCRIPT type="">
    function checkBoxValidator()
    {
      for(var i = 0; i < document.addlayer.elements.length; i++)
      {
        var e = document.addlayer.elements[i];
        if((e.type == 'checkbox') && (e.checked == true) )
        {
          return true;
        }
      }
      alert("请至少选择一种催办方式");
      return false;
    }
    </SCRIPT>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body id="bodynone">
<div id="head6">
  <img height="6" src="about:blank" alt="">
</div>
<form name="addlayer" action="/servlet/adddestineinfo" onsubmit="return checkBoxValidator()">
<div id="jspbefore" style="display:none"></div>
<div id="tablebgnone" class="register">
  <h1>催办信息</h1>
  <table border="1" cellpadding="0" cellspacing="0" width="30%" align="center" id="tablecenter">
    <tr>
      <TD align="center">订单号：</TD>
      <td align="center">
        <font color="#DF451C">
          <strong><%=teasession.getParameter("destine")%>          </strong>
        </font>
        <input type="hidden" name="nodeid" value="<%=request.getParameter("node")%>"/>
        <input type="hidden" name="destine" value="<%=teasession.getParameter("destine")%>"/>
      </td>
    </tr>
    <tr>
      <TD align="center">酒店名称：</td>
      <td align="center"><%=teasession.getParameter("name")%>        <input type="hidden" name="hotelname" value="<%=teasession.getParameter("name")%>"/>
      </TD>
    </tr>
    <tr>
      <TD align="center">催办人：</td>
      <td align="center">
        <strong><%=teasession._rv.toString()%>        </strong>
        <input type="hidden" name="rcreator" value="<%=teasession._rv.toString()%>"/>
      </TD>
    </tr>
  <%
    String mobile;
    String email;
    mobile = HotelMethod.findRcMobile(teasession._rv.toString());
    email = HotelMethod.findRcEmail(teasession._rv.toString());
  %>
    <tr>
      <TD align="center">联系电话：</td>
      <td align="center">
      <%
        if (mobile.equals("")) {
          out.println("无");
        }
        else {
          out.println(mobile);
        }
      %>
      </TD>
    </tr>
    <tr>
      <TD align="center">Email：</td>
      <td align="center">
      <%
        if (email.equals("")) {
          out.println("无");
        }
        else {
          out.println(email);
        }
      %>
      </TD>
    </tr>
    <tr>
      <TD align="center">催办方式：</TD>
      <td align="center">
        <input type="checkbox" name="domethod" value="1"/>
        打电话
        <input type="checkbox" name="domethod" value="2"/>
        发邮件
      </td>
    </tr>
    <tr>
      <TD align="center" rowspan="3">备注：</TD>
      <td align="center" rowspan="3" width="60%">
        <textarea cols="75" rows="3" name="remark">        </textarea>

    </tr>
  </table>
  <br/>
  <center>
    <input type="submit" value="添加催办信息"/>
    <input type="reset" value="重新输入"/>
  </center>
  <br/>
  <br/>
  <br/>
  <br/>
<%
  SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd HHmmss");
  try {
    db.executeQuery("SELECT destine, hotelname, rcreator, domethod, nowdate FROM DestineorderInfo");
%>
  <table border="1" cellpadding="0" cellspacing="0" width="30%" align="center" id="tablecenter">
    <tr>
      <td colspan="5" align="center">
        <strong>催办记录</strong>
      </td>
    </tr>
    <tr>
      <td align="center">订单号</td>
      <td align="center">酒店名称</td>
      <td align="center">催办人</td>
      <td align="center">催办方式</td>
      <td align="center">催办时间</td>
    </tr>
  <%
    int pos = 0;
    int pageSize = 20;
    if (teasession.getParameter("Pos") != null) {
      pos = Integer.parseInt(teasession.getParameter("Pos"));
    }
    java.util.Enumeration e = HotelMethod.findCbInfo(pos, pageSize);
    if (!e.hasMoreElements()) {
      out.print("<tr><td align=center colspan=5>暂无催办记录</td></tr>");
    }
    while (db.next()) {
  %>
    <tr>
      <td align="center"><%=db.getInt(1) %>      </td>
      <td align="center"><%=db.getString(2) %>      </td>
      <td align="center"><%=db.getString(3) %>      </td>
      <td align="center">
      <%
        if (db.getString(4).equals("1")) {
          out.println("打电话");
        }
        else if (db.getString(4).equals("2")) {
          out.println("发邮件");
        }
        else {
          out.println("打电话，发邮件");
        }
      %>
      </td>
      <td align="center"><%=sdf.format(db.getDate(5)).substring(0,4) + "年" +
            sdf.format(db.getDate(5)).substring(4,6) + "月" +
            sdf.format(db.getDate(5)).substring(6,8) + "日    " +
            sdf.format(db.getDate(5)).substring(9,11) + "时" +
            sdf.format(db.getDate(5)).substring(11,13) + "分" +
            sdf.format(db.getDate(5)).substring(13,15) + "秒" %>      </td>
    </tr>
  <%}  %>
  </table>
<%
  } catch (java.sql.SQLException e) {
    e.printStackTrace();
  }
  finally {
    db.close();
  }
%>
</div>
</form>
<div id="jspafter" style="display:none"></div>
<div id="head6">
  <img height="6" src="about:blank" alt="">
</div>
</body>
</html>
