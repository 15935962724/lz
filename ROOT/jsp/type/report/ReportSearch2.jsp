<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.html.*"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.ui.TeaServlet"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>

<%@page import="tea.entity.site.*"%>
<%@page import=" tea.resource.*"%>
<%@page import=" tea.db.DbAdapter"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.ui.member.order.*"%>
<%@page import="tea.http.RequestHelper"%>

<%@page import="java.io.PrintWriter"%>
<%@page import="javax.servlet.*"%>
<%@page import="tea.entity.RV"%>
<%
Resource r = new Resource();
TeaSession teasession = new TeaSession(request);
Node node = Node.find(teasession._nNode);



%><html>
  <head>
  <script>
function td_calendar(fieldname,detail)
{
  eval(fieldname).value='';
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/tea/inc/calendar.jsp?FIELDNAME="+fieldname+"&detail="+detail,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
</script>
<style type="text/css">
<!--
*{font-size:9pt;}
-->
</style>
</head>
<body  style="margin:0px;padding:0px;border:0px;">
  <div style="background-image:url(/tea/image/section/12384.jpg);background-position: left top;background-repeat:no-repeat;padding:10px;10px;margin-top:20px;width:575px;height:130px;">
 <div style="padding:0px 10px;border-bottom:1px solid #D5D5D5;text-valign:bottom;">
 <div style="border-left:4px solid #000;margin:4px;padding-left:10px;color:#E0181A;font-size:14px;font-weight:600">检索</div></div>
 <form  NAME="condition" method="post" action="/servlet/Node?node=8241&Listing=5574"   target="_parent" >
   <input type="hidden" name="Node" value="24057"/>
   <input type="hidden" name="Listing" value="5114"/>
  <div style="background:#EEEEEE;margin-top:-18px;padding:10px;"> <input name="keyword" type="text" class="in" size="15">

    <select name="radiobutton">
      <option value="1">标题</option>
      <option value="2">全文</option>
    </select>
    　媒体名称
      <select name="mediaid">
        <option value="">全部媒体</option>
        <%//DropDown dropdown = new DropDown("media",m_r);
       java.util.Enumeration enumer= Media.find("",0,Integer.MAX_VALUE);
       while(enumer.hasMoreElements())//dropdown.addOption(s22, dbadapter.getVarchar(teasession._nLanguage, 1, 2)))
       {
         Media media_obj=Media.find(((Integer)enumer.nextElement()).intValue());
         out.println("<option value="+media_obj.getMediaID()+">"+media_obj.getName()+"</option>");
       }
%></select>
<br/>
开始时间<input name="begin_date" type="text"  onclick="td_calendar('condition.begin_date');" size="15" readonly/>
结束时间<input name="end_date" type="text"  onclick="td_calendar('condition.end_date');" size="15" readonly/>
<input name="Submit" type="image" value="Submit" src="/tea/image/section/12395.jpg" width="48" height="19"><br/>
<%--<input name="FatherNode"  id="radio" type="radio" value="24025">网络
<input name="FatherNode"  id="radio" type="radio" value="24027">电视
<input name="FatherNode"  id="radio" type="radio" value="24028">电台
<input name="FatherNode"  id="radio" type="radio" value="24026">报刊
--%>
 </div>
</form>
</div>
</body>
</html>

