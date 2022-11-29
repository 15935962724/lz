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
<TITLE>填写注册信息</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<LINK REL="stylesheet" href="/tea/CssJs/default.css" TYPE="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT language="javascript" SRC="/jsp/type/job/validate.js"></SCRIPT>
<SCRIPT language="javascript" SRC="/tea/CssJs/CheckUserName.js"></SCRIPT>
<SCRIPT LANGUAGE="javascript" SRC="/tea/CssJs/Select.js"></SCRIPT>
<%--<SCRIPT LANGUAGE="javascript">
<!--版本号：0001-->
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
Location_CodeValue[I] = '北京';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '5';
Location_ParentId[I] = '30000';
Location_CodeValue[I] = '北京';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '31000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '上海';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '115';
Location_ParentId[I] = '31000';
Location_CodeValue[I] = '上海';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '32000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '天津';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '140';
Location_ParentId[I] = '32000';
Location_CodeValue[I] = '天津';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '33000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '重庆';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '25';
Location_ParentId[I] = '33000';
Location_CodeValue[I] = '重庆';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '16000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '广东省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '40';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '广州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '16010';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '潮州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '225';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '东莞';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '16050';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '佛山';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '16020';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '惠州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '16030';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '清远';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '117';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '汕头';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '125';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '深圳';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '16040';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '顺德';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '16060';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '湛江';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '16080';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '肇庆';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '16070';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '中山';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '180';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '珠海';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '7000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '江苏省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '100';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '南京';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '7010';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '常熟';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '18';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '常州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '7020';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '昆山';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '7070';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '连云港';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '7060';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '南通';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '220';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '苏州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '7040';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '太仓';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '152';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '无锡';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '7030';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '徐州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '167';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '扬州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '7080';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '镇江';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '8000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '浙江省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '55';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '杭州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '107';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '宁波';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '147';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '温州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '8050';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '绍兴';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '8060';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '金华';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '8080';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '台州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '8090';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '湖州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '73';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '嘉兴';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '8110';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '衢州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '8100';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '丽水';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '8070';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '舟山';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '9000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '安徽省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '65';
Location_ParentId[I] = '9000';
Location_CodeValue[I] = '合肥';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '9040';
Location_ParentId[I] = '9000';
Location_CodeValue[I] = '安庆';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '9030';
Location_ParentId[I] = '9000';
Location_CodeValue[I] = '蚌埠';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '9020';
Location_ParentId[I] = '9000';
Location_CodeValue[I] = '芜湖';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '10000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '福建省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '35';
Location_ParentId[I] = '10000';
Location_CodeValue[I] = '福州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '10030';
Location_ParentId[I] = '10000';
Location_CodeValue[I] = '泉州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '155';
Location_ParentId[I] = '10000';
Location_CodeValue[I] = '厦门';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '10040';
Location_ParentId[I] = '10000';
Location_CodeValue[I] = '漳州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '24000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '甘肃省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '85';
Location_ParentId[I] = '24000';
Location_CodeValue[I] = '兰州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '24020';
Location_ParentId[I] = '24000';
Location_CodeValue[I] = '嘉峪关';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '24030';
Location_ParentId[I] = '24000';
Location_CodeValue[I] = '酒泉';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '17000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '广西自治区';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '105';
Location_ParentId[I] = '17000';
Location_CodeValue[I] = '南宁';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '17040';
Location_ParentId[I] = '17000';
Location_CodeValue[I] = '北海';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '42';
Location_ParentId[I] = '17000';
Location_CodeValue[I] = '桂林';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '17020';
Location_ParentId[I] = '17000';
Location_CodeValue[I] = '柳州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '17050';
Location_ParentId[I] = '17000';
Location_CodeValue[I] = '玉林';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '20000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '贵州省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '45';
Location_ParentId[I] = '20000';
Location_CodeValue[I] = '贵阳';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '20020';
Location_ParentId[I] = '20000';
Location_CodeValue[I] = '遵义';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '18000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '海南省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '50';
Location_ParentId[I] = '18000';
Location_CodeValue[I] = '海口';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '18020';
Location_ParentId[I] = '18000';
Location_CodeValue[I] = '三亚';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '1000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '河北省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '130';
Location_ParentId[I] = '1000';
Location_CodeValue[I] = '石家庄';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '7';
Location_ParentId[I] = '1000';
Location_CodeValue[I] = '保定';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '1070';
Location_ParentId[I] = '1000';
Location_CodeValue[I] = '承德';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '53';
Location_ParentId[I] = '1000';
Location_CodeValue[I] = '邯郸';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '1080';
Location_ParentId[I] = '1000';
Location_CodeValue[I] = '廊坊';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '1030';
Location_ParentId[I] = '1000';
Location_CodeValue[I] = '秦皇岛';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '1020';
Location_ParentId[I] = '1000';
Location_CodeValue[I] = '唐山';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '1060';
Location_ParentId[I] = '1000';
Location_CodeValue[I] = '张家口';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '13000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '河南省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '175';
Location_ParentId[I] = '13000';
Location_CodeValue[I] = '郑州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '78';
Location_ParentId[I] = '13000';
Location_CodeValue[I] = '开封';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '92';
Location_ParentId[I] = '13000';
Location_CodeValue[I] = '洛阳';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '6000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '黑龙江省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '60';
Location_ParentId[I] = '6000';
Location_CodeValue[I] = '哈尔滨';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '6030';
Location_ParentId[I] = '6000';
Location_CodeValue[I] = '大庆';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '6040';
Location_ParentId[I] = '6000';
Location_CodeValue[I] = '佳木斯';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '6050';
Location_ParentId[I] = '6000';
Location_CodeValue[I] = '牡丹江';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '6020';
Location_ParentId[I] = '6000';
Location_CodeValue[I] = '齐齐哈尔';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '14000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '湖北省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '150';
Location_ParentId[I] = '14000';
Location_CodeValue[I] = '武汉';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '14020';
Location_ParentId[I] = '14000';
Location_CodeValue[I] = '十堰';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '14040';
Location_ParentId[I] = '14000';
Location_CodeValue[I] = '襄樊';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '14030';
Location_ParentId[I] = '14000';
Location_CodeValue[I] = '宜昌';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '14050';
Location_ParentId[I] = '14000';
Location_CodeValue[I] = '潜江';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '14060';
Location_ParentId[I] = '14000';
Location_CodeValue[I] = '荆门';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '14070';
Location_ParentId[I] = '14000';
Location_CodeValue[I] = '荆州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '14080';
Location_ParentId[I] = '14000';
Location_CodeValue[I] = '黄石';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '15000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '湖南省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '15';
Location_ParentId[I] = '15000';
Location_CodeValue[I] = '长沙';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '15030';
Location_ParentId[I] = '15000';
Location_CodeValue[I] = '湘潭';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '15020';
Location_ParentId[I] = '15000';
Location_CodeValue[I] = '株洲';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '15040';
Location_ParentId[I] = '15000';
Location_CodeValue[I] = '常德';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '15050';
Location_ParentId[I] = '15000';
Location_CodeValue[I] = '衡阳';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '15060';
Location_ParentId[I] = '15000';
Location_CodeValue[I] = '益阳';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '15070';
Location_ParentId[I] = '15000';
Location_CodeValue[I] = '郴州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '15080';
Location_ParentId[I] = '15000';
Location_CodeValue[I] = '岳阳';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '5000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '吉林省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '10';
Location_ParentId[I] = '5000';
Location_CodeValue[I] = '长春';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '5020';
Location_ParentId[I] = '5000';
Location_CodeValue[I] = '吉林市';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '11000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '江西省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '95';
Location_ParentId[I] = '11000';
Location_CodeValue[I] = '南昌';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '11020';
Location_ParentId[I] = '11000';
Location_CodeValue[I] = '九江';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '4000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '辽宁省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '120';
Location_ParentId[I] = '4000';
Location_CodeValue[I] = '沈阳';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '4030';
Location_ParentId[I] = '4000';
Location_CodeValue[I] = '鞍山';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '30';
Location_ParentId[I] = '4000';
Location_CodeValue[I] = '大连';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '4040';
Location_ParentId[I] = '4000';
Location_CodeValue[I] = '葫芦岛';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '3000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '内蒙古自治区';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '70';
Location_ParentId[I] = '3000';
Location_CodeValue[I] = '呼和浩特';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '3020';
Location_ParentId[I] = '3000';
Location_CodeValue[I] = '包头';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '3030';
Location_ParentId[I] = '3000';
Location_CodeValue[I] = '赤峰';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '26000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '宁夏自治区';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '170';
Location_ParentId[I] = '26000';
Location_CodeValue[I] = '银川';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '25000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '青海省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '165';
Location_ParentId[I] = '25000';
Location_CodeValue[I] = '西宁';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '12000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '山东省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '75';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '济南';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '12090';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '德州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '12040';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '东营';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '12060';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '济宁';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '12100';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '临沂';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '110';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '青岛';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '12080';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '日照';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '12070';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '泰安';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '146';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '威海';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '12050';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '潍坊';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '168';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '烟台';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '12030';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '淄博';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '2000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '山西省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '135';
Location_ParentId[I] = '2000';
Location_CodeValue[I] = '太原';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '2010';
Location_ParentId[I] = '2000';
Location_CodeValue[I] = '大同';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '2020';
Location_ParentId[I] = '2000';
Location_CodeValue[I] = '临汾';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '2030';
Location_ParentId[I] = '2000';
Location_CodeValue[I] = '运城';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '23000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '陕西省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '160';
Location_ParentId[I] = '23000';
Location_CodeValue[I] = '西安';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '23010';
Location_ParentId[I] = '23000';
Location_CodeValue[I] = '宝鸡';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '23020';
Location_ParentId[I] = '23000';
Location_CodeValue[I] = '咸阳';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '19000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '四川省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '20';
Location_ParentId[I] = '19000';
Location_CodeValue[I] = '成都';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '19060';
Location_ParentId[I] = '19000';
Location_CodeValue[I] = '乐山';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '19030';
Location_ParentId[I] = '19000';
Location_CodeValue[I] = '泸州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '19040';
Location_ParentId[I] = '19000';
Location_CodeValue[I] = '绵阳';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '19050';
Location_ParentId[I] = '19000';
Location_CodeValue[I] = '内江';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '19070';
Location_ParentId[I] = '19000';
Location_CodeValue[I] = '宜宾';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '19020';
Location_ParentId[I] = '19000';
Location_CodeValue[I] = '自贡';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '22000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '西藏自治区';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '90';
Location_ParentId[I] = '22000';
Location_CodeValue[I] = '拉萨';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '22020';
Location_ParentId[I] = '22000';
Location_CodeValue[I] = '日喀则';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '27000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '新疆自治区';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '145';
Location_ParentId[I] = '27000';
Location_CodeValue[I] = '乌鲁木齐';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '27030';
Location_ParentId[I] = '27000';
Location_CodeValue[I] = '喀什';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '27020';
Location_ParentId[I] = '27000';
Location_CodeValue[I] = '克拉玛依';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '27040';
Location_ParentId[I] = '27000';
Location_CodeValue[I] = '伊犁';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '21000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '云南省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '80';
Location_ParentId[I] = '21000';
Location_CodeValue[I] = '昆明';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '21030';
Location_ParentId[I] = '21000';
Location_CodeValue[I] = '大理';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '21040';
Location_ParentId[I] = '21000';
Location_CodeValue[I] = '丽江';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '21020';
Location_ParentId[I] = '21000';
Location_CodeValue[I] = '玉溪';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '34000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '香港';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '185';
Location_ParentId[I] = '34000';
Location_CodeValue[I] = '香港';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '35000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '澳门';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '190';
Location_ParentId[I] = '35000';
Location_CodeValue[I] = '澳门';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '36000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '台湾';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '195';
Location_ParentId[I] = '36000';
Location_CodeValue[I] = '台湾';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '37000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '其他亚洲国家和地区';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '200';
Location_ParentId[I] = '37000';
Location_CodeValue[I] = '其他亚洲国家和地区';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '38000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '北美洲';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '205';
Location_ParentId[I] = '38000';
Location_CodeValue[I] = '北美洲';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '41000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '南美洲';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '230';
Location_ParentId[I] = '41000';
Location_CodeValue[I] = '南美洲';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '39000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '大洋洲';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '210';
Location_ParentId[I] = '39000';
Location_CodeValue[I] = '大洋洲';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '40000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '欧洲';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '215';
Location_ParentId[I] = '40000';
Location_CodeValue[I] = '欧洲';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '42000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '非洲';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '235';
Location_ParentId[I] = '42000';
Location_CodeValue[I] = '非洲';
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
  if(locbox.length==0) fullup_P(locbox, '--请选择--', -1);
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

	if(!submitText(frm.txtMem_Name, "公司名称")) return false;

