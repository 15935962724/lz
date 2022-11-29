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
//info=info.replaceAll("<","&lt;");

String nexturl=request.getParameter("nexturl");
nexturl = tea.entity.node.Report.getHtml2(nexturl);

/*
if(nexturl!=null)
{
  info+=("<script>setTimeout(\"redirect('"+nexturl+"');\",7000);</script>");
}
*/

tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);

Resource r=new Resource();
r.add("/tea/resource/Photography");


info = tea.entity.node.Report.getHtml2(info);


%><html>

<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <script type="">

  function redirect(url)
  {
    window.location.replace(url);
  }
  </script>
  </head>
  <body class="infoAlert">

<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>

  <h1><%=r.getString(teasession._nLanguage, "7318072012")%></h1><!-- 提示 -->
  <div id="head6"><img height="6" alt=""></div>
    <DIV ID="edit_Bodydiv">
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr><td><%=info%>&nbsp;<a href="javascript:history.go(-1)"><%=r.getString(teasession._nLanguage, "1315968283")%></a></td></tr><!-- 返回 -->
      </table>
    </DIV>


    <div id="head6"><img height="6" src="about:blank"></div>
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
  </body>
</html>
