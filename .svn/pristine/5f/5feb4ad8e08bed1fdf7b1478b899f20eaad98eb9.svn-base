<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"%> <%@ page import="tea.resource.Resource"%><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

String nexturl=request.getParameter("nexturl");
int flowtopinion=Integer.parseInt(request.getParameter("flowtopinion"));
Flowtopinion ft=Flowtopinion.find(flowtopinion);
if("POST".equals(request.getMethod()))
{
  String content=request.getParameter("content");
  if(content==null)
  {
    ft.delete();
  }else
  {
    int type=Integer.parseInt(request.getParameter("type"));
    if(flowtopinion<1)
    {
      Flowtopinion.create(teasession._strCommunity,type,teasession._rv._strV,content);
    }else
    {
      ft.set(type,content);
    }
  }
  response.sendRedirect(nexturl);
  return;
}
int type=ft.getType();
String content=ft.getContent();

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function f_act(url,flow)
{
  if(url)
  {
    form1.action=url;
  }
  form1.flow.value=flow;
  form1.submit();
}
</script>
</head>
<body onload="form1.content.focus();">

<h1>意见管理</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="post" onsubmit="return submitText(this.content,'无效-内容');">
<input type=hidden name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="flowtopinion" value="<%=flowtopinion%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
   <td>类别</td>
   <td>
     <select name="type">
     <%
     for(int i=0;i<Flowtopinion.OPTINION_TYPE.length;i++)
     {
       out.print("<option value="+i);
       if(i==type)
       out.println(" selected='true' ");
       out.println(" >"+Flowtopinion.OPTINION_TYPE[i]);
     }
     %></select>
   </td>
  </tr>
  <tr>
    <td>内容</td>
    <td><textarea name="content" cols="50" rows="5"><%if(content!=null)out.print(content);%></textarea></td>
  </tr>
</table>
<input type="submit" value="确定"/>
<input type="button" value="取消" onclick="window.open('<%=nexturl%>','_self');" />
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</HTML>
