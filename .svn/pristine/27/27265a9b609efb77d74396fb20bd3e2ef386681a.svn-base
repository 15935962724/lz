<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.admin.earth.*" %>
<%@page import="java.util.*"%>
<%@page import="java.net.*"%>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Resource r=new Resource("/tea/resource/fun");

String q=request.getParameter("q");

StringBuffer sql=new StringBuffer();
StringBuffer param=new StringBuffer();
param.append("?community=").append(teasession._strCommunity);

if(q!=null&&(q=q.trim()).length()>0)
{
	sql.append(" AND ( community LIKE ").append(DbAdapter.cite("%"+q+"%"));
	sql.append(" OR name LIKE ").append(DbAdapter.cite("%"+q+"%"));
	sql.append(")");

	param.append("&q=").append(URLEncoder.encode(q,"UTF-8"));
}

int pos=0;
String _strPos=request.getParameter("pos");
if(_strPos!=null)
{
	pos=Integer.parseInt(_strPos);
}
param.append("&pos=");

int count=Communityinfo.count(sql.toString());

%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
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
#aniu a{text-decoration:none;line-height:17px;color:#000;margin-top:10px;float:left;width:80px;height:16px;border:#979797 1px solid;text-align:center;margin-right:5px;}
#xleft{width:95px;float:left;}
</style>
<script>
function f_onerror(obj)
{
  if(obj.src.indexOf("index")==-1)
  {
    obj.src="/res/ROOT/snapshots/index.jpg";
  }
}
function f_sendx(host,community,ip,context)
{
  var div=document.all("xleft");
  if(div.length)
  {
    div=div[div.length-1];
  }

}
</script>
</head>
<body>
<%
Enumeration e=Communityinfo.find(sql.toString(),pos,25); //Communityinfo.findByHost(host,0,Integer.MAX_VALUE);
while(e.hasMoreElements())
{
 // String community=(String)e.nextElement();
 int cfid = ((Integer)e.nextElement()).intValue();
  Communityinfo obj=Communityinfo.find(cfid);
  String community = obj.getCommunity();
  EarthHost eh=EarthHost.find(obj.getHost());

  String url=null;
  Enumeration e2=DNS.findByCommunity(community,teasession._nStatus);
  if(e2.hasMoreElements())
  {
    url=(String)e2.nextElement();
  }
  else
  {
    url=obj.getHost();
  }

//  out.print("<div  id=\"bigdiv\"><div id=\"divleft\" style=\"border:#AAAAAA solid 1px\" ><img src=/res/ROOT/snapshots/"+community+".jpg onerror=f_onerror(this); ></div><div id=\"smdiv\"><div id=\"biaoti\"> ");
   out.print("<div  id=\"bigdiv\"><div id=\"divleft\" style=\"border:#AAAAAA solid 1px\" ><img src=");
   if(obj.getPicurl()!=null &&obj.getPicurl().length()>0)
   {
     out.print("http://"+obj.getHost()+obj.getPicurl());
   }else
   {
     out.print("http://center.redcome.com/res/ROOT/snapshots/index.jpg");
   }
  out.print(" onerror=f_onerror(this); ></div><div id=\"smdiv\"><div id=\"biaoti\"> ");


  if(url!=null)
  out.print("<a href=http://"+url+"?community="+community+" target=_blank >");
  out.print(obj.getName()+"</a> ( "+community+" )");
  out.print("</div>");
  out.print("<div id=\"con\"><script src=http://"+obj.getHost()+"/jsp/admin/earth/EarthCommunityDetail.jsp?community="+community+"&ip="+eh.getIp()+"&context="+eh.getContext()+"></script></span></div>");
//  out.print("<div id=\"con\"><span id=span_"+community+"><img src=/tea/image/public/load.gif><script>setTimeout('<script src=http://"+obj.getHost()+"/jsp/admin/earth/EarthCommunityDetail.jsp?community="+community+"&ip="+eh.getIp()+"&context="+eh.getContext()+"></script>',100);</script></span></div>");
  out.println("<div id=\"aniu\"><a target=_blank href=http://"+url+"/jsp/admin/Frame.jsp?community="+community+">已开通功能</a><a target=_blank href=http://"+url+"/jsp/site/EditDNS.jsp?community="+community+">发布域名</a></div></li></ul></div></div>");

}
out.print(new tea.htmlx.FPNL(teasession._nLanguage, param.toString(), pos, count));
%>
</body>
</html>



