<%@ page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.io.*" %><%@page import="tea.resource.*" %>
<%@page import="javax.servlet.ServletConfig" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="java.util.*"%><%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.htmlx.*"%><%@page import="tea.html.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
Node   node=Node.find(teasession._nNode);
long i = node.getOptions();
boolean flag = (i & 0x8000) != 0;
if(teasession._rv == null && !flag)
{
  response.sendRedirect("/servlet/StartLogin");
  return;
}
boolean flag1 = node.isCreator(teasession._rv);

Resource r = new Resource();
r.add("/tea/ui/node/talkback/TalkbackServlet");
int l = Integer.parseInt(request.getParameter("talkback"));
Talkback talkback = Talkback.find(l);
RV rv = talkback.getCreator();
String dat=talkback.getTimeToString();
talkback.getStatus();
int hint=talkback.getHint();
String subject=talkback.getSubject(teasession._nLanguage);
String creator=rv._strR;
if (creator==""||creator.length()==32)
creator="匿名";
String content=talkback.getContent(teasession._nLanguage);
int j = talkback.findNext();
int k = talkback.findPrev();



%>


<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<body>
<h1> </h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="PathDiv"><%=node.getAncestor(teasession._nLanguage,"top")%></div>

<h2>发表的信息</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<TR><TD><%=r.getString(teasession._nLanguage, "Poster")%>:</TD><TD><%=creator%></TD></TR>
<TR><TD><%=r.getString(teasession._nLanguage, "Time")%>:</TD><TD><%=dat%></TD></TR>
<TR><TD><%=r.getString(teasession._nLanguage, "Subject")%>:</TD><TD>
<span id="imgid"></span><IMG BORDER=0 SRC="/tea/image/hint/<%=hint%>.gif"></span><%=subject%></TD>
</TR>
<tr><td>内容：</td><td><%=content%></td></tr>
</TABLE>

  <%/*
              String picturefile1 =getServletContext().getRealPath("/tea/image/talkback/"+i+".jpg");
            File file1=new File(picturefile1);
			if (file1.exists())
			{
			   Image image1 = new Image("/tea/image/talkback/" + i+".jpg");
               				  out.print(image1);

			  } */
  String picture=talkback.getPicture(teasession._nLanguage);
  if(picture!=null&&picture.length()>0)
  {
    out.print(new Image(picture));
  }
  String voice=talkback.getVoice(teasession._nLanguage);
  if(voice!=null&&voice.length()>0)
  {
    out.print("<input type=button class=edit_input onClick=\"window.open('"+voice+"','_self');\" value="+r.getString(teasession._nLanguage, "CBPlay")+" >");
  }
  String file=talkback.getFile(teasession._nLanguage);
  if(file!=null&&file.length()>0)
  {
    out.print("<a href="+file+">"+talkback.getFileName(teasession._nLanguage)+"</a>");
  }
  java.util.Enumeration enumer=TalkbackReply.findByTalkback(l);
  java.text.SimpleDateFormat df=new java.text.SimpleDateFormat("yyyy-MM-dd");
  while(enumer.hasMoreElements())
  {
    TalkbackReply obj=  TalkbackReply.find(((Integer)enumer.nextElement()).intValue());

%><hr size="1"><TABLE CELLSPACING=0 CELLPADDING=0 id="tablecenter"><tr><td>时期：</td><td><%=df.format(obj.getTime())%></td></tr>
<tr><td>回复人：</td><td><%if(obj.getMember()!=null && obj.getMember().length()==32){out.print("游客");}else{out.print(obj.getMember());}%></td></tr><tr><td>内容：</td><td><%=(  obj.getText())%></td></tr></table>
<%  }%>
<HR SIZE=1><%
if(j != 0)
{
  subject=Talkback.find(j).getSubject(teasession._nLanguage);
  out.print(r.getString(teasession._nLanguage, "CBPrevious")+":<A HREF=/jsp/talkback/Talkback.jsp?node="+teasession._nNode+"&talkback="+j+" ID=TalkbackIndex>"+subject+"</A><br/>");
}
if(k != 0)
{
  subject=Talkback.find(k).getSubject(teasession._nLanguage);
  out.print(r.getString(teasession._nLanguage, "Next")+":<A HREF=/jsp/talkback/Talkback.jsp?node="+teasession._nNode+"&talkback="+k+" ID=TalkbackIndex>"+subject+"</A><br/>");
}
%>

<form action="/servlet/EditTalkbackReply" method="POST" onSubmit=" return submitText(this.reply, '无效内容')">
<input type="hidden" name="talkbackreply" value="0">
<input type="hidden" name="talkback" value="<%=l%>">
<input type="hidden" name="node" value="<%=teasession._nNode%>">

<TABLE CELLSPACING=0 CELLPADDING=0 id="tablecenter">
<tr><td>
<input  id="radio" type="radio" checked="checked" value="" name="formattype"/>文本 <input  id="radio" type="radio" name="formattype" value="1"/>HTML
</td></tr>
<tr><td>
<textarea cols="80" rows="6" name="reply"></textarea>
</td></tr>
<tr><td>
<input type="submit" value="回复" CLASS="CB" />
</td></tr>
</table>
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<!--div id="language"><%=new Languages(teasession._nLanguage,request)%></div-->
</body>
</html>
