<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.entity.node.*"%>
<%@ page import="tea.html.*"%>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.resource.*"%>
<%@ page import="tea.ui.TeaServlet"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@page import="javax.mail.*" %>
<%@ page import="java.net.Socket"%>
<%@page import="javax.mail.internet.*" %>
<%@ page import=" tea.db.DbAdapter"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.entity.util.*"%>
<%@ page import="tea.entity.site.*"%>
<%@ page import="tea.ui.member.order.*"%>
<%@ page import="tea.http.RequestHelper"%>

<%@ page import="java.io.PrintWriter"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="tea.entity.RV"%>
<%!
String getCheck(boolean bool)
{
	return bool?" CHECKED ":" ";
}
String getCheck(int value)
{
	return value!=0?" CHECKED ":" ";
}
String getSelect(boolean i)
{
	return i?" SELECTED ":" ";
}

String getNull(Object strNull)
{	return strNull==null?"":String.valueOf(strNull);
}
String getNull(int intValue)
{	return intValue==0?"":String.valueOf(intValue);
}
String getNull(float floatValue)
{	return floatValue==0f?"":String.valueOf(floatValue);
}
String getDisplay(boolean bool)
{
    return bool?" style=\"display:\" ":" style=\"display:none\" ";
}
TeaServlet ts=new TeaServlet();
Resource r = new Resource();
Node node;
TeaSession teasession;
%>
<%
//response.setHeader("Expires", "0");
//response.setHeader("Cache-Control", "no-cache");
//response.setHeader("Pragma", "no-cache");
teasession = new TeaSession(request);
//if(teasession._rv == null)
//{
//response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
//return;
//}

node=Node.find(teasession._nNode);
%>

<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
tea.resource.Resource r = new tea.resource.Resource();
String member=request.getParameter("member");
String address,webpage,fax,email,telephone,zip, name,linkman,synopsis,property;
boolean sex=false;
int size=0,calling=0;
if(member!=null)
{
  tea.entity.member.ProfileEnterprise pe = tea.entity.member.ProfileEnterprise.find(member,node.getCommunity());
  name=pe.getName();
  linkman=pe.getLinkman();
  synopsis=pe.getSynopsis();
  sex=pe.isLinkmansex();
  property=pe.getProperty();
  size=pe.getSize();
  if(pe.getCalling()!=null&&pe.getCalling().length()>0)
  calling=Integer.parseInt(pe.getCalling());
  tea.entity.member.Profile profile=tea.entity.member.Profile.find(member);
  address=profile.getAddress(teasession._nLanguage);
  webpage=profile.getWebPage(teasession._nLanguage);
  fax=profile.getFax(teasession._nLanguage);
  email=profile.getEmail();
  telephone=profile.getTelephone(teasession._nLanguage);
  zip=profile.getZip(teasession._nLanguage);
}else
{
  address=webpage=fax=email=telephone=zip=name=linkman=synopsis=property="";
}
%>
<html>
<head>
<TITLE>??????????????????</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<LINK REL="stylesheet" href="/tea/CssJs/default.css" TYPE="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT language="javascript" SRC="/jsp/type/job/validate.js"></SCRIPT>
<SCRIPT language="javascript" SRC="/tea/CssJs/CheckUserName.js"></SCRIPT>
<SCRIPT LANGUAGE="javascript" SRC="/tea/CssJs/Select.js"></SCRIPT>
<%--<SCRIPT LANGUAGE="javascript">
<!--????????????0001-->
<!--Action:2-->
<!--
Location_CodeId = new Array;
Location_ParentId = new Array;
Location_CodeValue = new Array;
Location_IsVisible = new Array;
Location_Lvl = new Array;
I=-1;



