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
  if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(76))
  {
    response.sendError(403);
    return;
  }
}
r.add("/tea/resource/GreenManufacture");
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "GreenManufacture")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%> </div>
<form action="/servlet/EditGreenManufacture" method="post" enctype="multipart/form-data" name="theform" OnSubmit="return( submitText(this.Subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&submitText(this.company, '<%=r.getString(teasession._nLanguage, "Company")%>') &&submitText(this.content, '<%=r.getString(teasession._nLanguage, "Content")%>') &&submitText(this.linkman, '<%=r.getString(teasession._nLanguage, "Linkman")%>')&&submitEmail(this.email,'<%=r.getString(teasession._nLanguage, "Email")%>') &&submitText(this.Text, '<%=r.getString(teasession._nLanguage, "Text")%>') )" >
  <%
          String parameter=teasession.getParameter("nexturl");
          boolean   parambool=(parameter!=null&&!parameter.equals("null"));
          if(parambool)
          out.print("<input type='hidden' name=nexturl value="+parameter+">");
          String text,subject,faren      ,companyadd ,postalcode   ,quality    ,ep         ,medal      ,attestation,company    ,content    ,linkman    ,phone      ,fax        ,email      ,remark ,brand;
          if(request.getParameter("NewNode")!=null)
          {
            text=subject=faren      =companyadd =postalcode   =quality    =ep         =medal      =attestation=company    =content    =linkman    =phone     =fax        =email     =remark =brand="";
            out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
          }else
          {
            text=tea.html.HtmlElement.htmlToText(node.getText(teasession._nLanguage));
            subject=tea.html.HtmlElement.htmlToText(node.getSubject(teasession._nLanguage));
            tea.entity.node.GreenManufacture obj=tea.entity.node.GreenManufacture.find(teasession._nNode,teasession._nLanguage);
            faren  =obj.getFaren();
        companyadd =obj.getCompanyadd();
        postalcode=obj.getPostalcode();
     quality=obj.getQuality();
     ep=obj.getEp();
medal=obj.getMedal();
attestation=obj.getAttestation();
company=obj.getCompany();
content=obj.getContent();
linkman=obj.getLinkman();
phone=obj.getPhone();
fax=obj.getFax();
email=obj.getEmail();
remark =tea.html.HtmlElement.htmlToText(obj.getRemark());
brand=obj.getBrand();
          }
            %>
  <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><div align="right"><%=r.getString(teasession._nLanguage,"Faren")%>：</div></td>
      <td><input name="faren" type="text" class=text value="<%=faren%>"  size="20" maxlength="20"></td>
      <td><div align="right"><%=r.getString(teasession._nLanguage,"CompanyAdd")%>：</div></td>
      <td colspan="2"><input name="companyadd" type="text" value="<%=companyadd%>" class=text  size="20" maxlength="20"></td>
    </tr>
    <tr>
      <td><div align="right"><%=r.getString(teasession._nLanguage,"Postalcode")%>：</div></td>
      <td><input name="postalcode" type="text" value="<%=postalcode%>" class=text  size="20" maxlength="20"></td>
      <td><div align="right"><%=r.getString(teasession._nLanguage,"Brand")%>：</div></td>
      <td colspan="2"><input name="brand"  type="file" class=text size="20">
        <input type="hidden" name="brandpath" value="<%=brand%>">
      </td>
    </tr>
    <tr>
      <td><div align="right"><%=r.getString(teasession._nLanguage,"Quality")%>：</div></td>
      <td><input name="quality" value="<%=quality%>" type="text" class=text  size="20" maxlength="100"></td>
      <td><div align="right"><%=r.getString(teasession._nLanguage,"EP")%>：</div></td>
      <td colspan="2"><input name="ep" type="text" value="<%=ep%>" class=text size="20" maxlength="100"></td>
    </tr>
    <tr>
      <td><div align="right"><%=r.getString(teasession._nLanguage,"Medal")%>：</div></td>
      <td><input name="medal" type="text" value="<%=medal%>" class=text  size="20" maxlength="60"></td>
      <td><div align="right"><%=r.getString(teasession._nLanguage,"Attestation")%>：</div></td>
      <td colspan="2"><input name="attestation" value="<%=attestation%>" type="text" class=text  size="20" maxlength="60"></td>
    </tr>
    <tr>
      <td><div align="right"><%=r.getString(teasession._nLanguage,"Subject")%>：</div></td>
      <td><input name="Subject" type="text" value="<%=subject%>" class=text  size="20" maxlength="20">
        <span class="text2"> **</span></td>
      <td><div align="right"><%=r.getString(teasession._nLanguage,"Company")%>： </div></td>
      <td colspan="2"><span class="text2">
        <input name="company" type="text" value="<%=company%>" class=text  size="20" maxlength="20">
        **</span></td>
    </tr>
    <tr>
      <td><div align="right"><%=r.getString(teasession._nLanguage,"Content")%>：</div></td>
      <td><span class="text2">
        <input name="content" type="text" value="<%=content%>" class=text  size="20" maxlength="20">
        ** </span></td>
      <td><div align="right"><%=r.getString(teasession._nLanguage,"Linkman")%>：</div></td>
      <td colspan="2"><input name="linkman" value="<%=linkman%>" type="text" class=text  size="20" maxlength="16" >
        <span class="text2"> **</span> </td>
    </tr>
    <tr>
      <td><div align="right"><%=r.getString(teasession._nLanguage,"Phone")%>：</div></td>
      <td><span class="text2">
        <input name="phone" type="text" value="<%=phone%>" class=text  size="20" maxlength="16" >
        </span> </td>
      <td><div align="right"><%=r.getString(teasession._nLanguage,"Fax")%>：</div></td>
      <td colspan="2"><input name="fax"  type="text" class=text  value="<%=fax%>" size="20" maxlength="13">
      </td>
    </tr>
    <tr>
      <td>　　　　　　
        <div align="right">E-Mail：</div></td>
      <td colspan="4"><span class="text2">
        <input name="email" type="text" class=text value="<%=email%>"  size="20" maxlength="100" >
        **</span> </td>
    </tr>
    <tr>
      <td><div align="right"><%=r.getString(teasession._nLanguage,"Text")%>：</div></td>
      <td colspan="4"><textarea name="Text" cols="40" rows="3" ><%=text%></textarea>
        <span class="text2">**</span> </td>
    </tr>
    <tr>
      <td><div align="right"><%=r.getString(teasession._nLanguage,"Remark")%>：</div></td>
      <td colspan="4"><textarea name="remark" cols="40" rows="3" ><%=remark%></textarea></td>
    </tr>
  </table>
  <p align=center>
    <input class="text" name=regin type=submit value="<%=r.getString(teasession._nLanguage,"Submit")%>">
&nbsp;&nbsp;&nbsp;&nbsp;
    <input class="text"  name=B2 type=reset value="<%=r.getString(teasession._nLanguage,"Reset")%>">
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
  <script>theform.Subject.focus();</script>

</body>
</html>

