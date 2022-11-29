<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@page  import="tea.entity.node.*" %>
<%@page  import="tea.entity.site.*" %>
<%@ page import="java.util.*" %>
<%@ page import="tea.ui.*" %>

<%@ page import="tea.html.*" %>
<%
TeaSession teasession=new TeaSession(request);
Community community=Community.find(teasession._strCommunity);
String type=request.getParameter("type");
%>


<%
if(type==null)
{
%>
   document.write("<select name='t39_media' id='lzj_kuan1'><option value='' >全部</option><%
     java.util.Enumeration e = Media.find(teasession._strCommunity,39,"  and m.media in (select media from medialayer)",0,Integer.MAX_VALUE);
     for(int i=0;e.hasMoreElements();i++)
     {
       int nid = ((Integer)e.nextElement()).intValue();
       Media nobj = Media.find(nid);
        out.print("<option value="+nid+">"+nobj.getName(teasession._nLanguage)+"</option>");
     }
     %><option value='728' >总裁</option></select>");
<%}else{%>
      document.write("<select name='classes'  id='lzj_kuan1'><option  value=''>---------------</option><%
        Enumeration eu = Classes.find(" and community="+DbAdapter.cite(teasession._strCommunity),0,Integer.MAX_VALUE);
        for(int i=0;eu.hasMoreElements();i++)
        {
          int idc= Integer.parseInt(String.valueOf(eu.nextElement()));
          Classes objty = Classes.find(idc);
          out.print("<option value="+idc+">"+objty.getName()+"</option>");
        }
        %></select>");
<%}%>
