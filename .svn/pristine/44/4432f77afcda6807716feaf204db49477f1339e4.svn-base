<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode("/jsp/admin/?community="+teasession._strCommunity+"&node="+teasession._nNode,"UTF-8"));
  return;
}

String url=request.getParameter("url");

Resource r=new Resource();
r.add("/tea/resource/fun"); 

int root=AdminFunction.getRootId(teasession._strCommunity,teasession._nStatus);

AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,teasession._rv._strR);
String popedom=aur.getAdminfunction(request.getRemoteAddr());

Community c=Community.find(teasession._strCommunity);

AdminUnit au=AdminUnit.find(aur.getUnit());
String picex=au.getPictureEx();

%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>

if(top.location == self.location)top.location="/jsp/admin/?community=<%=teasession._strCommunity%>&node=<%=teasession._nNode%>";


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

function fload()
{
/*
  var folder=document.getElementById('folder');

  if(folder && "about:blank"==parent.MenuFrame.location.href)
  {
	window.open(folder.href,folder.target);
  }


  //主菜单只有一个，则隐藏。
  var div=$("gongnengcaidan");
  var as=div.getElementsByTagName("A");
  if(as&&as.length<2)
  {
    div.style.display="none";
  }
  */
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
  window.open('/jsp/site/HelpFrame.jsp?community=<%=teasession._strCommunity%>&type=0&id='+id,'','width=500,height=550,resizable=1,scrollbars=auto');
}
</script>
<style>
body{margin:0px;padding:0px;}
#toutable{width:expression(this.offsetParent.clientWidth*1<1000?"1000px":"100%");min-width: 1000px;}
</style>
</head>

<body onLoad="fload();" class="headtopbody">

<table width="100%"  border="0" cellpadding="0" cellspacing="0" id="toutable" style="<% if(picex!=null)out.print("background-image:url("+picex+")"); %>" >
  <tr >
    <td rowspan="2" width="180" id="logo"><!--<a href="http://bp.redcome.com" target="top"><img alt="" src="/res/bigpic/u/0812/081255616.jpg" /></a>--></td>
    <td colspan="3" align="left" valign="bottom">
      <table border="0" width="100%" cellpadding="0" cellspacing="0">
        <tr>
          <td width=50% rowspan="2" align="center" ></td>
          <td width="50%" class="tou" > 
	         <div id="clssnid">
             <span class="left">
	         <a href="http://<%=request.getServerName() %>" target="_blank">网站首页</a>&nbsp;|&nbsp;<a href="/jsp/profile/MemberNewsletter.jsp" target="_blank">数字报</a>&nbsp;|&nbsp;<a href="/html/folder/24992-1.htm" target="_blank">论坛</a>&nbsp;|&nbsp;<a href='###' >博客</a></span>
	         <span class="right"><a href="###" id="ToDesktops"  onclick="window.parent.frames.location.reload();">管理中心首页</a>
            <a id="Toquit" href="/servlet/Logout?community=<%=teasession._strCommunity%>&node=<%=teasession._nNode%>" target=_top >&nbsp;退出管理中心</a></span>
            </div>
            </td>
        </tr>
        <!--<tr>
          <td class="tou" ><script src="/jsp/message/Reminder.jsp?community=<%=teasession._strCommunity%>"></script></td>
        </tr>-->
      </table>
    </td>
  </tr>
  <tr>	
    <td valign="bottom" align="left" ><%//if(aur.getRole().length()>1){%><div id=gongnengcaidan <%if(aur.getRole().length()<2)out.print("style=display:none;");%>><span id=qian></span><span id=zhong>
    <%
  
    java.util.Enumeration e = AdminFunction.findByFather(root);

    while(e.hasMoreElements())
    {
      int j = ((Integer)e.nextElement()).intValue();
      String aaaa = null ;
    
      if(popedom.indexOf("/"+j+"/")!=-1)
      {
        AdminFunction af = AdminFunction.find(j);
        if(af.isHidden())
        {
          String afurl=af.getUrl(teasession._nLanguage);
          if(af.getType()==0)
          {
            out.print("<a id=folder href=/jsp/admin/index_leftup.jsp?id="+j+"&node="+teasession._nNode+"&community="+teasession._strCommunity+" onfocus=this.blur() onclick=fchange(this) target=MenuFrame >"+af.getName(teasession._nLanguage)+"</a>");

            // out.print("<script>window.open('/jsp/admin/right.jsp?id="+j+"&node="+teasession._nNode+"&community="+teasession._strCommunity+"&info="+java.net.URLEncoder.encode(af.getName(teasession._nLanguage),"UTF-8")+"','_top');</script>");
          }else if(afurl.startsWith("javascript:"))//功能菜单
          {
            out.print("<a id=folder href="+afurl+" target="+af.getTarget()+" >"+af.getName(teasession._nLanguage)+"</a>");
          }else
          {
            out.print("<a id=folder href=/jsp/admin/right.jsp?id="+j+"&node="+teasession._nNode+"&community="+teasession._strCommunity+"&info="+java.net.URLEncoder.encode(af.getName(teasession._nLanguage),"UTF-8")+" onfocus=this.blur() onclick=fchange(this) target="+af.getTarget()+" >"+af.getName(teasession._nLanguage)+"</a>");
          }
        }
      }
    }

%></span><span id=hou></span></div><%//}%></td>
    <td align="right" valign="bottom" ID="renyuanqingkuang"><a id=person href="about:blank" onClick="parent.f_cols(2,0);" target="RightFrame">隐藏</a><a id=person href="/jsp/user/list/OnlineMembers.jsp?community=<%=teasession._strCommunity%>" onClick="parent.f_cols(2,200);" target="RightFrame">在线人员</a><a  id=person href="/jsp/user/list/AllMembers.jsp?community=<%=teasession._strCommunity%>" onClick="parent.f_cols(2,200);" target="RightFrame">全体人员</a></td>
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

</body>
</html>