//	if(!submitText(frm.txtAbbrName, "公司简称")) return false;

	if(ChkSel(frm.lstComType, -1, "公司性质")==false) return false;
	if(ChkSel(frm.lstSize, -1, "公司规模")==false) return false;
        if(ChkSel(frm.lstIndustry, '0', "所属行业")==false) return false;
/*	if(frm.sltAllLocId.value == -1)
	{
	  alert('请选择公司所在地区！');
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
	  alert("请选择公司所属行业！");
	  frm.lstIndustry.focus();
	  return false;
	}
	else if(intCount>3)
	{
	  alert("所属行业最多可以选三个！");
	  frm.lstIndustry.focus();
	  return false;
	}

	if(!submitText(frm.txtLinkManName, "联系人姓名")) return false;

	//if(!submitText(frm.txtLinkManTitle, "联系人职位")) return false;
	if(!submitText(frm.txtEmail, "E-mail")) return false;
	if(!submitEmail(frm.txtEmail,"请输入正确的E-mail格式！"))
	{
//		alert("请输入正确的E-mail格式！");
//		frm.txtEmail.focus();
		return false;
	}

	if(!submitText(frm.txtPhone, "电话")) return false;

  s = frm.txtComIntr.value;/*
  if(s.length < 100)
  {
//    for(var i=0;i<frm.txtComIntr.value.length;i++)
//      s = s.replace(/\s/i,'');
  }
  if(Trim(s).length == 0)
  {
    alert('公司简介必须填写！');
    frm.txtComIntr.focus();
    return false;
  }
	else */if(!submitText(frm.txtComIntr, "公司简介")) return false;
	else if(!ChkLength(frm.txtComIntr, "公司简介",3000)) return false;

	if(!submitText(frm.txtUserName, "用户名")) return false;
