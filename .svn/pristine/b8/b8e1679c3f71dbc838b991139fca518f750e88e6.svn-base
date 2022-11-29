<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.node.Hotel_application"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.node.*"%>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
int rigd = Integer.parseInt(teasession.getParameter("rigd"));
//Job j = Job.find(rigd,teasession._nLanguage);
Node n2 = Node.find(rigd);
      %>


　 <style type="text/css">
　　
　
　　 a:hover { text-decoration:underline;color: red}
　


　　</style>
      <span id="li_biaoti"><%=n2.getSubject(teasession._nLanguage)%></span>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

        <tr id="tableonetr">
          <td nowrap="nowrap">职位名称</td>
          <td nowrap="nowrap">工作地点</td>
          <td nowrap="nowrap">截止日期</td>
          <td nowrap="nowrap">招聘人数</td>
        </tr>
        <%

        java.util.Enumeration e = Job.findByOrg(rigd);
        while(e.hasMoreElements())
        {
          int node = ((Integer)e.nextElement()).intValue();
         Node n = Node.find(node);
         Job job = Job.find(node,teasession._nLanguage);
          %>
          <tr>
            <td><A HREF="/servlet/Job?node=<%=node%>&language=1" TARGET="_self"><%=n.getSubject(teasession._nLanguage) %></A></td>
            <td><%=job.getLocIdToHtml() %></td>
            <td><%=job.getValidityDateToString() %></td>
            <td><%if(job.getHeadCount()==0){out.print("---");}else {out.print(String.valueOf(job.getHeadCount()));}%></td>
          </tr>

          <%} %>

      </table>
