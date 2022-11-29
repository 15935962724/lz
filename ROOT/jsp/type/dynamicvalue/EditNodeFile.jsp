<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
String community=node.getCommunity();
if(request.getMethod().equals("POST"))
{
  byte by[]=  teasession.getBytesParameter("file");
  if(by==null)
  {
    response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("文件无效.","UTF-8"));
  }else
  {
    node.setFile(by,teasession._nLanguage);
    response.sendRedirect("/jsp/info/Succeed.jsp?info="+java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"UpdateSuccessful")+"<SCRIPT>setInterval(\"window.location.replace('/jsp/type/dynamicvalue/DynamicValues.jsp?node="+teasession._nNode+"&community="+community+"');\",3000);</SCRIPT>","UTF-8"));
  }
  return;
}


%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body onload="form1.file.focus();">
<h1><%//=r.getString(teasession._nLanguage, "上传文件")%>上传文件</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name=form1 action="" method="post" enctype=multipart/form-data onsubmit="">
  <input type="hidden" name="Node" value="<%=teasession._nNode%>">
  <%
  if(request.getParameter("id")!=null)
  {
    out.print("<input type=hidden name=id value="+request.getParameter("id")+">");
  }
  %>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage,"Subject")%>:</td>
      <td nowrap class=huititable ><input name="file" class="edit_input"  type="file" value="" size="25" maxlength="100">
      <%
if(node.getFileFlag())
{
  out.print(node.getFile(teasession._nLanguage).length+"字节");
//  out.print("<A href=/jsp/type/dynamicvalue/CebbankPdfDownload.jsp?node="+teasession._nNode+" >下载</A>");
}
%>
      </td>
    </tr>
  </table>

  <div align="center">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </div>
</form>
<br/>
<A href="/tea/download/Adobe_Acrobat_6.0_Standard.zip" title="pdf制作工具" >下载Acrobat 6.0</A>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

