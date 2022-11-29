<%@page contentType="text/html;charset=UTF-8" %>
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
  if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(77))
  {
    response.sendError(403);
    return;
  }
}
r.add("/tea/resource/EarthKavass");
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Edit")%><%=r.getString(teasession._nLanguage, "EarthKavass")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

    <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%>  </div>
    <form action="/servlet/EditEarthKavass" method="post" name="form1" OnSubmit="return( submitText(this.Subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&submitText(this.name, '<%=r.getString(teasession._nLanguage, "Name")%>')&&submitEmail(this.email,'E-Mail')&&submitText(this.Text, '<%=r.getString(teasession._nLanguage, "Text")%>') )" >
<%
          String parameter=teasession.getParameter("nexturl");
          boolean   parambool=(parameter!=null&&!parameter.equals("null"));
          if(parambool)
          out.print("<input type='hidden' name=nexturl value="+parameter+">");
          String text,subject,        name    ,address ,zip     ,phone   ,fax     ,email  ;
          if(request.getParameter("NewNode")!=null)
          {
            text=subject=        name    =address =zip     =phone   =fax     =email="";
            out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
          }else
          {
            text=tea.html.HtmlElement.htmlToText(node.getText(teasession._nLanguage));
            subject=tea.html.HtmlElement.htmlToText(node.getSubject(teasession._nLanguage));
            tea.entity.node.EarthKavass obj=tea.entity.node.EarthKavass.find(teasession._nNode,teasession._nLanguage);
           name=obj.getName();
address=obj.getAddress();
zip=obj.getZip();
phone=obj.getPhone();
fax=obj.getFax();
email=obj.getEmail();
          }
            %>
    <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
                                  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                                    <tr>
                                      <td ><%=r.getString(teasession._nLanguage,"Subject")%>：</td>
                                      <td ><input name="Subject" value="<%=subject%>" type="Text" class=text  size="48" maxlength="25">
                                        <font class=text2>**</font></td>
                                    </tr>
                                    <tr>
                                      <td ><%=r.getString(teasession._nLanguage,"Name")%>：</td>
                                      <td ><input name="name" value="<%=name%>" type="text" class=text  size="48" maxlength="12">
                                        <span class="text2">** </span></td>
                                    </tr>
                                    <tr>
                                      <td ><%=r.getString(teasession._nLanguage,"Address")%>：</td>
                                      <td ><input name="address" value="<%=address%>" type="text" class=text  size="48" maxlength="100"></td>
                                    </tr>
                                    <tr>
                                      <td ><%=r.getString(teasession._nLanguage,"Zip")%>：</td>
                                      <td ><input name="zip" value="<%=zip%>" type="text" class=text id="zip2" size="48" maxlength="10">
                                      </td>
                                    </tr>
                                    <tr>
                                      <td ><%=r.getString(teasession._nLanguage,"Phone")%>：</td>
                                      <td > <input name="phone" value="<%=phone%>" type="text" class=text id="phone" size="48" maxlength="10">
                                      </td>
                                    </tr>
                                    <tr>
                                      <td ><%=r.getString(teasession._nLanguage,"Fax")%>：</td>
                                      <td > <input name="fax" value="<%=fax%>" type="text" class=text id="fax2" size="48" maxlength="10"></td>
                                    </tr>
                                    <tr>
                                      <td >Email：</td>
                                      <td > <input name="email" value="<%=email%>" type="text" class=text id="mailbox2" size="48" maxlength="50">
                                        <font class=text2>**</font> </td>
                                    </tr>
                                    <tr>
                                      <td  ><%=r.getString(teasession._nLanguage,"Text")%>：</td>
                                      <td ><textarea name="Text" cols="40" rows="4" id="Reark"><%=text%></textarea>
                                        <span class="text2"> ** </span></td>
                                    </tr>
                                  </table>

                                <p align=center>

                                    <input class="text" name=regin type=submit value="<%=r.getString(teasession._nLanguage,"Submit")%>">
                                    <input class="text" button name=B2 type=reset value="<%=r.getString(teasession._nLanguage,"Reset")%>">
                                   </p>
                        </form> <div id="head6"><img height="6" src="about:blank"></div><div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
  <script>form1.Subject.focus();</script>

</body>
</html>

