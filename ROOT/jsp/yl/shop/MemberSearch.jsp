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

<%
	Http h=new Http(request,response);
	StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
	String inpname = h.get("inpname");
	String hosname = MT.f(h.get("hosname"));
	sql.append(" AND qualification = 0");
	
	
	if(!hosname.equals("")){
		sql.append(" AND member like "+Database.cite("%"+hosname+"%"));
		par.append("&hosname="+hosname);
	}
	sql.append(" AND deleted = 0 AND membertype = 0 AND type = 0 ");
	int pos=h.getInt("pos");
	int sum=Profile.count(sql.toString());
	par.append("&pos=");
	
	

%>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<table id="tablecenter" cellspacing="0" style="background:none;" >
<form action="">
<input name="inpname" value="<%= inpname %>" type="hidden" />
	<tr>
		<td>查询</td><td><input name="hosname" /></td><td><input type="submit" value="查询" /></td>
	</tr>
</form>
</table>
<table id="tablecenter" cellspacing="0" style="background:none;">
<tr>
	<td>用户名</td>
</tr>
				<%
				if(sum<1)
				{
				  out.print("<tr><td>暂无记录!</td></tr>");
				}else
				{
					List<Profile> shlist = Profile.find1(sql.toString(), pos, 20);
					for(int i=0;i<shlist.size();i++){
						Profile sh = shlist.get(i);
						out.print("<tr><td><a href='javascript:void(0);' onclick=ret('"+sh.profile+"','"+sh.member+"');>"+sh.member+"</a></td></tr>");
					}
				}
				
				%>
			<%
  				if(sum>20)out.print("<tr><td>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
			%>
			</table>
<script type="text/javascript">
	var pmt=parent.mt;
	function ret(h,name){
	pmt.receive1(h,'<%=inpname%>');
	pmt.receive1(name,'<%=inpname%>1');
	pmt.close();
	}
	
</script>
</body>
</html>