<%@page contentType="text/html;charset=utf-8" %>
<%@include file="/jsp/include/Header.jsp"%>


<%

String community=node.getCommunity();


if((node.getOptions1()& 1) == 0)
{
  if(teasession._rv==null)
  {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
  }
  if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(82))
  {
    response.sendError(403);
    return;
  }
}
r.add("/tea/resource/Weblog");


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
    removeCookie('jsp.type.report.EditReport.nonuse');
    ewebeditor.style.display="";
    foNew.Text.style.display="none";
  }
}
</script>
</head>
<body onLoad="foNew.Subject.focus();">
<h1><%=r.getString(teasession._nLanguage, "Weblog")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%>  </div>
  <FORM name=foNew  enctype=multipart/form-data  METHOD=POST action="/servlet/EditWeblog"   onsubmit="return submitText(this.Subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&submitText(this.Text, '<%=r.getString(teasession._nLanguage, "InvalidText")%>')" >
          <%
          String parameter=teasession.getParameter("nexturl");
    boolean   parambool=(parameter!=null&&!parameter.equals("null"));
    if(parambool)
    out.print("<input type='hidden' name=nexturl value="+parameter+">");
    String text,subject,Keywords;

    java.util.Date date_r=null;

            if(request.getParameter("NewNode")!=null)
            {
              out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
              text="";subject="";Keywords="";
            }else
            {
              text=node.getText(teasession._nLanguage);
              subject=HtmlElement.htmlToText(node.getSubject(teasession._nLanguage));
              Keywords=HtmlElement.htmlToText(node.getKeywords(teasession._nLanguage));
              date_r=node.getTime();
            }
            %>
    <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr><td nowrap>*<%=r.getString(teasession._nLanguage, "Subject")%>:</TD>
        <td nowrap><input name="Subject"  size=70 maxlength=255 class="edit_input" value="<%=(getNull(subject))%>"/>
        <img onClick="foNew.Subject.value='日记 ['+new Date()+']';foNew.Subject.focus();" style="cursor: hand;" alt="" src="/tea/image/public/Calendar2.gif"/>
        </td></tr>
        <tr>
        <td nowrap><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
        <td nowrap><textarea style=""  name="Text" rows="20" cols="70" class="edit_input"><%=(text)%></textarea>
 </td>
      </tr>
      <tr>
        <td nowrap><%=r.getString(teasession._nLanguage, "Time")%>:</TD>
        <td nowrap><%=new TimeSelection("Issue", date_r)%></td>
      </tr>
    </table>

    <center>
<input type=SUBMIT name="GoPicture" id="edit_GoNext" onClick="" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Picture")%>">
<input type=SUBMIT name="GoFinish" ID="edit_GoFinish"  onClick="" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Finish")%>">
    </center>

  </FORM>
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>

