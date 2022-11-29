<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.resource.*" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.util.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);

Community community=Community.find(teasession._strCommunity);
String pause=community.getPause(teasession._nLanguage);
if(pause!=null&&pause.length()>0)
{
  out.print(pause);
  return;
}
Date stop=community.getStopTime();
if(stop!=null&&stop.getTime()<System.currentTimeMillis())
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("已过期...","UTF-8"));
  return;
}

int root=community.getNode();
Node h=Node.find(root);
Company c = Company.find(root);

int node=teasession._nNode;
int lang=teasession._nLanguage;
String como=java.net.URLEncoder.encode(teasession._strCommunity,"UTF-8");
Node n = Node.find(node);

String adlink[]=c.getAdLink(lang);
String adpic[]=c.getAdPic(lang);

int father34=Category.find(teasession._strCommunity,34);//产品
int folder34=Node.find(father34).getFather();

Node n34=Node.find(folder34);
int father39=Category.find(teasession._strCommunity,39);
int father50=Category.find(teasession._strCommunity,50);//职位
int father73=Category.find(teasession._strCommunity,73);//售后服务
int father78=Category.find(teasession._strCommunity,78);//链接
int father87=Category.find(teasession._strCommunity,87);//公告
String url=teasession.getParameter("url");
if(url==null)
{
  url="";
}

WindowsBox wbs[]=new WindowsBox[30];
for(int i=0;i<wbs.length;i++)
{
  wbs[i]=WindowsBox.find(root,i);
}

int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

String nu=request.getParameter("nexturl");

Resource r = new Resource("/tea/resource/Windows");

CommunityOption co = CommunityOption.find(teasession._strCommunity);
String et=co.get("eyptemplate");
String es=co.get("eypstyle");
String ehm=co.get("eyphitsmember");
String eht=co.get("eyphitstime");

String q=request.getParameter("q");

/////////
int home21;
DbAdapter db=new DbAdapter();
try
{
  home21=db.getInt("SELECT node FROM Node WHERE vcreator="+DbAdapter.cite(teasession._strCommunity)+" AND type=21");
}finally
{
  db.close();
}
Node hn21=Node.find(home21);
Company hc21=Company.find(home21);

//记录最近访客
if(teasession._rv!=null&&!teasession._rv.equals(hn21.getCreator())&&!ehm.startsWith("/"+teasession._rv._strV+"/"))
{
  ehm="/"+teasession._rv+ehm;//.replace("/"+teasession._rv+"/","/");
  eht="/"+System.currentTimeMillis()+eht;
  if(ehm.length()>300)
  {
    ehm=ehm.substring(0,200);
    eht=eht.substring(0,200);
  }
  co.set("eyphitsmember",ehm);
  co.set("eyphitstime",eht);
}

%>
<!-- <%=teasession._strCommunity%> -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title><%=h.getSubject(lang)%></title>
<%--<base href="http://<%=request.getServerName()+":"+request.getServerPort()%>/jsp/type/company/windows/?<%=request.getQueryString()%>"/>--%>
<script type="text/javascript" src="/tea/tea.js"></script>
<link type="text/css" rel="stylesheet" href="/tea/image/eyp/style/<%=es%>.css">
<link type="text/css" rel="stylesheet" href="/tea/image/eyp/template/<%=et%>.css">
<link type="text/css" rel="stylesheet" href="/tea/image/eyp/union/<%=es+et%>.css">
</head>
<body>


<DIV id="body">
  <DIV ID=header>
    <div id="header_top"><div><a href="http://www.qiqiwang.com/servlet/Folder?node=2197067&language=1">第一站</a> | <a href="/jsp/user/StartLogin.jsp?node=<%=root%>&nexturl=/">登陆</a>
    <script type="" src="/jsp/im/Msns.jsp?style=0&member=<%=como%>"></script>
  </div>
</div>
<table id="header_logo">
  <tr>
    <td id="header_logo_td01"><Span ID=CompanyIDlogo><IMG BORDER=0 SRC="<%String clogo=c.getLogo(lang); out.print(clogo!=null?clogo:"/tea/image/eyp/images/logo.jpg");%>" width="80"/></Span></td>
      <td id="header_logo_td02"><%=h.getSubject(lang)%></td>
      <td id="header_logo_td03"></td>
      <td id="header_logo_td04"><a href="?community=<%=como%>&url=<%=url%>&language=1">中文</a>　<a href="?community=<%=como%>&url=<%=url%>&language=0">English</a></td>
  </tr>
