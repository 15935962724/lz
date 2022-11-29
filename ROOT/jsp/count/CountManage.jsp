<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.access.*" %>

<% request.setCharacterEncoding("UTF-8");

tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
  return;
} 

if(!teasession._rv.isOrganizer(teasession._strCommunity)&&!teasession._rv.isWebMaster())
{
  response.sendError(403);
  return;
}
if(request.getMethod().equals("POST"))
{
  String nexturl=request.getParameter("nexturl");
  if(request.getParameter("clear")!=null)
  {
  /*
    NodeAccessHour.delete(teasession._strCommunity);
    NodeAccessDay.delete(teasession._strCommunity);
    NodeAccessMonth.delete(teasession._strCommunity);
    NodeAccessReferer.delete(teasession._strCommunity);
    NodeAccessWhere.delete(teasession._strCommunity);
    */
    /*
    tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
    try
    {
      dbadapter.executeUpdate("UPDATE Node SET click=0 WHERE community="+dbadapter.cite(teasession._strCommunity));
    }catch(Exception e)
    {
      e.printStackTrace();
    }finally
    {
      dbadapter.close();
    }*/
  }else
  {
    String ip=request.getParameter("ip");
    if(request.getParameter("add")!=null)
    {
      NodeAccessManage.create(teasession._strCommunity,ip);
    }if(request.getParameter("delete")!=null)
    {
      NodeAccessManage.find(teasession._strCommunity,ip).delete();
    }
  }
  response.sendRedirect("/jsp/info/Succeed.jsp?nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));
  return;
}

%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onLoad="form1.ip.focus();">
<h1>添加不加入统计的IP</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<form name="form1" method="POST" action="<%=request.getRequestURI()%>" onSubmit="" ><!--this.delete.disabled=true;this.add.disabled=true;this.clear.disabled=true;-->
<%
if(request.getParameter("id")!=null)
out.print("<input type=hidden name=id value="+request.getParameter("id")+" >");
%>
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td>IP</td>
    <td>地区</td>
    <td>拦截次数</td>
    <td></td>
  </tr>
   <%
java.util.Enumeration enumer=NodeAccessManage.findByCommunity(teasession._strCommunity);
while(enumer.hasMoreElements())
{
  String ip=(String)enumer.nextElement();
  NodeAccessManage nam=NodeAccessManage.find(teasession._strCommunity,ip);
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
    <td><%=ip%></td>
    <td><%=NodeAccessWhere.findByIp(nam.getIp().trim())%></td>
    <td><%=nam.getAccess()%></td>
    <td><input type="submit" name="delete" value="删除" onClick="if(confirm('确认?')){form1.ip.style.color='#FFFFFF'; form1.ip.value='<%=nam.getIp()%>';  }else return false;"/></td>
</tr>
<%}%>
</table>

   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
      <td>IP:</td>
      <td><input type="text" name="ip" /></td>
      </tr>
      <tr><td></td>
            <td>
            <input type="submit" name="add" value="提交" onClick="return submitText(form1.ip,'无效IP')"/>
            </td>
      </tr>
</table>



<h2>清空统计</h2>
<input type="submit" name="clear" value="清空" onClick="return confirm('确认清空统计?');" />




<%--

<h2>月统计流量控制</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>添加:</td><td><input type=text name="monthadd" ></td></tr>
</table>
<input type="submit" name="hot" value="提交" />

--%>
</form>

<div id="head6"><img height="6" src="about:blank"></div>
</html>



