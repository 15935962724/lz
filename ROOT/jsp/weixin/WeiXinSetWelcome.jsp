<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.weixin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

WeiXin t=WeiXin.find(h.community);

int menu=h.getInt("id");
int wxtype=h.getInt("wxtype");


%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<link href="/tea/image/weixin/style.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1><%=AdminFunction.find(menu).getName(h.language)%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form2" action="/WeiXins.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="this.welcome.value=flag?ids:this.textarea.value; return mt.check(this)&&mt.show(null,0)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="act" value="welcome"/>
<input type="hidden" name="wxtype" value="<%=wxtype%>"/>
<input type="hidden" name="welcome" value="<%=MT.f(t.welcome[wxtype])%>"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl","")%>"/>

<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
  <tr>
    <td>欢迎语/被添加自动回复</td>
    <td>
     <div class="tools"><a href="###" onclick="mt.tab(this);flag=false;return false;" name="a_w">文字</a><a href="###" onclick="mt.tab(this);flag=true;return false;" name="a_w" title="图文">图文</a></div>
     <div name="w" class="tab-word"><textarea id="textarea"></textarea></div>
     <div name="w" class="tab-image">
       <div id="wtype1"></div>
       <input type="button" class="addBtn" value="添加" onclick="mt.show('/jsp/node/NodeSel.jsp?atype=<%=h.getInt("atype")%>&articles='+ids,'',0,500)"/>
     </div>
    </td>
    <td></td>
  </tr>
  <tr>
    <td>未找到/消息自动回复</td>
    <td><textarea name="notfound" rows="5" cols="50"><%=MT.f(t.notfound)%></textarea></td>
    <td></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>
mt.focus();
mt.del=function(a)
{
  ids=ids.replace('|'+a.id+'|','|');
  a=mt.ftr(a);a.parentNode.removeChild(a);
};

var flag=form2.welcome.value.charAt(0)=='|',ids=flag?form2.welcome.value:'|';
form2.textarea.value=flag?'您好，欢迎关注我们，后续有精彩内容会第一时间发给您。':form2.welcome.value;

$name('a_w')[flag?1:0].click();
mt.receive=function(a)
{
  ids+=a.substr(1);
  mt.send('/Nodes.do?act=appmsg&nodes='+ids,function(d){$$('wtype1').innerHTML=d;});
};
mt.receive("");
</script>
</body>
</html>
