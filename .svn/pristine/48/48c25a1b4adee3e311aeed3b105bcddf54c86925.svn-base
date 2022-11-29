<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.cio.*" %><%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.site.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String nexturl=request.getParameter("nexturl");
if(nexturl==null)
{
  nexturl=request.getRequestURI()+"?"+request.getQueryString();
}
String member=teasession._rv._strV;

String menuid=request.getParameter("id");

int ciocompany=0;
String tmp=request.getParameter("ciocompany");
if(tmp!=null)
{
  ciocompany=Integer.parseInt(tmp);
}else
{
  ciocompany=CioCompany.findByMember(member);
  if(ciocompany<1)
  {
    response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("你不是代表","UTF-8"));
    return;
  }
}

CioCompany cc=CioCompany.find(ciocompany);

CommunityOption co = new CommunityOption(teasession._strCommunity);
Date stoptime=co.getDate("ciostoptime");
if(!cc.isSpecial()&&(stoptime!=null&&System.currentTimeMillis()<stoptime.getTime()))//特殊企业或截止日期未到
{
  response.sendRedirect("/jsp/cio/InfoCioCompany.jsp?alert="+java.net.URLEncoder.encode("报名的截止日期,您不能修改行程信息了","UTF-8"));
  return;
}

int ciopart=0;
tmp=request.getParameter("ciopart");
if(tmp!=null)
{
  ciopart=Integer.parseInt(tmp);
}

Resource r=new Resource();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function f_edit(cpid)
{
  form1.action="?";
  form1.method="get";
  form1.ciopart.value=cpid;
  form1.submit();
}
</script>
</head>
<body id="qiyelog_05">
<h1>补充人员行程信息</h1>
<div id="tes_body02">
<div id="head6"><img height="6" src="about：blank"></div>
<br/>
<div id="div_001">
<%=cc.getName()%>,参会负责人您好：</div>
<div id="div_002">
您的企业于<%=cc.getTimeToString()%>提交参会报名表</br>
我们已确认了报名信息,请及时提交参会人员的行程信息,以便我们安排接送服务!</div>


<form name="form1" action="/servlet/EditCioPart" method="post" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="ciocompany" value="<%=ciocompany%>"/>
<input type="hidden" name="ciopart" value="<%=ciopart%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="act" value="trip"/>

<h2>参会人员信息</h2>
<div id="canh_ry">
<table border='0' cellpadding='0' cellspacing='0' id='canh_ry_table'>
  <tr id='tableonetr'>
    <td>序号</td>
    <td>姓名</td>
    <td>职位</td>
    <td>部门</td>
    <td>手机</td>
    <td>操作</td>
  </tr>
<%
StringBuffer sb=new StringBuffer();
Enumeration e=CioPart.find(ciocompany,"",0,Integer.MAX_VALUE);
for(int i=1;e.hasMoreElements();i++)
{
  CioPart cp=(CioPart)e.nextElement();
  int cpid=cp.getCioPart();
  String name=cp.getName();
  if(ciopart<1||ciopart==cpid)
  {
    Date cometime=cp.getComeTime();
    out.print("<tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor=''>");
    out.print("<td>"+i);//<input type=checkbox name='cioparts' value='"+cpid+"' >");
    out.print("<td>"+name);
    out.print("<td>"+cp.getJob());
    out.print("<td>"+cp.getDept());
    out.print("<td>"+cp.getMobile());
    out.print("<td>");
    if(ciopart==cpid)
    {
      out.print("编辑中...");
    }else
    {
      out.print("<a href='javascript:f_edit("+cpid+")'>"+(cometime==null?"添加":"编辑")+"行程</a>");
    }
  }
  if(ciopart!=cpid)
  {
    sb.append(" <input name='ciopart' type='checkbox' value='"+cpid+"'>").append(name);
  }
}
%>
</table>

<%
if(ciopart>0)
{
  CioPart cp=CioPart.find(ciopart);
  String name=cp.getName();
  String cometrain=cp.getComeTrain();
  String backroom=cp.getComeTimeToString();
  String cometime=cp.getComeTimeToString();
  String backtrain=cp.getBackTrain();
  String backtime=cp.getBackTimeToString();
  int cth=cp.getComeTimeH();
  int ctm=cp.getComeTimeM();
  int bth=cp.getBackTimeH();
  int btm=cp.getBackTimeM();
  %>
  <table  id='canh_ry_table_bottom'>
    <tr>
      <td nowrap>到达航班/车次：</td>
      <td><input type="text" name="cometrain" value="<%if(cometrain!=null)out.print(cometrain);%>"/></td>
        <td nowrap>退房日期：</td>
        <td><input type="text" name="backroom" readonly="readonly" onClick="showCalendar(this)" value="<%if(backroom!=null)out.print(backroom);%>"/></td>
    </tr>
    <tr>
      <td nowrap>到港/到站日期：</td>
      <td><input type="text" name="cometime" readonly="readonly" onClick="showCalendar(this)" value="<%if(cometime!=null)out.print(cometime);%>"/></td>
        <td nowrap>返回航班/车次：</td>
        <td><input type="text" name="backtrain" value="<%if(backtrain!=null)out.print(backtrain);%>"/></td>
    </tr>
    <tr>
      <td nowrap>到港/到站时刻：</td>
      <td>
        <%
        out.print("<select name='cth'>");
        for(int i=0;i<24;i++)
        {
          out.print("<option value="+i);
          if(i==cth)out.print(" selected=''");
          out.print(">"+i);
        }
        out.print("</select>时");
        out.print("<select name='ctm'>");
        for(int i=0;i<60;i=i+10)
        {
          out.print("<option value="+i);
          if(i==ctm)out.print(" selected=''");
          out.print(">"+i);
        }
        out.print("</select>分");
        %>
      </td>
      <td nowrap>离港/发车时间：</td>
      <td>
      <%
      out.print("<select name='bth'>");
      for(int i=0;i<24;i++)
      {
        out.print("<option value="+i);
        if(i==bth)out.print(" selected=''");
        out.print(">"+i);
      }
      out.print("</select>时");
      out.print("<select name='btm'>");
      for(int i=0;i<60;i=i+10)
      {
        out.print("<option value="+i);
        if(i==btm)out.print(" selected=''");
        out.print(">"+i);
      }
      out.print("</select>分");
      %>
      </td>
    </tr>
    <tr>
      <td>和<%=name%>同路的有：</td>
      <td colspan="3"><%=sb.toString()%></td>
    </tr>
  </table>

<input type="submit" value="提交" onClick="return submitText(form1.cometrain,'无效-到达航班/车次')&&submitText(form1.backroom,'无效-退房日期')&&submitText(form1.cometime,'无效-到港/到站日期')&&submitText(form1.backtrain,'无效-返回航班/车次')&&submitText(form1.backtime,'无效-离港/发车时间');"/>
<input type="button" value="返回" onClick="history.back();"/>
<%  }%>
</form>
</div>
<%@include file="/jsp/include/Calendar2.jsp" %>
</div>
</body>
</html>
