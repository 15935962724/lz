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

/////Annuity_0013.jsp/////////////////////////////////

TeaSession teasession=new TeaSession(request);

String code=(String)session.getAttribute("code");
String user=(String)session.getAttribute("user");

Resource r=new Resource("/tea/resource/Annuity");

if(code==null||user==null)
{
  response.sendRedirect("/jsp/info/Alert.jsp?community="+teasession._strCommunity+"&info="+URLEncoder.encode(r.getString(teasession._nLanguage,"1186555649328"),"UTF-8")+"&nexturl=/servlet/Node%3FNode%3D"+teasession._nNode);
  return;
}
ArrayList atn=(ArrayList)session.getAttribute("annuity.trade_no");
if(atn==null||atn.indexOf("0013")==-1)
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

String trade_type=request.getParameter("trade_type");
String startdate=request.getParameter("startdate");
String enddate=request.getParameter("enddate");

Map m=new HashMap();
m.put("trade_no","0013");
m.put("code",corp_no);
m.put("user",user);
if(trade_type!=null&&trade_type.length()>0)
{
  m.put("trade_type",trade_type);
}
if(!"".equals(startdate))
{
  m.put("startdate",startdate);
}
if(!"".equals(enddate))
{
  m.put("enddate",enddate);
}

String info=request.getParameter("info");

%>
<jsp:include page="/jsp/admin/cebbank/AnnuityFrame.jsp" >
<jsp:param name="frame" value="mainheader"/>
</jsp:include>

<div id="new"></div><div style="width:100%;overflow: auto;"><div id="neirong">






<form name="form1" action="?" method="get" onsubmit="return submitDate(this.startdate,'<%=r.getString(teasession._nLanguage,"1186568245875")%>')&&submitDate(this.enddate,'<%=r.getString(teasession._nLanguage,"1186568245875")%>');">
<input type=hidden name=community value="<%=teasession._strCommunity%>">
<input type=hidden name=trade_no value="<%=Annuity.encode("0013")%>">
<input type=hidden name=corp_no value="<%=corp_no%>">
<input type=hidden name=info value="<%=info%>">

<div id="neibiao">
  <span id="biaol"></span>
  <span id="neibiaozi"><%=r.getString(teasession._nLanguage,"Annuity.0013")%></span>
  <span id="biaor"></span></div>
  <table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse">
    <tr>
      <td class="zuoge"><%=r.getString(teasession._nLanguage,"业务类型")%>：</td>
      <td><%=Annuity.Annuity_GT(trade_type)%></td>
    </tr>
    <tr><td class="zuoge">*<%=r.getString(teasession._nLanguage,"1186472518328")%>：</td>
      <td>
        <table border="0" cellspacing="0" cellpadding="0">
          <tr>
              <td style="width:15px;"><%=r.getString(teasession._nLanguage,"1186542510031")%>：</td>
              <td style="width:180px;"><input class="biaodan" type="text" name="startdate" value="<%if(startdate!=null)out.print(startdate);%>" /><a href=### onclick="showCalendar('form1.startdate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td>
                <td class="xiaobiao"><%=r.getString(teasession._nLanguage,"1186542560843")%>：</td>
                <td><input class="biaodan" type="text" name="enddate"  value="<%if(enddate!=null)out.print(enddate);%>" /><a href=### onclick="showCalendar('form1.enddate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td>
            </tr>
          </table>
      </td>
    </tr>
  </table>
<input class="bdanniu" type="submit" value="<%=r.getString(teasession._nLanguage,"1186542726218")%>"  onclick="form1.action='?'"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input class="bdanniu" type="button" value="<%=r.getString(teasession._nLanguage,"1186542790281")%>" onclick="clearFrom(form1);"/>

<%
if(startdate!=null&&enddate!=null)
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

<div id="neibiao">
  <span id="biaol"></span>
  <span id="neibiaozi"><%=r.getString(teasession._nLanguage,"Annuity.0013")%> ( <%=al.size()%> )</span>
  <span id="biaor"></span>
</div>
<table style="border-collapse:collapse" border="0" cellspacing="0" cellpadding="0">
  <tr><td colspan="6" class="youge">　<%=r.getString(teasession._nLanguage,"1186472111484")%>：<%=startdate%>　　　　　　<%=r.getString(teasession._nLanguage,"1186472169000")%>：<%=enddate%></td></tr>
  <tr class="shuohang">
    <td nowrap><%=r.getString(teasession._nLanguage,"业务类型")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"企业子账户发生金额")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"个人子账户发生金额")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"账户发生总金额")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"发生日期")%></td>
  </tr>
<%
for(int i=0;i<al.size();i++)
{
  Map v=(Map)al.get(i);
  %>
  <tr>
    <td><%=v.get("trade_type")%></td>
    <td><%=Annuity.d(v.get("corp_accour_balance"))%></td>
    <td><%=Annuity.d(v.get("person_accour_balance"))%></td>
    <td><%=Annuity.d(v.get("total_accour_balance"))%></td>
    <td><%=Annuity.d(v.get("accour_date"))%></td>
  </tr>
  <%
}%>
</table>

<input type=submit name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity';">

<%
}
}%>


</form>

</div>

<jsp:include page="/jsp/admin/cebbank/AnnuityFrame.jsp" >
<jsp:param name="frame" value="mainfooter"/>
</jsp:include>

</div>





