<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.util.*" %>
<%@ page import ="java.io.*" %>
<%@ page import="java.net.*" %>

<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


String community=teasession._strCommunity;

String act = teasession.getParameter("act");

String nexturl = request.getParameter("nexturl");
int fileendorse = Integer.parseInt(request.getParameter("fileendorse"));
    FileEndorse feobj = FileEndorse.find(fileendorse);




%>

<html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <script src="/tea/tea.js" type="text/javascript"></script>
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/image/ig/ig_iframe.js"></SCRIPT>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">

  </head>
  <body>
  <script>


  function sub()
  {
    if(form1.content.value=="")
    {
      alert("请选择发布人员");
      return false;
    }
  }

  </script>
  <h1>填写原因</h1>
  <div id="head6"><img height="6" src="about:blank" alt=""></div>
    <br>

    <form enctype="multipart/form-data" name="form1" METHOD="post" action="/servlet/EditFileEndorse" onSubmit="return sub(this);">
    <input  type="hidden" name="nexturl" value="<%=nexturl%>"/>
    <input type="hidden" name="act" value="<%=act%>"/>
    <input type="hidden" value="<%=fileendorse%>" name="fileendorse"/>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
          <td>原因：</td><td><textarea name="content" cols=60 rows=10 ></textarea> </td>
        </tr>
      </table>
      <input type="Submit" name="" value="提交"><input type="reset" name="" value="重填" >
 <input type="button" value="返回" onClick="history.back();">
    </FORM>

    <br>
    <div id="head6"><img height="6" src="about:blank"></div>
  </body>
</html>




