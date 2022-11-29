<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="java.util.*" %>
<%@page import="java.math.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.admin.cebbank.*" %>
<%@page import="java.net.URLEncoder"%><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);

Resource r=new Resource("/tea/resource/Annuity");

String code=(String)session.getAttribute("code");
String user=(String)session.getAttribute("user");
if(code==null)
{
  response.sendRedirect("/jsp/info/Alert.jsp?community="+teasession._strCommunity+"&info="+URLEncoder.encode(r.getString(teasession._nLanguage,"1186555649328"),"UTF-8")+"&nexturl=/servlet/Node%3FNode%3D"+teasession._nNode);
  return;
}

String corp_no=(String)session.getAttribute("corp_no");
if(corp_no==null||corp_no.length()==0)
{
  corp_no=code;
}


String alert=request.getParameter("alert");
if(alert!=null)
{
  out.print("<script>alert('"+alert+"');</script>");
}


String tn=request.getParameter("tn");
if(tn==null)
{
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>

<frameset id="annuity_frame" rows="101,*"  frameborder="NO" border="0" framespacing="0">
  <frame src="/jsp/admin/cebbank/AnnuityFrame.jsp?community=<%=teasession._strCommunity%>&frame=header" name="topFrame" marginheight="10" scrolling="NO" noresize >

  <frameset id="annuity_frame2" cols="154,*" rows="*" frameborder="no" border="0" framespacing="0">
    <frame name="MenuFrame" src="/jsp/admin/cebbank/AnnuityFrame.jsp?community=<%=teasession._strCommunity%>&frame=left<%--&corp_no=<%=corp_no%>&pkc=<%=pkc%>--%>" scrolling="NO">
    <frame name="Annuity_Main" src="/jsp/admin/cebbank/AnnuityDesktop.jsp?community=<%=teasession._strCommunity%><%--&corp_no=<%=corp_no%>--%>">
  </frameset>

 <!-- <frame src="/jsp/admin/cebbank/AnnuityFrame.jsp?community=<%=teasession._strCommunity%>&frame=footer" style="overflow:hidden"> -->
</frameset>

</html>
<%
}else
{
  String trade_no=Annuity.des(tn);
  String info=r.getString(teasession._nLanguage,"Annuity."+trade_no);//+trade_no
  //集团判断
  ArrayList acn = (ArrayList) session.getAttribute("annuity.corp_no");
  if(!code.equals(corp_no)&&(acn==null||acn.indexOf(corp_no)==-1))
  {
    response.sendError(403);
    return;
  }

  StringBuffer param=new StringBuffer();
  param.append("?community=").append(teasession._strCommunity);
  param.append("&tn=").append(tn);
  //param.append("&corp_no=").append(corp_no);

  Map m=new HashMap();
  m.put("trade_no",trade_no);
  Boolean if_tip = (Boolean) session.getAttribute("if_tip");
  if (if_tip != null && if_tip.booleanValue())
  {
  }else
  {
    m.put("user",user);//code
  }
  if("0009".equals(trade_no))
  {
    m.put("code",code);//code
    m.put("corp_no",corp_no);//code
  }else
  {
    m.put("code",corp_no);//code
  }
  String pk_corporation=(String)session.getAttribute("pk_corporation");//企业主键
  if(pk_corporation!=null&&pk_corporation.length()>0)
  {
    m.put("pk_corporation",pk_corporation);//Annuity.des(pkc)
  }
  String plan_code=request.getParameter("plan_code");//计划编码
  if(plan_code!=null&&plan_code.length()>0)
  {
    m.put("plan_code",plan_code);
    param.append("&plan_code=").append(plan_code);
  }
  String startdate=request.getParameter("startdate");//开始日期
  if(startdate!=null&&startdate.length()>0)
  {
    m.put("startdate",startdate);
    param.append("&startdate=").append(startdate);
  }
  String enddate=request.getParameter("enddate");//截止日期
  if(enddate!=null&&enddate.length()>0)
  {
    m.put("enddate",enddate);
    param.append("&enddate=").append(enddate);
  }
  String person_code=request.getParameter("person_code");//职工编号
  if(person_code!=null&&person_code.length()>0)
  {
    m.put("person_code",person_code);
    param.append("&person_code=").append(person_code);
  }
  String person_name=request.getParameter("person_name");//职工姓名
  if(person_name!=null&&person_name.length()>0)
  {
    m.put("person_name",person_name);
    param.append("&person_name=").append(URLEncoder.encode(person_name,"UTF-8"));
  }
  String identity_no=request.getParameter("identity_no");//证件号码
  if(identity_no!=null&&identity_no.length()>0)
  {
    m.put("identity_no",identity_no);
    param.append("&identity_no=").append(identity_no);
  }
  param.append("&info=").append(URLEncoder.encode(info,"UTF-8"));

  String trade_type=request.getParameter("trade_type");//业务类型
  if(trade_type!=null&&trade_type.length()>0)
  {
    m.put("trade_type",trade_type);
  }
  short period=-1;
  String tmp=request.getParameter("period");
  if(tmp!=null)
  {
    period=Short.parseShort(tmp);
  }
  if(period!=-1)
  {
    m.put("period",new Short(period));
    param.append("&period=").append(period);
  }
  int pos=-1,size=10;
  tmp=request.getParameter("pos");
  if(tmp!=null)
  {
    pos=Integer.parseInt(tmp);
  }
  param.append("&pos=");

  if("/0005/0006/0013/0014/1005/1006/1009/1010/1011/1014/4001/4003/5001/5003/5005/8003/8004/".indexOf(trade_no)==-1)//有分页的交易///
  {
    m=(Map)Annuity.conn(m);

    String ec = (String) m.get("error_code");
    if (!Annuity.EC_0000.equals(ec))
    {
      response.sendRedirect("/jsp/info/Alert.jsp?info=" +URLEncoder.encode(r.getString(teasession._nLanguage,"Annuity.error_code."+ec),"UTF-8"));
      return;
    }
  }
  Calendar c=Calendar.getInstance();






  if(trade_no.equals("0009")||trade_no.equals("1013"))
  {


  %>
<jsp:include page="/jsp/admin/cebbank/AnnuityFrame.jsp" >
<jsp:param name="frame" value="header"/>
</jsp:include>

<jsp:include page="/jsp/admin/cebbank/AnnuityFrame.jsp" >
<jsp:param name="frame" value="mainheader"/>
<jsp:param name="info" value="<%=info%>"/>
<jsp:param name="if_tip" value="true"/>
</jsp:include>

<div id="new"></div><div style="width:100%;overflow: auto;"><div id="neirong">

<form name="form1" action="?" >
<input type=hidden name="community" value="<%=teasession._strCommunity%>">
<input type=hidden name="tn" value="<%=tn%>">
<input type=hidden name="info" value="<%=info%>">
<%
if(corp_no!=null)
{
  out.print("<input type=hidden name=corp_no value="+corp_no+">");
}
%>

  <%
    if(trade_no.equals("0009"))
    {
      ArrayList al=(ArrayList)m.get("result");
      %>
      <%@include file="/jsp/admin/cebbank/Annuity_0009.jsp"%>
      <%
    }else if(trade_no.equals("1013"))
    {
      ArrayList al=(ArrayList)m.get("result");
      %>
      <%@include file="/jsp/admin/cebbank/Annuity_1013.jsp"%>
      <%
    }
    %>

</form>

</div>

<jsp:include page="/jsp/admin/cebbank/AnnuityFrame.jsp" >
<jsp:param name="frame" value="mainfooter"/>
</jsp:include>

</div>

<jsp:include page="/jsp/admin/cebbank/AnnuityFrame.jsp" >
<jsp:param name="frame" value="footer"/>
</jsp:include>


    <%
  }else
  {
    //交易判断
    ArrayList atn=(ArrayList)session.getAttribute("annuity.trade_no");
    if(atn==null||atn.indexOf(trade_no)==-1)
    {
      response.sendError(403);
      return;
    }



  %>
  <jsp:include page="/jsp/admin/cebbank/AnnuityFrame.jsp">
  <jsp:param name="frame" value="mainheader"/>
  <jsp:param name="info" value="<%=info%>"/>
  </jsp:include>
  <div id="new"></div><div style="width:100%;overflow: auto;"><div id="neirong">
    <form name="form1" action="?" >
    <input type=hidden name="community" value="<%=teasession._strCommunity%>">
    <input type=hidden name="tn" value="<%=tn%>">
    <input type=hidden name="info" value="<%=info%>">
    <input type=hidden name="corp_no" value="<%=corp_no%>">
    <input type=hidden name="pos" value="0">


<%
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////===0001===///////////////////////
if(trade_no.equals("0001"))
{
  ArrayList al=(ArrayList)m.get("result");
  Map v=(Map)al.get(0);
%>
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
<input id="xia_z" type=image src="/res/fulijihua/u/0802/080239018.gif" name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity';">





<%
}else//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////===0002===///////////////////////
if(trade_no.equals("0002"))
{
  ArrayList al=(ArrayList)m.get("result");
%>

<DIV id=neibiao><SPAN id=biaol></SPAN><SPAN id=neibiaozi><%=r.getString(teasession._nLanguage,"1186469885359")%>( <%=al.size()%> )</SPAN>
  <SPAN id=biaor></SPAN>
  <span id="biaor_text"><%=Annuity.Annuity_0007(session,corp_no,  plan_code)%></span>
  <span id="biaor_text"><input type="submit" value="GO" onclick="form1.action='?'"></span></DIV>

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
  for (int i = 0; i < al.size(); i++)
  {
    Map v = (Map) al.get(i);
    plan_code = (String) v.get("plan_code");
    String plan_name = (String) v.get("plan_name");
    %>
    <tr>
      <td><%=plan_code%></td>
      <td><%=plan_name%></td>
      <td><%=Annuity.d(v.get("invest_option"))%></td>
      <td><%=Annuity.d(v.get("contr_period"))%></td>
      <td><%=Annuity.d(v.get("contr_month"))%></td>
      <td><%=Annuity.d(v.get("contr_day"))%></td>
      <td><%=Annuity.d(v.get("offer_way"))%></td>
      <td><%=Annuity.d(v.get("corpplan_status"))%></td>
      <td><%=Annuity.d(v.get("contr_status"))%></td>
      <td><%=Annuity.d(v.get("contact_person"))%></td>
      <td><%=Annuity.d(v.get("contact_address"))%></td>
      <td><%=Annuity.d(v.get("contact_phone"))%></td>
      <td><%=Annuity.d(v.get("postcode"))%></td>
      <td><%=Annuity.d(v.get("join_date"))%></td>
    </tr>
    <%
    }
    %>
    </TBODY>
</TABLE>
<input id="xia_z" type=image src="/res/fulijihua/u/0802/080239018.gif" name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity';">





<%
}else//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////===0003===///////////////////////
if(trade_no.equals("0003"))
{
    ArrayList al=(ArrayList)m.get("result");
%>

<DIV id=neibiao><SPAN id=biaol></SPAN><SPAN id=neibiaozi><%=r.getString(teasession._nLanguage,"1186539505703")%> ( <%=al.size()%> )</SPAN>
<SPAN id=biaor></SPAN>
<span id="biaor_text"><%=Annuity.Annuity_0007(session,corp_no,plan_code)%></span>
<span id="biaor_text"><input type="submit" value="GO"  onclick="form1.action='?'"/></span>
</DIV>


<table style="BORDER-COLLAPSE: collapse" cellSpacing=0 cellPadding=0 border=0>
<TBODY>
<TR class=shuohang>
<td noWrap><%=r.getString(teasession._nLanguage,"1186466576328")%></td>
<td noWrap><%=r.getString(teasession._nLanguage,"1186466756468")%></td>
<td noWrap><%=r.getString(teasession._nLanguage,"1186539710734")%></td>
<td noWrap><%=r.getString(teasession._nLanguage,"1186539798062")%></td>
<td noWrap><%=r.getString(teasession._nLanguage,"1186539843031")%></td>
<td noWrap><%=r.getString(teasession._nLanguage,"1186539912765")%></td>
</tr>
<%
for(int i=0;i<al.size();i++)
{
  Map v=(Map)al.get(i);
  plan_code=(String)v.get("plan_code");
  String plan_name=(String)v.get("plan_name");
%>
<tr>
<td><%=plan_code%></td>
<td><%=plan_name%></td>
<td><%=Annuity.d(v.get("account_balance"))%></td>
<td><%=Annuity.d(v.get("corp_balance"))%></td>
<td><%=Annuity.d(v.get("person_balance"))%></td>
<td><%=Annuity.d(v.get("sp_balance"))%></td>
</tr>
<%}%>
</TBODY>
</TABLE>
<input id="xia_z" type=image src="/res/fulijihua/u/0802/080239018.gif" name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity';">





<%
}else//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////===0004===///////////////////////
if(trade_no.equals("0004"))
{
  ArrayList al=(ArrayList)m.get("result");
%>
<DIV id=neibiao><SPAN id=biaol></SPAN><SPAN id=neibiaozi><%=r.getString(teasession._nLanguage,"1186471072296")%> ( <%=al.size()%> )</SPAN>
<SPAN id=biaor></SPAN><span id="biaor_text"><%=Annuity.Annuity_0007(session,corp_no,plan_code)%></span>
<span id="biaor_text"><input type="submit" value="GO"  onclick="form1.action='?'"/></span>
</DIV>

<table style="BORDER-COLLAPSE: collapse" cellSpacing=0 cellPadding=0 border=0>
<TBODY>
<TR class=shuohang>
<td noWrap><%=r.getString(teasession._nLanguage,"1186466576328")%></td>
<td noWrap><%=r.getString(teasession._nLanguage,"1186466756468")%></td>
<td noWrap><%=r.getString(teasession._nLanguage,"1186471222875")%></td>
<td noWrap><%=r.getString(teasession._nLanguage,"1186471324781")%></td>
<td noWrap><%=r.getString(teasession._nLanguage,"1207536083500")%></td>
<td noWrap><%=r.getString(teasession._nLanguage,"1207535844656")%></td>
<td noWrap><%=r.getString(teasession._nLanguage,"1186471425296")%></td>
<td noWrap><%=r.getString(teasession._nLanguage,"1186471494734")%></td>
<td noWrap><%=r.getString(teasession._nLanguage,"1186471562984")%></td>
<td noWrap><%=r.getString(teasession._nLanguage,"1186471621359")%></td>
<td noWrap><%=r.getString(teasession._nLanguage,"1186471660609")%></td>
</tr>
<%
for(int i=0;i<al.size();i++)
{
  Map v=(Map)al.get(i);
  plan_code=(String)v.get("plan_code");
  String plan_name=(String)v.get("plan_name");
%>
<tr>
<td><%=Annuity.d(plan_code)%></td>
<td><%=Annuity.d(plan_name)%></td>
<td><%=Annuity.d(v.get("invest_code"))%></td>
<td><%=Annuity.d(v.get("invest_name"))%></td>
<td><%=Annuity.d(v.get("account_unit"))%></td>
<td><%=Annuity.d(v.get("net_value"))%></td>
<td><%=Annuity.d(v.get("corp_cash"))%></td>
<td><%=Annuity.d(v.get("person_cash"))%></td>
<td><%=Annuity.d(v.get("sp_cash"))%></td>
<td><%=Annuity.d(v.get("account_cash"))%></td>
<td><%=Annuity.d(v.get("unit"))%></td>
</tr>
<%}%>
</TBODY>
</TABLE>

<input id="xia_z" type=image src="/res/fulijihua/u/0802/080239018.gif" name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity';">









<%
}else//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////===0005===///////////////////////
if(trade_no.equals("0005"))
{
%>
<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186471785671")%></span><span id="biaor"></span></div>
<table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse">
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186471846765")%>：</td>
    <td><span style="float:left;margin-left:10px;"><%=Annuity.Annuity_0007(session,corp_no,plan_code)%></span></td>
  </tr>
<tr><td class="zuoge">* <%=r.getString(teasession._nLanguage,"1186472518328")%>：</td><td><table border="0" cellspacing="0" cellpadding="0">
<tr><td style="width:15px;"><%=r.getString(teasession._nLanguage,"1186542510031")%>：</td><td style="width:180px;"><input class="biaodan" type="text" name="startdate" value="<%=startdate!=null?startdate:(c.get(c.YEAR)+"-"+(c.get(c.MONTH)+1)+"-1")%>" /><a href=### onclick="showCalendar('form1.startdate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td>
<td class="xiaobiao"><%=r.getString(teasession._nLanguage,"1186542560843")%>：</td><td><input class="biaodan" type="text" name="enddate"  value="<%=enddate!=null?enddate:(c.get(c.YEAR)+"-"+(c.get(c.MONTH)+1)+"-"+c.get(c.DAY_OF_MONTH))%>" /><a href=### onclick="showCalendar('form1.enddate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td></tr></table></td></tr></table>
<input class="bdanniu" type="submit" value="<%=r.getString(teasession._nLanguage,"1186542726218")%>" onclick="return f_time();"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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

<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186472008640")%> ( <%=al.size()%> )</span><span id="biaor"></span></div>
  <table style="border-collapse:collapse" border="0" cellspacing="0" cellpadding="0">
  <tr>
<td colspan="7" class="youge">　<%=r.getString(teasession._nLanguage,"1186472111484")%>：<%=startdate%>　　　　　　<%=r.getString(teasession._nLanguage,"1186472169000")%>：<%=enddate%></td>
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

<input id="xia_z" type=image src="/res/fulijihua/u/0802/080239018.gif" name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity';">

<%
}}%>












<%
}else//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////===0006===///////////////////////
if(trade_no.equals("0006"))
{
%>
<div id="neibiao">
  <span id="biaol"></span>
  <span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186472777046")%></span>
  <span id="biaor"></span>
</div>
<table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse">
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186471846765")%>：</td>
    <td><span style="float:left;margin-left:10px;"><%=Annuity.Annuity_0007(session,corp_no,plan_code)%></span></td>
  </tr>
  <tr>
    <td class="zuoge">* <%=r.getString(teasession._nLanguage,"1186472518328")%>：</td>
    <td>
      <table border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td style="width:15px;"><%=r.getString(teasession._nLanguage,"1186542510031")%>：</td>
          <td style="width:180px;"><input class="biaodan" type="text" name="startdate" value="<%=startdate!=null?startdate:(c.get(c.YEAR)+"-"+(c.get(c.MONTH)+1)+"-1")%>" /><a href=### onclick="showCalendar('form1.startdate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td>
          <td class="xiaobiao"><%=r.getString(teasession._nLanguage,"1186542560843")%>：</td>
          <td><input class="biaodan" type="text" name="enddate"  value="<%=enddate!=null?enddate:(c.get(c.YEAR)+"-"+(c.get(c.MONTH)+1)+"-"+c.get(c.DAY_OF_MONTH))%>" /><a href=### onclick="showCalendar('form1.enddate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td>
        </tr>
      </table>
</td>
  </tr>
</table>
<input class="bdanniu" type="submit" value="<%=r.getString(teasession._nLanguage,"1186542726218")%>" onclick="return f_time();"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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

<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186472998109")%> ( <%=al.size()%> )</span><span id="biaor"></span></div>
  <table style="border-collapse:collapse" border="0" cellspacing="0" cellpadding="0">
  <tr>
<td colspan="6" class="youge">　<%=r.getString(teasession._nLanguage,"1186472111484")%>：<%=startdate%>　　　　　　<%=r.getString(teasession._nLanguage,"1186472169000")%>：<%=enddate%></td>
</tr>
    <tr class="shuohang">
      <td nowrap><%=r.getString(teasession._nLanguage,"1186466576328")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186466756468")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186473455125")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186473614656")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186473673953")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186473735703")%></td>
    </tr>
