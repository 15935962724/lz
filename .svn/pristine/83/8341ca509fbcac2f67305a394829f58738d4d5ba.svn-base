<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.node.*" %><%@page  import="tea.entity.site.*" %><%@ page import="java.util.*" %><%@ page import="tea.ui.*" %><%@ page import="tea.html.*" %><%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);



Node node=Node.find(teasession._nNode);
Category category = Category.find(teasession._nNode);//显示类别中的内容
boolean _bNew=request.getParameter("NewNode")!=null;
String community=node.getCommunity();
int options1=node.getOptions1();
if(!_bNew)//如果是编辑就取父节点的选项,即：类别
{
  options1=Node.find(node.getFather()).getOptions1();
}
int type=node.getType();
if(type==1)
{
  type=category.getCategory();
}
if((options1& 1) == 0)
{
  if(teasession._rv==null)
  {
    response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
    return;
  }
  if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(type))
  {
    response.sendError(403);
    return;
  }
}

Resource r=new Resource("/tea/resource/Venues");

Community c=Community.find(community);

String title=r.getString(teasession._nLanguage, "Venues");

String parameter=teasession.getParameter("nexturl");
boolean parambool=(parameter!=null&&!parameter.equals("null"));
String subject=null;
String address=null;
String text = null;
String linkman = null;
String contactway=null;
String aunit=null;
String intropicname=null;
String intropicpath = null;
int seating = 0;
int let = 0;
if(_bNew)
{
  out.println("<input type=hidden NAME=NewNode VALUE=ON>");
}else
{
  Venues obj=Venues.find(teasession._nNode);
  text=HtmlElement.htmlToText(node.getText(teasession._nLanguage));
  subject=node.getSubject(teasession._nLanguage);
  address=obj.getAddress();
  linkman=obj.getLinkman();
  contactway=obj.getContactway();
  aunit=obj.getAunit();
  seating=obj.getSeating();
  intropicname = obj.getIntropicname();
  intropicpath = obj.getIntropicpath();
  if(intropicpath!=null&&intropicpath.length()>0)
  {
   	let=(int)new java.io.File(application.getRealPath(intropicpath)).length();
  }
}


%>
<html>
<head>
<title><%=title%></title>

<style type="text/css">
#gzd{position:absolute;position: relative;}
#xilidiv{display:block;position: relative;position:absolute;height: auto;width: 281px;left: 0px;top: 19px;z-index:1;}
#tablecenter #xiaoliajatable{background:#ffffff;width: 281px;}
#tablecenter #xiaoliajatable td{padding:4px 5px 2px 5px;height:18px;border-collapse:collapse;border:1px solid #9BB7CC;border-top:0;}
</style>

<script src="/tea/tea.js" type="text/javascript" ></script>
<script src="/res/<%=community%>/cssjs/community.js" type="text/javascript" defer="defer"></script>
<link href="/res/<%=community%>/cssjs/community.css" type="text/css" rel="stylesheet">
<script language="javascript" src="/tea/inc/media_<%=teasession._nLanguage%>_92.js?<%=System.currentTimeMillis()%>" type="text/javascript"></script>

