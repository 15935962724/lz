<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.site.*" %><%@page import="java.io.*" %><%@page import="java.util.*" %><%@page import="tea.html.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.admin.*" %><%@page import="java.math.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String file=request.getParameter("file");
//String arr[]=file.split(":");//有可能会是模板
//if(arr.length>1)
//{
//  file=arr[1];
//}
CommunityOffice co=CommunityOffice.find(teasession._strCommunity);

//
File f=new File(application.getRealPath(file));
if(!f.exists())
{
  out.print("<script>alert('文件丢失!');</script>");
  file=co.getTemplate();
}

%><html>
<head>
<title><%=co.getProductCaption()%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/applet/office/ocx.js"></script>
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

<script>
var ocx=ActionX("<%=co.getProductCaption()%>","<%=co.getProductKey()%>","100%","95%");
ocx.FileNew=false;
ocx.FileOpen=false;
ocx.FileClose=false;
ocx.FileSave=false;
ocx.FileSaveAs=false;
function f_file()
{
  try
  {
    ocx.OpenFromURL("<%=file%>");
    ocx.ActiveDocument.ShowRevisions=false;
  }catch(e)
  {
    setTimeout(f_file,200);
    return;
  }
  sign.lock();
}
f_file();
</script>
<input type="button" onclick="ocx.ActiveDocument.ShowRevisions=!ocx.ActiveDocument.ShowRevisions;" value="显示/隐藏 修改记录"/>
<input type="button" onclick="window.close();" value=" 取 消 "/>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