<%
for(int i=0;i<al.size();i++)
{
  Map v=(Map)al.get(i);
%>
    <tr>
      <td><%=v.get("plan_code")%></td>
      <td><%=v.get("plan_name")%></td>
      <td><%=Annuity.d(v.get("pay_sum"))%></td>
      <td><%=Annuity.d(v.get("invest_name"))%></td>
      <td><%=Annuity.d(v.get("investpay_sum"))%></td>
      <td><%=Annuity.d(v.get("pay_date"))%></td>
    </tr>
<%
}%>
</table>

<input id="xia_z" type=image src="/res/fulijihua/u/0802/080239018.gif" name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity';">

<%
}}%>









<%
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////===0011===///////////////////////
}else if(trade_no.equals("0011"))
{
%>
<div id="neibiao">
  <span id="biaol"></span>
  <span id="neibiaozi"><%=r.getString(teasession._nLanguage,"Annuity.0011")%></span>
  <span id="biaor"></span>
</div>
<table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse">
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186471846765")%>：</td>
    <td><%=Annuity.Annuity_0007(session,corp_no, plan_code)%></td>
  </tr>
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1207535658484")%>：</td>
    <td><%=Annuity.Annuity_GT(trade_type)%></td>
  </tr>
</table>
<input class="bdanniu" type="submit" value="<%=r.getString(teasession._nLanguage,"1186542726218")%>" onclick="form1.action='?'"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input class="bdanniu" type="button" value="<%=r.getString(teasession._nLanguage,"1186542790281")%>" onclick="clearFrom(form1);"/>


<%
if(plan_code!=null&&trade_type!=null)
{
  ArrayList al=(ArrayList)m.get("result");
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
      <td noWrap><%=r.getString(teasession._nLanguage,"1207535658484")%></td>
      <td noWrap><%=r.getString(teasession._nLanguage,"1207534911625")%></td>
      <td noWrap><%=r.getString(teasession._nLanguage,"1207534929375")%></td>
      <td noWrap><%=r.getString(teasession._nLanguage,"1207534957000")%></td>
      <td noWrap><%=r.getString(teasession._nLanguage,"1186473735703")%></td>
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

<input id="xia_z" type=image src="/res/fulijihua/u/0802/080239018.gif" name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity';">
<%}%>














<%
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////===0012===///////////////////////
}else if(trade_no.equals("0012"))
{
%>
<div id="neibiao">
  <span id="biaol"></span>
  <span id="neibiaozi"><%=r.getString(teasession._nLanguage,"Annuity.0012")%></span>
  <span id="biaor"></span>
</div>
<table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse">
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186471846765")%>：</td>
    <td><%=Annuity.Annuity_0007(session,corp_no, plan_code)%></td>
  </tr>
    <tr><td class="zuoge">*<%=r.getString(teasession._nLanguage,"1186472518328")%>：</td>
      <td>
        <table border="0" cellspacing="0" cellpadding="0">
          <tr>
              <td style="width:15px;"><%=r.getString(teasession._nLanguage,"1186542510031")%>：</td>
              <td style="width:180px;"><input class="biaodan" type="text" name="startdate" value="<%if(startdate!=null)out.print(startdate);%>" readonly><a href=### onclick="showCalendar('form1.startdate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td>
                <td class="xiaobiao"><%=r.getString(teasession._nLanguage,"1186542560843")%>：</td>
                <td><input class="biaodan" type="text" name="enddate" value="<%if(enddate!=null)out.print(enddate);%>" readonly><a href=### onclick="showCalendar('form1.enddate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td>
          </tr>
        </table>
      </td>
    </tr>
</table>
<input class="bdanniu" type="submit" value="<%=r.getString(teasession._nLanguage,"1186542726218")%>" onclick="return f_time();"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input class="bdanniu" type="button" value="<%=r.getString(teasession._nLanguage,"1186542790281")%>" onclick="clearFrom(form1);"/>


<%
if(startdate!=null&&enddate!=null)
{
  ArrayList al=(ArrayList)m.get("result");
%>
<DIV id=neibiao>
  <SPAN id=biaol></SPAN>
  <SPAN id=neibiaozi><%=r.getString(teasession._nLanguage,"Annuity.0012")%>( <%=al.size()%> )</SPAN>
  <span id="biaor"></span>
</DIV>

<table style="BORDER-COLLAPSE: collapse" cellSpacing=0 cellPadding=0 border=0>
  <TBODY>
    <TR class=shuohang>
      <td noWrap><%=r.getString(teasession._nLanguage,"1186536333546")%></td>
      <td noWrap><%=r.getString(teasession._nLanguage,"1186536398843")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186468848421")%></td>
      <td noWrap><%=r.getString(teasession._nLanguage,"1186466576328")%></td>
      <td noWrap><%=r.getString(teasession._nLanguage,"1186466756468")%></td>
      <td noWrap><%=r.getString(teasession._nLanguage,"1186471324781")%></td>
      <td noWrap><%=r.getString(teasession._nLanguage,"1186473673953")%></td>
      <td noWrap><%=r.getString(teasession._nLanguage,"1186473735703")%></td>
    </tr>
    <%
    for (int i = 0; i < al.size(); i++)
    {
      Map v = (Map) al.get(i);
      %>
      <tr>
        <td><%=Annuity.d(v.get("person_no"))%></td>
        <td><%=Annuity.d(v.get("name"))%></td>
        <td><%=Annuity.d(v.get("corp_name"))%></td>
        <td><%=Annuity.d(v.get("plan_code"))%></td>
        <td><%=Annuity.d(v.get("plan_name"))%></td>
        <td><%=Annuity.d(v.get("invest_name"))%></td>
        <td><%=Annuity.d(v.get("investpay_sum"))%></td>
        <td><%=Annuity.d(v.get("pay_date"))%></td>
      </tr>
      <%
    }
      %>
      </TBODY>
</TABLE>

<input id="xia_z" type=image src="/res/fulijihua/u/0802/080239018.gif" name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity';">
<%}%>















<%
}else//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////===0013===///////////////////////
if(trade_no.equals("0013"))
{
%>
<div id="neibiao">
  <span id="biaol"></span>
  <span id="neibiaozi"><%=r.getString(teasession._nLanguage,"Annuity.0013")%></span>
  <span id="biaor"></span></div>
  <table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse">
    <tr>
      <td class="zuoge"><%=r.getString(teasession._nLanguage,"1207535658484")%>：</td>
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
<input class="bdanniu" type="submit" value="<%=r.getString(teasession._nLanguage,"1186542726218")%>"  onclick="return f_time();"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
    <td nowrap><%=r.getString(teasession._nLanguage,"1207535658484")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1207534911625")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1207534929375")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1207534957000")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1186473735703")%></td>
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
}
%>
</table>
<input id="xia_z" type=image src="/res/fulijihua/u/0802/080239018.gif" name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity';">

