<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.ui.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.site.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
  return;
}

Resource r=new Resource("/tea/resource/Blog");

String community=teasession._strCommunity;

if("POST".equals(request.getMethod()))
{
  if(teasession.getParameter("temp_del")!=null)
  {
    Template3 temp=Template3.find(teasession._nNode);
    temp.delete();
  }else
  {
    String name=teasession.getParameter("name");
    Template3 temp=Template3.find(teasession._nNode);
    if(temp.isExists())
    {
      temp.set(name);
    }else
    {
      Template3.create(teasession._nNode,name);
    }
  }

  response.sendRedirect(request.getRequestURI()+"?community="+community);
  return;
}

%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage,"TemplateManage")%></h1>

<div id="head6"><img height="6" alt=""></div>

<form action="<%=request.getRequestURI()%>" method="post" name="form1" onsubmit="">
  <input type="hidden" name="community" value="<%=community%>"/>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr ID=tableonetr>
      <td  width="1"><script type="">var i=0;</script></TD>
      <td ><%=r.getString(teasession._nLanguage,"Name")%></TD>
      <TD><%=r.getString(teasession._nLanguage,"Node")%></TD>
      <td ></TD>
    </tr>
          <%
          java.util.Enumeration enumer=Template3.find();
          while(enumer.hasMoreElements())
          {
            int id=((Integer)enumer.nextElement()).intValue();
            Template3 temp_obj= Template3.find(id);
            %>
          <tr onmouseover="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
          <td width="1"><script type="">document.write(++i);</script></td>
            <td><%=temp_obj.getName()%> </td>
            <td><%=temp_obj.getNode()%> </td>
            <td><input type="button" value="<%=r.getString(teasession._nLanguage,"Edit")%>" class="edit_button" id="edit_submit" name="temp" onclick="form1.name.value='<%=temp_obj.getName()%>';form1.node.value='<%=id%>';form1.id.value='1';form1.name.focus();">
              <input type="submit" value="<%=r.getString(teasession._nLanguage,"Delete")%>" class="edit_button" id="edit_submit" name="temp_del" onclick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){form1.node.value='<%=id%>';}else return false;"></td>
          </tr>
          <%
          }
          %>
        </table>


  <h2><%=r.getString(teasession._nLanguage,"AddTemplate")%></h2>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <input type="hidden" name="id" value="0"/>
    <tr>
      <TD><%=r.getString(teasession._nLanguage,"Name")%></TD>
      <td><input name="name" type="text" class="edit_input" size="20" ></td>
    </tr>
    <tr>
      <TD><%=r.getString(teasession._nLanguage,"Node")%></TD>
      <td><input name="node" type="text" class="edit_input" size="20" ></td>
    </tr>
    <tr>
      <td colspan="2"><input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>" name="temp_edit" onclick="return submitText(form1.name,'<%=r.getString(teasession._nLanguage,"InvalidName")%>')&&submitInteger(form1.node,'<%=r.getString(teasession._nLanguage,"InvalidNodeNumber")%>');">
    </tr>
  </table>

</form>

<div id="head6"><img height="6" alt=""></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>

</body>
</html>