//	if(!CheckUserName(form1.txtUserName)) return false;

	if(!submitText(frm.txtPassword, "密码")) return false;
	if(!Chkpwd(frm.txtPassword, "密码", 12, 6)) return false;

	if(!submitText(frm.txtConPassword, "确认密码")) return false;
	if(!Chkpwd(frm.txtConPassword,"确认密码",12, 6)) return false;

	if(frm.txtPassword.value != frm.txtConPassword.value)
	{
		alert("密码与确认密码不一致！");
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
//城市缩进"--"
function CheckLoc(objloc)
{
    for(var x=0;x<objloc.length;x++)
    {
	  var opt = objloc.options[x];
	  if (opt.value.substring(opt.value.length-3,opt.value.length)!='000'&& opt.value!='5'&& opt.value!='115'&& opt.value!='140'&& opt.value!='25'&& opt.value!='185'&& opt.value!='190'&& opt.value!='195'&& opt.value!='200'&& opt.value!='205'&& opt.value!='210'&& opt.value!='215'&& opt.value!='230'&& opt.value!='235'&& opt.value!='255') //是省id
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
<title>填写注册信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<BODY>
<h1><%=r.getString(teasession._nLanguage, "填写信息")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <FORM NAME = "form1" METHOD = "post"  enctype=multipart/form-data onSubmit = "return chkForm()&&submitIdentifier(this.txtUserName,'<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>')" action="/servlet/ProfileEnterpriseServlet">
 <input type="hidden" name="community" value="<%=node.getCommunity()%>"/>
    <INPUT TYPE="hidden" VALUE="resiger" NAME="hdnResiger">
          <TR>
            <TD colspan="4" ALIGN="right"><div align="left">填写注册信息  </div></TD>
          </TR>
		 <TR >
            <TD colspan="4" ALIGN="right">
		  * 必须填写</TD>
          </TR>
          <TR>
            <TD WIDTH="100" ALIGN="right"><SPAN CLASS="alert">*</SPAN> 公司名称&nbsp;</TD>
            <TD COLSPAN="3"> <INPUT TYPE="text"  class="edit_input"  NAME="txtMem_Name" MAXLENGTH="60" VALUE="<%=name%>" SIZE="44">
            </TD>
          </TR>
         <TR>  <!--
            <TD ALIGN="right"><SPAN CLASS="alert">*</SPAN> 公司简称&nbsp;</TD>
            <TD> <INPUT TYPE="text" NAME="txtAbbrName" MAXLENGTH="20" VALUE="" SIZE="20">
              <SPAN CLASS="note">用于登录智聘系统</SPAN> </TD>-->
            <TD WIDTH="100" ALIGN="right" NOWRAP> 营业执照&nbsp;</TD>
            <TD> <INPUT TYPE="file" NAME="txtLicenceNo" MAXLENGTH="30" VALUE=""  class="edit_button" >
            </TD>
          </TR>
          <TR>
            <TD ALIGN="right"><SPAN CLASS="alert">*</SPAN> 公司性质&nbsp;</TD>
            <TD> <SELECT NAME="lstComType" STYLE="width:135px">
                <OPTION VALUE="-1">--请选择--</OPTION>
                <!--版本号：0001-->
<!--Action:2-->
<OPTION VALUE="外商独资．外企办事处" <%if(property.equals("外商独资．外企办事处"))out.print(" SELECTED ");%>>外商独资．外企办事处</OPTION>
<OPTION VALUE="中外合营(合资．合作)" <%if(property.equals("中外合营(合资．合作)"))out.print(" SELECTED ");%>>中外合营(合资．合作)</OPTION>
<OPTION VALUE="私营．民营企业" <%if(property.equals("私营．民营企业"))out.print(" SELECTED ");%>>私营．民营企业</OPTION>
<OPTION VALUE="国有企业" <%if(property.equals("国有企业"))out.print(" SELECTED ");%>>国有企业</OPTION>
<OPTION VALUE="国内上市公司" <%if(property.equals("国内上市公司"))out.print(" SELECTED ");%>>国内上市公司</OPTION>
<OPTION VALUE="政府机关／非盈利机构" <%if(property.equals("政府机关／非盈利机构"))out.print(" SELECTED ");%>>政府机关／非盈利机构</OPTION>
<OPTION VALUE="事业单位" <%if(property.equals("事业单位"))out.print(" SELECTED ");%>>事业单位</OPTION>

              </SELECT> </TD>
            <TD ALIGN="right"><SPAN CLASS="alert">*</SPAN> 公司规模&nbsp;</TD>
            <TD> <select name="lstSize" style="width:135px"  class="edit_input" >
              <option value="-1">--请选择--</option>
              <!--版本号：0001-->
              <!--Action:2-->
              <option value="1"  <%if(size==1)out.print(" SELECTED ");%>>1 - 49人</option>
              <option value="50"<%if(size==50)out.print(" SELECTED ");%>>50 - 99人</option>
              <option value="100"<%if(size==100)out.print(" SELECTED ");%>>100 - 499人</option>
              <option value="500"<%if(size==500)out.print(" SELECTED ");%>>500 - 999人</option>
              <option value="1000"<%if(size==1000)out.print(" SELECTED ");%>>1000人以上</option>
            </select> </TD>
          </TR>
          <%--          <TR>
  <TD ALIGN="right" NOWRAP><SPAN CLASS="alert">*</SPAN> 公司所在地区&nbsp;</TD>
            <TD COLSPAN="3"> <SELECT NAME="sltProvinceId"  STYLE="width:135px" ONCHANGE="javascript:SelectOption('Location',true, form1.sltProvinceId,form1.sltAllLocId,'', '255', '--选择城市--');CheckLoc(form1.sltAllLocId);">
                <OPTION VALUE="-1">--请选择--</OPTION>
                <!--版本号：0001-->
<!--Action:1-->
<OPTION VALUE="30000">北京</OPTION>
<OPTION VALUE="31000">上海</OPTION>
<OPTION VALUE="32000">天津</OPTION>
<OPTION VALUE="33000">重庆</OPTION>
<OPTION VALUE="16000">广东省</OPTION>
<OPTION VALUE="7000">江苏省</OPTION>
<OPTION VALUE="8000">浙江省</OPTION>
<OPTION VALUE="9000">安徽省</OPTION>
<OPTION VALUE="10000">福建省</OPTION>
<OPTION VALUE="24000">甘肃省</OPTION>
<OPTION VALUE="17000">广西自治区</OPTION>
<OPTION VALUE="20000">贵州省</OPTION>
<OPTION VALUE="18000">海南省</OPTION>
<OPTION VALUE="1000">河北省</OPTION>
<OPTION VALUE="13000">河南省</OPTION>
<OPTION VALUE="6000">黑龙江省</OPTION>
<OPTION VALUE="14000">湖北省</OPTION>
<OPTION VALUE="15000">湖南省</OPTION>
<OPTION VALUE="5000">吉林省</OPTION>
<OPTION VALUE="11000">江西省</OPTION>
<OPTION VALUE="4000">辽宁省</OPTION>
<OPTION VALUE="3000">内蒙古自治区</OPTION>
<OPTION VALUE="26000">宁夏自治区</OPTION>
<OPTION VALUE="25000">青海省</OPTION>
<OPTION VALUE="12000">山东省</OPTION>
<OPTION VALUE="2000">山西省</OPTION>
<OPTION VALUE="23000">陕西省</OPTION>
<OPTION VALUE="19000">四川省</OPTION>
<OPTION VALUE="22000">西藏自治区</OPTION>
<OPTION VALUE="27000">新疆自治区</OPTION>
<OPTION VALUE="21000">云南省</OPTION>
<OPTION VALUE="34000">香港</OPTION>
<OPTION VALUE="35000">澳门</OPTION>
<OPTION VALUE="36000">台湾</OPTION>
<OPTION VALUE="37000">其他亚洲国家和地区</OPTION>
<OPTION VALUE="38000">北美洲</OPTION>
<OPTION VALUE="41000">南美洲</OPTION>
<OPTION VALUE="39000">大洋洲</OPTION>
<OPTION VALUE="40000">欧洲</OPTION>
<OPTION VALUE="42000">非洲</OPTION>

              </SELECT>

              <SELECT NAME="sltAllLocId"  STYLE="width:135px">

                <OPTION VALUE = "-1">--请选择--</OPTION>

              </SELECT> </TD>
          </TR>--%>
          <TR>
            <TD ALIGN="right">地址&nbsp;</TD>
            <TD><input  class="edit_input"  type="text" name="txtAddress" maxlength="100" value="<%=address%>" size="44"></TD>
            <TD ALIGN="RIGHT">邮政编码&nbsp;</TD>
            <TD> <INPUT  class="edit_input" TYPE="text" NAME="txtZipCode" MAXLENGTH="10" VALUE="<%=zip%>">
            </TD>
          </TR>
          <TR>
            <TD ALIGN="right">公司网址&nbsp;</TD>
            <TD> <INPUT  class="edit_input"  NAME="txtMem_Url" TYPE="text" MAXLENGTH="100"  VALUE="<%=webpage%>" SIZE="44"> </TD>
            <TD ALIGN="right">&nbsp;</TD>
            <TD>&nbsp; </TD>
          </TR>
          <TR>
            <TD ALIGN="right">传真&nbsp;</TD>
            <TD COLSPAN="3"><input  class="edit_input"  name="txtFax" type="text"  value="<%=fax%>" size="20" maxlength="40">              <SPAN CLASS="note">格式：区号-传真号码</SPAN></TD>
          </TR>
          <TR>
            <TD ALIGN="right" VALIGN="top"><SPAN CLASS="alert">*</SPAN> 所属行业&nbsp;</TD>
            <TD COLSPAN="3"> <%=new tea.htmlx.TradeSelection("lstIndustry",calling)%>
			<%--<SELECT NAME="lstIndustry" SIZE="5"  MULTIPLE  STYLE="width:275px">
                <!--版本号：0003-->
<!--Action:2-->
<OPTION VALUE="100">计算机</OPTION>
<OPTION VALUE="3600">互联网·电子商务</OPTION>
<OPTION VALUE="300">电子·微电子技术</OPTION>
<OPTION VALUE="400">通讯·电信业</OPTION>
<OPTION VALUE="1300">快速消费品(食品·饮料·日化·烟酒等)</OPTION>
<OPTION VALUE="3800">纺织品业(服饰鞋帽·家纺用品·皮具等)</OPTION>
<OPTION VALUE="1400">家电业</OPTION>
<OPTION VALUE="1101000">家具·工艺品</OPTION>
<OPTION VALUE="1102000">木材加工及木、竹、藤、棕、草制品业</OPTION>
<OPTION VALUE="1103000">橡胶·塑料·非金属矿物制品业</OPTION>
<OPTION VALUE="1104000">金属制品业</OPTION>
<OPTION VALUE="1500">家居·室内设计·装潢</OPTION>
<OPTION VALUE="600">批发·零售(商场·专卖店·百货·超市)</OPTION>
<OPTION VALUE="700">贸易·进出口</OPTION>
<OPTION VALUE="1700">运输·物流·快递</OPTION>
<OPTION VALUE="1600">旅游·酒店·餐饮服务</OPTION>
<OPTION VALUE="3700">物业管理·商业中心</OPTION>
<OPTION VALUE="1100">建筑·房地产</OPTION>
<OPTION VALUE="800">市场·广告·公关</OPTION>
<OPTION VALUE="900">专业服务·咨询·财会·法律</OPTION>
<OPTION VALUE="2800">中介服务(人才·房地产·商标专利·技术等)</OPTION>
<OPTION VALUE="1000">金融业(投资·保险·证券·银行·基金)</OPTION>
<OPTION VALUE="1200">娱乐·运动·休闲</OPTION>
<OPTION VALUE="2500">媒体·影视制作·新闻出版</OPTION>
<OPTION VALUE="4000">艺术·文化传播</OPTION>
<OPTION VALUE="2000">医疗设备</OPTION>
<OPTION VALUE="2300">制药·生物工程</OPTION>
<OPTION VALUE="3200">医疗·保健·卫生服务</OPTION>
<OPTION VALUE="1800">办公设备·用品</OPTION>
<OPTION VALUE="2100">汽车·摩托车(制造与维护·配件·用品)</OPTION>
<OPTION VALUE="2200">石油·化工·采掘·冶炼·原材料</OPTION>
<OPTION VALUE="500">电力·电气·能源</OPTION>
<OPTION VALUE="3900">仪器·仪表·工业自动化</OPTION>
<OPTION VALUE="1900">机械制造·机电设备·重工业</OPTION>
<OPTION VALUE="2600">印刷·包装·造纸</OPTION>
<OPTION VALUE="2700">生产·制造·加工</OPTION>
<OPTION VALUE="2400">环保服务·设备</OPTION>
<OPTION VALUE="1105000">航空/航天研究与制造</OPTION>
<OPTION VALUE="1106000">服务业</OPTION>
<OPTION VALUE="2900">农·林·牧·渔</OPTION>
<OPTION VALUE="3100">培训机构·教育·科研院所</OPTION>
<OPTION VALUE="3300">政府·公共事业</OPTION>
<OPTION VALUE="3400">协会·学会·社团·非营利机构</OPTION>
<OPTION VALUE="3500">在校学生</OPTION>
<OPTION VALUE="4100">其他</OPTION>

              </SELECT> --%><SPAN CLASS="note">按住Ctrl键可多选，最多选三种行业 </SPAN></TD>
          </TR>
          <TR>
            <TD ALIGN="right" COLSPAN="4"> <HR SIZE="1"> </TD>
          </TR>
          <TR>
            <TD ALIGN="right"><SPAN CLASS="alert">* </SPAN>联系人姓名&nbsp;</TD>
            <TD COLSPAN="3"><input  class="edit_input"  type="text" name="txtLinkManName" maxlength="60" value="<%=linkman%>">
              <INPUT  id="radio" type="radio" NAME="rdoGender" VALUE="1" CHECKED>
              先生
              <INPUT  id="radio" type="radio" NAME="rdoGender" VALUE="0" <%if(!sex)out.println(" CHECKED ");%>>
            女士</TD>
          </TR><%-- %>
          <TR VALIGN="TOP">
            <TD ALIGN="right"><SPAN CLASS="alert">*</SPAN> 联系人职位&nbsp;</TD>
            <TD COLSPAN="3"> <INPUT TYPE="text" NAME="txtLinkManTitle" MAXLENGTH="60" VALUE="">
            </TD>
          </TR>--%>
          <TR>
            <TD ALIGN="right"><SPAN CLASS="alert">* </SPAN>E-mail&nbsp;</TD>
            <TD COLSPAN="3"><input  class="edit_input"  type="text" name="txtEmail" maxlength="120" value="<%=email%>">              <SPAN CLASS="alert">重要！</SPAN><SPAN CLASS="note">E-mail是你今后使用本网的重要工具，请务必填写正确。</SPAN></TD>
          </TR>
          <TR>
            <TD ALIGN="right"><SPAN CLASS="alert">*</SPAN> 电话&nbsp;</TD>
            <TD COLSPAN="3"> <INPUT  class="edit_input"  TYPE="text" NAME="txtPhone" MAXLENGTH="40" VALUE="<%=telephone%>">
              <SPAN CLASS="note">格式：区号-电话-分机</SPAN></TD>
          </TR>
          <TR>
            <TD ALIGN="right" VALIGN="top"><SPAN CLASS="alert">*</SPAN> 公司简介&nbsp;</TD>
            <TD COLSPAN="3"> <TEXTAREA NAME="txtComIntr" class="edit_input"  COLS="70" ROWS="5"><%=synopsis%></TEXTAREA>
              <br/> <SPAN CLASS="note">最多可以输入3000个字。</SPAN><A HREF="javascript:getLength(form1.txtComIntr.value);">查看字数</A></TD>
          </TR>
          <TR>
            <TD COLSPAN="4"> <HR SIZE="1"> </TD>
          </TR>
          <TR>
            <TD ALIGN="right"><SPAN CLASS="alert">*</SPAN> 用户名&nbsp;</TD>
            <TD COLSPAN="3"><input class="edit_input"  type="text" name="txtUserName" maxlength="20" value="<%if(member!=null)out.println(member);%>">              <SPAN CLASS="note"> 20位以内，字母、数字、下划线的组合</SPAN></TD>
          </TR>
          <TR>
            <TD ALIGN="right"><SPAN CLASS="alert">*</SPAN> 密码&nbsp;</TD>
            <TD COLSPAN="3"><input  class="edit_input"  type="password" name="txtPassword" maxlength="12">              <SPAN CLASS="note"> 6－12位</SPAN> </TD>
          </TR>
          <TR>
            <TD ALIGN="right"><SPAN CLASS="alert">*</SPAN> 确认密码&nbsp;</TD>
            <TD COLSPAN="3"> <INPUT class="edit_input" TYPE="password" NAME="txtConPassword" MAXLENGTH="12">
            </TD>
          </TR>

          <TR>
            <TD COLSPAN="4" ALIGN="center" HEIGHT="50"> <INPUT NAME="hiddenSubmit" VALUE="1" TYPE="hidden">
                            <input name="提交" type="submit" id="提交" value="提交"  class="edit_button" >

              &nbsp; <input name="取消" type="submit" id="取消" value="取消" onClick="return cancel();"  class="edit_button" >
            </TD>
          </TR></FORM>
        </TABLE>


 <%if(member!=null)out.println(new tea.html.Script("for(var counter=0;counter<form1.elements.length;counter++)form1.elements[counter].disabled=true;"));%>
</BODY>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</head>
</html>

