<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);


boolean flag =request.getParameter("NewNode")!=null;

Node node = Node.find(teasession._nNode);

if((node.getOptions1()& 1) == 0)
{
  if(teasession._rv==null)
  {
    response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
    return;
  }
  if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(44))
  {
    response.sendError(403);
    return;
  }
}

Resource r=new Resource("/tea/ui/node/type/newspaper/EditNewsPaper");

String community = node.getCommunity();


long options=node.getOptions();
int defaultlanguage=node.getDefaultLanguage();
int sequence = 0;
String subject = null;
String subtitle = null;
String keywords = null;
String author =null;
String text=null;


int issue =0;
String column =null;
String edition =null;
String editor = null;
java.util.Date pubdate=null;

if(!flag)
{
  subject=tea.html.HtmlElement.htmlToText(node.getSubject(teasession._nLanguage));
  keywords=node.getKeywords(teasession._nLanguage);
  text=tea.html.HtmlElement.htmlToText(node.getText(teasession._nLanguage));
  sequence=node.getSequence();

  NewsPaper obj=NewsPaper.find(teasession._nNode,teasession._nLanguage);
  subtitle=obj.getSubTitle();
  author=obj.getAuthor();
  issue=obj.getIssue();
  edition=obj.getEdition();
  column=obj.getColumn();
  editor=obj.getEditor();

  pubdate=obj.getPubdate();

} else
{
  sequence = Node.getMaxSequence(teasession._nNode) + 10;

}

%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
  <script type="">
  function getIssueValue()
  {
    if(form1.issue.value=='0')
    {
      form1.issue.value=getCookie('tea.IssueValue<%=node._nNode%>','0');
      if(form1.issue.value=='null')
      form1.issue.value='0';
    }
  }
  function setIssueValue()
  {
    if(form1.issue.value!='0')
    {
      setCookie('tea.IssueValue<%=node._nNode%>',form1.issue.value);
    }
  }
  function submitCheck()
  {
    if(submitText(form1.subject, '<%=r.getString(teasession._nLanguage,"InvalidSubject")%>')&&submitInteger(form1.issue, '<%=r.getString(teasession._nLanguage,"Qihao")%>')&&submitInteger(form1.sequence, '<%=r.getString(teasession._nLanguage,"InvalidSequence")%>') )
    {
      et.save();
      return true;
    }else
    {
      return false;
    }
  }
  </script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage,Node.NODE_TYPE[44])%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%>  </div>

<FORM NAME=form1 METHOD=POST ACTION="/servlet/EditNewsPaper" ENCTYPE=multipart/form-data onSubmit="return submitCheck();">
<%
if(flag)
{
  out.print("<input type=hidden name=NewNode value=ON >");
}
%>
<INPUT TYPE=HIDDEN NAME="community" VALUE="<%=community%>">
<INPUT TYPE=HIDDEN NAME="node" VALUE="<%=teasession._nNode%>">


<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
<tr><td ><%=r.getString(teasession._nLanguage, "Subject")%>:</td><td>
<INPUT TYPE=TEXT  class="edit_input" NAME=subject VALUE="<%if(subject!=null)out.print(subject);%>" SIZE=70 MAXLENGTH=255></td></tr>

<tr><td ><%=r.getString(teasession._nLanguage, "SubTitle")%>:</td><td>
<INPUT TYPE=TEXT  class="edit_input" NAME=subtitle VALUE="<%if(subtitle!=null)out.print(subtitle.replaceAll("\"", "&quot;"));%>" SIZE=70 MAXLENGTH=255></td></tr>

<tr>
<TD COLSPAN=2><P ALIGN=CENTER>
<!--INPUT TYPE=SUBMIT NAME="GoNext" VALUE="下一步"-->
<input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "Super")%>">
<INPUT TYPE=SUBMIT class="edit_button"  NAME="GoFinish" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>"></P></td></tr>

<tr><td ><%=r.getString(teasession._nLanguage, "Keywords")%>:</td><td>
<INPUT TYPE=TEXT  class="edit_input" NAME=keywords VALUE="<%if(keywords!=null)out.print(keywords);%>" SIZE=70 MAXLENGTH=255></td></tr>

<tr><td ><%=r.getString(teasession._nLanguage, "Author")%>:</td><td>
<INPUT TYPE=TEXT  class="edit_input" NAME=author VALUE="<%if(author!=null)out.print(author);%>" SIZE=70 MAXLENGTH=255></td></tr>

<tr><td >  </td>
<td>
 <input id="CHECKBOX" type="CHECKBOX" name="nonuse" id="nonuse" value="checkbox" onclick="f_editor(this)"><label for="nonuse"><%=r.getString(teasession._nLanguage, "NonuseEditor")%></label><br/>
</td></tr>

<tr>
<td><%=r.getString(teasession._nLanguage, "Text")%>:</td>
<td>
<textarea style="display:none" name="content" rows="12" cols="97" class="edit_input"><%if(text!=null)out.print(text);%></textarea>
<iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=community%>" width="730" height="300" frameborder="no" scrolling="no"></iframe>

<tr>
<td >       </td>
<td>
<INPUT TYPE=BUTTON NAME="Pictureview" class="edit_button"  VALUE="<%=r.getString(teasession._nLanguage, "Pictureview")%>" onClick="window.open('/servlet/InsertPicture', '_blank');"></td></tr>
<tr><td  nowrap="nowrap"><%=r.getString(teasession._nLanguage,"Qihao")%>:</td><td>
<INPUT TYPE=TEXT  class="edit_input" NAME=issue onChange="setIssueValue();" VALUE="<%=issue%>"  MAXLENGTH=255>

</td></tr>
<tr><td  nowrap="nowrap"><%=r.getString(teasession._nLanguage,"Edition")%>:</td><td><INPUT TYPE=TEXT  class="edit_input" NAME=edition VALUE="<%if(edition!=null)out.print(edition);%>" SIZE=70 MAXLENGTH=255></td></tr>

<tr><td  nowrap="nowrap"><%=r.getString(teasession._nLanguage,"Lanmu")%>:</td><td><INPUT TYPE=TEXT  class="edit_input" NAME=column VALUE="<%if(column!=null)out.print(column);%>" SIZE=70 MAXLENGTH=255></td></tr>

<tr><td  nowrap="nowrap"><%=r.getString(teasession._nLanguage,"Editor")%>:</td><td><INPUT TYPE=TEXT  class="edit_input" NAME=editor VALUE="<%if(editor!=null)out.print(editor);%>" SIZE=70 MAXLENGTH=255></td></tr>

<tr>
<td  nowrap="nowrap"><%=r.getString(teasession._nLanguage,"PubDate")%>:</td>
<td><%=new tea.htmlx.TimeSelection("Issue", pubdate)%></td></tr>

<tr>
<td  nowrap="nowrap"><%=r.getString(teasession._nLanguage, "Sequence")%>:</td><td>
<INPUT TYPE=TEXT  class="edit_input" NAME=sequence VALUE="<%=sequence%>"></td></tr>


</TABLE>

</FORM>
<SCRIPT>getIssueValue();document.form1.subject.focus(); f_editor();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</html>
