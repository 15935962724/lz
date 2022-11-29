<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.io.*" %><%@page import="tea.resource.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.ui.*" %><%!
Resource r=new Resource();
private String tree_1(int node,int lang,String order,String target,int step,String sql)throws Exception
{
  StringBuilder h=new StringBuilder();
  String s = "";
  if(sql==""){
	  s = " AND father="+node;
  }else
	{
	  s = " and (type=1 or type =0) ";
	}
  java.util.Enumeration enumer=Node.find(" AND hidden = 0 "+s+"  AND exists (select node from NodeLayer nl where nl.node=n.node and nl.subject like "+DbAdapter.cite("%"+sql+"%")+" )"+" ORDER BY "+order,0,200);
  if(!enumer.hasMoreElements())
  {
      h.append("<br>暂无记录");
  }
  while(enumer.hasMoreElements())
  {
    int j=((Integer)enumer.nextElement()).intValue();
    Node n=Node.find(j);
   // System.out.println(j); 
    if(n.getType()>2)
    {
      tea.html.Anchor a2=new tea.html.Anchor("/servlet/Node?node="+j,n.getSubject(lang));
      a2.setTarget(target);
     // h.append("<div id=divnode_"+j+" ><img src='/tea/image/tree/tree_blank.gif' BORDER=0 align=absmiddle id=img"+j+" />"+a2.toString()+"</div>");
      h.append("<div id=leftuptree"+step+" ><img src='/tea/image/tree/tree_blank.gif' BORDER=0 align=absmiddle id=img"+j+" />"+a2.toString()+"</div>");
    }else
    {
      h.append(tree_0(n,lang,target,step));
    }
  }
  return h.toString();
}
private String tree_0(Node n,int lang,String target,int step)throws Exception
{
  int j=n._nNode,type=n.getType();
  StringBuilder h=new StringBuilder();
  h.append("<div id=leftuptree"+step+" ><img src='/tea/image/tree/tree_"+(type==0?"plus":"minus")+".gif' align=absmiddle id=img"+j);
  if(type==0)h.append(" onclick='f_c("+j+","+step+");'");
  h.append(" /><a href='/jsp/general/NodeReport.jsp?node="+j+"' target='"+target+"'>"+n.getSubject(lang)+"</a>");
  h.append("<div class='tree' id='divid"+j+"' style='display:none'></div></div>");
  return h.toString();
} 
%><%
TeaSession teasession=new TeaSession(request);

String order=request.getParameter("order");
if(order==null)order="sequence";

String target=request.getParameter("target");
if(target==null)target="m";
String sql =request.getParameter("sql");
if(sql==null){sql="";}else{
	
	// out.print(tree_1(teasession._nNode,teasession._nLanguage,order,target,0,sql));
}

if(request.getParameter("ajax")!=null)
{
	int s = Integer.parseInt(request.getParameter("step"));
	
  out.print(tree_1(teasession._nNode,teasession._nLanguage,order,target,s+1,""));
  return;
}

String info=request.getParameter("info");

String ns=request.getParameter("nodes");

boolean isFrame=request.getParameter("frame")!=null;
  
%>
<!--
参数:
frame: 是否在框架中.
order: 排序
target: 打开方式
-->
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function f_c(j,step)
{
  var d=document.getElementById("divid"+j);
 
  if(d.style.display=='')
  {
    d.style.display='none';
    document.all("img"+j).src='/tea/image/tree/tree_plus.gif';
  }else
  {
    if(d.innerHTML.length==0)
    {
      d.innerHTML="<img src='/tea/image/public/load.gif'>load...";
   
      sendx("/jsp/admin/NodeReportTree.jsp?ajax=ON&node="+j+"&step="+step,function(data)
      {
        if(data=="")data="暂无";
        d.innerHTML=data;
      } );
    }
    d.style.display="";
    document.all("img"+j).src="/tea/image/tree/tree_minus.gif";
  }
}
</script>
<style type="text/css">.tree{padding-left:15px;}</style>
<%
if(isFrame)
{
  out.print("<frameset cols='208,*' frameborder='no' border='0' framespacing='0'><frame src='/jsp/admin/NodeReportTree.jsp?node="+teasession._nNode+"&target=m2' /><frame src='about:blank' name='m2' /></frameset>");
  return;
}
%>
</head>
<body id="leftup">
<div id="leftupdiv2">
<div id="leftup_bottom" >
<script>
	function f_nn()
	{
		 var nodename = document.getElementById('nodename').value;
 		 window.location.href=encodeURI('/jsp/admin/NodeReportTree.jsp?node=<%=teasession._nNode%>&sql='+nodename);
	}
</script>
<input type="text" id="nodename" name="nodename" value="<%=Node.getNULL(sql) %>"  size=10>
<input type="button" value="GO" onclick="f_nn();">
<br/>
<%
if(ns==null)
{
  Node node=Node.find(teasession._nNode);
  //out.print("<span id='leftuptree0'><img src=\"/tea/image/other/img-globe.gif\" width=\"16\" height=\"16\"><a href='/jsp/general/NodeLists.jsp?node="+teasession._nNode+"' target='"+target+"'>"+node.getSubject(teasession._nLanguage)+"</a></span>");
  out.print("<span class='title'><img src=\"/tea/image/other/img-globe.gif\" width=\"16\" height=\"16\"><a href='/jsp/general/NodeReport.jsp?node="+teasession._nNode+"' target='"+target+"'>"+node.getSubject(teasession._nLanguage)+"</a></span>");
 
  
  out.print(tree_1(teasession._nNode,teasession._nLanguage,order,target,0,sql));
}else
{
  out.print("<img src='/tea/image/other/img-globe.gif'>"+info+"<br>");
  String arr[]=ns.split(",");
  for(int i=0;i<arr.length;i++)
  {
    out.print(tree_0(Node.find(Integer.parseInt(arr[i])),teasession._nLanguage,target,0));
  }
}
%>
</div>
</div>
</body>
</html>
