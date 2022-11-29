<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.admin.earth.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();
 EarthNode.sync();
StringBuffer param=new StringBuffer("&community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer();

String ip=request.getParameter("_ip");
if(ip!=null&&(ip=ip.trim()).length()>0)
{
  sql.append(" AND ip = ").append(DbAdapter.cite(ip));
  param.append("&_ip=").append(java.net.URLEncoder.encode(ip,"UTF-8"));
}

String host=request.getParameter("_host");
if(host!=null&&(host=host.trim()).length()>0)
{
  sql.append(" AND host LIKE ").append(DbAdapter.cite("%"+host.replaceAll(" ","%")+"%"));
  param.append("&_host=").append(java.net.URLEncoder.encode(host,"UTF-8"));
}

String _strId=request.getParameter("id");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_edit(host)
{
  form1.nexturl.value=location;
  form1.host.value=host;
  form1.action='/jsp/admin/earth/EditEarthHost.jsp';
  form1.submit();
}
function f_move(host,off)
{
  form1.nexturl.value=location;
  form1.host.value=host;
  form1.sequence.value=off;
  form1.action='/servlet/EditEarth';
  form1.act.value='moveearthhost';
  form1.submit();
}
function f_refresh(host)
{
  form1.nexturl.value=location;
  form1.host.value=host;
  form1.action='/servlet/EditEarth';
  form1.act.value='refreshearthhost';
  form1.submit();
}
function f_delete(host)
{
  if(confirm('确认删除'))
  {
    form1.nexturl.value=location;
    form1.host.value=host;
    form1.action='/servlet/EditEarth';
    form1.act.value='deleteearthhost';
    form1.submit();
  }
}
</script>
</head>
<body>

<h1>虚似主机管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<h2>查询</h2>
<form name=form1 METHOD=get action="?">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="id" value="<%=_strId%>"/>
<input type=hidden name="act" >
<input type=hidden name="host">
<input type=hidden name="sequence">
<input type=hidden name="nexturl" >


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>IP:<select name="_ip">
       <option value="">---------------</option>
       <%
       java.util.Enumeration e=EarthIp.find("",0,Integer.MAX_VALUE);
       while(e.hasMoreElements())
       {
         String _ip=(String)e.nextElement();
         out.print("<option value='"+_ip+"'");
         if(_ip.equals(ip))
         out.print(" SELECTED ");
         out.print(">"+_ip);
       }
       %>
       </select></td>
       <td>主机:<input name="_host" value="<%if(host!=null)out.print(host);%>"></td>
       <td><input type="submit" value="查询"/></td>
     </tr>
</table>


<h2>列表</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap width="1">&nbsp;</td>
    <td>主机</td>
    <td>IP</td>
    <td>名称</td>
    <td>路径</td>
    <td>排序</td>
    <td>&nbsp;</td>
  </tr>
<%
java.util.Enumeration e2=EarthHost.find(sql.toString(),0,Integer.MAX_VALUE);
for(int index=1;e2.hasMoreElements();index++)
{
  host=(String)e2.nextElement();

  EarthHost obj=EarthHost.find(host);
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=index%></td>
    <td ><%=host%></td>
    <td ><%=obj.getIp()%></td>
    <td ><%if(obj.getName()!=null)out.print(obj.getName());else{out.print("&nbsp;");}%></td>
    <td ><%=obj.getRealPath()%></td>
    <td nowrap><%
    if(index>1)
    {
      out.print("<a href=\"javascript:f_move('"+host+"',true);\" ><img src=/tea/image/public/arrow_up.gif></a>");
    }
    if(e2.hasMoreElements())
    {
      out.print("<a href=\"javascript:f_move('"+host+"',false);\" ><img src=/tea/image/public/arrow_down.gif></a>");
    }
    %></td>
    <td>
      <input type=button value="<%=r.getString(teasession._nLanguage,"CBEdit")%>"  onClick="f_edit('<%=host%>');">
      <input type=button value="<%=r.getString(teasession._nLanguage,"刷新")%>"  onClick="f_refresh('<%=host%>');">
      <input type=button value="<%=r.getString(teasession._nLanguage,"CBDelete")%>"  onClick="f_delete('<%=host%>');">
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
