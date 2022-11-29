<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.node.*" %><%@ page import="java.util.*" %><%@ page import="tea.ui.*" %><%@ page import="tea.html.*" %><%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Resource r=new Resource();


int cid=0;
int classcid=0;
int selectid=0;
if(request.getParameter("cid")!=null)
{
  cid=Integer.parseInt(request.getParameter("cid"));
}
if(request.getParameter("classid")!=null)
{
  classcid=Integer.parseInt(request.getParameter("classid"));
}
int type = 0;
if(request.getParameter("type")!=null)
{
  type=Integer.parseInt(request.getParameter("type"));
}
String name=null;
if(classcid!=0)
{
  ClassesChild c=ClassesChild.find(classcid);
  name=c.getName();
  selectid=c.getClass_id();
}else
{
  selectid=cid;
  name="";
}

%>
<html>
<head>
<title>添加子类</title>
<base target="dialog"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body onload="form1.name.focus();">
<h1>添加子类</h1>
<FORM name="form1" METHOD=POST action="/servlet/EditClasses" onsubmit="return submitText(this.name,'<%=r.getString(teasession._nLanguage, "InvalidSubject")%>');">
<input type='hidden' name="node" VALUE="<%=teasession._nNode%>">
<input type='hidden' name="classcid" VALUE="<%=classcid%>">
<input type='hidden' name="classid" VALUE="<%=selectid%>">
<input type='hidden' name="type" VALUE="<%=type%>">
<input type='hidden' name="act" VALUE="EditClassesChild">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>选择上级类别:</td>
    <td><select name="class_id"><%
    java.util.Enumeration enumer = tea.entity.node.Classes.findByCommunity(teasession._strCommunity, teasession._nLanguage);
    while (enumer.hasMoreElements())
    {
      int id = ((Integer) enumer.nextElement()).intValue();
      tea.entity.node.Classes obj = tea.entity.node.Classes.find(id);

      out.print("<option value="+id);
      if(selectid==id)
      {
        out.print(" selected ");
      }
     out.print(">"+obj.getName()+"</option>");

      }
      %></select></td>
  </tr>
  <tr>
    <td>名称:</td>
    <td><input type="TEXT" class="edit_input"  name="name" value="<%=name%>"></td>
  </tr>
</table>
<input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBClose")%>" onClick="window.close();">
</FORM>
<iframe style="display:none" name="dialog"></iframe>
</body>
</html>
