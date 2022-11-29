<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.db.*" %>
<%

request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
Community community =Community.find(teasession._strCommunity);
StringBuffer sql=new StringBuffer();
//sql.append(" AND nodeid IN (SELECT node FROM Node )");
//StringBuffer par=new StringBuffer("?");
String memberid=request.getParameter("memberid");
if(memberid!=null&&memberid.length()>0)
{
  sql.append(" AND  memberid LIKE ").append(DbAdapter.cite(memberid));
 // par.append("&memberid=").append(java.net.URLEncoder.encode(memberid,"UTF-8"));
}
int pos1=0,pos2=0,size=20;
String tmp=request.getParameter("pos1");
if(tmp!=null)
{
  pos1=Integer.parseInt(tmp);
}
tmp=request.getParameter("pos2");
if(tmp!=null)
{
  pos2=Integer.parseInt(tmp);
}
int count1=Hotel_application.count(sql.toString()+" AND audit=0");
int count2=Hotel_application.count(sql.toString()+" AND audit=1");
java.util.Enumeration e1=Hotel_application.find(sql.toString()+" AND audit=0",pos1,size);
java.util.Enumeration e2=Hotel_application.find(sql.toString()+" AND audit=1",pos2,size);
%>
<html>
<head>
<link  href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script language="javascript" src="calendar1/calendar.js" type="text/javascript"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js" type=""></script>
<script  language="javascript" type="">
function ShowCalendar(fieldname)
{
 window.showModalDialog("/jsp/registration/Calendar2.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+200+"px;dialogLeft:"+300+"px");
}
</script>
<title>audits</title>
</head>
<body>
<h1>代用户进行预定房间</h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<h2>入住信息</h2>
<form name="form1" action="/jsp/registration/Editaudits.jsp">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td><label>房间数量：</label></td>
<td>
<select name="roomnum">
<option value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
</select>※
</td>
</tr>
<tr>
<td><label>入住人数：</label>
</td>
<td>
<select name="person">
<option value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
</select>※
</td>
</tr>
<tr>
<td>
<label>会员ID：</label>
</td>
<td><form action="">
  <input type="text" name="memberid"/><input type="button" value="查询" /><input type="checkbox" value="" name="newmember"/><label>生成新会员</label>
</form></td>
</tr>
<tr>
<td><label>入住人：</label></td>
<td><input type="text" name="liveperson" /></td><!--入住人-->
</tr>
<tr>
<td><label>手机号码：</label></td>
<td><input type="text" name="mobile"/>※&nbsp;&nbsp;&nbsp;如果没有手机，请留下座机号码：<input type="text" name="telephone"/></td>
</tr>
<tr>
<td><label>房间类型：</label></td>
<td><label><% %></label></td>
</tr>
<tr>
<td><label>住店日期：</label></td>

<td><input name="indata" type="text"/>&nbsp;&nbsp;&nbsp;
<input name="checkInDate" value="2008-01-29" size="15" readonly>
<a href="javascript:ShowCalendar('form1.indata')" target="_self">
<img id="dimg3" style="POSITION: relative" src="/tea/image/public/Calendar.gif" border="0" align="middle" alt=""></a> 　　
&nbsp;&nbsp;&nbsp;
<label>离开日期:</label>
<input type="text" name="outdata"/>※
<a href="javascript:ShowCalendar('form1.outdata')" target="_self">
<img id="dimg3" style="POSITION: relative" src="/tea/image/public/Calendar.gif" border="0" align="middle" alt=""></a>
</td>　　
</tr>
<tr>
<td><label>最早到达时间：</label></td>
<td><select name="earlytime">
<%int i = 1;
while(i>24) {%>
  <option value="<%=i%>:00"><%=i%>:00</option>
  <%i++;} %>
</select>※</td>
</tr>
<tr>
<td><label>最晚到达时间：</label></td>
<td><select name="latertime">
<%int j = 1;
while(j>24) {%>
  <option value="<%=j%>:00"><%=j%>:00</option>
  <%j++;} %>
</select>※</td>
</tr>
<tr>
<td><label>付款类型：</label></td>
<td><select name="type">
<option value="0">门市价 ※</option>
</select></td>
</tr>
</table>
<h2>联系人信息</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
 <td><input type="checkbox" name="contactinfo"/>&nbsp;&nbsp;&nbsp;<label>与入住人相同</label></td>
</tr>
<tr>
<td>联系人姓名：</td>
<td><input type="text" name="contactname" />※</td>
</tr>
 <tr>
<td>性别：</td>
<td><!--需要修改的地方之一-->
<input type="radio" name="sex" value="1" id="gender_0"/>
<label for="gender_0"> 男</label>
<input type="radio" name="sex" value="0" id="gender_1" />
<label for="gender_1">女</label>
</td>
</tr>
 <tr>
<td>手机号码：</td>
<td><input type="text" name="mobile" />※&nbsp;&nbsp;&nbsp;如果没有手机，请留下座机号码：<input type="text" name="telephone" /></td>
</tr>
<tr>
<td>电子邮件：</td>
<td> <input type="text" name="email" />※</td>
</tr>
<tr>
<td>传真：</td>
<td> <input type="text" name="fax" />※</td>
</tr>
<tr>
<td>确认方式：</td>
<td><select>
<option value="SMS">使用短信来确认</option>
</select>※</td>
</tr>
</table>
<h2>其他信息</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td colspan="2">当您成功入住酒店后，我们会按照您填写的邮编地址，在15天内给您邮寄一张""及最新商旅手册. </td>
</tr>
<tr>
<td colspan="2"><input type="checkbox" name="need"/><label>我需要（注：如果您需要寄卡，请确保您填写的会员注册信息是真实的，我们会按此邮寄。）</label></td>
</tr>
 <tr>
 <td><label>邮政编码：</label></td>
<td><input name="postcode" type="text"/></td>
</tr>
  <tr>
 <td><label>通讯地址：</label></td>
<td><input name="postaddress" type="text"/></td>
</tr>

  <tr>
 <td><label>特殊要求：</label></td>
<td><textarea cols="20" rows="5"></textarea><label>最多255个字符</label></td>
</tr>

  <tr>
 <td><label>加床数量：</label></td>
<td><input name="addbed" type="text"/>&nbsp;&nbsp;<label>如您在最晚到店时间以后到店，请及时与我们联系.</label></td>
</tr>
<tr>
  <td colspan="5" align="left">
 <%//=new tea.htmlx.FPNL(teasession._nLanguage,par.toString()+"&pos2=",pos2,count2,size)%>
  </td>
</tr>
<tr>
<td colspan="2" align="center"><input type="submit" value=" 提 交 " /></td>
</tr>
</table>
</body>
</html>
