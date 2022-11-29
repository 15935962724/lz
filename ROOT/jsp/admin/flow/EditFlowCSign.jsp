<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.node.*" %><%@page import="java.io.*" %><%@page import="java.util.*" %><%@page import="tea.html.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.admin.*" %><%@page import="java.math.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");
Http h=new Http(request);


TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


String member=teasession._rv._strV;
int flowbusiness=h.getInt("flowbusiness");
int dynamictype=h.getInt("dynamictype");


DynamicCsign dc = DynamicCsign.find(-flowbusiness,dynamictype,member);

if("POST".equals(request.getMethod()))
{
  Date starttime = h.getDate("csignstarttime");
  if(starttime==null)starttime=new Date();
  int comment = Integer.parseInt(teasession.getParameter("csigncomment" ));
  String sign = teasession.getParameter("csignsign" );
  if(sign==null)sign=dc.getSign();
  Date endtime = h.getDate("csignendtime");
  if(endtime==null)endtime=new Date();
  String content = teasession.getParameter("csigncontent" );
  dc.set(starttime, null, comment, content, sign, endtime);
  out.println("<script>window.returnValue=true; window.close();</script>");
  return;
}

Resource r=new Resource("/tea/resource/Dynamic");

int comment=dc.getComment();
String content=dc.getContent();
String endtime=dc.getEndTimeToString();
if(endtime.length()<1)endtime=MT.f(new Date(),3);


DynamicType dt=DynamicType.find(dynamictype);


%><html>
<head>
<title><%=dt.getName(teasession._nLanguage)%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script LANGUAGE=JAVASCRIPT src="/tea/applet/key/key.js" type="text/javascript"></script>
<style type="text/css">
<!--
body
{
 margin-left: 0px;
 margin-top: 0px;
 margin-right: 0px;
 margin-bottom: 0px;
 border:0px;
 background-color:menu;
}
-->
</style>
<script>

var opener=opener?opener:dialogArguments;
function f_showarea(obj)
{
  obj.checked=true;
  var tr=document.getElementById("trcsigncontent");
  if(obj.value=="2")
  {
    tr.style.display="";
    window.dialogHeight="200px";
    form1.csigncontent.focus();
  }else
  {
    tr.style.display="none";
    window.dialogHeight="175px";
  }
}
function f_submit()
{
  var t=form1.csignsign;
  if(t&&t.value=='')
  {
    alert("必须“签字”才能提交！");
    return false;
  }
}
function f_load()
{
  f_showarea(form1.csigncomment);
}
</script>
</head>
<body onLoad="f_load()" class="Pop_up">
<form name="form1" action="?" method="post" onSubmit="return f_submit();">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="flowbusiness" value="<%=flowbusiness%>"/>
<input type="hidden" name="dynamictype" value="<%=dynamictype%>"/>
<input type="hidden" name="repository" value="flow">
<table class="Sign">
<tr class="Date">
<td>送签时间：<input name='csignstarttime' type='text' value="<%=dc.getStartTimeToString()%>" readonly='true' /></td>
<td>签出日期：<input name='csignendtime' type='text' onclick_='showCalendar(this,true)' value="<%=endtime%>" readonly='true' /></td>
</tr>
<tr>
<td colspan="2" class="Signature">
<table class="Views">
<tr><td class="Radio"><input type="hidden" name="csigncomment" value="2"/>
<%--
for (int j = 0; j < DynamicCsign.COMMENT_TYPE.length; j++)
{
  out.print("<input type=radio name='csigncomment" +   "' value='" + j + "' onclick='f_showarea(this)' id='csigncomment" +  "_" + j + "'");
  if (j ==comment)
  {
    out.print(" checked='true'");
  }
  out.println("><label for='csigncomment" +   "_" + j + "'>" + DynamicCsign.COMMENT_TYPE[j] + "</label>");
}
--%>
</td><td colspan='2'>
<div class=Simulation_textarea ><textarea class='con' name='csigncontent' cols='60' rows='5'><%if(content!=null)out.print(content);%></textarea>
<div class=Signature>
<%
ProfileBBS pb = ProfileBBS.find(teasession._strCommunity, teasession._rv._strV);
String isign = MT.f(pb.getISign(teasession._nLanguage), teasession._rv._strV);
String sn=pb.getSerialNum();
//
String csign=MT.f(dc.getSign());
if(csign.length()>0)
  out.print(csign.startsWith("/res/")?"<img src='"+csign+"' oncontextmenu='return false'>":"<span style='font-size:24px'>"+csign+"</span>");
else
{
  out.print("<input type='hidden' name='csignsign'><span style='font-size:24px'><img src='about:blank' style='display:none' onload=style.display=''; oncontextmenu='return false'></span><input type='button' name=dynamictype_button value='签字' onclick=\"if(confirm('确认签字?')){");
//  if (isign == null || isign.length() == 0)
//  {
//    out.print("alert('您还没有上传你的签名.')");
//  } else
  {
    out.print("var key=new Key(); if(key.check('"+sn+"')){ var ps=previousSibling; ps.previousSibling.value='" + isign + "'; style.display='none'; ps."+(isign.startsWith("/res/")?"firstChild.src":"innerHTML")+"='"+isign+"'; }");
  }
  out.print("} \"/>");
}
%></div></div>
</td></tr></table>
</td>
</tr>

<tr id='trcsigncontent' style='display:'>
  <td colspan='2'></td></tr>
</table>

<input type="submit" value=" 确 定 "/>
<input type="button" value=" 取 消 " onClick="window.close();"/>
</form>

</body>
</html>
