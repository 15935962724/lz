<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="tea.ui.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.admin.*" %>
<%request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

String url=request.getParameter("url");
String tree=request.getParameter("tree");

Community c=Community.find(teasession._strCommunity);
AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());
String desktop=c.getDesktop();

if(desktop==null||desktop.length()<1)
{
  desktop=("DefaultDesktop.jsp");
}



if(url==null)
{
  url=desktop;
}


if(tree==null)
{
//  if(aur.getRole().contains("358"))
//  {
//    tree="index_leftup.jsp?id=130506&language=1&node="+teasession._nNode;
//  }else if(aur.getRole().length()>5)
//  {
//
//
//    tree="index_leftup.jsp?id=130552&language=1&node="+teasession._nNode;
//  }else
//  {
    tree="about:blank";//index_leftup.jsp?node="+teasession._nNode;
//  }
}
%>
<script>
function f_cols(i,v)
{
	 var f=document.getElementById("frame2");
  var arr=f.cols.split(",");
  arr[i]=v;
  f.cols=arr[0]+","+arr[1]+","+arr[2];
}
/*setInterval(function a1s()
{
  var doc=m.document;
  if(!doc.title)
  {
    var h1=doc.getElementsByTagName("H1")[0];
    if(h1)
    {
      h1=h1.innerHTML;
      var j=h1.indexOf('<'); if(j>0)h1=h1.substring(0,j);
      doc.title=h1;
    }
  }
  var newt=doc.title+" <%=c.getName(teasession._nLanguage)%>";
  if(document.title!=newt)document.title=newt;
},200);*/
</script>
<!DOCTYPE html>
<head>
    <meta name="renderer" content="webkit">
</head>
<html>

<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">

<frameset  id="frame" rows="85,36,*"  frameborder="NO" border="0" framespacing="0">

	<frame src="index_headtop.jsp?community=<%=teasession._strCommunity%>&url=<%=java.net.URLEncoder.encode(desktop,"UTF-8")%>" name="topFrame" id="topFrame" marginheight="0" scrolling="no"/>
	<frame name="MenuFrameyu" id="MenuFrameyu" src="/jsp/admin/index_profile2.jsp?community=<%=teasession._strCommunity%>&showcount=10&igd=0" marginheight="0" scrolling="no">
	<frameset id="frame2" cols="200,*,0" rows="*" frameborder="no" border="0" framespacing="0" >
		<frame id="MenuFrame" name="MenuFrame" src="<%=tree%>" marginheight="0" scrolling="yes" >
		<frame name="m" src="<%=url%>" marginheight="0" scrolling="yes" id='Fright'>
		<!-- <frame id="RightFrame" name="RightFrame" src="/jsp/admin/Lief.jsp"> -->

	<frame src="/ROOT/jsp/admin/UntitledFrame-4"></frameset>

</frameset><noframes></noframes>





</html>