I++;
Location_CodeId[I] = '30000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '5';
Location_ParentId[I] = '30000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '31000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '115';
Location_ParentId[I] = '31000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '32000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '140';
Location_ParentId[I] = '32000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '33000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '25';
Location_ParentId[I] = '33000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '16000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '40';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '16010';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '225';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '16050';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '16020';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '16030';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '117';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '125';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '16040';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '16060';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '16080';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '16070';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '180';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '7000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '100';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '7010';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '18';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '7020';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '7070';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '7060';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '220';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '7040';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '152';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '7030';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '167';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '7080';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '8000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '55';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '107';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '147';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '8050';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '8060';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '8080';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '8090';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '73';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '8110';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '8100';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '8070';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '9000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '65';
Location_ParentId[I] = '9000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '9040';
Location_ParentId[I] = '9000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '9030';
Location_ParentId[I] = '9000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '9020';
Location_ParentId[I] = '9000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '10000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '35';
Location_ParentId[I] = '10000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '10030';
Location_ParentId[I] = '10000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '155';
Location_ParentId[I] = '10000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '10040';
Location_ParentId[I] = '10000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '24000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '85';
Location_ParentId[I] = '24000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '24020';
Location_ParentId[I] = '24000';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '24030';
Location_ParentId[I] = '24000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '17000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '???????????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '105';
Location_ParentId[I] = '17000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '17040';
Location_ParentId[I] = '17000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '42';
Location_ParentId[I] = '17000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '17020';
Location_ParentId[I] = '17000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '17050';
Location_ParentId[I] = '17000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '20000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '45';
Location_ParentId[I] = '20000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '20020';
Location_ParentId[I] = '20000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '18000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '50';
Location_ParentId[I] = '18000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '18020';
Location_ParentId[I] = '18000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '1000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '130';
Location_ParentId[I] = '1000';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '7';
Location_ParentId[I] = '1000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '1070';
Location_ParentId[I] = '1000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '53';
Location_ParentId[I] = '1000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '1080';
Location_ParentId[I] = '1000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '1030';
Location_ParentId[I] = '1000';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '1020';
Location_ParentId[I] = '1000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '1060';
Location_ParentId[I] = '1000';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '13000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '175';
Location_ParentId[I] = '13000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '78';
Location_ParentId[I] = '13000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '92';
Location_ParentId[I] = '13000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '6000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '????????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '60';
Location_ParentId[I] = '6000';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '6030';
Location_ParentId[I] = '6000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '6040';
Location_ParentId[I] = '6000';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '6050';
Location_ParentId[I] = '6000';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '6020';
Location_ParentId[I] = '6000';
Location_CodeValue[I] = '????????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '14000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '150';
Location_ParentId[I] = '14000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '14020';
Location_ParentId[I] = '14000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '14040';
Location_ParentId[I] = '14000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '14030';
Location_ParentId[I] = '14000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '14050';
Location_ParentId[I] = '14000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '14060';
Location_ParentId[I] = '14000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '14070';
Location_ParentId[I] = '14000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '14080';
Location_ParentId[I] = '14000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '15000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '15';
Location_ParentId[I] = '15000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '15030';
Location_ParentId[I] = '15000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '15020';
Location_ParentId[I] = '15000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '15040';
Location_ParentId[I] = '15000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '15050';
Location_ParentId[I] = '15000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '15060';
Location_ParentId[I] = '15000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '15070';
Location_ParentId[I] = '15000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '15080';
Location_ParentId[I] = '15000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '5000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '10';
Location_ParentId[I] = '5000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '5020';
Location_ParentId[I] = '5000';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '11000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '95';
Location_ParentId[I] = '11000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '11020';
Location_ParentId[I] = '11000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '4000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '120';
Location_ParentId[I] = '4000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '4030';
Location_ParentId[I] = '4000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '30';
Location_ParentId[I] = '4000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '4040';
Location_ParentId[I] = '4000';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '3000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '??????????????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '70';
Location_ParentId[I] = '3000';
Location_CodeValue[I] = '????????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '3020';
Location_ParentId[I] = '3000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '3030';
Location_ParentId[I] = '3000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '26000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '???????????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '170';
Location_ParentId[I] = '26000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '25000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '165';
Location_ParentId[I] = '25000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '12000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '75';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '12090';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '12040';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '12060';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '12100';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '110';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '12080';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '12070';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '146';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '12050';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '168';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '12030';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '2000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '135';
Location_ParentId[I] = '2000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '2010';
Location_ParentId[I] = '2000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '2020';
Location_ParentId[I] = '2000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '2030';
Location_ParentId[I] = '2000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '23000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '160';
Location_ParentId[I] = '23000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '23010';
Location_ParentId[I] = '23000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '23020';
Location_ParentId[I] = '23000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '19000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '20';
Location_ParentId[I] = '19000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '19060';
Location_ParentId[I] = '19000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '19030';
Location_ParentId[I] = '19000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '19040';
Location_ParentId[I] = '19000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '19050';
Location_ParentId[I] = '19000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '19070';
Location_ParentId[I] = '19000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '19020';
Location_ParentId[I] = '19000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '22000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '???????????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '90';
Location_ParentId[I] = '22000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '22020';
Location_ParentId[I] = '22000';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '27000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '???????????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '145';
Location_ParentId[I] = '27000';
Location_CodeValue[I] = '????????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '27030';
Location_ParentId[I] = '27000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '27020';
Location_ParentId[I] = '27000';
Location_CodeValue[I] = '????????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '27040';
Location_ParentId[I] = '27000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '21000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '80';
Location_ParentId[I] = '21000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '21030';
Location_ParentId[I] = '21000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '21040';
Location_ParentId[I] = '21000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '21020';
Location_ParentId[I] = '21000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '34000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '185';
Location_ParentId[I] = '34000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '35000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '190';
Location_ParentId[I] = '35000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '36000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '195';
Location_ParentId[I] = '36000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '37000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '???????????????????????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '200';
Location_ParentId[I] = '37000';
Location_CodeValue[I] = '???????????????????????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '38000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '205';
Location_ParentId[I] = '38000';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '41000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '230';
Location_ParentId[I] = '41000';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '39000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '210';
Location_ParentId[I] = '39000';
Location_CodeValue[I] = '?????????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '40000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '215';
Location_ParentId[I] = '40000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '42000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '235';
Location_ParentId[I] = '42000';
Location_CodeValue[I] = '??????';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';
//-->
</SCRIPT>
--%>
<SCRIPT language = "javascript">
<!--
function SelectProvice()
{
  SelectLoc();

  var locbox = form1.sltAllLocId;
  if(locbox.length==0) fullup_P(locbox, '--?????????--', -1);
}