<%}}%>










<%
}else//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////===0014===///////////////////////
if(trade_no.equals("0014"))
{
%>
<div id="neibiao">
  <span id="biaol"></span>
  <span id="neibiaozi"><%=r.getString(teasession._nLanguage,"Annuity.0014")%></span>
  <span id="biaor"></span></div>
  <table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse">
    <tr>
      <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186471846765")%>：</td>
      <td><%=Annuity.Annuity_0007(session,corp_no, plan_code)%></td>
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
<input class="bdanniu" type="submit" value="<%=r.getString(teasession._nLanguage,"1186542726218")%>"  onclick="return f_time();"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
  <span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1207534794500")%> ( <%=al.size()%> )</span>
  <span id="biaor"></span>
</div>
<table style="border-collapse:collapse" border="0" cellspacing="0" cellpadding="0">
  <tr><td colspan="6" class="youge">　<%=r.getString(teasession._nLanguage,"1186472111484")%>：<%=startdate%>　　　　　　<%=r.getString(teasession._nLanguage,"1186472169000")%>：<%=enddate%></td></tr>
  <tr class="shuohang">
    <td nowrap><%=r.getString(teasession._nLanguage,"1186466756468")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1186477035000")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1207534911625")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1207534929375")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1207534957000")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1186473735703")%></td>
  </tr>
