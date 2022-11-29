<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%r.add("/tea/resource/Hostel");
//session.setAttribute("ID","1");
int id=Integer.parseInt(request.getParameter("destine"));
int roomPriceId=Integer.parseInt(request.getParameter("roomprice"));
//session.removeAttribute("ID");
RoomPrice roomPrice=RoomPrice.find(roomPriceId);
Destine destine =Destine.find(id);
  java.text.DateFormat df = java.text.DateFormat.getDateInstance();
  Hostel hostel=Hostel.find(teasession._nNode,teasession._nLanguage);
%>
<html><head><TITLE>酒店预订</TITLE>
<META content="text/html; charset=UTF-8" http-equiv=content-type><LINK
href="img/gbcss.htm" rel=stylesheet type=text/css>
<BODY>



<CENTER>

<style type="text/css">
<!--
body,td{font-size:12px;}
select{font-size:12px;}
.topsys:link{color:#5CC3E6;text-decoration:none;}
.topsys:visited{color:#5CC3E6;text-decoration:none;}
.topsys:hover{color:white;text-decoration:none;}
.tabs1{border:1px #5A9FB5 solid;border-width:1 1 1 1}
.blulink{color:blue;}
.ptabcon{line-height:180%;margin-left:35px;margin-right:5px;margin-top:5px;margin-bottom:5px;}
.orderdh:link{color:#227E95;text-decoration:none;font-size:14px;}
.orderdh:visited{color:#227E95;text-decoration:none;font-size:14px;}
.orderdh:hover{color:#22afbb;text-decoration:underlinefont-size:14px;;}
.inputmodify{font-size:12px;border:1px #5A9FB5 solid;font-family:Arial;}
-->
</style>
<h1><%=r.getString(teasession._nLanguage, "Result")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
<center>
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><img SRC="/img/z.gif" width="1" height="1"></td>
    </tr>
  </table><br>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr>
            <td> &nbsp;<img SRC="/img/list_arrowright.gif" width="18" height="17" hspace="7" vspace="3" align="absmiddle"><strong><font color="#DF451C" style="font-size:14px;">提交成功 </font></strong>
			&nbsp;
	总计： <s>门市价RMB1032</s> <strong><font color="#DC441C"> e龙价RMB 720(省30%)
			</font></strong>

 成功入住后，我们会及时为您寄出会员卡，您将得到积分<font size="4" color="ff0000" face="Trebuchet MS">1220</font>分
			</td>
          </tr>
		  <tr>
            <td><img SRC="/img/z.gif" width="1" height="1"></td>
          </tr>
  </table>
<br>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td>　　订 单 号：<font color="#DF451C"><strong><%//=destine.getDestineCode()%></strong></font></td>
</tr>
<tr>
<td>　　入住客人：<%=destine.getHumanname(teasession._nLanguage)%> </td>
</tr>
<tr>
  <td>　　住宿日期：<%=(  destine.getKipdateToString())%> 至 <%=( destine.getLeavedateToString())%> </td>
</tr>
<tr>
<td>　　酒店名称：<%=hostel.getName()%> </td>
</tr>
<tr>
<td>　　房间类型：<%=roomPrice.getRoomtype(teasession._nLanguage)%> </td>
</tr>
<tr>
  <td>　　房间数量：<%=destine.getRoomcount()%> </td>
</tr>
<tr>
<td>　　付款方式：<%=r.getString(teasession._nLanguage,RoomPrice.PAYMENT[ destine.getPaymenttype()])%> </td>
</tr>
<tr>
<td>　　抵店时间：<%=destine.getEarlyarrive()%> 至 <%=destine.getEveningarrive()%></td>
</tr>
<tr>
<td>　　价 &nbsp; &nbsp;格：<%=roomPrice.getPrice(destine.getPaymenttype())%> </td>
</tr>
<tr>
<td>　　联 系 人：<%=destine.getLinkmanname(teasession._nLanguage)%> </td>
</tr>
<tr>
<td>　　联系电话：<%=destine.getLinkmanhandset()%> </td>
</tr>
<tr>
<td>　　E-mail： <%=destine.getLinkmanmail()%></td>
</tr>

</table>

<br><table border="0" cellpadding="0" cellspacing="0" id="tablecenter"><p style="color:#227E95;line-height:180%;letter-spacing:1px;margin:0 30 0 55;">如果您的计划有变动，如：不能按时入住酒店、取消预订、延长入住、提前退房等情况，请与预订中心<br>
          <strong><font color="#DF451C">(010-64329999,800-810-1010)</font></strong>联系。<br>
          <br>
          谢谢您选择e龙订房系统，祝您旅途愉快！<br>
          　
          <center>


<input type=button value=返回 onClick="window.open('/servlet/Node?node=<%=teasession.getParameter("Node")%>','_self')">
          </center>
        </p></td></tr></table>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><img SRC="/img/z.gif" width="1" height="1"></td>
    </tr>
  </table>
</center>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr><td><img src="img/trans.gif" width="1" height="1"></td></tr>
</table>
<!--
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr><td><hr width="773" size="1" noshade></td></tr>
</table>
-->
</CENTER>
<div id="head6"><img height="6" src="about:blank"></div>

</BODY></html>

