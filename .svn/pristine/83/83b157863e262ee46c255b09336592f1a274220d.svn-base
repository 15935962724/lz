<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*" %><%@page import="tea.entity.site.*" %><%@page import="java.io.*" %><%@page import="java.util.*" %><%@page import="tea.html.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.admin.*" %><%@page import="java.math.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Http h=new Http(request);
int flowview=h.getInt("flowview");
Flowview fv=Flowview.find(flowview);
if(request.getParameter("ajax")!=null)
{
  fv.setUsePrint();
  return;
}


int flowprocess=fv.getFlowprocess();
Flowprocess fp=Flowprocess.find(flowprocess);
Flow f=Flow.find(fp.getFlow());

String act=request.getParameter("act");
boolean isAuto=request.getParameter("auto")!=null;

String file=h.get("file","").replace('?','f');

CommunityOffice co=CommunityOffice.find(teasession._strCommunity);

//
File fi=new File(application.getRealPath(file));
if(!fi.exists())
{
  out.print("<script>alert('文件丢失!');</script>");
  file=co.getTemplate();
}

//主控 && 盖章步之后 && 分发步之前
boolean isPrint="print".equals(act)|| (flowprocess==f.getMainProcess()&&Flowview.find(fv.getFlowbusiness()," AND flowprocess="+f.stampprocess).hasMoreElements()&&!Flowview.find(fv.getFlowbusiness()," AND flowprocess="+f.getDistProcess()).hasMoreElements());
boolean isDist=flowprocess==f.getDistProcess();//分发步

%><html>
<head>
<title><%=co.getProductCaption()%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
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
<%
if(!isPrint)out.println("ocx.FilePrint=false;");
%>
try
{
  ocx.OpenFromURL(mt.dec(new Array(0<%for(int i=0;i<file.length();i++)out.print(","+(int)file.charAt(i));%>)));
}catch(e)
{
  if(e.number==-2147217149)
  alert("您没有正确安装Word，或者您安装的是精简版。请重新安装Microsoft Word！");
}
var doc=ocx.ActiveDocument;
var revi=doc.ShowRevisions=false;

var sumprint=<%=fv.getSumPrint()%>,useprint=<%=fv.getUsePrint()%>;
function f_print()
{
  if(useprint>=sumprint)
  {
    alert("您最多可以打印“"+sumprint+"”份，您已打印“"+useprint+"”份。");
    return;
  }else if(!confirm("本次打印完后，您还可以再打印"+(sumprint-useprint-1)+"份！"))
  {
    return;
  }
  ocx.FilePrint=true;
  try
  {
    ocx.PrintOut(true);
  }catch(e)
  {
    ocx.FilePrint=false;
    return;//点取消,引发异常
  }
  ocx.FilePrint=false;
  useprint++;
  sendx("/jsp/admin/flow/ViewDynamicOffice.jsp?flowview=<%=flowview%>&ajax=on");
}
function f_revis()
{
  if(!revi)sign.ro(revi);
  doc.ShowRevisions=!revi;
  if(revi)sign.ro(revi);
  revi=!revi;
}
</script>
<%
if(isDist)//分发步
{
  out.println("<input type='button' onclick='f_print()' value=' 打 印 ' />");
  out.print("<script>doc.AcceptAllRevisions();doc.TrackRevisions=false;</script>");//分发步:不可查看修订
}else
{
  if(isPrint)
  {
    out.println("<input type='button' onclick='ocx.PrintOut(true);' value=' 打 印 ' />");
    if(isAuto)out.print("<script>ocx.PrintOut(true);</script>");
  }
  out.println("<input type='button' onclick='f_revis()' value='显示/隐藏 修改记录' />");
}
%>
<input type="button" onclick="window.close();" value=" 取 消 "/>
<script>
if(<%=isDist%>||sign.get().length>0)
sign.ro(true);
else
sign.lock();
</script>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