function cancel()
{
  form1.reset();

  return false;
}
function ChkSel(selectobj,value,text)
{
  if(selectobj.options[selectobj.selectedIndex].value==value)
{  alert(text)
selectobj.focus();
return false;
}return true;
}
function chkForm()
{
	var frm = document.form1;

	if(!submitText(frm.txtMem_Name, "????????????")) return false;

//	if(!submitText(frm.txtAbbrName, "????????????")) return false;

	if(ChkSel(frm.lstComType, -1, "????????????")==false) return false;
	if(ChkSel(frm.lstSize, -1, "????????????")==false) return false;
        if(ChkSel(frm.lstIndustry, '0', "????????????")==false) return false;
/*	if(frm.sltAllLocId.value == -1)
	{
	  alert('??????????????????????????????');
	  frm.sltProvinceId.focus();
	  return false;
	}*/

	var intCount=0;
	var frm=document.form1;
	for(var x=0;x<frm.lstIndustry.options.length;x++)
	{
	  if(frm.lstIndustry.options(x).selected)
	    intCount++;
	}
	if(intCount==0)
	{
	  alert("??????????????????????????????");
	  frm.lstIndustry.focus();
	  return false;
	}
	else if(intCount>3)
	{
	  alert("????????????????????????????????????");
	  frm.lstIndustry.focus();
	  return false;
	}

	if(!submitText(frm.txtLinkManName, "???????????????")) return false;

	//if(!submitText(frm.txtLinkManTitle, "???????????????")) return false;
	if(!submitText(frm.txtEmail, "E-mail")) return false;
	if(!submitEmail(frm.txtEmail,"??????????????????E-mail?????????"))
	{
//		alert("??????????????????E-mail?????????");
//		frm.txtEmail.focus();
		return false;
	}

	if(!submitText(frm.txtPhone, "??????")) return false;

  s = frm.txtComIntr.value;/*
  if(s.length < 100)
  {
//    for(var i=0;i<frm.txtComIntr.value.length;i++)
//      s = s.replace(/\s/i,'');
  }
  if(Trim(s).length == 0)
  {
    alert('???????????????????????????');
    frm.txtComIntr.focus();
    return false;
  }
	else */if(!submitText(frm.txtComIntr, "????????????")) return false;
	else if(!ChkLength(frm.txtComIntr, "????????????",3000)) return false;

	if(!submitText(frm.txtUserName, "?????????")) return false;
//	if(!CheckUserName(form1.txtUserName)) return false;

	if(!submitText(frm.txtPassword, "??????")) return false;
	if(!Chkpwd(frm.txtPassword, "??????", 12, 6)) return false;

	if(!submitText(frm.txtConPassword, "????????????")) return false;
	if(!Chkpwd(frm.txtConPassword,"????????????",12, 6)) return false;

	if(frm.txtPassword.value != frm.txtConPassword.value)
	{
		alert("?????????????????????????????????");
		frm.txtPassword.focus();
		return false;
	}

	return true;
}
function ChkLength(obj,text,maxlen)
{
  if(obj.value.lengTD>maxlen)
  {
    alert(text);
    obj.focus;
    return false
    ;
  }return true;
}
function Chkpwd(objpass,text,maxlen,minlen)
{
if(  objpass.value.lengTD>maxlen||objpass.value.length<minlen)
{
  alert(text);
  objpass.focus();
  return false;
}
return true;
}
//????????????"--"
function CheckLoc(objloc)
{
    for(var x=0;x<objloc.length;x++)
    {
	  var opt = objloc.options[x];
	  if (opt.value.substring(opt.value.length-3,opt.value.length)!='000'&& opt.value!='5'&& opt.value!='115'&& opt.value!='140'&& opt.value!='25'&& opt.value!='185'&& opt.value!='190'&& opt.value!='195'&& opt.value!='200'&& opt.value!='205'&& opt.value!='210'&& opt.value!='215'&& opt.value!='230'&& opt.value!='235'&& opt.value!='255') //??????id
			{
			   opt.text='-- '+opt.text;
			}
    }
}
function getLength(value)
{
  alert(value.length);

}
//-->
</SCRIPT>
<html>
<head>
<title>??????????????????</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<BODY>
<h1><%=r.getString(teasession._nLanguage, "????????????")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <FORM NAME = "form1" METHOD = "post"  enctype=multipart/form-data onSubmit = "return chkForm()&&submitIdentifier(this.txtUserName,'<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>')" action="/servlet/ProfileEnterpriseServlet">
 <input type="hidden" name="community" value="<%=node.getCommunity()%>"/>
    <INPUT TYPE="hidden" VALUE="resiger" NAME="hdnResiger">
          <TR>
            <TD colspan="4" ALIGN="right"><div align="left">??????????????????  </div></TD>
          </TR>
		 <TR >
            <TD colspan="4" ALIGN="right">
		  * ????????????</TD>
          </TR>
          <TR>
            <TD WIDTH="100" ALIGN="right"><SPAN CLASS="alert">*</SPAN> ????????????&nbsp;</TD>
            <TD COLSPAN="3"> <INPUT TYPE="text"  class="edit_input"  NAME="txtMem_Name" MAXLENGTH="60" VALUE="<%=name%>" SIZE="44">
            </TD>
          </TR>
         <TR>  <!--
            <TD ALIGN="right"><SPAN CLASS="alert">*</SPAN> ????????????&nbsp;</TD>
            <TD> <INPUT TYPE="text" NAME="txtAbbrName" MAXLENGTH="20" VALUE="" SIZE="20">
              <SPAN CLASS="note">????????????????????????</SPAN> </TD>-->
            <TD WIDTH="100" ALIGN="right" NOWRAP> ????????????&nbsp;</TD>
            <TD> <INPUT TYPE="file" NAME="txtLicenceNo" MAXLENGTH="30" VALUE=""  class="edit_button" >
            </TD>
          </TR>
          <TR>
            <TD ALIGN="right"><SPAN CLASS="alert">*</SPAN> ????????????&nbsp;</TD>
            <TD> <SELECT NAME="lstComType" STYLE="width:135px">
                <OPTION VALUE="-1">--?????????--</OPTION>
                <!--????????????0001-->
