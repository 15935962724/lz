<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*" %><%@page import="tea.entity.site.*" %><%@page import="java.io.*" %><%@page import="java.util.*" %><%@page import="tea.html.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.admin.*" %><%@page import="java.math.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String member=teasession._rv._strV;

//加为私用意见
String act=request.getParameter("act");
if("template".equals(act))
{
  String info="添加成功!!!";
  String content=request.getParameter("content");
  if(Flowtopinion.find(teasession._strCommunity," AND type=1 AND member="+DbAdapter.cite(member)+" AND content LIKE "+DbAdapter.cite(content)).hasMoreElements())
  {
    info="已存在,不能重复添加.";
  }else
  {
    Flowtopinion.create(teasession._strCommunity,1,member,content);
  }
  out.print("<script>alert('"+info+"');</script>");
  return;
}

String dtw=teasession.getParameter("dtw");
int flowbusiness=Integer.parseInt(request.getParameter("flowbusiness"));
//int dt[][]={{20,21,22},{23,24,25},{28,29,30},//发文
//{55,56,57},{60,61,62},{65,66,67},{70,71,72}//收文
//};
int[] dt=Arrayx.parseInt(dtw.substring(1,dtw.length()-1).split("/"));

ProfileBBS pb = ProfileBBS.find(teasession._strCommunity, member);
if("POST".equals(request.getMethod()))
{
  out.print("<script> var doc=dialogArguments.document;");
  for(int i=0;i<dt.length;i++)
  {
    String v=request.getParameter("dynamictype"+dt[i]);
    if(v==null)continue;
    DynamicValue dv = DynamicValue.find(-flowbusiness, teasession._nLanguage, dt[i]);
    DynamicType d=DynamicType.find(dt[i]);
    if(d.getFather()>0)
    {
      dv.setMulti(-1, member, v);
    }else
    {
      dv.set(v);
    }
    out.print("obj=doc.all('dynamictype"+dt[i]+"'); if(obj)obj.value=\""+v.replaceAll("\"","&quot;").replaceAll("\r\n","\\\\r\\\\n")+"\";");
  }
  out.println("window.returnValue=true;window.close();</script>");
  return;
}

Resource r=new Resource("/tea/resource/Dynamic");
String isign =MT.f(pb.getISign(teasession._nLanguage),member);

String time=MT.f(new Date(),3);

//内容,签字,时间
%><html>
<head>
<title>填写意见</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script LANGUAGE=JAVASCRIPT src="/tea/tea.js" type="text/javascript"></script>
<script LANGUAGE=JAVASCRIPT src="/tea/applet/key/key.js" type="text/javascript"></script>
<style type="text/css">
body
{
 margin-left: 0px;
 margin-top: 0px;
 margin-right: 0px;
 margin-bottom: 0px;
 border:0px;
 background-color:menu;
}
</style>
<script>
function f_template(t)
{
  var ta=document.getElementsByTagName('TEXTAREA')[0];
  if(ta.value=="")
  {
    alert("内容不能为空!!!");
    return;
  }
  form2.content.value=ta.value;
  form2.submit();
}
function f_load()
{
  var ta=document.getElementsByTagName('TEXTAREA')[0];
//  if(ta.value=="")
//  {
//    f_key(form1.key[0]);
//  }
  ta.focus();
}
function f_sel(t)
{
  var v=window.showModalDialog('/jsp/admin/flow/SelFlowtopinions.jsp?community='+form1.community.value+'&type='+t+'&t='+new Date().getTime(),self,'dialogWidth:400px;dialogHeight:500px;resizable:1;help:0;status:0;');
  if(v)
  {
    var ta=document.getElementsByTagName('TEXTAREA')[0];
    ta.value=v;
    ta.focus();
  }
}
function f_lock()
{
  var ta=document.getElementsByTagName('TEXTAREA')[0];
  ta.parentNode.style.backgroundColor=ta.style.backgroundColor="";
  ta.onfocus=null;
  ta.focus();
}
function f_close()
{
  var nl=form1.elements;
  for(var i=0;i<nl.length;i++)
  {
    if(nl[i].value!=nl[i].defaultValue)
    {
      return "内容已修改,确定“不保存”,就关闭吗?";
    }
  }
}
</script>
</head>
<body onLoad="f_load()" onbeforeunload="return f_close();" class="Pop_up">
<form name="form1" action="?" method="post" onsubmit="f_close=function(){};">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="flowbusiness" value="<%=flowbusiness%>">
<input type="hidden" name="dtw" value="<%=dtw%>">

<table class="Views">
<%
StringBuffer sb=new StringBuffer();
String v[]=new String[3];
for(int j=0;j<v.length;j++)
{
  DynamicType d=DynamicType.find(dt[j]);
  if(d.isNeed())
    sb.append("&&submitText(form1.dynamictype"+dt[j]+",'“"+d.getName(teasession._nLanguage)+"”不能为空！')");

  DynamicValue dv = DynamicValue.find(-flowbusiness, teasession._nLanguage, dt[j]);
  if(d.getFather()>0)
  {
    Enumeration e=dv.findMulti(" AND member="+DbAdapter.cite(member),0,1);
    if(e.hasMoreElements())
    {
      DynamicValue.Multi m = (DynamicValue.Multi) e.nextElement();
      v[j] = m.getValue();
    }
  }else if(dv.isExists())
  {
    v[j]=dv.getValue();
  }
}
if(!MT.f(v[1]).equals(MT.f(isign)))//签名不相同，清空信息~
  v[0]=v[1]=v[2]="";

out.print("<tr><td colspan='2'><div class=Simulation_textarea ><textarea class='con' name='dynamictype"+dt[0]+"' cols='60' rows='8'>"+MT.f(v[0])+"</textarea><div class=Signature>");
if(v[1]!=null&&v[1].length()>0)
{
  out.print("<input type='hidden' name='dynamictype"+dt[1]+"' value='"+v[1]+"'><img src='"+v[1]+"' oncontextmenu='return false' />");
}else
{
  out.print("<input type='hidden' name='dynamictype"+dt[1]+"'><span style='font-size:24px'><img id=img"+dt[1]+" src='about:blank' style='display:none' onload=style.display=''; oncontextmenu='return false'></span><input type='button' name=dynamictype_button"+dt[1]+" value='签字' onclick=\"if(confirm('确认签字?')){");
//  if (isign == null || isign.length() == 0)
//  {
//    out.print("alert('您还没有上传你的签名.')");
//  } else
  {
    out.print("var key=new Key(); if(key.check('"+pb.getSerialNum()+"')){ var ps=previousSibling; ps.previousSibling.value='" + isign + "'; style.display='none'; ps."+(isign.startsWith("/res/")?"firstChild.src":"innerHTML")+"='"+isign+"'; }");
  }
  out.print(" }\" />");
}
out.print("</div></div></td></tr><tr><td class='Date'><input name='dynamictype"+dt[2]+"' type='text' onclick='showCalendar(this,true)' readonly='true' size=25 value=\""+MT.f(v[2],time)+"\" />");
%>
</table>
<!--
<input type="button" value="公用意见" onClick="f_sel(0)"/>
<input type="button" value="私用意见" onClick="f_lock()"/>
-->
<!--
<input type="button" value="加为私用意见" onClick="f_template()"/>
-->
<input type="submit" value=" 确 定 " onclick="return true<%=sb.toString()%>;" />
<input type="button" value=" 取 消 " onClick="window.close();"/>
</form>

<!--加为私用意见-->
<form name="form2" action="?" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="act" value="template"/>
<textarea name="content" style="display:none"></textarea>
</form>

</body></html>
