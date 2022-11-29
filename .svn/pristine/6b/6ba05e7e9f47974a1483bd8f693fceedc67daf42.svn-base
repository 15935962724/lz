<%@page contentType="text/html;charset=UTF-8"  %>
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
  if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(74))
  {
    response.sendError(403);
    return;
  }
}
r.add("/tea/resource/Contribute");
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "EditContribute")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

    <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%>  </div>
 <FORM name=fomr1 METHOD=POST action="/servlet/EditContribute"  enctype=multipart/form-data onSubmit="return( submitText(this.Subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&submitText(this.project, '<%=r.getString(teasession._nLanguage, "Project")%>')&&submitFloat(this.moneycount, '<%=r.getString(teasession._nLanguage, "MoneyCount")%>')&&submitText(this.linkman, '<%=r.getString(teasession._nLanguage, "Linkman")%>')&&submitEmail(this.email, 'E_Mail1') )" >
          <%
          String parameter=teasession.getParameter("nexturl");
          boolean   parambool=(parameter!=null&&!parameter.equals("null"));
          if(parambool)
          out.print("<input type='hidden' name=nexturl value="+parameter+">");
          String text,subject,project,photo,linkman,linkman2,phone,phone2,address,address2,postalcode,postalcode2,email,email2;
          java.util.Date time=null;
          int belong=0;
          boolean classes=false;
          java.math.BigDecimal moneycount;
          if(request.getParameter("NewNode")!=null)
          {
            text=subject=project=photo=linkman=linkman2=phone=phone2=address=address2=postalcode=postalcode2=email=email2="";
            moneycount=new java.math.BigDecimal(0D);
            out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
          }else
          {
            text=tea.html.HtmlElement.htmlToText(node.getText(teasession._nLanguage));
            subject=tea.html.HtmlElement.htmlToText(node.getSubject(teasession._nLanguage));
            tea.entity.node.Contribute obj=tea.entity.node.Contribute.find(teasession._nNode,teasession._nLanguage);
            project=obj.getProject();
            moneycount=obj.getMoneycount();
            time=obj.getTime();
            photo=obj.getPhoto();
            linkman=obj.getLinkman();
            linkman2=obj.getLinkman2();
            phone=obj.getPhone();
            phone2=obj.getPhone2();
            address=obj.getAddress();
            address2=obj.getAddress2();
            postalcode=obj.getPostalcode();
            postalcode2=obj.getPostalcode2();
            email=obj.getEmail();
            email2=obj.getEmail2();
            classes=obj.isClasses();
            belong=obj.getBelong();
          }
            %>
    <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage,"Subject")%></td>
      <td colspan="3"><input name="Subject" type=text value="<%=subject%>"  size="53" maxlength="50" >
        <span class="text2">*</span>

      </td>
    </tr>
    <tr>
      <td ><%=r.getString(teasession._nLanguage,"Project")%></td>
      <td colspan="3"><input name="project" type=text  value="<%=project%>" size="53" maxlength="50" >
        <span class="text2">*</span></td>
    </tr>
    <tr>
      <td ><%=r.getString(teasession._nLanguage,"Classes")%></td>
      <td ><input name="classes"  id="radio" type="radio" value="false" checked  >
        <%=r.getString(teasession._nLanguage,"Individual")%>
        <input  id="radio" type="radio" name="classes" <%if(classes)out.print(" checked ");%> value="true"  >
        <%=r.getString(teasession._nLanguage,"Unit")%></td>
        <%--
      <td ><%=r.getString(teasession._nLanguage,"Belong")%></td>
      <td ><select name="belong">
          <option value="0" selected>---------</option>
          <option value="1" <%if(belong==1)out.print(" selected ");%>>100万以上</option>
          <option value="2" <%if(belong==2)out.print(" selected ");%>>50—100万（50万）</option>
          <option value="3" <%if(belong==3)out.print(" selected ");%>>10—50万（含10万）</option>
          <option value="4" <%if(belong==4)out.print(" selected ");%>>10万以下</option>
        </select>
        <span class="text2">*</span> </td> --%>
    </tr>
    <tr>
      <td ><%=r.getString(teasession._nLanguage,"MoneyCount")%></td>
      <td colspan="3"><input name="moneycount" value="<%=moneycount%>" type=text  size="53" maxlength="16" >
        <%=r.getString(teasession._nLanguage,"RMB")%> <span class="text2">*</span></td>
    </tr>
    <tr>
      <td ><%=r.getString(teasession._nLanguage,"Time")%>：</td>
      <td  colspan="3" ><%=new tea.htmlx.TimeSelection("time",time).toString()%> <span class="text2">*</span></td>
    </tr>
   <%-- <tr>
      <td ><%=r.getString(teasession._nLanguage,"Photo")%>
      <td  colspan="3"><input name="photo" type="file" id="filename1"  size="53" maxlength="100">
        <input name="photopath" type="hidden" value="<%=photo%>" id="filename1"  size="53" maxlength="100">
      </td>
    </tr> --%>
    <tr>
      <td ><%=r.getString(teasession._nLanguage,"Linkman")%></td>
      <td ><input name="linkman" type="text" value="<%=linkman%>" size="18" maxlength="20">
        <span class="text2">*</span></td>
      <%--<td ><%=r.getString(teasession._nLanguage,"Linkman")%>2</td>
      <td ><input name="linkman2" type="text"  value="<%=linkman2%>" size="20" maxlength="20">
      </td> --%>
    </tr>
    <tr>
      <td ><%=r.getString(teasession._nLanguage,"Phone")%></td>
      <td ><input name="phone" type="text"  value="<%=phone%>" size="18" maxlength="11">
      </td>
     <%-- <td ><%=r.getString(teasession._nLanguage,"Phone")%>2</td>
      <td ><input name="phone2" type="text" value="<%=phone2%>" size="20" maxlength="11">
      </td> --%>
    </tr>
    <tr>
      <td ><%=r.getString(teasession._nLanguage,"Address")%></td>
      <td  colspan="3"><input name="address" type="text"  value="<%=address%>" size="53" maxlength="40">
      </td>
    </tr>
   <%--  <tr>
      <td ><%=r.getString(teasession._nLanguage,"Address")%>2</td>
      <td  colspan="3"><input name="address2" type="text" value="<%=address2%>"  size="53" maxlength="40">
      </td>
    </tr>--%>
    <tr>
      <td ><%=r.getString(teasession._nLanguage,"Postalcode")%></td>
      <td ><input name="postalcode" type="text"  value="<%=postalcode%>" size="18" maxlength="6">
      </td>
     <%-- <td ><%=r.getString(teasession._nLanguage,"Postalcode")%>2</td>
      <td ><input name="postalcode2" type="text"  value="<%=postalcode2%>" size="20" maxlength="6">
      </td> --%>
    </tr>
    <tr>
      <td >E_Mail</td>
      <td  colspan="3"><input name="email" type="text"  value="<%=email%>" size="53" maxlength="40">
        <span class="text2">*</span></td>
    </tr>
    <%-- <tr>
      <td >E_Mail2</td>
      <td  colspan="3"><input name="email2" type="text" value="<%=email2%>" size="53" maxlength="50">
      </td>
    </tr>--%>
    <tr>
      <td ><%=r.getString(teasession._nLanguage,"Text")%></td>
      <td  colspan="3"><textarea name="Text" cols="53" rows="6" ><%=text%></textarea>
      </td>
    </tr>
    <tr>
      <td colspan="4"><div align="center">
          <input class="text" name=regin type=submit value="<%=r.getString(teasession._nLanguage,"Submit")%>">
&nbsp;&nbsp;&nbsp;&nbsp;
          <input class="text"  name=B2 type=reset value="<%=r.getString(teasession._nLanguage,"Reset")%>">
&nbsp;&nbsp;&nbsp;&nbsp;</div></td>
    </tr>
  </table>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

