<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %>
<%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.entity.site.*" %>
<%
request.setCharacterEncoding("UTF-8");

Http h=new Http(request);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node+"&nexturl="+java.net.URLEncoder.encode("/jsp/admin/?community="+h.community+"&node="+h.node,"UTF-8"));
  return;
}

String url=request.getParameter("url");

Resource r=new Resource();
r.add("/tea/resource/fun");

AdminFunction root=AdminFunction.getRoot(h.community,h.status);


AdminUsrRole aur=AdminUsrRole.find(h.community,h.member);

Community c=Community.find(h.community);

AdminUnit au=AdminUnit.find(aur.getUnit());
String picex=au.getPictureEx();

%><!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script>

if(top.location == self.location)top.location="/jsp/admin/indextop.jsp?community=<%=h.community%>&node=<%=h.node%>";


function fclick()
{
  var value=getCookie('admin_head_hide');
  if(value=='true')
  {
    parent.frame.rows='80,*';
    img.src="/tea/image/public/ico_min.gif";
    setCookie('admin_head_hide','false');
  }else
  {
    parent.frame.rows='10,*';
    img.src="/tea/image/public/ico_max.gif";
    setCookie('admin_head_hide','true');
  }
  size_button.focus();
}


function fchange(a,j,n,c,e,t)
{
  var cf=document.getElementById('currentfolder');
  if(cf)
  {
    cf.id='folder';
  }
  a.id='currentfolder';
  parent.f_cols(0,200);
}
function f_help()
{
  var id=0;
  var url=parent.m.document.location.href;
  var i=url.indexOf("?id=");
  if(i!=-1)
  {
    i=i+4;
    var j=url.indexOf("&",i);
    id=url.substring(i,j);
  }
  window.open('/jsp/site/HelpFrame.jsp?community=<%=h.community%>&type=0&id='+id,'','width=700,height=550,resizable=1,scrollbars=auto');
}
</script>
<style>
body{margin:0px;padding:0px;}
#toutable{width:expression(this.offsetParent.clientWidth*1<1000?"1000px":"100%");min-width: 1000px;}
</style>
</head>

<body class="headtopbody">
<table width="100%" width="100%" width="100%" width="100%" border="0" cellpadding="0" cellspacing="0" id="toutable" style="<% if(picex!=null)out.print("background-image:url("+picex+")"); %>" >
  <tr >
    <td rowspan="2" width="180" id="logo"><!--<a href="http://bp.redcome.com" target="top"><img alt="" src="/res/bigpic/u/0812/081255616.jpg" /></a>--></td>
    <td colspan="3" align="left" valign="bottom">
      <table border="0" width="100%" cellpadding="0" cellspacing="0">
        <tr>
          <td width=50% rowspan="2" align="center" ></td>
          <td width="50%" class="tou" >
            <script src="/jsp/message/Reminder.jsp?community=<%=h.community%>"></script>
	         <a href="<%=url%>" id="ToDesktop" target="m" ><%=r.getString(h.language,"ToDesktop")%></a>
            <%--<a id="ToProspects" href="/servlet/Node?node=<%=c.getNode()%>" target="_blank" ><%=r.getString(h.language,"ToProspects")%></a>--%>
            <a id="ToProspects" href="http://www.brachysolution.com/" target="_blank" ><%=r.getString(h.language,"ToProspects")%></a>
            <a id="Toquit" href="/servlet/Logout?community=<%=h.community%>&node=<%=h.node%>" target="_parent" >&nbsp;退出系统</a>
            <a href="javascript:f_help();" id="Tohelp" >&nbsp;系统帮助</a>       </td>
        </tr>
        <!--<tr>
          <td class="tou" ><script src="/jsp/message/Reminder.jsp?community=<%=h.community%>"></script></td>
        </tr>-->
      </table>
    </td>
  </tr>
  <tr>
    <td valign="bottom" align="left"><div id=gongnengcaidan>
    <span id=qian></span><span id=zhong>
    <%
    ArrayList al=AdminFunction.find(" AND father="+root.id,h);
    for(int i=0;i<al.size();i++)
    {
      AdminFunction af=(AdminFunction)al.get(i);
      String afurl=af.getUrl(h.language);
      if(af.getType()==0)
      {
        out.print("<a id=folder href=/jsp/admin/index_leftup.jsp?id="+af.id+"&node="+h.node+"& onfocus=this.blur() onclick=fchange(this) target=MenuFrame >"+af.getName(h.language)+"</a>");
      }else if(afurl.startsWith("javascript:"))//功能菜单
      {
        out.print("<a id=folder href="+afurl+" target="+af.getTarget()+" >"+af.getName(h.language)+"</a>");
      }else
      {
        out.print("<a id=folder href=/jsp/admin/right.jsp?id="+af.id+"&node="+h.node+"&info="+java.net.URLEncoder.encode(af.getName(h.language),"UTF-8")+" onfocus=this.blur() onclick=fchange(this) target="+af.getTarget()+" >"+af.getName(h.language)+"</a>");
      }
    }
%></span><span id=hou></span></div></td>
    <td align="right" valign="bottom" ID="renyuanqingkuang"><a id=person href="about:blank" onClick="parent.f_cols(2,0);" target="RightFrame">隐藏</a><a id=person href="/jsp/user/list/OnlineMembers.jsp?community=<%=h.community%>" onClick="parent.f_cols(2,200);" target="RightFrame">在线人员</a><a  id=person href="/jsp/user/list/AllMembers.jsp?community=<%=h.community%>" onClick="parent.f_cols(2,200);" target="RightFrame">全体人员</a></td>
  </tr>
</table>
<%--
if (teasession._nCount == 1 && tea.ui.member.notification.NotificationServlet.isNotifying(teasession._rv))
{
  out.print("<SCRIPT language=JavaScript FOR=window EVENT=onload>");
  out.print("window.screenX = screen.width; window.screenY = screen.height;");
  out.print("window.open(\"/servlet/Notification\",\"Notification\", \"height=250,width=250,left=600,top=400,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no,resizable=yes\");");
  out.print("</SCRIPT>");
}
<APPLET CODEBASE="/tea/applet/" CODE="tea.applet.meeting.CheckIn.class" WIDTH="0" HEIGHT="0" style="display:none"></APPLET>
--%>
<script>
var folder=document.getElementById('folder'),menu=parent.MenuFrame.location;
if(folder&&menu.href=="about:blank")
{
  menu.href=folder.href+"&auto=false";
}

//主菜单只有一个，则隐藏。
var div=$$("gongnengcaidan");
if(div.getElementsByTagName("A").length<2)
{
  div.style.display="none";
}
/*
  var value=  getCookie('admin_head_hide');
  if(value=='true')
  {
    parent.frame.rows='10,*';
    img.src="/tea/image/public/ico_max.gif";
  }else
  {
    parent.frame.rows='80,*';
    img.src="/tea/image/public/ico_min.gif";
  }
  size_button.focus();
*/
</script>
</body>
</html>
