<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*" %><%@page import="tea.entity.site.*" %><%@page import="java.io.*" %><%@page import="java.util.*" %><%@page import="tea.html.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.admin.*" %><%@page import="java.math.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);


String uri="/tea/applet/office/default.doc";

CommunityOffice co=CommunityOffice.find(teasession._strCommunity);



%><HTML>
<HEAD>
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
<input id="view"/>
<input type="button" value="印章" onclick="window.showModalDialog('/jsp/admin/office/CachetList.jsp?esp=&seal=0&t='+new Date().getTime(),self,'scroll:0;status:0;help:0;resizable:1;dialogWidth:680px;dialogHeight:350px;');"/>
<input type='button' onclick='ocx.ShowDialog(3)' value='下载文档'>
<input type='button' onclick='window.close()' value=' 取 消 '>

<script type="">

var ocx=ActionX("<%=co.getProductCaption()%>","<%=co.getProductKey()%>","800","800");


//ocx.FileNew=false;
//ocx.FileOpen=false;
//ocx.FileClose=false;
//ocx.FileSave=false;
//ocx.FileSaveAs=false;
//ocx.FilePrint=false;
try
{
  ocx.OpenFromURL("<%=uri%>111");
}catch(e)
{
  alert(e);
  if(e.number==-2147217149)
  alert("您没有正确安装Office，或者您安装的是精简版。请重新安装Microsoft Office！");
}
//ocx.OpenLocalFile("E:/test.docx",false);
var doc=ocx.ActiveDocument;
alert(doc);
doc.AcceptAllRevisions();//接受所有修订
doc.TrackRevisions = false;//修订模式
//var rs=ocx.SaveToURL('?community=Home&flowbusiness=105&sync=false&path=','file','','newdoc.doc',0);
//alert(rs);



</script>

</body></html>
