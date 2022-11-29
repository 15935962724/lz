<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><%@ page import="tea.html.*" %><%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);

Node node=Node.find(teasession._nNode);

boolean _bNew=request.getParameter("NewNode")!=null;

String community=node.getCommunity();

int options1=node.getOptions1();
if(!_bNew)//如果是编辑就取父节点的选项,即：类别
{
  options1=Node.find(node.getFather()).getOptions1();
}
if((options1& 1) == 0)
{
  if(teasession._rv==null)
  {
    response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
    return;
  }
  if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(39))
  {
    response.sendError(403);
    return;
  }
}

Resource r=new Resource();
r.add("/tea/ui/node/type/report/EditReport");

%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function fnonuse(obj)
{
  var ewebeditor=document.all('word_body');
  if(obj.checked)
  {
    foNew.Text.style.display="";
    ewebeditor.style.display="none";
    setCookie('jsp.type.report.EditReport.nonuse',obj.checked);
  }else
  {
    ewebeditor.style.display="";
    foNew.Text.style.display="none";
    setCookie('jsp.type.report.EditReport.nonuse','');
  }
}
function submitSave()
{
     et.save();
     if(!foNew.nonuse.checked)
     foNew.Text.value=foNew.word_body_textarea.value;

     return true;
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Report")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%>  </div>
  <FORM name=foNew METHOD=POST action="/servlet/EditReport"  enctype=multipart/form-data onSubmit="return submitText(this.subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&submitSave();" >
<%
String parameter=teasession.getParameter("nexturl");
boolean   parambool=(parameter!=null&&!parameter.equals("null"));
if(parambool)
out.print("<input type='hidden' name=nexturl value="+parameter+">");
String text="",subject=null,keywords=null;

int m_r=0;
int c_r=0;
java.util.Date date_r=null;
long l2=0;
int j=0;
String picture=null,locus=null,subhead=null,author=null,logograph=null;
int mostl=1;
if(_bNew)
{
  out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
}else
{
  text=HtmlElement.htmlToText(node.getText(teasession._nLanguage));
  subject=node.getSubject(teasession._nLanguage);
  keywords=node.getKeywords(teasession._nLanguage);

  tea.entity.node.Report  report_r=tea.entity.node.Report.find(teasession._nNode,teasession._nLanguage);
  m_r=report_r.getMedia();
  c_r=report_r.getClasses();
  date_r=report_r.getIssueTime();
  picture=report_r.getPicture();
  locus=report_r.getLocus();
  subhead=report_r.getSubhead();
  author=report_r.getAuthor();
  logograph=report_r.getLogograph();
  if(picture!=null)
  {
    l2=new java.io.File(application.getRealPath(picture)).length();
  }
  mostl=node.getMostly();
}
            %>
    <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr><td nowrap>*<%=r.getString(teasession._nLanguage, "1168312316734")%>:<!--标题--></TD>
        <td nowrap><input name="subject"  size=70 maxlength=255 class="edit_input" value="<%if(subject!=null)out.print(subject.replaceAll("\"","&quot;"));%>"/></td></tr>
      <tr>
        <td nowrap><%=r.getString(teasession._nLanguage, "media")%>:</TD>
        <td nowrap>
          <%
          tea.html.DropDown dropdown = new tea.html.DropDown("media",m_r);
          dropdown.addOption(0,"-------------");
          java.util.Enumeration _media_enumer=Media.find("",0,Integer.MAX_VALUE);
          while(_media_enumer.hasMoreElements())
          {
            Media media_obj=Media.find(((Integer) _media_enumer.nextElement()).intValue());
            dropdown.addOption(media_obj.getMediaID(),media_obj.getName());
          }
          out.println(dropdown);
          %>
          <input type=BUTTON onClick="window.open('/servlet/NewMedia?node=<%=teasession._nNode%>&nextUrl=<%=request.getRequestURI()%>&type=<%=j%>', '_self');" VALUE="<%=r.getString(teasession._nLanguage, "New")%>">
          <input type=BUTTON onClick="window.open('/servlet/ManageMedia?node=<%=teasession._nNode%>&type=<%=j%>', '_self');" VALUE="<%=r.getString(teasession._nLanguage, "All")%>">
          <input type=BUTTON onClick="window.open('/jsp/type/media/MediaSel.jsp?index=foNew.media','','edge:raised;status:0;help:0;resizable:1;scrollbars=1;dialogWidth:450px;dialogHeight:550px;dialogTop:100 ;dialogLeft:150 ');" VALUE="<%=r.getString(teasession._nLanguage, "Search")%>">
        <br/></td>
      </tr>
      <tr>
        <td nowrap><%=r.getString(teasession._nLanguage, "class")%>:</TD>
        <td nowrap><%
                tea.html.DropDown dropdown1 = new tea.html.DropDown("class",c_r);
                dropdown1.addOption(0,"-------------");
                java.util.Enumeration enumer=tea.entity.node.Classes.findByCommunity(node.getCommunity(),teasession._nLanguage);
                while(enumer.hasMoreElements())
                {
                  tea.entity.node.Classes class_obj=  tea.entity.node.Classes.find(((Integer)enumer.nextElement()).intValue());
                  dropdown1.addOption(class_obj.getId(),class_obj.getName());
                }
                out.println(dropdown1);
                %>
          <input name="fff" type=BUTTON class="edit_button" onClick="window.open('/servlet/NewClass?node=<%=teasession._nNode%>&type=<%=j%>', '_self');" VALUE="<%=r.getString(teasession._nLanguage, "New")%>">
          <input name="fff" type=BUTTON class="edit_button" onClick="window.open('/servlet/ManageClasses?node=<%=teasession._nNode%>&type=<%=j%>', '_self');" VALUE="<%=r.getString(teasession._nLanguage, "All")%>">
        <br/></td>
      </tr>
      <tr>
        <td nowrap><%=r.getString(teasession._nLanguage, "Picture")%>:</TD>
        <td nowrap>
          <input TYPE=FILE NAME="picture" onDblClick="<%if(l2>0)out.print("window.open('"+picture+"');");%>" class="edit_input">
          <%if(l2 != 0) out.print(l2 + r.getString(teasession._nLanguage, "Bytes"));%>
          <input  id="CHECKBOX" type="CHECKBOX" NAME=clearpicture onClick="foNew.picture.disabled=this.checked"><%=r.getString(teasession._nLanguage, "Clear")%>
        </td>
      </tr>
      <tr><td nowrap><%=r.getString(teasession._nLanguage, "Locus")%>:</TD>
        <td nowrap><input name="locus" size="50"  class="edit_input" value="<%if(locus!=null)out.print(locus.replaceAll("\"","&quot;"));%>"/></td>
