<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.ui.TeaSession"%>
<jsp:directive.page import="java.math.BigDecimal"/>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
if (teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

String tmp;
String community = teasession._strCommunity;
String nexturl=request.getParameter("nexturl");
int flowitem = 0;
if (request.getParameter("flowitem") != null && request.getParameter("flowitem").length() > 0)
flowitem = Integer.parseInt(request.getParameter("flowitem"));
int workproject = 0;
if (request.getParameter("workproject") != null && request.getParameter("workproject").length() > 0)
workproject = Integer.parseInt(request.getParameter("workproject"));
//添加项目
if (request.getMethod().equals("POST") || request.getParameter("delete") != null)
{
  String name = request.getParameter("name");

  java.util.Date nextcosttime = Flowitem.sdf.parse(request.getParameter("nextcosttimeYear") + "-" + request.getParameter("nextcosttimeMonth") + "-" + request.getParameter("nextcosttimeDay"));

  Flowitem obj = Flowitem.find(flowitem);
  obj.setNameAndNext(name,nextcosttime,teasession._nLanguage );
  response.sendRedirect(nexturl);
  return;
}
Resource r = new Resource();
String name = null, content = null, manager = null, member = null, pact = null;
java.util.Date ftime = null;
int itemgenre = 0, cost = 0, overallmoney = 0;
BigDecimal vindicate = new BigDecimal(0);
java.util.Date nextcosttime = null;
if (flowitem != 0)
{
  Flowitem obj = Flowitem.find(flowitem);
  name = obj.getName(teasession._nLanguage);
  nextcosttime = obj.getNextcosttime();
}else
{
  name = content = manager = member = "";
}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">
        <script>
        function defaultfocus()
        {
          form1.name.focus();
        }
        function f_submit()
        {
          var s1_o=form1.manager1.options;
          for(var i=0;i<s1_o.length;i++)
          {
            form1.manager.value=form1.manager.value+s1_o[i].value+"/";
          }
          var s2_o=form1.member1.options;
          for(var i=0;i<s2_o.length;i++)
          {
            form1.member.value=form1.member.value+s2_o[i].value+"/";
          }
          return submitText(form1.name, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-<%=r.getString(teasession._nLanguage,"ProjectName")%>')&&submitText(form1.workproject, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-客户');
        }
        </script>
        </head>
        <body onLoad="defaultfocus();">
        <h1><%=r.getString(teasession._nLanguage, "EditPaymentDate")%></h1>
        <div id="head6">
          <img height="6" src="about:blank">
        </div>
        <br/>
        <form name="form1" action="<%=request.getRequestURI()%>" method="post" onSubmit="return f_submit();">
        <input type=hidden name="flowitem" value="<%=flowitem%>"/>
        <input type=hidden name="community" value="<%=community%>"/>
        <input type=hidden name="nexturl" value="<%=nexturl%>"/>


        <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr>
            <td align="right" width="50%"><%=r.getString(teasession._nLanguage, "ProjectName")%>:</td>
            <td nowrap>      　
              <input name="name" type="hidden" value="<%=name%>" size="40">
              <%=name %>
            </td>
          </tr>
          <tr>
            <td align="right"><%=r.getString(teasession._nLanguage, "Nextcosttime")%>:</td>
            <td nowrap>      　
              <%=new tea.htmlx.TimeSelection("nextcosttime", nextcosttime)%>    </td>
          </tr>
          <tr>
        </table>
        <br />
        <input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
        <input type="reset" value="<%=r.getString(teasession._nLanguage, "Reset")%>" onClick="defaultfocus();">
        <input type="button" value="<%=r.getString(teasession._nLanguage, "Back")%>" onClick="history.back();">
        </form>
        <br>
        <div id="head6">
          <img height="6" src="about:blank">
        </div>
        </body>
</html>
