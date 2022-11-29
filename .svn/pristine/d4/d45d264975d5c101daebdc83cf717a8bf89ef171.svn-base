<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*"%><%@page import="tea.entity.*" %><%@page import="tea.entity.util.Caiji"%><% request.setCharacterEncoding("UTF-8");

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

int caiji=h.getInt("caiji");
Caiji c=Caiji.find(caiji>0?caiji:h.getInt("clone"));
if(c.caiji<1)
{
  c.repeat=1;
}
//HtmlElement.htmlToText()


%><!DOCTYPE html>
<html>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<body>
<h1><%=caiji<1?"添加":"编辑"%>采集信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form method="post" action="/Caijis.do" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="caiji" value="<%=caiji%>"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>
<input type="hidden" name="act" value="edit"/>

<table border="0" cellpadding="0" cellspacing="0"  id="tablecenter">
  <tr>
    <th colspan="2"><em>*</em>名称</th>
    <td><input name="name" size="60" value="<%=MT.f(c.name)%>" alt="采集名称"/></td>
  </tr>
  <tr>
    <th colspan="2"><em>*</em>新闻目录节点</th>
    <td><input name="father" value="<%=MT.f(c.father)%>" mask="int" alt="新闻目录节点"/></td>
  </tr>
<!--
  <tr>
    <td>网站编码</td>
    <td><input name="code" size="10"  value="<%=MT.f(c.code)%>"/></td>
  </tr>
-->
  <tr>
    <th colspan="2">采集数量</th>
    <td><input name="count" size="10" value="<%=MT.f(c.count)%>" mask="int" /> 不填就代表无限制</td>
  </tr>
  <tr>
    <th colspan="2"><em>*</em>采集站点连接</th>
    <td><input name="url" size="60"  value="<%=MT.f(c.url)%>" alt="站点连接"/>&#36;{page}表示分页</td>
  </tr>
<!--
  <tr>
    <td>图片保存路径</td>
    <td><input name="imgpath" size="51"  value="<%=MT.f(c.imgpath)%>"/></td>
  </tr>
-->
  <tr>
    <th rowspan="2"><em>*</em>列表</th>
    <th>开始</th>
    <td><textarea name="listbegin" ROWS="3" COLS="40" alt="列表开始"><%=MT.f(c.listbegin)%></textarea></td>
  </tr>
  <tr>
    <th>结束</th>
    <td><textarea name="listend" ROWS="3" COLS="40" alt="列表结束"><%=MT.f(c.listend)%></textarea></td>
  </tr>
<!--
  <tr>
    <td>连接开始</td>
    <td><textarea name="linkbegin" ROWS="3" COLS="40"><%=MT.f(c.linkbegin)%></TEXTAREA></td>
  </tr>
  <tr>
    <td>连接结束</td>
    <td><textarea name="linkend" ROWS="3" COLS="40"><%=MT.f(c.linkend)%></TEXTAREA></td>
  </tr>
-->
  <tr>
    <th rowspan="2">引题</th>
    <th>开始</th>
    <td><textarea name="kickerbegin" ROWS="3" COLS="40"><%=MT.f(c.kickerbegin)%></textarea></td>
  </tr>
  <tr>
    <th>结束</th>
    <td><textarea name="kickerend" ROWS="3" COLS="40"><%=MT.f(c.kickerend)%></textarea></td>
  </tr>
  <tr>
    <th rowspan="2"><em>*</em>标题</th>
    <th>开始</th>
    <td><textarea name="titlebegin" ROWS="3" COLS="40" alt="标题开始"><%=MT.f(c.titlebegin)%></textarea></td>
  </tr>
  <tr>
    <th>结束</th>
    <td><textarea name="titleend" ROWS="3" COLS="40" alt="标题结束"><%=MT.f(c.titleend)%></textarea></td>
  </tr>
  <tr>
    <th rowspan="2">副标题</th>
    <th>开始</th>
    <td><textarea name="subheadbegin" ROWS="3" COLS="40"><%=MT.f(c.subheadbegin)%></textarea></td>
  </tr>
  <tr>
    <th>结束</th>
    <td><textarea name="subheadend" ROWS="3" COLS="40"><%=MT.f(c.subheadend)%></textarea></td>
  </tr>
  <tr>
    <th rowspan="2">作者</th>
    <th>开始</th>
    <td><textarea name="authorbegin" ROWS="3" COLS="40"><%=MT.f(c.authorbegin)%></textarea></td>
  </tr>
  <tr>
    <th>结束</th>
    <td><textarea name="authorend" ROWS="3" COLS="40"><%=MT.f(c.authorend)%></textarea></td>
  </tr>
  <tr>
    <th rowspan="2">时间</th>
    <th>开始</th>
    <td><textarea name="timebegin" ROWS="3" COLS="40"><%=MT.f(c.timebegin)%></textarea></td>
  </tr>
  <tr>
    <th>结束</th>
    <td><textarea name="timeend" ROWS="3" COLS="40"><%=MT.f(c.timeend)%></textarea></td>
  </tr>
  <tr>
    <th rowspan="2">来源</th>
    <th>开始</th>
    <td><textarea name="sourcebegin" ROWS="3" COLS="40"><%=MT.f(c.sourcebegin)%></textarea></td>
  </tr>
  <tr>
    <th>结束</th>
    <td><textarea name="sourceend" ROWS="3" COLS="40"><%=MT.f(c.sourceend)%></textarea></td>
  </tr>
  <tr>
    <th rowspan="2"><em>*</em>正文</th>
    <th>开始</th>
    <td><textarea name="contentbegin" ROWS="3" COLS="40" alt="正文开始"><%=MT.f(c.contentbegin)%></textarea></td>
  </tr>
  <tr>
    <th>结束</th>
    <td><textarea name="contentend" ROWS="3" COLS="40" alt="正文结束"><%=MT.f(c.contentend)%></textarea></td>
  </tr>
  <tr>
    <th colspan="2">如果重复</th>
    <td><%=h.radios(Caiji.REPEAT_TYPE,"repeat",c.repeat)%></td>
  </tr>
</table>
<input type="submit" value="提交">
<input type="button" value="返回" onClick="history.back()"/>
</form>

</body>
</html>
