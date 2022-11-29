<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="java.io.*" %><%@page  import="java.util.*" %><%@page  import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><%@ page import="tea.html.*" %><%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);

Node n=Node.find(teasession._nNode);

boolean _bNew=request.getParameter("NewNode")!=null;

String community=n.getCommunity();

int options1=n.getOptions1();
if(!_bNew)//如果是编辑就取父节点的选项,即：类别
{
  options1=Node.find(n.getFather()).getOptions1();
}
if((options1& 1) == 0)
{
  if(teasession._rv==null)
  {
    response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
    return;
  }
  if (!n.isCreator(teasession._rv)&&!AccessMember.find(n._nNode, teasession._rv._strV).isProvider(39))
  {
    response.sendError(403);
    return;
  }
}

String member=teasession._rv._strR;

Resource r=new Resource("/tea/resource/AdminList");

%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function f_load()
{
  form1.subject.focus();
  form1.nonuse.checked=getCookie('jsp.type.report.EditReport.nonuse','');
  fnonuse(form1.nonuse);
}
</script>
</head>
<body onLoad="f_load()">
<h1><%=r.getString(teasession._nLanguage, "Report")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<div id="pathdiv"><%=n.getAncestor(teasession._nLanguage)%></div>

<FORM name="form1" METHOD=POST action="/servlet/EditScholar" enctype="multipart/form-data" onSubmit="return submitText(this.subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&submitText(this.father, '<%=r.getString(teasession._nLanguage, "无效-类别")%>');" >
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<%
String parameter=teasession.getParameter("nexturl");
boolean parambool=(parameter!=null&&!parameter.equals("null"));
if(parambool)
out.print("<input type='hidden' name=nexturl value="+parameter+">");
String text="",subject=null,keywords=null;

