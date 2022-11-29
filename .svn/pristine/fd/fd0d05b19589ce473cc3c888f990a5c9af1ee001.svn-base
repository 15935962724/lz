<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.ui.*"%><%@page import="tea.db.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.htmlx.*"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLConnection"%>
<%@ page import="java.util.*"%>
<%
request.setCharacterEncoding("UTF-8");
	response.setHeader("Expires", "0");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
Resource r = new Resource();
r.add("/tea/resource/fashiongolf");
	TeaSession teasession = new TeaSession(request);
	if (teasession._rv == null) {
		response.sendRedirect("/servlet/StartLogin?node="
				+ teasession._nNode + "&nexturl="
				+ request.getRequestURI() + "?"
				+ request.getQueryString());
		return;
	}
	

	String act = "MyGolfEventTalkbackList";
	if(request.getParameter("act")!=null)
	{
		act = request.getParameter("act");	
	}
	

%>
<html>
<head>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>

<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">

<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/tea/tea.js" type="text/javascript"></script>

</head>
<body> 

<div class="titlemypl"><%=r.getString(teasession._nLanguage, "Mycomments")%></div>
<div id="tablemypl">
  <ul>
    <li><a href="/jsp/type/golf/MyGolfTalkbackIndex.jsp?community=<%=teasession._strCommunity%>&act=MyGolfEventTalkbackList"><%=r.getString(teasession._nLanguage, "Eventcomments")%></a> </li>
    <li> <a href="/jsp/type/golf/MyGolfTalkbackIndex.jsp?community=<%=teasession._strCommunity%>&act=MyGolfTalkbackList"><%=r.getString(teasession._nLanguage, "Stadiumreviews")%></a></li>
    <li> <a href="/jsp/type/golf/MyGolfTalkbackIndex.jsp?community=<%=teasession._strCommunity%>&act=MyGolfCoachTalkbackList"><%=r.getString(teasession._nLanguage, "Coachcomments")%></a></li>
    <!--<li><a href="/jsp/type/golf/MyGolfTalkbackIndex.jsp?community=<%=teasession._strCommunity%>&act=hour"><%=r.getString(teasession._nLanguage, "ServicesComments")%></a></li> -->    
  </ul>
</div>
<script>
var as=$('tablemypl').getElementsByTagName("A");
for(var i=0;i<as.length;i++)
{
	if(as[i].href.indexOf('<%=act%>')!=-1)
	{
		as[i].className="special";
		break;
		}
}
</script>
<%
out.flush();
try{

  if ("MyGolfTalkbackList".equals(act))
  {//活动
    %>
    <%@include file="/jsp/type/golf/MyGolfTalkbackList.jsp" %>
    <%
    } else if ("MyGolfEventTalkbackList".equals(act))
    {//球场
    	%>
    	  <%@include file="/jsp/type/golf/MyGolfEventTalkbackList.jsp" %>
   <%	
    }else if("MyGolfCoachTalkbackList".equals(act))
    {//教练
    %>
    <%@include file="/jsp/type/golf/MyGolfCoachTalkbackList.jsp" %>
    <%
    }
}catch(Exception e)
{e.printStackTrace();}
  %>
  </form>
</body>
</html>