<%
for(int i=0;i<al.size();i++)
{
  Map v=(Map)al.get(i);
  %>
  <tr>
    <td><%=v.get("plan_name")%></td>
    <td><%=Annuity.d(v.get("income_sum"))%></td>
    <td><%=Annuity.d(v.get("corp_income_sum"))%></td>
    <td><%=Annuity.d(v.get("person_income_sum"))%></td>
    <td><%=Annuity.d(v.get("accour_date"))%></td>
  </tr>
  <%
}

%>
</table>
<input id="xia_z" type=image src="/res/fulijihua/u/0802/080239018.gif" name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity';">

<%
}
}
%>























<%
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////===1001===///////////////////////
}else if(trade_no.equals("1001"))
{
  ArrayList al=(ArrayList)m.get("result");
  Map v=(Map)al.get(0);
%>
<%@include file="/jsp/admin/cebbank/Annuity_1001.jsp" %>
<%
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////===1002===///////////////////////
}else if(trade_no.equals("1002"))
{
  ArrayList al=(ArrayList)m.get("result");
%>
<%@include file="/jsp/admin/cebbank/Annuity_1002.jsp" %>
<%
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////===1003===///////////////////////
}else if(trade_no.equals("1003"))
{
  ArrayList al=(ArrayList)m.get("result");
%>
<%@include file="/jsp/admin/cebbank/Annuity_1003.jsp" %>
<%
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////===1004===///////////////////////
}else if(trade_no.equals("1004"))
{
  ArrayList al=(ArrayList)m.get("result");
%>

<DIV id=neibiao><SPAN id=biaol></SPAN><SPAN id=neibiaozi><%=r.getString(teasession._nLanguage,"1186475850812")%> ( <%=al.size()%> )</SPAN>
<SPAN id=biaor></SPAN><span id="biaor_text"><%=Annuity.Annuity_1007(session,plan_code)%></span>
<span id="biaor_text"><input type="submit" value="GO" onclick="form1.action='?'"/></span>
</DIV>


<table style="BORDER-COLLAPSE: collapse" cellSpacing=0 cellPadding=0 border=0>
<TBODY>
<TR class=shuohang>
  <td nowrap><%=r.getString(teasession._nLanguage,"1186468848421")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage,"1186466576328")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage,"1186466756468")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage,"1186471222875")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage,"1186471324781")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage,"1186471425296")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage,"1186476170000")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage,"1186471494734")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage,"1186476253984")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage,"1207535844656")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage,"1186476345546")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage,"1186476407218")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage,"1186471660609")%></td>
</tr>
<%
for(int i=0;i<al.size();i++)
{
	Map v=(Map)al.get(i);
	plan_code=(String)v.get("plan_code");
	String plan_name=(String)v.get("plan_name");
%>
<tr>
<td><%=Annuity.d(v.get("corp_name"))%></td>
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








<%
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////===1005===///////////////////////
}else if(trade_no.equals("1005"))
{
%>
<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186476580531")%></span><span id="biaor"></span></div>
<table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse"><tr><td class="zuoge"><%=r.getString(teasession._nLanguage,"1186471846765")%>：</td><td ><span style="float:left;margin-left:10px;">
<%=Annuity.Annuity_1007(session,plan_code)%>
</span>
</td></tr>
<tr><td class="zuoge">* <%=r.getString(teasession._nLanguage,"1186472518328")%>：</td><td><table border="0" cellspacing="0" cellpadding="0">
<tr><td style="width:15px;"><%=r.getString(teasession._nLanguage,"1186542510031")%>：</td><td style="width:180px;"><input class="biaodan" type="text" name="startdate" value="<%if(startdate!=null)out.print(startdate);%>" /><a href=### onclick="showCalendar('form1.startdate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td>
<td class="xiaobiao"><%=r.getString(teasession._nLanguage,"1186542560843")%>：</td><td><input class="biaodan" type="text" name="enddate"  value="<%if(enddate!=null)out.print(enddate);%>" /><a href=### onclick="showCalendar('form1.enddate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td></tr></table></td></tr></table>
<input class="bdanniu" type="submit" value="<%=r.getString(teasession._nLanguage,"1186542726218")%>"  onclick="return f_time();"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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

<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186476774468")%> ( <%=al.size()%> )</span>
<span id="biaor"></span></div>
  <table style="border-collapse:collapse" border="0" cellspacing="0" cellpadding="0">
  <tr>
<td colspan="6" class="youge">　<%=r.getString(teasession._nLanguage,"1186472111484")%>：<%=startdate%>　　　　　　<%=r.getString(teasession._nLanguage,"1186472169000")%>：<%=enddate%></td>
</tr>
<tr class="shuohang">
  <td nowrap><%=r.getString(teasession._nLanguage,"1186468848421")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage,"1186466576328")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage,"1186466756468")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage,"1186477035000")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage,"1186472405609")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage,"1186472457781")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage,"1186535903171")%></td>
