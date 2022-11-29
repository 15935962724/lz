<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="javax.servlet.ServletConfig" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.html.HtmlElement"%>
<%!
String getCheck(boolean bool)
{
	return bool?" CHECKED ":" ";
}
String getCheck(int value)
{
	return value!=0?" CHECKED ":" ";
}
String getNull(String strNull)
{	return strNull==null?"":strNull;
}%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);
Node   node=Node.find(teasession._nNode);

if((node.getOptions1()& 1) == 0)
{
  if(teasession._rv==null)
  {
    response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
    return;
  }
  if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(73))
  {
    response.sendError(403);
    return;
  }
}


Resource r = new Resource("/tea/resource/MessageBoard");

%><html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<script>
function f_sub()
{

 if(foEdit.subject.value=='')
 {
    alert("主题不能为空!");
     return false;
 }
 if(foEdit.age.value!=''){
	 var ag=foEdit.age.value.trim();
	 if(isNaN(ag)){
		 alert("年龄必须为数字");
		 return false;
	 }
 }


}
</script>
<body onLoad="document.foEdit.subject.focus();">
<h1><%=r.getString(teasession._nLanguage, "EditMessageBoard")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
  <br>
  <FORM NAME=foEdit METHOD=POST action="/servlet/EditMessageBoard"  onSubmit="return f_sub();">
    <INPUT TYPE=HIDDEN NAME=Node VALUE="<%=teasession._nNode%>">
<%
    String nexturl=request.getParameter("nexturl");
    if(nexturl!=null)
    out.println(new tea.html.HiddenField("nexturl",nexturl));


String subject=null,text=null;
int hint=0;
String email=null,mobile=null,name=null,phone=null;
int age=0,sex=0;
if(request.getParameter("NewNode")!=null)
{
  out.println(new tea.html.HiddenField("NewNode","ON"));
  if(teasession._rv!=null)
  {
    Profile obj=Profile.find(teasession._rv._strV);
    email=obj.getEmail();
    mobile=obj.getMobile();
    name=obj.getFirstName(teasession._nLanguage);
    phone=obj.getTelephone(teasession._nLanguage);
    age= obj.getAge();
    sex=obj.isSex()?1:0;
  }
}else
{
  MessageBoard obj=MessageBoard.find(teasession._nNode,teasession._nLanguage);
  subject=node.getSubject(teasession._nLanguage);
  text=node.getText(teasession._nLanguage);
  hint=obj.getHint();
  email=obj.getEmail();
  mobile=obj.getMobile();
  name=  obj.getName();
  phone=obj.getPhone();
  age=obj.getAge();
  sex=obj.getSex();
}
%>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <TR id="edittalikback2">
        <TD><%=r.getString(teasession._nLanguage, "CcMembers")%>:</TD>
        <TD><INPUT NAME=cc TYPE=TEXT class="edit_input" VALUE="" SIZE=40 MAXLENGTH=255></TD>
      </TR>
      <TR id="edittalikback3">
        <TD><%=r.getString(teasession._nLanguage, "Bcc")%>:</TD>
        <TD><INPUT NAME=bcc TYPE=TEXT class="edit_input" VALUE="" SIZE=40 MAXLENGTH=255></TD>
      </TR>
      <TR id="edittalikback4">
        <TD><%=r.getString(teasession._nLanguage, "Options")%>:</TD>
        <TD>
          <INPUT  id=CHECKBOX type="CHECKBOX" NAME=msgOsendemail VALUE=null <%=getCheck(false)%>>
          <%=r.getString(teasession._nLanguage, "SameSendE-MAIL")%></TD>
      </TR>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Name")%> </TD>
        <td><input name="name" type="text" value="<%=getNull(name)%>">
        </td>
      </tr>
      
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "性别")%> </TD>
        <td><INPUT  id="radio" type="radio" NAME=sex VALUE=0 <%=(sex==0)?"checked":"" %> ><span>男</span>
          <INPUT  id="radio" type="radio" NAME=sex VALUE=1 <%=(sex==1)?"checked":"" %> ><span>女</span>
        </td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "年龄")%> </TD>
        <td><input name="age" type="text" value="<%=age%>">
        </td>
      </tr>
      
      
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "phone")%> </TD>
        <td><input name="phone" type="text" value="<%=getNull(phone)%>">
        </td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "mobile")%> </TD>
        <td><input name="mobile" type="text" value="<%=getNull(mobile)%>">
        </td>
      </tr>
      <tr>
        <TD>E-Mail </TD>
        <td><input name="email" type="text" value="<%=getNull(email)%>">
        </td>
      </tr>
