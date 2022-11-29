<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.entity.admin.cebbank.*" %><%@page import="java.util.*" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.TeaSession" %><%
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

int rootid=AnnuityEnt.getRootId(teasession._strCommunity);


AnnuityEnt node1 = AnnuityEnt.find(rootid);

%><%!

private void  tree1(java.io.Writer jw,int nodecode,int step,TeaSession teasession)throws Exception
{
  for(Enumeration enumeration = AnnuityEnt.findByFather(nodecode); enumeration.hasMoreElements(); )
  {
    int j = ((Integer)enumeration.nextElement()).intValue();
    int count=AnnuityEnt.countByFather(j);
    AnnuityEnt node1 = AnnuityEnt.find(j);
    for(int loop=1;loop<step;jw.write("<img src=/tea/image/tree/tree_line.gif  align=absmiddle >"),loop++);
    if(step>0)jw.write("<img src=/tea/image/tree/tree_line.gif  align=absmiddle >");
    if(count>0)
    {
      jw.write("<A HREF=\"javascript:f_click("+j+","+step+");\" ><img id=img"+j+" src=/tea/image/tree/tree_plus.gif  align=absmiddle></A>");
    }else//功能菜单
    {
      jw.write("<IMG SRC=/tea/image/tree/tree_blank.gif BORDER=0 align=absmiddle ID=img"+j+" />");
    }
    jw.write(" <A target=annuityent_edit href=EditAnnuityEnt.jsp?community="+teasession._strCommunity+"&node="+teasession._nNode+"&annuityent="+j+">"+node1.getName(teasession._nLanguage)+"</A><br/>");

    //if(count>0)
    {
      jw.write("<Div id=divid"+j+" style=display:none></Div>");
    }
  }
}

private String deploy(int id)throws Exception
{
  AnnuityEnt obj = AnnuityEnt.find(id);
  if(obj.getFather()!=0)
  {
      int count=AnnuityEnt.countByFather(id);
	  if(count<1)
	  {
		 return deploy(obj.getFather());
	  }else
 	  {
        return deploy(obj.getFather())+"var id"+id+"=setInterval(\"if(document.all('divid"+id+"')!=null){ f_click("+id+",step++); clearInterval(id"+id+"); }\",50); \r\n";//+"document.getElementById('divid"+id+"').style.display='';if(document.getElementById('img"+id+"').src.indexOf('tree_plus.gif')!=-1)document.getElementById('img"+id+"').src='/tea/image/tree/tree_minus.gif';";
      }
  }else
  {
    return "";
  }
}

%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function f_click(j,step)
{
  var divid=document.all("divid"+j);
  //alert(divid);
  if(divid.style.display=="")
  {
    divid.style.display="none";
    document.all("img"+j).src="/tea/image/tree/tree_plus.gif";
  }else
  {
    divid.style.display="";
    document.all("img"+j).src="/tea/image/tree/tree_minus.gif";

	if(divid.innerHTML=="")
	{
	  divid.innerHTML="　　<img src=/tea/image/public/load.gif>load...";

	  sendx("?ajax=ON&community=<%=teasession._strCommunity%>&father="+j+"&step="+(step+1),
	  function(data)
	  {
		eval("divid"+j).innerHTML=data;
	  } );
	}
  }
}
</script>
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

<A target="annuityent_edit" href="EditAnnuityEnt.jsp?community=<%=teasession._strCommunity%>&node=<%=teasession._nNode%>&annuityent=<%=rootid%>"><%=node1.getName(teasession._nLanguage)%></A><br/>
<%
tree1(out,rootid,0,teasession);

//自动展开
if(request.getParameter("annuityent")!=null)
{
 out.print("<SCRIPT>var step=0;"+deploy(Integer.parseInt(request.getParameter("annuityent")))+"</SCRIPT>");
}
%>
</BODY>
</html>



