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

/////Annuity_1004.jsp/////////////////////////////////

TeaSession teasession=new TeaSession(request);

Resource r=new Resource("/tea/resource/Annuity");

String code=(String)session.getAttribute("code");

if(code==null)
{
	response.sendRedirect("/jsp/info/Alert.jsp?community="+teasession._strCommunity+"&info="+URLEncoder.encode(r.getString(teasession._nLanguage,"1186555649328"),"UTF-8")+"&nexturl=/servlet/Node%3FNode%3D"+teasession._nNode);
	return;
}
ArrayList atn=(ArrayList)session.getAttribute("annuity.trade_no");
if(atn==null||atn.indexOf("1004")==-1)
{
  response.sendError(403);
  return;
}

String _strPlan_code=request.getParameter("plan_code");

Map m=new HashMap();
m.put("trade_no","1004");
m.put("code",code);

if(_strPlan_code!=null&&_strPlan_code.length()>0)
{
	m.put("plan_code",_strPlan_code);
}
m=(Map)Annuity.conn(m);


String ec = (String) m.get("error_code");
if (!Annuity.EC_0000.equals(ec))
{
	response.sendRedirect("/jsp/info/Alert.jsp?info=" +URLEncoder.encode(r.getString(teasession._nLanguage,"Annuity.error_code."+ec),"UTF-8"));
	return;
}

ArrayList al=(ArrayList)m.get("result");

String info=request.getParameter("info");

%>
<jsp:include page="/jsp/admin/cebbank/AnnuityFrame.jsp" >
<jsp:param name="frame" value="mainheader"/>
</jsp:include>

<div id="new"></div><div style="width:100%;"><div id="neirong">



<form name="form1" action="?" method="get">
<input type=hidden name=community value="<%=teasession._strCommunity%>">
<input type=hidden name=trade_no value="<%=Annuity.encode("1004")%>">
<input type=hidden name=info value="<%=info%>">

<DIV id=neibiao><SPAN id=biaol></SPAN><SPAN id=neibiaozi><%=r.getString(teasession._nLanguage,"1186475850812")%> ( <%=al.size()%> )</SPAN>
<SPAN id=biaor></SPAN><span id="biaor_text"><%=Annuity.Annuity_1007(session,_strPlan_code)%></span>
<span id="biaor_text"><input type="submit" value="GO" onclick="form1.action='?'"/></span>
</DIV>


<table style="BORDER-COLLAPSE: collapse" cellSpacing=0 cellPadding=0 border=0>
<TBODY>
<TR class=shuohang>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186466576328")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186466756468")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186471222875")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186471324781")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186471425296")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186476170000")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186471494734")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186476253984")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"单位净值")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186476345546")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186476407218")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186471660609")%></td>
</tr>
<%
for(int i=0;i<al.size();i++)
{
	Map v=(Map)al.get(i);
	String plan_code=(String)v.get("plan_code");
	String plan_name=(String)v.get("plan_name");
%>
<tr>
<td><%=plan_code%></td>
<td><%=plan_name%></td>
<td><%=Annuity.d(v.get("invest_code"))%></td>
<td><%=Annuity.d(v.get("invest_name"))%></td>
<td><%=Annuity.d(v.get("corp_cash"))%></td>
<td><%=Annuity.d(v.get("corp_balance"))%></td>
<td><%=Annuity.d(v.get("person_cash"))%></td>
<td><%=Annuity.d(v.get("person_balance"))%></td>
<td><%=Annuity.d(v.get("net_value"))%></td><!--new add-->
<td><%=Annuity.d(v.get("capital_cash"))%></td>
<td><%=Annuity.d(v.get("capital_balance"))%></td>
<td><%=Annuity.d(v.get("unit"))%></td>
</tr>
<%}%>
</TBODY>
</TABLE>

<input id="xia_z" type=image src="/res/fulijihua/u/0802/080239018.gif" name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity';">

</form>

</div>

<jsp:include page="/jsp/admin/cebbank/AnnuityFrame.jsp" >
<jsp:param name="frame" value="mainfooter"/>
</jsp:include>

</div>





