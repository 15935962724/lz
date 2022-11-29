<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.MT"%>
<%@page import="java.util.List"%>
<%@page import="tea.entity.yl.shop.ShopHospital"%>
<%@page import="tea.entity.Database"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
<h1>选择签收人</h1>
<%
	Http h=new Http(request,response);
	StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");

	sql.append(" AND deleted!=1 AND type!=1 AND membertype=2 "); //AND membertype=0
	
	String member = MT.f(h.get("member"));
	if(!member.equals("")){
		sql.append(" AND member like "+Database.cite("%"+member+"%"));
		par.append("&member="+member);
	}
	
	int pos=h.getInt("pos");
	
	int sum=Profile.count(sql.toString());
	int editparent = h.getInt("editparent");//编辑账户1      回传ret1
	par.append("&editparent="+editparent);
	par.append("&pos=");



%>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/jquery.js" type="text/javascript"></script>
<table id="tablecenter" cellspacing="0" style="background:none;" >

<form action="">
	<input type="hidden" name="editparent" value="<%=editparent%>">
	<tr>
  		<td class="th">用户名：</td><td><input name="member" value="<%=member %>" /></td>
  	</tr>
	<tr>
		<td colspan="2"><input type="submit" class="btn btn-primary" value="查询" /></td>
	</tr>
</form>
</table>
<table id="tablecenter" cellspacing="0" style="background:none;">
  <tr><td>用户名</td>
  <td>手机</td>
  <td>操作</td></tr>
				<%
				if(sum<0)
				{
				  out.print("<tr><td colspan='6' align='center'>暂无记录!</td></tr>");
				}else
				{
					List<Profile> shlist = Profile.find1(sql.toString(), pos, 20);
					for(int i=0;i<shlist.size();i++){
						Profile sh = shlist.get(i);
						%>
						<tr>
    <td><%=MT.f(sh.getMember())%></a></td>
    <td><%=MT.f(sh.getMobile())%></a></td>
                            <%if(editparent==1){%>
                            <td><a href="javascript:void(0);" onclick="ret1('<%= sh.getProfile() %>','<%= sh.getMember() %>');">选择</a></td>
                            <%}else {%>
                            <td><a href="javascript:void(0);" onclick="ret('<%= sh.getProfile() %>','<%= sh.getMember() %>');">选择</a></td>
                            <%}%>

    </tr>
						<%
					}
				}
				%>
			<%
  				if(sum>20)out.print("<tr><td colspan='20'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20)+"</td></tr>");
			%>
			</table>
<script type="text/javascript">
	var pmt=parent.mt;
	function ret(h,n){
		pmt.receive(h,n);
		pmt.close();
	}
    function ret1(h,n){
        pmt.receive1(h,n);
        pmt.close();
    }


</script>
</body>
</html>