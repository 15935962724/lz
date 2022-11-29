<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.entity.admin.GoodsType"%><%@ page import="java.util.*"%><%!
String path;
private void  tree1(java.io.Writer jw,int father,int language,int step,String community)throws Exception
{
  StringBuffer sb=new StringBuffer();
  for(int loop=0;loop<step;sb.append("<img src="+path+"/tea/image/tree/tree_line.gif align=absmiddle>"),loop++);
  for(Enumeration enumeration = GoodsType.findByFather(father); enumeration.hasMoreElements(); )
  {
	GoodsType node = (GoodsType)enumeration.nextElement();
    int j=node.getGoodstype();

    if(GoodsType.countByFather(j)<1)
    {
      tea.html.Anchor a2=new tea.html.Anchor("EditGoodsType.jsp?community="+community+"&goodstype="+j,node.getName(language));
      a2.setTarget("function_fun");
      jw.write("<div>"+sb.toString()+"<IMG SRC="+path+"/tea/image/tree/tree_blank.gif BORDER=0 align=absmiddle ID=img"+j+" />"+a2.toString()+"</div><Div id=divid"+j+" style=display:none></Div>");
    }else
    {
      tea.html.Anchor a=new tea.html.Anchor("javascript:void(0);","<IMG SRC="+path+"/tea/image/tree/tree_plus.gif BORDER=0 align=absmiddle ID=img"+j+" />");

      a.setOnClick("if(divid"+j+".style.display==''){divid"+j+".style.display='none';document.getElementById('img"+j+"').src='"+path+"/tea/image/tree/tree_plus.gif';}else{if(divid"+j+".innerHTML.length==0)sendx('/jsp/type/goods/GoodsTypeList.jsp?ajax=ON&community="+community+"&step="+(step+1)+"&father="+j+"',function(data){divid"+j+".innerHTML=data;} ); divid"+j+".style.display='';document.getElementById('img"+j+"').src='"+path+"/tea/image/tree/tree_minus.gif';}");

      tea.html.Anchor a2=new tea.html.Anchor("EditGoodsType.jsp?community="+community+"&goodstype="+j,node.getName(language));
      a2.setTarget("function_fun");
      jw.write("<div>"+sb.toString()+a.toString()+a2.toString()+"</div><Div id=divid"+j+" style=display:none></Div>");
    }
  }
}

private String deploy(int id,String community)throws Exception
{
  GoodsType obj = GoodsType.find(id);
  if(obj.getFather()!=0)
  {
    return deploy(obj.getFather(),community)+"if(document.getElementById('img"+id+"').src.indexOf('tree_plus.gif')!=-1){if(divid"+id+".innerHTML.length==0)     \r\n"+
    "     sendx('/jsp/type/goods/GoodsTypeList.jsp?ajax=ON&community="+community+"&step='+(++step)+'&father="+id+"',function(d){divid"+id+".innerHTML=d; } );     \r\n"+
    "     divid"+id+".style.display='';               \r\n"+
    "     document.getElementById('img"+id+"').src='/tea/image/tree/tree_minus.gif';}              \r\n";
//    return deploy(obj.getFather())+"document.getElementById('divid"+id+"').style.display='';if(document.getElementById('img"+id+"').src.indexOf('tree_plus.gif')!=-1)document.getElementById('img"+id+"').src='"+path+"/tea/image/tree/tree_minus.gif';";
  }else
  {
    return "";
  }
}
%><%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

path=request.getContextPath();
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
String community=request.getParameter("community");

int step=0;
if(request.getParameter("ajax")!=null)
{
  step=Integer.parseInt(request.getParameter("step"));
  int father=Integer.parseInt(request.getParameter("father"));
  tree1(out,father,teasession._nLanguage,step,community);
  return;
}


if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}





int rootid=GoodsType.getRootId(community);
path=request.getContextPath();

GoodsType node1 = GoodsType.find(rootid);
%>

<html>
  <head>
    <META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<style type="text/css">
<!--
body {text-align:left;
	margin-left: 10px;
	margin-top: 10px;
	margin-right: 0px;
	margin-bottom: 0px;
}
img{ border:0px}
-->
</style></head>
<body>
<hr color="#CB9966" size="1">
<A target=function_fun href=EditGoodsType.jsp?node=<%=teasession._nNode%>&community=<%=community%>&goodstype=<%=rootid%> ><%=node1.getName(teasession._nLanguage)%></A><br/>
<%
tree1(out,rootid,0,teasession._nLanguage,community);


//自动展开
if(request.getParameter("goodstype")!=null)
{
  rootid=Integer.parseInt(request.getParameter("goodstype"));
  out.print("<SCRIPT>var step=1;"+deploy(rootid,community)+"</SCRIPT>");
}
if(request.getParameter("editgoodstype")!=null)
{
  out.print("<SCRIPT>window.open('/jsp/type/goods/EditGoodsType.jsp?node="+teasession._nNode+"&community="+community+"&goodstype="+rootid+"','function_fun');</SCRIPT>");
}
%>

<hr color="#CB9966" size="1">
</BODY>
</html>

