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

/////Annuity_5003.jsp/////////////////////////////////

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
if(atn==null||atn.indexOf("5003")==-1)
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

StringBuffer param=new StringBuffer();
param.append("?community=").append(teasession._strCommunity);
param.append("&corp_no=").append(corp_no);

int pos=0,size=10;
String _strPos=request.getParameter("pos");
if(_strPos!=null)
{
	pos=Integer.parseInt(_strPos);
}

String _strPlan_code=request.getParameter("plan_code");
String _strPerson_code=request.getParameter("person_code");
String _strPerson_name=request.getParameter("person_name");
String _strIdentity_no=request.getParameter("identity_no");
String _strStartdate=request.getParameter("startdate");
String _strEnddate=request.getParameter("enddate");

Map m=new HashMap();
m.put("trade_no","5003");
m.put("code",corp_no);
m.put("user",user);
if(_strPlan_code!=null&&_strPlan_code.length()>0)
{
	m.put("plan_code",_strPlan_code);
	param.append("&plan_code=").append(_strPlan_code);
}
if(_strPerson_code!=null&&_strPerson_code.length()>0)
{
	m.put("person_code",_strPerson_code);
	param.append("&person_code=").append(_strPerson_code);
}
if(_strPerson_name!=null&&_strPerson_name.length()>0)
{
	m.put("person_name",_strPerson_name);
	param.append("&person_name=").append(_strPerson_name);
}
if(_strIdentity_no!=null&&_strIdentity_no.length()>0)
{
	m.put("identity_no",_strIdentity_no);
	param.append("&identity_no=").append(_strIdentity_no);
}
if(_strStartdate!=null&&_strStartdate.length()>0)
{
	m.put("startdate",_strStartdate);
	param.append("&startdate=").append(_strStartdate);
}
if(_strEnddate!=null&&_strEnddate.length()>0)
{
	m.put("enddate",_strEnddate);
	param.append("&enddate=").append(_strEnddate);
}
String info=request.getParameter("info");
param.append("&info=").append(URLEncoder.encode(info,"UTF-8"));

param.append("&pos=");



%>
<jsp:include page="/jsp/admin/cebbank/AnnuityFrame.jsp" >
<jsp:param name="frame" value="mainheader"/>
</jsp:include>

<div id="new"></div><div style="width:100%;overflow: auto;"><div id="neirong">




<form name="form1" action="?" method="get" onsubmit="return (this.startdate.value.length==0||submitDate(this.startdate,'<%=r.getString(teasession._nLanguage,"1186568245875")%>'))&&( this.enddate.value.length==0||submitDate(this.enddate,'<%=r.getString(teasession._nLanguage,"1186568245875")%>') );">
<input type=hidden name=community value="<%=teasession._strCommunity%>">
<input type=hidden name=trade_no value="<%=Annuity.encode("5004")%>">
<input type=hidden name=info value="<%=info%>">
<input type=hidden name=pos value="0">
<input type=hidden name=corp_no value="<%=corp_no%>">

<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186537119250")%></span><span id="biaor"></span></div>
<table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse">
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186471846765")%>：</td>
    <td><%=Annuity.Annuity_0007(session,corp_no,_strPlan_code)%></td>
  </tr>
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186536054375")%>：</td>
    <td ><input class="biaodan" type="text" name="person_code" value="<%if(_strPerson_code!=null)out.print(_strPerson_code);%>"/></td>
  </tr>
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186536117593")%>：</td>
    <td ><input class="biaodan" type="text" name="person_name" value="<%if(_strPerson_name!=null)out.print(_strPerson_name);%>"/></td>
  </tr>
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186536171906")%>：</td>
    <td ><input class="biaodan" type="text" name="identity_no" value="<%if(_strIdentity_no!=null)out.print(_strIdentity_no);%>"/></td>
  </tr>
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186537325578")%>：</td>
    <td ><table border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td style="width:15px;"><%=r.getString(teasession._nLanguage,"1186542510031")%>：</td>
          <td style="width:180px;"><input class="biaodan" type="text" name="startdate" value="<%if(_strStartdate!=null)out.print(_strStartdate);%>" /><a href=### onClick="showCalendar('form1.startdate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td>
          <td class="xiaobiao"><%=r.getString(teasession._nLanguage,"1186542560843")%>：</td>
          <td><input class="biaodan" type="text" name="enddate" value="<%if(_strEnddate!=null)out.print(_strEnddate);%>"/><a href=### onClick="showCalendar('form1.enddate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td>
        </tr>
      </table></td>
  </tr>
</table>
<input class="bdanniu" type="submit" value="<%=r.getString(teasession._nLanguage,"1186542726218")%>" onclick="form1.action='?'"/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input class="bdanniu" type="button" value="<%=r.getString(teasession._nLanguage,"1186542790281")%>" onclick="clearFrom(form1);"/>

<%
if(_strPos!=null)
{
  Map m2=(Map)Annuity.conn(m);
  ArrayList al=(ArrayList)m2.get("result");
  Map v=(Map)al.get(0);
  int total=((Integer)v.get("total")).intValue();

  int endnum=pos+size;
  if(endnum>total)
	  endnum=total;

  m.put("trade_no","5004");
  m.put("startnum",new Integer(pos+1));
  m.put("endnum",new Integer(endnum));
  m2=(Map)Annuity.conn(m);

  String ec = (String) m2.get("error_code");
  if (!Annuity.EC_0000.equals(ec))
  {
  	out.print("<script>alert('" +r.getString(teasession._nLanguage,"Annuity.error_code."+ec)+"');</script>");
  }else
  {
     al=(ArrayList)m2.get("result");
%>


<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186537375562")%></span><span id="biaor"></span></div>
  <table style="border-collapse:collapse" border="0" cellspacing="0" cellpadding="0">
  <tr>
<td colspan="9" class="youge"><div style="text-align:right;">[<%=r.getString(teasession._nLanguage,"1186536885171")%><%=total%><%=r.getString(teasession._nLanguage,"1186536939078")%>] <%= new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,total,size)%></div></td>
</tr>
    <tr class="shuohang">
      <td nowrap><%=r.getString(teasession._nLanguage,"1186537444406")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186536398843")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186466576328")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186466756468")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186474596125")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186537654343")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186537787875")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186537850437")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186537919203")%></td>
    </tr>

	<%
	for(int i=0;i<al.size();i++)
	{
		v=(Map)al.get(i);
	%>
	     <tr>
	      <td><%=Annuity.d(v.get("person_no"))%></td>
	      <td><%=Annuity.d(v.get("name"))%></td>
	      <td><%=Annuity.d(v.get("plan_code"))%></td>
	      <td><%=Annuity.d(v.get("plan_name"))%></td>
	      <td><%=Annuity.d(v.get("identity_no"))%></td>
	      <td><%=Annuity.d(v.get("person_status"))%></td>
	      <td><%=Annuity.d(v.get("contr_status"))%></td>
	      <td><%=Annuity.d(v.get("account_balance"))%></td>
	      <td><%=Annuity.d(v.get("join_date"))%></td>
	    </tr>
	<%
	}%>

</table>
<div style="text-align:right;">[<%=r.getString(teasession._nLanguage,"1186536885171")%><%=total%><%=r.getString(teasession._nLanguage,"1186536939078")%>] <%= new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,total,size)%></div>

<input type=submit name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity';">


<%
}}%>

</form>

</div>

<jsp:include page="/jsp/admin/cebbank/AnnuityFrame.jsp" >
<jsp:param name="frame" value="mainfooter"/>
</jsp:include>

</div>


