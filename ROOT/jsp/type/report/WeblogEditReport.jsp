<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>


<%
r.add("/tea/ui/node/type/Report/EditReport");
String community=node.getCommunity();
tea.entity.node.AccessMember obj_am = tea.entity.node.AccessMember.find(node._nNode, teasession._rv._strV);
  if (!node.isCreator(teasession._rv)&&!obj_am.isProvider(39)&&((node.getOptions1()& 1) == 0))
  {
    response.sendError(403);
    return;
  }




%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function fnonuse(obj)
{
  var ewebeditor=document.all('eWebEditor1');
  if(obj.checked)
  {
    ewebeditor.src="";
    foNew.Text.style.display="";
    ewebeditor.style.display="none";
    setCookie('jsp.type.report.EditReport.nonuse',obj.checked);
  }else
  {
    removeCookie('jsp.type.report.EditReport.nonuse');
    ewebeditor.style.display="";
    ewebeditor.src="/jsp/include/eWebEditor/eWebEditor.jsp?id=Text&style=standard";
    foNew.Text.style.display="none";
  }
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Weblog")%><%=r.getString(teasession._nLanguage, "Edit")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%>  </div>
  <FORM name=foNew METHOD=POST action="/servlet/EditReport"  enctype=multipart/form-data onsubmit="return submitText(this.Name, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')" >
          <%
          String parameter=teasession.getParameter("nexturl");
    boolean   parambool=(parameter!=null&&!parameter.equals("null"));
    if(parambool)
    out.print("<input type='hidden' name=nexturl value="+parameter+">");
    String text="",subject="",Keywords="";


    int m_r=0;
    int c_r=0;
    java.util.Date date_r=null;
    long l2=0;
    int j=0;
    String picture=null,locus=null,logograph=null;
            if(request.getParameter("NewNode")!=null)
            {
              out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
            }else
            {
                text=node.getText(teasession._nLanguage);
                subject=node.getSubject(teasession._nLanguage);
                Keywords=node.getKeywords(teasession._nLanguage);

                tea.entity.node.Report  report_r=tea.entity.node.Report.find(teasession._nNode,teasession._nLanguage);
                m_r=report_r.getMedia();
                c_r=report_r.getClasses();
                date_r=report_r.getIssueTime();
                picture=report_r.getPicture();
                locus=report_r.getLocus();
                logograph=tea.html.HtmlElement.htmlToText(report_r.getLogograph());
                if(picture!=null)
                {
                  l2=new java.io.File(application.getRealPath(picture)).length();
                }
              }
            %>
    <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">    <tr><td nowrap>*<%=r.getString(teasession._nLanguage, "Name")%>:</TD>
        <td nowrap><input name="Name"  size=70 maxlength=255 class="edit_input" value="<%=HtmlElement.htmlToText(getNull(subject))%>"/></td></tr>
      <tr>
        <td nowrap><%=r.getString(teasession._nLanguage, "media")%>:</TD>
        <td nowrap>
          <%tea.html.DropDown dropdown = new tea.html.DropDown("media",m_r);
          dropdown.addOption(0,"-------------");
java.util.Enumeration _media_enumer=          tea.entity.node.Media.findByLanguage(teasession._nLanguage);
while(_media_enumer.hasMoreElements())
{
tea.entity.node.Media media_obj=  tea.entity.node.Media.find(((Integer) _media_enumer.nextElement()).intValue());
dropdown.addOption(media_obj.getMediaID(),media_obj.getName());
}

           out.println(dropdown);
%>
          <input name="fff" type=BUTTON class="edit_button" onClick="window.open('/servlet/NewMedia?node=<%=teasession._nNode%>&nextUrl=<%=request.getRequestURI()%>&type=<%=j%>', '_self');" VALUE="<%=r.getString(teasession._nLanguage, "New")%>">
          <input name="fff" type=BUTTON class="edit_button" onClick="window.open('/servlet/ManageMedia?node=<%=teasession._nNode%>&type=<%=j%>', '_self');" VALUE="<%=r.getString(teasession._nLanguage, "All")%>">
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


%>
          <%=dropdown1%>
          <input name="fff" type=BUTTON class="edit_button" onClick="window.open('/servlet/NewClass?node=<%=teasession._nNode%>&type=<%=j%>', '_self');" VALUE="<%=r.getString(teasession._nLanguage, "New")%>">
          <input name="fff" type=BUTTON class="edit_button" onClick="window.open('/servlet/ManageClasses?node=<%=teasession._nNode%>&type=<%=j%>', '_self');" VALUE="<%=r.getString(teasession._nLanguage, "All")%>">
        <br/></td>
      </tr>
      <tr>
        <td nowrap><%=r.getString(teasession._nLanguage, "Picture")%>:</TD>
        <td nowrap>   <input TYPE=FILE NAME="Picture" ondblclick="<%if(l2>0)out.print("open('"+picture+"');");%>" class="edit_input">
          <%if(l2 != 0) out.print(l2 + r.getString(teasession._nLanguage, "Bytes"));%>
          <input  id="CHECKBOX" type="CHECKBOX" NAME=ClearPicture onclick="foNew.Picture.disabled=this.checked">
        <%=r.getString(teasession._nLanguage, "Clear")%>   </td>
      </tr>
      <tr><td nowrap><%=r.getString(teasession._nLanguage, "Locus")%>:</TD>
          <td nowrap><input name="Locus" size="50"  class="edit_input" value="<%=getNull(locus)%>"/></td></tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Keywords")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name="Keywords" value="<%=Keywords%>" size="70" maxlength="255">
        </td>
      </tr>



            <tr>
        <td nowrap><%=r.getString(teasession._nLanguage, "Logograph")%>:</TD>
        <td nowrap> <textarea name="Logograph" rows="8" cols="70" class="edit_input"><%if(logograph!=null)out.print(logograph);%></textarea>    </td>
      </tr>
      <tr>
        <td nowrap> </TD>
        <td nowrap><input  id="radio" type="radio" name=TextOrHtml value=0 checked="checked">
          <%=r.getString(teasession._nLanguage, "TEXT")%>
          <input  id="radio" type="radio" name=TextOrHtml value=1 <%=getCheck((node.getOptions() & 0x40) != 0)%> >HTML
<%--<input  id="radio" type="radio" name=TextOrHtml value=2 <%=getCheck((j1 & 0x20) != 0)%> >JSP--%>
  <input type="button" name="Pictureview" id="Pictureview" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Pictureview")%>" onClick="window.open('/servlet/InsertPicture?node=<%=teasession._nNode%>', '_blank');">
  <input  id="CHECKBOX" type="CHECKBOX" name="nonuse"  id="nonuse" value="checkbox" onclick="fnonuse(this)"><label for="nonuse"><%=r.getString(teasession._nLanguage, "NonuseEditor")%></label>


        </td>
      </tr>
       <tr>
        <td nowrap><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
        <td nowrap><textarea style="display:none"  name="Text" rows="8" cols="70" class="edit_input"><%=HtmlElement.htmlToText(text)%></textarea>
<IFRAME ID="eWebEditor1" SRC="/jsp/include/eWebEditor/eWebEditor.jsp?id=Text&style=standard" frameborder="0" scrolling="no" width="650" height="350"></IFRAME>
<script>foNew.nonuse.checked=getCookie('jsp.type.report.EditReport.nonuse','');
fnonuse(foNew.nonuse);
</script>
</td>
      </tr>
      <tr>
        <td nowrap><%=r.getString(teasession._nLanguage, "HappenTime")%>:</TD>
        <td nowrap><%=new TimeSelection("Issue", date_r)%></td>
      </tr>
    </table>

    <center>
<input type="hidden" name="act" value="">
          <input type=SUBMIT name="GoFinish" ID="edit_GoFinish"  onClick="act.value='finish';" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Finish")%>">
<input type=SUBMIT name="GoBackSuper" id="edit_GoNext" onClick="act.value='back';" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Super")%>">
    </center>
  </FORM>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
  <script>foNew.Name.focus();</script>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

