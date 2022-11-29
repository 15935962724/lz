<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="java.util.Date"%>

<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
%>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<form name="form1Search" action="/html/folder/2199127-1.htm" method="POST">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>

 <div class="RepertoireSearch">剧目<br/><input type="text" name="subject" value="" ></div>
  <div class="VenuesSearch">场地<br/>
        <select name="venues">
           <option value="0">--演出场馆--</option>
           <%
 
              java.util.Enumeration en = Node.find(" and community="+DbAdapter.cite(teasession._strCommunity)+" and type=92 and hidden = 0",0,100);
              while(en.hasMoreElements())
              {
                int nid = ((Integer)en.nextElement()).intValue();
                Node nobj = Node.find(nid);
                out.print("<option value="+nid);
              //  if(venues==nid)
              //  {
                     // out.print(" selected ");
               // }
                out.print(">"+nobj.getSubject(teasession._nLanguage));
                out.print("</option>");
              }

           %>
        </select>
    </div>
  <div class="dateSearch">日期<br/>
       <div> 从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="" readonly="readonly">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1Search.time_c');" /></div>
        <div>到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="" readonly="readonly">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1Search.time_d');" /></div>
        </div>
  <div class="submitSearch"><input type="submit" value="查询"/></div>





  </form>


