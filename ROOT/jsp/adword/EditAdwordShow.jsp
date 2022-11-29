<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int adword = Integer.parseInt(teasession.getParameter("adword"));

Adword obj = Adword.find(adword);
String adtitle=obj.getAdtitle();
String adexplain1=obj.getAdexplain1();
String adexplain2=obj.getAdexplain2();
String adshow=obj.getAdshow();
String adurl=obj.getAdurl();

int len=0;
if(obj.getAdpic()!=null&&obj.getAdpic().length()>0)
 len=(int)new java.io.File(application.getRealPath(obj.getAdpic())).length();

Resource r=new Resource();

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_change()
{
  var v=form1.adtitle.value;
  if(v.length==0)
    v="飞往火量的豪华旅游";
  else
    while(f_len(v)>25)
    {
      v=v.substring(0,v.length-1);
      form1.adtitle.value=v;
    }
  example1.innerHTML=v;

  v=form1.adexplain1.value;
  if(v.length==0)
    v="参观这一别具风格的红色星球。";
  else
    while(f_len(v)>35)
    {
      v=v.substring(0,v.length-1);
      form1.adexplain1.value=v;
    }
  example2.innerHTML=v;

  v=form1.adexplain2.value;
  if(v.length==0)
    v="失重的乐趣人皆可享!";
  else
    while(f_len(v)>35)
    {
      v=v.substring(0,v.length-1);
      form1.adexplain2.value=v;
    }
  example3.innerHTML=v;

  v=form1.adshow.value;
  if(v.length==0)
    v="www.example.com";
  else
    while(f_len(v)>35)
    {
      v=v.substring(0,v.length-1);
      form1.adshow.value=v;
    }
  example4.innerHTML=v;
}

function f_change2()
{
	f_change();
	if(form1.adurl.value.length==0)
	{
	  form1.adurl.value="http://"+form1.adshow.value;
	}
}

function f_change3()
{
  var obj=document.getElementById('example5');
  obj.width=obj.height="";
  obj.src=form1.adpic.value;
}

function f_len(s)
{
    var len=0;
	for (var i = 0; i < s.length; i++)
	{
		var c = s.charCodeAt(i);
		if (c >= 0 && c < 256)
			len++;
		else
			len=len+2;
	}
	return len;
}
</script>
</head>
<body onload="f_change();form1.adtitle.focus();">

为广告命名 > 目标客户 > <b>制作广告</b> > 选择关键字 > 定价 > 审核与保存
<div id="head6"><img height="6" src="about:blank"></div>
<br>


<form name="form1" action="/servlet/EditAdword" enctype="multipart/form-data" method=POST onsubmit="return submitText(this.adtitle,'无效-标题')&&submitText(this.adexplain1,'无效-说明第 1 行')&&submitText(this.adexplain2,'无效-说明第 2 行')&&submitText(this.adshow,'无效-显示的网址')&&submitText(this.adurl,'无效-目标网址');">
<input type=hidden name=community value="<%=teasession._strCommunity%>" >
<input type=hidden name=adword value="<%=adword%>" >
<input type=hidden name=act value=editadwordshow >
<input type=hidden name=nexturl value="/jsp/adword/EditAdwordKeywords.jsp">

<h2>短广告示例</h2>
<table cellpadding="3" width="260" style="border:1px solid #b4d0dc;" cellspacing="0" border="0" >
  <tr><td><img id=example5 onload="this.style.display='';if(this.height!=60||this.width!=200){if(this.src.indexOf('?edit')==-1)alert('大小必须是 200 X 60');this.width=200;this.height=60;}" onerror="this.style.display='none';" src="<%=obj.getAdpic()%>?edit"></td></tr>
  <tr>
    <td bgcolor="#ffffff" nowrap valign="bottom"><a href="http://www.example.com/" id="exampleUrl" target="google_popup" onclick="return HPU_helpPopUp(this, {target: &#39;google_popup&#39;, width: null, height: null})" ><font size="+0"><span id="example1"></span></font></a> <br>
      <span id="example2"></span> <br>
      <span id="example3"></span> <br>
      <font color="green" size="-1"><span id="example4"></span></font><br></td>
  </tr>
</table>
<br>

<h2>制作广告</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>标题：</td>
  <td><input maxlength="25" size="50" type=text name=adtitle value="<%if(adtitle!=null)out.print(adtitle);%>" onKeyUp="this.onchange();" onChange="f_change();"></td>
  <td>不能超过 25 个英文字符或 12 个中文字</td>
 </tr>
<tr>
  <td>说明第 1 行：</td>
  <td><input maxlength="35" size="50" type=text name=adexplain1 value="<%if(adexplain1!=null)out.print(adexplain1);%>" onKeyUp="this.onchange();" onChange="f_change();"></td>
  <td>不能超过 35 个英文字符或 17 个中文字</td>
 </tr>
<tr>
  <td>说明第 2 行：</td>
  <td><input maxlength="35" size="50" type=text name=adexplain2 value="<%if(adexplain2!=null)out.print(adexplain2);%>" onKeyUp="this.onchange();" onChange="f_change();"></td>
  <td>不能超过 35 个英文字符或 17 个中文字</td>
 </tr>
<tr>
  <td>显示的网址：</td>
  <td>http://<input maxlength="35" size="50" type=text name=adshow value="<%if(adshow!=null)out.print(adshow);%>" onKeyUp="f_change();" onChange="f_change2();"></td>
  <td> 不能超过 35 个字符</td>
 </tr>
<tr>
  <td>目标网址：</td>
  <td><input maxlength="300" size="50" type=text name=adurl value="<%if(adurl!=null)out.print(adurl);%>"></td>
  <td>不能超过 300 个字符</td>
 </tr>
 <tr>
  <td>图片广告：</td>
  <td><input size="40" type=file name=adpic onChange="f_change3();"> <%if(len>0)out.print("<a href=\"javascript:window.open('about:blank','','height=300,width=400,top=200,left=300,toolbar=no,menubar=no,scrollbars=no,location=no,status=no').document.write('<img src="+obj.getAdpic()+" onload=window.resizeTo(this.width+30,this.height+50) >');\" >"+len+r.getString(teasession._nLanguage,"Bytes")+"</a>");%></td>
  <td>大小必须是 200 X 60</td>
 </tr>
</table>

<input type="submit" value="<%=r.getString(teasession._nLanguage,"返回")%>" onclick="form1.nexturl.value='/jsp/adword/EditAdwordTarget.jsp'" >
<input type="submit" value="<%=r.getString(teasession._nLanguage,"继续")%>" >

</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

