<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Job");

int applytable=0;
String _strApplytable=request.getParameter("applytable");
if(_strApplytable!=null)
applytable=Integer.parseInt(_strApplytable);

%>
<HTML>
<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
</HEAD>
  <body>
  <h1><%=r.getString(teasession._nLanguage, "UploadApplyTable")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>


  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td >
        <form enctype="multipart/form-data" onsubmit="return submitText(this.file,'<%=r.getString(teasession._nLanguage, "InvalidFile")%>')" method="post" action="/servlet/EditApplyTable" >
        <input type="hidden" name="applytable" value="<%=applytable%>">
        <input type="file" name="file">
        <input type="hidden" name="act" value="edit">
        <input type="submit"  value="<%=r.getString(teasession._nLanguage, "CBSubmit")%>">
        <input type="button"  onclick="window.history.back();" value="<%=r.getString(teasession._nLanguage, "CBBack")%>">
        </form>
      </td>
    </tr>
  </table>

 <div id="head6"><img height="6" src="about:blank"></div>
 </body>
 </html>

