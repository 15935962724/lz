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

/////Annuity_4003.jsp/////////////////////////////////

TeaSession teasession=new TeaSession(request);

Resource r=new Resource("/tea/resource/Annuity");

String code=(String)session.getAttribute("code");
String user=(String)session.getAttribute("user");

if(code==null||user==null)
{
	response.sendRedirect("/servlet/Node?node="+teasession._nNode);
	return;
}
ArrayList atn=(ArrayList)session.getAttribute("annuity.trade_no");
if(atn==null||atn.indexOf("4003")==-1)
{
  response.sendError(403);
  return;
}
String corp_no=request.getParameter("corp_no");
ArrayList acn = (ArrayList) session.getAttribute("annuity.corp_no");
if(!code.equals(corp_no)&&(acn==null||acn.indexOf(corp_no)==-1))
{
  response.sendError(403);
  return;
}

String _strStartdate=request.getParameter("startdate");
String _strEnddate=request.getParameter("enddate");

Map m=new HashMap();
m.put("trade_no","4003");
m.put("code",corp_no);
m.put("user",user);
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
<input type=hidden name=trade_no value="<%=Annuity.encode("4003")%>">
<input type=hidden name=corp_no value="<%=corp_no%>">
<input type=hidden name=info value="<%=info%>">

<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186535226734")%></span><span id="biaor"></span></div>
<table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse">
<tr><td class="zuoge"><%=r.getString(teasession._nLanguage,"1186535316796")%>：</td><td><table border="0" cellspacing="0" cellpadding="0">
<tr><td style="width:15px;">
<%=r.getString(teasession._nLanguage,"1186542510031")%>：</td><td style="width:180px;"><input class="biaodan" type="text" name="startdate" value="<%if(_strStartdate!=null)out.print(_strStartdate);%>" /><a href=### onclick="showCalendar('form1.startdate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td>
<td class="xiaobiao"><%=r.getString(teasession._nLanguage,"1186542560843")%>：</td><td><input class="biaodan" type="text" name="enddate"  value="<%if(_strEnddate!=null)out.print(_strEnddate);%>" /><a href=### onclick="showCalendar('form1.enddate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td></tr></table></td></tr></table>
<input class="bdanniu" type="submit" value="<%=r.getString(teasession._nLanguage,"1186542726218")%>" onclick="form1.action='?'"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input class="bdanniu" type="button" value="<%=r.getString(teasession._nLanguage,"1186542790281")%>" onclick="clearFrom(form1);"/>


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

<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186535385703")%> ( <%=al.size()%> )</span><span id="biaor"></span></div>
  <table style="border-collapse:collapse" border="0" cellspacing="0" cellpadding="0">
  <tr>
<td colspan="9" class="youge">　<%=r.getString(teasession._nLanguage,"1186472111484")%>：<%=_strStartdate%>　　　　　　<%=r.getString(teasession._nLanguage,"1186472169000")%>：<%=_strEnddate%></td>
</tr>

    <tr>
      <td><%=r.getString(teasession._nLanguage,"1186468686609")%></td>
      <td><%=r.getString(teasession._nLanguage,"1186468848421")%></td>
      <td><%=r.getString(teasession._nLanguage,"1186466576328")%></td>
      <td><%=r.getString(teasession._nLanguage,"1186466756468")%></td>
      <td><%=r.getString(teasession._nLanguage,"1186535640156")%></td>
      <td><%=r.getString(teasession._nLanguage,"1186535680671")%></td>
      <td><%=r.getString(teasession._nLanguage,"1186535700875")%></td>
      <td><%=r.getString(teasession._nLanguage,"1186535780531")%></td>
      <td><%=r.getString(teasession._nLanguage,"1186535842828")%></td>
      <td><%=r.getString(teasession._nLanguage,"1186535903171")%></td>
    </tr>
<%
for(int i=0;i<al.size();i++)
{
	Map v=(Map)al.get(i);
%>
    <tr>
      <td><%=v.get("corp_no")%></td>
      <td><%=v.get("corp_name")%></td>
      <td><%=Annuity.d(v.get("plan_code"))%></td>
      <td><%=Annuity.d(v.get("plan_name"))%></td>
      <td><%=Annuity.d(v.get("operate_date"))%></td>
      <td><%=Annuity.d(v.get("start_date"))%></td>
      <td><%=Annuity.d(v.get("end_date"))%></td>
      <td><%=Annuity.d(v.get("billstatus"))%></td>
      <td><%=Annuity.d(v.get("fee_sum"))%></td>
      <td><%=Annuity.d(v.get("arrive_date"))%></td>
    </tr>
<%
}%>
</table>

<input type=submit name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity';">

<%
}}%>

</from>


</div>

<jsp:include page="/jsp/admin/cebbank/AnnuityFrame.jsp" >
<jsp:param name="frame" value="mainfooter"/>
</jsp:include>

</div>





