<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*"%>
<%@page import="tea.ui.*" %><%@ page import="tea.entity.node.*" import="tea.html.*" import="tea.db.*" import="tea.entity.site.*" import="tea.resource.*" import="java.util.*" import="java.io.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);

Http h=new Http(request,response);


int realnode=teasession._nNode;
int cssjs=Integer.parseInt(request.getParameter("cssjs"));
int status=0;
int style=0,styletype=0,stylecategory=39,hiden=3;
boolean theme=false;
String name=null,css=null,js=null,picture=null;
if(cssjs>0)
{
  CssJs obj=CssJs.find(cssjs);
  realnode=obj.getNode();
  status=obj.getStatus();
  style=obj.getStyle();
  styletype=obj.getStyleType();
  stylecategory=obj.getStyleCategory();
  theme=obj.isTheme();
  picture=obj.getPicture();

  name=obj.getName(teasession._nLanguage);
  css=obj.getCss(teasession._nLanguage);
  js=obj.getJs(teasession._nLanguage);

  Cssjshide ch=Cssjshide.find(cssjs,teasession._nNode);
  hiden=ch.getHiden();
}else
{
  name=css=js="";
  status=Integer.parseInt(request.getParameter("status"));
}
AccessMember am = AccessMember.find(teasession._nNode, teasession._rv);
if(realnode>0&&!Node.find(realnode).isCreator(teasession._rv)&&am.getPurview()<2)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}
Node node=Node.find(teasession._nNode);

String title="CSS\\JS"+" ( "+cssjs+")";

Resource r=new Resource();

%>
<html>
<head>
<title><%=title%></title>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function f_load()
{
  f_change();
  form1.type.onchange=f_change;
  form1.name.focus();
}
function f_change()
{
  var o1=form1.type.options;
  var sc=form1.stylecategory;
  var o2=sc.options;
  if(form1.type.value=="1")
  {
    sc.style.display="";
  }else
  {
    sc.style.display="none";
  }
  if(o2.length==0)
  {
    for(var i=0;i<o1.length;i++)
    {
      var v=o1[i].value;
      if(v!="255"&&v!="0"&&v!="1")
      {
        o2[o2.length]=new Option(o1[i].text,v);
      }
    }
    if(<%=stylecategory%>!=0)
    sc.value="<%=stylecategory%>";
  }
}
</script>
</head>
<body onload="f_load()">
<%=tea.ui.node.general.NodeServlet.getButton(node,h, am,request)%>
<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" method="post" action="/servlet/EditCssJs" enctype="multipart/form-data" onsubmit="mt.storage(this,true);return(submitText(this.name,'<%=r.getString(teasession._nLanguage, "InvalidName")%>')&&(this.submit.disabled=true)&&mt.show(null,0))">
<input type=hidden name="community" value="<%=teasession._strCommunity%>">
<input type=hidden name="node" value="<%=teasession._nNode%>">
<input type=hidden name="cssjs" value="<%=cssjs%>">
<input type=hidden name="status" value="<%=status%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Name")%>:</td>
    <td><input name="name" type="text" value="<%=name%>" class="edit_input" size="50" maxlength="50"></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Options")%>:</td>
    <td><input name="theme" type="checkbox"  class="edit_input" <%if(theme)out.print(" checked=''");%> id="theme"><label for="theme">可选主题</label></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "缩略图")%>:</td>
    <td><input name="picture" type="file" class="edit_input" >
      <%
      if(picture!=null&&picture.length()>0)
      {
        out.print("<a href=\""+picture+"\" target='_blank'>查看</a>　");
        out.print("<input type='checkbox' name='pictureDel' onclick='form1.picture.disabled=checked' id='pictureDel'><label for='pictureDel'>删除</label>");
      }
      %></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"Edit")%>CSS:</td>
    <td><textarea  class="edit_input" name="css" cols="80" rows="12"><%=css%></textarea></td>
  </tr><tr>
    <td><%=r.getString(teasession._nLanguage,"Edit")%>JS:</td><td>
      <textarea class="edit_input"  name="js" cols="80" rows="12"><%=js%></textarea>
      <br/><a href="javascript:mt.storage(form1,true)">保存数据</a> <a href="javascript:mt.storage(form1,false)">恢复数据</a>
    </td>
  </tr>
    <tr><td><%=r.getString(teasession._nLanguage,"Style")%>:</td>
      <td>
        <input id="radio" type="radio" name="style" value="0" <%if(style==0)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, "ThisNode")%>
        <input id="radio" type="radio" name="style" value="2" <%if(style==2)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, "1206432316359")%>
        <%=new tea.htmlx.TypeSelection(teasession._strCommunity,teasession._nLanguage, styletype)%>
        <select name="stylecategory" style="display:none"></select>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "HidenStyle")%>:</td>
      <td>
        <input id="radio" type="radio" NAME=hiden VALUE=0 <%if(hiden==0)out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, Section.SECTION_HideStyle[0])%>
        <input id="radio" type="radio" NAME=hiden VALUE=1 <%if(hiden==1)out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, Section.SECTION_HideStyle[1])%>
        <input id="radio" type="radio" NAME=hiden VALUE=2 <%if(hiden==2)out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, Section.SECTION_HideStyle[2])%>
        <input id="radio" type="radio" NAME=hiden VALUE=3 <%if(hiden==3)out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, Section.SECTION_HideStyle[3])%>
      </td>
    </tr>
</table>

<input type="button" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Pictureview")%>" onClick="window.open('/servlet/InsertPicture?node=<%=teasession._nNode%>', '_blank');">
<input name="submit" type="SUBMIT" id="edit_submit" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
<%
if(node._nNode>0)
{
  out.print("<input name='example' type='submit' id='edit_submit' class='edit_button'  VALUE="+r.getString(teasession._nLanguage, "同时存为模板")+" />");
}
%>
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
