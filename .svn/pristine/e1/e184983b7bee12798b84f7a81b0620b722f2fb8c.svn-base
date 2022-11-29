<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");
String nexturl=request.getParameter("nexturl");

int referenceres=Integer.parseInt(request.getParameter("referenceres"));



Resource r=new Resource();

String name,publishing,author,calling,specialty,derivation;
java.util.Date time=null;
if(referenceres!=0)
{
  Referenceres obj=Referenceres.find(referenceres);
  name=obj.getName().replaceAll("\"","&quot;");
  publishing=obj.getPublishing().replaceAll("\"","&quot;");
  calling=obj.getCalling();
  specialty=obj.getSpecialty();
  author=obj.getAuthor().replaceAll("\"","&quot;");
  time=obj.getTime();
  derivation=obj.getDerivation();
}else
{
  name=publishing=author=calling=specialty=derivation="";
}
%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function defaultfocus()
{
  document.form1.name.focus();
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>参考文献</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form name="form1" action="/servlet/EditItem" method="post" onSubmit="return submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-姓名')&&submitText(this.calling, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-行业')&&submitText(this.specialty, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-专长')">
<input type=hidden name="referenceres" value="<%=referenceres%>"/>
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<input type=hidden name="act" value="EditReferenceres"/>
<input type=hidden name="item" value="0"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>名称:</td>
         <TD><input name="name" type="text" id="name" value="<%=name%>"></TD>
     </tr>

       <tr>
        <td>出版社</td>
         <td nowrap><input name="publishing" type="text" id="publishing" value="<%=publishing%>" size="40"></td>
       </tr>
       <tr>
         <td>行业</td>
         <td nowrap><input name="calling" type="text" id="calling" value="<%=calling%>" size="40">
         <%--
           <select name="calling" id="calling">
	   <option value="" >------------
           <%
           for(int index=0;index<Expertres.CALLING_TYPE.length;index++)
           {
            out.print("<option value="+index);
            if(index==calling)
            out.print(" SELECTED ");
            out.println(" >"+Expertres.CALLING_TYPE[index]);
           }
           %></select>
           --%>
         </td>
       </tr>
              <tr>
         <td>专长</td>
         <td nowrap><input name="specialty" type="text" id="specialty" value="<%=specialty%>" size="40">
         <%--
         <select name="specialty" id="specialty">
	   <option value="" >------------
       <%
           for(int index=0;index<Expertres.SPECIALTY_TYPE.length;index++)
           {
            out.print("<option value="+index);
            if(index==specialty)
            out.print(" SELECTED ");
            out.println(" >"+Expertres.SPECIALTY_TYPE[index]);
           }
           %></select>
           --%>
         </td>
       </tr>
 <tr>
        <td>作者</td>
         <td nowrap><input name="author" type="text" id="author" value="<%=author%>" size="40"></td>
       </tr>
        <tr>
        <td>出处(来源)</td>
         <td nowrap><input name="derivation" type="text" id="derivation" value="<%=derivation%>" size="40"></td>
       </tr>
       <tr>
        <td>日期</td>
         <td nowrap><%=new tea.htmlx.TimeSelection("time", time)%></td>
       </tr>
       <tr>
         <td>&nbsp;</td>
         <td nowrap>
           <input type="submit" name="Submit" value="提交">
           <input type="reset" name="Submit2" value="重置" onClick="defaultfocus();">
           <input type="button" value="返回" onClick="history.back();">         </td>
       </tr>
  </table>
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


