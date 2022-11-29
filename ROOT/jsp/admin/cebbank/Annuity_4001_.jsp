<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.cebbank.*" %>
<%@page import="tea.resource.*"%>
<%@page import="java.net.URLEncoder"%><%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

/////Annuity_4001.jsp/////////////////////////////////

TeaSession teasession=new TeaSession(request);

Resource r=new Resource("/tea/resource/Annuity");

String code=(String)session.getAttribute("code");
//String user=(String)session.getAttribute("user");

if(code==null)//||user==null
{
	response.sendRedirect("/servlet/Node?node="+teasession._nNode);
	return;
}
ArrayList atn=(ArrayList)session.getAttribute("annuity.trade_no");
if(atn==null||atn.indexOf("4001")==-1)
{
  response.sendError(403);
  return;
}

String _strStartdate=request.getParameter("startdate");
String _strEnddate=request.getParameter("enddate");

Map m=new HashMap();
m.put("trade_no","4001");
m.put("code",code);
if(!"".equals(_strStartdate))
{
  m.put("startdate",_strStartdate);
}
if(!"".equals(_strEnddate))
{
  m.put("enddate",_strEnddate);
}


String info=request.getParameter("info");

%>
<jsp:include page="/jsp/admin/cebbank/AnnuityFrame.jsp" >
<jsp:param name="frame" value="mainheader"/>
</jsp:include>

<div id="new"></div><div style="width:100%;overflow: auto;"><div id="neirong">






<form name="form1" action="?" method="get" onsubmit="return submitDate(this.startdate,'<%=r.getString(teasession._nLanguage,"1186568245875")%>')&&submitDate(this.enddate,'<%=r.getString(teasession._nLanguage,"1186568245875")%>');">
<input type=hidden name=community value="<%=teasession._strCommunity%>">
<input type=hidden name=info value="<%=info%>">

<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186481230906")%></span><span id="biaor"></span></div>
<table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse">
<tr><td class="zuoge"><%=r.getString(teasession._nLanguage,"1186481292296")%>：</td><td><table border="0" cellspacing="0" cellpadding="0">
<tr><td style="width:15px;">
<%=r.getString(teasession._nLanguage,"1186542510031")%>：</td><td style="width:180px;"><input class="biaodan" type="text" name="startdate" value="<%if(_strStartdate!=null)out.print(_strStartdate);%>" /><a href=### onclick="showCalendar('form1.startdate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td>
<td class="xiaobiao"><%=r.getString(teasession._nLanguage,"1186542560843")%>：</td><td><input class="biaodan" type="text" name="enddate"  value="<%if(_strEnddate!=null)out.print(_strEnddate);%>" /><a href=### onclick="showCalendar('form1.enddate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td></tr></table></td></tr></table>
<input class="bdanniu" type="submit" value="<%=r.getString(teasession._nLanguage,"1186542726218")%>" onclick="form1.action='?'" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input class="bdanniu" type="button" value="<%=r.getString(teasession._nLanguage,"1186542790281")%>" onclick="clearFrom(form1);"/>
</form>

<%
if(_strStartdate!=null&&_strEnddate!=null)
{
  m=(Map)Annuity.conn(m);

  String ec = (String) m.get("error_code");
  if (!Annuity.EC_0000.equals(ec))
  {
  	out.print("<script>alert('" +r.getString(teasession._nLanguage,"Annuity.error_code."+ec)+"');</script>");
  }else
  {
     ArrayList al=(ArrayList)m.get("result");

%>

<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186481390062")%> ( <%=al.size()%> )</span><span id="biaor"></span></div>
  <table style="border-collapse:collapse" border="0" cellspacing="0" cellpadding="0">
  <tr>
<td colspan="7" class="youge">　<%=r.getString(teasession._nLanguage,"1186472111484")%>：<%=_strStartdate%>　　　　　　<%=r.getString(teasession._nLanguage,"1186472169000")%>：<%=_strEnddate%></td>
</tr>

    <tr>
      <!-- <td>企业客户号</td>
      <td>企业名称</td>
       -->
      <td><%=r.getString(teasession._nLanguage,"1186466576328")%></td>
      <td><%=r.getString(teasession._nLanguage,"1186466756468")%></td>
      <td><%=r.getString(teasession._nLanguage,"1186534472062")%></td>
      <td><%=r.getString(teasession._nLanguage,"1186534605031")%></td>
      <td><%=r.getString(teasession._nLanguage,"1186534670109")%></td>
      <td><%=r.getString(teasession._nLanguage,"1186534719421")%></td>
      <td><%=r.getString(teasession._nLanguage,"1186534770718")%></td>
    </tr>
<%
for(int i=0;i<al.size();i++)
{
	Map v=(Map)al.get(i);
	String corp_no=(String)v.get("corp_no");
	String plan_code=(String)v.get("plan_code");
	String operate_date=(String)v.get("operate_date");
%>
    <tr>
    <!--
      <td><%=corp_no%></td>
      <td><%=v.get("corp_name")%></td>
      -->
      <td><%=plan_code%></td>
      <td><%=Annuity.d(v.get("plan_name"))%></td>
      <td><%=operate_date%></td>
      <td><%=Annuity.d(v.get("period"))%></td>
      <td><%=Annuity.d(v.get("start_date"))%></td>
      <td><%=Annuity.d(v.get("end_date"))%></td>
      <td><a href="/servlet/ExportAnnuityPdf?trade_no=<%=Annuity.encode("4002")%>&corp_no=<%=corp_no%>&plan_code=<%=plan_code%>&operate_date=<%=operate_date%>&info=<%=java.net.URLEncoder.encode(info+"("+operate_date+")", "UTF-8")%>"><%=r.getString(teasession._nLanguage,"1186534919562")%></a></td>
    </tr>
<%
}%>
</table>
<%
}}%>




</div>

<jsp:include page="/jsp/admin/cebbank/AnnuityFrame.jsp" >
<jsp:param name="frame" value="mainfooter"/>
</jsp:include>

</div>






