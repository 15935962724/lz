<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.html.*"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.ui.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.mail.*" %>
<%@page import="java.net.Socket"%>
<%@page import="javax.mail.internet.*" %>
<%@page import=" tea.db.DbAdapter"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.util.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.ui.member.order.*"%>
<%@page import="tea.http.RequestHelper"%>
<%@page import="tea.entity.*"%>
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
Communityjob communityjob=Communityjob.find(teasession._strCommunity);

if(!"1DEF7C184B2B52104A08A4555B7C2126".equals((String)request.getParameter("jsessionid")))
{
  if(teasession._rv == null)
  {
    response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
    return;
  }
  AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,teasession._rv._strV);
  String role=aur.getRole();

  if(role.indexOf("/"+communityjob.getRolejob()+"/")==0 && role.indexOf("/"+communityjob.getRoleresume()+"/")==0 && role.indexOf("/"+communityjob.getRoleapp()+"/")==0 && role.indexOf("/"+communityjob.getRolecom()+"/")==0 &&!License.getInstance().getWebMaster().equals(teasession._rv.toString())&&!communityjob.getJobmember().equals(teasession._rv.toString())&&!node.isCreator(teasession._rv))
  {
    response.sendError(403);
    return;
  }
}

String community =node.getCommunity();



r.add("/tea/resource/Job");


int job=0;
String tmp=request.getParameter("job");
if(tmp!=null&&tmp.length()>0)
{
  job=Integer.parseInt(tmp);
}



%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
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

</HEAD>

