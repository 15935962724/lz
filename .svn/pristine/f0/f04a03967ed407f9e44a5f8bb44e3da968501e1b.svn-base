<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
//tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
//tea.resource.Resource r=new tea.resource.Resource();
String community=teasession.getParameter("community");

tea.entity.site.Pdf obj=tea.entity.site.Pdf.find(community);


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBEditListing")%></h1>
<div id="head6"><img height="6" alt=""></div>

<FORM action="/servlet/EditPdf" METHOD=POST enctype="multipart/form-data" name=foform111 >
<input type="hidden" name="community" value="<%=community%>"/>
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
 <table width="451" border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Header")%>:</td>
      <td>
        <input   type="file" onDblClick="window.open('<%=obj.getHeader()%>');" name="header" ><%=new java.io.File(application.getRealPath(obj.getHeader())).length()%>³ß´ç:595pxX40px</td>
    </tr>
	 <tr>
      <td><%=r.getString(teasession._nLanguage, "Footer")%>:</td>
      <td>
        <input  type="file" onDblClick="window.open('<%=obj.getFooter()%>');" name="footer" ><%=new java.io.File(application.getRealPath(obj.getFooter())).length()%>
      ³ß´ç:595pxX40px</td>
    </tr>
  </table>
    <input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>"/>



              <div id="head6"><img height="6" alt=""></div>
</FORM>

<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>


