<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.io.*" %><%@ page import="java.util.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="java.math.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

CommunityOffice obj = CommunityOffice.find(teasession._strCommunity);

String caption=obj.getProductCaption(),pkey=obj.getProductKey(),template=obj.getTemplate(),issued=obj.issued;
if(request.getMethod().equals("POST"))
{
  caption=teasession.getParameter("caption");
  pkey=teasession.getParameter("pkey");
  issued=teasession.getParameter("issued");
  String tmp=teasession.getParameter("template");
  if(tmp!=null)
    template=tmp;
  else if(teasession.getParameter("clear")!=null)
    template="";
  obj.set(caption,pkey,template,issued);
  response.sendRedirect("/jsp/info/Succeed.jsp?nexturl="+java.net.URLEncoder.encode(teasession.getParameter("nexturl"),"utf-8"));
  return;
}

int len=0;
if(template!=null)len=(int)new File(application.getRealPath(template)).length();


%><HTML>
<HEAD>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</HEAD>
<body onLoad="form1.caption.focus();">

<h1>Office管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/jsp/community/EditCommunityOffice.jsp" method="post" enctype="multipart/form-data" onSubmit="return(submitText(this.caption,'<%=r.getString(teasession._nLanguage,"无效-公司名称")%>')&&submitText(this.key, '<%=r.getString(teasession._nLanguage,"无效-Key")%>'));">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=request.getParameter("id")%>">
<script>document.write("<input type='hidden' name='nexturl' value='"+location.href+"'/>");</script>

<table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage,"公司名称")%>:</td>
    <td><input type="text" name="caption" value="<%if(caption!=null)out.print(caption);%>" size="50"></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"Key")%>:</td>
    <td><input type="text" name="pkey" value="<%if(pkey!=null)out.print(pkey);%>" size="80"></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"Template")%>:</td>
    <td><input type="file" name="template" size="50">
    <%
    if(len>0)
    {
      out.print("<a href=/jsp/include/DownFile.jsp?uri="+template+"&name=exp.doc>"+len+r.getString(teasession._nLanguage,"Bytes")+"</a>");
      //out.print("<input name=clear type=checkbox onclick=form1.template.disabled=this.checked>"+r.getString(teasession._nLanguage,"Clear"));
    }
    %>
    </td>
  </tr>
  <tr>
    <td>发文代号:</td>
    <td><input type="text" name="issued" value="<%if(issued!=null)out.print(issued);%>"> <a href="/jsp/admin/flow/FlowIssuecodes.jsp?community=<%=teasession._strCommunity%>" target="_blank">字号管理</a></td>
  </tr>
  <tr>
    <td></td><td><input type="submit" value="<%=r.getString(teasession._nLanguage,"CBSubmit")%>">
  </tr>
</table>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</HTML>
