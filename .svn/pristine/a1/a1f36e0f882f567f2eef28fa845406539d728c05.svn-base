<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.*" %>
<%@page import="java.text.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="java.util.*"%>
<%@page import="tea.entity.node.access.*" %>
<%

request.setCharacterEncoding("UTF-8");

String referer=request.getHeader("referer");
if(referer==null)
{
  response.sendError(404,request.getRequestURI());
  return;
}

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  //response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  //return;
}
Resource r=new Resource();

String ip=request.getParameter("ip");
String host=request.getParameter("host");
String context=request.getParameter("context");

DecimalFormat df=new DecimalFormat("#,##0");
Date time=new Date();
//int day=Integer.parseInt( new SimpleDateFormat("dd").format(time));

%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/tea/community.css" rel="stylesheet" type="text/css">
<link href="http://center.redcome.com/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<style>
body{
scrollbar-face-color:#fff;
scrollbar-shadow-color:#e1e1e1;
scrollbar-highlight-color:#e1e1e1;
scrollbar-darkshadow-color:#e1e1e1;
scrollbar-track-color:#eee;
scrollbar-arrow-color:#35507a;
background:url(http://center.redcome.com/res/ROOT/u/0709/070921023.jpg) no-repeat right top;
background-attachment:fixed;
}
#bigdiv{width:300px;height:127px;background:url(http://center.redcome.com/res/ROOT/u/0709/070921021.jpg) repeat-x bottom;margin:10px 10px 0px 10px;float:left;}
#divleft{height:80px;float:left;margin-left:10px;}
#biaoti{color:#00c;font-size:14px;height:16px;overflow:hidden;}
#biaoti a{color:#00c;text-decoration:none;}
#con{color:#979797;font-size:12px;}
#con a{color:#979797;}
#smdiv{text-align:left;margin-left:10px;float:left;}
#aniu{clear:both;}
#divleft img{width:80px;}
#aniu a{text-decoration:none;line-height:17px;color:#000;margin-top:10px;float:left;width:80px;height:16px;border:#979797 1px solid;text-align:center;margin-right:5px;}
#xleft{width:95px;float:left;}
</style>
<script>
function f_onerror(obj)
{
  if(obj.src.indexOf("index")==-1)
  {
    obj.src="http://center.redcome.com/res/ROOT/snapshots/index.jpg";
  }
}
</script>
</head>
<body>
<%

ArrayList al=Community.find("",0,Integer.MAX_VALUE); //Communityinfo.findByHost(host,0,Integer.MAX_VALUE);
for(int i=0;i<al.size();i++)
{
  Community obj=(Community)al.get(i);
  String community=obj.community;
  if(obj.getNode()>0)
  {
    String url=null;
    Enumeration e2=DNS.findByCommunity(community,teasession._nStatus);
    if(e2.hasMoreElements())
    url=(String)e2.nextElement();

    NodeAccess na=NodeAccess.find(community);
    int count_aur=AdminUsrRole.count(community," AND role!='/'");
    int count_ol=OnlineList.countByCommunity(community," AND member IN ( SELECT member FROM AdminUsrRole WHERE role!='/' )");

   // out.print("<div  id=\"bigdiv\"><div id=\"divleft\" style=\"border:#AAAAAA solid 1px\" ><img src=http://center.redcome.com/res/ROOT/snapshots/"+community+".jpg onerror=f_onerror(this); ></div><div id=\"smdiv\"><div id=\"biaoti\"> ");
   out.print("<div  id=\"bigdiv\"><div id=\"divleft\" style=\"border:#AAAAAA solid 1px\" ><img src=");
   if(obj.getSmallMap(teasession._nLanguage)!=null &&obj.getSmallMap(teasession._nLanguage).length()>0)
   {
     out.print(obj.getSmallMap(teasession._nLanguage));
   }else
   {
     out.print("http://center.redcome.com/res/ROOT/snapshots/index.jpg");
   }
  out.print(" onerror=f_onerror(this); ></div><div id=\"smdiv\"><div id=\"biaoti\"> ");

    if(url!=null)
    out.print("<a href=http://"+url+" target=_blank >");
    out.print(obj.getName(teasession._nLanguage)+"</a> ( "+community+" )");
    out.print("</div>");
    out.print("<div id=\"con\"><div id=\"xleft\">");
    out.print("节点数:"+df.format(Node.count(" AND community="+DbAdapter.cite(community))));
    out.print("<br>访问量:"+df.format(na.getAllTotal()));
    out.print("<br>会员数:"+df.format(Subscriber.count(community,"")));
    out.print("<br>工作人员:"+df.format(count_aur));
   // out.print("<br>目录:"+context);
    out.print("<br>状态:"+Community.STATE_TYPE[obj.getState()]);
    out.print("<br></div><div id=\"xleft\">今日节点数:"+df.format(Node.count(" AND community="+DbAdapter.cite(community)+" AND time="+DbAdapter.cite(Community.sdf.format(time)))));
    out.print("<br>今日访问量:"+df.format(na.getDayTotal()));
    out.print("<br>在线数:"+df.format(OnlineList.countByCommunity(community,"")-count_ol));
    out.print("<br>在线数:"+count_ol);
    out.print("<br>IP:"+ip+"");
    out.print("<br></div></div><div id=\"aniu\">");
    out.print("<a target=_blank href="+(url!=null?("http://"+url+"/jsp/admin/Frame.jsp?community="+community):"javascript:alert('此网站未开通');")+">已开通功能</a><a target=_blank href="+(url!=null?("http://"+url+"/jsp/site/EditDNS.jsp?community="+community):"javascript:alert('此网站未开通');")+">发布域名</a>");
    out.print("</div></li></ul></div></div>");
  }
}

%>


</body>
</html>
