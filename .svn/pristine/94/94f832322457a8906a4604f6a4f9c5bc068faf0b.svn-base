<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %><%@page import="tea.ui.*"%><%@page import="tea.entity.im.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

String act=request.getParameter("act");
int id=Integer.parseInt(request.getParameter("id"));
String list=request.getParameter("list");
if(request.getMethod().equals("POST"))
{
  String member=teasession._rv._strV;
  if("message".equals(act))
  {
    Message obj=Message.find(id);
    if(request.getParameter("deletemessage")!=null)
    {
      obj.setFolder(member,5);
    }else if(request.getParameter("reader")!=null)
    {
      obj.setReader(member);
    }
  }else if("immessage".equals(act))
  {
    ImMessage obj=ImMessage.find(id);
    obj.setReader();
  }
  out.print("<script>window.close();</script>");
  return;
}

%><HTML>
<HEAD>
<title>短信息提醒</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</HEAD>
<body>
<div id="reminderdiglog">
<FORM name=form1 METHOD=post action="?" onSubmit="">
  <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
  <input type=hidden name="id" value="<%=id%>"/>
  <input type=hidden name="act" value="<%=act%>"/>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
if("message".equals(act))
{
  int index=0;
  String arr[]=list.split("/");
  for(int i=1;i<arr.length;i++)
  {
    if(Integer.parseInt(arr[i])==id)
    {
      index=i;
      break;
    }
  }
  out.print("<tr><td colspan='2' align='right'>共"+(arr.length-1)+"条 当前第"+index+"条");
  if(arr.length>1)
  {
    if(index>1)
    out.print("　<a href='?community="+teasession._strCommunity+"&act="+act+"&id="+arr[index-1]+"&list="+list+"'>上一条</a>");
    if(index<arr.length-1)
    out.print("　<a href='?community="+teasession._strCommunity+"&act="+act+"&id="+arr[index+1]+"&list="+list+"'>下一条</a>");
  }

  Message obj=Message.find(id);
  String subject=obj.getSubject(teasession._nLanguage);
  if(subject.length()>20)
  {
    subject=subject.substring(0,17)+"...";
  }
  String url=obj.getUrl();
  if(url==null||url.length()==0)
  {
    url="/jsp/message/Message.jsp?folder=0&message="+id;
  }

  Profile p=Profile.find(obj.getFMember());
  %>
    <tr>
      <td nowrap>发件人:</td><td><%=p.getName(teasession._nLanguage)%> ( <%=obj.getTimeToString()%> )</td>
    </tr>
    <tr>
      <td nowrap>主题:</td><td><%=subject%></td>
    </tr>
    <tr>
    <td></td>
      <td align="center">
        <input type="submit" value="关闭">
        <input type="submit" name="reader" value="阅读" onclick="window.open('<%=url%>');"/>
        <!--<input type="submit" name="deletemessage" value="删除短信" />-->
      </td>
    </tr>
<%}else
///////////////////////////////////////////////////////////////
if("immessage".equals(act))
{
  ImMessage obj=ImMessage.find(id);
  String content=obj.getContent();
  Profile p=Profile.find(obj.getFMember());
  %>
    <tr>
      <td nowrap>发件人:</td><td><%=p.getName(teasession._nLanguage)%> ( <%=obj.getTimeToString()%> )</td>
    </tr>
    <tr>
      <td nowrap>内容:</td><td><%=content%></td>
    </tr>
    <tr>
    <td></td>
      <td align="center">
        <input type="submit" value="关闭">
      </td>
    </tr>
<%
}
%>
</table>
</form>
</div>
</body>
</html>