<!--Action:2-->
<OPTION VALUE="??????????????????????????????" <%if(property.equals("??????????????????????????????"))out.print(" SELECTED ");%>>??????????????????????????????</OPTION>
<OPTION VALUE="????????????(???????????????)" <%if(property.equals("????????????(???????????????)"))out.print(" SELECTED ");%>>????????????(???????????????)</OPTION>
<OPTION VALUE="?????????????????????" <%if(property.equals("?????????????????????"))out.print(" SELECTED ");%>>?????????????????????</OPTION>
<OPTION VALUE="????????????" <%if(property.equals("????????????"))out.print(" SELECTED ");%>>????????????</OPTION>
<OPTION VALUE="??????????????????" <%if(property.equals("??????????????????"))out.print(" SELECTED ");%>>??????????????????</OPTION>
<OPTION VALUE="??????????????????????????????" <%if(property.equals("??????????????????????????????"))out.print(" SELECTED ");%>>??????????????????????????????</OPTION>
<OPTION VALUE="????????????" <%if(property.equals("????????????"))out.print(" SELECTED ");%>>????????????</OPTION>

              </SELECT> </TD>
            <TD ALIGN="right"><SPAN CLASS="alert">*</SPAN> ????????????&nbsp;</TD>
            <TD> <select name="lstSize" style="width:135px"  class="edit_input" >
              <option value="-1">--?????????--</option>
              <!--????????????0001-->
              <!--Action:2-->
              <option value="1"  <%if(size==1)out.print(" SELECTED ");%>>1 - 49???</option>
              <option value="50"<%if(size==50)out.print(" SELECTED ");%>>50 - 99???</option>
              <option value="100"<%if(size==100)out.print(" SELECTED ");%>>100 - 499???</option>
              <option value="500"<%if(size==500)out.print(" SELECTED ");%>>500 - 999???</option>
              <option value="1000"<%if(size==1000)out.print(" SELECTED ");%>>1000?????????</option>
            </select> </TD>
          </TR>
          <%--          <TR>
  <TD ALIGN="right" NOWRAP><SPAN CLASS="alert">*</SPAN> ??????????????????&nbsp;</TD>
            <TD COLSPAN="3"> <SELECT NAME="sltProvinceId"  STYLE="width:135px" ONCHANGE="javascript:SelectOption('Location',true, form1.sltProvinceId,form1.sltAllLocId,'', '255', '--????????????--');CheckLoc(form1.sltAllLocId);">
                <OPTION VALUE="-1">--?????????--</OPTION>
                <!--????????????0001-->
