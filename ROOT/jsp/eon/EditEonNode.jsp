<%@page contentType="text/html;charset=UTF-8"%><%@page import="tea.entity.*"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.eon.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="java.io.*"%>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);

AccessMember am = AccessMember.find(teasession._nNode, teasession._rv);
if(am.getPurview()<1)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

String nexturl = request.getParameter("nexturl");

Resource r = new Resource();

EonNode en=EonNode.find(teasession._nNode);

String introduce=en.getIntroduce();

Node node =Node.find(teasession._nNode);

Http h=new Http(request,response);


%><html>
<head>
<title>设置节点联系信息</title>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function f_load()
{
  form1.introduce.focus();
  f_click();
}
function f_click()
{
  var bool=form1.extend.checked;
  form1.side[0].disabled=bool;
  form1.side[1].disabled=bool;
  form1.price.disabled=bool;
  form1.introduce.disabled=bool;
}
</script>
</head>
<body onLoad="f_load();">
<%=tea.ui.node.general.NodeServlet.getButton(node,h, am,request) %>
<h1>设置节点联系信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>

<form name="form1" action="/servlet/EditEonNode" method="post" onSubmit="return submitText(this.price, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-电话')">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<script>document.write("<input type=hidden name=nexturl value="+document.location+">");</script>
<input type=hidden name="act" value="edit"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>付费方</td>
    <td>
      <input type="radio" name="side" value="false" checked>服务方付费
      <input type="radio" name="side" value="true" <%if(en.isSide())out.print(" checked ");%> >被服务方付费
    </td>
  </tr>
  <tr>
    <td>通话费用</td>
    <td>
      <input type="text" name="price" value="<%=en.getPrice()%>">元/分钟
    </td>
  </tr>
  <tr>
    <td>付费说明</td>
    <td>
      <textarea name="introduce" cols="50" rows="5"><%if(introduce != null)out.print(introduce);%></textarea>
    </td>
  </tr>
  <tr>
    <td>选项</td>
    <td>
      <input type="checkbox" name="extend" value="true" onclick="f_click();" <%if(!en.isFather())out.print(" disabled ");else if(en.isExtend())out.print(" checked ");%> >继承父节点的联系信息
      <input type="checkbox" name="reg" value="true" <%if(en.isReg())out.print(" checked ");%>>必须是会员才可以拨打
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>
      <input type="submit" value="提交">
      <input type="submit" value="设置服务人" onClick="form1.nexturl.value='/jsp/eon/EonNodeMembers.jsp?community=<%=teasession._strCommunity%>&node=<%=teasession._nNode%>';">
      <!-- window.open('/jsp/eon/EonNodeMembers.jsp?community=<%=teasession._strCommunity%>&node=<%=teasession._nNode%>','','width=500,height=500,scrollbars=1'); -->
    </td>
  </tr>
</table>
</form>
<br>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
