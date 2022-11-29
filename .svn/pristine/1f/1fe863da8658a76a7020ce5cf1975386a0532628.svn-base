<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"  %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/Other");

CommunityOption obj=CommunityOption.find(teasession._strCommunity);
int info=obj.getInt("tenderinfo");
String role=obj.get("tenderrole");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function f_submit()
{
  var v="/";
  var o1=form1.tr1.options;
  for(var i=0;i<o1.length;i++)
  {
    v=v+o1[i].value+"/";
  }
  form1.tenderrole.value=v;
  return submitInteger(form1.tenderinfo,'<%=r.getString(teasession._nLanguage,"InvalidNodeNumber")%>');
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "SetOther")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditCommunityOption" method="post" target="_ajax" onsubmit="return f_submit();">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="name" value="/tenderinfo/tenderrole/">
<input type="hidden" name="tenderrole" value="<%=role%>">

<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage,"招标类")%></td>
    <td><input name="tenderinfo" onblur="value=value.replace(/\D/g,'');if(value=='')value='0';" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" value="<%=info%>"></td>
    <td>权限不足的信息提示页</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"角色")%></td>
    <td>
    <table>
    <tr><td>
    <select name="tr1" size="10" multiple style="width:150px" ondblclick="move(form1.tr1,form1.tr2,true);"></select>
    <td>
    <input type="button" value=" ← " onclick="move(form1.tr2,form1.tr1,true);"/>
    <br>
    <input type="button" value=" → " onclick="move(form1.tr1,form1.tr2,true);"/>
    <td>
    <select name="tr2" size="10" multiple style="width:150px" ondblclick="move(form1.tr2,form1.tr1,true);">
    <%
    Enumeration e=AdminRole.findByCommunity(teasession._strCommunity,teasession._nStatus);
    while(e.hasMoreElements())
    {
      int id=((Integer)e.nextElement()).intValue();
      AdminRole ar=AdminRole.find(id);
      if(role.indexOf("/"+id+"/")!=-1)
      {
        out.print("<script>form1.tr1.options[form1.tr1.options.length]=new Option(\""+ar.getName()+"\","+id+");</script>");
      }else
      {
        out.print("<option value="+id+">"+ar.getName());
      }
    }
    %></select>
    </table>
    </td>
    <td>下载查看,应该有那个角色。</td>
  </tr>
</table>

<input type="submit" class="edit_input" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