<!--Action:1-->
<OPTION VALUE="30000">??????</OPTION>
<OPTION VALUE="31000">??????</OPTION>
<OPTION VALUE="32000">??????</OPTION>
<OPTION VALUE="33000">??????</OPTION>
<OPTION VALUE="16000">?????????</OPTION>
<OPTION VALUE="7000">?????????</OPTION>
<OPTION VALUE="8000">?????????</OPTION>
<OPTION VALUE="9000">?????????</OPTION>
<OPTION VALUE="10000">?????????</OPTION>
<OPTION VALUE="24000">?????????</OPTION>
<OPTION VALUE="17000">???????????????</OPTION>
<OPTION VALUE="20000">?????????</OPTION>
<OPTION VALUE="18000">?????????</OPTION>
<OPTION VALUE="1000">?????????</OPTION>
<OPTION VALUE="13000">?????????</OPTION>
<OPTION VALUE="6000">????????????</OPTION>
<OPTION VALUE="14000">?????????</OPTION>
<OPTION VALUE="15000">?????????</OPTION>
<OPTION VALUE="5000">?????????</OPTION>
<OPTION VALUE="11000">?????????</OPTION>
<OPTION VALUE="4000">?????????</OPTION>
<OPTION VALUE="3000">??????????????????</OPTION>
<OPTION VALUE="26000">???????????????</OPTION>
<OPTION VALUE="25000">?????????</OPTION>
<OPTION VALUE="12000">?????????</OPTION>
<OPTION VALUE="2000">?????????</OPTION>
<OPTION VALUE="23000">?????????</OPTION>
<OPTION VALUE="19000">?????????</OPTION>
<OPTION VALUE="22000">???????????????</OPTION>
<OPTION VALUE="27000">???????????????</OPTION>
<OPTION VALUE="21000">?????????</OPTION>
<OPTION VALUE="34000">??????</OPTION>
<OPTION VALUE="35000">??????</OPTION>
<OPTION VALUE="36000">??????</OPTION>
<OPTION VALUE="37000">???????????????????????????</OPTION>
<OPTION VALUE="38000">?????????</OPTION>
<OPTION VALUE="41000">?????????</OPTION>
<OPTION VALUE="39000">?????????</OPTION>
<OPTION VALUE="40000">??????</OPTION>
<OPTION VALUE="42000">??????</OPTION>

              </SELECT>

              <SELECT NAME="sltAllLocId"  STYLE="width:135px">

                <OPTION VALUE = "-1">--?????????--</OPTION>

              </SELECT> </TD>
          </TR>--%>
          <TR>
            <TD ALIGN="right">??????&nbsp;</TD>
            <TD><input  class="edit_input"  type="text" name="txtAddress" maxlength="100" value="<%=address%>" size="44"></TD>
            <TD ALIGN="RIGHT">????????????&nbsp;</TD>
            <TD> <INPUT  class="edit_input" TYPE="text" NAME="txtZipCode" MAXLENGTH="10" VALUE="<%=zip%>">
            </TD>
          </TR>
          <TR>
            <TD ALIGN="right">????????????&nbsp;</TD>
            <TD> <INPUT  class="edit_input"  NAME="txtMem_Url" TYPE="text" MAXLENGTH="100"  VALUE="<%=webpage%>" SIZE="44"> </TD>
            <TD ALIGN="right">&nbsp;</TD>
            <TD>&nbsp; </TD>
          </TR>
          <TR>
            <TD ALIGN="right">??????&nbsp;</TD>
            <TD COLSPAN="3"><input  class="edit_input"  name="txtFax" type="text"  value="<%=fax%>" size="20" maxlength="40">              <SPAN CLASS="note">???????????????-????????????</SPAN></TD>
          </TR>
          <TR>
            <TD ALIGN="right" VALIGN="top"><SPAN CLASS="alert">*</SPAN> ????????????&nbsp;</TD>
            <TD COLSPAN="3"> <%=new tea.htmlx.TradeSelection("lstIndustry",calling)%>
			<%--<SELECT NAME="lstIndustry" SIZE="5"  MULTIPLE  STYLE="width:275px">
                <!--????????????0003-->
