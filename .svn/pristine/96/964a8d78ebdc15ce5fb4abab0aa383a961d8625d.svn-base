<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.node.*" %><%@ page  import="tea.entity.bbs.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_act(act,id)
{
  if(act=='del'&&!confirm('确认删除'))return;
  if(act!='edit')form1.method='post';
  form1.act.value=act;
  form1.nexturl.value=location;
  form1.bbslevel.value=id;
  form1.action='/jsp/type/bbs/EditBBSLevel.jsp';
  form1.submit();
}
</script>
</head>
<body>

<h1>论坛等级管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<form name=form1 action="?">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="id" value="<%=request.getParameter("id")%>"/>
<input type=hidden name="act" >
<input type=hidden name="bbslevel" value="0">
<input type=hidden name="nexturl" >


<h2>列表</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap width="1">&nbsp;</td>
    <TD>名称</TD>
    <TD>积分下限</TD>
    <TD>图示</TD>
    <TD>&nbsp;</TD>
  </tr>
<%
java.util.Enumeration e=BBSLevel.find(" AND community=" + DbAdapter.cite(teasession._strCommunity)+" ORDER BY point",0,Integer.MAX_VALUE);
for(int index=1;e.hasMoreElements();index++)
{
  BBSLevel bt=(BBSLevel)e.nextElement();
  int id=bt.getBbslevel();
  %>
  <tr onMouseOver=bgColor='#FFFFCA' onMouseOut=bgColor=''>
    <td width="1"><%=index%></td>
    <td ><%=bt.getName()%></td>
    <td ><%=bt.getPoint()%></td>
    <td ><img alt="" src="<%=bt.getPicture()%>"/></td>
    <td>
      <input type=button value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onClick="f_act('edit','<%=id%>');">
      <input type=button value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onClick="f_act('del','<%=id%>');">
    </td>
 </tr>
<%
}
%>
</table>
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBNew")%>" onClick="f_act('edit',0);">
<input type="button" value="<%=r.getString(teasession._nLanguage,"恢复默认")%>" onClick="f_act('def',0);">
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
