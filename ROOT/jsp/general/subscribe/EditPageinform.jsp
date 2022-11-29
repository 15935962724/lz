<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.subscribe.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Resource r=new Resource();
r.add("/tea/ui/node/general/EditNode");

String nexturl = request.getRequestURL() + "?node="+teasession._nNode + request.getContextPath();
String nexturl_2 = teasession.getParameter("nexturl");
Node node = Node.find(teasession._nNode);
int pfid = 0;
if(teasession.getParameter("pfid")!=null && teasession.getParameter("pfid").length()>0)
{
	pfid = Integer.parseInt(teasession.getParameter("pfid"));	
}

Pageinform pfobj = Pageinform.find(pfid);
//提交信息
if("POST".equals(request.getMethod()))
{
	int pagenumber =0;
	if( teasession.getParameter("pagenumber")!=null &&  teasession.getParameter("pagenumber").length()>0)
	{
		pagenumber = Integer.parseInt(teasession.getParameter("pagenumber"));
	}
	String pagename = teasession.getParameter("pagename");
	
	if(pfid>0)
	{
		pfobj.set(pagenumber,pagename);
		out.print("<script>alert('版面信息修改成功!');window.returnValue=1;window.close();</script>");
		return;
	}else
	{
		Pageinform.create(pagenumber,pagename,teasession._nNode,teasession._strCommunity);
		out.print("<script>alert('版面信息添加成功!');window.returnValue=1;window.close();</script>");
		return;
	}
}


int count = Pageinform.count(teasession._strCommunity,"");

%>
<html>
<head>
<title>版面信息管理</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >
<script>
window.name='tar';
function f_add()
{
	var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:557px;dialogHeight:457px;';
	  var url = '/jsp/general/subscribe/Pageinform.jsp?node='+form1.node.value+'&community='+form1.community.value+'&nexturl='+form1.nexturl.value;
	  var rs = window.showModalDialog(url,self,y);
	  if(rs==1)
	  { 
	    //window.open('/jsp/type/perform/PerformStreak.jsp?community='+form1.community.value+'&node='+form1.node.value,'_self ');
		  document.location.reload();
	  }
}
function f_sub()
{
	if(form1.pagename.value=='')
	{
		alert("请您填写版面信息!");
		form1.pagename.focus();
		return false;
	}
}

</script>

<h1>版面信息管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form action="?" name="form1" method="POST"  target="tar" onsubmit="return f_sub();" >
<input type="hidden" name="pfid" value="<%=pfid %>"/>
<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>  
<input type="hidden" name="nexturl" value="<%=nexturl %>"/>  
<input type="hidden" name="act"> 

 
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

    <tr>
      <td align="right">版面编号:</td>
      <td><input type="text" name="pagenumber" value="<%if(pfid>0){out.print(pfobj.getPagenumber());}else{out.print(count+1);}%>" readonly="readonly"></td>
    </tr>
     <tr>
      <td align="right">版面名称:</td>
      <td><input type="text" name="pagename" value="<%if(pfobj.getPagename()!=null)out.print(pfobj.getPagename()); %>"/></td>
    </tr>
  </table>
  <input type="submit" value="提交"/>&nbsp;<input type="button" value="关闭" onclick="window.close();">
</form>
</body>
</html>
