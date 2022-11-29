<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.node.*" %><%@ page  import="tea.entity.admin.earth.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

StringBuffer param=new StringBuffer("&community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer();

String ip=request.getParameter("_ip");
if(ip!=null&&(ip=ip.trim()).length()>0)
{
  sql.append(" AND ip LIKE ").append(DbAdapter.cite("%"+ip+"%"));
  param.append("&_ip=").append(java.net.URLEncoder.encode(ip,"UTF-8"));
}

String name=request.getParameter("name");
if(name!=null&&(name=name.trim()).length()>0)
{
  sql.append(" AND name LIKE ").append(DbAdapter.cite("%"+name.replaceAll(" ","%")+"%"));
  param.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
}

String _strId=request.getParameter("id");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_edit(ip)
{
  form1.nexturl.value=location;
  form1.ip.value=ip;
  form1.action='/jsp/admin/earth/EditEarthIp.jsp';
  form1.submit();
}
function f_refresh(ip)
{
  form1.nexturl.value=location;
  form1.ip.value=ip;
  form1.action='/servlet/EditEarth';
  form1.act.value='refreshearthip';
  form1.submit();
}
function f_move(ip,off)
{
  form1.nexturl.value=location;
  form1.ip.value=ip;
  form1.sequence.value=off;
  form1.action='/servlet/EditEarth';
  form1.act.value='moveearthip';
  form1.submit();
}
function f_delete(ip)
{
  if(confirm('确认删除'))
  {
    form1.nexturl.value=location;
    form1.ip.value=ip;
    form1.action='/servlet/EditEarth';
    form1.act.value='deleteearthip';
    form1.submit();
  }
}
</script>
</head>
<body>

<h1>服务器IP管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<h2>查询</h2>
<form name=form1 METHOD=get action="?">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="id" value="<%=_strId%>"/>
<input type=hidden name="act" >
<input type=hidden name="ip">
<input type=hidden name="sequence">
<input type=hidden name="nexturl" >


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>IP:<input name="_ip" value="<%if(ip!=null)out.print(ip);%>"></td>
      <td>名称:<input name="name" value="<%if(name!=null)out.print(name);%>"></td>
        <td><input type="submit" value="查询"/></td>
  </tr>
</table>


<h2>列表</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap width="1">&nbsp;</td>
    <td>IP</td>
    <td>名称</td>
    <td>端口</td>
    <td>节点</td>
    <td>排序</td>
    <td>&nbsp;</td>
  </tr>
<%
java.util.Enumeration e=EarthIp.find(sql.toString(),0,Integer.MAX_VALUE);
for(int index=1;e.hasMoreElements();index++)
{
  ip=(String)e.nextElement();
  EarthIp obj=EarthIp.find(ip);
  int node=obj.getNode();
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=index%></td>
    <td ><%=ip%></td>
    <td ><%=obj.getName()%></td>
    <td ><%=obj.getPort()%></td>
    <td ><%
    if(node>0)
    {
      Node n_obj=Node.find(node);
      if(n_obj.getCreator()!=null)
      out.print("<a target='newwindows' href=/servlet/Node?node="+node+"&Language="+teasession._nLanguage+">"+n_obj.getSubject(teasession._nLanguage)+"</a>");
      else
      out.print(node);
    }
    %></td>
    <td nowrap>
    <%
    if(index>1)
    {
      out.print("<a href=javascript:f_move('"+ip+"',-3); ><img src=/tea/image/public/arrow_up.gif></a>");
    }
    if(e.hasMoreElements())
    {
      out.print("<a href=javascript:f_move('"+ip+"',3); ><img src=/tea/image/public/arrow_down.gif></a>");
    }
    %></td>
    <td>
      <input type=button value="<%=r.getString(teasession._nLanguage,"CBEdit")%>"  onClick="f_edit('<%=ip%>');">
      <input type=button value="<%=r.getString(teasession._nLanguage,"刷新")%>"  onClick="f_refresh('<%=ip%>');">
      <input type=button value="<%=r.getString(teasession._nLanguage,"CBDelete")%>"  onClick="f_delete('<%=ip%>');">
    </td>
 </tr>
<%
}
%>
</table>
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBNew")%>" onClick="f_edit('');">
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



