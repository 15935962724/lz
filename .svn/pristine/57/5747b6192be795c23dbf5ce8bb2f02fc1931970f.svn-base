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

String ps[]=request.getParameterValues("filecenters");
if(ps==null)
{
  out.print("<script>history.back();</script>");
  return;
}


Resource r=new Resource("/tea/resource/NetDisk");

String str="/";
int base=Integer.parseInt(request.getParameter("base"));
if(base>0)
{
  FileCenter fc=FileCenter.find(base);
  str=fc.getPath();
}

int filecenter=Integer.parseInt(request.getParameter("filecenter"));

String act=request.getParameter("act");

FileCenter obj=FileCenter.find(filecenter);

StringBuffer sql=new StringBuffer();
sql.append(" AND type=0");
//sql.append(" AND type=0 AND path LIKE ").append(DbAdapter.cite(str+"%"));

%>
<HTML>
  <HEAD>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="/tea/tea.js" type="text/javascript"></script>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</HEAD>
<body>

<h1><%=r.getString(teasession._nLanguage, "移动/复制")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=obj.getAncestor(base)%></td>
  </tr>
</table>

<form name="form1" action="/servlet/EditFileCenter" method="POST">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="act" value="<%=act%>">
<input type="hidden" name="base" value="<%=base%>">
<%
for(int i=0;i<ps.length;i++)
{
  out.print("<input type=hidden name=filecenters value="+ps[i]+">");
  int id=Integer.parseInt(ps[i]);
  FileCenter fc=FileCenter.find(id);
  ///不能移动或复制到自已或见子身上//
  sql.append(" AND path NOT LIKE ").append(DbAdapter.cite(fc.getPath()+"%"));
}
//System.out.println(sql.toString());
%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>选择目录</td>
    <td><select name="filecenter">
    <%
    Enumeration e=FileCenter.find(teasession._strCommunity,sql.toString(),null,false);
    while(e.hasMoreElements())
    {
      int id=((Integer)e.nextElement()).intValue();
      int purview=FileCenterSafety.findByMember(id,teasession._rv._strV);
      if(purview>=2)
      {
        FileCenter fc=FileCenter.find(id);
        String p=fc.getPath();
        out.print("<option value="+id);
        if(id==filecenter)
        {
          out.print(" selected ");
        }
        out.print(">"+fc.getAncestor(-1));
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
