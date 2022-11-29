<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.admin.orthonline.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.*"%>
<%

request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);

int ids = 0;
if(teasession.getParameter("ids")!=null && teasession.getParameter("ids").length()>0)
{
  ids = Integer.parseInt(teasession.getParameter("ids"));
}
CaseCollection ccobj = CaseCollection.find(ids);
String  str="",strpath="";
String name="";


String shownum="";
if(teasession.getParameter("shownum")!=null && teasession.getParameter("shownum").length()>0)
{
  shownum= teasession.getParameter("shownum");
  if(shownum.equals("1"))
  {
    if(teasession.getParameter("str")!=null && teasession.getParameter("str").length()>0)
    {
      str= teasession.getParameter("str");
      if("first".equals(str))
      {
        strpath = ccobj.getYxfirstpath();
        name  = ccobj.getYxfirstpathname();
      }
      else if("last".equals(str))
      {
        strpath = ccobj.getYxlastpath();
        name  = ccobj.getYxlastpathname();
      }

    }
  }
  if(shownum.equals("2"))
  {
    if(teasession.getParameter("str")!=null && teasession.getParameter("str").length()>0)
    {
      str= teasession.getParameter("str");
      if("first".equals(str))
      {
        strpath = ccobj.getYxfirstpath2();
         name  = ccobj.getYxfirstpathname2();
      }
      else if("last".equals(str))
      {
        strpath = ccobj.getYxlastpath2();
         name  = ccobj.getYxlastpathname2();
      }
    }
  }
  if(shownum.equals("3"))
  {
    if(teasession.getParameter("str")!=null && teasession.getParameter("str").length()>0)
    {
      str= teasession.getParameter("str");
      if("first".equals(str))
      {
        strpath = ccobj.getYxfirstpath3();
         name  = ccobj.getYxfirstpathname3();
      }
      else if("last".equals(str))
      {
        strpath = ccobj.getYxlastpath3();
         name  = ccobj.getYxlastpathname3();
      }
    }
  }
  if(shownum.equals("4"))
  {
    if(teasession.getParameter("str")!=null && teasession.getParameter("str").length()>0)
    {
      str= teasession.getParameter("str");
      if("first".equals(str))
      {
        strpath = ccobj.getYxfirstpath4();
         name  = ccobj.getYxfirstpathname4();
      }
      else if("last".equals(str))
      {
        strpath = ccobj.getYxlastpath4();
         name  = ccobj.getYxlastpathname4();
      }
    }
  }
  if(shownum.equals("5"))
  {
    if(teasession.getParameter("str")!=null && teasession.getParameter("str").length()>0)
    {
      str= teasession.getParameter("str");
      if("first".equals(str))
      {
        strpath = ccobj.getYxfirstpath5();
         name  = ccobj.getYxfirstpathname5();
      }
      else if("last".equals(str))
      {
        strpath = ccobj.getYxlastpath5();
         name  = ccobj.getYxlastpathname5();
      }
    }
  }

}

%>
<head><link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
</head>
<body bgcolor="#ffffff">
<table>
  <tr>
    <td><img alt="" src="<%=strpath%>" /></td>
  </tr>
  <tr>
    <td>图片名称：<%=name%></td>
  </tr>
</table>
</body>