<%
CommunityOption co = CommunityOption.find(teasession._strCommunity);
String mb = co.get("msgboptions");
if(mb!=null&&mb.indexOf("/1/")!=-1)
{
  out.print("<tr><td>验正码:</td><td><input name='vertify' size='10'><img src='/jsp/user/validate.jsp'/></td></tr>");
}
%>
      <TR id="edittalikback5">
        <TD><%=r.getString(teasession._nLanguage, "Hint")%>:</TD>
        <TD><INPUT  id="radio" type="radio" NAME=hint VALUE=0 CHECKED><IMG BORDER=0 SRC="/tea/image/hint/0.gif">
          <INPUT  id="radio" type="radio" NAME=hint VALUE=1 <%=getCheck(hint==1)%>><IMG BORDER=0 SRC="/tea/image/hint/1.gif">
          <INPUT  id="radio" type="radio" NAME=hint VALUE=2<%=getCheck(hint==2)%>><IMG BORDER=0 SRC="/tea/image/hint/2.gif">
          <INPUT  id="radio" type="radio" NAME=hint VALUE=3<%=getCheck(hint==3)%>><IMG BORDER=0 SRC="/tea/image/hint/3.gif">
          <INPUT  id="radio" type="radio" NAME=hint VALUE=4<%=getCheck(hint==4)%>><IMG BORDER=0 SRC="/tea/image/hint/4.gif">
          <INPUT  id="radio" type="radio" NAME=hint VALUE=5<%=getCheck(hint==5)%>><IMG BORDER=0 SRC="/tea/image/hint/5.gif">
          <INPUT  id="radio" type="radio" NAME=hint VALUE=6<%=getCheck(hint==6)%>><IMG BORDER=0 SRC="/tea/image/hint/6.gif">
          <INPUT  id="radio" type="radio" NAME=hint VALUE=7<%=getCheck(hint==7)%>><IMG BORDER=0 SRC="/tea/image/hint/7.gif">
          <INPUT  id="radio" type="radio" NAME=hint VALUE=8<%=getCheck(hint==8)%>><IMG BORDER=0 SRC="/tea/image/hint/8.gif">
          <INPUT  id="radio" type="radio" NAME=hint VALUE=9<%=getCheck(hint==9)%>><IMG BORDER=0 SRC="/tea/image/hint/9.gif">
          <INPUT  id="radio" type="radio" NAME=hint VALUE=10<%=getCheck(hint==10)%>><IMG BORDER=0 SRC="/tea/image/hint/10.gif">
          <INPUT  id="radio" type="radio" NAME=hint VALUE=11<%=getCheck(hint==11)%>><IMG BORDER=0 SRC="/tea/image/hint/11.gif"></TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "Subject")%>:</TD>
        <TD><INPUT NAME="subject" TYPE=TEXT class="edit_input" VALUE="<%=getNull(subject)%>" SIZE=70 MAXLENGTH=255></TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
        <TD>

          <textarea name="content" id="content"  rows="1" cols="1" style="display:none"><%=HtmlElement.htmlToText(text)%></textarea>
<iframe id="myiframe" src="/jsp/include/smallFCK/Edit/editor.htm?id=content&ReadCookie=0" frameborder="0" scrolling="no" width="621" height="200"></iframe>

        </TD>
      </TR>
    </TABLE>
    <INPUT TYPE=SUBMIT class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </FORM>
  <br>
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%> </DIV>
</body>
</html>
