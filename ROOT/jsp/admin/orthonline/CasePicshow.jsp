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
String  str="",path1="",path2="",path3="",path4="",path5="";

if(teasession.getParameter("str")!=null && teasession.getParameter("str").length()>0)
{
  str= teasession.getParameter("str");
  if("first".equals(str))
  {
    if(ccobj.getYxfirstpath()!=null && ccobj.getYxfirstpath().length()>0)
    {
      path1 = ccobj.getYxfirstpath();
    }
    else
    {
      path1="/jsp/admin/orthonline/snap_m.jpg";
    }
    if(ccobj.getYxfirstpath2()!=null && ccobj.getYxfirstpath2().length()>0)
    {
      path2 = ccobj.getYxfirstpath2();
    }
    else
    {
      path2="/jsp/admin/orthonline/snap_m.jpg";
    }
    if(ccobj.getYxfirstpath3()!=null && ccobj.getYxfirstpath3().length()>0)
    {
      path3 = ccobj.getYxfirstpath3();
    }
    else
    {
      path3="/jsp/admin/orthonline/snap_m.jpg";
    } if(ccobj.getYxfirstpath4()!=null && ccobj.getYxfirstpath4().length()>0)
    {
      path4 = ccobj.getYxfirstpath4();
    }
    else
    {
      path4="/jsp/admin/orthonline/snap_m.jpg";
    } if(ccobj.getYxfirstpath5()!=null && ccobj.getYxfirstpath5().length()>0)
    {
      path5 = ccobj.getYxfirstpath5();
    }
    else
    {
      path5="/jsp/admin/orthonline/snap_m.jpg";
    }
  }
  else if("last".equals(str))
  {
    if(ccobj.getYxlastpath()!=null && ccobj.getYxlastpath().length()>0)
    {
      path1 = ccobj.getYxlastpath();
    }
    else
    {
      path1="/jsp/admin/orthonline/snap_m.jpg";
    }
    if(ccobj.getYxlastpath2()!=null && ccobj.getYxlastpath2().length()>0)
    {
      path2 = ccobj.getYxlastpath2();
    }
    else
    {
      path2="/jsp/admin/orthonline/snap_m.jpg";
    }
    if(ccobj.getYxlastpath3()!=null && ccobj.getYxlastpath3().length()>0)
    {
      path3 = ccobj.getYxlastpath3();
    }
    else
    {
      path3="/jsp/admin/orthonline/snap_m.jpg";
    } if(ccobj.getYxlastpath4()!=null && ccobj.getYxlastpath4().length()>0)
    {
      path4 = ccobj.getYxlastpath4();
    }
    else
    {
      path4="/jsp/admin/orthonline/snap_m.jpg";
    } if(ccobj.getYxlastpath5()!=null && ccobj.getYxlastpath5().length()>0)
    {
      path5 = ccobj.getYxlastpath5();
    }
    else
    {
      path5="/jsp/admin/orthonline/snap_m.jpg";
    }
  }
}
%>
<head><link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
  <script type="">
  function f_showpic(path)
  {
    document.getElementById('pic').src=path;
  }
  </script>
  </head>
  <body bgcolor="#ffffff">
  <form action="" name="form1">
  <table>
    <tr>
      <td><input type="button" value="查看图片1" onclick="f_showpic('<%=path1%>')" />
        <input type="button" value="查看图片2" onclick="f_showpic('<%=path2%>')"  />
        <input type="button" value="查看图片3" onclick="f_showpic('<%=path3%>')"  />
        <input type="button" value="查看图片4" onclick="f_showpic('<%=path4%>')"  />
        <input type="button" value="查看图片5" onclick="f_showpic('<%=path5%>')"  /></td>
    </tr>
    <tr>
      <td>

        <img name="pic" alt="" src="<%=path1%>" />


      </td>
    </tr>
  </table>
  </form>
  </body>
