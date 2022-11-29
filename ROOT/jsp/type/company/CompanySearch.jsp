<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="org.apache.lucene.index.*"%>
<%@ page import="org.apache.lucene.search.*"%>
<%@ page import="tea.entity.util.*"%>
<%@ page import="tea.entity.node.*"%>
<%@ page import="tea.db.*"%>
<%@page import="org.apache.lucene.queryParser.*" %>
<%@page import="org.apache.lucene.analysis.standard.*" %>
<%@ page import="java.util.*"%>
<%@page import="java.net.URLEncoder"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

int lucenelist=Integer.parseInt(request.getParameter("lucenelist"));

String url="/servlet/Node?node="+teasession._nNode+"&Language="+teasession._nLanguage;

String q=request.getParameter("t255_q");
if(q==null)
	q="";
else
if(q!=null&&q.length()>0)
{
	url="/jsp/type/company/CompanySearchResult.jsp?lucenelist=0&community="+teasession._strCommunity+"&t255_q="+URLEncoder.encode(q,"UTF-8");
}

StringBuffer param=new StringBuffer();
param.append("?node=").append(teasession._nNode);
param.append("&community=").append(teasession._strCommunity);
param.append("&lucenelist=").append(lucenelist);


String _strPath=request.getParameter("t255_path");

String _strCity=request.getParameter("t21_city");


int pos=0;
String _strPos=request.getParameter("pos");
if(_strPos!=null)
{
	pos=Integer.parseInt(_strPos);
}

tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Lucene");

java.io.File f=new java.io.File(application.getRealPath("/res/" + teasession._strCommunity + "/searchindex/"+lucenelist+"_"+teasession._nLanguage));
if(!f.exists())
{
  //response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"1169017432031"),"UTF-8"));//没有发现索引文件
  //return;
}


%>
<html>
<head>

<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">

</head>
<body id="companysrhbody">

<%--
<form name=formcsf1 action="/jsp/type/company/CompanySearchResult.jsp" method="get" target="iframe_csr" onSubmit="return submitText(this.t255_q,'请输入关键字!');">
<input type=hidden name=Node value="<%=teasession._nNode%>" >
<input type=hidden name=community value="<%=teasession._strCommunity%>" >
<input type=hidden name=lucenelist value="<%=lucenelist%>" >
<input type=hidden name=t255_path value="<%if(_strPath!=null)out.print(_strPath);%>" >
<input type=hidden name=t21_city value="<%if(_strCity!=null)out.print(_strCity);%>" >
<table id="comsearch">
  
  <tr>
    <td>&nbsp;</td>
    <td><input name="t255_q" type="text" value="<%=q%>"></td>
    <td><input type="submit" value="提交"></td>
  </tr>
 
</table>
</form>
--%>

<script>
function s(v,t)
{
  if(t)
  {
  	formcsf1.t255_path.value=v;
  }else
  {
  	formcsf1.t21_city.value=v;
  }
  formcsf1.submit();
}
function f_outspread(v)
{
	var d=document.getElementById("div"+v);
	var i=document.getElementById("img"+v);
	if(d.style.display=="none")
	{
		d.style.display="";
		i.src='/tea/image/tree/tree_blank.gif';
	}else
	{
		d.style.display="none";
		i.src='/tea/image/tree/tree_plus.gif';
	}
}
function f2(v)
{
	if(v)
	{
		companycalling.style.display="";
		companycity.style.display="none";
		companycallingh3.style.backgroundColor="#EEF7FC";
		companycityh3.style.backgroundColor="#ffffff";
	}else
	{
		companycalling.style.display="none";
		companycity.style.display="";
		companycallingh3.style.backgroundColor="#ffffff";
		companycityh3.style.backgroundColor="#EEF7FC";
	}
}
////////////////////////
function f_c(v,n)
{
  var url=new Array("CompanyBasicinfo.jsp","CompanyGoods.jsp","CompanySynopsis.jsp","CompanyTalkback.jsp");
  window.open("/jsp/type/company/windows/"+url[v]+"?node="+n,"cbi");

  var cn=company_menu.childNodes;
  for(var i=0;i<cn.length;i++)
  {
 	cn[i].style.color=(v!=i?"":"#FFFFFF");
  	cn[i].style.backgroundColor=(v!=i?"":"#85B8EB");
  }
}
</script>

<div id="companysearch" >

<h3 id=companycallingh3 style="background-color:#EEF7FC"><a href="javascript:f2(true);">按行业</a></h3>
<h3 id=companycityh3 ><a href="javascript:f2(false);">按地区</a></h3>

<div id="companycalling">
<img src=/tea/image/tree/tree_blank.gif> <a href=javascript:s('',true); >所有行业</a><br>
<%
Enumeration e=Node.findAllSons(Integer.parseInt(request.getParameter("father")));
while(e.hasMoreElements())
{
	int id=((Integer)e.nextElement()).intValue();
	Node n=Node.find(id);
	out.print("<span id=companytree><img onclick=f_outspread('"+id+"'); style=cursor:hand id=img"+id+" src=/tea/image/tree/tree_plus.gif></span> <a href=javascript:s("+id+",true); >"+n.getSubject(teasession._nLanguage)+"</a><br>");
	out.print("<div id=div"+id+" style=display:none >");
	Enumeration e2=Node.findAllSons(id);
	while(e2.hasMoreElements())
	{
		int id2=((Integer)e2.nextElement()).intValue();
		Node n2=Node.find(id2);
		out.print("　　<img src=/tea/image/tree/tree_blank.gif> <a href=javascript:s("+id2+",true); >"+n2.getSubject(teasession._nLanguage)+"</a><br>");
	}
	out.print("</div>");
}
%>
</div>

<div id="companycity" style="display:none;">
<img src=/tea/image/tree/tree_blank.gif> <a href=javascript:s('',false); >所有地区</a><br>
<%
e=Card.find(" AND card<100",0,Integer.MAX_VALUE);
while(e.hasMoreElements())
{
	Card n=(Card)e.nextElement();
	int id=n.getCard();
	out.print("<span id=companytree>");
	if(n.getAddress().endsWith("市"))
	{
		out.print("<img src=/tea/image/tree/tree_blank.gif>");
	}else
	{
		out.print("<img onclick=f_outspread('"+id+"'); style=cursor:hand id=img"+id+" src=/tea/image/tree/tree_plus.gif>");
	}
	out.print("</span> <a href=javascript:s('"+id+"',false); >"+n.getAddress()+"</a><br>");
	out.print("<div id=div"+id+" style=display:none >");
	Enumeration e2=Card.find(" AND card>100 AND card LIKE "+DbAdapter.cite(id+"__"),0,Integer.MAX_VALUE);
	while(e2.hasMoreElements())
	{
		Card n2=(Card)e2.nextElement();
		int id2=n2.getCard();
		out.print("　　<img src=/tea/image/tree/tree_blank.gif> <a href=javascript:s('"+id2+"',false); >"+n2.getAddress()+"</a><br>");
	}
	out.print("</div>");
}
%>
</div>
</div>

<iframe id=iframe_csr name=iframe_csr src="<%=url%>" frameborder="0"></iframe>

</body>
</html>
