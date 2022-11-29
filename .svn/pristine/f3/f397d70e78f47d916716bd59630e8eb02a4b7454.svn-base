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

/////Annuity_0001.jsp/////////////////////////////////

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
if(atn==null||atn.indexOf("0001")==-1)
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

String info=request.getParameter("info");

Map m=new HashMap();
m.put("trade_no","0001");
m.put("code",corp_no);
m.put("user",user);
m=(Map)Annuity.conn(m);

String ec = (String) m.get("error_code");
if (!Annuity.EC_0000.equals(ec))
{
	response.sendRedirect("/jsp/info/Alert.jsp?info=" +URLEncoder.encode(r.getString(teasession._nLanguage,"Annuity.error_code."+ec),"UTF-8"));
	return;
}

ArrayList al=(ArrayList)m.get("result");

Map v=(Map)al.get(0);


%>
<jsp:include page="/jsp/admin/cebbank/AnnuityFrame.jsp" >
<jsp:param name="frame" value="mainheader"/>
</jsp:include>

<div id="new"></div><div style="width:100%;overflow: auto;"><div id="neirong">


<form name="form1" action="?" method="get">
<input type=hidden name=community value="<%=teasession._strCommunity%>">
<input type=hidden name=trade_no value="<%=Annuity.encode("0001")%>">
<input type=hidden name=corp_no value="<%=corp_no%>">
<input type=hidden name=info value="<%=info%>">

<DIV id=neibiao><SPAN id=biaol></SPAN><SPAN id=neibiaozi><%=r.getString(teasession._nLanguage,"1186468590687")%></SPAN><SPAN id=biaor></SPAN></DIV>
<table style="BORDER-COLLAPSE: collapse" cellSpacing=0 cellPadding=0 border=0 id="biao_g01">
<TBODY>
<tr>
<td align="left" width=20%><%=r.getString(teasession._nLanguage,"1186468686609")%>：</td>
<td align="left"><%=Annuity.d(v.get("corp_no"))%></td>
<td align="left" width=20%><%=r.getString(teasession._nLanguage,"1186468779234")%>：</td>
<td align="left"><%=Annuity.d(v.get("short_name"))%></td>
</tr>
<tr>
  <td align="left" width=20%><%=r.getString(teasession._nLanguage,"1186468848421")%>：</td>
  <td colspan="3" align="left"><%=Annuity.d(v.get("corp_name"))%></td>
  </tr>
<tr>
<td align="left" width=20%><%=r.getString(teasession._nLanguage,"1186468911765")%>：</td>
<td colspan="3" align="left"><%=Annuity.d(v.get("group_name"))%></td>
</tr>
<tr>
<td align="left" width=20%><%=r.getString(teasession._nLanguage,"1186469012562")%>：</td>
<td align="left"><%=Annuity.d(v.get("org_id"))%></td>
<%--
<td align="left"><%=r.getString(teasession._nLanguage,"1186469081718")%></td>
<td align="left"><%=Annuity.d(v.get("legal_person"))%></td>
</tr>
<tr>
<td align="left"><%=r.getString(teasession._nLanguage,"1186469141625")%></td>
<td align="left"><%=Annuity.d(v.get("reg_capital"))%></td>
--%>
<td align="left" width=20%><%=r.getString(teasession._nLanguage,"1186469215062")%>：</td>
<td align="left"><%=Annuity.d(v.get("postcode"))%></td>
</tr>
<tr>
<td align="left" width=20%><%=r.getString(teasession._nLanguage,"1186469282609")%>：</td>
<td colspan="3" align="left"><%=Annuity.d(v.get("contact_address"))%></td>
</tr>
<tr>
<td align="left" width=20%><%=r.getString(teasession._nLanguage,"1186469347406")%>：</td>
<td colspan="3" align="left"><%=Annuity.d(v.get("net_address"))%></td>
</tr>
<tr>
<td align="left" width=20%><%=r.getString(teasession._nLanguage,"1186469426640")%>：</td>
<td align="left"><%=Annuity.d(v.get("sum_wage"))%></td>
<td align="left" width=20%><%=r.getString(teasession._nLanguage,"1186469499484")%>：</td>
<td align="left"><%=Annuity.d(v.get("industry_type"))%></td>
</tr>
<tr>
<td align="left" width=20%><%=r.getString(teasession._nLanguage,"1186469549875")%>：</td>
<td align="left"><%=Annuity.d(v.get("insurance_code"))%></td>
<td align="left" width=20%><%=r.getString(teasession._nLanguage,"1186469610828")%>：</td>
<td align="left"><%=Annuity.d(v.get("person_number"))%></td>
</tr>

</TBODY>
</TABLE>


<input id="xia_z" type=image src="/res/fulijihua/u/0802/080239018.gif" name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity'">
</form>


</div>

<jsp:include page="/jsp/admin/cebbank/AnnuityFrame.jsp" >
<jsp:param name="frame" value="mainfooter"/>
</jsp:include>

</div>




