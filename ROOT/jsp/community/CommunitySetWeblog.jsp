<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.entity.node.*"%>
<%@ page import="tea.html.*"%>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.resource.*"%>
<%@ page import="tea.ui.TeaServlet"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.Socket"%>
<%@ page import=" tea.db.DbAdapter"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.entity.util.*"%>
<%@ page import="tea.entity.*"%>
<%@ page import="tea.entity.site.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="tea.entity.RV"%>
<%!
public String write(String community, byte byDate[])
{
  ByteArrayOutputStream bytestream = new ByteArrayOutputStream();
  OutputStream file = null;
  java.io.File f = new java.io.File(getServletContext().getRealPath("/tea/image/type/" + community + "/" + String.valueOf(System.currentTimeMillis()) + ".gif"));
  if (!f.getParentFile().exists())
  {
    f.getParentFile().mkdirs();
  } while (f.exists())
  {
    f = new java.io.File(getServletContext().getRealPath("/tea/image/type/" + community + "/" + String.valueOf(System.currentTimeMillis()) + ".gif"));
  }
  try
  {
    bytestream.write(byDate);
    file = new FileOutputStream(f);
    bytestream.writeTo(file);
    return "/tea/image/type/" + community + "/" + f.getName();
  } catch (Exception e)
  {
    e.printStackTrace();
  } finally
  {
    try
    {
      if (file != null)
      {
        file.close();
      }
      bytestream.close();
    } catch (IOException ex)
    {
    }
  }
  return "";
}
%>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
Resource r = new Resource();
r.add("/tea/resource/Blog");
Http h=new Http(request);
String community=h.community;
tea.entity.site.BLOGCommunity obj=tea.entity.site.BLOGCommunity.find(community);

if("POST".equals(request.getMethod()))
{
  boolean temp_edit=teasession.getParameter("temp_edit")!=null;
  boolean temp_del=teasession.getParameter("temp_del")!=null;
  if(temp_edit||temp_del)
  {
    int id=0;
    if(teasession.getParameter("id")!=null)
    id=Integer.parseInt(teasession.getParameter("id"));

    tea.entity.site.Template2 temp=tea.entity.site.Template2.find(id);
    if(temp_edit)
    {
      String pict=null;
      if(teasession.getParameter("clear")==null)
      {
        byte by[]=teasession.getBytesParameter("picture");
        if(by!=null)
        pict=write(community,by);
        else
        pict=temp.getPicture();
      }

      int node=Integer.parseInt(teasession.getParameter("node"));
      String name=teasession.getParameter("name");
      int css=Integer.parseInt(teasession.getParameter("css"));
      temp.set(community,node,name,css,pict);
    }else
    temp.delete();

    response.sendRedirect(request.getRequestURI()+"?community="+community);
    return;
  }else
  if(teasession.getParameter("weblog")!=null)
  {
    String picture;
    byte by[]=teasession.getBytesParameter("picture");
    if(by!=null)
    picture=write(community,by);
    else
    picture=obj.getPicture();
    obj.set(Integer.parseInt(teasession.getParameter("weblog")),Integer.parseInt(teasession.getParameter("cssjs")),picture);

    response.sendRedirect("/jsp/info/Succeed.jsp");
    return;
  }

}



long len=0;
if(obj.getPicture()!=null)
{
  java.io.File file=new java.io.File(application.getRealPath(obj.getPicture()));
  len=file.length();
}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body onload="form1.name.focus();">
<h1><%=r.getString(teasession._nLanguage,"模板定义")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<form action="/jsp/community/CommunitySetWeblog.jsp" method="post" enctype="multipart/form-data" name="form1" onsubmit="">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<%--
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage,"Node")%>:</TD>
      <td><input name="weblog"  class="edit_input"  type="text" value="<%=obj.getNode()%>"></td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td nowrap>CssJs:</TD>
      <td><input type="text" name="cssjs" value="<%=obj.getCssjs()%>"></td>
      <td>&nbsp;</td>
    </tr>
	    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage,"Picture")%>:</TD>
      <td><input type="file" ondblclick="window.open('<%=obj.getPicture()%>');" name="picture"><%if(len>0)out.print(len+r.getString(teasession._nLanguage,"Bytes"));%>
      </td>
      <td>&nbsp;</td>
    </tr>
  </table>
  <input type="submit"  class="edit_input"  name="Submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>" onclick="return (submitInteger(form1.weblog,'<%=r.getString(teasession._nLanguage,"InvalidNodeNumber")%>'));">
--%>
<h2><%=r.getString(teasession._nLanguage,"TemplateManage")%></h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
  <TD><%=r.getString(teasession._nLanguage,"Node")%></TD>
  <td width="100"><%=r.getString(teasession._nLanguage,"Name")%></TD>
  <td width="100"><%=r.getString(teasession._nLanguage,"Miniature")%></TD>
  <td width="80"><%=r.getString(teasession._nLanguage,"operation")%></TD>
</tr>
          <%
          java.util.Enumeration enumer=tea.entity.site.Template2.findByCommunity(community);
          while(enumer.hasMoreElements())
          {
            tea.entity.site.Template2 temp_obj= tea.entity.site.Template2.find(((Integer)enumer.nextElement()).intValue());
            %>
            <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
            <td><%=temp_obj.getNode()%> </td>
            <td><%=temp_obj.getName()%> </td>
            <td><A href="<%=temp_obj.getPicture()%>" target="_parent"><img style="width:inherit ;display:none; " alt="" onload="this.style.display='';" width="50" height="40" src="<%=temp_obj.getPicture()%>"/></A></td>
            <td><input type="button" value="<%=r.getString(teasession._nLanguage,"Edit")%>" class="edit_button" id="edit_submit" name="temp" onclick="form1.id.value='<%=temp_obj.getId()%>';form1.name.value='<%=temp_obj.getName()%>';form1.node.value='<%=temp_obj.getNode()%>';form1.css.value='<%=temp_obj.getCss()%>';form1.name.focus();">
              <input type="submit" value="<%=r.getString(teasession._nLanguage,"Delete")%>" class="edit_button" id="edit_submit" name="temp_del" onclick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){form1.id.value='<%=temp_obj.getId()%>';}else return false;"></td>
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
      <TD>CSS</TD>
      <td><input name="css" type="text" class="edit_input" size="20" ></td>
    </tr>
    <tr>
      <TD><%=r.getString(teasession._nLanguage,"Miniature")%></TD>
      <td><input name="picture" type="file" class="edit_input" size="20"> <input onclick="form1.picture.disabled=this.checked;" type="checkbox" name="clear"/><%=r.getString(teasession._nLanguage,"Clear")%></td>
    </tr>
    <tr>
      <td colspan="2">
        <input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>" class="edit_button" id="edit_submit" name="temp_edit" onclick="return submitText(form1.name,'<%=r.getString(teasession._nLanguage,"InvalidSubject")%>')&&submitInteger(form1.node,'<%=r.getString(teasession._nLanguage,"InvalidNodeNumber")%>')&&submitInteger(form1.css,'CSS');">
    </tr>
  </table>

</form>
  <div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>

</body>
</html>


