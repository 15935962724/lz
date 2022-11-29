<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*" %><%@page import="tea.entity.site.*" %><%@page import="java.io.*" %><%@page import="java.util.*" %><%@page import="tea.html.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.admin.*" %><%@page import="java.math.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

Http h=new Http(request);

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


String file=h.get("file");
int flowbusiness=h.getInt("flowbusiness");
Flowbusiness fb=Flowbusiness.find(flowbusiness);


CommunityOffice co=CommunityOffice.find(teasession._strCommunity);

%><html>
<head>
<title>下载</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script LANGUAGE=JAVASCRIPT src="/tea/tea.js" type="text/javascript"></script>
<script LANGUAGE=JAVASCRIPT src="/tea/mt.js" type="text/javascript"></script>
<script LANGUAGE=JAVASCRIPT src="/tea/applet/office/ocx.js" type="text/javascript"></script>
<style type="text/css">
<!--
body
{
 margin-left: 0px;
 margin-top: 0px;
 margin-right: 0px;
 margin-bottom: 0px;
 border:0px;
 background-color:menu;
}
-->
</style>
</head>
<body>

<input type='button' onclick="window.open('/jsp/include/DownFile.jsp?uri=<%=h.enc(fb.getWord())%>&name=<%=h.enc(fb.getName(teasession._nLanguage))%>.doc','_ajax');" value='下载文档'>
<input type='button' onclick='window.close()' value=' 取 消 '>

<%--
<input type='button' onclick='ocx.ShowDialog(3)' value='下载文档'>
<input type='button' onclick='window.close()' value=' 取 消 '>

<script type="">
var ocx=ActionX("<%=co.getProductCaption()%>","<%=co.getProductKey()%>","0px","0px");

ocx.Titlebar=false;
ocx.Menubar=false;
ocx.Statusbar=false;
ocx.Toolbars=false;

function f_file()
{
  var doc;
  try
  {
    ocx.OpenFromURL("<%=file%>");
    doc=ocx.ActiveDocument;
  }catch(e)
  {
    setTimeout(f_file,500);//第一次老是失败
    return;
  }
  sign.del();
  doc.AcceptAllRevisions();
}
f_file();
</script>
--%>

</body>
</html>
