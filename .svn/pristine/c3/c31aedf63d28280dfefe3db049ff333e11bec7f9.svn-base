<%@page contentType="text/html;charset=UTF-8" %>
<%//@include file="/jsp/Header.jsp"%>
<%@ page import="tea.entity.node.*"%>
<%@ page import="tea.html.*"%>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.resource.*"%>
<%@ page import="tea.ui.TeaServlet"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.jasper.runtime.JspRuntimeLibrary"%>
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
%><%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
/*String uri=request.getRequestURI();
String str=uri.substring(uri.lastIndexOf("/")+1,uri.length()-4);
r.add(str);
*/
 teasession = new TeaSession(request);

node=Node.find(teasession._nNode);
%>

<%

String community =node.getCommunity();










%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<TITLE>个人简历</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" ></script>
<STYLE TYPE="text/css">
<!--
td {
	font-size: 12px;
	line-height: 130%;
}
.cell {
	padding: 5px;
}
-->
</STYLE>
<STYLE TYPE="text/css">
<!--
.font10 {
	font-size: 14px;
}
.red {
	color: #990000;
}
.table td{padding-left:35px}
.table {
	background-image:url(/tea/image/section/11443.jpg);background-repeat: no-repeat;height:18px;line-height:18px;font-weight:100;color:#ffffff;padding-left:35px;padding-top:2px;padding-bottom:2px;margin:0px;margin-bottom:5px;
	border-top-width: 1px;
	border-right-width: 1px;
	border-bottom-width: 1px;
	border-left-width: 1px;
	border-top-style: solid;
	border-right-style: none;
	border-bottom-style: none;
	border-left-style: none;
	border-top-color: #999999;
	border-right-color: #999999;
	border-bottom-color: #999999;
	border-left-color: #999999;
}
a {
	color: #0000CC;
}
-->
</STYLE>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);

