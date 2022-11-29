<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.weixin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  out.print("<script>top.location='/servlet/StartLogin?bg=1&node="+h.node+"'</script>");
  return;
}

int rule=h.getInt("rule");
WxRule t=WxRule.find(rule);
if(t.wxrule<1)t.type=1;

%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<link href="/tea/image/weixin/style.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form2" action="/WxRules.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)&&mt.check2(this)">
<input type="hidden" name="rule" value="<%=rule%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="weixin" value="<%=h.getInt("weixin")%>"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>
<input type="hidden" name="type" value="<%=t.type%>"/>
<input type="hidden" name="content2" value="<%=t.content[2]%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>名称</td>
    <td><input name="name" value="<%=MT.f(t.name)%>" alt="名称"/></td>
  </tr>
  <tr>
    <td>关键字</td>
    <td>
      <input name="_keyword" /> <input type="button" value="添加" onclick="mt.add()"/>
      <div id="block"><%
      for(int i=0;i<t.keyword.length;i++)
      {
        if(t.keyword[i]==null)continue;
        out.print("<span><input type=hidden name=keyword value='"+t.keyword[i]+"' >"+t.keyword[i]+"<img src=/tea/image/d7.gif onclick=mt.fdel(this) /></span>");
      }
      %></div>
    </td>
  </tr>
  <tr>
    <td>内容</td>
    <td>
      <div class="tools"><a href="###" onclick="mt.tab(this);form2.type.value=1;return false;" name="a_w">文字</a><a href="###" onclick="mt.tab(this);form2.type.value=2;return false;" name="a_w" title="图文">图文</a></div>
      <div name="w" class="tab-word"><textarea name="content1" rows="8" cols="60"><%=MT.f(t.content[1])%></textarea></div>
      <div name="w" class="tab-image">
        <div id="wtype1"></div>
        <input type="button" class="addBtn" value="添加" onclick="mt.show('/jsp/node/NodeSel.jsp?atype=<%=h.getInt("atype")%>&nodes='+form2.content2.value,'',0,500)"/>
      </div>
    </td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>
mt.focus();
mt.check2=function(frm)
{
  if(!frm.keyword)
  {
    mt.show('“关键字”不能为空！');
    return false;
  }
};
mt.add=function()
{
  var d=form2._keyword;
  if(!d.value)return;
  $$('block').innerHTML+="<span><input type=hidden name=keyword value='"+d.value+"'>"+d.value+"<img src=/tea/image/d7.gif onclick=mt.fdel(this) /></span>";
  d.value="";
};
mt.del=function(a)
{
  var b=form2.content2;
  b.value=b.value.replace('|'+a.id+'|','|');
  a=mt.ftr(a);
  a.parentNode.removeChild(a);
};
$name('a_w')[<%=t.type%>-1].click();
mt.receive=function(a)
{
  a=form2.content2.value+a.substr(1);
  if(a.split('|').length-2>10)
  {
    alert('最多10条！');
    return false;
  }
  form2.content2.value=a;
  mt.send('/Nodes.do?act=appmsg&nodes='+a,function(d){$$('wtype1').innerHTML=d;});
};
mt.receive("");
</script>
</body>
</html>
