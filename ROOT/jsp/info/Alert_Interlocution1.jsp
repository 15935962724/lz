<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.site.*" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

String info=request.getParameter("info");
if(info==null)
{
  info="您没有权限!";
}

String nexturl=request.getParameter("nexturl");
if(nexturl!=null||nexturl.length()>0)
{
  info+=("<script>setTimeout(\"redirect('"+nexturl+"');\",3000);</script>");
}

Community community=Community.find(teasession._strCommunity);

Resource r=new Resource();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script type="">
function redirect(url)
{
  window.location.replace(url);
}
</script>


  <style>
#bodyvl h1{width:1002px;margin-left:0px;}
#jspbefore #tablecenter{border:1px solid #dfdfdf;width:1002px;margin-bottom:15px;}
</style>
</head>
<body id="bodyvl">
<div id="jspbefore" style="display:none">
<%=community.getJspBefore(teasession._nLanguage)%>
</div>
<h1><%=r.getString(teasession._nLanguage, "提示")%></h1>
  <div id="head6"><img height="6" alt=""></div>
    <DIV ID="edit_Bodydiv">

      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr><td><%=info%></td></tr>
      </table>
    </DIV>

<div id="jspafter" style="display:none">
<%=community.getJspAfter(teasession._nLanguage)%>
</div>
<script>
if(top.location==self.location)
{
  jspbefore.style.display='';
  jspafter.style.display='';
}
</script>

</body>
</html>



