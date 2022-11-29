<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

int node=h.getInt("node");
Node n=Node.find(node);

Reserve t=null;
String subject=null,content=null,picture=null;
if(n.getType()==1)
{
  t=new Reserve(0,h.language);
}else
{
  subject=n.getSubject(h.language);
  content=n.getText(h.language);
  picture=n.getPicture(h.language);

  t=Reserve.find(h.node,h.language);
}



%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑——自然保护区</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/Reserves.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node" value="<%=node%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl","")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">名称：</td>
    <td><input name="subject" value="<%=MT.f(subject)%>" size="30"/></td>
  </tr>
  <tr>
    <td class="th">编号：</td>
    <td><input name="code" value="<%=MT.f(t.code)%>"/></td>
  </tr>
  <tr>
    <td class="th">级别：</td>
    <td><select name="level"><%=h.options(Reserve.LEVEL_TYPE,t.level)%></select></td>
  </tr>
  <tr>
    <td class="th">类型：</td>
    <td><select name="type"><%=h.options(Reserve.RESERVE_TYPE,t.type)%></select></td>
  </tr>
  <tr>
    <td class="th">所属部门：</td>
    <td><select name="dept"><%=h.options(Reserve.DEPT_TYPE,t.dept)%></select></td>
  </tr>
  <tr>
    <td class="th">地区：</td>
    <td><script>mt.city('city',null,null,"<%=t.city%>")</script></td>
  </tr>
  <tr>
    <td class="th">行政区域：</td>
    <td><input name="adminarea" value="<%=MT.f(t.adminarea)%>" size="40"/></td>
  </tr>
  <tr>
    <td class="th">主要保护对象：</td>
    <td><textarea name="protect" cols="60" rows="5" ><%=MT.f(t.protect)%></textarea></td>
  </tr>
  <tr>
    <td class="th">总面积：</td>
    <td><input name="area" value="<%=t.area==0?"":MT.f(t.area)%>" mask="float"/>公顷</td>
  </tr>
  <tr>
    <td class="th">批建时间：</td>
    <td><input name="years" value="<%=MT.f(t.years)%>" mask="int"/>年</td>
  </tr>
  <tr>
    <td class="th">图片：</td>
    <td><input type="file" name="picture"/>
      <%
      if(picture!=null)out.print("　<input type='checkbox' name='clear' id='clear' onclick='form1.picture.disabled=checked'><label for='clear'>清空</label>　<a href=javascript:mt.img('"+picture+"')>查看</a>");
      %>
    </td>
  </tr>
  <tr style="display:none">
    <td class="th">经度：</td>
    <td><input name="longitude" value="<%=t.longitude==0?"":String.valueOf(t.longitude)%>" mask="float"/></td>
  </tr>
  <tr style="display:none">
    <td class="th">纬度：</td>
    <td><input name="latitude" value="<%=t.latitude==0?"":String.valueOf(t.latitude)%>" mask="float"/></td>
  </tr>
  <tr>
        <td class="th">地图：</td>
        <td><input type=text   size=50 class="edit_input" value="<%=t.map %>"  name="map" readonly="readonly">
        <input type="button" value="标点" onClick="mt.show('/jsp/admin/map/BeditMap.jsp',2,'标点',600,450);"/>
          <!-- <input type="button" value="标点" onClick="window.open('/jsp/admin/map/EditGMap.jsp?field=form1.map','_blank','width=600,height=500');"/> -->
        </td>
      </tr>
  <tr>
    <td class="th">内容：</td>
    <td><textarea name="content" cols="60" rows="5" ><%=MT.f(content)%></textarea></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();
mt.value=function(a){
	form1.map.value=a;
}
</script>
</body>
</html>