</head>
<body>
<h1><%=title%></h1>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<form name="form1" METHOD=POST action="/servlet/EditVenues" enctype="multipart/form-data" onSubmit="return submitText(this.subject, '<%=r.getString(teasession._nLanguage, "Venues.Noname")%>');">
<%
if(parambool)
out.print("<input type='hidden' name=nexturl value="+parameter+">");
%>
<input type='hidden' name="node" value="<%=teasession._nNode%>">
<input type='hidden' name="community" value="<%=community%>">
<input type='hidden' name="act" value="EditVenues">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="Venues_name">
    <td nowrap align="right">&nbsp;*&nbsp;<%=r.getString(teasession._nLanguage, "Venues.name")%>:<!--标题--></TD>
    <td nowrap><input name="subject" size=70 maxlength=255 class="edit_input" value="<%if(subject!=null)out.print(subject.replaceAll("\"","&quot;"));%>"/></td>
  </tr>
  <tr id="Venues_address">
    <td nowrap align="right"><%=r.getString(teasession._nLanguage, "Venues.address")%>:<!--地址--></TD>
    <td nowrap><input name="address" size=70 maxlength=255 class="edit_input" value="<%if(address!=null)out.print(address.replaceAll("\"","&quot;"));%>"/></td>
  </tr>

  <tr id="Venues_text_1">
    <td nowrap> </TD>
    <td nowrap><input  id="radio" type="radio" name=TextOrHtml value=0 checked="checked">
      <%=r.getString(teasession._nLanguage, "TEXT")%>
      <input  id="radio" type="radio" name=TextOrHtml value=1 <%if((node.getOptions() & 0x40) != 0)out.print(" CHECKED ");%> >HTML
      <input type="button" name="Pictureview" id="Pictureview" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Pictureview")%>" onClick="window.open('/servlet/InsertPicture?node=<%=teasession._nNode%>', '_blank');">
      <input  id="CHECKBOX" type="checkbox" name="nonuse" value="checkbox" onclick="f_editor(this)"><label for="nonuse"><%=r.getString(teasession._nLanguage, "NonuseEditor")%></label>
        <input type="checkbox" name="srccopy"/>源网站的图片贴入本地
    </td>
  </tr>

  <tr id="Venues_text">
    <td nowrap align="right"><%=r.getString(teasession._nLanguage, "Venues.text")%>:</TD>
    <td nowrap>
      <textarea style="display:none" name="content" rows="12" cols="90" class="edit_input"><%if(text!=null)out.print(text);%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=community%>" width="740" height="300" frameborder="no" scrolling="no"></iframe>
    </td>
  </tr>
  <tr id="Venues_linkman">
    <td nowrap align="right"><%=r.getString(teasession._nLanguage, "Venues.linkman")%>:<!--联系人--></TD>
    <td nowrap><input name="linkman"  class="edit_input" value="<%if(linkman!=null)out.print(linkman.replaceAll("\"","&quot;"));%>"/></td>
  </tr>

  <tr id="Venues_contactway">
    <td nowrap align="right"><%=r.getString(teasession._nLanguage, "Venues.contactway")%>:<!--联系方式--></TD>
    <td nowrap><input name="contactway" size=70 maxlength=255 class="edit_input" value="<%if(contactway!=null)out.print(contactway.replaceAll("\"","&quot;"));%>"/></td>
  </tr>
  <tr id="Venues_aunit">
    <td nowrap align="right"><%=r.getString(teasession._nLanguage, "Venues.aunit")%>:<!--所属单位--></TD>
    <td nowrap><input name="aunit" size=70 maxlength=255 class="edit_input" value="<%if(aunit!=null)out.print(aunit.replaceAll("\"","&quot;"));%>"/></td>
  </tr>

  <tr id="Venues_intropic">
    <td nowrap align="right"><%=r.getString(teasession._nLanguage, "Venues.intropic")%>:</TD>
    <td nowrap>
      <input type="file" name="intropic" class="edit_input">
      <%
      if(let > 0)
      {
        out.print("<a href='"+intropicpath+"' target='_blank'>"+let + r.getString(teasession._nLanguage, "Bytes")+"</a>");
        out.print("<input id='checkbox' type='checkbox' name='clearintropic' onclick='form1.intropic.disabled=this.checked'>"+r.getString(teasession._nLanguage, "Clear"));
      }
      %>
      <input type="checkbox" name="tbn" checked="checked"/>自动缩小图片
    </td>
  </tr>
    <tr id="Venues_seating">
    <td nowrap align="right"><%=r.getString(teasession._nLanguage, "Venues.seating")%>:<!--所属单位--></TD>
    <td nowrap><input name="seating"  class="edit_input" value="<%=seating%>"/></td>
  </tr>


</table>
<br />
<center>
  <input type="hidden" name="act" value="">
      <input type=SUBMIT name="GoFinish" ID="edit_GoFinish"   class="edit_button" value="<%=r.getString(teasession._nLanguage, "Venues.seatinstall")%>">&nbsp;
      <input type=SUBMIT name="GoBackSuper" id="edit_GoSuper"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "Venues.submit")%>">&nbsp;
      <input type=button value="返回" onClick="javascript:history.back()">
</center>
</FORM>

<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
