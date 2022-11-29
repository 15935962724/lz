<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%@ page import="tea.entity.admin.sales.*" %>

<%
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

String community=teasession._strCommunity;
String names  = teasession.getParameter("names");
if(names==null)
		names="";

String clienttype=request.getParameter("clienttype");
String client=request.getParameter("client");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function f_click(c,ct)
{
  window.opener.document.<%=clienttype%>.value=ct;
  var op=window.opener.document.<%=client%>.options;
  if(ct)//客户
  {
    for(var i=op.length-1;i>=0;i--)
    {
      if(op[i].value==c)
      {
        op[i].selected=true;
        break;
      }
    }
  }else
  {
    for(var i=0;i<op.length;i++)
    {
      if(op[i].value==c)
      {
        op[i].selected=true;
        break;
      }
    }
  }
  window.close();
}
</script>
</head>
<body>

<h1>客户查找</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<br>
<form name=form1 METHOD=get  action="/jsp/admin/sales/clientserver.jsp" >
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
		<td nowrap>搜索:&nbsp;&nbsp;<input type="text" name="names" value="<%=names %>">&nbsp;&nbsp;<input type="submit" value=" 查 询 "></td>
	</tr>
</table>
</FORM>
<br>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

<tr id="tableonetr">
    <td nowrap>客户名称 </td>
	<td nowrap>所有人别名</td>
	<td nowrap>类型</td>
</tr>
	<%
		java.util.Enumeration lame = Latency.findByCommunity(teasession._strCommunity," and (family like "+DbAdapter.cite("%"+names+"%")+" or firsts like "+DbAdapter.cite("%"+names+"%")+")");
		while(lame.hasMoreElements())
		{
			int laid = ((Integer)lame.nextElement()).intValue();
			Latency laobj = Latency.find(laid);
	%>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
	 <td nowrap><a href="javascript:f_click(<%=laid%>,false);" ><%=laobj.getFamily()+laobj.getFirsts() %></a></td>
	<td nowrap><%=laobj.getMember() %></td>
	<td nowrap>潜在客户</td>
</tr>
<%
		}

		java.util.Enumeration wome = Workproject.find(teasession._strCommunity," and name like "+DbAdapter.cite("%"+names+"%")+"",0,10);
		while(wome.hasMoreElements())
		{
			int woid = ((Integer)wome.nextElement()).intValue();
			Workproject woobj = Workproject.find(woid);
%>

  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
	 <td nowrap><a href="javascript:f_click(<%=woid%>,true);" ><%=woobj.getName(teasession._nLanguage) %></a></td>
	<td nowrap><%=woobj.getMember()%></td>
	<td nowrap>客户</td>
</tr>
<%
		}
%>
</table>
</body>
</html>



