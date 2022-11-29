<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter"  %><%@page import="java.util.*" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.admin.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.TeaSession" %><%@page import="java.util.*"%><%
request.setCharacterEncoding("UTF-8");


TeaSession teasession=new TeaSession(request);

///JS代码////
String tmp=request.getParameter("style");
if(tmp!=null)
{
  String member=request.getParameter("member");
  if(member==null)
  {
    Node n=Node.find(teasession._nNode);
    member=n.getCreator()._strV;
  }
  Profile p=Profile.find(member);
  String msn=p.getMsn();
  String msnid=p.getMsnID();
  if(msnid!=null&&msnid.length()>0)
  {
    CommunityOption obj=CommunityOption.find(teasession._strCommunity);
    String policy=obj.get("msnpolicy");
    int width=obj.getInt("msnwidth");
    int height=obj.getInt("msnheight");
    String before=obj.get("msnbefore");
    String after=obj.get("msnafter");

    boolean js=request.getHeader("referer")!=null;
    int style=Integer.parseInt(tmp);
    if(js)
    {
      out.print("function f_msn(){ window.open('/jsp/im/Msns.jsp?community="+teasession._strCommunity+"&node="+teasession._nNode+"&member="+java.net.URLEncoder.encode(member,"UTF-8")+"&style=1','','width="+width+"px,height="+height+"px'); }");
      String div=request.getParameter("div");
      out.print((div!=null?"document.getElementById('"+div+"').innerHTML=":"document.write")+"(\"");
    }else
    {
      out.print("<style>body {	margin-left: 0px;	margin-top: 0px;	margin-right: 0px;	margin-bottom: 0px;}</style>");
    }
    switch(style)
    {
      case 0:
      out.print("<a href='javascript:f_msn()'>");
      if(before!=null)out.print(before);
      out.print("<img id='msnstatus' src='http://messenger.services.live.com/users/"+msnid+"/presenceimage?mkt=zh-cn' />");
      if(after!=null)out.print(after);
      out.print("</a>");
      break;
      case 1:
      out.print("<iframe src='http://settings.messenger.live.com/Conversation/IMMe.aspx?invitee="+msnid+"&mkt=zh-cn' width='"+width+"' height='"+height+"' frameborder='0'></iframe>");// style='border: solid 1px black; width: 300px; height: 300px;'
      break;
      case 2:
      if(msn==null||msn.length()<1)msn=p.getEmail();
      out.print("<a href='msnim:chat?contact="+msn+"'>");
      if(before!=null)out.print(before);
      out.print("<img id='msnstatus' src='http://messenger.services.live.com/users/"+msnid+"/presenceimage?mkt=zh-cn' />");
      if(after!=null)out.print(after);
      out.print("</a>");
      break;
    }
    if(js)
    {
      out.print("\");");
    }
  }
  return;
}

if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();




%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function f_open(msnid)
{
  window.open('http://settings.messenger.live.com/Conversation/IMMe.aspx?invitee='+msnid+'&mkt=zh-cn','','width=500px,height=400px');
}
function f_act(act,member)
{
  if(act=="del")
  {
    if(!confirm('确定删除您的「即时洽谈设定」吗？'))return false;
  }
  form1.act.value=act;
  form1.action=form1.action+"?member="+encodeURIComponent(member);
  form1.submit();
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "设置 Windows Live Messenger 即时消息控件")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditMsn" method="post">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl"/>
<script type="">
form1.nexturl.value=location;
</script>

<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
  <tr id="tableonetr">
    <td width="1">&nbsp;</td>
    <td>会员</td>
    <td>状态</td>
    <td>操作</td>
  </tr>
<%
StringBuffer sb=new StringBuffer();
Enumeration e=AdminUsrRole.find(teasession._strCommunity," AND role!='/' ",0,Integer.MAX_VALUE);
for(int i=1;e.hasMoreElements();)
{
  String member=(String)e.nextElement();
  Profile p=Profile.find(member);
  String msnid=p.getMsnID();
  if(msnid==null||msnid.length()<1)
  {
    sb.append("<option value='"+member+"'>"+member);
  }else
  {
    out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
    out.print("<td>"+i);
    out.print("<td>"+member);
    out.print("<td><img src='http://messenger.services.live.com/users/"+msnid+"/presenceimage/' />");
    out.print("<td><input type='button' value='编辑' onclick=f_act('edit','"+member+"');> ");
    out.print("<input type='button' value='删除' onclick=f_act('del','"+member+"');> ");
    out.print("<input type='button' value='测试' onclick=f_open('"+msnid+"');>");
    i++;
  }
}
%>
</table>

<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
<tr>
  <td>会员:</td>
  <td>
  <select name="member">
  <option value="">--------------------</option>
  <%=sb.toString()%>
  </select>
  </td>
</tr>
</table>
<input type="submit" value="现在设定" onclick="return submitText(form1.member,'无效-会员')"/>

</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
