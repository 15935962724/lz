<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.subscribe.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.resource.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.entity.subscribe.*" %>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache"); 
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

 
Node nobj = Node.find(teasession._nNode);

if(nobj.getType()==1)
{
	int father = Tactics.getNode(nobj.getPath());//报纸节点
	int qc = nobj.getFather();
	int fcc =Report.getSXqc(father,qc,"<");
	
	//out.print() 2010年06月23日 星期三 org.apache.commons.lang.time.
	
	java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat("yyyy"); //<SPAN ID=time_hm></SPAN>
	java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat("MM"); //<SPAN ID=time_hm></SPAN>
	java.text.SimpleDateFormat sdf3 = new java.text.SimpleDateFormat("dd"); //<SPAN ID=time_hm></SPAN>
	
	Date dq = Entity.sdf.parse(Node.find(nobj.getFather()).getSubject(teasession._nLanguage));
	String time =String.valueOf(sdf1.format(dq))+'年'+String.valueOf(sdf2.format(dq))+'月'+String.valueOf(String.valueOf(sdf3.format(dq)))+'日';
	 
	out.print("<span id=ymdid>"+time+"</span>");
	out.print("<span id =weekid>"+Entity.sdf_Week(dq)+"</span>");

	if(fcc>0)
	{
	  out.print("<span id=fccid><a href =/servlet/Node?node="+fcc+"&language="+teasession._nLanguage+">&laquo;上一期</a></span>");
	}else
	{
		out.print("<span id=fccid><a href =\"###\" onclick=\"alert('上期电子报暂没有发行');\">&laquo;上一期</a></span>");
	}
	out.print("&nbsp;");
	int fcc2=Report.getSXqc(father,qc,">");
	if(fcc2>0)
	{
	  out.print("<span id=fccid2><a href =/servlet/Node?node="+fcc2+"&language="+teasession._nLanguage+">下一期&raquo;</a></span>");
	}else
	{
		out.print("<span id=fccid2><a href =\"###\" onclick=\"alert('已经是最后一期电子报了');\">下一期&raquo;</a></span>");	
	}
}else if(nobj.getType()==39)
{
	java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat("yyyy"); //<SPAN ID=time_hm></SPAN>
	java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat("MM"); //<SPAN ID=time_hm></SPAN>
	java.text.SimpleDateFormat sdf3 = new java.text.SimpleDateFormat("dd"); //<SPAN ID=time_hm></SPAN>

	Date dq = Entity.sdf.parse(Node.find(Node.find(nobj.getFather()).getFather()).getSubject(teasession._nLanguage));
	String time =String.valueOf(sdf1.format(dq))+'年'+String.valueOf(sdf2.format(dq))+'月'+String.valueOf(String.valueOf(sdf3.format(dq)))+'日';
	 
	out.print("<span id=ymdid>"+time+"</span>");
	out.print("<span id =weekid>"+Entity.sdf_Week(dq)+"</span>");

	out.print("<span id=fccid3><a href =/servlet/Node?node="+Node.find(Node.find(teasession._nNode).getFather()).getFather()+"&language="+teasession._nLanguage+">返回目录</a></span>");
}



%>

