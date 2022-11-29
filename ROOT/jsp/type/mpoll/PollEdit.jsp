<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.node.type.mpoll.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?nexturl=" + Http.enc(request.getRequestURI() + "?" + request.getQueryString()));
  return;
}

int poll=h.getInt("poll");
Poll t=Poll.find(poll);


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
#filter4,#filter5,#filter6,#filter7{display:none}
</style>
</head>
<body>
<h1>添加/编辑——投票</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/MPolls.do" method="post" enctype="multipart/form-data" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="poll" value="<%=poll%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td rowspan="2">标题</td>
    <td>中文</td>
    <td><input name="name1" value="<%=MT.f(t.name[1])%>" size="30" alt="标题"/></td>
  </tr>
  <tr>
    <td>英文</td>
    <td><input name="name0" value="<%=MT.f(t.name[0])%>" size="30"/></td>
  </tr>
  <tr>
    <td rowspan="2">说明</td>
    <td>中文</td>
    <td>
      <textarea name="content1" style="display:none" rows="12" cols="90"><%=MT.f(t.content[1])%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content1&Toolbar=MySetting" width="600" height="200" frameborder="no"></iframe>
    </td>
  </tr>
  <tr>
    <td>英文</td>
    <td>
      <textarea name="content0" style="display:none" rows="12" cols="90"><%=MT.f(t.content[0])%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content0&Toolbar=MySetting" width="600" height="200" frameborder="no"></iframe>
    </td>
  </tr>
  <tr>
    <td></td>
    <td>过滤机制</td>
    <td><%=h.radios(Poll.FILTER_TYPE,"filter",t.filter)%><select name="question"><option value=''>--<%=Question.options(t.poll,t.question)%></select></td>
  </tr>
  <tr>
    <td></td>
    <td>验证码显示<br></td>
    <td><input name="captcha" type="radio" value="1" id="captcha_1" checked="checked"/><label for="captcha_1">使用</label>　<input name="captcha" type="radio" value="0" id="captcha_0" <%if(!t.captcha)out.print(" checked='checked' ");%>/><label for="captcha_0">不使用</label></td>
  </tr>
  <tr>
    <td rowspan="2">结束条件</td>
    <td>结束时间</td>
    <td><input name="etime" value="<%=MT.f(t.etime)%>" onClick="mt.date(this)"/></td>
  </tr>
  <tr>
    <td>允许收集</td>
    <td><input name="elimit" value="<%=MT.f(t.elimit)%>" size="4" mask="int"/>个数据后自动关闭调查表</td>
  </tr>
  <tr>
    <td colspan="2">合格分数线</td>
    <td><input name="score" value="<%=MT.f(t.score)%>" mask="int"/></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onClick="history.back();"/>
</form>

<script>
mt.focus();
var arr=form1.filter;
for(var i=0;i<arr.length;i++)
{
  arr[i].onchange=function()
  {
    form1.question.setAttribute('alt',this.value==8?'过滤机制':'');
  };
}
arr[<%=t.filter%>].onchange();
</script>
</body>
</html>