<!--Action:2-->
<OPTION VALUE="100">?????????</OPTION>
<OPTION VALUE="3600">???????????????????????</OPTION>
<OPTION VALUE="300">???????????????????????</OPTION>
<OPTION VALUE="400">?????????????????</OPTION>
<OPTION VALUE="1300">???????????????(?????????????????????????????????)</OPTION>
<OPTION VALUE="3800">????????????(?????????????????????????????????????)</OPTION>
<OPTION VALUE="1400">?????????</OPTION>
<OPTION VALUE="1101000">?????????????????</OPTION>
<OPTION VALUE="1102000">???????????????????????????????????????????????????</OPTION>
<OPTION VALUE="1103000">????????????????????????????????????????</OPTION>
<OPTION VALUE="1104000">???????????????</OPTION>
<OPTION VALUE="1500">????????????????????????????</OPTION>
<OPTION VALUE="600">??????????????(?????????????????????????????????)</OPTION>
<OPTION VALUE="700">?????????????????</OPTION>
<OPTION VALUE="1700">??????????????????????</OPTION>
<OPTION VALUE="1600">????????????????????????????</OPTION>
<OPTION VALUE="3700">??????????????????????????</OPTION>
<OPTION VALUE="1100">?????????????????</OPTION>
<OPTION VALUE="800">??????????????????????</OPTION>
<OPTION VALUE="900">????????????????????????????????????</OPTION>
<OPTION VALUE="2800">????????????(??????????????????????????????????????????)</OPTION>
<OPTION VALUE="1000">?????????(??????????????????????????????????????)</OPTION>
<OPTION VALUE="1200">??????????????????????</OPTION>
<OPTION VALUE="2500">??????????????????????????????????</OPTION>
<OPTION VALUE="4000">????????????????????</OPTION>
<OPTION VALUE="2000">????????????</OPTION>
<OPTION VALUE="2300">????????????????????</OPTION>
<OPTION VALUE="3200">????????????????????????????</OPTION>
<OPTION VALUE="1800">????????????????????</OPTION>
<OPTION VALUE="2100">?????????????????(???????????????????????????????)</OPTION>
<OPTION VALUE="2200">?????????????????????????????????????????</OPTION>
<OPTION VALUE="500">??????????????????????</OPTION>
<OPTION VALUE="3900">???????????????????????????????</OPTION>
<OPTION VALUE="1900">?????????????????????????????????????</OPTION>
<OPTION VALUE="2600">??????????????????????</OPTION>
<OPTION VALUE="2700">??????????????????????</OPTION>
<OPTION VALUE="2400">????????????????????</OPTION>
<OPTION VALUE="1105000">??????/?????????????????????</OPTION>
<OPTION VALUE="1106000">?????????</OPTION>
<OPTION VALUE="2900">??????????????????</OPTION>
<OPTION VALUE="3100">??????????????????????????????????</OPTION>
<OPTION VALUE="3300">????????????????????</OPTION>
<OPTION VALUE="3400">???????????????????????????????????????</OPTION>
<OPTION VALUE="3500">????????????</OPTION>
<OPTION VALUE="4100">??????</OPTION>

              </SELECT> --%><SPAN CLASS="note">??????Ctrl???????????????????????????????????? </SPAN></TD>
          </TR>
          <TR>
            <TD ALIGN="right" COLSPAN="4"> <HR SIZE="1"> </TD>
          </TR>
          <TR>
            <TD ALIGN="right"><SPAN CLASS="alert">* </SPAN>???????????????&nbsp;</TD>
            <TD COLSPAN="3"><input  class="edit_input"  type="text" name="txtLinkManName" maxlength="60" value="<%=linkman%>">
              <INPUT  id="radio" type="radio" NAME="rdoGender" VALUE="1" CHECKED>
              ??????
              <INPUT  id="radio" type="radio" NAME="rdoGender" VALUE="0" <%if(!sex)out.println(" CHECKED ");%>>
            ??????</TD>
          </TR><%-- %>
          <TR VALIGN="TOP">
            <TD ALIGN="right"><SPAN CLASS="alert">*</SPAN> ???????????????&nbsp;</TD>
            <TD COLSPAN="3"> <INPUT TYPE="text" NAME="txtLinkManTitle" MAXLENGTH="60" VALUE="">
            </TD>
          </TR>--%>
          <TR>
            <TD ALIGN="right"><SPAN CLASS="alert">* </SPAN>E-mail&nbsp;</TD>
            <TD COLSPAN="3"><input  class="edit_input"  type="text" name="txtEmail" maxlength="120" value="<%=email%>">              <SPAN CLASS="alert">?????????</SPAN><SPAN CLASS="note">E-mail??????????????????????????????????????????????????????????????????</SPAN></TD>
          </TR>
          <TR>
            <TD ALIGN="right"><SPAN CLASS="alert">*</SPAN> ??????&nbsp;</TD>
            <TD COLSPAN="3"> <INPUT  class="edit_input"  TYPE="text" NAME="txtPhone" MAXLENGTH="40" VALUE="<%=telephone%>">
              <SPAN CLASS="note">???????????????-??????-??????</SPAN></TD>
          </TR>
          <TR>
            <TD ALIGN="right" VALIGN="top"><SPAN CLASS="alert">*</SPAN> ????????????&nbsp;</TD>
            <TD COLSPAN="3"> <TEXTAREA NAME="txtComIntr" class="edit_input"  COLS="70" ROWS="5"><%=synopsis%></TEXTAREA>
              <br/> <SPAN CLASS="note">??????????????????3000?????????</SPAN><A HREF="javascript:getLength(form1.txtComIntr.value);">????????????</A></TD>
          </TR>
          <TR>
            <TD COLSPAN="4"> <HR SIZE="1"> </TD>
          </TR>
          <TR>
            <TD ALIGN="right"><SPAN CLASS="alert">*</SPAN> ?????????&nbsp;</TD>
            <TD COLSPAN="3"><input class="edit_input"  type="text" name="txtUserName" maxlength="20" value="<%if(member!=null)out.println(member);%>">              <SPAN CLASS="note"> 20????????????????????????????????????????????????</SPAN></TD>
          </TR>
          <TR>
            <TD ALIGN="right"><SPAN CLASS="alert">*</SPAN> ??????&nbsp;</TD>
            <TD COLSPAN="3"><input  class="edit_input"  type="password" name="txtPassword" maxlength="12">              <SPAN CLASS="note"> 6???12???</SPAN> </TD>
          </TR>
          <TR>
            <TD ALIGN="right"><SPAN CLASS="alert">*</SPAN> ????????????&nbsp;</TD>
            <TD COLSPAN="3"> <INPUT class="edit_input" TYPE="password" NAME="txtConPassword" MAXLENGTH="12">
            </TD>
          </TR>

          <TR>
            <TD COLSPAN="4" ALIGN="center" HEIGHT="50"> <INPUT NAME="hiddenSubmit" VALUE="1" TYPE="hidden">
                            <input name="??????" type="submit" id="??????" value="??????"  class="edit_button" >

              &nbsp; <input name="??????" type="submit" id="??????" value="??????" onClick="return cancel();"  class="edit_button" >
            </TD>
          </TR></FORM>
        </TABLE>


 <%if(member!=null)out.println(new tea.html.Script("for(var counter=0;counter<form1.elements.length;counter++)form1.elements[counter].disabled=true;"));%>
</BODY>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</head>
</html>

