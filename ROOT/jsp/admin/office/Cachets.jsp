<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.admin.office.*" %>
<%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

StringBuffer param=new StringBuffer("&community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer();


String name=request.getParameter("name");
if(name!=null&&(name=name.trim()).length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name.replaceAll(" ","%")+"%"));
  param.append("&name="+java.net.URLEncoder.encode(name,"UTF-8"));
}

String type=(request.getParameter("type"));
if(type!=null&&type.length()>0)
{
  sql.append(" AND type="+type);
  param.append("&type="+java.net.URLEncoder.encode(type,"UTF-8"));
}

String esp=request.getParameter("esp");
String _strId=request.getParameter("id");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function moveimd(igd,sequence)
{
  form1.cachet.value=igd;
  form1.act.value='move';
  form1.sequence.value=sequence;
  form1.action='/servlet/EditCachet';
  form1.submit();
}
function editimd(igd)
{
  form1.cachet.value=igd;
  if(form1.esp)
  {
    form1.action='/jsp/admin/office/EditCachetEsp.jsp';
  }else
  {
    form1.action='/jsp/admin/office/EditCachet.jsp';
  }
  form1.submit();
}
function deleteimd(igd)
{
  if(confirm('确认删除'))
  {
    form1.cachet.value=igd;
    form1.action='/servlet/EditCachet';
    form1.act.value='delete';
    form1.submit();
  }
}
</script>
</head>
<body>

<h1>电子章</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<h2>查询</h2>
<form name=form1 action="?">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<script>document.write("<input type=hidden name=nexturl value="+document.location+">");</script>
<input type=hidden name="id" value="<%=_strId%>"/>
<input type=hidden name="act" >
<input type=hidden name="cachet">
<input type=hidden name="sequence">
<%
if(esp!=null)
{
  out.print("<input type=hidden name=esp >");
}
%>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>名称<input name="name" value="<%if(name!=null)out.print(name);%>"></td>
    <td><input type="submit" value="查询"/></td>
  </tr>
</table>


<h2>列表</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap >序号</td>
    <td>名称</td>
    <td>类型</td>
<%--    <td>缩略图</td> --%>
    <td>排序</td>
    <td>操作</td>
  </tr>
<%
java.util.Enumeration e=Cachet.find(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);
for(int index=1;e.hasMoreElements();index++)
{
  int igd=((Integer)e.nextElement()).intValue();
  Cachet obj=Cachet.find(igd);
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td align="center"><%=index%></td>
    <td nowrap><%=obj.getName()%></td>
    <td align="center" nowrap><%=obj.getType()%></td>
    <%--         <td nowrap><img onerror="this.style.display='none';" src="<%=obj.getPicture()%>" ></td>--%>
      <td align="center" nowrap><%
      if(index>1)
      {
        out.print("<a href=javascript:moveimd("+igd+",true); ><img src=/tea/image/public/arrow_up.gif></a>");
      }
      if(e.hasMoreElements())
      {
        out.print("<a href=javascript:moveimd("+igd+",false); ><img src=/tea/image/public/arrow_down.gif></a>");
      }
      %></td>
      <td align="center" nowrap>
        <input type=button value="<%=r.getString(teasession._nLanguage,"CBEdit")%>"  onClick="editimd(<%=igd%>);">
        <input type=button value="<%=r.getString(teasession._nLanguage,"CBDelete")%>"  onClick="deleteimd(<%=igd%>);">      </td>
 </tr>
<%
}
%>
</table>
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBNew")%>" onClick="editimd(0);">
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</HTML>
