<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.cio.*" %><%@page import="tea.ui.TeaSession" %>
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
boolean flag=cc.isReceipt();

String title,type = request.getParameter("type");
if(type.equals("zs"))
{
  title="查看住宿安排";
  flag=flag&&cc.isRoom();
}else if(type.equals("seat"))
{
  title="查看座位安排";
  flag=flag&&cc.isSeat();
}else
{
  title="查看接送安排";
  flag=flag&&cc.isClerk();
}

if(!flag)
{
  response.sendRedirect("/jsp/cio/InfoCioCompany.jsp?alert="+java.net.URLEncoder.encode("您的信息正在安排中,暂时不能"+title,"UTF-8"));
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
  form1.ciopart.value=cpid;
  form1.submit();
}
</script>
</head>
<body id="qiyelog_05">

<h1><%=title%></h1>
<div id="tes_body02">
<div id="head6"><img height="6" src="about：blank"></div>
<br/>
<div id="div_001">
<%=cc.getName()%>,参会负责人您好：</div>
<div id="div_002">
您的企业于<%=cc.getTimeToString()%>提交参会报名表</br>
我们已确认了参会人员的行程信息,下面是安排好的人员
<%
if(type.equals("zs"))
  {
    out.print("住宿");
  }else if(type.equals("seat"))
  {
    out.print("座位");
  }else{
    out.print("接送");
  }
%>
情况!</div>

<h2>参会人员信息</h2>
<div id="canh_ry">
<table border='0' cellpadding='0' cellspacing='0' id='canh_ry_table'>
  <tr id='tableonetr'>
    <td>&nbsp;</td>
    <td>姓名</td>
    <%if(!type.equals("zs"))
    {
      out.print("<td>职位</td><td>部门</td>");
    }else
    {
      out.print("<td>酒店</td><td>房间</td><td>时间</td><td>状态</td>");
    }
    if(type.equals("seat"))
  {
    out.print("<td>手机号</td>");
    out.print("<td>座位号</td>");
  }
  if(type.equals("js"))
  {
    out.print("<td>接送人</td>");
    out.print("<td>接送人联系方式</td>");
  }
      %>
  </tr>
<%
StringBuffer sb=new StringBuffer();
if(type.equals("zs")){
  sb.append(" and cometime is not null");
}else if(type.equals("seat")){
  sb.append(" and seat=1");
}else{
  sb.append(" and shuttle=1");
}

Enumeration e=CioPart.find(ciocompany,sb.toString(),0,Integer.MAX_VALUE);;


for(int i=1;e.hasMoreElements();i++)
{
  CioPart cp=(CioPart)e.nextElement();
  int cpid=cp.getCioPart();
  String name=cp.getName()!=null?cp.getName():"";
int sr=CioSeatSet.seatRow(cpid);
int sc=CioSeatSet.seatCol(cpid);
CioClerk cck=CioClerk.find(cp.getCioClerkid());
  out.print("<tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor=''>");
  out.print("<td>"+i);//<input type=checkbox name='cioparts' value='"+cpid+"' >");
  out.print("<td>"+name);
  if(!type.equals("zs")){
    String job = "";
    if(cp.getJob()!=null)
    {
      job=cp.getJob();
    }
    String dept = "";
    if(cp.getDept()!=null)
    {
      dept=cp.getDept();
    }
    out.print("<td>"+job);
    out.print("<td>"+dept);
  }else{
    String rname=cp.getRname()!=null?cp.getRname():"";
    String rchamber=cp.getRchamber()!=null?cp.getRchamber():"";
    String cometime=cp.getComeTimeToString()!=null?cp.getComeTimeToString():"";
    String backroom=cp.getBackRoomToString()!=null?cp.getBackRoomToString():"";
    out.print("<td>"+rname);
    out.print("<td>"+rchamber);
    out.print("<td>"+cometime+"至"+backroom);
    out.print("<td>已预订");
  }
  if(type.equals("seat"))
  {
     String mobile = "";
    if(cp.getMobile()!=null)
    {
      mobile=cp.getMobile();
    }
    out.print("<td>"+mobile);
    out.print("<td>"+sr+"排"+sc+"号");
  }
  if(type.equals("js"))
  {
    String sname = "";
    if(cck.getSname()!=null)
    {
      sname=cck.getSname();
    }
    String stel = "";
    if(cck.getStel()!=null)
    {
      stel=cck.getStel();
    }
    out.print("<td>"+sname);
    out.print("<td>"+stel);
  }

}
%>
</table>
  <div  id="tablebottom_02">
以上
<%
if(type.equals("zs")){
  out.print("住宿");
}else if(type.equals("js")){
  out.print("接送");
}else
{
  out.print("座位");
}
%>
安排是根据您的行程信息进行的,如行程信息变更请及时联系！<br />
010-61392325<br />
注:请提前通知我们,以便于安排工作,谢谢！
  </div>
</div>
<%@include file="/jsp/include/Calendar2.jsp" %>
</div>
</body>
</html>
