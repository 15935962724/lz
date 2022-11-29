<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="java.util.*" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


if(request.getParameter("ajax")!=null)
{
  int step=Integer.parseInt(request.getParameter("step"));
  int father=Integer.parseInt(request.getParameter("father"));
  tree1(out,father,step,teasession);
  return;
}

AdminFunction obj=AdminFunction.getRoot(teasession._strCommunity,teasession._nStatus);

%>
<%!

private void  tree1(java.io.Writer jw,int nodecode,int step,TeaSession teasession)throws Exception
{
  ArrayList al=AdminFunction.find(" AND father="+nodecode+ " ORDER BY sequence",0,200);
  for(int i=0;i<al.size();i++)
  {
    AdminFunction obj = (AdminFunction)al.get(i);
    int j=obj.id;
    for(int loop=0;loop<step;jw.write("　&nbsp;"),loop++);
    if(obj.getType()==0)
    {
      jw.write("<a href=\"###\" onclick=f_click("+j+","+step+"); ><img id=img"+j+" src=/tea/image/tree/tree_plus.gif  align=absmiddle></a>");
    }else//功能菜单
    {
      jw.write("<img src=/tea/image/tree/tree_blank.gif BORDER=0 align=absmiddle ID=img"+j+" />");
    }
    jw.write(" <a target=function_fun href=EditAdminFunction.jsp?community="+teasession._strCommunity+"&status="+obj.getStatus()+"&id="+j+">");
    if(!obj.isHidden())
    jw.write("<STRIKE>"+obj.getName(teasession._nLanguage)+"</STRIKE>");
    else
    jw.write(obj.getName(teasession._nLanguage));
    jw.write("</a><br/>");

    jw.write("<div id=divid"+j+" style=display:none></div>\r\n");
  }
}

private String deploy(int id)throws Exception
{
  AdminFunction obj = AdminFunction.find(id);
  int fid=obj.getFather();
  return (fid>0?deploy(fid):"")+"var id"+id+"=setInterval(\"if(document.getElementById('divid"+id+"')!=null){ f_click("+id+",step++); clearInterval(id"+id+"); }\",50); \r\n";//+"document.getElementById('divid"+id+"').style.display='';if(document.getElementById('img"+id+"').src.indexOf('tree_plus.gif')!=-1)document.getElementById('img"+id+"').src='/tea/image/tree/tree_minus.gif';";
}

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function f_click(j,step)
{
  var divid=document.getElementById("divid"+j);
  //alert(divid);
  if(divid.style.display=="")
  {
    divid.style.display="none";
    document.getElementById("img"+j).src="/tea/image/tree/tree_plus.gif";
  }else
  {
    divid.style.display="";
    document.getElementById("img"+j).src="/tea/image/tree/tree_minus.gif";

	if(divid.innerHTML=="")
	{
	  divid.innerHTML="　　<img src=/tea/image/public/load.gif>load...";

	  sendx("?ajax=ON&community=<%=teasession._strCommunity%>&father="+j+"&step="+(step+1),
	  function(data)
	  {
		eval("divid"+j).innerHTML=data;
	  });
	}
  }
}
</script>
<style type="text/css">
<!--
body{height:auto;text-align:left;
margin:0px 0px 0px 0px;padding:0px 0px 0px 0px;
}
img{ border:0px}
H1{height:24px;width:82%;color:#007fb2;line-height:24px;padding:0px 8px 0px 7px;font-size:14px;margin:7px 0px 0px 10px;border:1px solid #1580b9;border-bottom:none;float:left;display:block; background-attachment:scroll; background-position-x:0%; background-position-y:0%;background-color:rgb(255,255,255);}
.cd{width:100%;height:30px;float:left;}
.cd span{font-weight:bold;width:78px;text-align:center;background:url(/res/jskxcbs/structure/cdbg.jpg) center no-repeat;font-size:14px;color:#007fb2;height:25px;line-height:25px;margin:7px 0px 0px 10px;display:block;}
.bgtree{border:1px solid #d7d7d7;background:#E6F2FB;margin:0 4%;padding:2%;}
.bgtree a{color:#069; text-decoration:none;line-height:18px;}
#tablecenter {width:92%;margin:50px 4% 10px 4%;font-size: 9pt;border-collapse: collapse;}
#tablecenter td {
background: #E6F2FB;
font-size: 12px;
border: 1px solid #d7d7d7;
min-height: 30px;
padding: 5px 5px 5px 10px;
line-height: 150%;}
-->
</style>
</head>
<body>

<h1>菜单管理</h1>
<table id="tablecenter" cellspacing="0">
<tbody>
  <tr>
    <td><input name="name" value="" size="12"> <input type="submit" value="查询" style="float:right !important;"></td>
  </tr>
</tbody>
</table>
<div class="bgtree">
<a target=function_fun href="EditAdminFunction.jsp?community=<%=teasession._strCommunity%>&status=<%=obj.getStatus()%>&id=<%=obj.id%>"><%=obj.getName(teasession._nLanguage)%></a><br/>
<%
tree1(out,obj.id,0,teasession);

//自动展开
String tmp=request.getParameter("id");
if(tmp!=null)
{
  AdminFunction af=AdminFunction.find(Integer.parseInt(tmp));
  out.print("<script>var step=0;"+deploy(af.getType()==0?af.getId():af.getFather())+"</script>");
}
%>
</div>
</body>
</html>
