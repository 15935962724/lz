<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.site.*" %><%@ page import="java.util.*" %><%@ page import="tea.ui.*" %><%@ page import="tea.html.*" %><%
request.setCharacterEncoding("UTF-8");

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Resource r=new Resource();

int mark=h.getInt("mark");
String name=h.get("name");
String act=h.get("act");
int type=255;
if("POST".equals(request.getMethod()))
{
  out.print("<script>mt=parent.mt;");
  try
  {
    if("del".equals(act))
    {
      Mark c=Mark.find(mark);
      c.delete();
    }else
    {
      type=h.getInt("type");
      if(Mark.count(" AND mark!="+mark+" AND community="+DbAdapter.cite(h.community)+" AND type="+type+" AND name="+DbAdapter.cite(name))>0)
      {
        out.print("mt.show('“"+name+"”已存在！');");
        return;
      }
      Mark c=Mark.find(mark);
      c.community=h.community;
      c.type=type;
      c.name=name;
      c.set();
    }
    out.print("mt.show('操作执行成功！',1,'location.reload()');");
  }finally
  {
    out.print("</script>");
  }
  return;
}

if(mark>0)
{
  Mark c=Mark.find(mark);
  name=c.getName();
  type=c.getType();
}else
{
  name="";
}
String title=r.getString(h.language, "添加/编辑 类别");
%>
<html>
<head>
<title><%=title%></title>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body style="overflow:hidden" class="iframe">

<form name="form1" METHOD=POST action="?" onsubmit="if(this.name.value==''){alert('“名称”不能为空！');return false;}">
<input type='hidden' name="node" value="<%=h.node%>">
<input type='hidden' name="mark" value="<%=mark%>">
<input type='hidden' name="act" value="<%=act%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
if("del".equals(act))
{
  int j=Node.count(" AND community="+DbAdapter.cite(h.community)+" AND mark LIKE '%/"+mark+"/%'");
  out.print("<tr><td>此类别下共有“"+j+"”个页面,确认删除吗?</td></tr>");
}else
{
%>
<tr>
  <td><%=r.getString(h.language, "名称")%>:</td>
  <td><input class="edit_input" name="name" value="<%=name%>"></td>
</tr>
<tr>
  <td><%=r.getString(h.language, "类型")%>:</td>
  <td><%=new tea.htmlx.TypeSelection(h.community,h.language, type)%></td>
</tr>
<%
}
%>
</table>
<input type="submit" value="<%=r.getString(h.language, "Submit")%>">
<input type="button" value="<%=r.getString(h.language, "CBClose")%>" onClick="mt.close();">
</form>

<script>
mt=parent.mt;
if(form1.name)form1.name.focus();
</script>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
