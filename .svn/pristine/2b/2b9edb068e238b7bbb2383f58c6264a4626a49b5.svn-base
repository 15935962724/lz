<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.resource.Resource"  %>
<%@page import="tea.entity.admin.map.*" %>
<%@page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}


String nexturl=request.getParameter("nexturl");
if(nexturl==null)
nexturl=request.getRequestURI()+"?"+request.getQueryString();

String sid=null,pic0=null,pic1=null,pic2=null,pic3=null;

MapReal obj=MapReal.find(teasession._nNode);
if(obj.isExists())
{
  pic0=obj.getPic0();
  pic1=obj.getPic1();
  pic2=obj.getPic2();
  pic3=obj.getPic3();
}

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel=stylesheet type=text/css>
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>创建/修改地图标点</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form NAME="form1" ACTION="/servlet/EditMapReal" METHOD="post" enctype="multipart/form-data" onSubmit="return submitText(this.pic0,'无效-图片')&&submitText(this.pic1,'无效-图片')&&submitText(this.pic2,'无效-图片')&&submitText(this.pic3,'无效-图片');">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
  <input type="hidden" name="nexturl" value="<%=nexturl%>">
  <input type="hidden" name="act" value="edit">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>地图:</td>
    <td><select name="sid" onchange=""><option value="">--------------------------</option>
    <%
    Enumeration e1=Mapabc.find("",0,Integer.MAX_VALUE);
    while(e1.hasMoreElements())
    {
      String _sid=(String)e1.nextElement();
      Mapabc m=Mapabc.find(_sid);
      out.print("<option value="+_sid);
      if(_sid.equals(sid))
      {

      }
      out.print(">"+m.getName());
    }
    %>
</select></td>
  </tr>

  <tr>
    <td>标点:</td>
     <td>
<%--
<object
    classid="clsid:8AD9C840-044E-11D1-B3E9-00805F499D93"
    codebase="http://java.sun.com/update/1.5.0/jinstall-1_5-windows-i586.cab#Version=5,0,0,7"
    WIDTH=400 HEIGHT=300 id="ptviewer">
    <PARAM NAME=CODE VALUE="ptviewer.class" >
    <PARAM NAME=ARCHIVE VALUE="/tea/applet/map/ptviewer.jar" >
    <param name="type" value="application/x-java-applet;version=1.5">
    <param name="scriptable" value="false">

    <PARAM NAME=file VALUE="/test.jpg">
    <PARAM NAME=cursor VALUE="MOVE">
    <PARAM NAME=pan VALUE=-105>
    <PARAM NAME=showToolbar VALUE="true">
    <PARAM NAME=imgLoadFeedback VALUE="false">
    <PARAM NAME=hotspot0 VALUE="X21.3 Y47.7 u'Sample27L2.htm' n'Hotspot description'">
    <PARAM NAME=wait VALUE="/res/chinaserve/u/0710/071040557.jpg">
</object>
--%>
<script type="">
//document.write("<object");
//document.write("    classid=clsid:8AD9C840-044E-11D1-B3E9-00805F499D93");
//document.write("    codebase=http://java.sun.com/update/1.5.0/jinstall-1_5-windows-i586.cab#Version=5,0,0,7");
//document.write("    WIDTH=400 HEIGHT=300 id=ptviewer>");
//document.write("    <PARAM NAME=CODE VALUE=ptviewer.class >");
//document.write("    <PARAM NAME=ARCHIVE VALUE=/tea/applet/ptviewer.jar >");
//document.write("    <param name=type value=application/x-java-applet;version=1.5>");
//document.write("    <param name=scriptable value=false>");
//document.write("    ");
//document.write("    <PARAM NAME=file VALUE=/test.jpg>");
//document.write("    <PARAM NAME=cursor VALUE=MOVE>");
//document.write("    <PARAM NAME=pan VALUE=-105>");
//document.write("    <PARAM NAME=showToolbar VALUE=true>");
//document.write("    <PARAM NAME=imgLoadFeedback VALUE=false>");
//document.write("    <PARAM NAME=hotspot0 VALUE=\"X21.3 Y47.7 u'Sample27L2.htm' n'Hotspot description'\">");
//document.write("    <PARAM NAME=wait VALUE=/res/chinaserve/u/0710/071040557.jpg>    ");
//document.write("</object>");
//
//var ptviewer=document.getElementById("ptviewer");
//for(var aa in ptviewer)
//{
//  document.write(aa+"<br>");
//}
</script>

<APPLET CODE="ptviewer.class" ARCHIVE="/tea/applet/ptviewer.jar" WIDTH=400 HEIGHT=300>
<PARAM NAME=file VALUE="/test.jpg">
<PARAM NAME=cursor VALUE="MOVE">
<PARAM NAME=pan VALUE=-105>
<PARAM NAME=showToolbar VALUE="true">
<PARAM NAME=imgLoadFeedback VALUE="false">
<PARAM NAME=hotspot0 VALUE="X21.3 Y47.7 u'Sample27L2.htm' n'Hotspot description'">
<PARAM NAME=wait VALUE="/res/chinaserve/u/0710/071040557.jpg">
</APPLET>

</td>
</tr>
<tr>
  <td></td>
  <td>
    <input TYPE="SUBMIT" VALUE="提交">
      <input TYPE="RESET" VALUE="重置"></td>
</tr>
</TABLE>

</FORM>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
