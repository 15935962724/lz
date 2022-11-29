<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.member.Profile" %>
<%@page import="tea.entity.admin.*" %>
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
   String nexturl =  "/jsp/user/AuditingMember2.jsp?role="+role;
   StringBuffer param=new StringBuffer("&community="+teasession._strCommunity);
   StringBuffer sql=new StringBuffer(" and role="+role+"  and type =2 ");
   param.append("&role=").append(role);
   param.append("&id=").append(request.getParameter("id"));
   int count=AuditingMember.count(teasession._strCommunity,sql.toString());
int pagesize = 10;
int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
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
  <script type="">
  function shenhe(igd)
  {
    if(confirm('您确认要执行此操作吗！'))
    {
      form1.amid.value=igd;
      //form1.act.value="shenhe";
      form1.action='/jsp/user/Auditing.jsp?act=set';
      form1.submit();
    }
  }
  </script>
    <h1>用户审核</h1>
    <div id="head6"><img height="6" src="about:blank"alt=""></div>
      <form id="form1" action="?" method="post">
       <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
       <input type="hidden" name="amid" />
       <input type="hidden" name="role" value="<%=role%>" />
       <input type="hidden" name="nexturl" value="<%=nexturl%>" />
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr id="tablecenter">
          <td nowrap="nowrap">用户ID</td>
            <td nowrap="nowrap">所属公司</td>
          <td nowrap="nowrap">注册时间</td>
          <td nowrap="nowrap">操作</td>
        </tr>
        <%
        java.util.Enumeration e = AuditingMember.find(teasession._strCommunity,sql.toString(),pos,pagesize);
        if(!e.hasMoreElements())
        {
          out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
        }
            while(e.hasMoreElements())
            {
              int id = ((Integer)e.nextElement()).intValue();
              AuditingMember obj = AuditingMember.find(id);
              Profile p = Profile.find(obj.getMember());
              tea.entity.node.Node n = tea.entity.node.Node.find(obj.getNode());
        %>
        <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
          <td><%=obj.getMember()%></td>
          <td><a href="/jsp/user/regPtqyShow.jsp?node=<%=obj.getNode()%>"><%
          out.print(n.getSubject(teasession._nLanguage));
          %></a></td>
          <td><%=obj.getTimeToString()%></td>
          <td>
             <input type="button" name="" value="审核" onclick="shenhe('<%=id%>');" />
          </td>
        </tr>
        <%
            } if(count>pagesize){
            %>
            <tr><td colspan="10" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,pagesize)%></td></tr>

            <%}%>
      </table>
      </form>
      <script language="JavaScript">
      </script>
  </body>
  </html>
