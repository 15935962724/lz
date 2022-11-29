<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.cio.*" %><%@page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

int ciocompany=Integer.parseInt(request.getParameter("ciocompany"));

TeaSession teasession=new TeaSession(request);
if(ciocompany>0&&teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String nexturl=request.getParameter("nexturl");
if(nexturl==null)
{
  nexturl=request.getRequestURI()+"?"+request.getQueryString();
}

StringBuilder sql=new StringBuilder();

boolean central=false;
if(ciocompany>0)
{
  CioCompany cc=CioCompany.find(ciocompany);
  central=cc.isCentral();
}

String act=request.getParameter("act");
if(act==null)act="edit";

int ciopart=Integer.parseInt(request.getParameter("ciopart"));
boolean sex=true,talk=false,room=false,shuttle=true;
String name=null,job=null,mobile=null,tel=null,dept=null,email=null,fax=null,address=null,zip=null,tourism=null;
String cometrain=null,backtrain=null,cometime=null,backroom=null;
int cth=13,ctm=0,bth=9,btm=0;
if(ciopart>0)
{
  CioPart cp=CioPart.find(ciopart);
  name=cp.getName();
  sex=cp.isSex();
  job=cp.getJob();
  mobile=cp.getMobile();
  tel=cp.getTel();
  dept=cp.getDept();
  email=cp.getEmail();
  fax=cp.getFax();
  address=cp.getAddress();
  zip=cp.getZip();
  talk=cp.isTalk();
  tourism=cp.getTourism();
  room=cp.isRoom();
  shuttle=cp.isShuttle();
  /////////
  cometrain=cp.getComeTrain();
  backtrain=cp.getBackTrain();
  cometime=cp.getComeTimeToString();
  backroom=cp.getBackRoomToString();
  cth=cp.getComeTimeH();
  ctm=cp.getComeTimeM();
  bth=cp.getBackTimeH();
  btm=cp.getBackTimeM();
  //sql.append(" AND ciopart=").append(ciopart);
}


Resource r=new Resource();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function f_action(act,id)
{
  switch(act)
  {
    case "trip":
    case "edit":
    form1.action="?";
    form1.method="get";
    break;
    case "delete":
    if(!confirm("确认删除?"))
    {
      return;
    }
    break;
  }
  form1.ciopart.value=id;
  form1.act.value=act;
  form1.submit();
}
function f_submit()
{
  return submitText(form1.name,'无效-姓名')&&submitText(form1.job,'无效-职务')&&submitText(form1.mobile,'无效-手机')&&submitText(form1.tel,'无效-电话')&&submitText(form1.dept,'无效-部门或子企业')&&submitEmail(form1.email,'无效-E-Mail')&&submitText(form1.fax,'无效-传真')&&submitText(form1.address,'无效-通信地址')&&submitText(form1.zip,'无效-邮编');
}
var ifcp=parent.document.getElementById("ifcp");
</script>
</head>
<body  id="qiyelog2">


<form name="form1" action="/servlet/EditCioPart" method="post">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="ciocompany" value="<%=ciocompany%>"/>
<input type="hidden" name="ciopart" value="<%=ciopart%>"/>
<input type="hidden" name="act" value="<%=act%>"/>
<div class="canhbm_xx">请逐个登记本企业参会信息</div>
<table border='0' cellpadding='0' cellspacing='0' id='canh_ry_table'>
  <tr id='tableonetr'>
    <td>&nbsp;</td>
    <td>姓名</td>
    <td>职位</td>
    <td>部门</td>
    <td>手机</td>
    <td>&nbsp;</td>
  </tr>
<%
StringBuilder sb=new StringBuilder();
Enumeration e=CioPart.find(ciocompany,sql.toString(),0,Integer.MAX_VALUE);
for(int i=0;e.hasMoreElements();)
{
  CioPart cp=(CioPart)e.nextElement();
  int cpid=cp.getCioPart();
  String cpname=cp.getName();
  Date cpcometime=cp.getComeTime();
  if(ciopart==0||ciopart==cpid)
  {
    out.print("<tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor=''>");
    out.print("<td>"+(i+1));
    out.print("<td>"+cpname);
    out.print("<td>"+cp.getJob());
    out.print("<td>"+cp.getDept());
    out.print("<td>"+cp.getMobile());
    out.print("<td>");
    if(ciopart==cpid)
    {
      out.print("正在编辑中...");
    }else
    {
      out.print("<a href=javascript:f_action('trip',"+cpid+")>"+(cpcometime==null?"添加":"编辑")+"行程</a> <a href=javascript:f_action('edit',"+cpid+")>修改</a> <a href=javascript:f_action('delete',"+cpid+")>删除</a>");
    }
    out.print("<script>ifcp.height=330+"+(i*22)+";</script>");
    i++;
  }else
  {
    sb.append("<input type='checkbox' name='ciopart' value='"+cpid+"' >").append(cpname).append("　");
  }
}
%>
</table>
<%
if("trip".equals(act))
{
%>
<table id="canh_ry_table22">
  <tr>
    <td>到达航班/车次：</td>
    <td><input type="text" name="cometrain" value="<%if(cometrain!=null)out.print(cometrain);%>"></td>
      <td>返回航班/车次：</td>
      <td><input type="text" name="backtrain" value="<%if(backtrain!=null)out.print(backtrain);%>"></td>
  </tr>
  <tr>
    <td>到港/到站日期：</td>
    <td><input type="text" name="cometime" onClick="showCalendar(this,-50)" readonly="readonly" value="<%if(cometime!=null)out.print(cometime);%>"></td>
      <td>退房日期：</td>
      <td><input type="text" name="backroom" onClick="showCalendar(this,-50)" readonly="readonly" value="<%if(backroom!=null)out.print(backroom);%>"></td>
  </tr>
  <tr>
    <td>到港/到站时刻：</td>
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
    <td>离港/发车时间：</td>
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
<%
if(sb.length()>0)
{
  out.print("<tr><td>与<b>"+name+"</b>同路的有</td><td>"+sb.toString()+"</td></tr>");
}
%>
</table>
<input type='submit' name='edit' class='buttonclass' value='确认修改'>
<input type='button' class='buttonclass' onclick='window.history.back();' value='返回'>

<%
}else
{
%>


<table border="0" cellpadding="0" cellspacing="0" id="canh_ry_table22">
  <tr>
    <td nowrap>姓名：</td>
    <td nowrap><input type="text" name="name" value="<%if(name!=null)out.print(name);%>">&nbsp;*</td>
      <td nowrap>性别：</td>
      <td nowrap>
        <select name="sex">
          <option value="true" selected="selected">先生</option>
          <option value="false" <%if(!sex)out.print("selected='selected'");%>>女士</option>
        </select>&nbsp;*
      </td>
  </tr>
  <tr>
    <td>职务：</td>
    <td><input type="text" name="job" value="<%if(job!=null)out.print(job);%>">&nbsp;*</td>
      <td>手机：</td>
      <td><input type="text" name="mobile" value="<%if(mobile!=null)out.print(mobile);%>" mask="int">&nbsp;*</td>
  </tr>
  <tr>
    <td>电话：</td>
    <td><input type="text" name="tel" value="<%if(tel!=null)out.print(tel);%>" mask="tel">&nbsp;*</td>
      <td>部门或子企业：</td>
      <td><input type="text" name="dept" value="<%if(dept!=null)out.print(dept);%>">&nbsp;*</td>
  </tr>
  <tr>
    <td>E-Mail：</td>
    <td><input type="text" name="email" class="email" value="<%if(email!=null)out.print(email);%>">&nbsp;*</td>
    <td>传真：</td>
    <td><input type="text" name="fax" value="<%if(fax!=null)out.print(fax);%>" mask="tel">&nbsp;*</td>
  </tr>
  <tr>
    <td>通信地址：</td>
    <td><input type="text" name="address" class="address" value="<%if(address!=null)out.print(address);%>">&nbsp;*</td>
      <td>邮编：</td>
      <td><input type="text" name="zip" value="<%if(zip!=null)out.print(zip);%>" mask="int">&nbsp;*</td>
  </tr>
  <tr>
<td colspan="10">
<%
if(!central)
{
  out.print("是否发言：");
  out.print("<select name='talk'><option value='true' selected='selected'>是</option><option value='false' ");
  if(!talk)out.print("selected='selected'");
  out.print(">否</option></select>&nbsp;*　");
}
out.print("参观意向：");
for(int i=1;i<CioPart.TOURISM_TYPE.length;i++)
{
  out.print("<input type='checkbox' name='tourism' value='"+i+"'");
  if(tourism!=null&&tourism.indexOf("/"+i+"/")!=-1)
  {
    out.print(" checked='true' ");
  }
  out.print(" />"+CioPart.TOURISM_TYPE[i]+" ");
}
%>
</td>
  </tr>
<tr>
  <td colspan="10">是否合住：<select name="room">
    <option value="true" selected="selected">合</option>
    <option value="false" <%if(!room)out.print("selected='selected'");%>>单</option>
  </select>&nbsp;*　　是否需要接机：<select name="shuttle">
    <option value="true" selected="selected">是</option>
    <option value="false" <%if(!shuttle)out.print("selected='selected'");%>>否</option>
  </select>&nbsp;*
   </td>
  </tr>
</table>
<input type="submit" name="add" class="buttonclass" value="作为新记录添加" onClick="return f_submit();"/>
<%
if(ciopart>0)
{
  out.print("<input type='submit' name='edit' class='buttonclass' value='确认修改' onclick='return f_submit();'> ");
  out.print("<input type='button' class='buttonclass' onclick='window.history.back();' value='返回'>");
}

}
%>


</form>
<%@include file="/jsp/include/Calendar2.jsp" %>
</body>
</html>
