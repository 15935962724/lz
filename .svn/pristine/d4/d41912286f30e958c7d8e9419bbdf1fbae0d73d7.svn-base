<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.service.SendEmaily" %>
<%request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
//集佳可以游客发信
//if(teasession._rv==null)
//{
//  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
//  return;
//}

tea.resource.Resource r=new tea.resource.Resource();

//此周期内默认选中
CommunityOption co=CommunityOption.find(teasession._strCommunity);
String nodes[]=co.get("subnode").split("/");
int subday=co.getInt("subday");
if(subday==0)subday=1;
Calendar ca=Calendar.getInstance();
ca.add(Calendar.DAY_OF_YEAR,-subday);
Date time=ca.getTime();

%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<style type="text/css">
div
{
padding-left:20px;
}
</style>
<script type="">
function f_ex(obj)
{
  var d=obj.parentNode;
  while(d.tagName!="DIV")
  {
    d=d.nextSibling;
  }
  if(obj.src.indexOf("plus")!=-1)
  {
    obj.old=obj.src;
    obj.src="/tea/image/tree/tree_blank.gif";
    d.style.display="";
  }else
  {
    obj.src=obj.old;
    d.style.display="none";
  }
}
function f_se(obj)
{
  var d=obj.nextSibling.nextSibling.nextSibling;
  var is=d.getElementsByTagName("INPUT");
  for(var i=0;i<is.length;i++)
  {
    is[i].checked=obj.checked;
  }
}
function f_pa(obj)
{
  if(obj.checked)
  {
    var d=obj.parentNode;
    while(d.tagName!="INPUT")
    {
      d=d.previousSibling;
    }
    d.checked=true;
  }
}
function f_tb()
{
  if(form1.type[0].checked)
  {
    tb0.style.display="";
    tb1.style.display="none";
  }else
  {
    tb0.style.display="none";
    tb1.style.display="";
  }
}
function f_submit()
{
  if(document.getElementById("email1").value == ""){
    alert("必须填写发送地址!");
    return false;
  }
  if(document.getElementById("email1").value != ""){
    str=/^\s*([A-Za-z0-9_\-]+(\.\w+)*@(\w+\.)+\w{2,3})\s*$/;
    var v1 = document.getElementById("email1").value;
    if(str.test(v1)){}
    else
    {
        alert('您的email格式不正确');
        return false;
    }
  }
    if(document.getElementById("email2").value != ""){
    str=/^\s*([A-Za-z0-9_\-]+(\.\w+)*@(\w+\.)+\w{2,3})\s*$/;
    var v2 = document.getElementById("email2").value;
    if(str.test(v2)){}
    else
    {
        alert('您的email格式不正确');
        return false;
    }
  }
  if(document.getElementById("email3").value != ""){
    str=/^\s*([A-Za-z0-9_\-]+(\.\w+)*@(\w+\.)+\w{2,3})\s*$/;
    var v3 = document.getElementById("email3").value;
    if(str.test(v3)){}
    else
    {
        alert('您的email格式不正确');
        return false;
    }
  }
  if(form1.type[0].checked)
  {
    for(var i=0;i<form1.nodes.length;i++)
    {
      if(form1.nodes[i].checked)
      {
        var f=form1.nodes[i].parentNode.nextSibling;
        f.value=f.value+form1.nodes[i].value+"/";
      }
    }
  }else
  {
    return submitText(form1.url,"网址不能为空...");
  }
  return true;
}
</script>
</head>
<body>
<h1>发送</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name="form1" action="/servlet/Subscibes2" method="POST" onsubmit="return f_submit();">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="act" value="send"/>

<table cellSpacing="0" cellPadding="0" width="100%"  border="0" id="tablecenter">
<!--
<tr>
<td align="right">发送类型:</td>
<td>
  <input type="radio" name="type" value="0" onclick="f_tb()" id="t0" checked="checked"/><label for="t0">网页列表</label>
  <input type="radio" name="type" value="1"  id="t1" checked="checked" onclick="f_tb()"/><label for="t1">网页内容</label>
</td>
</tr>
-->
<!--
<tbody id="tb0">
<tr>
<td>
  <td>
