<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"  %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*"%><%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/Editor");

CommunityOption obj=CommunityOption.find(teasession._strCommunity);
String toolbar=obj.get("editortoolbar");

String DEFAULT[]={"Source","DocProps","-","NewPage","Preview","-","Templates","Cut","Copy","Paste","PasteText","PasteWord","-","Print","SpellCheck","Undo","Redo","-","Find","Replace","-","SelectAll","RemoveFormat","Form","Checkbox","Radio","TextField","Textarea","Select","Button","ImageButton","HiddenField","\\n",
	"Bold","Italic","Underline","StrikeThrough","-","Subscript","Superscript","OrderedList","UnorderedList","-","Outdent","Indent","JustifyLeft","JustifyCenter","JustifyRight","JustifyFull","Link","Unlink","Anchor","Image","Flash","Table","Rule","Smiley","SpecialChar","PageBreak",
	"\\n","Style","FontFormat","FontName","FontSize","TextColor","BGColor","FitWindow"};
/*
	'-','Source','Preview',
	'-','Bold','Italic','Underline','StrikeThrough',
	'-','JustifyLeft','JustifyCenter','JustifyRight','JustifyFull',
	'-','Image','Table',
	'-','TextColor',
	'-','FontName','FontSize',
	'-','FitWindow'
*/
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
  form1.editortoolbar.value=v;
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "editor.CustomToolbar")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditCommunityOption" method="post" onSubmit="return f_submit();" target="_ajax">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="name" value="/editortoolbar/">
<input type="hidden" name="editortoolbar" value="<%=toolbar%>">
<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage,"")%></td>
    <td>
    <table>
    <tr><td>
    <select name="tr1" size="12" multiple style="width:150px" ondblclick="move(form1.tr1,form1.tr2,true);">
    <%
    if(toolbar!=null)
    {
      String tbs[]=toolbar.split("/");
      for(int i=1;i<tbs.length;i++)
      {
        out.print("<option value="+tbs[i]+">"+r.getString(teasession._nLanguage,"editor."+tbs[i]));
      }
    }
    %>
    </select>
    <td>
    <input type="button" value=" ← " onClick="move(form1.tr2,form1.tr1,true);"/><br>
    <input type="button" value=" → " onClick="move(form1.tr1,form1.tr2,true);"/><br><br>
    <input type="button" value=" ↓ " onClick="move(form1.tr1,null,false);"/><br>
    <input type="button" value=" ↑ " onClick="move(form1.tr1,null,true);"/>
    <td>
    <select name="tr2" size="12" multiple style="width:150px" ondblclick="move(form1.tr2,form1.tr1,true);">
    <%
    for(int i=0;i<DEFAULT.length;i++)
    {
      if(DEFAULT[i].equals("-")||DEFAULT[i].equals("\\n")||(toolbar!=null&&toolbar.indexOf("/"+DEFAULT[i]+"/")==-1))
      {
        out.print("<option value="+DEFAULT[i]+">"+r.getString(teasession._nLanguage,"editor."+DEFAULT[i]));
      }
    }
    //out.print("<option value=->"+r.getString(teasession._nLanguage,"editor.-"));
    //out.print("<option value=\\n>"+r.getString(teasession._nLanguage,"editor.\\n"));
    %>
    </select>
    </table></td>
    </tr>
</table>

<input type="submit" class="edit_input" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