</tr>
<tr>
  <TD><%=r.getString(teasession._nLanguage, "Keywords")%>:</TD>
  <td><input type="TEXT" class="edit_input"  name="keywords" value="<%if(keywords!=null)out.print(keywords.replaceAll("\"","&quot;"));%>" size="70" maxlength="255">
  </td>
</tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "1168312412921")%>:<!--副标题--></TD>
        <td><input type="TEXT" class="edit_input"  name="subhead" value="<%if(subhead!=null)out.print(subhead.replaceAll("\"","&quot;"));%>" size="70" maxlength="255">
        </td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "1168312423500")%>:<!--作者--></TD>
        <td><input type="TEXT" class="edit_input"  name="author" value="<%if(author!=null)out.print(author.replaceAll("\"","&quot;"));%>" size="70" maxlength="255">
        </td>
      </tr>


            <tr>
        <td nowrap><%=r.getString(teasession._nLanguage, "Logograph")%>:</TD>
        <td nowrap> <textarea name="logograph" rows="8" cols="70" class="edit_input"><%if(logograph!=null)out.print(logograph.replaceAll("</","&lt;/"));%></textarea>    </td>
      </tr>
      <tr>
        <td nowrap> </TD>
        <td nowrap><input  id="radio" type="radio" name=TextOrHtml value=0 checked="checked">
          <%=r.getString(teasession._nLanguage, "TEXT")%>
          <input  id="radio" type="radio" name=TextOrHtml value=1 <%if((node.getOptions() & 0x40) != 0)out.print(" CHECKED ");%> >HTML
<%--<input  id="radio" type="radio" name=TextOrHtml value=2 <%=getCheck((j1 & 0x20) != 0)%> >JSP--%>
  <input type="button" name="Pictureview" id="Pictureview" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Pictureview")%>" onClick="window.open('/servlet/InsertPicture?node=<%=teasession._nNode%>', '_blank');">
  <input  id="CHECKBOX" type="CHECKBOX" name="nonuse"  id="nonuse" value="checkbox" onclick="fnonuse(this)"><label for="nonuse"><%=r.getString(teasession._nLanguage, "NonuseEditor")%></label>


        </td>      </tr>
               </table>

<table border="0" cellpadding="0" cellspacing="0" id="tableword">
       <tr>
        <td nowrap><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
        <td nowrap><textarea style="display:none"  name="Text" rows="8" cols="70" class="edit_input"><%=text%></textarea>


<script language="JavaScript" type="text/javascript" src="/jsp/include/word_edit/word_edit.js"></script>
<link rel="Stylesheet" href="/jsp/include/word_edit/word_edit.css" type="text/css" media="all" />
<script type="text/javascript">
document.write("<div id=\"word_body\" ></div>");
et = new word("word_body", foNew.Text );
foNew.attachEvent("onsubmit", et.save);
</script>

<script>
//alert(getCookie('jsp.type.report.EditReport.nonuse',''));
foNew.nonuse.checked=getCookie('jsp.type.report.EditReport.nonuse','');
fnonuse(foNew.nonuse);
</script>

</td>
       </tr>
       </table>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td nowrap><%=r.getString(teasession._nLanguage, "HappenTime")%>:</TD>
        <td nowrap><%=new tea.htmlx.TimeSelection("Issue", date_r)%></td>
      </tr>
      <tr>
      <TD></td>
      <TD><input type="checkbox" name="mostly" <%if(mostl==1)out.print("checked");%> /><%=r.getString(teasession._nLanguage, "Mostly")%></td>
      </tr>
    </table>

    <center>
<input type="hidden" name="act" value="">
          <input type=SUBMIT name="GoFinish" ID="edit_GoFinish"  onClick="act.value='finish';" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Finish")%>">
          <input type=SUBMIT name="GoFinish" ID="edit_GoFinish"  onClick="act.value='next';" class="edit_button" value="<%=r.getString(teasession._nLanguage, "CBNext")%>">
<input type=SUBMIT name="GoBackSuper" id="edit_GoNext" onClick="act.value='back';" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Super")%>">
    </center>
  </FORM>
  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
  <script>foNew.subject.focus();</script>

 <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
