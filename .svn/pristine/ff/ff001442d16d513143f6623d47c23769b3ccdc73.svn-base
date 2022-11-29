<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.entity.node.*"%>
<%@ page import="tea.html.*"%>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.resource.*"%>
<%@ page import="tea.ui.TeaServlet"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@page import="javax.mail.*" %>
<%@ page import="java.net.Socket"%>
<%@page import="javax.mail.internet.*" %>
<%@ page import=" tea.db.DbAdapter"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.entity.util.*"%>
<%@ page import="tea.entity.site.*"%>
<%@ page import="tea.ui.member.order.*"%>
<%@ page import="tea.http.RequestHelper"%>

<%@ page import="java.io.PrintWriter"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="tea.entity.RV"%>
<%
TeaSession teasession = new TeaSession(request);
tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
tea.resource.Resource r=new tea.resource.Resource();
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBNewCustom")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <FORM name=foNew METHOD=POST action="/servlet/NewApp" ENCtype=multipart/form-data onSubmit="return(submitText(this.xm, '姓名不能为空')&&submitText(this.File, '简历不能为空'));">
    <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
    <input type='hidden' name=Type VALUE="<%=request.getParameter("Type")%>">
    <input type='hidden' name=TypeAlias VALUE="<%=request.getParameter("TypeAlias")%>">
      <%
      if(request.getParameter("NewNode")!=null)
      {
        out.println("<input type=hidden name=NewNode value=ON >");
      }
      %>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td>*<%=r.getString(teasession._nLanguage, "Name")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=xm VALUE="" SIZE=20 MAXLENGTH=20></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Sex")%>:</td>
        <td><input   id="radio" type="radio" name=xb VALUE=<%=r.getString(teasession._nLanguage, "Man")%> CHECKED>
          <%=r.getString(teasession._nLanguage, "Man")%>
          <input   id="radio" type="radio" name=xb VALUE=<%=r.getString(teasession._nLanguage, "Woman")%>>
          <%=r.getString(teasession._nLanguage, "Woman")%></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "IssueTime")%>:</td>
        <td><SELECT name=IssueYear>
            <%for( int value=1900;value<2000;value++)
{%>
            <OPTION VALUE="<%=value%>"><%=value%></OPTION>
            <%}%>
          </SELECT>
          <SELECT name=IssueMonTD>
            <OPTION VALUE="1">1</OPTION>
            <OPTION VALUE="2">2</OPTION>
            <OPTION VALUE="3">3</OPTION>
            <OPTION VALUE="4">4</OPTION>
            <OPTION VALUE="5">5</OPTION>
            <OPTION VALUE="6">6</OPTION>
            <OPTION SELECTED VALUE="7">7</OPTION>
            <OPTION VALUE="8">8</OPTION>
            <OPTION VALUE="9">9</OPTION>
            <OPTION VALUE="10">10</OPTION>
            <OPTION VALUE="11">11</OPTION>
            <OPTION VALUE="12">12</OPTION>
          </SELECT>
          <SELECT name=IssueDay>
            <OPTION VALUE="1">1</OPTION>
            <OPTION VALUE="2">2</OPTION>
            <OPTION VALUE="3">3</OPTION>
            <OPTION VALUE="4">4</OPTION>
            <OPTION VALUE="5">5</OPTION>
            <OPTION VALUE="6">6</OPTION>
            <OPTION VALUE="7">7</OPTION>
            <OPTION VALUE="8">8</OPTION>
            <OPTION VALUE="9">9</OPTION>
            <OPTION VALUE="10">10</OPTION>
            <OPTION VALUE="11">11</OPTION>
            <OPTION VALUE="12">12</OPTION>
            <OPTION VALUE="13">13</OPTION>
            <OPTION VALUE="14">14</OPTION>
            <OPTION SELECTED VALUE="15">15</OPTION>
            <OPTION VALUE="16">16</OPTION>
            <OPTION VALUE="17">17</OPTION>
            <OPTION VALUE="18">18</OPTION>
            <OPTION VALUE="19">19</OPTION>
            <OPTION VALUE="20">20</OPTION>
            <OPTION VALUE="21">21</OPTION>
            <OPTION VALUE="22">22</OPTION>
            <OPTION VALUE="23">23</OPTION>
            <OPTION VALUE="24">24</OPTION>
            <OPTION VALUE="25">25</OPTION>
            <OPTION VALUE="26">26</OPTION>
            <OPTION VALUE="27">27</OPTION>
            <OPTION VALUE="28">28</OPTION>
            <OPTION VALUE="29">29</OPTION>
            <OPTION VALUE="30">30</OPTION>
            <OPTION VALUE="31">31</OPTION>
          </SELECT></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "xl1")%>:</td>
        <td><SELECT name=xl>
            <OPTION VALUE="博士研究生">博士研究生</OPTION>
            <OPTION VALUE="硕士研究生">硕士研究生</OPTION>
            <OPTION VALUE="本科">本科</OPTION>
            <OPTION VALUE="大专">大专</OPTION>
            <OPTION VALUE="高中及以下">高中及以下</OPTION>
          </SELECT></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "xw")%>:</td>
        <td><SELECT name=xw>
            <OPTION VALUE="博士">博士</OPTION>
            <OPTION VALUE="硕士">硕士</OPTION>
            <OPTION VALUE="学士">学士</OPTION>
            <OPTION VALUE="双学士">双学士</OPTION>
          </SELECT></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "zw")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=zw VALUE="" SIZE=20 MAXLENGTH=20></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "phone1")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=phone VALUE="" SIZE=20 MAXLENGTH=20></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "xdw")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=xdw VALUE="" SIZE=20 MAXLENGTH=20></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "xbw")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=xbm VALUE="" SIZE=20 MAXLENGTH=20></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "xgw")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=xgw VALUE="" SIZE=20 MAXLENGTH=20></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "csny")%>:</td>
        <td><SELECT name=cjgzrqYear>
            <OPTION VALUE="1999">1999</OPTION>
            <OPTION VALUE="2000">2000</OPTION>
            <OPTION VALUE="2001">2001</OPTION>
            <OPTION VALUE="2002">2002</OPTION>
            <OPTION SELECTED VALUE="2003">2003</OPTION>
            <OPTION VALUE="2004">2004</OPTION>
            <OPTION VALUE="2005">2005</OPTION>
            <OPTION VALUE="2006">2006</OPTION>
            <OPTION VALUE="2007">2007</OPTION>
          </SELECT>
          <SELECT name=cjgzrqMonTD>
            <OPTION VALUE="1">1</OPTION>
            <OPTION VALUE="2">2</OPTION>
            <OPTION VALUE="3">3</OPTION>
            <OPTION VALUE="4">4</OPTION>
            <OPTION VALUE="5">5</OPTION>
            <OPTION VALUE="6">6</OPTION>
            <OPTION SELECTED VALUE="7">7</OPTION>
            <OPTION VALUE="8">8</OPTION>
            <OPTION VALUE="9">9</OPTION>
            <OPTION VALUE="10">10</OPTION>
            <OPTION VALUE="11">11</OPTION>
            <OPTION VALUE="12">12</OPTION>
          </SELECT>
          <SELECT name=cjgzrqDay>
            <OPTION VALUE="1">1</OPTION>
            <OPTION VALUE="2">2</OPTION>
            <OPTION VALUE="3">3</OPTION>
            <OPTION VALUE="4">4</OPTION>
            <OPTION VALUE="5">5</OPTION>
            <OPTION VALUE="6">6</OPTION>
            <OPTION VALUE="7">7</OPTION>
            <OPTION VALUE="8">8</OPTION>
            <OPTION VALUE="9">9</OPTION>
            <OPTION VALUE="10">10</OPTION>
            <OPTION VALUE="11">11</OPTION>
            <OPTION VALUE="12">12</OPTION>
            <OPTION VALUE="13">13</OPTION>
            <OPTION VALUE="14">14</OPTION>
            <OPTION SELECTED VALUE="15">15</OPTION>
            <OPTION VALUE="16">16</OPTION>
            <OPTION VALUE="17">17</OPTION>
            <OPTION VALUE="18">18</OPTION>
            <OPTION VALUE="19">19</OPTION>
            <OPTION VALUE="20">20</OPTION>
            <OPTION VALUE="21">21</OPTION>
            <OPTION VALUE="22">22</OPTION>
            <OPTION VALUE="23">23</OPTION>
            <OPTION VALUE="24">24</OPTION>
            <OPTION VALUE="25">25</OPTION>
            <OPTION VALUE="26">26</OPTION>
            <OPTION VALUE="27">27</OPTION>
            <OPTION VALUE="28">28</OPTION>
            <OPTION VALUE="29">29</OPTION>
            <OPTION VALUE="30">30</OPTION>
            <OPTION VALUE="31">31</OPTION>
          </SELECT></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "mobile")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=mobile VALUE="" SIZE=20 MAXLENGTH=20></td>
      </tr>
      <tr>
        <td>*E-Mail:</td>
        <td><input type="TEXT" class="edit_input"  name=email VALUE="" SIZE=41></td>
      </tr>
      <tr>
        <td>*<%=r.getString(teasession._nLanguage, "File")%>:</td>
        <td COLSPAN=6><input type="file" name="File" class="edit_input"/></td>
      </tr>
    </table>
    <input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
  </FORM>
  <SCRIPT>document.foNew.xm.focus();</SCRIPT>
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