<BODY>
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
String rs[]=request.getParameterValues("resumes");
for(int index=0;index<rs.length;index++)
{
  teasession._nNode=Integer.parseInt(rs[index]);
  Node node=Node.find(teasession._nNode);
  Resume summary=Resume.find(teasession._nNode,langu);
  String strMember=node.getCreator()._strV;
  tea.entity.member.Profile profile=tea.entity.member.Profile.find(strMember);
  java.util.Enumeration enumeration=Employment.find(teasession._nNode,teasession._nLanguage);

  //教育
  java.util.Enumeration enumerationEducate=Educate.find(teasession._nNode,teasession._nLanguage);
  if(index!=0)
  out.print("<hr size=1>");
%>

<TABLE WIDTH="600" BORDER="0" ALIGN="center" CELLPADDING="1" CELLSPACING="1" BGCOLOR="#999999">
  <TR>
    <TD ALIGN="CENTER" BGCOLOR="#FFFFFF">
      <TABLE WIDTH="98%" BORDER="0" CELLSPACING="0" CELLPADDING="5">
        <TR>
          <TD VALIGN="top" CLASS="cell"><FONT COLOR="#990000"><%=r.getString(teasession._nLanguage,"1168236735765")%><!--编号--> <%=teasession._nNode%></FONT>&nbsp;&nbsp;&nbsp;&nbsp;<FONT COLOR="#666666"><%=r.getString(teasession._nLanguage,"1167461815640")%><!--更新日期--> <%=node.getTimeToString()%></FONT></TD>
          <TD WIDTH="60"><%--<IMG SRC="http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=communityjob.getLogo()%>" alt="">--%></TD>
        </TR>
        <tr>
          <td><% if(job>0)out.print("申请职位："+Node.find(job).getSubject(teasession._nLanguage)); %>
      </TABLE>
      <TABLE WIDTH="99%" BORDER="0" ALIGN="center" CELLPADDING="0" CELLSPACING="0">
        <TR>
          <TD HEIGHT="1" BGCOLOR="#999999"><IMG WIDTH="1" HEIGHT="1"></TD>
        </TR>
      </TABLE>
      <TABLE WIDTH="98%" BORDER="0" ALIGN="center" CELLPADDING="6" CELLSPACING="0">
        <TR>
          <TD VALIGN="top">
            <STRONG>
              <SPAN CLASS="font10"><%=profile.getFirstName(langu)%> <%=profile.getLastName(langu)%></SPAN></STRONG>
            <%
            out.print("（"+r.getString(teasession._nLanguage,(profile.isSex()?"1167457951671":"1167457972406")));
            if(profile.getAge()>0)
            out.println(profile.getAge()+r.getString(teasession._nLanguage,"1167463743062"));//岁
            out.print("）");

            java.util.Enumeration fbm_enumer=ApplyTable.findByMember(strMember,teasession._strCommunity);
            while(fbm_enumer.hasMoreElements())
            {
              ApplyTable at_obj=ApplyTable.find(((Integer)fbm_enumer.nextElement()).intValue());
              out.print("<a href=http://"+request.getServerName()+":"+request.getServerPort()+"/servlet/EditApplyTable?act=down&applytable="+at_obj.getApplytable()+" >"+at_obj.getName()+"</a>");
            }
            %>
            <BR>
            <BR>
            <%
            String strEmail=profile.getEmail();
            if(strEmail!=null&&strEmail.length()>0)
            {
              out.print("E-Mail&nbsp;&nbsp;：<A HREF=mailto:"+strEmail+">"+strEmail+"</A><BR>");
            }
            String strMobile=profile.getMobile();
            if(strMobile!=null&&strMobile.length()>0)
            {
              out.print(r.getString(teasession._nLanguage,"1167464081718")+"："+strMobile+"<BR>");//手&nbsp;&nbsp;&nbsp;&nbsp;机
            }
            String strtelephone=profile.getTelephone(langu);
            if(strtelephone!=null&&strtelephone.length()>3)
            {
              out.print(r.getString(teasession._nLanguage,"1167464153921")+"："+strtelephone+"<BR>");//电&nbsp;&nbsp;&nbsp;&nbsp;话
            }
            String straddress=profile.getAddress(langu);
            String getZip=profile.getZip(langu);
            if(getZip!=null&&getZip.length()>3)
            {
              getZip="("+getZip+")";
            }
            if(straddress!=null&&straddress.length()>0)
            {
              out.print(r.getString(teasession._nLanguage,"1167464200421")+"："+straddress+getZip+"<BR>");//通信地址
            }
            String school = profile.getSchool(langu);
            if(school != null || school.length() > 0){
              out.print(r.getString(langu,"毕业学校") + "：" + school + "<br>");
            }
            String getWebPage=profile.getWebPage(langu);
            if(getWebPage!=null&&getWebPage.length()>3)
            {
              out.print(r.getString(teasession._nLanguage,"1167464232843")+"：<A HREF="+getWebPage+">"+getWebPage+"</A><BR>");//个人主页
            }
//            String getCountry=profile.getState(langu);
//            if(getCountry!=null&&getCountry.length()>0)
//            {
//              out.print(r.getString(teasession._nLanguage,"1167464302546")+"："+getCountry+"<BR>");//国&nbsp;&nbsp;&nbsp;&nbsp;籍
//            }
            out.print(r.getString(teasession._nLanguage,"1167464346828")+"："+tea.htmlx.DegreeSelection.getDegree(profile.getDegree(teasession._nLanguage))+"<BR>");//教育程度
//            out.print(r.getString(teasession._nLanguage,"1167464377812")+"："+profile.getSchool(teasession._nLanguage)+"<BR>");//毕业学校
            //户口所在地：北京<BR>
            //政治面貌：群众<BR>

            %>
            <BR> </TD>
          <TD WIDTH="200">
            <TABLE WIDTH="116" HEIGHT="150" BORDER="0" ALIGN="center" CELLPADDING="0" CELLSPACING="1" BGCOLOR="#999999">
              <TR>
                <TD ALIGN="center" BGCOLOR="#FFFFFF">
                <%
                if(profile.getPhotopath(teasession._nLanguage)==null)
                {
                  //<IMG SRC="http:///images/template_zhaopian.gif">
                }else
                {
                  out.print("<img src=http://"+request.getServerName()+":"+request.getServerPort()+profile.getPhotopath(teasession._nLanguage)+" width=90 height=120 >");
                }
                %>
                </TD>
              </TR>
            </TABLE></TD>
        </TR>
      </TABLE>
      <%
      String getSelfValue=summary.getSelfvalue();
      String getSelfAim=summary.getSelfaim();
      if((getSelfValue!=null&&getSelfValue.length()>0)||(getSelfAim!=null&&getSelfAim.length()>0))
      {
    %>
    <TABLE WIDTH="100%" BORDER="0" CELLPADDING="3" CELLSPACING="0" CLASS="table">
      <TR>
        <TD style="background-color:#999999"><STRONG><a name="objective"></a><%=r.getString(teasession._nLanguage,"自我评价")%></STRONG></TD><!--自我评价/职业目标-->
      </TR>
    </TABLE>
    <TABLE WIDTH="585" BORDER="0" ALIGN="center" CELLPADDING="5" CELLSPACING="0">
    <%
    if(getSelfValue!=null&&getSelfValue.length()>0)
    {
      %>
      <TR>
        <TD WIDTH="130" VALIGN="top"><strong><%=r.getString(teasession._nLanguage,"1167464711468")%>：</strong><BR><!--自我评价-->
        </TD>
        <TD WIDTH="455"><%=getSelfValue%></TD>
      </TR>
      <%}if(getSelfAim!=null&&getSelfAim.length()>0){%>
      <TR>
        <TD VALIGN="top"><%=r.getString(teasession._nLanguage,"1167464750687")%>：</TD><!--职业目标-->
        <TD><%=getSelfAim%></TD>
      </TR>
      <% }%>
    </TABLE>
    <%}%>

    <%--语言能力--%>

      <TABLE WIDTH="100%" BORDER="0" CELLPADDING="3" CELLSPACING="0" CLASS="table">
      <TR>
        <TD style="background-color:#999999"><STRONG><a name="objective"></a><%=r.getString(teasession._nLanguage,"语言能力")%></STRONG></TD>
      </TR>
    </TABLE>
     <TABLE WIDTH="585" BORDER="0" ALIGN="center" CELLPADDING="5" CELLSPACING="0">

  <%
    java.util.Enumeration le =  Lang.find(teasession._nNode,teasession._nLanguage);
    for(int i = 1;le.hasMoreElements();i++)
    {
      int lid = ((Integer)le.nextElement()).intValue();
      Lang l = Lang.find(lid);

    %>
      <TR>
        <TD WIDTH="130" VALIGN="top"><strong><%=r.getString(teasession._nLanguage,"语言"+i)%>：</strong> </TD>
        <TD WIDTH="455"><%

        for(int j=0;j<Lang.SPRSL_TYPE.length;j++)
        {

          if(Lang.SPRSL_TYPE[j][0].equals(l.getSprsl()))
          out.print(  Lang.SPRSL_TYPE[j][1]);
        }
        %></TD>
          <TD WIDTH="130" VALIGN="top"><strong><%=r.getString(teasession._nLanguage,"熟练程度")%>：</strong> </TD>
           <TD WIDTH="455"><%
           for(int cs=0;cs<Lang.TYPE.length;cs++)
           {

             if(Lang.TYPE[cs][0].equals(l.getZtlnl())){

               out.print(Lang.TYPE[cs][1]);
             }
           }
           %></TD>
      </TR>

    <%}%>

    </TABLE>

     <!--职业概况-->
      <TABLE WIDTH="100%" BORDER="0" CELLPADDING="3" CELLSPACING="0" CLASS="table">
        <TR>
          <TD style="background-color:#999999"><STRONG><%=r.getString(teasession._nLanguage,"职业概况")%></STRONG></TD>
        </TR>
      </TABLE>
      <TABLE WIDTH="585" BORDER="0" ALIGN="center" CELLPADDING="5" CELLSPACING="0">
        <TR>
          <TD WIDTH="50%" VALIGN="top">
          <%
          //目前月薪（税前）
          //out.print("<TD VALIGN=top >"+r.getString(teasession._nLanguage,"1167465192609")+":"+summary.getSalarysum()+r.getString(teasession._nLanguage,"1167464858437")+"<br>");

          //现从事行业nowmaincareerCommon.ZCSZY[index][1]
          out.print("<STRONG>"+r.getString(teasession._nLanguage,"现从事行业")+":</STRONG> "+Common.ZCSZY[Integer.parseInt(summary.getNowmaincareer())-1][1]);
          out.print("<br>");

          //现职位级别nowcareerlevel
//          out.print("<STRONG>"+r.getString(teasession._nLanguage,"现职位级别")+":</STRONG> "+Common.ZZWJB[Integer.parseInt(summary.getNowcareerlevel())-1][1]);
//          out.print("<br>");

          //工作经验experience
          out.print("<STRONG>"+r.getString(teasession._nLanguage,"工作经验")+":</STRONG> "+summary.getExperience()+"年");
          out.print("<br>");

          //是否有海外工作经历hasabroad
          out.print("<STRONG>"+r.getString(teasession._nLanguage,"是否有海外工作经历")+":</STRONG> ");
          if(summary.isHasabroad())out.print("是");else{out.print("否");}
          out.print("<br>");
          %></TD>
        </TR>
      </TABLE>
    <!--教育背景-->




    <!--求职意向-->
      <TABLE WIDTH="100%" BORDER="0" CELLPADDING="3" CELLSPACING="0" CLASS="table">
        <TR>
          <TD style="background-color:#999999"><STRONG><%=r.getString(teasession._nLanguage,"1167464788390")%></STRONG></TD>
        </TR>
      </TABLE>
      <TABLE WIDTH="585" BORDER="0" ALIGN="center" CELLPADDING="5" CELLSPACING="0">
        <TR>
          <TD WIDTH="50%" VALIGN="top">

            <%
            //            <!--期望月薪（税前）-->                                                                       //元(人民币)
          String money = summary.getExpectsalarysum().toString();
            if(money.equals("0.00")){
            money = "面议";
            }
            out.print("<STRONG>"+r.getString(teasession._nLanguage,"1167464827921")+":</STRONG> "+money +"<BR>");
            //现从事职业
           // out.print(r.getString(teasession._nLanguage,"1167464954281")+":"+summary.getNowmaincareerToHtml());
            //意向工作性质
            String zqwgz= "";
            if(summary.getZqwgz()==1)
           zqwgz= "全职";
            else
            if((summary.getZqwgz())==2)
            zqwgz="兼职";
            else
            if((summary.getZqwgz())==3)
            zqwgz="临时";
            else
            if((summary.getZqwgz())==4)
            zqwgz="实习";
            out.print("<STRONG>"+r.getString(teasession._nLanguage,"1167465006453")+":</STRONG> "+zqwgz);
            out.print("<br>");
            //到岗时间
            String hTime= "";
            if(summary.getJoindatetype()==1)
            hTime = "面谈";
            else
            if((summary.getJoindatetype())==2)
           hTime = "立即";
            else
            if((summary.getJoindatetype())==3)
            hTime = "一周以内";
            else
            if((summary.getJoindatetype())==4)
            hTime = "一个月内";
            else
            if((summary.getJoindatetype())==5)
            hTime = "1~3个月";
            else
            hTime = "三个月后";
            out.print("<STRONG>"+r.getString(teasession._nLanguage,"1167465105562")+":</STRONG> "+hTime+"</TD>");

            //目前月薪（税前）
            //out.print("<TD VALIGN=top >"+r.getString(teasession._nLanguage,"1167465192609")+":"+summary.getSalarysum()+r.getString(teasession._nLanguage,"1167464858437")+"<br>");

            //期望从事职业
            out.print("<STRONG>"+r.getString(teasession._nLanguage,"1167460620765")+":</STRONG> "+summary.getExpectcareerToHtml());
            out.print("<br>");

            //期望工作地区
            out.print("<STRONG>"+r.getString(teasession._nLanguage,"1167460801234")+":</STRONG> "+summary.getExpectcityToHtml());
           out.print("<br>");
            %></TD>
        </TR>
      </TABLE>
      <!--工作经验-->
      <TABLE WIDTH="100%" BORDER="0" CELLPADDING="3" CELLSPACING="0" CLASS="table">
        <TR>
          <TD style="background-color:#999999"><STRONG ><a name="expdesc"></a><%=r.getString(teasession._nLanguage,"1167457783859")%></STRONG></TD>
        </TR>
      </TABLE>
      	<%
       int ecount= Employment.count(teasession._nNode,teasession._nLanguage);
        if(enumeration.hasMoreElements())
        {
          boolean sumbool=false;
          int id;
          for(int i2=1 ;enumeration.hasMoreElements();i2++)
          {
            id=((Integer)enumeration.nextElement()).intValue();
            Employment employment=Employment.find(id);
            %>
            <TABLE WIDTH="585" BORDER="0" ALIGN="center" CELLPADDING="5" CELLSPACING="0">
              <TR>
                <TD WIDTH="150" VALIGN="top"><%=employment.getStartDate("yyyy年MM月")%>--<%=employment.getEndDate("yyyy年MM月")%><BR> </TD>
                  <TD WIDTH="435" VALIGN="top">
                    <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
                      <TR>
                        <TD WIDTH="345"><STRONG>公司名称：</STRONG> <%=employment.getOrgName()%></TD>
                      </TR>
                      <TR>
                        <TD WIDTH="345"><STRONG> <%=r.getString(teasession._nLanguage,"1167465522578")%></STRONG><!--工作地点-->：<%=employment.getWorkSite()%> </TD>
                      </TR>
                      <TR>
                        <TD WIDTH="345"><STRONG> <%=r.getString(teasession._nLanguage,"所在部门")%></STRONG><!--所在部门tbDepartment-->：<%=employment.getDepartment()%> </TD>
                      </TR>
                      <TR>
                        <TD WIDTH="345"><STRONG>  <%=r.getString(teasession._nLanguage,"职位名称")%></STRONG>：<%=employment.getPositionName()%><%if(employment.getDepartment()!=null&&employment.getDepartment().length()>0)out.println("/"+employment.getDepartment());%>  </TD>
                      </TR>
                      <TR>
                        <TD WIDTH="345"><STRONG> <%=r.getString(teasession._nLanguage,"行业")%></STRONG><!--、-->：
                        <%
                        for(int j=0;j<Common.ZCSZY.length;j++)
                        {
                          if(Common.ZCSZY[j][0].equals(employment.getBranc())){
                            out.print(Common.ZCSZY[j][1]);
                          }
                        }
                        %>
                        </TD>
                      </TR>
                       <TR>
                        <TD WIDTH="345"><STRONG> <%=r.getString(teasession._nLanguage,"工作经历证明人")%></STRONG><!--工作经历证明人-->：<%=employment.getZzmr()%> </TD>
                      </TR>
                      <TR>
                        <TD WIDTH="345"><STRONG> <%=r.getString(teasession._nLanguage,"工作经历证明人联系方式")%></STRONG><!--工作经历证明人联系方式-->：<%=employment.getZzlxfs()%> </TD>
                      </TR>
                      <TR>
                        <TD WIDTH="345"><STRONG> <%=r.getString(teasession._nLanguage,"工作经历类型")%></STRONG><!--工作经历类型-->：<%=Employment.ZZJLLX_TYPE[employment.getZzjllx()]%> </TD>
                      </TR>
                        <TR>
                        <TD WIDTH="345"><STRONG> <%=r.getString(teasession._nLanguage,"用工类型")%></STRONG><!--用工类型-->：
                        <%
                        for(int jj=0;jj<Employment.ZZYGLX_TYPE.length;jj++)
                        {

                          if(Employment.ZZYGLX_TYPE[jj][0].equals(employment.getZzyglx())){

                            out.print(Employment.ZZYGLX_TYPE[jj][1]);
                          }
                        }
                        %> </TD>
                        </TR>
                    </TABLE>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" id=follow<%=id%> style="DISPLAY: none">
              <tr>
                <td><%=employment.getOrgInfo()%></td>
              </tr>
            </table>
             <BR>
                <%
                //工作职责和业绩：
                out.print("<strong>"+r.getString(teasession._nLanguage,"1167465545156")+"</strong>:"+employment.getFunction()+"<BR>");
                //离职/换岗原因：
                out.print("<strong>"+r.getString(teasession._nLanguage,"1167465612453")+"</strong>:"+employment.getReasonOfLeaving());

                %>
                  </TD>
              </TR>
            </TABLE>
            <%if(ecount!=i2){%>
<TABLE WIDTH="585" BORDER="0" ALIGN="center" CELLPADDING="0" CELLSPACING="0">
  <TR>
    <TD HEIGHT="1" BGCOLOR="#CCCCCC"><IMG WIDTH="1" HEIGHT="1"/></TD>
  </TR>
</TABLE><%
}}
}%>








   <%--  <TABLE WIDTH="100%" BORDER="0" CELLPADDING="3" CELLSPACING="0" CLASS="table">
        <TR>
          <TD><STRONG><IMG SRC="images/spacer.gif" WIDTH="8" HEIGHT="8"><a name="project"></a>项目管理经验</STRONG></TD>
        </TR>
      </TABLE>
      <TABLE WIDTH="585" BORDER="0" ALIGN="center" CELLPADDING="5" CELLSPACING="0">
        <TR>
          <TD WIDTH="130" VALIGN="top">1999/11 - 2000/04</TD>
          <TD WIDTH="455" VALIGN="top"> 项目名称：ABC公司ERP系统<BR>
            软件环境：Rational Rose, Power Design, Weblogic 8.1, Oracle8i<BR>
            硬件环境：SUN 服务器<BR>
            开发工具：Java, JSP, Power Design
            <P>项目描述：该项目是为ABC公司建立的ERP系统，其中包括了生产、物料管理、人力资源等6个子系统，共20个功能模块<BR>
              责任描述：客户需求调研；制定系统的需求规范；建立相应的商务需求和系统需求；和技术经理一起设计整个项目的各个功能模块；制定子系统的开发模型、测试方案和需求变更流程等；负责上线及交付事宜。</P></TD>
        </TR>
      </TABLE>--%>
      <!--教育培训-->
      <TABLE WIDTH="100%" BORDER="0" CELLPADDING="3" CELLSPACING="0" CLASS="table">
        <TR>
          <TD style="background-color:#999999"><STRONG><a name="education"></a><%=r.getString(teasession._nLanguage,"1167465882593")%></STRONG></TD>
        </TR>
      </TABLE>
      <%
      boolean boolspacer=false;
      int counted = Educate.count(teasession._nNode,teasession._nLanguage);
        for(int xi = 1;enumerationEducate.hasMoreElements();xi++)
        {
          Educate educateobj=Educate.find(((Integer)enumerationEducate.nextElement()).intValue());
          if(boolspacer)
          {%>
      <TABLE WIDTH="585" BORDER="0" ALIGN="center" CELLPADDING="0" CELLSPACING="0">
        <TR>
          <TD HEIGHT="1" BGCOLOR="#CCCCCC"><IMG WIDTH="1" HEIGHT="1"></TD>
        </TR>
      </TABLE>
      <%}%>
      <TABLE WIDTH="585" BORDER="0" ALIGN="center" CELLPADDING="5" CELLSPACING="0">
        <TR>
          <TD WIDTH="150" VALIGN="top"><%=educateobj.getStart("yyyy年MM月")%>--<%=educateobj.getStop("yyyy年MM月")%></TD>
          <TD WIDTH="435" VALIGN="top">
            <STRONG>学校名称：</STRONG>　  <%=educateobj.getSchool()%>　<br>
            <STRONG>专业类别：</STRONG><%=tea.htmlx.MajorSelection.MAJOR_TYPE[educateobj.getMajorCategory()]%>　<br>
            <STRONG>专业名称或研究方向：</STRONG><%if(educateobj.getMajorName()!=null)out.print(educateobj.getMajorName());%><br>
             <STRONG>第二专业名称：</STRONG><%if(educateobj.getZzzymc2()!=null)out.print(educateobj.getZzzymc2());%><br>
             <STRONG>学历：</STRONG><%if(educateobj.getZzzymc2()!=null)out.print(educateobj.getZzzymc2());%><br>

            <STRONG>学位：</STRONG>
            <%
           //zzxlbh
           if(educateobj.getZzxlbh()!=null){
             if("Z0".equals(educateobj.getZzxlbh()))
             {
               out.print("无学位");
             } else if("Z1".equals(educateobj.getZzxlbh()))
             {
               out.print("学士学位");
             } else if("Z2".equals(educateobj.getZzxlbh()))
             {
               out.print("双学士学位");
             }else if("Z3".equals(educateobj.getZzxlbh()))
             {
               out.print("硕士学位");
             }else if("Z4".equals(educateobj.getZzxlbh()))
             {
               out.print("博士学位");
             }
           }else
           {
             out.print("无学位");
           }
              %>
            <br>
             <STRONG>学历证书编号：</STRONG><%if(educateobj.getZzxlbh2()!=null)out.print(educateobj.getZzxlbh2());%><br>
             <STRONG>学历类型：</STRONG><%if(!educateobj.isZzjylx())out.print("在职教育");else{out.print("全日制");}%><br>
             <STRONG>学位授予时间：</STRONG><%if(educateobj.getZzxwsj()!=null)out.print(educateobj.getZzxwsjToString());%><br>
              <STRONG>学位授予机构：</STRONG><%if(educateobj.getZzjgdz()!=null)out.print(educateobj.getZzjgdz());%><br>
              <STRONG>学习形式：</STRONG><%
               for( int x=0;x<Educate.ZZXXXS_TYPE.length;x++)
               {
                 if(Educate.ZZXXXS_TYPE[x][0].equals(educateobj.getZzxxxs()))
                 {
                   out.print(educateobj.getZzxxxs());
                 }
               }
              %><br>
             <STRONG>最高学历：</STRONG><%if(!educateobj.isZzzgxl())out.print("否");else{out.print("是");}%><br>
             <STRONG>最高学位：</STRONG><%if(!educateobj.isZzzgxw())out.print("否");else{out.print("是");}%><br>
             <STRONG>专业描述：</STRONG><%=educateobj.getComment()%>
          </TD>
        </TR>
      </TABLE>
      <%
      boolspacer=true;
       if(counted!=xi){

         %>
         <TABLE WIDTH="585" BORDER="0" ALIGN="center" CELLPADDING="0" CELLSPACING="0">
           <TR>
             <TD HEIGHT="1" BGCOLOR="#CCCCCC"><IMG WIDTH="1" HEIGHT="1"/></TD>
           </TR>
         </TABLE>
         <%
         }
    }

   }%>


  <!--职业资格-->
       <TABLE WIDTH="100%" BORDER="0" CELLPADDING="3" CELLSPACING="0" CLASS="table">
        <TR>
          <TD style="background-color:#999999"><STRONG ><a name="expdesc"></a><%=r.getString(teasession._nLanguage,"职业资格")%></STRONG></TD>
        </TR>
      </TABLE>
