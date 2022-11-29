<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.site.*" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.html.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="java.math.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/Dynamic");
String community=teasession._strCommunity;
String nexturl=request.getParameter("nexturl");
int dynamic=Integer.parseInt(request.getParameter("dynamic"));

Dynamic d=Dynamic.find(dynamic);
String dtfb=d.getDtfb();
if("POST".equals(request.getMethod()))
{
  dtfb=request.getParameter("dtfb");
  d.setDtfb(dtfb);
  out.print("<script>window.close();</script>");
  return;
}

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function f_submit()
{
  var h="/";
  var op=form1.dtfb1.options;
  for(var i=0;i<op.length;i++)
  {
    h=h+op[i].value+"/";
  }
  form1.dtfb.value=h;
}
function f_dis()
{
  var flag=form1.dtfb1.selectedIndex==-1;
  form1.m3.disabled=form1.m4.disabled=form1.m1.disabled=flag;
  form1.m3.style.backgroundColor=form1.m4.style.backgroundColor=form1.m1.style.backgroundColor=flag?"#CCCCCC":"";
  //
  flag=form1.dtfb2.selectedIndex==-1;
  form1.m2.disabled=flag;
  form1.m2.style.backgroundColor=flag?"#CCCCCC":"";
}
setInterval(f_dis,200);
</script>
</head>

<body>

<h1>事务名称绑定</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" method="post" action="?" onsubmit="return f_submit();">
<input type='hidden' name="community" value="<%=community%>">
<input type='hidden' name="dynamic" value="<%=dynamic%>">
<input type='hidden' name="dtfb" value="/">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td>已选定</td>
    <td>&nbsp;</td>
    <td>备选</td>
    </tr>
  <tr>
  <td>
    <select name="dtfb1" size="10" multiple style="width:150" ondblclick="move(form1.dtfb1,form1.dtfb2,true);">
    <%
    String ds[]=dtfb.split("/");
    for(int i=1;i<ds.length;i++)
    {
      int id=Integer.parseInt(ds[i]);
      DynamicType obj=DynamicType.find(id);
      if(obj.isExists())
      {
        out.print("<option value="+id+">"+obj.getName(teasession._nLanguage));
      }
    }
    %>
    </select>
  </td>
  <td>
    <input type="button" name="m1" value=" → " onclick="move(form1.dtfb1,form1.dtfb2,true);"><br>
    <input type="button" name="m2" value=" ← " onclick="move(form1.dtfb2,form1.dtfb1,true);"><br>
    <input type="button" name="m3" value=" ↑ " onclick="move(form1.dtfb1,null,true);"><br>
    <input type="button" name="m4" value=" ↓ " onclick="move(form1.dtfb1,null,false);"></td>
  <td>
    <select name="dtfb2" size="10" multiple style="width:150" ondblclick="move(form1.dtfb2,form1.dtfb1,true);">
    <%
    Enumeration enumeration=DynamicType.findByDynamic(dynamic," AND type NOT IN('file','img','office','sign','cachet')",0,Integer.MAX_VALUE);
    while(enumeration.hasMoreElements())
    {
      int id=((Integer)enumeration.nextElement()).intValue();
      if(dtfb.indexOf("/"+id+"/")==-1)
      {
        DynamicType obj=DynamicType.find(id);
        out.print("<option value="+id+">"+obj.getName(teasession._nLanguage));
      }
    }
    %>
  </select>
</table>

<input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>" class="edit_button" id="edit_submit">
<input type="button" value="<%=r.getString(teasession._nLanguage, "关闭")%>" onclick="window.close();">
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
