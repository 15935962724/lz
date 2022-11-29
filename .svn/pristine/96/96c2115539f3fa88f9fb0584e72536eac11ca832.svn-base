<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.io.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Resource r=new Resource("/tea/resource/userpriv");

String member=request.getParameter("member");
if(member==null)
{
  member=teasession._rv._strV;
}

String act=request.getParameter("act");

ProfileBBS obj=ProfileBBS.find(teasession._strCommunity,member);
if("POST".equals(request.getMethod()))
{
  String serialnum=request.getParameter("serialnum");
  obj.setSerialNum(serialnum);
  response.sendRedirect("/jsp/info/Succeed.jsp");
  return;
}

String serialnum=obj.getSerialNum();


%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

<script>
//var key=new Key();
function f_ref()
{
  //key.getSerialNum(form1.serialnum);
  var obj = form1.serialnum;
  var key=document.getElementById("key");
  document.body.appendChild(key);
  var sn=null;

    try
    {
      var hCard=key.OpenDevice(1);//打开设备
      sn=key.GetSerialNum(hCard);//
      key.CloseDevice(hCard);
     
    }catch(e)
    {
    }
    if(obj)
    {
      if(sn)
      {
        obj.value=sn;
      }else
      {
        alert('出现错误: 没有找到Key.');
      }
    }
   // return sn;
}
</script>
</head>
<body>
<OBJECT id=key name=key classid=clsid:FB4EE423-43A4-4AA9-BDE9-4335A6D3C74E codebase=/tea/applet/key/HTActX.cab#version=1,0,0,1 style=display:none></OBJECT>

<h1><%=r.getString(teasession._nLanguage, "Key安全设置")%></h1>
<div id="head6"><img  height="6"></div>
<br>

<form name="form1" action="?" method="post" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="member" value="<%=member%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter" >
<tr>
   <td>设备序号:</td>
   <td><input name="serialnum" type="text" size="30" value="<%if(serialnum!=null)out.print(serialnum);%>"><input type="button" value="刷" onClick="f_ref()"></td>
</tr>
</table>
<input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>" >
<input type="button" value="<%=r.getString(teasession._nLanguage, "关闭")%>" onClick="window.close();" >
</form>
 
<br>
<!--
<a href="/tea/applet/key/HaiKeyRuntime.exe">下载KEY驱动</a>
-->
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</HTML>