</table>
<div id="banner_top"><img src="<%=c.getBanner(lang)%>" width="800" height="120"></div>
<table id="nav">
  <tr>
    <td>
    <%
    out.print("<a href='?community="+como+"'>"+r.getString(lang,"fj0vgqw1")+"</a>");
    if(!wbs[18].isHidden())
    {
      out.print("　|　<a href='?community="+como+"&url=ViewReport'>"+wbs[18].getName(lang)+"</a>");
    }
    if(!wbs[14].isHidden())
    {
      out.print("　|　<a href='?community="+como+"&url=Goodss'>"+wbs[14].getName(lang)+"</a>");
    }
    if(!wbs[19].isHidden())
    {
      out.print("　|　<a href='?community="+como+"&url=ViewCompany0'>"+wbs[19].getName(lang)+"</a>");
    }
    if(!wbs[9].isHidden())
    {
      out.print("　|　<a href='?community="+como+"&url=ViewJob'>"+wbs[9].getName(lang)+"</a>");
    }
    if(!wbs[20].isHidden())
    {
      out.print("　|　<a href='?community="+como+"&url=ViewMessageBoard'>"+wbs[20].getName(lang)+"</a>");
    }
    if(!wbs[4].isHidden())
    {
      out.print("　|　<a href='?community="+como+"&url=ViewCompany4'>"+wbs[4].getName(lang)+"</a>");
    }
    %>
    </td>
</table>
</div>
<DIV ID=content>
<%
//公告板
if("ViewBulletinBoard".equals(url))
{
%><%@include file="/jsp/type/company/windows/view/ViewBulletinBoard.jsp" %><%
}else
//公司
if("ViewCompany0".equals(url))
{
%><%@include file="/jsp/type/company/windows/view/ViewCompany0.jsp" %><%
}else if("ViewCompany1".equals(url))
{
%><%@include file="/jsp/type/company/windows/view/ViewCompany1.jsp" %><%
}else if("ViewCompany2".equals(url))
{
%><%@include file="/jsp/type/company/windows/view/ViewCompany2.jsp" %><%
}else if("ViewCompany3".equals(url))
{
%><%@include file="/jsp/type/company/windows/view/ViewCompany3.jsp" %><%
}else if("ViewCompany4".equals(url))
{
%><%@include file="/jsp/type/company/windows/view/ViewCompany4.jsp" %><%
}else
//新闻
if("ViewReport".equals(url))
{
%><%@include file="/jsp/type/company/windows/view/ViewReport.jsp" %><%
}else
//职位
if("ViewJob".equals(url))
{
%><%@include file="/jsp/type/company/windows/view/ViewJob.jsp" %><%
}else
//产品
if("Goodss".equals(url))
{
%><%@include file="/jsp/type/company/windows/view/Goodss.jsp" %><%
}else if("ViewGoods".equals(url))
{
%><%@include file="/jsp/type/company/windows/view/ViewGoods.jsp" %><%
}else
//链接
if("AmityLinks".equals(url))
{
%><%@include file="/jsp/type/company/windows/edit/AmityLinks.jsp" %><%
}else if("EditAmityLink".equals(url))
{
%><%@include file="/jsp/type/company/windows/edit/EditAmityLink.jsp" %><%
}else
//服务
if("ViewMessageBoard".equals(url))
{
%><%@include file="/jsp/type/company/windows/view/ViewMessageBoard.jsp" %><%
}else if("Search".equals(url))
{
  %><%@include file="/jsp/type/company/windows/Search.jsp" %><%
}else
{
%><%@include file="/jsp/type/company/windows/view/index.jsp" %><%
}
%>
</DIV>

<DIV ID=Footer>
<%
if((url==null||url.length()<1)&&!wbs[17].isHidden())//合作伙伴/客户
{
  out.print("<div id=Links>");
  out.print("<div id=Links_top>"+wbs[17].getName(lang)+"</div>");
  out.print("<ul id=links_ul info='"+r.getString(lang,"fj0vgqx5")+"'>");
  Enumeration e78=Node.find(" AND father="+father78+" AND type=78",pos,6);
  while(e78.hasMoreElements())
  {
    int n78=((Integer)e78.nextElement()).intValue();
    Node o78=Node.find(n78);
    AmityLink al78=AmityLink.find(n78,lang);
    out.print("<li><img src="+al78.getLogo()+"><br><a href="+al78.getUrl()+" target=_blank>"+o78.getSubject(lang)+"</a></li>");
  }
  out.print("</ul>");
  out.print("</div>");
}
%>
<script src="/jsp/type/company/windows/script.js"></script>

