<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.db.*" %><%@page import="tea.entity.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.resource.Resource" %>
<%@page import="java.util.*" %><%

Http h=new Http(request,response);
response.setHeader("Cache-Control","no-cache");
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community+"&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString()));
  return;
}


StringBuffer par=new StringBuffer();
StringBuffer sql=new StringBuffer();
par.append("?community=").append(h.community);
sql.append(" AND m.community="+DbAdapter.cite(h.community)+" AND ml.media>0");

String menuid=request.getParameter("id");
par.append("&id=").append(menuid);

int type=h.getInt("type");
par.append("&type=").append(type);
sql.append(" AND m.type="+type);


String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND ml.name LIKE ").append(DbAdapter.cite("%"+name+"%"));
  par.append("&name="+Http.enc(name));
}

int pos=h.getInt("pos");
par.append("&pos=");

int count=Media.count(sql.toString());


Resource r = new Resource("/tea/resource/Media");

String title=r.getString(h.language, "ManageMedia");
%>
<html>
<head>
<title><%=title%></title>
<base target="dialog"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" scroll="yes">

<h2>查询</h2>
<form name="form1" action="?" target="dialog">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="type" value="<%=type%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="media" value="0"/>
<input type="hidden" name="nexturl"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>名称:<input name="name" value="<%=name%>" type="text"><input type="submit" value="GO"></td>
  </tr>
</table>
</form>

<h2>列表 ( <%=count %> )&nbsp;<INPUT TYPE=BUTTON VALUE="<%=r.getString(h.language, "CBNew")%>" ID="CBNew" CLASS="CB" onClick="f_edit(0);"></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td width=1></td>
    <td nowrap="nowrap" >ID号</td>
    <td>名称</td>
    <td>Logo</td>
    <td></td>
  </tr>
<%
sql.append(" ORDER BY ml.name");
Iterator it=Media.find(sql.toString(),pos,10).iterator();
for(int i=pos+1;it.hasNext();i++)
{
  Media t=(Media)it.next();
  String logo=t.getLogo(h.language);
  out.print("<tr onmouseover=bgColor='#BCD1E9'; onMouseOut=bgColor='';  >");
  out.print("<td width=1>"+i+"</td>");
  out.print("<td width=1><input type=text value="+t.media+" size=4 readonly></td>");
  out.print("<td title=\"点击,选择新闻媒体 \"  onclick=\"f_button('"+t.media+"',this);\" style=\"cursor:pointer\">");
 // out.print("<a href =# onclick=\"f_lin('/"+t.getName(h.language)+"/"+id+"/');\">");
  out.print(t.getName(h.language));
 // out.print("</a>");
  out.print("<td>");
  if(logo!=null&&logo.length()>0)
  {
    out.print("<img src=\""+logo+"\" height='50'>");
  }
  out.print("<td><input type=button value="+r.getString(h.language, "CBEdit")+" onClick=f_edit("+t.media+");>");
 // if(obj.isLayerExists(h.language))
  {
    out.print("<input type=button value="+r.getString(h.language, "CBDelete")+" onClick=f_del("+t.media+") >");
  }
}
if(count>10)out.print("<tr><td colspan='20' align='center'>"+new tea.htmlx.FPNL(h.language,par.toString(),pos,count,10)+"</td></tr>");
%>
</table>


<script>
window.name="dialog";
form1.nexturl.value=location.pathname+location.search;
if(form1.nexturl.value.charAt(0)!='/')form1.nexturl.value='/'+form1.nexturl.value;//IE此处以不“/”开头
function f_edit(id)
{
  form1.name.disabled=true;
  form1.media.value=id;
  form1.action="/jsp/type/media/EditMedia.jsp";
  form1.submit();
}
function f_del(id)
{
  if(confirm('<%= r.getString(h.language, "ConfirmDelete")%>'))
  {
    form1.media.value=id;
    form1.method="POST";
    form1.action="/servlet/EditMedia?act=del";
    form1.submit();
  }
}
function f_button(igd,igd2)
{
  window.returnValue='/'+igd+'/'+igd2.innerHTML+'/';
  window.close();
}
</script>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(h.language,request)%></div>
</body>
</html>
