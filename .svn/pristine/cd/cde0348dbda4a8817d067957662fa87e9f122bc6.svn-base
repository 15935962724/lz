<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.math.BigDecimal" %>
<%@include file="/jsp/include/Header.jsp"%>
<%

Node node = Node.find(teasession._nNode);
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
int j1 = 0;
Date date = null;
String subject,keywords,text;
String s2 ;
int s4=0 ;
String s5 ;
String s6 ;
String s7 ;
String picture,small;
String s8 ;
BigDecimal price = new BigDecimal(0);
long lenpic=0,lentbn=0;
int width=0,height=0;
if(!_bNew)
{
  Picture p=Picture.find(teasession._nNode);
  keywords=node.getKeywords(teasession._nLanguage);
  subject=node.getSubject(teasession._nLanguage);
  text=tea.html.HtmlElement.htmlToText(node.getText(teasession._nLanguage));
  s2=p.getAuthor(teasession._nLanguage);
  date=p.getDate(teasession._nLanguage);
  s4=p.getClass(teasession._nLanguage);
  s5=p.getAddress(teasession._nLanguage);
  s6=p.getNote(teasession._nLanguage);
  s7=p.getSave(teasession._nLanguage);
  s8=p.getCode(teasession._nLanguage);
  width=p.getWidth(teasession._nLanguage);
  height=p.getHeight(teasession._nLanguage);
  price=p.getPrice(teasession._nLanguage);
  picture="/res/"+node.getCommunity()+"/picture/"+teasession._nNode+".jpg";
  small="/res/"+node.getCommunity()+"/picture/small/"+teasession._nNode+".jpg";
  lenpic=new File(application.getRealPath(picture)).length();
  lentbn=new File(application.getRealPath(small)).length();
}else
{
  subject=keywords=text = "";
  s2 = "";
  s5 = "";
  s6 = "";
  s7 = "";
  s8 = String.valueOf(System.currentTimeMillis());
  picture=small="";
}

%><html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body oncontextmenu="return false">
<h1><%=r.getString(teasession._nLanguage, "Picture")%><%=r.getString(teasession._nLanguage, "Edit")%></h1>
<center>
<span id="description"><font size="4"><b>插件安装提示：请单击左上方工具→Internet选项→安全→本地Internet,把IE安全级别设置为低,并且把该网站添加为可信任站点。</b></font></span>
</center>
<br />
<br />
<FORM name=form1 METHOD=POST action="/servlet/EditPicture" enctype="multipart/form-data" onSubmit="return(submitText(this.subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>'));">
<%
if(_bNew)
{
  out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
}
%>
<input type='hidden' name=node VALUE="<%=teasession.getParameter("node")%>"/>
<input type='hidden' name=memberpic VALUE="<%=teasession._rv%>"/>
<input type='hidden' name=Type VALUE="<%=request.getParameter("Type")%>"/>
<input type='hidden' name=TypeAlias VALUE="<%=request.getParameter("TypeAlias")%>"/>
<input type='hidden' name="width" value=""/>
<input type='hidden' name="height" value=""/>
<OBJECT ID="upload" CLASSID="clsid:6EED3E1C-2279-4E93-9657-9AEFBAAD3F5F" CODEBASE="/tea/applet/Upload.CAB#version=2,0,0,0" width="600" height="500" style="display:none">
</OBJECT>
<script>
var obj=document.all("upload");
var memberpic=document.all("memberpic").value;
var nodeid=document.all("node").value;

obj.cookie=document.cookie;
obj.filter="所有图像格式|*.jpg"; //obj.filter="所有图像格式|*.jpg;*.gif;*.bmp;*.png|Word文件|*.doc|所有文件 (*.*)|*.*";
obj.url="http://"+location.host+"/servlet/EditPicture?NewNode=0&pictype=1&nodeid="+nodeid+"&community=<%=teasession._strCommunity%>&repository=res/<%=teasession._strCommunity%>/salepic/<%=java.net.URLEncoder.encode(teasession._rv._strV,"UTF-8")%>";
//obj.min=50*1024;   //最小文件
obj.max=25*1024*1024;  //最大文件
//obj.size=30*1024*1024; //图片未压缩大小
obj.size=1*1024*1024; //图片未压缩大小
obj.setBackColor(13607543);//白:16777215
obj.setSize(600,500);
obj.info="上传成功,请等待管理员进行审核!";
obj.style.display="";
</script>
<%
//if(_bNew)
//{
//  out.print("<input type=SUBMIT name=CBContinue  VALUE="+r.getString(teasession._nLanguage,"CBContinue")+" >");
//}
%>
<!--input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>"-->
</FORM>
</body>
</html>
