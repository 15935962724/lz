<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%@ page import="tea.entity.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%

TeaSession teasession = new TeaSession(request);
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");


if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode("/jsp/admin/?community="+teasession._strCommunity+"&node="+teasession._nNode,"UTF-8"));
  return;
}

String url=request.getParameter("url");

Resource r=new Resource();
r.add("/tea/resource/fun");
r.add("/tea/resource/Photography");

int root=AdminFunction.getRootId(teasession._strCommunity,teasession._nStatus);

AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,teasession._rv._strR);
String popedom=aur.getAdminfunction(request.getRemoteAddr());

Community c=Community.find(teasession._strCommunity);

AdminUnit au=AdminUnit.find(aur.getUnit());
String picex=au.getPictureEx();


StringBuilder sql = new StringBuilder(" and hidden = 0 "); 

StringBuffer sql2 = new StringBuffer(" and audit =0 and n.type = 94 ");

sql.append(" AND node IN(SELECT node FROM Node WHERE path LIKE '/"
		+ c.getNode() + "/%')");
int count = Talkback.count(sql.toString());
int count2 = Node.countPhotography(teasession._strCommunity,sql2.toString());





%><!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script>
if (top.location == self.location)top.location="/jsp/admin/?community=<%=teasession._strCommunity%>&node=<%=teasession._nNode%>";

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
  var cf=$('currentfolder');
  if(!cf)
  {
    var arr=mt.find("id","folder");
    for(var i=0;i<arr.length;i++)
    {
      if(arr[i].href.indexOf("leftup")!=-1)
      {
        cf=arr[i];
        break;
      }
    }
  }
  if(cf && "about:blank"==parent.MenuFrame.location.href)
  {
	window.open(cf.href,cf.target);
  }
  var folder=document.getElementById('folder');
  if(!folder)
  {
    cf.style.display="none";
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
  var cf=$('currentfolder');
  if(cf)cf.id='folder';
  a.id='currentfolder';
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

var doc=parent.m.document;
if(doc.readyState=="complete")
{

}
</script>
<style>
body{margin:0px;padding:0px;}
#toutable{width:expression(this.offsetParent.clientWidth*1<1000?"1000px":"100%");min-width: 1000px;}
</style>
</head>

<body onLoad="fload();">
<table width="100%"  border="0" cellpadding="0" cellspacing="0" id="toutable"  style="<%if(picex!=null)out.print("background-image:url("+picex+")"); %>" >
  <tr >
    <td rowspan="2" width="180" class="logotd">&nbsp;</td>
    <td colspan="3" align="left" valign="bottom">
      <table border="0" width="100%" cellpadding="0" cellspacing="0">
        <tr>
          <td width=50% rowspan="2" align="center" ></td>
          <td width="50%" class="tou" >
          <%
         
          int unit=aur.getUnit();
          String role = aur.getRole() ;
          String rs[]=role.split("/"); 

            out.print("<br><SPAN ID=profileunit>"+(unit>0?AdminUnit.find(unit).getName():"")+"</SPAN>");
            out.print("<SPAN ID=strrid>"+teasession._rv._strR+"</span>");
          %>
            <a id="ToProspects" href="/servlet/Node?node=<%=c.getNode()%>" target="_top"><%=r.getString(teasession._nLanguage,"2906765269") %></a>
            <a id="cancels" href="/servlet/Logout?community=<%=teasession._strCommunity%>&node=<%=c.getNode()%>" target="_top"><%=r.getString(teasession._nLanguage,"5717197340") %></a>
            <a href="javascript:f_help();" id="ToHelp" ><%=r.getString(teasession._nLanguage,"5785493564") %></a>
          </td>
        </tr>
        <tr>
          <td class="tou02"><script src="/jsp/message/Reminder.jsp?community=<%=teasession._strCommunity%>"></script></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td valign="bottom" align="left" ></td>
    <td align="right" valign="bottom" ID="renyuanqingkuang"><!--<a id=person href="about:blank" onClick="fright(0);" target="RightFrame">隐藏</a>-->

   
</td>
  </tr>
</table><table  width="100%"  border="0" cellpadding="0" cellspacing="0" id="toutable2" >
  <tr>
    <td><div id=gongnengcaidan><span id=qian></span><span id=zhong><%
    boolean flag=false;
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


%>

    </span><span id=hou></span></div></td>
  </tr>
</table>
<%
if(AccessMember.find(teasession._nNode, teasession._rv._strV).getType()!=null && AccessMember.find(teasession._nNode, teasession._rv._strV).getType().indexOf("/94/")!=-1)
{ 
	if(count>0 || count2>0){ 
		
		StringBuffer sp = new StringBuffer();
		sp.append("系统信息<br>"); 
		if(count>0){//\"/jsp/type/photography/TalkbackList.jsp\"
			sp.append("待处理评论信息：<a  href=\"/jsp/type/photography/TalkbackList.jsp\" target=\"m\" style=color:red>"+count+"</a> ");
	    }  
		sp.append("<br>");   
	    if(count2>0){ 
	    	sp.append("待处理作品信息：<a  href=\"/jsp/type/photography/Photography.jsp?node="+teasession._nNode+"\" target=\"m\" style=color:red>"+count2+"</a> ");
	    }
	    out.print("<script>");
	    out.print("popup.show2('"+sp.toString()+"','温馨提示');");
	    out.print("</script>");
	}
}

%>
</body>
</html>
