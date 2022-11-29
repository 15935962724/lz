<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%


if(request.getMethod().equals("POST"))
{
  int id=Integer.parseInt(teasession.getParameter("id"));
  if(teasession.getParameter("delete")!=null)
  {
    Template obj=Template.find(id);
    obj.delete();
  }else
  {
    try
    {
      int template=Integer.parseInt(teasession.getParameter("template"));
      String name=teasession.getParameter("name");
      if(id==0)
      {
        Template.create(template,teasession._nNode,name);
      }else
      {
        Template obj=Template.find(id);
        obj.set(template,teasession._nNode,name);
      }
    }catch(Exception e)
    {
      response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "InvalidNodeNumber"),"UTF-8"));
      return;
    }
  }
  response.sendRedirect(request.getRequestURI()+"?node="+teasession._nNode);
  return;
}
r.add("/tea/ui/node/type/category/EditCategory");
%>
<script Language="JavaScript">

function delete_add(ADD_ID)
{
 msg='<%=r.getString(teasession._nLanguage, "DeleteTemplate")%>';
 if(window.confirm(msg))
 {
  URL="delete.jsp?id=" + ADD_ID;
  window.location=URL;
 }
}
</script>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Template")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2><%=r.getString(teasession._nLanguage, "TemplateManage")%></h2>

<form  method="POST" action="<%=request.getRequestURI()%>" name="form1" onSubmit="">
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="id" value="0"/>

<table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
        <tr id="tableonetr">
          <TD><%=r.getString(teasession._nLanguage, "NodeNumber")%></TD>
          <td><%=r.getString(teasession._nLanguage, "ActionTree")%></TD>
          <td><%=r.getString(teasession._nLanguage, "Name")%></TD>
          <td><%=r.getString(teasession._nLanguage, "operation")%></TD>
        </tr>
        <%
        java.util.Enumeration enumer=Template.findByPath(node.getPath());
while(enumer.hasMoreElements())
{
  int id=((Integer)enumer.nextElement()).intValue();
  Template obj=Template.find(id);

%>
        <tr valign=bottom   onmouseover="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
          <TD><%=obj.getNode()%>&nbsp;</TD>
          <td><%=obj.getCategory()%>&nbsp;</td>
          <td><%=obj.getName()%>&nbsp;</td>
          <td>
          <%if(teasession._nNode==obj.getCategory()){%>
            <input type=button  onclick="document.form1.id.value=<%=id%>;document.form1.template.value=<%=obj.getNode()%>;document.form1.name.value='<%=obj.getName()%>';document.form1.template.focus();"  value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" >
            <input type=submit name="delete" onclick="if(confirm('确认删除'))document.form1.id.value=<%=id%>;else return false;"  value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" >
<%}%>
          </td>
        </tr>
        <%
}

%>
      </table>

  <h2><%=r.getString(teasession._nLanguage, "AddTemplate")%></h2>
  <table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
    <tr>
      <TD><%=r.getString(teasession._nLanguage, "NodeNumber")%></TD>
      <td> <input name="template" type="text" class="edit_input" size="20"></td>
    </tr>
    <tr>
      <TD><%=r.getString(teasession._nLanguage, "Name")%></TD>
      <td> <input name="name" type="text" class="edit_input" size="20" ></td>
    </tr>
    <tr>
      <td colspan="2" align="center"> <input type="submit" onclick="return(submitInteger(document.form1.node, '<%=r.getString(teasession._nLanguage, "InvalidNodeNumber")%>')&&submitText(document.form1.name, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>'));" value="<%=r.getString(teasession._nLanguage, "Submit")%>" class="edit_button" id="edit_submit" name="submit">
        <input name="Submit" type="button" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Close")%>" onclick="javascript:window.close(); return false;"></td>
    </tr>
  </table>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

