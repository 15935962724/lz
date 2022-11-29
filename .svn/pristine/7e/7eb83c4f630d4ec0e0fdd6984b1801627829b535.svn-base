<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.cebbank.*" %>
<%@page import="tea.resource.*"%>
<%@page import="java.math.*"%>
<%@page import="java.net.URLEncoder"%><%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

/////Annuity_0005.jsp/////////////////////////////////

TeaSession teasession=new TeaSession(request);

Resource r=new Resource("/tea/resource/Annuity");

String code=(String)session.getAttribute("code");
String user=(String)session.getAttribute("user");

if(code==null||user==null)
{
	response.sendRedirect("/jsp/info/Alert.jsp?community="+teasession._strCommunity+"&info="+URLEncoder.encode(r.getString(teasession._nLanguage,"1186555649328"),"UTF-8")+"&nexturl=/servlet/Node%3FNode%3D"+teasession._nNode);
	return;
}

ArrayList atn=(ArrayList)session.getAttribute("annuity.trade_no");
if(atn==null||atn.indexOf("0005")==-1)
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
Calendar c=Calendar.getInstance();
String _strPlan_code=request.getParameter("plan_code");
String _strStartdate=request.getParameter("startdate");
String _strEnddate=request.getParameter("enddate");

Map m=new HashMap();
m.put("trade_no","0005");
m.put("code",corp_no);
m.put("user",user);

if(!"".equals(_strPlan_code))
{
	m.put("plan_code",_strPlan_code);
}
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
<input type=hidden name=trade_no value="<%=Annuity.encode("0005")%>">
<input type=hidden name=info value="<%=info%>">
<input type=hidden name=corp_no value="<%=corp_no%>">

<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186471785671")%></span><span id="biaor"></span></div>
<table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse"><tr><td class="zuoge"><%=r.getString(teasession._nLanguage,"1186471846765")%>：</td><td ><span style="float:left;margin-left:10px;">
<%=Annuity.Annuity_0007(session,corp_no,_strPlan_code)%>
</span>
</td></tr>
<tr><td class="zuoge">* <%=r.getString(teasession._nLanguage,"1186472518328")%>：</td><td><table border="0" cellspacing="0" cellpadding="0">
<tr><td style="width:15px;"><%=r.getString(teasession._nLanguage,"1186542510031")%>：</td><td style="width:180px;"><input class="biaodan" type="text" name="startdate" value="<%=_strStartdate!=null?_strStartdate:(c.get(c.YEAR)+"-"+(c.get(c.MONTH)+1)+"-1")%>" /><a href=### onclick="showCalendar('form1.startdate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td>
<td class="xiaobiao"><%=r.getString(teasession._nLanguage,"1186542560843")%>：</td><td><input class="biaodan" type="text" name="enddate"  value="<%=_strEnddate!=null?_strEnddate:(c.get(c.YEAR)+"-"+(c.get(c.MONTH)+1)+"-"+c.get(c.DAY_OF_MONTH))%>" /><a href=### onclick="showCalendar('form1.enddate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td></tr></table></td></tr></table>
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

<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186472008640")%> ( <%=al.size()%> )</span><span id="biaor"></span></div>
  <table style="border-collapse:collapse" border="0" cellspacing="0" cellpadding="0">
  <tr>
<td colspan="7" class="youge">　<%=r.getString(teasession._nLanguage,"1186472111484")%>：<%=_strStartdate%>　　　　　　<%=r.getString(teasession._nLanguage,"1186472169000")%>：<%=_strEnddate%></td>
</tr>
    <tr class="shuohang">
      <td nowrap><%=r.getString(teasession._nLanguage,"1186466576328")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186466756468")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186472307093")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186472405609")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186472457781")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186535903171")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186472565593")%></td>
    </tr>
<%
for(int i=0;i<al.size();i++)
{
	Map v=(Map)al.get(i);
	BigDecimal contr_sum=(BigDecimal)v.get("contr_sum");
    BigDecimal corpcontr_sum=(BigDecimal)v.get("corpcontr_sum");
    BigDecimal personcontr_sum=(BigDecimal)v.get("personcontr_sum");

    BigDecimal usable_balance=contr_sum.subtract(corpcontr_sum.add(personcontr_sum));
%>
    <tr>
      <td><%=v.get("plan_code")%></td>
      <td><%=v.get("plan_name")%></td>
      <td><%=Annuity.d(contr_sum)%></td>
      <td><%=Annuity.d(corpcontr_sum)%></td>
      <td><%=Annuity.d(personcontr_sum)%></td>
      <td><%=Annuity.d(v.get("contr_date"))%></td>
      <td><%=Annuity.d(usable_balance)%></td>
    </tr>
<%
}%>
</table>

<input type=submit name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity';">

<%
}}%>

</form>


</div>

<jsp:include page="/jsp/admin/cebbank/AnnuityFrame.jsp" >
<jsp:param name="frame" value="mainfooter"/>
</jsp:include>

</div>




