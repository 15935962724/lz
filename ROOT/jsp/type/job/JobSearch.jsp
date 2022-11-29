<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%request.setCharacterEncoding("UTF-8"); %>
<%
TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
int hidden=0;
if(request.getParameter("hidden")!=null)
{
  hidden=Integer.parseInt(request.getParameter("hidden"));
}
tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Job");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<SCRIPT LANGUAGE="javascript">
function td_calendar(fieldname)
{
  eval(fieldname).value='';
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/tea/inc/calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
</SCRIPT>
</head>
<BODY >
<h1><%=r.getString(teasession._nLanguage, "1167449285390")%><!--职位搜索--></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<FORM NAME="form1" METHOD="get" action="/jsp/type/job/yjobjobmanage.jsp" >
  <input type="hidden" name="Node" value="<%=teasession._nNode%>" />
  <table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "UpdateTime")%><!--更新时间--></td>
      <td><%=r.getString(teasession._nLanguage, "1167449375109")%><!--从--><INPUT name="txtStartDate" readonly="readonly" type="text" size="10" MAXLENGTH="10"><input type=button value=...  onclick="javascript:td_calendar('form1.txtStartDate');">
        <%=r.getString(teasession._nLanguage, "1167449395890")%><!--至--><INPUT name="txtEndDate" readonly="readonly" type="text" size="10" MAXLENGTH="10"><input type=button value=... onclick="javascript:td_calendar('form1.txtEndDate');"></TD>
      </TR>
      <%--TR>
        <TD CLASS="funcbg">职业类别</TD>
      </TR>
      <TR>
        <TD><SELECT NAME="occid" style="WIDTH: 172px" ONCHANGE="javascript:SelectOption('Occupation',false, form1.sltOccId_BigClass,form1.sltOccId, '', '255', '--全部--');">
            <OPTION VALUE="">--请选择--</OPTION>
            <!--版本号：0002-->
            <!--Action:1-->
            <OPTION VALUE="600">计算机/互联网</OPTION>
            <OPTION VALUE="700">电子/电器/通信</OPTION>
            <OPTION VALUE="2700">电气/能源/动力</OPTION>
            <OPTION VALUE="3420">机械/仪器仪表</OPTION>
            <OPTION VALUE="100">销售</OPTION>
            <OPTION VALUE="604">项目管理</OPTION>
            <OPTION VALUE="900">客户服务</OPTION>
            <OPTION VALUE="3600">市场/广告/公关与媒介</OPTION>
            <OPTION VALUE="1200">经营管理</OPTION>
            <OPTION VALUE="2100">咨询顾问</OPTION>
            <OPTION VALUE="300">人力资源/行政/文职人员</OPTION>
            <OPTION VALUE="400">财务/审计/统计</OPTION>
            <OPTION VALUE="1013000">金融/经济</OPTION>
            <OPTION VALUE="1014000">贸易/物流/采购/运输</OPTION>
            <OPTION VALUE="702">建筑/房地产/装饰装修/物业管理</OPTION>
            <OPTION VALUE="1016001">翻译</OPTION>
            <OPTION VALUE="1017000">酒店/餐饮/旅游/运动休闲</OPTION>
            <OPTION VALUE="3400">工厂生产</OPTION>
            <OPTION VALUE="1019000">轻工</OPTION>
            <OPTION VALUE="1020000">商业零售</OPTION>
            <OPTION VALUE="3800">美术/设计/创意</OPTION>
            <OPTION VALUE="3500">文体/影视/写作/媒体</OPTION>
            <OPTION VALUE="1900">教育/培训</OPTION>
            <OPTION VALUE="1700">法律</OPTION>
            <OPTION VALUE="2000">医疗卫生/美容保健</OPTION>
            <OPTION VALUE="1026000">生物/制药/化工/环保</OPTION>
            <OPTION VALUE="800">科研</OPTION>
            <OPTION VALUE="3300">技工/服务类/后勤保障</OPTION>
            <OPTION VALUE="1029000">农林牧渔</OPTION>
            <OPTION VALUE="2600">公务员</OPTION>
            <OPTION VALUE="3700">培训生</OPTION>
            <OPTION VALUE="2500">在校学生</OPTION>
            <OPTION VALUE="1033000">其他</OPTION>
          </SELECT>
          <br/>
        </TD>
      </TR>
      <TR>
        <TD><SELECT name="sltOccId" style="WIDTH: 172px">
            <OPTION VALUE = "255">--全部--</OPTION>
            <Script language="javascript">SelectOption('Occupation',false, form1.sltOccId_BigClass,form1.sltOccId, '', '255', '--全部--');//处理后退时条件保存不住的问题</Script>
          </SELECT>
        </TD>
      </TR--%>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "1167449432921")%><!--所属机构--></td>
        <TD><SELECT STYLE="WIDTH: 172px" NAME="orgid">
             <OPTION VALUE="0">--------------------------------</OPTION>
            <%
            java.util.Enumeration enumeration=Job.findCompanyByMember(teasession._rv._strR,teasession._nNode,teasession._nLanguage);
            while(enumeration.hasMoreElements())
            {
              int node_id =((Integer)enumeration.nextElement()).intValue();
              String subject=Node.find(node_id).getSubject(teasession._nLanguage);
              if(subject!=null)
              {
                out.print("<option value="+node_id+" >"+subject);
              }
            }
            %>
          </SELECT>
        </TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "1167449457531")%><!--职位编号--></td>
        <TD><INPUT name="refcode" type="text" SIZE="10" MAXLENGTH="30">
        </TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "1167449482781")%><!--职位关键字--></TD>
        <TD><INPUT MAXLENGTH="60" size="40" NAME="keyword" >
        </TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "1167449503062")%><!--状态--></td>
        <TD><INPUT  id="radio" type="radio" NAME="hidden" value="0" CHECKED><%=r.getString(teasession._nLanguage, "1167449522921")%><!--招聘中-->
          <INPUT  id="radio" type="radio" NAME="hidden" VALUE="1" <%if(hidden==1)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, "1167450232359")%><!--未发布-->
        </TD>
      </TR>
      <TR>
        <TD colspan="2" align="center">
          <INPUT NAME="submit" TYPE="submit" value="<%=r.getString(teasession._nLanguage, "CBSubmit")%>" onclick="">
          <INPUT type=button value="<%=r.getString(teasession._nLanguage,"CBBack")%>" onclick="window.history.back();">
        </TD>
      </TR>
    </TABLE>
  </FORM>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</BODY>
</html>

