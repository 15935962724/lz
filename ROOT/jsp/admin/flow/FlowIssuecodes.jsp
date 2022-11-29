<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"%> <%@ page import="tea.resource.Resource"%><%@ page import="tea.entity.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Http h=new Http(request);
if("POST".equals(request.getMethod()))
{
  String act=h.get("act");
  String code=h.get("code");
  if("edit".equals(act))
  {
    FlowIssuecode.create(teasession._strCommunity,code,h.getInt("sequence"));
  }else if("del".equals(act))
  {
    FlowIssuecode fsc=new FlowIssuecode(teasession._strCommunity,code);
    fsc.delete();
  }
  //return;
}
String mid=h.get("id");

Resource r=new Resource();

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>

<h1>发文代号</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>列表</h2>
<form name="form1" action="?" method="POST">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=mid%>"/>
<input type="hidden" name="act" value="del"/>
<input type="hidden" name="code"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap>序号</td>
    <td nowrap>名称</td>
    <td nowrap>&nbsp;</td>
  </tr>
<%
java.util.Enumeration enumer=FlowIssuecode.find(" AND community="+DbAdapter.cite(teasession._strCommunity),0,100);
for(int i=1;enumer.hasMoreElements();i++)
{
  FlowIssuecode t=(FlowIssuecode)enumer.nextElement();
%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td align="center"><%=i%></td>
  <td nowrap><%=t.name%></td>
  <td align="center" nowrap>
    <input type="button" value="删除" onClick="if(confirm('确定删除?')){ form1.code.value='<%=t.name%>'; form1.submit(); }" />
  </td>
</tr>
<%
}
%>
</table>
</form>

<form name="form2" action="?" method="POST" onsubmit="return mt.check(this)">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=mid%>"/>
<input type="hidden" name="act" value="edit"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>名称:</td><td><input type="text" name="code" value="" alt="名称"/></td></tr>
<tr><td>顺序:</td><td><input type="text" name="sequence" value="" mask="int"/></td></tr>
</table>
<input type="submit" value="<%=r.getString(teasession._nLanguage,"CBNew")%>">
</form>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</HTML>
