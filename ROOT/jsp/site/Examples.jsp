<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*"%>
<%@page import="java.util.*" %>
<%@page import="java.net.*" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.util.*" %>
<%@page import="tea.ui.node.general.*" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);


AccessMember am =AccessMember.find(teasession._nNode, teasession._rv);
Node node = Node.find(teasession._nNode);
if(!node.isCreator(teasession._rv)&&am.getPurview()<1)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
}

Http h=new Http(request,response);




Resource r=new Resource("/tea/resource/DNS");

String q=request.getParameter("q");

StringBuffer sql=new StringBuffer();
if(q!=null&&q.length()>0)
{
  sql.append(" AND subject LIKE ").append(DbAdapter.cite("%"+q+"%"));
}

int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

%><html>
<head>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></script>
<script LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<%=NodeServlet.getButton(node,h, am,request)%>
<h1><%=r.getString(teasession._nLanguage, "Template")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form action="?">
<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>名称:<input type="text" name="q" value="<%if(q!=null)out.print(q);%>"/>　<input type="submit" value="查询"/></td></tr>
</table>
</form>

<form name="form1" action="/servlet/EditExample" method="post" enctype="multipart/form-data" onSubmit="return(submitText(this.subject,'<%=r.getString(teasession._nLanguage, "InvalidSubject")%>'));">
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="example"/>
<input type="hidden" name="extype"/>
<input type="hidden" name="exid"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td>序号</td>
    <td>名称</td>
    <td>操作</td>
  </tr>
  <%
  ArrayList ee= Example.find(sql.toString(),pos,25);
  if(ee.size()<1)
  {
    out.print("<tr><td colspan='3' align='center'>暂无记录");
  }else
  for(int i=0;i<ee.size();i++)
  {
    Example e=(Example)ee.get(i);
    int id=e.getExample();
    String exids=e.getExid();
    String subject=e.getSubject();
    String picture=e.getPicture();
    if(q!=null)
    {
      subject=subject.replaceAll(q,"<font color='red'>"+q+"</font>");
    }
    out.print("<img src=\""+picture+"\" id='img"+id+"' style='visibility:hidden;position:absolute;filter:revealtrans(duration=0.5);' />");
    out.print("<tr onMouseOver=\"bgColor='#BCD1E9'\" onMouseOut=\"bgColor=''\">");
    out.print("<td>"+(i+1));
    out.print("<td onmouseover=showSnap(event,img"+id+") onMouseOut=showSnap(event,img"+id+")>"+subject);
    out.print("<td><input type='button' value='"+r.getString(teasession._nLanguage, "添加")+"' onclick=\"form1.act.value='use';form1.example.value="+id+"; form1.submit();\" />");
    out.print("<input type='button' value='"+r.getString(teasession._nLanguage, "CBEdit")+"' onclick=\"window.open('/jsp/site/EditExample.jsp?example="+id+"', '_self');\" />");
    out.print("<input type='button' value='"+r.getString(teasession._nLanguage, "CBDelete")+"' onclick=\"if(confirm('"+r.getString(teasession._nLanguage, "ConfirmDelete")+"')){ form1.act.value='del'; form1.example.value='"+id+"'; form1.submit(); }\" />");
    String exs[]=exids.split("/");
    for(int j=1;j<exs.length;j++)
    {
      String url=null;
      int exid=Integer.parseInt(exs[j].substring(1));
      char extype=exs[j].charAt(0);
      switch(extype)
      {
        case 'C':
        url="/jsp/section/EditCssJs.jsp?node="+teasession._nNode+"&status=0&cssjs="+exid;
        break;
        case 'S':
        url="/jsp/section/EditSection.jsp?node="+teasession._nNode+"&status=0&section="+exid;
        break;
        case 'L':
        url="/jsp/listing/EditListing.jsp?node="+teasession._nNode+"&status=0&listing="+exid;
        break;
      }
      out.print("<tr>");
      out.print("<td>&nbsp;");
      out.print("<td>"+exs[j].substring(1));
      out.print("<td><input type='button' value='"+r.getString(teasession._nLanguage, "CBEdit")+"' onclick=\"window.open('"+url+"', '_self');\" />");
      out.print("<input type='button' value='"+r.getString(teasession._nLanguage, "CBDelete")+"' onclick=\"if(confirm('"+r.getString(teasession._nLanguage, "ConfirmDelete")+"')){ form1.act.value='delexid'; form1.example.value='"+id+"'; form1.extype.value='"+extype+"'; form1.exid.value='"+exid+"'; form1.submit(); }\" />");
    }
  }
  %>
</table>
<!--
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBNew")%>" onclick="window.open('/jsp/site/EditExample.jsp?act=step1', '_self');" />
-->
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBBack")%>" onclick="window.open('/servlet/Node?node=<%=teasession._nNode%>', '_self');" />
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
