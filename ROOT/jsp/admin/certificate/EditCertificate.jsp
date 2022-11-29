
<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.util.*" %>
<%@ page import ="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="tea.entity.member.*" %>

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

String nexturl = request.getParameter("nexturl");
String type = request.getParameter("type");
int certificate =0;
if(request.getParameter("certificate")!=null && request.getParameter("certificate").length()>0)
  certificate = Integer.parseInt(request.getParameter("certificate"));

Certificate obj = Certificate.find(certificate);

 String names=null, cardname=null, content=null;
    int maplen=0;
 if(certificate>0)
 {
   names =obj.getNames();
   cardname =obj.getCardname();

   if(obj.getFileurl()!=null)
   {
     maplen=(int)new java.io.File(application.getRealPath(obj.getFileurl())).length();
   }
   content = obj.getContent();
 }

 %>

<html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <script src="/tea/tea.js" type="text/javascript"></script>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">

  </head>

  <script language="javascript" type="">



  function sub()
  {
//    if(form1.labnames.value=='')
//    {
//      alert("请填写员工姓名！");
//      return false;
//    }

  }





  </script>
    <body>
     <h1>证照添加</h1>
  <div id="head6"><img height="6" src="about:blank" alt=""></div>
    <br>

    <form name="form1" METHOD="post" enctype="multipart/form-data" action="/servlet/EditCertificate" onSubmit="return sub(this);">
      <input  type="hidden" name="nexturl" value="<%=nexturl%>"/>
      <input type="hidden" name="act" value="EditCertificate"/>
      <input type="hidden" name="type" value="<%=type%>"/>
      <input type="hidden" name ="certificate" value ="<%=certificate%>">


      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
          <td><%if("1".equals(type))out.print("公司");else if("2".equals(type))out.print("个人");%>名称：</td><td><input type="text" name="names" value="<%if(names!=null)out.print(names);%>" ></td>
        </tr>
        <tr>
          <td>证照名字：</td><td><input type="text" name="cardname" value="<%if(cardname!=null)out.print(cardname);%>" >
          </td>
        </tr>
        <tr>
          <td>证照图片：</td><td><input type="file" name="fileurl" value="" >
          <%

	   if(maplen>0){
	 %>
	       <%=maplen %> <input  id="CHECKBOX" type="CHECKBOX" name="clear1" onClick="form1.fileurl.disabled=this.checked;"/> 清空
	 <%} %>
          </td>
        </tr>
        <tr>
         <td>备注:</td><td><textarea cols=50 name="content" rows=4  title="备注" ><%if(content!=null)out.print(content);%></textarea></td>
        </tr>
         </table>
      <br>
   <input type="Submit" name="Submit1" value="保存"><input type="reset" name="" value="重填" >
      <input type="button" name="" value="返回" onClick="location='<%=nexturl%>'" >
    </FORM>

    <br>
   <div id="head6"><img height="6" src="about:blank" alt=""></div>
  </body>
</html>