<%
java.util.Enumeration enumeration=Professional.find(teasession._nNode,teasession._nLanguage);
int count =Professional.count(teasession._nNode,teasession._nLanguage);
for(int ii = 1;enumeration.hasMoreElements();ii++)
{
  int ids=((Integer)enumeration.nextElement()).intValue();
  Professional professionalobj=Professional.find(ids);

%>
 <TABLE WIDTH="585" BORDER="0" ALIGN="center" CELLPADDING="5" CELLSPACING="0">
   <TR>
     <TD WIDTH="150" VALIGN="top"><%=professionalobj.getBegdaToString()%>--<%=professionalobj.getEnddaToString()%></TD>
     <TD WIDTH="435" VALIGN="top">
       <STRONG>职业资格类别：</STRONG>
       <%
       for(int p=0;p<Professional.ZZGLB_TYPE.length;p++)
       {
         if(Professional.ZZGLB_TYPE[p][0].equals(professionalobj.getZzglb())){
           out.print(Professional.ZZGLB_TYPE[p][1]);
         }
       }
       %>
      <br>
      <STRONG >认证级别:</STRONG> <%out.print(Professional.ZRZJB_TYPE[professionalobj.getZrzjb()]);%><br />
 <STRONG >职业资格:</STRONG>  <%
    for(int p2=0;p2<Professional.ZZGDM1_TYPE.length;p2++)
    {
      if(Professional.ZZGDM1_TYPE[p2][0].equals(professionalobj.getZzgdm())){
        out.print(Professional.ZZGDM1_TYPE[p2][1]);
      }
    }
    %><br />
      <STRONG >发证单位:</STRONG><%if(professionalobj.getZfzdw()!=null)out.print(professionalobj.getZfzdw());%><br />
       <STRONG >取证时间:</STRONG><%if(professionalobj.getZqzsjToString()!=null)out.print(professionalobj.getZqzsjToString());%><br />
       <STRONG >证书编号:</STRONG><%if(professionalobj.getZzsbh()!=null)out.print(professionalobj.getZzsbh());%><br />
       <STRONG >鉴定单位:</STRONG><%if(professionalobj.getZjddw()!=null)out.print(professionalobj.getZjddw());%><br />
        <STRONG >取得资格途径:</STRONG> <%
    for(int P3=0;P3<Professional.ZQDZGTJ_TYPE.length;P3++)
    {

      if(Professional.ZQDZGTJ_TYPE[P3][0].equals(professionalobj.getZqdzgtj())){

        out.print(Professional.ZQDZGTJ_TYPE[P3][1]);
      }
    }
    %><br />
     <STRONG >备注:</STRONG><%if(professionalobj.getZqtbz()!=null)out.print(professionalobj.getZqtbz());%><br />
     </TD>
   </TR>
      </TABLE>

<%
if(count!=ii)
{
%>
<TABLE WIDTH="585" BORDER="0" ALIGN="center" CELLPADDING="0" CELLSPACING="0">
  <TR>
    <TD HEIGHT="1" BGCOLOR="#CCCCCC"><IMG WIDTH="1" HEIGHT="1"/></TD>
  </TR>
</TABLE>

<%} }%>
<center>
<input type="button" value="返回" onclick="window.history.back();"/>
</center>

</BODY>
</HTML>
