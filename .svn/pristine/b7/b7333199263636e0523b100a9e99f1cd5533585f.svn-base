<%@page contentType="text/html;charset=utf-8"  %>
<%@include file="/jsp/include/Header.jsp"%>

<%


  if(teasession._rv==null)
{
  if((node.getOptions1()& 1) == 0)
  {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
  }
}else
{
  if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(80))
  {
    response.sendError(403);
    return;
  }
}

  r.add("/tea/resource/Literature");
  %>
  <html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>
<body onLoad="fform111.subject.focus();">
<h1><%=r.getString(teasession._nLanguage, "Edit")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%>  </div>
  <form name="fform111" action="/servlet/EditLiterature?node=<%=teasession._nNode%>" method="post"  ENCtype="multipart/form-data"   onsubmit="return(submitText(this.subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&submitInteger(this.chapter, '<%=r.getString(teasession._nLanguage, "Chapter")%>')&&submitInteger(this.section, '<%=r.getString(teasession._nLanguage, "Section")%>')&&submitInteger(this.pos, '<%=r.getString(teasession._nLanguage, "Pos")%>'));">
<%
          String parameter=teasession.getParameter("nexturl");
    boolean   parambool=(parameter!=null&&!parameter.equals("null"));
    if(parambool)
    out.print("<input type='hidden' name=nexturl value="+parameter+">");

    String text,subject;
    long len=0;
    int pos=0;
    int section=0;
    int chapter=0;
    String subhead,cname  ,sname  ,author     ,flash ;
            if(request.getParameter("NewNode")!=null)
            {
              out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
              text=subject=subhead=cname  =sname  =author     =flash="" ;
            }else
              {
                text=tea.html.HtmlElement.htmlToText(node.getText(teasession._nLanguage));
                subject=node.getSubject(teasession._nLanguage);

                tea.entity.node.Literature  obj=tea.entity.node.Literature.find(teasession._nNode,teasession._nLanguage);
                subhead=obj.getSubhead();
                chapter=obj.getChapter();
                cname=obj.getCname();
                sname=obj.getSname();
                author=obj.getAuthor();
                flash=(obj.getFlash());
                if(flash!=null)
                {
                  len=new java.io.File(application.getRealPath(flash)).length();
                }
              }
            %>
<table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
<tr>
<TD><%=r.getString(teasession._nLanguage, "Subject")%>:</TD>
<td><input type="text" size="50" name="subject" value="<%=subject%>"></td>
</tr>
<tr>
<TD><%=r.getString(teasession._nLanguage, "Subhead")%>:</TD>
<td><input type="text" size="50" name="subhead" value="<%=subhead%>"></td>
</tr>
<tr><TD><%=r.getString(teasession._nLanguage, "Chapter")%>:</TD>
<td><input name="chapter" type="text" size="5" value="<%=chapter%>"></td>
<TD><%=r.getString(teasession._nLanguage, "Cname")%>:</TD>
<td><input name="cname" type="text" size="20" value="<%=cname%>"></td>
</tr>
<tr><TD><%=r.getString(teasession._nLanguage, "Section")%>:</TD>
<td><input name="section" type="text" size="5" value="<%=section%>"></td>
<TD><%=r.getString(teasession._nLanguage, "Sname")%>:</TD>
<td><input name="sname" type="text" size="20" value="<%=sname%>"></td>
</tr>
<tr><TD><%=r.getString(teasession._nLanguage, "Author")%>:</TD>
<td><input name="author" type="text"  value="<%=author%>"></td>

</tr>
<tr><TD><%=r.getString(teasession._nLanguage, "Pos")%>:</TD>
<td><input name="pos" type="text" size="5" value="<%=pos%>"></td>

</tr>
<tr><TD><%=r.getString(teasession._nLanguage, "Flash")%>:</TD>
<td><input name="flash" type="file" onDblClick="window.open('<%=flash%>');" ><%if(len != 0) out.print(len + r.getString(teasession._nLanguage, "Bytes"));%>
          <input  id="CHECKBOX" type="CHECKBOX" NAME=clear onClick="fform111.flash.disabled=this.checked"><%=r.getString(teasession._nLanguage, "Clear")%></td>
</tr>
<tr><TD><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
<td>
 <textarea name="text" rows="20" cols="80" class="edit_input"><%=text%></textarea>
</td>
</tr>
</table>

    <center>
       <input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Finish")%>">
<input type=SUBMIT name="GoBack" id="edit_GoNext" onClick="act.value='back';" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Super")%>">
    </center>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