</tr>
<%
for(int i=0;i<al.size();i++)
{
	Map v=(Map)al.get(i);
%>
    <tr>
      <td><%=Annuity.d(v.get("corp_name"))%></td>
      <td><%=v.get("plan_code")%></td>
      <td><%=v.get("plan_name")%></td>
      <td><%=Annuity.d(v.get("contr_sum"))%></td>
      <td><%=Annuity.d(v.get("corpcontr_sum"))%></td>
      <td><%=Annuity.d(v.get("personcontr_sum"))%></td>
      <td><%=Annuity.d(v.get("contr_date"))%></td>
    </tr>
<%
}%>
</table>

<input id="xia_z" type=image src="/res/fulijihua/u/0802/080239018.gif" name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity';">

<%
}}%>






<%
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////===1006===///////////////////////
}else if(trade_no.equals("1006"))
{
%>
<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186480274281")%></span><span id="biaor"></span></div>
<table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse">
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186471846765")%>：</td>
    <td><span style="float:left;margin-left:10px;"><%=Annuity.Annuity_1007(session,plan_code)%></span></td>
  </tr>
  <tr>
    <td class="zuoge">* <%=r.getString(teasession._nLanguage,"1186472518328")%>：</td>
    <td>
      <table border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td style="width:15px;"><%=r.getString(teasession._nLanguage,"1186542510031")%>：</td>
          <td style="width:180px;"><input class="biaodan" type="text" name="startdate" value="<%if(startdate!=null)out.print(startdate);%>" /><a href=### onclick="showCalendar('form1.startdate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td>
            <td class="xiaobiao"><%=r.getString(teasession._nLanguage,"1186542560843")%>：</td>
            <td><input class="biaodan" type="text" name="enddate"  value="<%if(enddate!=null)out.print(enddate);%>" /><a href=### onclick="showCalendar('form1.enddate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td>
        </tr>
      </table>
</td></tr>
</table>
<input class="bdanniu" type="submit" value="<%=r.getString(teasession._nLanguage,"1186542726218")%>" onclick="return f_time();"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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

<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186480401140")%> ( <%=al.size()%> )</span><span id="biaor"></span></div>
  <table style="border-collapse:collapse" border="0" cellspacing="0" cellpadding="0">
  <tr>
<td colspan="6" class="youge">　<%=r.getString(teasession._nLanguage,"1186472111484")%>：<%=startdate%>　　　　　　<%=r.getString(teasession._nLanguage,"1186472169000")%>：<%=enddate%></td>
</tr>
    <tr class="shuohang">
      <td nowrap><%=r.getString(teasession._nLanguage,"1186468848421")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186466576328")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186466756468")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186471324781")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186480610609")%></td>
<!--      <td nowrap><%=r.getString(teasession._nLanguage,"1186480666265")%></td> -->
      <td nowrap><%=r.getString(teasession._nLanguage,"1186473735703")%></td>
    </tr>
<%
for(int i=0;i<al.size();i++)
{
  Map v=(Map)al.get(i);
%>
    <tr>
      <td><%=Annuity.d(v.get("corp_name"))%></td>
      <td><%=v.get("plan_code")%></td>
      <td><%=v.get("plan_name")%></td>
      <td><%=Annuity.d(v.get("invest_name"))%></td>
      <td><%=Annuity.d(v.get("investpay_sum"))%></td>
<!--      <td><%=Annuity.d(v.get("pay_sum"))%></td>-->
      <td><%=Annuity.d(v.get("pay_date"))%></td>
    </tr>
<%
}%>
</table>

<input id="xia_z" type=image src="/res/fulijihua/u/0802/080239018.gif" name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity';">
<%
}}%>








<%
}else//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////===1009===///////////////////////
if(trade_no.equals("1009"))
{
%>
<div id="neibiao">
  <span id="biaol"></span>
  <span id="neibiaozi"><%=r.getString(teasession._nLanguage,"Annuity.1009")%></span>
  <span id="biaor"></span></div>
  <table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse">
    <tr>
      <td class="zuoge"><%=r.getString(teasession._nLanguage,"1207535658484")%>：</td>
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
<input class="bdanniu" type="submit" value="<%=r.getString(teasession._nLanguage,"1186542726218")%>"  onclick="return f_time();"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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

<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186476774468")%> ( <%=al.size()%> )</span>
<span id="biaor"></span></div>
<table style="border-collapse:collapse" border="0" cellspacing="0" cellpadding="0">
  <tr><td colspan="6" class="youge">　<%=r.getString(teasession._nLanguage,"1186472111484")%>：<%=startdate%>　　　　　　<%=r.getString(teasession._nLanguage,"1186472169000")%>：<%=enddate%></td></tr>
  <tr class="shuohang">
    <td nowrap><%=r.getString(teasession._nLanguage,"1186468848421")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1207535658484")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1207534911625")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1207534929375")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1207534957000")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1186473735703")%></td>
  </tr>
<%
for(int i=0;i<al.size();i++)
{
  Map v=(Map)al.get(i);
  %>
  <tr>
    <td><%=Annuity.d(v.get("corp_name"))%></td>
    <td><%=v.get("trade_type")%></td>
    <td><%=Annuity.d(v.get("corp_accour_balance"))%></td>
    <td><%=Annuity.d(v.get("person_accour_balance"))%></td>
    <td><%=Annuity.d(v.get("total_accour_balance"))%></td>
    <td><%=Annuity.d(v.get("accour_date"))%></td>
  </tr>
  <%
}%>
</table>

<input id="xia_z" type=image src="/res/fulijihua/u/0802/080239018.gif" name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity';">

<%
}
}%>










<%
}else//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////===1010===///////////////////////
if(trade_no.equals("1010"))
{
%>
<div id="neibiao">
  <span id="biaol"></span>
  <span id="neibiaozi"><%=r.getString(teasession._nLanguage,"Annuity.1010")%></span>
  <span id="biaor"></span></div>
  <table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse">
    <tr>
      <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186471846765")%>：</td>
      <td><%=Annuity.Annuity_1007(session,plan_code)%></td>
    </tr>
    <tr>
      <td class="zuoge"><%=r.getString(teasession._nLanguage,"1207535658484")%>：</td>
      <td><%=Annuity.Annuity_GT(trade_type)%></td>
    </tr>
    <tr><td class="zuoge">*<%=r.getString(teasession._nLanguage,"1186472518328")%>：</td>
      <td>
        <table border="0" cellspacing="0" cellpadding="0">
          <tr>
              <td style="width:15px;"><%=r.getString(teasession._nLanguage,"1186542510031")%>：</td>
              <td style="width:180px;"><input class="biaodan" type="text" name="startdate" value="<%if(startdate!=null)out.print(startdate);%>" readonly><a href=### onclick="showCalendar('form1.startdate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td>
                <td class="xiaobiao"><%=r.getString(teasession._nLanguage,"1186542560843")%>：</td>
                <td><input class="biaodan" type="text" name="enddate" value="<%if(enddate!=null)out.print(enddate);%>" readonly><a href=### onclick="showCalendar('form1.enddate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td>
            </tr>
          </table>
      </td>
    </tr>
  </table>
<input class="bdanniu" type="submit" value="<%=r.getString(teasession._nLanguage,"1186542726218")%>"  onclick="return f_time();"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
  <span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186476774468")%> ( <%=al.size()%> )</span>
  <span id="biaor"></span>
</div>
<table style="border-collapse:collapse" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td colspan="7" class="youge">　<%=r.getString(teasession._nLanguage,"1186472111484")%>：<%=startdate%>　　　　　　<%=r.getString(teasession._nLanguage,"1186472169000")%>：<%=enddate%></td>
  </tr>
  <tr class="shuohang">
    <td nowrap><%=r.getString(teasession._nLanguage,"1186466756468")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1186468848421")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1207535658484")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1207534911625")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1207534929375")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1207534957000")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1186473735703")%></td>
  </tr>
<%
for(int i=0;i<al.size();i++)
{
  Map v=(Map)al.get(i);
  %>
  <tr>
    <td><%=Annuity.d(v.get("plan_name"))%></td>
    <td><%=Annuity.d(v.get("corp_name"))%></td>
    <td><%=Annuity.d(v.get("trade_type"))%></td>
    <td><%=Annuity.d(v.get("corp_accour_balance"))%></td>
    <td><%=Annuity.d(v.get("person_accour_balance"))%></td>
    <td><%=Annuity.d(v.get("total_accour_balance"))%></td>
    <td><%=Annuity.d(v.get("accour_date"))%></td>
  </tr>
  <%
}%>
</table>

