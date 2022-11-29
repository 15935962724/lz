<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

int node=h.getInt("node");
Node n=Node.find(node);
Outside t;

String subject=null,content=null;
if(n.getType()==1)
{
  t=new Outside(0,h.language);
}else
{
  subject=n.getSubject(h.language);
  content=n.getText(h.language);

  t=Outside.find(h.node,h.language);
}

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑——校外机构</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/Outsides.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="node" value="<%=node%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl","")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>名称</td>
    <td><input name="subject" value="<%=MT.f(subject)%>" size="40" alt="名称"/></td>
  </tr>
  <tr>
    <td>内容</td>
    <td>
      <textarea name="content" cols="50" rows="5" style="display:none"><%=MT.f(content)%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=MySetting" width="530" height="250" frameborder="no" scrolling="no"></iframe>
    </td>
  </tr>
  <tr>
    <td>城市</td>
    <td><script>mt.city('city0','city1','city2','<%=MT.f(t.city)%>');</script></td>
  </tr>
  <tr>
    <td>详细地址</td>
    <td><input name="address" value="<%=MT.f(t.address)%>" size="40"/></td>
  </tr>
  <tr>
    <td>网址</td>
    <td><input name="website" value="<%=MT.f(t.website)%>"/></td>
  </tr>
  <tr>
    <td>电话</td>
    <td><input name="tel" value="<%=MT.f(t.tel)%>"/></td>
  </tr>
  <tr>
    <td>QQ</td>
    <td><input name="qq" value="<%=MT.f(t.qq)%>"/></td>
  </tr>
  <tr>
    <td>乘车路线</td>
    <td><input name="bus" value="<%=MT.f(t.bus)%>"/></td>
  </tr>
  <tr>
    <td>地图</td>
    <td><input name="map" value="<%=MT.f(t.map)%>" readonly="readonly"/> <input type="button" value="标点" onClick="window.open('/jsp/admin/map/EditGMap.jsp?field=form1.map&q='+encodeURIComponent(form1.subject.value),'_blank','width=800,height=500');"/></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>
mt.focus();
form1.city0.setAttribute("alt","省份");
</script>

</body>
</html>
