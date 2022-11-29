<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.io.*" %><%@page import="tea.entity.admin.*"%><%@page import="tea.resource.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.ui.*" %><%!
Resource r=new Resource();
private String tree_1(int node,int lang,String order,String target,String role,String member,int step)throws Exception
{
  StringBuilder h=new StringBuilder();
  java.util.Enumeration enumer=Node.find(" AND hidden = 0 AND father="+node+" ORDER BY "+order,0,200);
  while(enumer.hasMoreElements())
  {
    int j=((Integer)enumer.nextElement()).intValue();
    Node n=Node.find(j);
    
    AdminUsrRole arobj = AdminUsrRole.find(n.getCommunity(),member);
    
    if(n.getType()>2&&AdminRole.isEx(arobj.getRole(),j,member))
    {
      tea.html.Anchor a2=new tea.html.Anchor("/servlet/Node?node="+j,n.getSubject(lang));
      a2.setTarget(target);
     // h.append("<div id=divnode_"+j+" ><img src='/tea/image/tree/tree_blank.gif' BORDER=0 align=absmiddle id=img"+j+" />"+a2.toString()+"</div>");
        h.append("<div id=leftuptree"+step+" ><img src='/tea/image/tree/tree_blank.gif' BORDER=0 align=absmiddle id=img"+j+" />"+a2.toString()+"</div>");
    }else  if(AdminRole.isEx(arobj.getRole(),j,member))
    {
      h.append(tree_0(n,lang,target,role,member,step));
    }
  } 
 
  return h.toString();
}
private String tree_0(Node n,int lang,String target,String role,String member,int step)throws Exception
{
  		int j=n._nNode,type=n.getType();
 	 	StringBuilder h=new StringBuilder();
 	 	
	  //h.append("<div id=divnode_"+j+" ><img src='/tea/image/tree/tree_"+(type==0?"plus":"minus")+".gif' align=absmiddle id=img"+j);
	  h.append("<div id=leftuptree"+step+" ><img src='/tea/image/tree/tree_"+(type==0?"plus":"minus")+".gif' align=absmiddle id=img"+j);
	  if(type==0)
	  {
		 
		 // h.append(" onclick='f_c("+j+");'");
		  h.append(" onclick='f_c("+j+","+step+");'");
	  }
	  h.append(" />");
	     
	  if(NodeRole.isRole2(n.getCommunity(),member,j,12))//显示列表修改
	  {		  
	 	 h.append("<a href='/jsp/general/AdminNodeLists.jsp?node="+j+"&order=time' target='"+target+"'>"+n.getSubject(lang)+"</a>");
	  }else if(type==0){
		  h.append("<a href='###' onclick='f_c("+j+","+step+");' >"+n.getSubject(lang)+"</a>");
	  }else{
		  h.append("<a href='/jsp/general/AdminNodeLists.jsp?node="+j+"&order=time' target='"+target+"'>"+n.getSubject(lang)+"</a>");
	  }
		  
	  h.append("<div class='tree' id='divid"+j+"' style='display:none'></div></div>");
  

  return h.toString();
}
%>

<%
TeaSession teasession=new TeaSession(request);

String order=request.getParameter("order");
if(order==null)order="sequence";

String target=request.getParameter("target");
if(target==null)target="m";

AdminUsrRole arobj = AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());

String role = arobj.getRole();



out.print("<script>");
out.print("window.open('/jsp/general/AdminNodeLists2.jsp?node="+teasession._nNode+"', '"+target+"');"); 
out.print("</script>");
 

if(request.getParameter("ajax")!=null)
{
	int s = Integer.parseInt(request.getParameter("step"));
  out.print(tree_1(teasession._nNode,teasession._nLanguage,order,target,role,teasession._rv._strR,s+1));
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
      sendx("/jsp/admin/AdminNodeTree.jsp?ajax=ON&node="+j+"&step="+step,function(data)
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
  out.print("<frameset cols='208,*' frameborder='no' border='0' framespacing='0'><frame src='/jsp/admin/AdminNodeTree.jsp?node="+teasession._nNode+"&target=m2' /><frame src='about:blank' name='m2' /></frameset>");
  return;
}
%>
</head>
<body id="leftup">
<div id="leftupdiv2">
<div id="leftup_bottom">


<%
if(ns==null)
{
  Node node=Node.find(teasession._nNode);
  out.print("<span class='title'><img src=\"/tea/image/other/img-globe.gif\" width=\"16\" height=\"16\">"+node.getSubject(teasession._nLanguage)+"</span>");//<a href='/jsp/general/NodeLists.jsp?node="+teasession._nNode+"' target='"+target+"'>
 
  out.print(tree_1(teasession._nNode,teasession._nLanguage,order,target,role,teasession._rv._strR,0));
}else
{
  out.print("<img src='/tea/image/other/img-globe.gif'>"+info+"<br>");
  String arr[]=ns.split(",");
  for(int i=0;i<arr.length;i++)
  { 
    out.print(tree_0(Node.find(Integer.parseInt(arr[i])),teasession._nLanguage,target,role,teasession._rv._strR,0));
  }
}
%>
</div>
</div>
</body>
</html>