<%
//for(int z=1;z<nodes.length;z++)
//{
//  int father=Integer.parseInt(nodes[z]);
//  Node f=Node.find(father);
//  if(f.getTime()==null)
//  {
//    continue;
//  }
//  boolean fsel=false;
//  StringBuilder h=new StringBuilder();
//  DbAdapter db=new DbAdapter();
//  try
//  {
//    db.executeQuery("SELECT n.node FROM Node n WHERE n.father="+father+" AND hidden=0 ORDER BY n.node DESC",0,200);
//    for(int i=0;db.next();i++)
//    {
//      int node=db.getInt(1);
//      Node obj=Node.find(node);
//      boolean nsel=time.compareTo(obj.getTime())==-1;
//      if(i>20&&!nsel)
//      {
//        break;
//      }
//      h.append("<input type='checkbox' name='nodes' onclick='f_pa(this);' value='"+node+"'");
//      if(nsel)
//      {
//        fsel=true;
//        h.append(" checked='true'");
//      }
//      h.append(">");
//      h.append("<a href=/servlet/Node?node="+node+" target=_blank>"+obj.getSubject(teasession._nLanguage)+"</A>");
//      h.append(" ["+obj.getTimeToString()+"]<br>");
//    }
//  }finally
//  {
//    db.close();
//  }
//  if(h.length()>0)
//  {
//    out.print("<a href='###'><img src='/tea/image/tree/tree_plus.gif' onclick='f_ex(this)'></a>");
//    //else
//    //out.print("<img src='/tea/image/tree/tree_blank.gif'>");
//    out.print("<input type='checkbox' name='fathers' onClick='f_se(this);' value='"+father+"'");
//    if(fsel)
//    {
//      out.print(" checked='true'");
//    }
//    out.print(">");
//    out.print(f.getSubject(teasession._nLanguage)+"<br>");
//    out.print("<div style='display:none'>");
//    out.print(h.toString());
//    out.print("</div>");
//    out.print("<input type='hidden' name='f"+father+"' value='/' />");
//  }
//}
String tuijian = null;//集佳推荐好友
if(request.getParameter("tuijian") != null){
  tuijian = request.getParameter("tuijian");
}
//获取域名http://www.unitalen.com.cn/
String www = request.getServerName();
%>
<tr><td><td><input type="checkbox" onClick="selectAll(form1.fathers,checked);selectAll(form1.nodes,checked);"><%=r.getString(teasession._nLanguage,"SelectAll")%></td></tr>
</tbody>
-->
<tbody id="tb1" style="">
<tr>
  <td align="right">网址:</td>

  <td><input type="text" name="url" size="80" value="<%if(tuijian!=null){out.print("http://"+www+"/html/folder/"+tuijian+"-1.htm");}%>"/></td>
</tr>
</tbody>
<tr>
  <td align="right">主题:</td><td><input type="text" name="theme" size="40"/></td>
</tr>
<tr>
  <td align="right">您的姓名:</td><td><input type="text" name="uname" size="40"/></td>
</tr>
<!--
<tr>
  <td align="right">您的E-mail:</td><td><input type="text" name="uemail" size="80" style="color:#666" value=""/></td>
</tr>
-->
<tr>
  <td align="right">发送到:</td>
  <td><input type="text" name="email1" size="80" id="email1"/></td>
</tr>
<tr>
  <td align="right">发送到:</td>
  <td><input type="text" name="email2" size="80"/>（可选） </td>
</tr>
<tr>
  <td align="right">发送到:</td>
  <td><input type="text" name="email3" size="80"/>（可选） </td>
</tr>
<tr>
  <td align="right">内容:</td>
  <td>您还可以输入<span id="counter">125</span>个字<br><textarea name="contents" id="text" rows="5" cols="50" onkeydown='countChar("text","counter");' onkeyup='countChar("text","counter");'></textarea></td>
</tr>
<script language="javascript">
function countChar(textareaName,spanName)//统计剩余字数
         {
           if(document.getElementById(textareaName).value.length > 125){
             alert("对不起,您的字数已经超过125");
             document.getElementById(spanName).innerHTML = 0;
           }else{
             document.getElementById(spanName).innerHTML = 125 - document.getElementById(textareaName).value.length;
             t = document.getElementById(textareaName).value;
           }
         }
</script>
<!--tr id="check_emailid">
  <td align="right">只发送附加E-Mail:</td>
  <td><input type="checkbox"  id ="checkboxid" name="check_email" value="1" checked="checked"/></td>
</tr-->

<!--
<tr>
  <td align="right">附加E-Mail:</td>
  <td><textarea name="email" rows="5" cols="50"></textarea></td>
</tr>
-->
</table>
<input type="submit" value="<%=r.getString(teasession._nLanguage,"CBSend")%>"/>
</form>

<div id="head6"><img height="6" src="about:blank"></div>
</BODY>
</html>
