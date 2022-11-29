<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource"  %>
<%@page import="tea.entity.admin.ig.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="java.net.URLEncoder" %>
<%@page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

String member;
String _strRole=request.getParameter("role");
int role=0;
if(_strRole!=null)
	role=Integer.parseInt(_strRole);


String communityx=request.getParameter("communityx");
if(communityx==null)
{
	communityx=teasession._strCommunity;
}

int root=AdminFunction.getRootId(communityx,teasession._nStatus);

String popedom;
if(role>0)
{
	StringBuffer sb = new StringBuffer(AdminRole.find(role).getAdminfunction());
	//把角色类型为 1(所有会员拥用的角色) 读出
	java.util.Enumeration enumer = AdminRole.findByType(communityx,1);
	while (enumer.hasMoreElements())
	{
		int id = ((Integer) enumer.nextElement()).intValue();
		AdminRole ar_obj = AdminRole.find(id);
		sb.append(ar_obj.getAdminfunction());
	}
	popedom=sb.toString();
}else
{
	popedom=AdminUsrRole.find(communityx,teasession._rv._strR).getAdminfunction();
}
if(popedom.length()<2)
{
	response.sendRedirect("/jsp/info/Alert.jsp?info="+URLEncoder.encode("对不起,您无权添加任何内容.","UTF-8"));//+"&nexturl="+URLEncoder.encode("/jsp/admin/popedom/userpriv.jsp?community="+teasession._strCommunity,"UTF-8"));
	return;
}

int igtab=Integer.parseInt(request.getParameter("igtab"));
Igtab igt_obj=Igtab.find(igtab);
String mp=igt_obj.getMp();




%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<script>
function s(id)
{
form1.igdirectory.value=id;
form1.submit();
}
</script>
<body>

<div id="shequ"><h3>请选择社区>></h3><div id="xzshequ">
<%
java.util.Enumeration es=Subscriber.findJoined(teasession._rv);
while(es.hasMoreElements())
{
	String community=(String)es.nextElement();
	Community obj=Community.find(community);
	if(!communityx.equals(community))
		out.print("<a href=?community="+teasession._strCommunity+"&communityx="+community+"&igtab="+igtab+"&role="+role+">"+obj.getName(teasession._nLanguage)+"</a>");
	else
		out.print("<span id=dqshequ>"+obj.getName(teasession._nLanguage)+"</span>");
}
%>
</div><a id=more  href="###">更多社区</a></div>

<div id="boxadd">
<h1>添加内容到标签</h1>
<span id="boxsm">点击内容名称小图或简介即可马上添加使用指定功能模块到自定义标签</span>

<form name=form1 METHOD=get action="/servlet/EditIg" >
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="igtab" value="<%=igtab%>"/>
<input type=hidden name="role" value="<%=role%>"/>
<input type=hidden name="igdirectory" value="0"/>
<input type=hidden name="act" value="selectigdirectory"/>
<%
	java.util.Enumeration enumer = AdminFunction.findByFather(root);
	while(enumer.hasMoreElements())
	{
	  int id=((Integer)enumer.nextElement()).intValue();
	  AdminFunction obj = AdminFunction.find(id);
	  if(!obj.isType()&&popedom.indexOf("/"+id+"/")!=-1)
	  {
	    StringBuffer html=new StringBuffer();
		int index=0;
		java.util.Enumeration e2 = AdminFunction.findByFather(id);
		while(e2.hasMoreElements())
		{
		  id=((Integer)e2.nextElement()).intValue();
		  if(popedom.indexOf("/"+id+"/")!=-1)//!obj.isType()&&
		  {
			AdminFunction obj2 = AdminFunction.find(id);
		  	if(mp.indexOf(":"+id+"_")!=-1||mp.startsWith(id+"_"))
		  	{

		  	}else
		  	{
		  		html.append("<DIV ID=box><SPAN ID=img><A HREF=javascript:s(").append(id).append(")><IMG SRC=");
			  	if(obj2.getIcon()==null||obj2.getIcon().length()<1)
			  		html.append("/tea/image/igicon/index.jpg");
			  	else
			  		html.append(obj2.getIcon()).append(" onerror=\"if(this.src.indexOf('index.jpg')==-1)this.src='/tea/image/igicon/index.jpg';\"");
			  	html.append("></A></SPAN>");
			  	html.append("<SPAN id=subject>");
			  	html.append("<A HREF=javascript:s(").append(id).append(")>").append(obj2.getName(teasession._nLanguage)).append("</A></SPAN>");
			  	html.append("<SPAN id=content>").append(obj2.getContent(teasession._nLanguage)).append("</SPAN></DIV>");//"  onClick=\"form1.igdirectory.value='"+id+"';form1.submit();\"></td>");
		  	}
		  }
		}
		if(html.length()>0)
		{
			out.print("<h2>"+obj.getName(teasession._nLanguage)+"</h2>");
			out.print(html.toString());
		}
	  }
	}
%>
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div></div>
</body>
</html>
