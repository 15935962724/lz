<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
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

String popedom=AdminUsrRole.find(teasession._strCommunity,teasession._rv._strR).getAdminfunction();

Profile p=Profile.find(teasession._rv._strV);

%><html>
<head>
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
  var folder=document.getElementById('folder');

  if(folder && "about:blank"==parent.MenuFrame.location.href)
  {
    window.open(folder.href,folder.target);
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
var cols,rows;
function fchange(a,j,n,c,e,t)
{
  var cf=document.getElementById('currentfolder');
  if(cf)
  {
    cf.id='folder';
  }
  a.id='currentfolder';
  //
  var fs=parent.document.getElementsByTagName("FRAMESET");
  for(var i=0;i<fs.length;i++)
  {
    if(a.target=="m")
    {
      if(fs[i].rows!="")
      {
        if(!rows)rows=fs[i].rows;
        var rs=fs[i].rows.split(",");
        fs[i].rows=rs[0]+",*,0";
      }else
      {
        if(!cols)cols=fs[i].cols;
        fs[i].cols="0,*,0";
      }
    }else if(rows&&cols)
    {
      if(fs[i].rows!="")
      {
        fs[i].rows=rows;
      }else
      {
        fs[i].cols=cols;
      }
    }
  }
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
body{ margin:0px;padding:0px;}
</style>
</head>

<body onLoad="fload();">
<table width="100%"  border="0" cellpadding="0" cellspacing="0" id="toutable">

  <tr><td id="qqlogos" width="215px"></td>
    <td valign="bottom" align="left" id="zhongx"><%
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
        out.print("<a id=folder href=/jsp/netkoo/index_leftup.jsp?id="+j+"&node="+teasession._nNode+"&community="+teasession._strCommunity+" target=MenuFrame");
      }else//功能菜单
      {
        out.print("<a href=/jsp/admin/right.jsp?id="+j+"&node="+teasession._nNode+"&community="+teasession._strCommunity+"&info="+java.net.URLEncoder.encode(node1.getName(teasession._nLanguage),"UTF-8")+" target="+node1.getTarget());
      }
      out.print(" onfocus=this.blur() onclick=fchange(this) >"+node1.getName(teasession._nLanguage)+"</a>");
    }
  }
}
%></td>
    <td align="right" valign="bottom" ID="renyuanqingkuang">  <SCRIPT>
today=new Date();
var day; var date; var hello; var wel;
hour=new Date().getHours()
if(hour < 6)hello='凌晨好'
else if(hour < 9)hello='早上好'
else if(hour < 12)hello='上午好'
else if(hour < 14)hello='中午好'
else if(hour < 17)hello='下午好'
else if(hour < 19)hello='傍晚好'
else if(hour < 22)hello='晚上好'
else {hello='夜里好!'}
if(today.getDay()==0)day='星期日'
else if(today.getDay()==1)day='星期一'
else if(today.getDay()==2)day='星期二'
else if(today.getDay()==3)day='星期三'
else if(today.getDay()==4)day='星期四'
else if(today.getDay()==5)day='星期五'
else if(today.getDay()==6)day='星期六'
date=(today.getYear())+'年'+(today.getMonth() + 1 )+'月'+today.getDate()+'日';
if(hour<1)wel='子时';
else if(hour<3)wel='丑时';
else if(hour<5)wel='寅时';
else if(hour<7)wel='卯时';
else if(hour<9)wel='辰时';
else if(hour<11)wel='巳时';
else if(hour<13)wel='午时';
else if(hour<15)wel='未时';
else if(hour<17)wel='申时';
else if(hour<19)wel='酉时';
else if(hour<21)wel='戌时';
else if(hour<23)wel='亥时';
else {wel='子时';}
document.write(hello);
</SCRIPT>
<SCRIPT>
document.write(date + ' ' + day + ' ' );
    </SCRIPT>&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
  <tr >
    <td rowspan="2" width="215" class="logotd">&nbsp;</td>  <td id="fanhui"><span style="color:#737AC2;"><%=teasession._rv.toString()%></span>,&nbsp;&nbsp;欢迎您来到企业管理中心</td>
    <td colspan="3" align="right" id="fanhui">
            <a href="<%=url%>" id="ToDesktop" target="m" ><%=r.getString(teasession._nLanguage,"ToDesktop")%></a> <a id="ToProspects" href="/servlet/Node?node=<%=Community.find(teasession._strCommunity).getNode()%>" target="_blank" >[返回首页]</a>
          <a id="cancels" href="/servlet/Logout?community=<%=teasession._strCommunity%>" target=_top >[安全退出]</a>

	&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
</table>

<script type="" src="/jsp/message/Reminder.jsp"></script>

</body>
</html>
