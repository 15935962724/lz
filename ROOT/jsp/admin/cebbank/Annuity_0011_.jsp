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

/////Annuity_0011.jsp/////////////////////////////////

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
if(atn==null||atn.indexOf("0011")==-1)
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

String plan_code=request.getParameter("plan_code");
String trade_type=request.getParameter("trade_type");

Map m=new HashMap();
m.put("trade_no","0011");
m.put("code",corp_no);
m.put("user",user);
if(plan_code!=null&&plan_code.length()>0)
{
  m.put("plan_code",plan_code);
}
if(trade_type!=null&&trade_type.length()>0)
{
  m.put("trade_type",trade_type);
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
<input type=hidden name=trade_no value="<%=Annuity.encode("0011")%>">
<input type=hidden name=info value="<%=info%>">
<input type=hidden name=corp_no value="<%=corp_no%>">



<div id="neibiao">
  <span id="biaol"></span>
  <span id="neibiaozi"><%=r.getString(teasession._nLanguage,"Annuity.0011")%></span>
  <span id="biaor"></span>
</div>
<table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse">
  <tr>
    <td class="zuoge">计划编码计划名称：</td>
    <td><%=Annuity.Annuity_0007(session,corp_no, plan_code)%></td>
  </tr>
  <tr>
    <td class="zuoge">业务类型：</td>
    <td><%=Annuity.Annuity_GT(trade_type)%></td>
  </tr>
</table>
<input class="bdanniu" type="submit" value="提交" onclick="form1.action='?'"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input class="bdanniu" type="button" value="重置" onclick="clearFrom(form1);"/>


<%
if(plan_code!=null&&trade_type!=null)
{
%>
<DIV id=neibiao>
  <SPAN id=biaol></SPAN>
  <SPAN id=neibiaozi><%=r.getString(teasession._nLanguage,"Annuity.0011")%>( <%=al.size()%> )</SPAN>
  <span id="biaor"></span>
</DIV>

<table style="BORDER-COLLAPSE: collapse" cellSpacing=0 cellPadding=0 border=0>
  <TBODY>
    <TR class=shuohang>
      <td noWrap><%=r.getString(teasession._nLanguage,"1186466576328")%></td>
      <td noWrap><%=r.getString(teasession._nLanguage,"1186466756468")%></td>
      <td noWrap><%=r.getString(teasession._nLanguage,"业务类型")%></td>
      <td noWrap><%=r.getString(teasession._nLanguage,"企业子账户发生金额")%></td>
      <td noWrap><%=r.getString(teasession._nLanguage,"个人子账户发生金额")%></td>
      <td noWrap><%=r.getString(teasession._nLanguage,"账户发生总金额")%></td>
      <td noWrap><%=r.getString(teasession._nLanguage,"发生日期")%></td>
    </tr>
    <%
    for (int i = 0; i < al.size(); i++)
    {
      Map v = (Map) al.get(i);
      plan_code = (String) v.get("plan_code");
      String plan_name = (String) v.get("plan_name");
      %>
      <tr>
        <td><%=plan_code%></td>
        <td><%=plan_name%></td>
        <td><%=Annuity.d(v.get("trade_type"))%></td>
        <td><%=Annuity.d(v.get("corp_accour_balance"))%></td>
        <td><%=Annuity.d(v.get("person_accour_balance"))%></td>
        <td><%=Annuity.d(v.get("total_accour_balance"))%></td>
        <td><%=Annuity.d(v.get("accour_date"))%></td>
      </tr>
      <%
      }
      %>
      </TBODY>
</TABLE>

<input type=submit name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity'">
<%}%>

</form>

</div>

<jsp:include page="/jsp/admin/cebbank/AnnuityFrame.jsp">
<jsp:param name="frame" value="mainfooter" />
</jsp:include>

</div>
