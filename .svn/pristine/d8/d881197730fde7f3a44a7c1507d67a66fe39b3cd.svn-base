<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="java.io.*"%>
<%@page import="tea.entity.site.*"%><%

Http h=new Http(request,response);

int menuid=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&community="+h.community+"&id="+menuid);

final String name=h.get("name","");
final Date t0=h.getDate("t0"),t1=h.getDate("t1");
File[] fs=new File(application.getRealPath("/res/"+h.community+"/structure/")).listFiles(new FileFilter()
{
  public boolean accept(File f)
  {
    return (f.getName().indexOf(name)!=-1)&&(t0==null||f.lastModified()>t0.getTime())&&(t1==null||f.lastModified()<t1.getTime());
  }
});

int pos=h.getInt("pos");
par.append("&pos=");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<style>
.tbn{border:1px solid #CCCCCC; width:100px; height:100px;overflow: hidden;text-align:center}
.tbn img{max-width:100px;max-height:100px; width:expression(this.offsetWidth>100?'100px':true);}
</style>
</head>
<body>
<h1>结构图片管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>名称:<input name="name" value="<%=name%>"/></td>
  <td>时间:<input name="t0" value="<%=MT.f(t0)%>" onclick="new Calendar().show('form1.t0')" size="10"/> - <input name="t1" value="<%=MT.f(t1)%>" onclick="new Calendar().show('form1.t1')" size="10"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=fs.length%></h2>
<form name="form2" action="/Structures.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="name"/>
<input type="hidden" name="act"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>缩略图</td>
  <td>名称</td>
  <td>大小</td>
  <td>时间</td>
  <td>操作</td>
</tr>
<%
if(fs.length<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  for(int i=pos;i<Math.min(pos+10,fs.length);i++)
  {
    String n=fs[i].getName(),p="/res/"+h.community+"/structure/"+n;
  %>
  <tr>
    <td><%=i+1%></td>
    <td><a class="tbn" href="###" onclick="mt.img('<%=p%>')"><img src="<%=p%>"/></a></td>
    <td><%=n%></td>
    <td><%=MT.f(fs[i].length()/1024F)%>K</td>
    <td><%=MT.f(new Date(fs[i].lastModified()),1)%></td>
    <td><input type="button" value="编辑" onclick="f_act('edit','<%=n%>')"/> <input type="button" value="删除" onclick="f_act('del','<%=n%>')"/></td>
  </tr>
  <%}
  if(fs.length>10)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, fs.length,10));
}%>
</table>
<br/>
<input type="button" value="添加" onclick="f_act('edit','')"/>
</form>

<script>
//var imgs=document.images;
//if(imgs)
//for(var i=1;i<imgs.length;i++)
//{
//  var w=imgs[i].width,h=imgs[i].height;
//  if(w<100&&h<100)continue;
//  if(w>h)imgs[i].width=100;else imgs[i].height=100;
//}

form2.nexturl.value=location.pathname+location.search;
function f_act(a,n,b)
{
  form2.act.value=a;
  form2.name.value=n;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='edit')
  {
    window.open('/jsp/site/StructureUpload.jsp?name='+encodeURIComponent(n),'_blank','width=580px,height=380px');
  }
}
</script>
</body>
</html>