<input id="xia_z" type=image src="/res/fulijihua/u/0802/080239018.gif" name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity';">

<%
}
}%>










<%
}else//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////===1011===///////////////////////
if(trade_no.equals("1011"))
{
%>
<div id="neibiao">
  <span id="biaol"></span>
  <span id="neibiaozi"><%=r.getString(teasession._nLanguage,"Annuity.1011")%></span>
  <span id="biaor"></span>
</div>
<table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse">
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1207535132312")%>：</td>
    <td align="left">
      <select name="period" style="width:100px">
        <option value="0"><%=r.getString(teasession._nLanguage,"1207535149078")%></option>
        <option value="1" <%if(1==period)out.print(" SELECTED ");%>><%=r.getString(teasession._nLanguage,"1207535164984")%></option>
        <option value="2" <%if(2==period)out.print(" SELECTED ");%>><%=r.getString(teasession._nLanguage,"1207535178984")%></option>
      </select>
    </td>
  </tr>
</table>
<input class="bdanniu" type="submit" value="<%=r.getString(teasession._nLanguage,"1186542726218")%>" onclick="form1.action='?'; return submitText(form1.period,'<%=r.getString(teasession._nLanguage,"1186568245875")%>');" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input class="bdanniu" type="button" value="<%=r.getString(teasession._nLanguage,"1186542790281")%>" onclick="clearFrom(form1);"/>

</form>

<%
if(period!=-1)
{
  ArrayList al=null;
  if(pos==0)
  {
    m=(Map)Annuity.conn(m);

    String ec = (String) m.get("error_code");
    if (!Annuity.EC_0000.equals(ec))
    {
      out.print("<script>alert('" +r.getString(teasession._nLanguage,"Annuity.error_code."+ec)+"');</script>");
      return;
    }
     al=(ArrayList)m.get("result");
     session.setAttribute("annuity.result1011",al);
  }else
  {
    al=(ArrayList)session.getAttribute("annuity.result1011");
  }

%>

<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"Annuity.1011")%> ( <%=al.size()%> )</span><span id="biaor"></span></div>
  <table style="border-collapse:collapse" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td><%=r.getString(teasession._nLanguage,"1207535256843")%></td>
     <!-- <td><%=r.getString(teasession._nLanguage,"1207535132312")%></td>-->
      <td><%=r.getString(teasession._nLanguage,"1207535348406")%></td>
      <td><%=r.getString(teasession._nLanguage,"1207535474625")%></td>
      <td><%=r.getString(teasession._nLanguage,"1207535571156")%></td>
      <td><%=r.getString(teasession._nLanguage,"1207535566281")%></td>
      <td><%=r.getString(teasession._nLanguage,"1207535554109")%></td>
    </tr>
<%
if(al.size()==0)
{
  out.println("<tr><td colspan=7>"+r.getString(teasession._nLanguage,"1207535425906")+"</td></tr>");
}else
for(int i=pos;i<(pos+size)&&i<al.size();i++)
{
  Map v=(Map)al.get(i);
  String filename=((String)v.get("filename")).trim();
  String pk_corpaccountreport=(String)v.get("pk_corpaccountreport");
%>
    <tr>
      <td><%=filename%></td>
<!--      <td><%=Annuity.d(v.get("preiod"))%></td>-->
      <td><%=Annuity.d(v.get("report_year"))%></td>
      <td><%=Annuity.d(v.get("report_start_date"))%></td>
      <td><%=Annuity.d(v.get("report_end_date"))%></td>
      <td><%=Annuity.d(v.get("report"))%></td>
      <td><a href="/servlet/ExportAnnuity?community=<%=teasession._strCommunity%>&tn=<%=Annuity.des("1012")%>&pk_corpaccountreport=<%=pk_corpaccountreport%>&info=<%=java.net.URLEncoder.encode(filename, "UTF-8")%>"><%=r.getString(teasession._nLanguage,"1207535554109")%></a></td>
    </tr>
<%
}%>
</table>
<div style="text-align:right;">[<%=r.getString(teasession._nLanguage,"1186536885171")%><%=al.size()%><%=r.getString(teasession._nLanguage,"1186536939078")%>] <%= new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,al.size(),size)%></div>
<%
}%>






<%
}else//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////===1014===///////////////////////
if(trade_no.equals("1014"))
{
%>
<div id="neibiao">
  <span id="biaol"></span>
  <span id="neibiaozi"><%=r.getString(teasession._nLanguage,"Annuity.1014")%></span>
  <span id="biaor"></span></div>
  <table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse">
    <tr>
      <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186471846765")%>：</td>
      <td><%=Annuity.Annuity_1007(session,plan_code)%></td>
    </tr>
    <tr><td class="zuoge">*<%=r.getString(teasession._nLanguage,"1186472518328")%>：</td>
      <td>
        <table border="0" cellspacing="0" cellpadding="0">
          <tr>
              <td style="width:15px;"><%=r.getString(teasession._nLanguage,"1186542510031")%>：</td>
              <td style="width:180px;"><input class="biaodan" type="text" name="startdate" value="<%if(startdate!=null)out.print(startdate);%>" readonly><a href=### onclick="showCalendar('form1.startdate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td>
                <td class="xiaobiao"><%=r.getString(teasession._nLanguage,"1186542560843")%>：</td>
                <td><input class="biaodan" type="text" name="enddate" value="<%if(enddate!=null)out.print(enddate);%>" readonly><a href=### onclick="showCalendar('form1.enddate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td>
            </tr>
          </table>
      </td>
    </tr>
  </table>
<input class="bdanniu" type="submit" value="<%=r.getString(teasession._nLanguage,"1186542726218")%>"  onclick="return f_time();"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
  <span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1207534562953")%> ( <%=al.size()%> )</span>
  <span id="biaor"></span>
</div>
<table style="border-collapse:collapse" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td colspan="7" class="youge">　<%=r.getString(teasession._nLanguage,"1186472111484")%>：<%=startdate%>　　　　　　<%=r.getString(teasession._nLanguage,"1186472169000")%>：<%=enddate%></td>
  </tr>
  <tr class="shuohang">
    <td nowrap><%=r.getString(teasession._nLanguage,"1186466756468")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1186468848421")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1207535032750")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1207534911625")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1207534929375")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1186473735703")%></td>
  </tr>
<%
for(int i=0;i<al.size();i++)
{
  Map v=(Map)al.get(i);
  %>
  <tr>
    <td><%=Annuity.d(v.get("plan_name"))%></td>
    <td><%=Annuity.d(v.get("corp_name"))%></td>
    <td><%=Annuity.d(v.get("income_sum"))%></td>
    <td><%=Annuity.d(v.get("corp_income_sum"))%></td>
    <td><%=Annuity.d(v.get("person_income_sum"))%></td>
    <td><%=Annuity.d(v.get("accour_date"))%></td>
  </tr>
  <%
}%>
</table>

<input id="xia_z" type=image src="/res/fulijihua/u/0802/080239018.gif" name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity';">

<%
}
}%>












