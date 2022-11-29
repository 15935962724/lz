<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.lvyou.*"%>
<%@page import="tea.resource.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.member.*"%>
<%
request.setCharacterEncoding("UTF-8");
    	TeaSession teasession = new TeaSession(request);
     int  id = 0;
     if(teasession.getParameter("id")!=null && teasession.getParameter("id").length()>0)
     {
         id = Integer.parseInt(teasession.getParameter("id"));
     }

     ArrayList<LvyouCity> citis = LvyouCity.find2(id);
%>
     <select name="city" style="width:150px;">
     <option value="0">------------</option>
     <%
     for (int i = 0; i < citis.size(); i++) {
 		LvyouCity city = (LvyouCity) citis.get(i);
 		out.print("<option value='"+city.getId()+"'>"+ city.getName() + "</option>");
 	}
     %>
 	</select>
 