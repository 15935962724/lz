<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.resource.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.db.*" %><%@ page import="tea.ui.*" %>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

//String nexturl=request.getParameter("nexturl");
String nexturl=request.getRequestURL().toString();
String email=request.getParameter("email");

Resource r=new Resource();

CommunityOption co=CommunityOption.find(teasession._strCommunity);
String nodes[]=co.get("subnode").split("/");


String semail="";
String snode="";
if(teasession._rv!=null)
 {Profile profile=Profile.find(teasession._rv._strV);
 semail=profile.getEmail();
 snode=Subscibe.find(teasession._strCommunity,semail).getNode();

}


Subscibe obj=Subscibe.find(teasession._strCommunity,email);
String ns=obj.getNode();
String v=request.getParameter("v");
if(v!=null)
{
  if(!obj.isExists())
  {
    response.sendRedirect("/jsp/info/Alert.jsp?community=" + teasession._strCommunity + "&info="+java.net.URLEncoder.encode("此用户不存在,或已经退订...","UTF-8"));
    return;
  }
  if(Long.parseLong(v)!=obj.getTimes().getTime()*email.length())
  {
    response.sendRedirect("/jsp/info/Alert.jsp?community=" + teasession._strCommunity + "&info=error");
    return;
  }
}
Community community=Community.find(teasession._strCommunity);


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body onload="try{ form_subscibe.email.focus(); }catch(e){}">

<script src="<%=community.getJspBeforePath(teasession._nLanguage)%>"></script>

<h1><%=r.getString(teasession._nLanguage, "管理订阅项")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form_subscibe" method="post" action="/servlet/Subscibes" TARGET="form_subscibe_iframe" onSubmit="return submitEmail(this.email,'无效邮件地址');" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="act" value="edit"/>
<iframe name="form_subscibe_iframe" id="form_subscibe_iframe" src="about:blank" style="display:none"></iframe>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
int j=1;
for(int i=1;i<nodes.length;i++)
{String ischecked="";
  int node=Integer.parseInt(nodes[i]);
  Node n=Node.find(node);
  if(n.getTime()==null)
  {
    j++;
    continue;
  }
  if((i-j)%5==0)
  {
    out.print("<tr>");
  }

  if(snode.indexOf("/"+nodes[i]+"/")>=0)
  ischecked="checked";
  out.print("<td><input name='nodes' "+ischecked+" type='checkbox' value='"+node+"' id='"+i+"'");
  if(ns.indexOf("/"+node+"/")!=-1)
  {
    out.print(" checked ");
  }
  out.print(" /><label for='"+i+"'>"+n.getSubject(teasession._nLanguage)+"</label>");
}
%>
</table>
<br>
<%
//从"订阅邮件"中点出来编辑订阅项
if(v!=null)
{
  out.print("<input type='hidden' name='email' value='"+email+"' />");
  out.print("<input type='submit' value='保存订阅项' />");
}else
{  
%>
E-Mail:<input type="text" name="email" value="<%if(semail!=null && semail.length()>0)out.print(semail); %>" size="80">
  <input type="submit" value="订阅杂志" >
  <input type="button" value="返回" onclick="history.back();" >
<%
}
%>
</form>

<div id="head6"><img height="6" src="about:blank"></div>

<script src="<%=community.getJspAfterPath(teasession._nLanguage)%>"></script>
</body>
</html>
