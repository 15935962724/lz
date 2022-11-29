<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.ui.*" %><%@page import="java.io.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.resource.Resource" %><%

TeaSession teasession = new TeaSession(request);
Resource r=new Resource();

String act=teasession.getParameter("act");
String nu=teasession.getParameter("nexturl");

Community community=Community.find(teasession._strCommunity);
int root=community.getNode();

Company c=Company.find(root);
String banner=c.getBanner(teasession._nLanguage);

int len=0;
if(banner!=null)
{
  File f=new File(application.getRealPath(banner));
  len=(int)f.length();
}

CommunityOption co = CommunityOption.find(teasession._strCommunity);
String et=co.get("eyptemplate");
String es=co.get("eypstyle");

%><html>
<head>
<!--
<link type="text/css" rel="stylesheet" href="/tea/image/eyp/style/<%=es%>.css">
<link type="text/css" rel="stylesheet" href="/tea/image/eyp/template/<%=et%>.css">
-->
<link type="text/css" rel="stylesheet" href="/res/<%=teasession._strCommunity%>/cssjs/community.css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="head6"><img height="6" src="about:blank"></div>

<form name=form1 enctype="multipart/form-data" method=POST action="/servlet/EditCompanyWindows">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="nexturl" value="<%=nu%>">
<input type="hidden" name="act" value="<%=act%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Picture")%>:</td>
    <td>
      <input type="file" name="file">
      <%
      out.print(r.getString(teasession._nLanguage,"fj14p1yp")+":");
      if(act.equals("ad0")||act.equals("ad1"))
      {
        out.print("80 x 200");
      }else
      if(act.equals("ad2"))
      {
        out.print("480 x 80");
      }else
      if(act.equals("ad3"))
      {
        out.print("310 x 60");
      }else
      if(act.equals("banner"))
      {
        out.print("800 x 120");
      }else
      if(act.equals("logo"))
      {
        out.print("80 x 32");
      }
      %>
      <%--
      if(len>0)
      {
        out.print("<a href="+banner+" target=_blank>"+len+ r.getString(teasession._nLanguage, "Bytes")+"</a>");
      }
      --%>
      </td>
  </tr>
  <%
  if(act.startsWith("ad"))
  {
    int i=Integer.parseInt(act.substring(2));
    String ads[]=c.getAdLink(teasession._nLanguage);
    out.print("<tr><td>"+r.getString(teasession._nLanguage, "Anchor")+":</td><td><input type=text name=link value='");
    if(ads[i]!=null)
    {
      out.print(ads[i]);
    }
    out.print("' size=40>"+r.getString(teasession._nLanguage, "fj14p1yq")+":http://www.baidu.com</td></tr>");
  }else if(act.equals("logo"))
  {
    out.print("<tr><td>"+r.getString(teasession._nLanguage, "fj14p1yr")+":</td><td><input type=text name=link value='");
    out.print(Node.find(root).getSubject(teasession._nLanguage));
    out.print("' size=40></td></tr>");
  }
  %>
</table>

<input type="submit" value="<%=r.getString(teasession._nLanguage, "fj14p1y4")%>">
<input type="button" value="<%=r.getString(teasession._nLanguage, "fj14p1yo")%>" onClick="window.close();">
</form>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
