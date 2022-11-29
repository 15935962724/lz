<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.util.*"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.netdisk.*"%>
<%@page import="tea.ui.TeaSession"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/NetDisk");


String ps[]=request.getParameterValues("paths");

String base=request.getParameter("base");
String path=request.getParameter("path");

String act=request.getParameter("act");

NetDiskMember obj=NetDiskMember.find(teasession._strCommunity,teasession._rv._strV,path);

%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="/tea/tea.js" type="text/javascript"></script>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<body>

<h1><%=r.getString(teasession._nLanguage, "移动/复制")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=obj.getAncestor(null)%></td>
  </tr>
</table>

<form name="form1" action="/servlet/EditNetDisk" method="POST">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="act" value="<%=act%>">
<input type="hidden" name="base" value="<%=base%>">
<%
if(ps!=null)
{
  for(int i=0;i<ps.length;i++)
  {
    out.print("<input type=hidden name=paths value="+ps[i]+">");
  }
}
%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>选择目录</td>
    <td><select name="path">
    <%
    Enumeration e=NetDisk.find(teasession._strCommunity," AND type=0 AND path LIKE "+DbAdapter.cite(base+"/%"),null,false);
    while(e.hasMoreElements())
    {
      String p=(String)e.nextElement();

      int purview=Safety.findByMember(teasession._strCommunity,p,teasession._rv._strV);
      if(purview>=2)
      {
        out.print("<option value="+p);
        if(p.equals(path))
        {
          out.print(" selected ");
        }
        out.print(">"+p.substring(base.length()));
      }
    }
    %>
    </select></td>
  </tr>
</table>
<input type="submit" value="提交">
<input type="button" value="返回" onclick="history.back();">
</form>

</body>
</html>
