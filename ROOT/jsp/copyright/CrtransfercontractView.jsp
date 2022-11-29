<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.copyright.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);


int crtransfercontract=Integer.parseInt(request.getParameter("crtransfercontract"));

String code=null;
String scrbid=null;
String name=null;
String font1=null;
String author=null;
String font2=null;
String droit=null;
String assignor=null;
String font3=null;
String alienee=null;
String font4=null;
String time=null;
String path=null;
if(crtransfercontract>0)
{
  Crtransfercontract obj=Crtransfercontract.find(crtransfercontract);
  code=obj.getCode();
  scrbid=obj.getScrbid();
  name=obj.getName();
  font1=obj.getFont1();
  author=obj.getAuthor();
  font2=obj.getFont2();
  droit=obj.getDroit();
  assignor=obj.getAssignor();
  font3=obj.getFont3();
  alienee=obj.getAlienee();
  font4=obj.getFont4();
  time=obj.getTime();
  path=obj.getPath();
}


%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onload="form1.scrbid.focus();">

<h1>转让合同公告信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>

 
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR>
    <TD >编号</TD>
    <TD><%if(code!=null)out.print(code);%></TD>
    <TD >登记号</TD>
    <TD><%if(scrbid!=null)out.print(scrbid);%></TD>
  </tr>
  <TR>
    <TD >软件名称</TD>
    <TD><%if(name!=null)out.print(name);%></TD>
    <TD >软件名称字体号</TD>
    <TD><%if(font1!=null)out.print(font1);%></TD>
  </tr>
  <TR>
    <TD >合同登记人</TD>
    <TD><%if(author!=null)out.print(author);%></TD>
    <TD >合同登记人字体号</TD>
    <TD><%if(font2!=null)out.print(font2);%></TD>
  </tr>
  <tr>
    <TD>转让权利</TD>
    <TD><%if(droit!=null)out.print(droit);%></TD>
  </tr>
  <TR>
    <TD >转让人</TD>
    <TD><%if(assignor!=null)out.print(assignor);%></TD>
    <TD >转让人字体号</TD>
    <TD><%if(font3!=null)out.print(font3);%></TD>
  </tr>
  <TR>
    <TD >受让人</TD>
    <TD><%if(alienee!=null)out.print(alienee);%></TD>
    <TD >受让人字体号</TD>
    <TD><%if(font4!=null)out.print(font4);%></TD>
  </tr>
  <TR>
    <TD >发证日期</TD>
    <TD><%if(time!=null)out.print(time);%></TD>
    <TD>原文路径</TD>
    <TD><%if(path!=null)out.print(path);%></TD>
  </tr>
</TABLE>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

