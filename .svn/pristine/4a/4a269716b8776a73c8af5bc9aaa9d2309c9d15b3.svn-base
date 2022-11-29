<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.cio.*" %><%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.member.*" %>
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

int ciopart = 0;
int ciocompany=0;
String ciop = request.getParameter("ciopart");
String tmp=request.getParameter("ciocompany");
if(ciop!= null)
{
  ciopart = Integer.parseInt(ciop);
}
if(tmp!=null)
{
  ciocompany=Integer.parseInt(tmp);
}
//else
//{
//  ciocompany=CioCompany.findByMember(member);
//  if(ciocompany<1)
//  {
//    response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("你不是代表","UTF-8"));
//    return;
//  }
//}


CioCompany cc=CioCompany.find(ciocompany);
String name=cc.getName();
String contact=cc.getContact();
String tel=cc.getTel();
String mobile=cc.getMobile();
String email=cc.getEmail();
String remark=cc.getRemark();
String[] attach1=cc.getAttach();


CioPart cp = CioPart.find(ciopart);
String cpmember=cp.getMember();
  Profile p=Profile.find(cpmember);
StringBuilder sql=new StringBuilder();

String tour = cp.getTourismToHtml();

Resource r=new Resource();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="qiyelog_05">

<h1>会员详细信息</h1>
<div id="tes_body">
<div id="head6"><img height="6" src="about：blank"></div>
<br/>

<h2>该会员企业信息</h2>
<div id="qiy_xx">
<table border="0" cellpadding="0" cellspacing="0" id="qiy_xx_table">
  <tr>
    <td  nowrap colspan="3">参会企业(集团)名称：<span id="table_tesspan"><%if(name!=null)out.print(name);%></td>
  </tr>
  <tr>
    <td id="td_01">参会联系人：<%if(contact!=null)out.print(contact);%></td>
    <td id="td_02" >联系人电话：<%if(tel!=null)out.print(tel);%></td>
  </tr>
  <tr>
    <td id="td_01">联系人手机：<%if(mobile!=null)out.print(mobile);%></td>
    <td id="td_02">E-Mail：<%if(email!=null)out.print(email);%></td>
  </tr>
  <tr>
    <td colspan="3">该企业关心的问题：<br/><%if(remark!=null)out.print(remark);%>
  </tr>
  <tr>
    <td>参会相关文件：</td>
    <td colspan="3">
      <%=cc.getAttachToHtml() %>
    </td>
  </tr>
</table>
</div>

<h2>参会人员信息</h2>
<div id="canh_ry">
<table border='0' cellpadding='0' cellspacing='0' id='canh_ry_table'>
  <tr>
  <td width="30%">代表号：</td><td><%=cp.getMember()%></td></tr>
    <tr><td>姓名：</td><td><%=cp.getName() %></td></tr>
    <tr><td>性别：</td><td><%=cp.isSex()?"男":"女" %></td></tr>
    <tr><td>职位：</td><td><%=cp.getJob() %></td></tr>
    <tr><td>手机：</td><td><%=cp.getMobile() %></td></tr>
    <tr><td>电话：</td><td><%=cp.getTel() %></td></tr>
    <tr><td>部门：</td><td><%=cp.getDept() %></td></tr>
    <tr><td>Email：</td><td><%=cp.getEmail() %></td></tr>
    <tr><td>传真：</td><td><%=cp.getFax() %></td></tr>
    <tr><td>地址：</td><td><%=cp.getAddress() %></td></tr>
    <tr><td>邮编：</td><td><%=cp.getZip() %></td></tr>
    <tr><td>是否发言：</td><td><%=cp.isTalk()?"是":"否" %></td></tr>
    <tr><td>观光意向：</td><td><%=tour %></td></tr>
    <tr><td>是否合住：</td><td><%=cp.isRoom()?"是":"否" %></td></tr>
    <tr><td>到达航班/车次：</td><td><%=cp.getComeTrain()!=null?cp.getComeTrain():"" %></td></tr>
    <tr><td>到港/到站日期：</td><td><%=cp.getComeTimeToString() %></td></tr>
    <tr><td>离店日期：</td><td><%=cp.getBackRoomToString() %></td></tr>
    <tr><td>返回航班/车次：</td><td><%=cp.getBackTrain()!=null?cp.getBackTrain():"" %></td></tr>
    <tr><td>返回日期：</td><td><%=cp.getBackTimeToString() %></td></tr>
    <tr><td>接送人姓名：</td><td><%=cp.getCioClerkid()%></td></tr>
    <tr><td>接送人电话：</td><td><%=cp.getSTel()==null?"":cp.getSTel() %></td></tr>
    <tr><td>是否报到：</td><td><%=cp.isBd()?"已报到":"未报到" %></td></tr>
    <tr><td>会员级别：</td><td><%=cp.isVip()?"VIP":"普通" %></td></tr>
    <tr><td>酒店名：</td><td><%=cp.getRname()==null?"":cp.getRname() %></td></tr>
    <tr><td>房型：</td><td><%=cp.getRchamber()==null?"":cp.getRchamber() %></td></tr>
    <tr><td>入住时间：</td><td><%if(cp.getRstime()==null){out.print("");}else{out.print(cp.getRstimeToString());} %></td></tr>
    <tr><td>退房时间：</td><td><%if(cp.getRetime()==null){out.print("");}else{out.print(cp.getRetimeToString());} %></td></tr>
    <tr><td>密码：</td><td><%=p.getPassword() %></td></tr>


</table>
</div>
<div>
<input type="button" value="返回" onclick="history.back();"/>
</div>
<br>
<div id="head6"><img height="6" src="about：blank"></div>
</div>
</body>
</html>