<%
}else//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////===4001===///////////////////////
if(trade_no.equals("4001"))
{
%>
<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186481230906")%></span><span id="biaor"></span></div>
<table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse">
<tr><td class="zuoge"><%=r.getString(teasession._nLanguage,"1186481292296")%>：</td><td><table border="0" cellspacing="0" cellpadding="0">
<tr><td style="width:15px;">
<%=r.getString(teasession._nLanguage,"1186542510031")%>：</td><td style="width:180px;"><input class="biaodan" type="text" name="startdate" value="<%if(startdate!=null)out.print(startdate);%>" /><a href=### onclick="showCalendar('form1.startdate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td>
<td class="xiaobiao"><%=r.getString(teasession._nLanguage,"1186542560843")%>：</td><td><input class="biaodan" type="text" name="enddate"  value="<%if(enddate!=null)out.print(enddate);%>" /><a href=### onclick="showCalendar('form1.enddate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td></tr></table></td></tr></table>
<input class="bdanniu" type="submit" value="<%=r.getString(teasession._nLanguage,"1186542726218")%>" onclick="return f_time();" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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

<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186481390062")%> ( <%=al.size()%> )</span><span id="biaor"></span></div>
  <table style="border-collapse:collapse" border="0" cellspacing="0" cellpadding="0">
  <tr>
<td colspan="7" class="youge">　<%=r.getString(teasession._nLanguage,"1186472111484")%>：<%=startdate%>　　　　　　<%=r.getString(teasession._nLanguage,"1186472169000")%>：<%=enddate%></td>
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
	plan_code=(String)v.get("plan_code");
        corp_no=(String)v.get("corp_no");
	String operate_date=(String)v.get("operate_date");
%>
    <tr>
    <%--
      <td><%=corp_no%></td>
      <td><%=v.get("corp_name")%></td>
      --%>
      <td><%=plan_code%></td>
      <td><%=Annuity.d(v.get("plan_name"))%></td>
      <td><%=operate_date%></td>
      <td><%=Annuity.d(v.get("period"))%></td>
      <td><%=Annuity.d(v.get("start_date"))%></td>
      <td><%=Annuity.d(v.get("end_date"))%></td>
      <td><a href="/servlet/ExportAnnuity?tn=<%=Annuity.des("4002")%>&corp_no=<%=corp_no%>&plan_code=<%=plan_code%>&operate_date=<%=operate_date%>&info=<%=java.net.URLEncoder.encode(info+"("+operate_date+").pdf", "UTF-8")%>"><%=r.getString(teasession._nLanguage,"1186534919562")%></a></td>
    </tr>
<%
}%>
</table>
<%
}}%>















<%
}else//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////===4003===///////////////////////
if(trade_no.equals("4003"))
{
%>
<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186535226734")%></span><span id="biaor"></span></div>
<table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse">
<tr><td class="zuoge"><%=r.getString(teasession._nLanguage,"1186535316796")%>：</td><td><table border="0" cellspacing="0" cellpadding="0">
<tr><td style="width:15px;">
<%=r.getString(teasession._nLanguage,"1186542510031")%>：</td><td style="width:180px;"><input class="biaodan" type="text" name="startdate" value="<%if(startdate!=null)out.print(startdate);%>" /><a href=### onclick="showCalendar('form1.startdate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td>
<td class="xiaobiao"><%=r.getString(teasession._nLanguage,"1186542560843")%>：</td><td><input class="biaodan" type="text" name="enddate"  value="<%if(enddate!=null)out.print(enddate);%>" /><a href=### onclick="showCalendar('form1.enddate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td></tr></table></td></tr></table>
<input class="bdanniu" type="submit" value="<%=r.getString(teasession._nLanguage,"1186542726218")%>" onclick="return f_time();"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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

<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186535385703")%> ( <%=al.size()%> )</span><span id="biaor"></span></div>
  <table style="border-collapse:collapse" border="0" cellspacing="0" cellpadding="0">
  <tr>
<td colspan="10" class="youge">　<%=r.getString(teasession._nLanguage,"1186472111484")%>：<%=startdate%>　　　　　　<%=r.getString(teasession._nLanguage,"1186472169000")%>：<%=enddate%></td>
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

<input id="xia_z" type=image src="/res/fulijihua/u/0802/080239018.gif" name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity';">

<%
}}%>












<%
}else//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////===5001===///////////////////////
if(trade_no.equals("5001"))
{
%>
<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186536001578")%></span><span id="biaor"></span></div>
<table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse">
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186474465078")%>：</td>
    <td ><input class="biaodan" type="text" name="person_code" value="<%if(person_code!=null)out.print(person_code);%>"/></td>
  </tr>
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186536117593")%>：</td>
    <td ><input class="biaodan" type="text" name="person_name" value="<%if(person_name!=null)out.print(person_name);%>"/></td>
  </tr>
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186536171906")%>：</td>
    <td ><input class="biaodan" type="text" name="identity_no" value="<%if(identity_no!=null)out.print(identity_no);%>"/></td>
  </tr>
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186536207171")%>：</td>
    <td ><table border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td style="width:15px;"><%=r.getString(teasession._nLanguage,"1186542510031")%>：</td>
          <td style="width:180px;"><input class="biaodan" type="text" name="startdate" value="<%if(startdate!=null)out.print(startdate);%>" /><a href=### onclick="showCalendar('form1.startdate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td>
          <td class="xiaobiao"><%=r.getString(teasession._nLanguage,"1186542560843")%>：</td>
          <td><input class="biaodan" type="text" name="enddate" value="<%if(enddate!=null)out.print(enddate);%>"/><a href=### onclick="showCalendar('form1.enddate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td>
        </tr>
      </table></td>
  </tr>
</table>
<input class="bdanniu" type="submit" value="<%=r.getString(teasession._nLanguage,"1186542726218")%>" onclick="form1.action='?'; return(form1.startdate.value.length==0||submitDate(form1.startdate,'<%=r.getString(teasession._nLanguage,"1186568245875")%>'))&&(form1.enddate.value.length==0||submitDate(form1.enddate,'<%=r.getString(teasession._nLanguage,"1186568245875")%>'));"/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input class="bdanniu" type="button" value="<%=r.getString(teasession._nLanguage,"1186542790281")%>" onclick="clearFrom(form1);"/>



<%
if(pos!=-1)
{
  Map m2=(Map)Annuity.conn(m);
  ArrayList al=(ArrayList)m2.get("result");
  Map v=(Map)al.get(0);
  int total=((Integer)v.get("total")).intValue();

  int endnum=pos+size;
  if(endnum>total)
	  endnum=total;

  m.put("trade_no","5002");
  m.put("startrade_noum",new Integer(pos+1));
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


<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186536273281")%></span><span id="biaor"></span></div>
  <table style="border-collapse:collapse" border="0" cellspacing="0" cellpadding="0">
  <tr>
<td colspan="7" class="youge"><div style="text-align:right;">[<%=r.getString(teasession._nLanguage,"1186536885171")%><%=total%><%=r.getString(teasession._nLanguage,"1186536939078")%>] <%= new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,total,size)%></div></td>
</tr>
    <tr class="shuohang">
      <td nowrap><%=r.getString(teasession._nLanguage,"1186536333546")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186536398843")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186536452375")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186474596125")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186474814046")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186475045437")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186536829921")%></td>
    </tr>

	<%
	for(int i=0;i<al.size();i++)
	{
		v=(Map)al.get(i);
	%>
	     <tr>
	      <td><%=Annuity.d(v.get("person_no"))%></td>
	      <td><%=Annuity.d(v.get("name"))%></td>
	      <td><%=Annuity.d(v.get("gender"))%></td>
	      <td><%=Annuity.d(v.get("identity_no"))%></td>
	      <td><%=Annuity.d(v.get("birthday"))%></td>
	      <td><%=Annuity.d(v.get("contr_base"))%></td>
	      <td><%=Annuity.d(v.get("telephone"))%></td>
	    </tr>
	<%
	}%>

</table>
<div style="text-align:right;">[<%=r.getString(teasession._nLanguage,"1186536885171")%><%=total%><%=r.getString(teasession._nLanguage,"1186536939078")%>] <%= new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,total,size)%></div>

<input id="xia_z" type=image src="/res/fulijihua/u/0802/080239018.gif" name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity';">
<%
}}%>









