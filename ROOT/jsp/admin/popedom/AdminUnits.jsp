<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.io.*" %><%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String menuid=h.get("id");

Resource r=new Resource("/tea/resource/unitlist");

String nexturl=h.get("nexturl");

int root=AdminUnit.getRootId(h.community);

int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null)pos=Integer.parseInt(tmp);

StringBuffer par=new StringBuffer();
StringBuffer sql = new StringBuffer();
par.append("?community=").append(h.community);
par.append("&id=").append(menuid);

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name=").append(Http.enc(name));
}
par.append("&pos=");

int sum=AdminUnit.countByCommunity(h.community,sql.toString());

%><html>
<head>
<title><%=r.getString(h.language, "DeptManage")%></title>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<SCRIPT language="JavaScript" type="">
function f_edit(obj,id)
{
  form2.action="/jsp/admin/popedom/EditAdminUnit.jsp";
  form2.method="get";
  form2.adminunit.value=id;
  form2.nexturl.value=location;
  obj.disabled=true;
  obj.value="Load...";
  form2.submit();
}
function f_delete(obj,id)
{
  if(confirm('<%=r.getString(h.language, "ConfirmDelete")%>'))
  {
    form2.adminunit.value=id;
    form2.act.value='deleteadminunit';
    form2.nexturl.value=location;
    obj.disabled=true;
    obj.value="Load...";
    form2.submit();
  }
}
function f_move(id,bool)
{
  form2.act.value='moveadminunit';
  form2.adminunit.value=id;
  form2.nexturl.value=location;
  form2.sequence.value=bool;
  form2.submit();
}

function f_submit()
{
  return( submitInteger(form2.pid,'<%=r.getString(h.language, "InvalidParameter")%>-<%=r.getString(h.language, "Code")%>')
		&&submitText(form2.name,'<%=r.getString(h.language, "InvalidName")%>'))
}
function f_load()
{
  if(form2.nexturl.value.length<5)
  {
    form2.nexturl.value=location;
  }
}
</SCRIPT>
</head>
<BODY onLoad="f_load();" id="bodynone">
<div id="wai">
<h1><%=r.getString(h.language, "DeptManage")%></h1>
<div id="head6"><img height="6" alt=""></div>

<form name="form1" action="?">
<input type=hidden name="id" value="<%=menuid%>"/>

<h2>查询</h2>
<table cellSpacing="0" cellPadding="0" width="100%" border="0" id="tablecenter">
<tr>
  <td colspan="2" align="left"><%=r.getString(h.language, "Name")%><input name="name" value="<%=name%>"/>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>


<form name="form2" action="/servlet/EditAdminPopedom" method="post" enctype="multipart/form-data">
<input type=hidden name="community" value="<%=h.community%>"/>
<input type=hidden name="adminunit" value="0">
<input type=hidden name="act" value="editadminunit"/>
<input type=hidden name="id" value="<%=menuid%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<input type=hidden name="sequence" />
<h2>列表 <%=sum%></h2>
<table cellSpacing="0" cellPadding="0" width="100%" border="0" id="tablecenter">
  <tr id="tableonetr">
    <td><%=r.getString(h.language, "Name")%></td>
    <td><%=r.getString(h.language, "Telephone")%></td>
    <td><%=r.getString(h.language, "Fax")%></td>
    <td><%=r.getString(h.language, "排序")%></td>
    <td><%=r.getString(h.language, "operation")%></td>
  </tr>
<%
if(sum>0)
{
  int last=0;
  Enumeration e = AdminUnit.findByCommunity(h.community,sql.toString()+" ORDER BY sequence",pos,15);
  for(int i=1;e.hasMoreElements();i++)
  {
    AdminUnit obj=(AdminUnit)e.nextElement();
    int id=obj.getId();
    int fid=obj.getFather();
    out.write("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
    out.write("<td>"+obj.getPrefix()+obj.getName());
    out.write("<td align=center>"+MT.f(obj.tel));
    out.write("<td align=center>"+MT.f(obj.fax));
    out.write("<td align=center>");
    if(last==fid)
    out.write("<a href=javascript:f_move('"+id+"',true)><img src=/tea/image/public/arrow_up.gif></a>");
    else
    out.write("　&nbsp;");
    last=fid;
    if(e.hasMoreElements())
    out.write("<a href=javascript:f_move('"+id+"',false)><img src=/tea/image/public/arrow_down.gif></a>");

    out.write("<td align=center><input type='button' value="+r.getString(h.language, "CBEdit")+" onclick=f_edit(this,"+id+")> ");
    out.write("<input type='button' value="+r.getString(h.language, "CBDelete")+" onclick=f_delete(this,"+id+")>\r\n");
  }
  if(sum>15)out.print("<tr><td colspan='5' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,15)+"</td></tr>");
}else
{
  out.print("<tr><td colspan='5' align='center'>暂无部门");
}

%>
</table>
<input type="button" value="<%=r.getString(h.language, "CBNew")%>" onclick="f_edit(this,0)">
</form>

<br>
<div id="head6"><img height="6" alt=""></div>
</div>
</body>
</html>
