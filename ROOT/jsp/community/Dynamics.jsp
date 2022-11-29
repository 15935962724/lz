<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.site.*" %><%@page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="java.util.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;

Resource r=new Resource("/tea/resource/Dynamic");

String nexturl=request.getParameter("nexturl");
if(nexturl==null)
nexturl=request.getRequestURI()+"?"+request.getQueryString();

String info=request.getParameter("info");
if(info==null)
info=r.getString(teasession._nLanguage, "Dynamic");

int sort=-1;
String tmp=request.getParameter("sort");
if(tmp!=null)sort=Integer.parseInt(tmp);

boolean debug="127.0.0.1".equals(request.getRemoteAddr());

%>
<!--
debug:id,
-->
<HTML>
<HEAD>
<title><%=info%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function f_act(a,d,s)
{
  if(a=="delete")
  {
    if(!confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'))return;
  }
  if(s)
  {
    form1.sort.value=s;
  }else
  {
    form1.action='/servlet/EditDynamic';
    form1.act.value=a;
  }
  form1.nexturl.value=location;
  form1.dynamic.value=d;
  form1.submit();
}
</script>
</HEAD>
<body>
<h1><%=info%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/jsp/community/EditDynamic.jsp">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="dynamic" value="0">
<input type="hidden" name="sort" value="0">
<input type="hidden" name="nexturl">
<input type="hidden" name="act">

<table cellspacing="0" cellpadding="0" id="tablecenter">
<%
Enumeration e=Dynamic.findByCommunity(community,sort);
if(!e.hasMoreElements()&&sort!=-1)
{
    out.print("<tr><td>&nbsp;<td><input type=button value="+r.getString(teasession._nLanguage, "CBNew")+" onclick=f_act('edit',"+0+","+sort+");>");
}else
{
  int last=-1;
  while(e.hasMoreElements())
  {
    int id = ((Integer)e.nextElement()).intValue();
    Dynamic d = Dynamic.find(id);
    sort=d.getSort();
    if(last==-1)last=sort;
    if(last!=sort)
    {
      out.print("<tr><td>&nbsp;<td><input type=button value="+r.getString(teasession._nLanguage, "CBNew")+" onclick=f_act('edit',"+0+","+last+");>");//创建按钮显示在"编辑/删除"的下面.
      last=sort;
    }
    out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
    out.print("<td>"+(debug?id+"、":"")+d.getName(teasession._nLanguage));
    out.print("<td><input type=button value="+r.getString(teasession._nLanguage, "CBEdit")+" onclick=f_act('edit',"+id+","+sort+");> ");
    if(d.isLayerExists(teasession._nLanguage))
    {
      out.print("<input type=button value="+r.getString(teasession._nLanguage, "CBDelete")+" onclick=f_act('delete',"+id+");> ");
    }
    out.print("<input type=button value="+r.getString(teasession._nLanguage, "CBClone")+" onclick=f_act('clone',"+id+");> ");
  }
  out.print("<tr><td>&nbsp;<td><input type=button value="+r.getString(teasession._nLanguage, "CBNew")+" onclick=f_act('edit',"+0+","+last+");>");
}
%>
</table>
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</HTML>
