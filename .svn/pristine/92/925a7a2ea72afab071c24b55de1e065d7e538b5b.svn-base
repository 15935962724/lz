<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.ui.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.admin.cebbank.*"%>
<%@page import="tea.resource.*"%>
<%@page import="java.net.URLEncoder"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

/////Annuity_0002.jsp/////////////////////////////////

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
if(atn==null||atn.indexOf("0002")==-1)
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

String _strPlan_code=request.getParameter("plan_code");

Map m=new HashMap();
m.put("trade_no","0002");
m.put("code",corp_no);
m.put("user",user);
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

String info=request.getParameter("info");

ArrayList al=(ArrayList)m.get("result");


%>
<jsp:include page="/jsp/admin/cebbank/AnnuityFrame.jsp">
<jsp:param name="frame" value="mainheader" />
</jsp:include>

<div id="new"></div>
<div style="width:100%;">
<div id="neirong">

<form name="form1" action="?" method="get">
<input type=hidden name=community value="<%=teasession._strCommunity%>">
<input type=hidden name=trade_no value="<%=Annuity.encode("0002")%>">
<input type=hidden name=info value="<%=info%>">
<input type=hidden name=corp_no value="<%=corp_no%>">


<DIV id=neibiao><SPAN id=biaol></SPAN><SPAN id=neibiaozi><%=r.getString(teasession._nLanguage,"1186469885359")%>
( <%=al.size()%> )</SPAN> <SPAN id=biaor></SPAN> <span  id="biaor_text"> <%=Annuity.Annuity_0007(session,corp_no,  _strPlan_code)%>
</span>
<span  id="biaor_text">
<input type="submit" value="GO" onclick="form1.action='?'"></span></DIV>



<table style="BORDER-COLLAPSE: collapse" cellSpacing=0 cellPadding=0 border=0>
<TBODY>
  <TR class=shuohang>
    <td noWrap><%=r.getString(teasession._nLanguage,"1186466576328")%></td>
    <td noWrap><%=r.getString(teasession._nLanguage,"1186466756468")%></td>
    <td noWrap><%=r.getString(teasession._nLanguage,"1186470272109")%></td>
    <td noWrap><%=r.getString(teasession._nLanguage,"1186470334531")%></td>
    <td noWrap><%=r.getString(teasession._nLanguage,"1186470387125")%></td>
    <td noWrap><%=r.getString(teasession._nLanguage,"1186470438328")%></td>
    <td noWrap><%=r.getString(teasession._nLanguage,"1186470482609")%></td>
    <td noWrap><%=r.getString(teasession._nLanguage,"1186470558718")%></td>
    <td noWrap><%=r.getString(teasession._nLanguage,"1186470617218")%></td>
    <td noWrap><%=r.getString(teasession._nLanguage,"1186470680687")%></td>
    <td noWrap><%=r.getString(teasession._nLanguage,"1186469282609")%></td>
    <td noWrap><%=r.getString(teasession._nLanguage,"1186470803437")%></td>
    <td noWrap><%=r.getString(teasession._nLanguage,"1186469215062")%></td>
    <td noWrap><%=r.getString(teasession._nLanguage,"1186470902781")%></td>
  </tr>
		<%
				for (int i = 0; i < al.size(); i++) {
				Map v = (Map) al.get(i);
				String plan_code = (String) v.get("plan_code");
				String plan_name = (String) v.get("plan_name");
		%>
		<tr>
			<td><%=plan_code%></td>
			<td><%=plan_name%></td>
			<td>
			<%=Annuity.d(v.get("invest_option"))%>
			</td>
			<td>
			<%=Annuity.d(v.get("contr_period"))%>
			</td>
			<td>
			<%=Annuity.d(v.get("contr_month"))%>
			</td>
			<td>
			<%=Annuity.d(v.get("contr_day"))%>
			</td>
			<td>
			<%=Annuity.d(v.get("offer_way"))%>
			</td>
			<td>
			<%=Annuity.d(v.get("corpplan_status"))%>
			</td>
			<td>
			<%=Annuity.d(v.get("contr_status"))%>
			</td>
			<td>
			<%=Annuity.d(v.get("contact_person"))%>
			</td>
			<td>
			<%=Annuity.d(v.get("contact_address"))%>
			</td>
			<td>
			<%=Annuity.d(v.get("contact_phone"))%>
			</td>
			<td>
			<%=Annuity.d(v.get("postcode"))%>
			</td>
			<td>
			<%=Annuity.d(v.get("join_date"))%>
			</td>
		</tr>
		<%
		}
		%>
	</TBODY>
</TABLE>

<input id="xia_z" type=image src="/res/fulijihua/u/0802/080239018.gif" name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity'">
</form>

</div>

<jsp:include page="/jsp/admin/cebbank/AnnuityFrame.jsp">
	<jsp:param name="frame" value="mainfooter" />
</jsp:include></div>