function MM_callJS(jsStr) { //v2.0
  return eval(jsStr)
}
//-->
</script>
</head>
<BODY>
<h1><%=r.getString(teasession._nLanguage, "jianli")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<SCRIPT>
function loadThreadFollow(t_id,b_id){
	var targetImg =eval("document.all.followImg" + t_id);
	var targetDiv =eval("document.all.follow" + t_id);
	if (targetImg.src.indexOf("nofollow")!=-1){return false;}
	if ("object"==typeof(targetImg)){
		if (targetDiv.style.display!='block'){
			targetDiv.style.display="block";
			targetImg.src="images/template_10_.gif";
			if (targetImg.loaded=="no"){
			}
		}else{
			targetDiv.style.display="none";
			targetImg.src="images/template_10.gif";
		}
	}
}
</SCRIPT>
<%
int langu=1;//teasession._nLanguage;
String values[]=request.getParameterValues("Node");
for(int index=0;index<values.length;index++)
{
  teasession._nNode=Integer.parseInt(values[index]);
  Waiter summary=Waiter.find(teasession._nNode,langu);

  String strMember=summary.getMember();

  Profile profile=Profile.find(strMember);
  java.util.Enumeration enumeration=Employment.find(teasession._nNode,teasession._nLanguage);

  //教育
  java.util.Enumeration enumerationEducate=Educate.find(teasession._nNode,teasession._nLanguage);
  if(index!=0)
  out.print("<hr size=1>");
%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR>
    <TD ALIGN="CENTER" BGCOLOR="#FFFFFF">
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <TR>
          <TD VALIGN="top" CLASS="cell"><FONT COLOR="#990000">编号 <%=teasession._nNode%></FONT>&nbsp;&nbsp;&nbsp;&nbsp;<FONT COLOR="#666666">更新日期:<%=node.getTimeToString()%></FONT></TD>
          <TD><IMG SRC="http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=Communityjob.find(community).getLogo()%>"></TD>
        </TR>
        <tr><td><%String applyAmount=request.getParameter("applyAmount");
        if(applyAmount!=null&&applyAmount.length()>0)
        out.print("申请职位："+tea.entity.node.Job.find(Integer.parseInt(applyAmount),1 ).getName());%>

      </TABLE><!--
      <TABLE WIDTH="99%" BORDER="0" ALIGN="center" CELLPADDING="0" CELLSPACING="0">
        <TR>
          <TD HEIGHT="1" BGCOLOR="#999999"><IMG SRC="images/spacer.gif" WIDTH="1" HEIGHT="1"></TD>
        </TR>
      </TABLE>
      <TABLE WIDTH="98%" BORDER="0" ALIGN="center" CELLPADDING="5" CELLSPACING="0">
        <TR>
          <TD>计算机 | 人事经理 | 4年工作经验 | 本科 | 北京</TD>
          <TD WIDTH="70" ALIGN="right">&nbsp;</TD>
        </TR>
      </TABLE>-->
	        <TABLE BORDER="0" ALIGN="center" CELLPADDING="0" CELLSPACING="0" style="display:none">
        <TR>
          <TD BGCOLOR="#999999"><IMG SRC="images/spacer.gif" WIDTH="1" HEIGHT="1"></TD>
        </TR>
      </TABLE>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <TR>
          <TD VALIGN="top">
            <STRONG><SPAN CLASS="font10"><%=profile.getFirstName(langu)%></SPAN></STRONG> （<%=profile.isSex()?"男":"女"%>
            <%if(profile.getAge()>0)out.println(profile.getAge()+"岁");%>）
            <%
            java.util.Enumeration fbm_enumer=tea.entity.node.ApplyTable.findByMember(summary.getMember(),community);
            while(fbm_enumer.hasMoreElements())
            {
              tea.entity.node.ApplyTable at_obj=tea.entity.node.ApplyTable.find(((Integer)fbm_enumer.nextElement()).intValue());
             %>
            <A href="http://<%=request.getServerName()%>:<%=request.getServerPort()%>/tea/app/at<%=at_obj.getApplytable()%>.doc" ><%=at_obj.getName()%></A>
            <%}
            %>
            <br/>
            <br/>
            <%String strEmail=profile.getEmail();
            if(strEmail!=null&&strEmail.length()>0)
            {
            %>
            E-Mail&nbsp;　：<A HREF="mailto:<%=strEmail%>"><%=strEmail%></A><br/>
<%        }
String strMobile=profile.getMobile();
if(strMobile!=null&&strMobile.length()>0){
%>
手&nbsp;&nbsp;&nbsp;&nbsp;机：<%=strMobile%><br/>
<%    }String strtelephone=profile.getTelephone(langu);
if(strtelephone!=null&&strtelephone.length()>3){
%>
电&nbsp;&nbsp;&nbsp;&nbsp;话：<%=strtelephone%><br/>
<%    }String straddress=profile.getAddress(langu);
String getZip=profile.getZip(langu);
if(getZip!=null&&getZip.length()>3){
getZip="("+getZip+")";
}
if(straddress!=null&&straddress.length()>0){
%>
通信地址：<%=straddress+getZip%> <br/>
<%    }
String getWebPage=profile.getWebPage(langu);
if(getWebPage!=null&&getWebPage.length()>3){
%>
个人主页：<A HREF="<%=getWebPage%>"><%=getWebPage%></A><br/>
<%    }
String getCountry=profile.getState(langu);
if(getCountry!=null&&getCountry.length()>0){
%>
籍　　贯：<%=getCountry%><br/>
<%   }%>
教育程度：<%=tea.htmlx.DegreeSelection.getDegree(profile.getDegree(teasession._nLanguage))%><br/>
毕业学校：<%=profile.getSchool(teasession._nLanguage)%>
<%--            户口所在地：北京<br/>
            政治面貌：群众<br/>--%>
            <br/> </TD>
          <TD ><a name="photo"></a>
<TABLE BORDER="0" ALIGN="center" CELLPADDING="0" CELLSPACING="1" BGCOLOR="#999999">
              <TR>
                <TD ALIGN="center" BGCOLOR="#FFFFFF">
<%
//out.println(new String(profile.getPhoto(teasession._nLanguage)));

if(profile.getPhotopath(teasession._nLanguage)==null)
{
  %><IMG SRC="http://<%=request.getServerName()%>:<%=request.getServerPort()%>/images/template_zhaopian.gif">
<%}else{//session.setAttribute("src",new String(profile.getPhoto(teasession._nLanguage))); %>
				<img onerror="" src="http://<%=request.getServerName()%>:<%=request.getServerPort()%>/servlet/PhotoPicture?member=<%=strMember%>&community=<%=community%>" width="90" height="120">
				<%}%></TD>
              </TR>
            </TABLE></TD>
        </TR>
      </TABLE>


      <div style="display:none">

      <%
    String getSelfValue=  summary.getSelfValue();
    String getSelfAim=summary.getSelfAim();
    if((getSelfValue!=null&&getSelfValue.length()>0)||(getSelfAim!=null&&getSelfAim.length()>0)){
    %>
    <TABLE BORDER="0" CELLPADDING="3" CELLSPACING="0">
        <TR>
            <TD><STRONG><a name="objective"></a>自我评价/职业目标</STRONG></TD>
      </TR>
      </TABLE>
        <TABLE BORDER="0" ALIGN="center" CELLPADDING="5" CELLSPACING="0">
            <%if(getSelfValue!=null&&getSelfValue.length()>0){%>
            <TR>
                <TD VALIGN="top">自我评价：<br/>
                </TD>
                <TD><%=getSelfValue%></TD>
            </TR>
            <%}if(getSelfAim!=null&&getSelfAim.length()>0){%>
            <TR>
                <TD VALIGN="top">职业目标：</TD>
                <TD><%=getSelfAim%></TD>
            </TR>
           <% }%>
        </TABLE>
        <%}%>

      <TABLE BORDER="0" CELLPADDING="3" CELLSPACING="0">
        <TR>
          <TD><STRONG>求职意向</STRONG></TD>
        </TR>
      </TABLE>
      <TABLE BORDER="0" ALIGN="center" CELLPADDING="5" CELLSPACING="0">
        <TR>
          <TD VALIGN="top"> 期望月薪（税前）：<%=summary.getExpectSalarySum()%>元(人民币)<br/>
            现从事职业：<%--StringTokenizer tokenizer=new StringTokenizer(getNull(summary.getExpectTrade()),"&");
                    while(tokenizer.hasMoreTokens())
                    {String str=tokenizer.nextToken();out.println(str+"<br>");}--%>
                      <%
                  StringTokenizer   tokenizer=new StringTokenizer(getNull(summary.getExpectCareer()),"&");
                    while(tokenizer.hasMoreTokens())
                    {String str=tokenizer.nextToken();
                    %><%=str%> <br><%}%>
            意向工作性质：<%if((summary.getExpectWorkKind()&2)!=0)out.println("全职");
            if((summary.getExpectWorkKind()&4)!=0)out.println("兼职");
            if((summary.getExpectWorkKind()&8)!=0)out.println("临时");
            if((summary.getExpectWorkKind()&16)!=0)out.println("实习");
            %><br/>
            到岗时间：<%=summary.getJoinDateType()%>天</TD>
          <TD VALIGN="top">目前月薪（税前）：<%=summary.getSalarySum()%>元(人民币)<br/>
            期望从事职业：<%
                     tokenizer=new StringTokenizer(getNull(summary.getExpectCareer()),"&");
                    while(tokenizer.hasMoreTokens())
                    {String str=tokenizer.nextToken();
                    out.println(str+" ");}%><br/>
            期望工作地区：  <%
                     tokenizer=new StringTokenizer(getNull(summary.getExpectCity()),"&");
                    while(tokenizer.hasMoreTokens())
                    {String str=tokenizer.nextToken();out.println(str+" ");
                    }%> </TD>
        </TR>
      </TABLE>                    <TABLE BORDER="0" CELLPADDING="3" CELLSPACING="0">
                        <TR>
                            <TD><STRONG><a name="expdesc"></a>工作经验</STRONG></TD>
                      </TR>
                        </TABLE>
      	<%                if(enumeration.hasMoreElements()){boolean sumbool=false;%>


                           <%     int id;
                           while(enumeration.hasMoreElements()){
                               id=((Integer)enumeration.nextElement()).intValue();
                           Employment employment=Employment.find(id);
                %>  <TABLE BORDER="0" ALIGN="center" CELLPADDING="5" CELLSPACING="0">
                            <TR>
                                <TD VALIGN="top"><%=employment.getStartDate("yyyy/MM")%>--<%=employment.getEndDate("yyyy/MM")%><br/> </TD>
                                    <TD VALIGN="top"> <TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0">
                                        <TR>
                                            <TD><STRONG><%=employment.getOrgName()%></STRONG> </TD>
                                            <TD ALIGN="right"><A HREF="javascript:void (0)" onclick=loadThreadFollow(<%=id%>,6)><IMG id=followImg<%=id%> SRC="/images/template_10.gif" WIDTH="9" HEIGHT="9" HSPACE="6" BORDER="0" ALIGN="absmiddle" loaded="no">公司信息</A></TD>
                                      </TR>
                                        </TABLE>
                                        <table border="0" cellspacing="0" cellpadding="0" id=follow<%=id%> style="DISPLAY: none">
                                            <tr>
                                                <td><%=employment.getOrgInfo()%></td>
                                            </tr>
                                        </table>
                                                    <br/>
                                                        <STRONG><%=employment.getPositionName()%><%if(employment.getDepartment()!=null&&employment.getDepartment().length()>0)out.println("/"+employment.getDepartment());%> 工作地点：<%=employment.getWorkSite()%></STRONG><br/>
                                                         <br/>
                                                                工作职责和业绩：
                                                                   <%=employment.getFunction()%>
                                                                        <br/>
                                                                            <br/>
                                                                                离职/换岗原因：
                                                                                    <%=employment.getReasonOfLeaving()%></TD>
                             </TR>
                                                                       </TABLE>
                                                                            <TABLE BORDER="0" ALIGN="center" CELLPADDING="0" CELLSPACING="0">
                                                                                <TR>
                                                                                    <TD BGCOLOR="#CCCCCC"><IMG SRC="images/spacer.gif" WIDTH="1" HEIGHT="1"/></TD>
                                                                              </TR>
      </TABLE><%
                                                                            } }%>








   <%--  <TABLE BORDER="0" CELLPADDING="3" CELLSPACING="0" CLASS="table">
        <TR>
          <TD><STRONG><IMG SRC="images/spacer.gif" WIDTH="8" HEIGHT="8"><a name="project"></a>项目管理经验</STRONG></TD>
        </TR>
      </TABLE>
      <TABLE BORDER="0" ALIGN="center" CELLPADDING="5" CELLSPACING="0">
        <TR>
          <TD VALIGN="top">1999/11 - 2000/04</TD>
          <TD VALIGN="top"> 项目名称：ABC公司ERP系统<br/>
            软件环境：Rational Rose, Power Design, Weblogic 8.1, Oracle8i<br/>
            硬件环境：SUN 服务器<br/>
            开发工具：Java, JSP, Power Design
            <P>项目描述：该项目是为ABC公司建立的ERP系统，其中包括了生产、物料管理、人力资源等6个子系统，共20个功能模块<br/>
              责任描述：客户需求调研；制定系统的需求规范；建立相应的商务需求和系统需求；和技术经理一起设计整个项目的各个功能模块；制定子系统的开发模型、测试方案和需求变更流程等；负责上线及交付事宜。</P></TD>
        </TR>
      </TABLE>--%>







      <TABLE BORDER="0" CELLPADDING="3" CELLSPACING="0" CLASS="table">
        <TR>
          <TD><STRONG><a name="education"></a>教育培训</STRONG></TD>
        </TR>
      </TABLE>
      <%boolean boolspacer=false;
        while(enumerationEducate.hasMoreElements()){
                   Educate educateobj=Educate.find(((Integer)enumerationEducate.nextElement()).intValue());
         if(boolspacer){%>
      <TABLE BORDER="0" ALIGN="center" CELLPADDING="0" CELLSPACING="0">
        <TR>
          <TD BGCOLOR="#CCCCCC"><IMG SRC="images/spacer.gif" WIDTH="1" HEIGHT="1"></TD>
        </TR>
      </TABLE><%}%>
      <TABLE BORDER="0" ALIGN="center" CELLPADDING="5" CELLSPACING="0">
        <TR>
          <TD VALIGN="top"><%=educateobj.getStart("yyyy/MM")%>--<%=educateobj.getStop("yyyy/MM")%></TD>
          <TD VALIGN="top"> <P><STRONG><%=educateobj.getSchool()%></STRONG> <%=educateobj.getMajorName()%> <%=(educateobj.getDegree(teasession._nLanguage))%> <%=educateobj.getCity()%></P>
            <P><%=educateobj.getComment()%>
            </P>
          </TD>
        </TR>
      </TABLE>
      <%boolspacer=true;}%>    </TABLE>
      </div>


<%}%>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</BODY>
</html>

