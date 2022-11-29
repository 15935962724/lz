<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.*" %><%@page import="java.io.*" %><%@page import="java.util.*" %><%@page import="tea.html.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.admin.*" %><%@page import="java.math.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

boolean sync=Boolean.parseBoolean(teasession.getParameter("sync"));

if("POST".equals(request.getMethod()))
{
  byte by[]=teasession.getBytesParameter("file");
  String name=teasession.getParameter("fileName");
  String path=teasession.getParameter("path");
  if(by!=null)
  {
    String ex="."+name.substring(name.lastIndexOf(".")+1);
    if(sync)
    {
      Filex.write(application.getRealPath(path),by);
    }else
    {
      path=TeaServlet.write(teasession._strCommunity,"flow",by,ex);
    }
    out.print(path);
  }
  return;
}

Http h=new Http(request);


String field=teasession.getParameter("field");
boolean authority="true".equals(teasession.getParameter("authority"));//是否显示 签字/盖章
boolean seal="true".equals(teasession.getParameter("seal"));//是否打开盖章窗口

CommunityOffice co=CommunityOffice.find(teasession._strCommunity);

Resource r=new Resource("/tea/resource/Dynamic");

Calendar c=Calendar.getInstance();
int year=c.get(Calendar.YEAR);

ProfileBBS pb = ProfileBBS.find(teasession._strCommunity, teasession._rv._strV);
String isign = pb.getISign(teasession._nLanguage);
String sn=pb.getSerialNum();

%><html>
<head>
<title><%=co.getProductCaption()%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script LANGUAGE=JAVASCRIPT src="/tea/tea.js" type="text/javascript"></script>
<style type="text/css">
<!--
body
{
 margin:10px;
 background-color:menu;
}
-->
</style>
<script>
var opener=opener?opener:dialogArguments;
var dt=opener.document.all("<%=field%>");
var head=opener.document.all("head");
head=new Array('','a','b','c','d','e','f')[head?parseInt(head.value):0];
function f_load()
{
  var sel=document.getElementById('sel');
  window.returnValue=sel.value;
}
</script>
</head>
<body onunload="f_load()">

<table border='0' cellpadding='0' cellspacing='0' id='TableAnnex' >
  <tr><td class='TableAnnextitle'>请选择模板:</td></tr>
<tr>
  <td><select id='sel' size='12' style='width:260px' ondblclick='window.close();' mask="div">
<script>
var v=dt.value;
if(v.charAt(v.length-1)==':')v=v.substring(0,v.length-1);
var dts=v.split(":");
for(var i=1;i<dts.length;i++)
{
  var j=dts[i].lastIndexOf('/');
  var name=dts[i].substring(j+1,dts[i].lastIndexOf('.'));
  if(name.indexOf(head)!=0)continue;
  //document.write("<td onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor='' style='cursor:hand' align='center' onclick=\"f_load('"+dts[i]+"');\">"+name);
  document.write("<option value='"+dts[i]+"'");
  if(i==1)document.write(" selected='true'");
  document.write(">"+name.substring(head.length));
}
$('sel').selectedIndex=0;
</script>
</select></td>
<td valign='top' id='inputbutton'><input type='submit' onclick='window.close();' value=' 确 定 '>
  <!--<br><input type='button' value=' 取 消 ' onclick='window.close();'>--></td></tr></table>
</body>
</html>
