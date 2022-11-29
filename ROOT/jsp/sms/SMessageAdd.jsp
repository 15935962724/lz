<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.review.*"%><%

Http h=new Http(request,response);
TeaSession ts=new TeaSession(request);
if(ts._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node+"&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString()));
  return;
}



int sum=0;

StringBuilder to=new StringBuilder();

int member=h.getInt("member");
String members=member>0?"|"+member+"|":h.get("members","|");
members=members.substring(1).replace('|',',')+0;


Enumeration e=Profile.find(" AND mobile IS NOT NULL AND profile IN("+members+")",0,Integer.MAX_VALUE);
while(e.hasMoreElements())
{
  String mid=(String)e.nextElement();
  Profile p=Profile.find(mid);
  to.append("<span><input type='hidden' name='members' value='"+p.getProfile()+"'>"+mid+"<img onclick='mt.del(this)' src='/tea/image/d7.gif' /></span>");
}



int smessage=h.getInt("smessage");
//SMessage t=SMessage.find(smessage);

%><html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>发送短信</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/SMessages.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check1(this)">
<input type="hidden" name="smessage" value="<%=smessage%>"/>
<input type="hidden" name="act" value="add"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">接收者：</td>
    <td><div id="t_member" alt="<%=to.length()>0?"接收者":""%>"><%=to.toString()%></div> <input class="but" type="button" value="添加" onclick="mt.act('add')"/></td>
  </tr>
<%
if(to.length()<1)
{
%>
  <tr>
    <td class="th">手机号：</td>
    <td><textarea name="mobile" cols="20" rows="5"></textarea>每行一个手机号！</td>
  </tr>
<%
}%>
  <tr>
    <td class="th">内容：</td>
    <td><textarea name="content" cols="50" rows="5" alt="内容"></textarea><br/>还能输入<b id="count"></b>字</td>
  </tr>
</table>

<input class="but" type="submit" value="提交"/> <input class="but" type="button" value="返回" onclick="history.back();"/>
</form>

<script>
mt.focus();
mt.check1=function(f)
{
  if(f.mobile&&$('t_member').innerHTML==''&&f.mobile.value=='')
  {
    mt.show("“接收者”和“手机号”至少要填写一项！");
    return false;
  }
  return mt.check(f)&&mt.show(null,0);
};
mt.act=function(a)
{
  if(a=='add')
  {
    mt.show('/jsp/sms/MemberSel.jsp?field=mobile&type=2&tab=1&member='+mt.value(form1.members,'|')+'&contact='+mt.value(form1.contacts,'|'),2,'添加成员',500,400);
  }
};
mt.receive=function(a,b,c){$('t_member').innerHTML+=c;}
mt.del=function(p){p=p.parentNode;p.parentNode.removeChild(p);}

var t=form1.content;
t.oninput=t.onpropertychange=function()
{
  $("count").innerHTML=70-this.value.length;
};
t.oninput();
</script>
</body>
</html>
