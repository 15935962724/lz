<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int attrib=h.getInt("attrib");
int category=h.getInt("category");
ShopAttrib t=ShopAttrib.find(attrib);


%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑</h1>

<form name="form1" action="/ShopAttribs.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="attrib" value="<%=attrib%>"/>
<input type="hidden" name="category" value="<%=category%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td width="150px">类型</td>
    <td><%=h.radios(ShopAttrib.TYPE_NAME,"type",t.type)%></td>
  </tr>
  <tr>
    <td>英文名称</td>
    <td><input name="name0" value="<%=MT.f(t.name[0])%>"/></td>
  </tr>
  <tr>
    <td>中文名称</td>
    <td><input name="name1" value="<%=MT.f(t.name[1])%>"/></td>
  </tr>
  <tbody id="tcontent">
  <tr>
    <td>英文内容</td>
    <td><input name="content0" value="<%=MT.f(t.content[0])%>" size="50"/> 用“|”分隔</td>
  </tr>
  <tr>
    <td>中文内容</td>
    <td><input name="content1" value="<%=MT.f(t.content[1])%>" size="50"/></td>
  </tr>
  </tbody>
  <tr>
    <td>选项</td>
    <td><input name="need" type="checkbox" value="1" id="need_1" <%if(t.need)out.print(" checked='checked' ");%>/><label for="need_1">必填</label>
      <input name="query" type="checkbox" value="1" id="query_1" <%if(t.query)out.print(" checked='checked' ");%>/><label for="query_1">查询</label>
      </td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>
mt.focus(form1);
var t=form1.type;
for(var i=0;i<t.length;i++)
t[i].onclick=function()
{
  var a=[form1.query.nextSibling,form1.query,$('tcontent')];
  for(var j=0;j<a.length;j++)a[j].style.display=parseInt(this.value)>1?'':'none';
}
t[<%=t.type%>].onclick();
</script>

</body>
</html>