int media=0;
Date time=null;
long len=0;
int father=0;
String filepath=null,filename=null,locus=null,subhead=null,author=null,logograph=null;
boolean mostl=false;
if(_bNew)
{
  out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
  father=teasession._nNode;
}else
{
  father=n.getFather();
  text=HtmlElement.htmlToText(n.getText(teasession._nLanguage));
  subject=n.getSubject(teasession._nLanguage);
  keywords=n.getKeywords(teasession._nLanguage);

  Scholar obj=Scholar.find(teasession._nNode,teasession._nLanguage);
  media=obj.getMedia();
  time=obj.getTime();
  locus=obj.getLocus();
  subhead=obj.getSubhead();
  author=obj.getAuthor();
  filepath=obj.getFilePath();
  filename=obj.getFileName();
  logograph=obj.getLogograph();
  if(filepath!=null)
  {
    len=new File(application.getRealPath(filepath)).length();
  }
  mostl=n.isMostly();
}
%>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td nowrap>*<%=r.getString(teasession._nLanguage, "Subject")%>:<!--标题--></TD>
    <td nowrap><input name="subject"  size=70 maxlength=255 class="edit_input" value="<%if(subject!=null)out.print(subject.replaceAll("\"","&quot;"));%>"/></td>
  </tr>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage, "Scholar.media")%>:</TD>
    <td nowrap>
      <%=Media.toHtml(community,85,teasession._nLanguage,media)%>
      <input type=button value="..." onClick="window.open('/jsp/type/media/MediaSel.jsp?community=<%=community%>&type=85&field=form1.media','','width=450px,height=550');">
      <input type=button value="<%=r.getString(teasession._nLanguage, "管理")%>" onClick="window.open('/jsp/type/media/Medias.jsp?community=<%=community%>&type=85');">
    </td>
  </tr>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage, "Node.father")%>:</TD>
    <td nowrap>
      <select name="father">
      <option value="">-------------------------</option>
      <%
      Enumeration e=Node.find(" AND n.type=1 AND n.node IN ( SELECT node FROM Category WHERE category=85 ) ORDER BY n.path",0,Integer.MAX_VALUE);
      while(e.hasMoreElements())
      {
        int nodeid=((Integer)e.nextElement()).intValue();

        AccessMember am=AccessMember.find(nodeid,member);
        if(am.isProvider(85))
        {
          Node obj=Node.find(nodeid);
          out.print("<option value="+nodeid);
          if(father==nodeid)
          {
            out.print(" selected ");
          }
          out.print(">"+obj.getSubject(teasession._nLanguage));
        }
      }
      %>
      </select>
    </td>
  </tr>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage, "Scholar.locus")%>:</TD>
    <td nowrap><input name="locus" size="50"  class="edit_input" value="<%if(locus!=null)out.print(locus.replaceAll("\"","&quot;"));%>"/></td>
  </tr>
  <tr>
    <TD><%=r.getString(teasession._nLanguage, "Keywords")%>:</TD>
    <td><input type="TEXT" class="edit_input"  name="keywords" value="<%if(keywords!=null)out.print(keywords.replaceAll("\"","&quot;"));%>" size="70" maxlength="255"></td>
  </tr>
  <tr>
    <TD><%=r.getString(teasession._nLanguage, "Scholar.subhead")%>:<!--副标题--></TD>
    <td><input type="TEXT" class="edit_input"  name="subhead" value="<%if(subhead!=null)out.print(subhead.replaceAll("\"","&quot;"));%>" size="70" maxlength="255"></td>
  </tr>
  <tr>
    <TD><%=r.getString(teasession._nLanguage, "Scholar.author")%>:<!--作者--></TD>
    <td><input type="TEXT" class="edit_input"  name="author" value="<%if(author!=null)out.print(author.replaceAll("\"","&quot;"));%>" size="70" maxlength="255"></td>
  </tr>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage, "Scholar.file")%>:</td>
    <td nowrap><input name=file type=file class=edit_input size="40">
    <%
    if(len>0)
    {
      out.print("<a href=/servlet/ScholarDowns?node="+teasession._nNode+">"+len + r.getString(teasession._nLanguage, "Bytes")+"</a>");///jsp/include/DownFile.jsp?uri="+filepath+"&name="+java.net.URLEncoder.encode(filename,"UTF-8")+"
      out.print("<input id=checkbox type=checkbox NAME=clearfile onClick=form1.file.disabled=checked>"+r.getString(teasession._nLanguage, "Clear"));
    }
    %>
    <tr>
        <td nowrap><%=r.getString(teasession._nLanguage, "Scholar.logograph")%>:</TD>
        <td nowrap><textarea name="logograph" rows="8" cols="70" class="edit_input"><%if(logograph!=null)out.print(logograph.replaceAll("</","&lt;/"));%></textarea>    </td>
    </tr>

    <tr>
      <td nowrap> </TD>
      <td nowrap>
        <input  id="radio" type="radio" name=TextOrHtml value=0 checked="checked"><%=r.getString(teasession._nLanguage, "TEXT")%>
        <input  id="radio" type="radio" name=TextOrHtml value=1 <%if((n.getOptions() & 0x40) != 0)out.print(" CHECKED ");%> >HTML
        <input type="button" name="Pictureview" id="Pictureview" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Pictureview")%>" onClick="window.open('/servlet/InsertPicture?node=<%=teasession._nNode%>', '_blank');">
        <input type="CHECKBOX" name="nonuse" id="nonuse" value="checkbox" onClick="fnonuse(this)"><label for="nonuse"><%=r.getString(teasession._nLanguage, "NonuseEditor")%></label>
      </td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
      <td nowrap>
        <textarea style="display:none" name="content" rows="12" cols="97" class="edit_input"><%=text%></textarea>
        <textarea style="display:none" name="wordcontent" rows="8" cols="70" class="edit_input"><%=text%></textarea>
        <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=wordcontent&Toolbar=<%=teasession._strCommunity%>" width="700" height="200" frameborder="no" scrolling="no"></iframe>
      </td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "Scholar.time")%>:</TD>
      <td nowrap><%=new tea.htmlx.TimeSelection("Issue", time)%></td>
    </tr>
    <!--tr>
      <TD></td>
      <TD><input type="checkbox" name="mostly" <%if(mostl)out.print(" checked ");%> /><%=r.getString(teasession._nLanguage, "Mostly")%></td>
    </tr-->
</table>

<center>
  <input type="hidden" name="act" value="">
  <input type=SUBMIT name="GoFinish" ID="edit_GoFinish"  onClick="act.value='finish';" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Finish")%>">
  <input type=SUBMIT name="GoFinish" ID="editReport_GoNext"  onClick="act.value='next';" class="edit_button" value="<%=r.getString(teasession._nLanguage, "CBNext")%>">
  <input type=SUBMIT name="GoBackSuper" id="GoBackSuper" onClick="act.value='back';" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Super")%>">
</center>

</FORM>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
