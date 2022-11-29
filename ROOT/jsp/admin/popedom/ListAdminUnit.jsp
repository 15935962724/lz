<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<% request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource().add("/tea/resource/deptuser");

String right=request.getParameter("right");
if(right==null||right.length()==0)
{
  right="/jsp/admin/popedom/EditAdminUsrRole.jsp";
}

int root=AdminUnit.getRootId(teasession._strCommunity);

StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();
boolean unull = false;
String unitname = request.getParameter("unitname");
if(unitname!=null&&unitname.length()>0){
  unull = true;
  sql.append(" AND name like '%"+unitname+"%'");
  param.append("?unitname=").append(unitname);
}

int sum=AdminUnit.countByCommunity(teasession._strCommunity,sql.toString());
%>
<!--<%=root%>-->
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<script>
function f_click(obj,id)
{
  var div=document.getElementById("div"+id);
  if(div&&div.innerHTML!="")
  {
	  var img,dis;
	  if(obj.src.indexOf("tree_blank")!=-1)
	  {
	  	dis="none";
	  	img="/tea/image/tree/tree_plus.gif";
	  }else
	  {
	  	dis="";
	  	img="/tea/image/tree/tree_blank.gif";
	  }
	  div.style.display=dis;
	  obj.src=img;
  }
  obj.focus();
}

function selunit(){
  var un = document.getElementById('unitname').value;
  window.location.href=encodeURI('/jsp/admin/popedom/ListAdminUnit.jsp?community=<%=teasession._strCommunity%>&unitname='+un);
}

function document.onkeydown()
{
  var e=event.srcElement;
  if(event.keyCode==13)
  {
    document.getElementById("sun").click();
    return false;
  }
}
</script>
</head>
<BODY leftMargin="0" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">


<h1 id="h1"><%=r.getString(teasession._nLanguage, "部门列表")%></h1>
<input type="text" id="unitname" style="width:74%;float:left;margin:15px 0px 10px 2%;" name="unitname" value="<%if(unitname!=null){out.print(unitname);}%>"/>&nbsp;<input id="sun" style="float:right;margin:15px 1% 10px 0px;" type="button" value="GO" onClick="selunit();"/>

<script type="">var selectunit=document.getElementById("selectunit");
</script>

<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
<tr><td id=Department>
<%
//if(unitname!=null&&unitname.length()>0){
//
//  Enumeration e = AdminUnit.findByCommunity(teasession._strCommunity,sql.toString());
//  for(int j=0;e.hasMoreElements();j++)
//  {
//    AdminUnit obj=(AdminUnit)e.nextElement();
//    int id=obj.getId();
//
//    out.write("<img onclick=f_click(this,"+id+"); src=/tea/image/tree/tree_blank.gif align=absmiddle>");
//
//    out.write("<a href=/jsp/admin/popedom/EditAdminUsrRole.jsp?community="+teasession._strCommunity+"&adminunit="+id+" target=dept_user>"+obj.getName()+"</a><br>");
//  }
//}else{
  tree(out,teasession._strCommunity,root,teasession._nLanguage,0,r,sql.toString(),unull);
//}
if(sum<1)
{
  out.print("暂无部门");
}
%>
<!--img src="/tea/image/tree/tree_blank.gif" align=absmiddle> <A href="<%=right%>?community=<%=teasession._strCommunity%>&adminunit=0" target="dept_user"><%=r.getString(teasession._nLanguage, "NoDept")%></A-->
</td>
</tr>
</TABLE>

<br/>
<div id="head6"><img height="6" src="about:blank"></div>

</BODY>
</html>


<%!
public static void tree(Writer out,String community,int father,int language,int setp,Resource r,String sql,boolean unull)throws Exception
{

  if(!unull){
    sql += " and father ="+father;
  }

  Enumeration e = AdminUnit.findByCommunity(community,sql);
  for(int j=0;e.hasMoreElements();j++)
  {
    AdminUnit obj=(AdminUnit)e.nextElement();
    int id=obj.getId();
	 out.write("<div class=Department>");
    for(int i=0;i<setp;i++)
    {
      out.write("　&nbsp;");
    }
    out.write("<img onclick=f_click(this,"+id+"); src=/tea/image/tree/tree_blank.gif align=absmiddle>");

    out.write("<a href=/jsp/admin/popedom/EditAdminUsrRole.jsp?community="+community+"&adminunit="+id+" target=dept_user>"+obj.getName()+"</a></div>");
    if(father!=id && !unull){
      out.write("<div id=div"+id+">");
      tree(out,community,id,language,setp+1,r,"",false);
      out.write("</div>");
    }
  }
}
%>



