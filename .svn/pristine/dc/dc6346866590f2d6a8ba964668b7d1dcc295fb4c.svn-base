<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.io.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.bbs.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.ui.*"%><%@page import="java.util.*"%><%@page import="java.text.SimpleDateFormat"%><%@page import="tea.htmlx.*"%><%@page import="tea.html.HtmlElement"%><%

Http h=new Http(request,response);

TeaSession teasession = new TeaSession(request);


Node node=Node.find(teasession._nNode);

if((Node.find(node.getFather()).getOptions1() & 1) == 0)
{
  if(teasession._rv == null)
  {
    response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
    return;
  }
}


Resource r = new Resource();
r.add("/tea/ui/node/talkback/TalkbackServlet");

int bbsreply=0;
String tmp = teasession.getParameter("bbsreply");
if(tmp!=null)bbsreply=Integer.parseInt(tmp);

int hint=0;
String nexturl=teasession.getParameter("nexturl");
String subject,text;




BBS b=BBS.find(teasession._nNode,teasession._nLanguage);
if(b.locking)
{
  out.print("<script>alert('本主题已经锁定，不能发表回复。');history.back();</script>");
  return;
}

if(h.member>0)
{
  Profile p=Profile.find(h.member);
  Date gag=p.getGag();
  if(gag!=null&&gag.getTime()>System.currentTimeMillis())
  {
    out.print("<script>alert('抱歉，您被禁言了，于 "+MT.f(gag)+" 之前不能发贴！');history.back();</script>");
    return;
  }
}


//回贴校验积分
if(bbsreply==0)
{
  BBSForum bf=BBSForum.find(node.getFather());
  if(!bf.isAuth(h.community,h.username,bf.lreply,bf.rreply))
  {
    if(h.member<1)
      response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
    else
      out.print("<script>alert('您的积分不足，无权回贴！');history.back();</script>");
    return;
  }
}

int reply=h.getInt("reply");
int quote=h.getInt("quote");

tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);
%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body class="BBSReply">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<div class="BBSReplyCon">
<h1><%=r.getString(teasession._nLanguage, "CBReply")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<FORM NAME=foEdit METHOD=POST action="/servlet/EditBBSReply?node=<%=teasession._nNode%>" target="_ajax" onSubmit="return mt.check(this);">
<%
if(nexturl!=null)
{
  out.print("<input type='hidden' name=nexturl value="+nexturl+">");
}
if(bbsreply!=0)
{
  BBSReply obj=BBSReply.find(bbsreply);
  //if(!teasession._rv.toString().equals(obj.getMember()))
 // {
  //  response.sendError(403);
   // return;
 // }
  subject=obj.getSubject(teasession._nLanguage);
  text=MT.f(obj.getContent(teasession._nLanguage)).replaceAll("\r\n","\\\\r\\\\n");
  hint=obj.getHint();

  //查阅
  obj.setSearch(1);
  obj.setSearch(teasession._rv._strR,new Date());
}else
{
  subject="回复: "+node.getSubject(teasession._nLanguage);
  text="";
}
%>
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="bbsreply" value="<%=bbsreply%>">
<input type='hidden' name='reply' value='<%=reply%>' />
<input type='hidden' name='quote' value='<%=quote%>' />

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr class="tishifu">
      <td><%=r.getString(teasession._nLanguage, "Hint")%>:</td>
      <td>
      <%
      for(int i=0;i<12;i++)
      {
        out.print("<INPUT id=radio type=radio NAME=hint VALUE="+i);
        if(hint==i)
        {
          out.print(" checked ");
        }
        out.print("><IMG BORDER=0 SRC=/tea/image/hint/"+i+".gif> ");
      }
      %>
      </td>
    </tr>
   <tr>
     <td><%=r.getString(teasession._nLanguage,"Subject")%>:</td>
     <td><script>document.write("<in"+"put name='sub"+"ject' value=\"<%=MT.f(subject)%>\" size=50 maxlength=128 alt='主题' />");</script></td>
   </tr>
<%
if(reply>0)
{
  String str,user,time;
  if(reply==1)
  {
    Node n=Node.find(h.node);
    str=n.getText(h.language);
    user=n.getCreator()._strR;
    time=MT.f(n.getTime(),1);
  }else
  {
    BBSReply br=BBSReply.find(reply);
    str=br.getContent(h.language);
    user=br.getMember();
    time=MT.f(br.getTime(),1);
  }
  str=MT.f(tea.entity.util.Lucene.t(str),100);
%>
<tr>
  <td><%=r.getString(teasession._nLanguage, "回复")%>:</td>
  <td>
<div style="background-color:#FDFDDF"><font color="red">回复 <%=user%> 的内容：<br/></font><%=str%></div></td>
</tr>
<%
}
if(quote>0)
{
  String str,user,time;
  if(quote==1)
  {
    Node n=Node.find(h.node);
    str=n.getText(h.language);
    user=n.getCreator()._strR;
    time=MT.f(n.getTime(),1);
  }else
  {
    BBSReply br=BBSReply.find(quote);
    str=br.getContent(h.language);
    user=br.getMember();
    time=MT.f(br.getTime(),1);
  }
  str=MT.f(tea.entity.util.Lucene.t(str),100);
%>
<tr>
  <td><%=r.getString(teasession._nLanguage, "引用")%>:</td>
  <td>
<img src="/tea/image/bbslevel/quote1.gif"/><%=user%>发表于<%=time%><img src="/tea/image/bbslevel/quote.gif"/><br/><%=str%><img src="/tea/image/bbslevel/quote2.gif"/>
  </td>
</tr>
<%
}
%>
  <tr>
     <td><%=r.getString(teasession._nLanguage, "Text")%>:</td>
     <td>
       <script>document.write("<tex"+"tarea name='con"+"tent' style='display:none'><%=text%></textarea><ifra"+"me id='editor' src='/jsp/include/FCKeditor/editor/fckeditor.html?Insta"+"nceName=content&Toolbar=MySetting<%//=teasession._strCommunity%>' width='730' height='300' frameborder='no' scrolling='no'></iframe>");</script>
     </td>
   </tr>
<%
if(teasession._rv != null)
{
  out.print("<tr><td nowrap>"+r.getString(teasession._nLanguage, "附件")+":</td><td nowrap><iframe src='/jsp/type/bbs/EditBBSAttach.jsp?type=true&bbsid="+bbsreply+"&node="+node.getFather()+"' scrolling='no' id='ba' height='20px' width='100%' allowtransparency='true' frameborder='0'></iframe></td></tr>");
}
%>
</table>


<input TYPE=submit onClick="" name="submit" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
<input class="edit_button" type="button" value="<%=r.getString(teasession._nLanguage, "返回")%>" onClick="history.back();">

</FORM>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</div>
 <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>
</html>
<!-- http://127.0.0.1/jsp/type/bbs/EditBBSReply.jsp -->
