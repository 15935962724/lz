<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.member.Profile" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms" />
<%
TeaSession teasession = new TeaSession(request);
Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/Node?node=&language=1");
  return ;
}

int role = 0;
if(request.getParameter("role")!=null && request.getParameter("role").length()>0)
   role = Integer.parseInt(request.getParameter("role"));
String nexturl =  request.getParameter("nexturl");//"/jsp/user/AuditingMember.jsp?role="+role;
int amid =Integer.parseInt(request.getParameter("amid"));
//AuditingMember amobj = AuditingMember.find(amid);
Company obj = Company.find(amid);
String act = request.getParameter("act");
if("EditD".equals(act))
{
  int grade = Integer.parseInt(request.getParameter("grade"));
  int compositor=Integer.parseInt(request.getParameter("compositor"));
  int credit = 0;
  if(request.getParameter("credit")!=null && request.getParameter("credit").length()>0)
  credit= Integer.parseInt(request.getParameter("credit"));
  obj.set(grade,compositor,credit,teasession._nLanguage);
  response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode("等级设置成功!", "UTF-8")+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));
  return;
}

  %>
  <html>
  <HEAD>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">
  </HEAD>
  <body bgcolor="#ffffff">
    <h1>设置供应商级别</h1>
    <div id="head6"><img height="6" src="about:blank"alt=""></div>
      <form id="form1" action="?" method="post">
       <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
       <input type="hidden" name="amid" value="<%=amid%>" />
       <input type="hidden" name="act" value="EditD" />
       <input type="hidden" name="role" value="<%=role%>" />
       <input type="hidden" name="nexturl" value="<%=nexturl%>" />
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
          <td >等级</td>
          <td >
          <select name="grade">
          <%
            for(int j=0;j<Company.GRADE_TYPE.length;j++)
            {
              out.print("<option value="+j);
              if(obj.getGrade(teasession._nLanguage)==j)
                 out.print(" selected");
              out.print(">"+Company.GRADE_TYPE[j]);
              out.print("</option>");
            }
          %>
          </select>
          </td>
        </tr>
        <tr>
          <td >排序</td>
          <td >
          <select name="compositor">
          <%
            for(int i =0;i<100;i++)
            {
              out.print("<option value="+i);
               if(obj.getCompositor(teasession._nLanguage)==i)
                 out.print(" selected");
              out.print(">"+i);
              out.print("</option>");
            }
          %>
          </select>
          </td>
        </tr>
        <tr>
          <td >信誉额度</td>
          <td ><input type="text" name="credit" value="<%if(obj.getCredit(teasession._nLanguage)!=0)out.print(obj.getCredit(teasession._nLanguage));else out.print("100");%>" /></td>
        </tr>
        <tr >
          <td align="center" colspan="2"><input type="submit" value="设置" />&nbsp;&nbsp;&nbsp;<input type=button value="返回" onClick="javascript:history.back()"></td>

        </tr>
      </table>

      </form>

  </body>
  </html>
