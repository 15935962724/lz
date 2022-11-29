<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %>
<%@page  import="tea.entity.node.*" %><%@page  import="tea.entity.site.*" %><%@ page import="java.util.*" %><%@ page import="java.io.*" %>
<%@ page import="tea.ui.*" %><%@ page import="tea.html.*" %>
<%@ page import="tea.htmlx.*"%>
<%

request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);
Node node = Node.find(teasession._nNode);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}else
{
  if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(55))
  {
    response.sendError(403);
    return;
  }
}

String community=node.getCommunity();
Resource r=new Resource("tea/resource/Perform");
String nexturl=teasession.getParameter("nexturl");
Perform obj;
String subject="",text="";
if(node.getType()==1)
{
  obj = Perform.find(0, teasession._nLanguage);
  out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
}else
{
  obj=Perform.find(teasession._nNode, teasession._nLanguage);
  subject=HtmlElement.htmlToText(node.getSubject(teasession._nLanguage));
  text=node.getText(teasession._nLanguage);
}
long lp1len=0;
if(obj.getIntropicture()!=null)
{
 lp1len=(int)new File(application.getRealPath(obj.getIntropicture())).length();
}


%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<script>
function f_submit()
{
  if(form1.Subject.value=='')
  {
    alert('请添加演出名称!');
    document.form1.Subject.focus();
    return false;
  }
}
</script>
<h1><%=r.getString(teasession._nLanguage, "Perform")%><%=r.getString(teasession._nLanguage, "Edit")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%>  </div>
  <form name="form1" method="post" action="/servlet/EditPerform"  ENCtype=multipart/form-data  onSubmit="return f_submit();">
  <input type="hidden" name="node" value="<%=teasession._nNode%>">
  <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
  <input type="hidden" name="act" value="EditPerform">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td align="right" nowrap><%=r.getString(teasession._nLanguage, "Perform.Subject")%>:
      </td>
      <td >
        <input type="text" size="60" class="edit_input" name="Subject" value="<%=subject%>"  maxlength="60">&nbsp;*&nbsp;
      </td>
    </tr>

	<tr>
      <td align="right" nowrap><%=r.getString(teasession._nLanguage, "Perform.pftime")%>:
      </td>
      <td>
        <input type="text"  size="60"  class="edit_input" name="pftime"  value="<%if(obj.getPftime()!=null)out.print(obj.getPftime());%>" maxlength="60">
      </td>
    </tr>

	<tr>
      <td align="right" nowrap><%=r.getString(teasession._nLanguage, "Perform.price")%>:
      </td>
      <td>
        <input type="text"  size="60"  class="edit_input" name="price"  value="<%if(obj.getPfprice()!=null)out.print(obj.getPfprice());%>" maxlength="60">
      </td>
    </tr>

    <tr>
      <td align="right" nowrap><%=r.getString(teasession._nLanguage, "Perform.Sort")%>:
      </td>
      <td>
        <input type="text"  size="60"  class="edit_input" name="sort"  value="<%if(obj.getSort()!=null)out.print(obj.getSort());%>" maxlength="60">
      </td>
    </tr>


    <tr>
      <td align="right" nowrap><%=r.getString(teasession._nLanguage,"Perform.Text")%>:</td>
      <td>
        <textarea style="display:none" name="content" rows="12" cols="90" class="edit_input"><%=text %></textarea>
        <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=teasession._strCommunity%>" width="740" height="300" frameborder="no" scrolling="no"></iframe>
      </td>
    </tr>

    <tr>
      <td align="right" nowrap><%=r.getString(teasession._nLanguage, "Perform.Organise")%>: </td>
      <td>
        <input type="text" size="60" class="edit_input" name="organise"   value="<%if(obj.getOrganise()!=null)out.print(obj.getOrganise());%>" >
      </td>
    </tr>

    <tr>
      <td align="right" nowrap><%=r.getString(teasession._nLanguage, "Perform.Linkman")%>:</td>
      <td>
        <input type="text" size="60" class="edit_input" name="linkman" value="<%if(obj.getLinkman()!=null)out.print(obj.getLinkman());%>">
      </td>
    </tr>
    <tr>
      <td align="right" nowrap><%=r.getString(teasession._nLanguage, "Perform.Corp")%>:</td>
      <td>
        <input type="text" size="60" class="edit_input" name="corp"  value="<%if(obj.getCorp()!=null)out.print(obj.getCorp());%>">
      </td>
    </tr>

    <tr>
      <td align="right" nowrap><%=r.getString(teasession._nLanguage, "Perform.IntroPicture")%>:</td>
      <td>
        <INPUT TYPE=FILE NAME=intropicture class="edit_input">
        <%
        if(lp1len>0)
        {
          out.print("<a href="+obj.getIntropicture()+" target=_blank>"+lp1len+ r.getString(teasession._nLanguage, "Bytes")+"</a>");
          out.print("<input type=checkbox name=ClearIntroPicture onclick='form1.intropicture.disabled=this.checked'>"+r.getString(teasession._nLanguage, "Clear"));
        }
        %>
        </td>
    </tr>

    <tr>
      <td align="right" nowrap><%=r.getString(teasession._nLanguage, "Perform.Direct")%>:</td>
      <td>
        <input type="text" size="60" class="edit_input" name="direct"  value="<%if(obj.getDirect()!=null)out.print(obj.getDirect()); %>">
      </td>
    </tr>
  </table>
  <br>
  <INPUT TYPE=SUBMIT NAME="GoBack"  ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Perform.GoBack")%>">&nbsp;
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">&nbsp;
    <input type=button value="返回" onClick="javascript:history.back()">&nbsp;

  </form>


  <div id="head6"><img height="6" src="about:blank"></div>
    <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>