<%
}else//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////===5003===///////////////////////
if(trade_no.equals("5003"))
{
%>
<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186537119250")%></span><span id="biaor"></span></div>
<table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse">
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186471846765")%>：</td>
    <td><%=Annuity.Annuity_0007(session,corp_no,plan_code)%></td>
  </tr>
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186474465078")%>：</td>
    <td ><input class="biaodan" type="text" name="person_code" value="<%if(person_code!=null)out.print(person_code);%>"/></td>
  </tr>
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186536117593")%>：</td>
    <td ><input class="biaodan" type="text" name="person_name" value="<%if(person_name!=null)out.print(person_name);%>"/></td>
  </tr>
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186536171906")%>：</td>
    <td ><input class="biaodan" type="text" name="identity_no" value="<%if(identity_no!=null)out.print(identity_no);%>"/></td>
  </tr>
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186537325578")%>：</td>
    <td ><table border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td style="width:15px;"><%=r.getString(teasession._nLanguage,"1186542510031")%>：</td>
          <td style="width:180px;"><input class="biaodan" type="text" name="startdate" value="<%if(startdate!=null)out.print(startdate);%>" /><a href=### onClick="showCalendar('form1.startdate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td>
          <td class="xiaobiao"><%=r.getString(teasession._nLanguage,"1186542560843")%>：</td>
          <td><input class="biaodan" type="text" name="enddate" value="<%if(enddate!=null)out.print(enddate);%>"/><a href=### onClick="showCalendar('form1.enddate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td>
        </tr>
      </table></td>
  </tr>
</table>
<input class="bdanniu" type="submit" value="<%=r.getString(teasession._nLanguage,"1186542726218")%>" onclick="form1.action='?'; return (form1.startdate.value.length==0||submitDate(form1.startdate,'<%=r.getString(teasession._nLanguage,"1186568245875")%>'))&&(form1.enddate.value.length==0||submitDate(form1.enddate,'<%=r.getString(teasession._nLanguage,"1186568245875")%>') );"/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input class="bdanniu" type="button" value="<%=r.getString(teasession._nLanguage,"1186542790281")%>" onclick="clearFrom(form1);"/>

<%
if(pos!=-1)
{
  Map m2=(Map)Annuity.conn(m);
  ArrayList al=(ArrayList)m2.get("result");
  Map v=(Map)al.get(0);
  int total=((Integer)v.get("total")).intValue();

  int endnum=pos+size;
  if(endnum>total)
	  endnum=total;

  m.put("trade_no","5004");
  m.put("startrade_noum",new Integer(pos+1));
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

<input id="xia_z" type=image src="/res/fulijihua/u/0802/080239018.gif" name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity';">


<%
}}%>








<%
}else//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////===5005===///////////////////////
if(trade_no.equals("5005"))
{
%>
<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186538089562")%></span><span id="biaor"></span></div>
<table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse">
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186471846765")%>：</td>
    <td><%=Annuity.Annuity_0007(session,corp_no,plan_code)%></td>
  </tr>
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186474465078")%>：</td>
    <td ><input class="biaodan" type="text" name="person_code" value="<%if(person_code!=null)out.print(person_code);%>"/></td>
  </tr>
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186536117593")%>：</td>
    <td ><input class="biaodan" type="text" name="person_name" value="<%if(person_name!=null)out.print(person_name);%>"/></td>
  </tr>
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186536171906")%>：</td>
    <td ><input class="biaodan" type="text" name="identity_no" value="<%if(identity_no!=null)out.print(identity_no);%>"/></td>
  </tr>
  <tr>
    <td class="zuoge">* <%=r.getString(teasession._nLanguage,"1186538266375")%>：</td>
    <td ><table border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td style="width:15px;"><%=r.getString(teasession._nLanguage,"1186542510031")%>：</td>
          <td style="width:180px;"><input class="biaodan" type="text" name="startdate" value="<%if(startdate!=null)out.print(startdate);%>" /><a href=### onclick="showCalendar('form1.startdate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td>
          <td class="xiaobiao"><%=r.getString(teasession._nLanguage,"1186542560843")%>：</td>
          <td><input class="biaodan" type="text" name="enddate" value="<%if(enddate!=null)out.print(enddate);%>"/><a href=### onclick="showCalendar('form1.enddate');"><img src="/res/eacebbank/u/0704/070425969.jpg"/></a></td>
        </tr>
      </table></td>
  </tr>
</table>
<input class="bdanniu" type="submit" value="<%=r.getString(teasession._nLanguage,"1186542726218")%>" onclick="return f_time();"/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input class="bdanniu" type="button" value="<%=r.getString(teasession._nLanguage,"1186542790281")%>" onclick="clearFrom(form1);"/>

<%
if(pos!=-1)
{
  Map m2=(Map)Annuity.conn(m);
  ArrayList al=(ArrayList)m2.get("result");
  Map v=(Map)al.get(0);
  int total=((Integer)v.get("total")).intValue();
	System.out.println(total+":"+m);
  int endnum=pos+size;
  if(endnum>total)
	  endnum=total;

  System.out.println("start:"+(pos+1)+"\tend:"+endnum);
  m.put("trade_no","5006");
  m.put("startrade_noum",new Integer(pos+1));
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


<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186538409734")%></span><span id="biaor"></span></div>
  <table style="border-collapse:collapse" border="0" cellspacing="0" cellpadding="0">
  <tr>
<td colspan="9" class="youge"><div style="text-align:right;">[<%=r.getString(teasession._nLanguage,"1186536885171")%><%=total%><%=r.getString(teasession._nLanguage,"1186536939078")%>] <%= new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,total,size)%></div></td>
</tr>
    <tr class="shuohang">
      <td nowrap><%=r.getString(teasession._nLanguage,"1186537444406")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186536398843")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186474596125")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186466576328")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186466756468")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186477035000")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186472405609")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186472457781")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage,"1186535903171")%></td>
    </tr>

	<%
	for(int i=0;i<al.size();i++)
	{
		v=(Map)al.get(i);
	%>
	     <tr>
	      <td><%=Annuity.d(v.get("person_no"))%></td>
	      <td><%=Annuity.d(v.get("name"))%></td>
	      <td><%=Annuity.d(v.get("identity_no"))%></td>
	      <td><%=Annuity.d(v.get("plan_code"))%></td>
	      <td><%=Annuity.d(v.get("plan_name"))%></td>
	      <td><%=Annuity.d(v.get("contr_sum"))%></td>
	      <td><%=Annuity.d(v.get("corpcontr_sum"))%></td>
	      <td><%=Annuity.d(v.get("personcontr_sum"))%></td>
	      <td><%=Annuity.d(v.get("contr_date"))%></td>
	    </tr>
	<%
	}%>

</table>
<div style="text-align:right;">[<%=r.getString(teasession._nLanguage,"1186536885171")%><%=total%><%=r.getString(teasession._nLanguage,"1186536939078")%>] <%= new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,total,size)%></div>

<input id="xia_z" type=image src="/res/fulijihua/u/0802/080239018.gif" name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity';">

<%
}}%>








<%
}else//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////===8003===///////////////////////
if(trade_no.equals("8003"))
{
%>
<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186538853953")%></span><span id="biaor"></span></div>
<table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse">
<%--
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"客户号")%>：</td>
    <td><input class="biaodan" type="text" name="code"/></td>
  </tr>
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"用户")%>：</td>
    <td><input class="biaodan" type="text" name="user"/></td>
  </tr>
  --%>
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186538899578")%>：</td>
    <td><input class="biaodan" type="password" name="psword1"/></td>
  </tr>
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186538940093")%>：</td>
    <td><input class="biaodan" type="password" name="psword2"/></td>
  </tr>
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186539013625")%>：</td>
    <td><input class="biaodan" type="password" name="psword3"/></td>
  </tr>
</table>
<input class="bdanniu" type="submit" value="<%=r.getString(teasession._nLanguage,"1186542726218")%>" onclick="return f_pwd();"/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input class="bdanniu" type="button" value="<%=r.getString(teasession._nLanguage,"1186542790281")%>" onclick="clearFrom(form1);"/>







<%
}else//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////===8004===///////////////////////
if(trade_no.equals("8004"))
{
%>
<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186539091609")%></span><span id="biaor"></span></div>
<table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse">
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186538899578")%>：</td>
    <td ><input class="biaodan" type="password" name="psword1"/></td>
  </tr>
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186538940093")%>：</td>
    <td ><input class="biaodan" type="password" name="psword2"/></td>
  </tr>
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186539013625")%>：</td>
    <td ><input class="biaodan" type="password" name="psword3"/></td>
  </tr>
</table>
<input class="bdanniu" type="submit" value="<%=r.getString(teasession._nLanguage,"1186542726218")%>" onclick="return f_pwd();"/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input class="bdanniu" type="button" value="<%=r.getString(teasession._nLanguage,"1186542790281")%>" onclick="clearFrom(form1);"/>











<%
}

%>


</form>
</div>
<jsp:include page="/jsp/admin/cebbank/AnnuityFrame.jsp" >
<jsp:param name="frame" value="mainfooter"/>
</jsp:include>
</div>


<%
}
}
%>