<div id="footer_nav">
<div id="footer_nav_nei">
  <table cellspacing="0" cellpadding="0" id="footer_nav_table">
    <tr>
      <td id="footer_nav_td_left" rowspan="3"><img src="/tea/image/eyp/images/no1.gif"></td>
        <td id="footer_nav_td_right_01">
        <%
        out.print("<a href='?community="+como+"'>"+r.getString(lang,"fj0vgqw1")+"</a>");
        if(!wbs[18].isHidden())
        {
          out.print("　|　<a href='?community="+como+"&url=ViewReport'>"+wbs[18].getName(lang)+"</a>");
        }
        if(!wbs[14].isHidden())
        {
          out.print("　|　<a href='?community="+como+"&url=Goodss'>"+wbs[14].getName(lang)+"</a>");
        }
        if(!wbs[19].isHidden())
        {
          out.print("　|　<a href='?community="+como+"&url=ViewCompany0'>"+wbs[19].getName(lang)+"</a>");
        }
        if(!wbs[9].isHidden())
        {
          out.print("　|　<a href='?community="+como+"&url=ViewJob'>"+wbs[9].getName(lang)+"</a>");
        }
        if(!wbs[20].isHidden())
        {
          out.print("　|　<a href='?community="+como+"&url=ViewMessageBoard'>"+wbs[20].getName(lang)+"</a>");
        }
        if(!wbs[4].isHidden())
        {
          out.print("　|　<a href='?community="+como+"&url=ViewCompany4'>"+wbs[4].getName(lang)+"</a>");
        }
        %>
        </td>
    </tr>
    <tr>
      <td id="footer_nav_td_right"><%=hn21.getSubject(lang)%>  版权所有 1997-2008  联系电话:<%=hc21.getTelephone(lang)%></td>
    </tr>
    <tr>
      <td id="footer_nav_td_right">技术支持：中龙网库科技有限公司</td>
    </tr>
  </table>
</div>
</div>
</DIV>


<%
if(!wbs[10].isHidden())
{
  out.print("<div id='ad0' style=Z-INDEX:10;LEFT:1px;POSITION:absolute;TOP:80px;><a href="+(adlink[0]!=null?adlink[0]:"/")+" target=blank><img src="+adpic[0]+" width=80 height=200></a></div>");
  out.print("<script>var ad0=document.getElementById('ad0'); setInterval('ad0.style.top=document.body.scrollTop+80;',100);</script>");
}
if(!wbs[11].isHidden())
{
  out.print("<div id='ad1' style=Z-INDEX:10;RIGHT:1px;POSITION:absolute;TOP:80px;><a href="+(adlink[1]!=null?adlink[1]:"/")+" target=blank><img src="+adpic[1]+" width=80 height=200></a></div>");
  out.print("<script>var ad1=document.getElementById('ad1'); setInterval('ad1.style.top=document.body.scrollTop+80;',100);</script>");
}

NodeAccess.Access(n,request,session);//访问统计
%>

</body>
</html>



<script type=text/javascript><!--
var LastLeftID = "";

function menuFix()
{
  var obj = document.getElementById("page2_left");
  if(!obj)return;
  obj=obj.getElementsByTagName("li");

  for (var i=0; i<obj.length; i++)
  {
    obj[i].onmouseover=function()
    {
      this.className+=(this.className.length>0? " ": "") + "sfhover";
    }
    obj[i].onMouseDown=function()
    {
      this.className+=(this.className.length>0? " ": "") + "sfhover";
    }
    obj[i].onMouseUp=function()
    {
      this.className+=(this.className.length>0? " ": "") + "sfhover";
    }
    obj[i].onmouseout=function()
    {
      this.className=this.className.replace(new RegExp("( ?|^)sfhover\\b"), "");
    }
  }
}

function DoMenu(emid)
{
	var obj = document.getElementById(emid);
	obj.className = (obj.className.toLowerCase() == "expanded"?"collapsed":"expanded");
	if((LastLeftID!="")&&(emid!=LastLeftID))	//关闭上一个Menu
	{
		document.getElementById(LastLeftID).className = "collapsed";
	}
	LastLeftID = emid;
}

function GetMenuID()
{

	var MenuID="";
	var _paramStr = new String(window.location.href);

	var _sharpPos = _paramStr.indexOf("#");

	if (_sharpPos >= 0 && _sharpPos < _paramStr.length - 1)
	{
		_paramStr = _paramStr.substring(_sharpPos + 1, _paramStr.length);
	}
	else
	{
		_paramStr = "";
	}

	if (_paramStr.length > 0)
	{
		var _paramArr = _paramStr.split("&");
		if (_paramArr.length>0)
		{
			var _paramKeyVal = _paramArr[0].split("=");
			if (_paramKeyVal.length>0)
			{
				MenuID = _paramKeyVal[1];
			}
		}
		/*
		if (_paramArr.length>0)
		{
			var _arr = new Array(_paramArr.length);
		}

		//取所有#后面的，菜单只需用到Menu
		//for (var i = 0; i < _paramArr.length; i++)
		{
			var _paramKeyVal = _paramArr[i].split('=');

			if (_paramKeyVal.length>0)
			{
				_arr[_paramKeyVal[0]] = _paramKeyVal[1];
			}
		}
		*/
	}

	if(MenuID!="")
	{
		DoMenu(MenuID)
	}
}

GetMenuID();	//*这两个function的顺序要注意一下，不然在Firefox里GetMenuID()不起效果
menuFix();
--></script>
