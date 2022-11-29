<%@page contentType="text/html;charset=UTF-8" %><%@page import="org.json.*"%><%@page import="tea.entity.*"%><%@ page import="tea.entity.stat.*"%><%@ page import="tea.entity.site.*"%><% request.setCharacterEncoding("UTF-8");

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

Community obj=Community.find(h.community);

String[] val=(obj.tjbaidu+"||||| ").split("[|]");
String act=h.get("act");

%><!DOCTYPE html>
<html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script>
function fsel(i)
{
  var mt=parent.mt;
  mt.receive(i);
  mt.close();
}
mt.receive=function(i)
{
  form2.tjid.value=i;
};
</script>
</head>
<body>
<%
if("sel".equals(act))
{
  TJBaidu tj=new TJBaidu();
  String info=tj.login(val[1],val[2],val[3]);
  if(info!=null)
  {
    out.print(info);
    return;
  }
  JSONObject jo=tj.find("'method':'getSiteList'");
  if(jo==null)
  {
    out.print(tj.message);
    return;
  }
  out.print("<table id=tablecenter><tr id=tableonetr><td>&nbsp;</td><td>域名</td><td>时间</td><td nowrap>操作</td>");
  JSONArray ja=jo.getJSONArray("list");
  for(int i=0;i<ja.length();i++)
  {
    jo=ja.getJSONObject(i);
    int id=jo.getInt("site_id");
    out.print("<tr><td>"+id+"<td>"+jo.getString("domain")+"<td>"+jo.getString("create_time")+"<td><a href=javascript:fsel("+id+")>选择</a>");
  }
  out.print("</table>用户ID:"+tj.ucid+",剩余配额:"+tj.rquota+"次<script>mt.fit()</script>");
  return;
}
%>
<h1>统计设置</h1>
<div id="head6"><img height="6" alt=""></div>

<form name=form2 action="/Communitys.do?act=tjbaidu" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl"/>
<table id="tablecenter">
  <tr>
    <td nowrap>百度账号:</td>
    <td><input name="tjuser" value="<%=val[1]%>" size=40 maxlength=40></td>
  </tr>
  <tr>
    <td>百度密码:</td>
    <td><input type="password" name="tjpwd" value="<%=val[2]%>" size=40 maxlength=40></td>
  </tr>
  <tr>
    <td>百度令牌:</td>
    <td><input name="tjtoken" value="<%=val[3]%>" size=40 maxlength=40> 百度统计-->数据导出服务</td>
  </tr>
  <tr>
    <td>百度站点:</td>
    <td><input name="tjid" value="<%=val[4]%>" size=30> <input type="button" value="..." onclick="mt.show('/jsp/stat/StatEdit.jsp?act=sel',2,'站点选择',400)"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" value="提交"></td>
  </tr>
</table>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
</script>
</body>
</html>
