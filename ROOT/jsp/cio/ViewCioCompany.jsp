<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %><%@page import="java.net.*" %>
<%@ page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@ page import="tea.entity.cio.*" %><%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String menuid=request.getParameter("id");
String nexturl=request.getParameter("nexturl");

String member=teasession._rv._strV;
int ciocompany=Integer.parseInt(request.getParameter("ciocompany"));

CioCompany cc=CioCompany.find(ciocompany);
String name=cc.getName();
String contact=cc.getContact();
String tel=cc.getTel();
String mobile=cc.getMobile();
String email=cc.getEmail();
String remark=cc.getRemark();
String invoice=cc.getInvoice();

StringBuilder sql=new StringBuilder();


Resource r=new Resource();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="qiyelog">
<div id="qiyelog_01">
<div id="qiyelog_02">
<div id="title_01"></div>
<h1>参会报名表</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>

<h2>参会企业信息</h2>
<div id="qiy_xx">
<table border="0" cellpadding="0" cellspacing="0" id="qiy_xx_table">
  <tr>
    <td nowrap colspan="3">参会企业（集团）名称：<span id="table_tesspan"><%if(name!=null)out.print(name);%></span></td>
  </tr>
  <tr>
    <td id="td_01">参会联系人：<%if(contact!=null)out.print(contact);%></td>
    <td id="td_02">联系人电话：<%if(tel!=null)out.print(tel);%></td>
   <td id="td_03">&nbsp;</td>
  </tr>
  <tr>
     <td id="td_01">联系人手机：<%if(mobile!=null)out.print(mobile);%></td>
    <td id="td_02">E-Mail：<%if(email!=null)out.print(email);%></td>
	 <td id="td_03">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="3">本企业关心的问题：</td>
  </tr>
   <tr>
    <td colspan="3" >参会相关文件：<%=cc.getAttachToHtml()%></td>
  </tr>
   <tr>
    <td colspan="3" >开具发票单位名称：<%if(invoice!=null)out.print(invoice);%></td>
  </tr>
</table>
</div>

<h2>参会人员信息</h2>
<div id="canh_ry">
<table border='0' cellpadding='0' cellspacing='0' id='canh_ry_table'>
  <tr id='tableonetr'>
    <td>&nbsp;</td>
    <td>姓名</td>
    <td>职位</td>
    <td>部门</td>
    <td>手机</td>
  </tr>
<%
Enumeration e=CioPart.find(ciocompany,"",0,Integer.MAX_VALUE);
for(int i=1;e.hasMoreElements();i++)
{
  CioPart cp=(CioPart)e.nextElement();
  int cpid=cp.getCioPart();
  out.print("<tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor=''>");
  out.print("<td>"+i);
  out.print("<td>"+cp.getName());
  out.print("<td>"+cp.getJob());
  out.print("<td>"+cp.getDept());
  out.print("<td>"+cp.getMobile());
}
%>
</table>
</div>

<h2>问卷调查</h2>
<div id="wenj_dc">
<table id="wenj_dc_table">
  <tr id="wenj_dc_table_tr">
    <td>应用系统</td>
    <td>软件供应商</td>
    <td>软件性价比评价</td>
  </tr>
<%
CioPoll cp=CioPoll.find(ciocompany);
String choose[]=cp.getChoose();
int score[]=cp.getScore();
for(int i=0;i<CioPoll.CHOOSE_TYPE.length;i++)
{
  out.print("<tr><td>"+CioPoll.CHOOSE_TYPE[i]+"</td>");
  out.print("<td>");
  if(choose[i]!=null)out.print(choose[i]);
  out.print("<td>"+CioPoll.SCORE_TYPE[score[i]]);
}
%>
</table>
</div>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</div>
<div class="banq_xx">管理维护：国资委信息中心　　　　国资委地址：北京市宣武西大街26号（10053）京ICP备030066号</div>
</div>
</body>
</html>
