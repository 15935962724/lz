<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="tea.ui.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.bpicture.*" %>
<%@page import="java.io.File.*" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.*" %>
<%@include file="/jsp/include/Header.jsp"%>
<%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
Node node = Node.find(2198116);
//if ((node.getOptions1() & 1) == 0)
//{
//  if (teasession._rv == null)
//  {
//    response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
//    return;
//  }
//  if (!node.isCreator(teasession._rv) && !AccessMember.find(node._nNode, teasession._rv._strV).isProvider(40))
//  {
//    response.sendError(403);
//    return;
//  }
//} else
//{
//  if (teasession._rv == null)
//  {
//    teasession._rv = new tea.entity.RV("ANONYMITY", "Home");
//  }
//}
boolean _bNew =request.getParameter("NewNode")!=null;


if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
int pos=0;
if(teasession.getParameter("pos")!=null && teasession.getParameter("pos").length()>0)
{
  pos=Integer.parseInt(teasession.getParameter("pos"));
}
int count=0;

StringBuffer param = new StringBuffer();

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String community = teasession._strCommunity;

%>
<html>
<head>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>

<script type="">
function selectallf()
{
  var a = document.getElementsByTagName("input");
  if(form1.selectall.checked==true)
  {
    for (var i=0; i<a.length; i++)
    {
      if (a[i].type == "checkbox" &&  (a[i].checked == false))
      {
        a[i].checked = true;
      }
    }
  }
  else
  {
    for (var i=0; i<a.length; i++)
    if (a[i].type == "checkbox" &&  (a[i].checked == true))
    {
      a[i].checked = false;
    }
  }
}
function Loadnew(aa)
{
  loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
  loc_y=document.body.scrollTop+event.clientY-event.offsetY+140;
  var sFeatures = "edge:raised;scroll:0;status:0;help:0;resizable:1;scroll:yes;dialogWidth:320px;dialogHeight:345px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px";
  var url = "/jsp/bpicture/Bpicprofile.jsp";
  var aio ="";
  document.all.memberpic.value =window.showModalDialog(url,aio,sFeatures);
  document.all.repository.value ="res/bigpic/salepic/"+document.all.memberpic.value;

}
</script>
<body>
<form action="/servlet/EditPicture" name="form1" method="POST" enctype="multipart/form-data">
<%
if(_bNew)
{
  out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
}
%>
<input type="hidden" name="pictype" value="1" />
<input type='hidden' name=nodeid VALUE="<%=2198116%>"/>
<input type='hidden' name=nexturl VALUE="/jsp/bpicture/testfile.jsp"/>

<input type='hidden' name=community VALUE="<%=community%>"/>
<input type='hidden' name=repository VALUE="res/bigpic/salepic/<%=teasession._rv.toString()%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="table001">
<tr><td><input  type="text"  size="16" name="memberpic"/></td>


  <td><input type="button"  value="选择会员" onclick="Loadnew(this.value);" /></td>
</tr>
</table>
<br>

<table border="0" cellpadding="0" cellspacing="0" id="table001">
<tr><td></td><td>文件名称</td><td>文件路径</td><tr>
<%
//application.getRealPath("/res/bigpic/daoru");
ArrayList filelist = new ArrayList();
int baselen=application.getRealPath("/").length()-1;
String strPath=application.getRealPath("/res/bigpic/daoru");
File dir = new File(strPath);
File[] files = dir.listFiles();
count=files.length;
if(files == null)
return;
for(int i = pos;i<pos+30&&i < files.length;i++)
{
  if(files[i].isDirectory())
  {
    //    refreshFileList(files[i].getAbsolutePath());
  } else
  {
    String strFileName = files[i].getAbsolutePath().toLowerCase().substring(baselen).replace('\\','/');
    //System.out.println(files[i].getPath());
    String namepic = strFileName.subSequence(strFileName.lastIndexOf("/") + 1,strFileName.lastIndexOf(".")).toString();
    out.print("<tr><td><input type=checkbox name=upload value="+strFileName+"  ></td>");
    out.print("<td>"+namepic+"</td>");
    out.print("<td>"+strFileName+"</td></tr>");
    filelist.add(files[i].getAbsolutePath());
  }
}
%>
<tr>
  <td><input type="checkbox" name="selectall" onClick="selectallf();" ></td>
    <td>全选</td>
</tr>
  <tr><td colspan="3" align="right" style="padding-right:5px;"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,30)%></td></tr>
     <tr><td colspan="3" align="left"><input type="submit" name="导入" value="导入" /></td></tr>
</table>
</form>
</body>
</html>
