<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String key=h.get("lmsleave","");
LmsLeave t=LmsLeave.find(key.length()<1?0:Integer.parseInt(MT.dec(key)));

String mkey=h.get("member");
Profile p=Profile.find(mkey.length()<1?0:Integer.parseInt(MT.dec(mkey)));
LmsOrg lo=LmsOrg.find(p.getAgent());


%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>退学申请</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form2" action="/LmsLeaves.do?repository=leave" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="if(mt.check(this)){mt.show(null,0);up.complete();}return false;">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmsleave" value="<%=key%>"/>
<input type="hidden" name="member" value="<%=mkey%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0" class="alignLeft">
  <tr>
    <th>省助学发展机构：</th>
    <td><%=MT.f(LmsOrg.find(lo.father).orgname)%></td>
    <th>学习中心：</th>
    <td><%=MT.f(lo.orgname)%></td>
  </tr>
  <tr>
    <th>申请人：</th>
    <td><%=p.getName(h.language)%></td>
    <th>学号：</th>
    <td><%=p.getMember()%></td>
  </tr>
  <tr>
    <th>证件号：</th>
    <td><%=p.getCard()%></td>
    <th>准考证号：</th>
    <td><%=MT.f(p.getCardnumber())%></td>
  </tr>
  <tr>
    <th><em>*</em>退学申请表：</th>
    <td colspan="3"><input type="hidden" name="attch" /><input class="file0" alt="退学申请表" readonly /><input type="button" id="_attch" value="浏览..." class="file1"/>　<span class="info">注：请扫描上传盖章文件</span></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>
mt.focus();
var up=new Upload($$('_attch'),{buttonAction:-100,uploadURL:"/Attchs.do?repository=leave"});
up.uploadSuccess=function(f,d)
{
  eval("d="+d.substring(d.indexOf('\n')+1));
  this.but.previousSibling.previousSibling.value=d.attch;
};
up.complete=function()
{
  file=this.getFile();
  if(file)
  {
    this.start();
    return;
  }
  form2.submit();
};
</script>
</body>
</html>
