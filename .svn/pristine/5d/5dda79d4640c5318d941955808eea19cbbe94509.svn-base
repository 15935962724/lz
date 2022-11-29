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
int qc = teasession._nNode;
if(nobj.getType()==39)//说明是版
{
	 nobj = Node.find(Node.find(teasession._nNode).getFather());
	 qc = Node.find(teasession._nNode).getFather();
}
	int father = nobj.getFather();//Tactics.getNode(nobj.getPath());//报纸节点
	 
	int fcc =Report.getSXban(father,qc,"<");
	 
	//显示版的名称
	out.print("<span id=fccname>"+nobj.getSubject(teasession._nLanguage)+"</span>");
	
	//显示pdf
	out.print("<span id=fccpdf>");
	if(nobj.getFile(teasession._nLanguage)!=null&&nobj.getFile(teasession._nLanguage).length()>0)
	{
		out.print("PDF：<a href="+nobj.getFile(teasession._nLanguage)+" target=_blank><img src=/tea/image/netdisk/pdf.gif></a>");
	}else
	{
		out.print("PDF：<a href=\"###\" onclick=alert('此版没有pdf文件!');><img src=/tea/image/netdisk/pdf.gif></a>");
	}
	out.print("</span>");

	if(fcc>0)
	{
	  out.print("<span id=fccid_ban><a href =/html/node/"+fcc+"-"+teasession._nLanguage+".htm>&laquo;上一版</a></span>");
	}
	 
	//out.print("&nbsp;&nbsp;");
	
	int fcc2=Report.getSXban(father,qc,">");
	
	if(fcc2>0)
	{
	  out.print("<span id=fccid2_ban><a href =/html/node/"+fcc2+"-"+teasession._nLanguage+".htm>下一版&raquo;</a></span>");
	}

	

 
%>

