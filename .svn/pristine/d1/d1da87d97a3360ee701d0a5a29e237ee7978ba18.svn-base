<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.entity.node.*"%>
<%@ page import="tea.html.*"%>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.ui.TeaServlet"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%@ page import="tea.entity.site.*"%>
<%@ page import=" tea.resource.*"%>
<%@ page import=" tea.db.DbAdapter"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.member.order.*"%>
<%@ page import="tea.http.RequestHelper"%>

<%@ page import="java.io.PrintWriter"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="tea.entity.RV"%>
<%
Resource r = new Resource();
TeaSession teasession = new TeaSession(request);
Node  node = Node.find(teasession._nNode);
int listing=Integer.parseInt(request.getParameter("Listing"));
%>
<html>
  <head>
  <script>
function td_calendar(fieldname,detail)
{
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/tea/inc/calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
        </script>


  <style type="text/css">
<!--
*{font-size:9pt;}
-->
  </style>
</head>
<body  style="margin:0px;padding:0px;border:0px;">


    <div style="border-left:4px solid #000;margin:4px;padding-left:10px;color:#E0181A;font-size:14px;font-weight:600"> 高级检索</div>
  <form  NAME="condition" method="post" action="/servlet/Node?node=<%=node._nNode%>&Listing=<%=listing%>"   target="_parent" style="padding:5px;border:1px solid #ccc;margin:4px 4px 4px 14px;">
   <input type="hidden" name="Node" value="<%=node._nNode%>"/>
   <input type="hidden" name="Listing" value="<%=listing%>"/>
  <input name="keyword" type="text" class="in" size="15">

    <select name="radiobutton">
      <option value="1">标题</option>
      <option value="2">全文</option>
    </select>
    　媒体名称
      <select name="mediaid">
        <option value="">全部媒体</option>
        <%
java.util.Enumeration _media_enumer=          tea.entity.node.Media.findByLanguage(teasession._nLanguage);
while(_media_enumer.hasMoreElements())
{
tea.entity.node.Media media_obj=  tea.entity.node.Media.find(((Integer) _media_enumer.nextElement()).intValue());
out.print("<option value="+media_obj.getMediaID()+">"+media_obj.getName()+"</option>");
}          %></select>

      　<br>
   开始时间
   <input name="begin_date" type="text"  onclick="td_calendar('condition.begin_date','condition.Begin');" size="15" readonly/>

结束时间<input name="end_date" type="text"  onclick="td_calendar('condition.end_date','condition.End');" size="15" readonly/>


类别:
<select name="classid">
  <option value="">全部类别</option>
  <%
                java.util.Enumeration enumer=tea.entity.node.Classes.findByCommunity(node.getCommunity(),teasession._nLanguage);
                while(enumer.hasMoreElements())
                {
                  tea.entity.node.Classes class_obj=  tea.entity.node.Classes.find(((Integer)enumer.nextElement()).intValue());
//                  dropdown1.addOption(class_obj.getId(),class_obj.getName());
                  out.print("<option value="+class_obj.getId()+">"+class_obj.getName()+"</option>");
                }
            //DbAdapter dbadapter = new DbAdapter();
           /* try
            {
                int i = teasession._nLanguage;
                dbadapter.executeQuery("SELECT class_id,name FROM Class where  community='"+node.getCommunity()+"' AND  language=" + i);
                for(; dbadapter.next();)
                {
                    String s1 = dbadapter.getVarchar(teasession._nLanguage, 1, 2);
                    int j = dbadapter.getInt(1);
					 out.println("<option value="+j+">"+s1+"</option>");
                }
            }
            catch(Exception exception1) { }
            finally
            {
                dbadapter.close();
            }*/

%>
</select>
<input name="Submit" type="image" value="Submit" src="/tea/image/section/12395.jpg" width="48" height="19">
 </form>

</body>
</html>

