<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"  %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*"%><%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/Other");

CommunityOption obj=CommunityOption.find(teasession._strCommunity);
int smslen=obj.getInt("smslen");
if(smslen==0)smslen=60;
String smssuffix=obj.get("smssuffix");
if(smssuffix==null)smssuffix="";
String smstype=obj.get("smstype");
//
String smsuser=obj.get("smsuser");
String smspwd=obj.get("smspwd");
//
String masip=obj.get("masip");
String masid=obj.get("masid");
String masuser=obj.get("masuser");
String maspwd=obj.get("maspwd");
String masdb=obj.get("masdb");
//
String cfuser=obj.get("cfuser");
String cfpwd=obj.get("cfpwd");
//
String triouser=obj.get("triouser");
String triopwd=obj.get("triopwd");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function f_submit()
{
  var j;
  for(var i=0;i<form1.smstype.length;i++)
  {
    if(form1.smstype[i].checked)
    {
      j=i;
      break;
    }
  }
  form1.name.value="/smslen/smssuffix/smstype"+form1.smstype[j].getAttribute("field");
  if(form1.smssuffix[1].style.display=="")
  {
    form1.smssuffix[0].value=form1.smssuffix[1].value;
  }
}
function f_suffix(v,init)
{
  var os=form1.smssuffix[0].options;
  if(init)
  {
    form1.smssuffix[0].value=v;
    if(form1.smssuffix[0].selectedIndex==-1)
    {
      os[os.length-1].selected=true;
      form1.smssuffix[1].value=v;
    }
  }
  form1.smssuffix[1].style.display=(os[os.length-1].selected?"":"none");
}
var old;
function f_load(v)
{
  if(old)
  {
    old.style.display="none";
  }
  old=document.getElementById(v);
  if(old)
  {
    old.style.display="";
  }
  for(var i=0;i<form1.smstype.length;i++)
  {
    if(form1.smstype[i].value==v)
    {
      form1.smstype[i].checked=true;
      break;
    }
  }
}
</script>
</head>
<body onload="f_load('<%=smstype%>');f_suffix('<%=smssuffix%>',true);">
<h1><%=r.getString(teasession._nLanguage, "短信通")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditCommunityOption" method="post" target="_ajax" onsubmit="return f_submit();">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="name" />

<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage,"短信字数")%></td>
    <td><input name="smslen" value="<%=smslen%>" mask="int"/></td>
    <td>每条短信的长度.</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"短信后缀")%></td>
    <td>
      <select name="smssuffix" onchange="f_suffix(value)">
      <option value="">-----------</option>
      <option value="1">发送者姓名</option>
      <option value="">自定义</option>
      </select>
      <input name="smssuffix" value="" style="display:none"/>
    </td>
    <td>跟在每条短信的后面的字符.</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"接口类型")%></td>
    <td colspan="2"><input name="smstype" type="radio" onclick="f_load(value)" field="/" value="" checked="true">不使用
    　　<input name="smstype" type="radio" onclick="f_load(value)" field="/smsuser/smspwd/" value="netarc">网路百科
    　　<input name="smstype" type="radio" onclick="f_load(value)" field="/masip/masid/masuser/maspwd/masdb/" value="mas">移动代理服务器MAS
    　　<input name="smstype" type="radio" onclick="f_load(value)" field="/cfuser/cfpwd/" value="chufa">触发短信
    　　<input name="smstype" type="radio" onclick="f_load(value)" field="/triouser/triopwd/" value="trio">Trio Mobile
    </td>
  </tr>
</table>

<div id="netarc" style="display:none">
<h2><%=r.getString(teasession._nLanguage, "网路百科http://www.jxtsms.com/")%></h2>
<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage,"帐号")%></td>
    <td><input name="smsuser" value="<%if(smsuser!=null)out.print(smsuser);%>"></td>
    <td>短信通登陆帐号</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"密码")%></td>
    <td><input name="smspwd" value="<%if(smspwd!=null)out.print(smspwd);%>"></td>
    <td>短信通安全操作码</td>
  </tr>
</table>
</div>


<div id="mas" style="display:none">
<h2><%=r.getString(teasession._nLanguage, "移动代理服务器MAS")%></h2>
<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage,"IP地址")%></td>
    <td><input name="masip" value="<%if(masip!=null)out.print(masip);%>"></td>
    <td>IP地址</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"接口编码")%></td>
    <td><input name="masid" value="<%if(masid!=null)out.print(masid);%>"></td>
      <td>接口的编码标识符，任意英文字母及数字组成，不能重复。</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"帐号")%></td>
    <td><input name="masuser" value="<%if(masuser!=null)out.print(masuser);%>"></td>
    <td>对应DB接口建立数据库连接的用户名，或API接口init函数的loginName参数。</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"密码")%></td>
    <td><input name="maspwd" value="<%if(maspwd!=null)out.print(maspwd);%>"></td>
    <td>对应DB接口建立数据库连接的用户密码，或API接口init函数的loginPWD参数。</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"数据库名")%></td>
    <td><input name="masdb" value="<%if(masdb!=null)out.print(masdb);%>"></td>
    <td>数据库名</td>
  </tr>
</table>
</div>


<div id="chufa" style="display:none">
<h2><%=r.getString(teasession._nLanguage, "触发短信 http://60.28.200.132/chufaceshi/")%></h2>
<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage,"帐号")%></td>
    <td><input name="cfuser" value="<%if(cfuser!=null)out.print(cfuser);%>"></td>
    <td>不支持群发！ 发送号：10657558025812775</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"密码")%></td>
    <td><input name="cfpwd" value="<%if(cfpwd!=null)out.print(cfpwd);%>"></td>
  </tr>
</table>
</div>


<div id="trio" style="display:none">
<h2>Trio Mobile　　http://websms.trio-mobile.com</h2>
<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage,"帐号")%></td>
    <td><input name="triouser" value="<%if(triouser!=null)out.print(triouser);%>"></td>
    <td>发送号：0085294667899</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"密码")%></td>
    <td><input name="triopwd" value="<%if(triopwd!=null)out.print(triopwd);%>"></td>
  </tr>
</table>
</div>

<input type="submit" class="edit_input" value="<%=r.getString(teasession._nLanguage,"Submit")%>">

</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
