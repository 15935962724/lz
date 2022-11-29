<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
License license = License.getInstance();
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

%><!doctype html>
<html>

<head>
<%=tea.ui.node.general.NodeServlet.getBackStyle() %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
if (top.location == self.location)
{
  top.location="/jsp/admin/?community=<%=teasession._strCommunity%>&node=<%=teasession._nNode%>";
}

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

  var folder=document.getElementById('folder2');
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
}

function fright(v)
{
  var f=parent.frame2;
  var arr=f.cols.split(",");
  switch(v)
  {
    case 0:
    f.cols=arr[0]+","+arr[1]+","+0;
    break;

    case 1:
    f.cols=arr[0]+","+arr[1]+","+200;
    break;

    case 2:
    f.cols=arr[0]+","+arr[1]+","+200;
    break;
  }
}

function fchange(a,j,n,c,e,t)
{
  var cf=document.getElementById('currentfolder2');
  if(cf)
  {
    cf.id='folder2';
  }
  a.id='currentfolder2';
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

<body onLoad="fload();">
<form name="foSwitchL" method="POST" action="/servlet/SwitchLanguage" target="_top">
<%--<table width="100%"  border="0" cellpadding="0" cellspacing="0" id="toutable"  style="<% if(picex!=null)out.print("background-image:url("+picex+")"); %>" >--%>
<table width="100%" cellpadding="0" cellspacing="0" border="0" id="EditTop">
  <tr bgcolor="#ffffff">
    <td align="left" id="edn_pic"></td><td align="right" nowrap="nowrap">
      <%=r.getString(teasession._nLanguage,"Communitty") %>:<%=teasession._strCommunity%>　<%=teasession._rv._strR %>　
 <%--  <tr >
    <td colspan="3" align="left">
      <table border="0" width="100%" cellpadding="0" cellspacing="0">
        <tr>
          <td width=50% rowspan="2" align="center" ></td>
          <td width="50%" class="tou" >
           <!-- <a href="<%=url%>" id="ToDesktop" target="m" ><%=r.getString(teasession._nLanguage,"ToDesktop")%></a>-->
            <a id="ToProspects" href="/servlet/Node?node=<%=c.getNode()%>" target="_blank" ><%=r.getString(teasession._nLanguage,"ToProspects")%></a>
            <a id="cancels" href="/servlet/Logout?community=<%=teasession._strCommunity%>&node=<%=c.getLogin()%>" target=_top >&nbsp;退出系统</a>
            <a href="javascript:f_help();" id="cancels" >&nbsp;系统帮助</a>          </td>
        </tr>
      </table>
    </td>
  </tr>--%>
<input type="hidden" name="nexturl" value="/jsp/admin/index2.jsp"/>

<select name="language" onchange="document.foSwitchL.submit();">
        <%if((license.getWebLanguages() & 1 << 0) != 0){%><option value="0" <%if(teasession._nLanguage == 0)out.print("selected");%>><%=r.getString(teasession._nLanguage, Common.LANGUAGE[0])%>　&nbsp;&nbsp;</option><%}%>
        <%if((license.getWebLanguages() & 1 << 1) != 0){%><option value="1" <%if(teasession._nLanguage == 1)out.print("selected");%>><%=r.getString(teasession._nLanguage, Common.LANGUAGE[1])%>　&nbsp;&nbsp;</option><%}%>
<%if((license.getWebLanguages() & 1 << 2) != 0){%><option value="2" <%if(teasession._nLanguage == 2)out.print("selected");%>><%=r.getString(teasession._nLanguage, Common.LANGUAGE[2])%>　&nbsp;&nbsp;</option><%}%>
<%if((license.getWebLanguages() & 1 << 3) != 0){%><option value="3" <%if(teasession._nLanguage == 3)out.print("selected");%>><%=r.getString(teasession._nLanguage, Common.LANGUAGE[3])%>　&nbsp;&nbsp;</option><%}%>
<%if((license.getWebLanguages() & 1 << 4) != 0){%><option value="4" <%if(teasession._nLanguage == 4)out.print("selected");%>><%=r.getString(teasession._nLanguage, Common.LANGUAGE[4])%>　&nbsp;&nbsp;</option><%}%>
<%if((license.getWebLanguages() & 1 << 5) != 0){%><option value="5" <%if(teasession._nLanguage == 5)out.print("selected");%>><%=r.getString(teasession._nLanguage, Common.LANGUAGE[5])%>　&nbsp;&nbsp;</option><%}%>
<%if((license.getWebLanguages() & 1 << 6) != 0){%><option value="6" <%if(teasession._nLanguage == 6)out.print("selected");%>><%=r.getString(teasession._nLanguage, Common.LANGUAGE[6])%>　&nbsp;&nbsp;</option><%}%>
<%if((license.getWebLanguages() & 1 << 7) != 0){%><option value="7" <%if(teasession._nLanguage == 7)out.print("selected");%>><%=r.getString(teasession._nLanguage, Common.LANGUAGE[7])%>　&nbsp;&nbsp;</option><%}%>
<%if((license.getWebLanguages() & 1 << 8) != 0){%><option value="8" <%if(teasession._nLanguage == 8)out.print("selected");%>><%=r.getString(teasession._nLanguage, Common.LANGUAGE[8])%>　&nbsp;&nbsp;</option><%}%>
<%if((license.getWebLanguages() & 1 << 9) != 0){%><option value="9" <%if(teasession._nLanguage == 9)out.print("selected");%>><%=r.getString(teasession._nLanguage, Common.LANGUAGE[9])%>　&nbsp;&nbsp;</option><%}%>

      </select>&nbsp;&nbsp;
      <input type="button" value="<%=r.getString(teasession._nLanguage,"SystemHelp")%>" onclick="javascript:f_help();"/>&nbsp;&nbsp;
      <input type="button" value="<%=r.getString(teasession._nLanguage,"Logout")%>" onclick="window.open('/servlet/Logout?community=<%=teasession._strCommunity%>&node=<%=c.getLogin()%>','_top');"/>&nbsp;&nbsp;
    <input type="button" value="<%=r.getString(teasession._nLanguage,"ForeshoreManage")%>" onclick="window.open('/servlet/Node?node=<%=c.getNode()%>&amp;em=1&amp;edit=ON','_blank');"/>

    </td>
  </tr>

  <tr class="edn_sectr">
   <td valign="bottom" align="left" ><div id=gongnengcaidan ><%
java.util.Enumeration e = AdminFunction.findByFather(root);
while(e.hasMoreElements())
{
  int j = ((Integer)e.nextElement()).intValue();
  String aaaa = null ;
  if(popedom.indexOf("/"+j+"/")!=-1)
  {
    AdminFunction node1 = AdminFunction.find(j);
    if(node1.isHidden())
    {
      if(node1.getType()==0)
      {
        out.print("<a id=folder2 href=/jsp/admin/index_leftup.jsp?id="+j+"&node="+teasession._nNode+"&community="+teasession._strCommunity+" onfocus=this.blur() onclick=fchange(this) target=MenuFrame >"+node1.getName(teasession._nLanguage)+"</a>");

        // out.print("<script>window.open('/jsp/admin/right.jsp?id="+j+"&node="+teasession._nNode+"&community="+teasession._strCommunity+"&info="+java.net.URLEncoder.encode(node1.getName(teasession._nLanguage),"UTF-8")+"','_top');</script>");

      }else//功能菜单
      {
        out.print("<a id=ToDesktop2 href=/jsp/admin/right.jsp?id="+j+"&node="+teasession._nNode+"&community="+teasession._strCommunity+"&info="+java.net.URLEncoder.encode(node1.getName(teasession._nLanguage),"UTF-8")+" target="+node1.getTarget()+" >"+node1.getName(teasession._nLanguage)+"</a>");
      }
    }
  }
}
%></div></td>
    <td align="right" valign="bottom" ID="edn_ryqk" ><!--<a id=person href="about:blank" onClick="fright(0);" target="RightFrame">隐藏</a>--><a id=person2 href="/jsp/user/list/OnlineMembers.jsp?community=<%=teasession._strCommunity%>" onClick="fright(1);" target="RightFrame">在线人员</a><a  id=person2 href="/jsp/user/list/AllMembers.jsp?community=<%=teasession._strCommunity%>" onClick="fright(2);" target="RightFrame">全体人员</a></td>
  </tr>
</table>
</form>
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
