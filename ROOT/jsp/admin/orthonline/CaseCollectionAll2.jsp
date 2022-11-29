<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.admin.orthonline.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.*"%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);

String nexturl = request.getRequestURI()+"?"+request.getQueryString();
StringBuffer sql = new StringBuffer(" and type=1 ");
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession._strCommunity);
Date datetime =new Date();
sql.append(" ORDER BY regtime desc ");
//最新
%>
<form action="" name="form">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=request.getParameter("id")%>" >
<%
Enumeration eu = CaseCollection.findByCommunity(teasession._strCommunity,sql.toString(),0,5);
if(!eu.hasMoreElements())
{
  %>
<li>暂无消息</li><%
}
for(int i=0;eu.hasMoreElements();i++)
{
  int ccid = Integer.parseInt(String.valueOf(eu.nextElement()));
  CaseCollection ccobj = CaseCollection.find(ccid);
  %>
  <li>
    <span id="id1"><a href="/servlet/Node?node=2198563&language=1&ids=<%=ccid%>" target="_blank"><%if(ccobj.getCasename()!=null)out.print(ccobj.getCasename());%></a></span>
    <span id="id2"><%=ccobj.getRegtimetoString()%>
     <%
    CaseCollection.sdf.format(datetime);
    if(CaseCollection.sdf.format(datetime).equals(ccobj.getRegtimetoString()))
    {
      %>
      <img alt="" src="/tea/image/public/new.gif" />
      <%
    }

    %>

    </span>
  </li>
  <%
}
%>
</form>

