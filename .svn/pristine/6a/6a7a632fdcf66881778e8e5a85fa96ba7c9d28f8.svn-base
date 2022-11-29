<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="org.apache.lucene.index.*"%>
<%@ page import="org.apache.lucene.search.*"%>
<%@ page import="tea.entity.util.*"%>
<%@ page import="tea.entity.node.*"%>
<%@ page import="tea.entity.admin.*"%>
<%@ page import="tea.db.*"%>
<%@page import="org.apache.lucene.queryParser.*" %>
<%@page import="org.apache.lucene.analysis.standard.*" %>
<%@ page import="java.util.*"%><%! 

public String getTypeTree(int father,int language,int step)throws Exception
{
	StringBuffer sb=new StringBuffer();
	Enumeration e=GoodsType.findByFather(father);
	while(e.hasMoreElements())
	{
		GoodsType n=(GoodsType)e.nextElement();
		int id=n.getGoodstype();
		sb.append("<span id=goodstypetree>");
		for(int i=0;i<step;i++)
		{
			sb.append("　");
		}
		sb.append("<img onclick=f_expand("+id+"); style=cursor:hand id=img"+id+" src=/tea/image/tree/"+(n.countByFather(id)>0?"tree_plus.gif":"tree_blank.gif")+"></span> <a href=javascript:s("+id+"); >"+n.getName(language)+"</a><br>");
		sb.append("<div id=div"+id+" style=display:none ></div>");
	}
	return sb.toString();
}
%><%
request.setCharacterEncoding("UTF-8");


TeaSession teasession=new TeaSession(request);

if(request.getParameter("ajax")!=null)
{
	int father=Integer.parseInt(request.getParameter("father"));
	if(father==0)
		 father=GoodsType.getRootId(teasession._strCommunity);
	String str=getTypeTree(father,teasession._nLanguage,1);
	out.print(str);
	return;
}


int lucenelist=0;//Integer.parseInt(request.getParameter("lucenelist"));

String url="/servlet/Node?node="+teasession._nNode+"&Language="+teasession._nLanguage;

String q=request.getParameter("t255_q");
if(q==null)
	q="";
else
if(q!=null&&q.length()>0)
{
	url="/jsp/type/goods/EYPGoodsSearchResult.jsp?lucenelist=0&community="+teasession._strCommunity+"&t255_q="+java.net.URLEncoder.encode(q,"UTF-8");
}

StringBuffer param=new StringBuffer();
param.append("?node=").append(teasession._nNode);
param.append("&community=").append(teasession._strCommunity);
//param.append("&lucenelist=").append(lucenelist);


String _strGoodstype=request.getParameter("t34_goodstype");


int pos=0;
String _strPos=request.getParameter("pos");
if(_strPos!=null)
{
	pos=Integer.parseInt(_strPos);
}

tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Lucene");
/*
java.io.File f=new java.io.File(application.getRealPath("/res/" + teasession._strCommunity + "/searchindex_"+lucenelist+"/"+teasession._nLanguage));
if(!f.exists())
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"1169017432031"),"UTF-8"));//没有发现索引文件
  return;
}*/


%><html>
<head>

<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">

</head>
<body id="companysrhbody">
<%--
<form name=formcsf2 action="/jsp/type/goods/EYPGoodsSearchResult.jsp" method="get" target="iframe_gsr" onSubmit="return submitText(this.t255_q,'请输入关键字!');">
<input type=hidden name=Node value="<%=teasession._nNode%>" >
<input type=hidden name=community value="<%=teasession._strCommunity%>" >
<input type=hidden name=lucenelist value="<%=lucenelist%>" >
<input type=hidden name=t34_goodstype value="<%if(_strGoodstype!=null)out.print(_strGoodstype);%>" >
<table id="comsearch">
  <tr>
    <td>&nbsp;</td>
    <td><input name="t255_q" type="text" value="<%=q%>"></td>
    <td><input type="submit" value="提交"></td>
  </tr>
 
</table>
</form>--%>
<script>
function s(v)
{
  formcsf2.t34_goodstype.value=v;
  formcsf2.submit();
}
function f_expand(v)
{
	var d=document.getElementById("div"+v);
	var i=document.getElementById("img"+v);
	if(d.style.display=="none")
	{
		d.innerHTML="<img src=/tea/image/public/load.gif>load...";
		d.style.display="";
		i.src='/tea/image/tree/tree_blank.gif';
		var step=0;
		sendx("/jsp/type/goods/EYPGoodsSearch.jsp?ajax=ON&community=<%=teasession._strCommunity%>&father="+v+"&step="+(step+1),
		function(data)
		{
			d.innerHTML=data;
		});
	}else
	{
		d.style.display="none";
		i.src='/tea/image/tree/tree_plus.gif';
	}
}
</script>

<div id="goodssearch" >

<h3 id=goodstypeh3 style="background-color:#EEF7FC">产品分类</h3>

<div id="goodstype">
<span id=goodstypetree><img src=/tea/image/tree/tree_blank.gif></span> <a href=javascript:s(''); >所有类型</a><br>
<%

int root=GoodsType.getRootId(teasession._strCommunity);
String str=getTypeTree(root,teasession._nLanguage,0);
out.print(str);

%>
</div>

</div>

<iframe id=iframe_gsr name=iframe_gsr src="<%=url%>" frameborder="0"  ></iframe>

</body>
</html>
