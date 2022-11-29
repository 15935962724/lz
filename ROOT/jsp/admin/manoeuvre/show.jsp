<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int manoeuvre = Integer.parseInt(request.getParameter("manoeuvre"));
Manoeuvre  obj = Manoeuvre.find(manoeuvre);
%>
<html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <script src="/tea/tea.js" type="text/javascript"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">
  </head>


  <body>

  <h1>文件会签</h1>
  <br>
  <div id="head6"><img height="6" src="about:blank"></div>


    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

      <tr >
        <td nowrap>调动人员</td>
         <td nowrap>
          <%
                tea.entity.member.Profile p = tea.entity.member.Profile.find(obj.getManmember());
                out.print(p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage));
            %>
         </td>
      </tr>
        <tr >
        <td nowrap>调动原因</td>
         <td nowrap><%=obj.getContent() %></td>
      </tr>
        <tr >
        <td nowrap>原职务</td>
         <td nowrap><%=obj.getFormerduty() %></td>
      </tr>
       <tr >
        <td nowrap>调动后职务</td>
         <td nowrap><%=obj.getBackduty() %></td>
      </tr>
  <tr >
        <td nowrap>调动时间</td>
         <td nowrap><%=obj.getTimesToString() %></td>
      </tr>
        <tr >
        <td nowrap>审核人员</td>
         <td nowrap>
            <%
                tea.entity.member.Profile p2 = tea.entity.member.Profile.find(obj.getAudmamber());
                out.print(p2.getLastName(teasession._nLanguage)+p2.getFirstName(teasession._nLanguage));
            %>
         </td>
      </tr>
        </table>
<tr align="center" class="TableControl">
      <td colspan="2">
        <input type="button" value="关闭"  onClick="javascript:window.close();">
      </td>
    </tr>
<br>


<div id="head6"><img height="6" src="about:blank"></div>
    </body>
  </html>



