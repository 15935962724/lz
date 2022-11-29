<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.site.*" %><%@ page import="java.io.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;


Resource r=new Resource("/tea/resource/Dynamic");
String nexturl=request.getParameter("nexturl");
int dynamic=Integer.parseInt(request.getParameter("dynamic"));
int sort=0;
String tmp=request.getParameter("sort");
if(tmp!=null)
{
  sort=Integer.parseInt(tmp);
}
int len=0;
String name,type,template=null;
if(dynamic!=0)
{
  Dynamic obj=Dynamic.find(dynamic);
  name=obj.getName(teasession._nLanguage);
  template=obj.getTemplate(teasession._nLanguage);
  type=obj.getType();
  if(template!=null)
  {
    len=(int)new File(application.getRealPath(template)).length();
  }
}else
{
  name=type="";
}

%><HTML>
<HEAD>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</HEAD>
<body onload="form1.name.focus();">
<h1><%=r.getString(teasession._nLanguage, "AddAttribute")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
 <FORM name="form1" enctype=multipart/form-data method=POST action="/servlet/EditDynamic" onsubmit="return submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&submitText(this.type, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-<%=r.getString(teasession._nLanguage, "Type")%>')" >
    <input type='hidden' name=nexturl value="<%=nexturl%>">
    <input type='hidden' name=community value="<%=community%>">
    <input type='hidden' name=dynamic value="<%=dynamic%>">
    <input type='hidden' name=sort value="<%=sort%>">

    <table cellspacing="0" cellpadding="0" id="tablecenter">
      <tr>
        <td>*<%=r.getString(teasession._nLanguage, "Name")%></td>
        <td> <input name="name" type="text" class="edit_input" value="<%=name%>" size="40" ></td>
      </tr>
      <tr>
        <td>*<%=r.getString(teasession._nLanguage, "Type")%></td>
        <td> <input name="type" type="text" class="edit_input" value="<%=type%>" maxlength="2" size="5" ></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Template")%></td>
        <td><input name="template" type="file" class="edit_input" >
          <%
          if(len>0)
          {
            out.print("<a href='/jsp/include/DownFile.jsp?uri="+template+"&name=exp.xls' >"+len+r.getString(teasession._nLanguage,"Bytes")+"</a>");
            out.print("<input name=clear type=checkbox onclick=form1.template.disabled=this.checked>"+r.getString(teasession._nLanguage,"Clear"));
          }
          %></td>
      </tr>
      <tr>
        <td colspan="2" align="center">
          <input type="submit" value="<%=r.getString(teasession._nLanguage, "CBNext")%>" class="edit_button" id="edit_submit" name="GoNext">
          <input type="submit" value="<%=r.getString(teasession._nLanguage, "GoFinish")%>" class="edit_button" id="edit_submit" name="submit">
        </td>
      </tr>
    </table>

  </form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
