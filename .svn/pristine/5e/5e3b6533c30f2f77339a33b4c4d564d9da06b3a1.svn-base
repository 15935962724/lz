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

String base=request.getParameter("base");

%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="/tea/tea.js" type="text/javascript"></script>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<body>

<h1><%=r.getString(teasession._nLanguage, "文件搜索")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br><form name="form1" action="/jsp/netdisk/NetDisks.jsp" method="post" target="NetDiskMainFrame" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="act" value="search">
<input type="hidden" name="base" value="<%=base%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter" style="line-height:22px">
<tr><td> <%=r.getString(teasession._nLanguage, "FileName")%> <br/>   <input name="name" ></td>
</tr>
  <tr><td >选择目录<br/>
    <select name="path">
      <%
    Enumeration e=NetDisk.find(teasession._strCommunity," AND type=0 AND path LIKE "+DbAdapter.cite(base+"/%"),null,false);
    while(e.hasMoreElements())
    {
      String p=(String)e.nextElement();
      int purview=Safety.findByMember(teasession._strCommunity,p,teasession._rv._strV);
      if(purview!=-1)
      {
        out.print("<option value="+p+">"+p.substring(base.length()) );
      }
    }
    %>
    </select></td>
	</tr>
  
  <tr>
    <td >修改时间:<br/>
      <input type="text" name="time0" readonly size="11">
      <input type="button" value="..." onClick="showCalendar('form1.time0')"/>
      <br />
    <input type="text" name="time1" readonly size="11">      <input type="button" value="..." onClick="showCalendar('form1.time1')"/>    </td></tr>
  
    <tr>
    <td>文件大小:<br/>
      <input type="text" name="size0" size="5"> 
      -
      <input type="text" name="size1" size="5">
    K    </td></tr>
</table>
<input type="submit" value="搜索">
</form>

</body>
</html>
