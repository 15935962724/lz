<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.io.*"%><%@page import="java.util.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.site.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

Html t=Html.find(h.community);
int act=h.getInt("act");

//if(act>0)
//{
//  if(act==4)// 显示进度条
//  out.print("parent.mt.progress("+t.value+","+t.sum+");");
//  else if(act==5)//删除缓存
//  {
//    Filex.delete(new File(t.getPath(h.community)));
//    out.print("<script>parent.mt.show('缓存删除完成！');</script>");
//  }else if(act==6)//修改设置
//  {
//    t.day=h.getInt("day");
//    t.hour=h.getInt("hour");
//    t.minute=h.getInt("minute");
//
//    String tmp=h.get("nodes").replaceAll(",+","|");
//    if(!tmp.startsWith("|"))tmp="|"+tmp;
//    if(!tmp.endsWith("|"))tmp+="|";
//    t.nodes=tmp;
//
////    t.path=h.get("path");
////    if(t.path.length()>0)
////    {
////      File f=new File(t.path);
////      f.mkdirs();
////      if(!f.canWrite())
////      {
////        out.print("<script>parent.mt.show('“缓存位置”不正确！');</script>");
////        return;
////      }
////      t.path=t.path.replace('\\','/');
////      if(!t.path.endsWith("/"))t.path+="/";
////    }
//    t.set();
//    out.print("<script>parent.mt.show('数据提交成功！');</script>");
//  }else //生成缓存
//  t.make(act);
//
//  return;
//}




int menuid=h.getInt("id");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>刷新缓存设置</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="act" />
<input type="hidden" name="id" value="<%=menuid%>"/>

<table id="tablecenter">
  <tr>
    <td>全部页面</td>
    <td><input name="day" value="<%=MT.f(t.day)%>" mask="int"/>天/次 <a href="javascript:f_act(1)">立即</a></td>
  </tr>
  <tr>
    <td>部分页面</td>
    <td><input name="hour" value="<%=MT.f(t.hour)%>" mask="int"/>小时/次 <a href="javascript:f_act(2)">立即</a></td>
  </tr>
  <tr>
    <td>当天更新的页面</td>
    <td><input name="minute" value="<%=MT.f(t.minute)%>" mask="int"/>分钟/次 <a href="javascript:f_act(3)">立即</a></td>
  </tr>
  <tr>
    <td>附加页面</td>
    <td><input name="nodes" value="<%=MT.f(t.nodes.substring(1).replace('|',','))%>"/>例：123,456,</td>
  </tr>
  <tr>
    <td>缓存位置</td>
    <td><!--<input name="path" value="<%=MT.f(t.path)%>" size="40"/>不建议填写<br/>默认位置：--><%=t.getPath(h.community)%></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交" onclick="f_act(6)"/> <input type="button" value="返回" onclick="history.back();"/>

<br/>
<br/>
<input type="submit" value="删除缓存" onclick="f_act(5,'删除缓存中...')"/>
</form>

<script>
var inter;
function f_act(i,info)
{
  mt.show(info,0);
  form1.act.value=i;
  if(i>4)//关掉 生成静态页 的进度条
  {
    clearInterval(mt.inter);
    return;
  }
  if(i!=4)form1.submit();
  mt.progress('?id=<%=menuid%>&community=<%=h.community%>&act=4');
}
<%
//if(t.sum>t.value)out.print("f_act(4,'静态页面生成中...');");
%>
</script>
</body>
</html>
