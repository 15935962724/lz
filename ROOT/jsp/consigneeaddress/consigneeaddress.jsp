<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.admin.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	TeaSession teasession = new TeaSession(request);

	if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?Node="+teasession._nNode);
  return;
}

	Resource r = new Resource("/tea/ui/member/offer/ShoppingCarts");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>



<html>
	<head>
		<base href="<%=basePath%>">
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/card.js"></SCRIPT>
		<script src="jsp/consigneeaddress/consigneevalidateform.js"></script>
	    <style type="text/css">
<!--
.STYLE1 {font-size: 12px}
.STYLE5 {font-size: 12px; color: #666666; font-weight: bold; }
-->
        </style>
</head>
	<body id="bodynone">
	<div id="lzj_dz">
		<%

		boolean panduan=true;
		boolean update=false;
		ConsigneeAddress cons=null;
			String type = teasession.getParameter("type");
			if (type != null && type.length() == 1) {

				switch (Integer.parseInt(type)) {
				case 0:
					if (ConsigneeAddress.create(teasession
					.getParameter("username"), teasession
					.getParameter("consignee"), teasession
					.getParameter("nowarea"), teasession
					.getParameter("streetaddress"), teasession
					.getParameter("postcode"), teasession
					.getParameter("homephone"), teasession
					.getParameter("phone"))) {
		%>
		<h2>
			添加成功
		</h2>
		<%
		} else {
		%>
		<h2>
			添加失败
		</h2>
		<%
					}
					break;
				case 1:
				update=true;
				cons=ConsigneeAddress.load(teasession.getParameter("id"));
				break;
				case 2:
					if (ConsigneeAddress.del(teasession.getParameter("id"))) {
		%>
		<h2>
			删除成功
		</h2>
		<%
		} else {
		%>
		<h2>
			删除失败
		</h2>
		<%
					}
					break;
				case 3:
					ConsigneeAddress.setOne(teasession.getParameter("id"),
					teasession._rv._strR);
					break;
					case 4:
						if (ConsigneeAddress.set(teasession
					.getParameter("consigneeid"), teasession
					.getParameter("consignee"), teasession
					.getParameter("nowarea"), teasession
					.getParameter("streetaddress"), teasession
					.getParameter("postcode"), teasession
					.getParameter("homephone"), teasession
					.getParameter("phone"))) {
		%>
		<h2>
			修改成功
		</h2>
		<%
		} else {
		%>
		<h2>
			修改失败
		</h2>
		<%
					}

					break;

				}
			}


			panduan=ConsigneeAddress.getCount(teasession._rv._strR);
		%>



		<div style="font-size:14px; font-weight:bold; margin:20px auto;">设置收货地址<span style=" font-style:normal; font-size:12px; font-weight:300; margin-left:10px;">您可预设您的购物收货地址</span></div>
	<table align="center" cellpadding="5"
			cellspacing="0" class="steptb" border="0" style="font-size:12px;">
			<tr>
				<th scope="col" width="11%" height="20" align="center" class="shouhuo">收货人</th>
				<th scope="col" width="17%" height="20" align="center" class="shouhuo">所在地区</th>
				<th scope="col" width="33%" height="20" align="center" class="shouhuo">街道地址</th>
				<th scope="col" width="10%" height="20" align="center" class="shouhuo">邮编</th>
				<th scope="col" width="12%" height="20" align="center" class="shouhuo">电话/手机</th>
				<th scope="col" width="17%" height="20" align="center" class="shouhuo">操作</th>
			</tr>

			<%
						List li = ConsigneeAddress
						.getConsigneeAddress(teasession._rv._strR);
				if (!li.isEmpty()) {
					ConsigneeAddress cs = null;
					for (int i = 0; i < li.size(); i++) {
						cs = (ConsigneeAddress) li.get(i);
						out.print("<tr>");
						out.print("<td class=biankuang2>" + cs.getConsignee() + "</td>");
						out
						.print("<td>"
						+ cs.getNowarea().substring(
								cs.getNowarea().indexOf("&") + 1)
						+ "</td>");
						out.print("<td class=biankuang2>" + cs.getStreetaddress() + "</td>");
						out.print("<td class=biankuang2>" + cs.getPostcode() + "</td>");
						out.print("<td class=biankuang2>" + cs.getHomephone() + " " + cs.getPhone()
						+ "</td>");
						out.print("<td class=biankuang2>");
						if (cs.getState().equalsIgnoreCase("0")) {
					out.print("<a href=" + request.getRequestURI()
							+ "?type=3&id=" + cs.getConsigneeid()
							+ ">设为首选</a>|<a href="
							+ request.getRequestURI() + "?type=1&id="
							+ cs.getConsigneeid() + ">修改</a>|<a href="
							+ request.getRequestURI() + "?type=2&id="
							+ cs.getConsigneeid() + ">删除</a></td>");
						} else {
					out.print("首选地址|<a href=" + request.getRequestURI()
							+ "?type=1&id=" + cs.getConsigneeid()
							+ ">修改</a>|<a href=" + request.getRequestURI()
							+ "?type=2&id=" + cs.getConsigneeid()
							+ ">删除</a></td>");
						}
						out.print("</tr>");
					}
				}
			%>
	</table>

<%
   if(panduan || update){
 %>
<div style="font-size:14px; font-weight:bold; margin:45px auto 20px auto;text-align:center;">新增收货地址</div>
		<form name="consigneeform" action="" method="post">
			<input type="hidden" name="act" value="ress">
			<table width="90%" border="0" align="center" cellpadding="5" cellspacing="0" class="steptb" style="font-size:12px;">
				<tr>
				    <td width="117" height="20" class="shouhuo10">
				      <%
				     if(cons!=null){
				     %>
				      <input type="hidden" name="consigneeid" value="<%=cons.getConsigneeid()%>">
				      <%}else{%>
   				      <input type="hidden" name="consigneeid" value="">
				      <%}%>
			      <%=r.getString(teasession._nLanguage, " *收货人姓名 ")%> </td>
					<td width="635" class="shouhuo101">
					   <input type="hidden" name="username"
							value="<%=teasession._rv._strR%>">
					   <%
				     if(cons!=null){
				     %>
	                  <input type="text" name="consignee" value="<%=cons.getConsignee()%>">
	                  <%}else{%>
	                  <input type="text" name="consignee" value="">
	                  <%}%>	    		<span id="consigneeError"></span>		  </td>
				</tr>
				<tr>
					<td height="20" class="shouhuo10">
					  <%=r.getString(teasession._nLanguage, "*所在地区")%></td>
					<td class="shouhuo102">
					    <%if(cons!=null){%>
						<SCRIPT>selectcard('provinceid','cityid','districtid','<%=cons.getNowarea()%>');</SCRIPT>
						<%}else{%>
						<SCRIPT>selectcard('provinceid','cityid','districtid','');</SCRIPT>
						<%}%>

					  <%if(cons!=null){%>
						<input type="hidden" name="nowarea" value="<%=cons.getNowarea()%>">
						<%}else{%>
						<input type="hidden" name="nowarea">
					  <%}%>				  <span id="nowareaError"></span>      </td>
				</tr>
				<tr>
					<td height="20" class="shouhuo10">
					  <%=r.getString(teasession._nLanguage, "*街道地址")%>				        </td>
					<td class="shouhuo102">
					  <%if(cons!=null){ %>
						<textarea name="streetaddress" rows="3" cols="60"><%=cons.getStreetaddress()%></textarea>
						<%}else{ %>
						<textarea name="streetaddress" rows="3" cols="60"></textarea>
					  <%}%>	  			<span id="streetaddressError"></span>	  </td>
				</tr>
				<tr>
					<td height="20" class="shouhuo10">
					  <%=r.getString(teasession._nLanguage, "*邮政编码")%>				        </td>
					<td class="shouhuo102">
					  <%if(cons!=null){ %>
						<input type="text" name="postcode" value="<%=cons.getPostcode()%>">
						<%}else{ %>
						<input type="text" name="postcode">
					  <%}%>	  			<span id="postcodeError"></span>	  </td>
				</tr>
				<tr>
					<td height="20" class="shouhuo10">
						<span class="STYLE1"><%=r.getString(teasession._nLanguage, "电话 ")%>				        </span></td>
					<td class="shouhuo102">
					  <%if(cons!=null){ %>
						<input type="text" name="homephone" value="<%=cons.getHomephone()%>">
						<%}else{ %>
						<input type="text" name="homephone">
					  <%}%>	  			<span id="homephoneError"></span>	  </td>
				</tr>
				<tr>
					<td height="20" class="shouhuo10">
						<span class="STYLE1"><%=r.getString(teasession._nLanguage, "手机 ")%>				        </span></td>
					<td class="shouhuo102">
					  <%if(cons!=null){ %>
						<input type="text" name="phone" value="<%=cons.getPhone()%>">
						<%}else{ %>
						<input type="text" name="phone">
					  <%}%>	  <span id="phoneError"></span>				  </td>
				</tr>
		  </table>
			 <br>
			<table width="90%" border="0" align="center" cellpadding="2"
				cellspacing="0" style="font-size:12px;">
                <tr>
					<td width="160" >
						<%=r.getString(teasession._nLanguage, "*最多保存5个有效地址 ")%>				  </td>
					<td align="center" id="cb">
					<%if(update){%>
						<input type="button" name="go" value="修改" onClick="submitForm('1')">
						<%}else{ %>
						<input type="button" name="go2" value="保存" onClick="submitForm('0')">
				  <%} %>				  </td>
				</tr>
		  </table>
		</form>
		<%}%>
</div>
	</body>
</html>
