<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="tea.entity.yl.shop.ShopCategory"%>
<%@page import="tea.entity.yl.shop.ShopProduct"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.MT"%>
<%@page import="java.util.List"%>
<%@page import="tea.entity.yl.shop.ShopHospital"%>
<%@page import="tea.entity.Database"%>
<%@page import="tea.entity.Http"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body id='leftbgs'>

<%
	Http h=new Http(request,response);
	StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
	String inpname = h.get("inpname");
	String hosname = MT.f(h.get("hosname"));
	int category = h.getInt("category",0);
	if(category>0){
		//sql.append(" AND category ="+category);
		sql.append(" AND ca.path like '%|"+category+"|%'");
		par.append("&category="+category);
	}
	String str= h.get("str");
	
	sql.append(" AND state = 0");
	
	sql.append(" AND product not in "+str);
	par.append("&str="+str);
	
	if(!hosname.equals("")){
		sql.append(" AND name1 like "+Database.cite("%"+hosname+"%"));
		par.append("&hosname="+hosname);
	}
	int pos=h.getInt("pos");
	int sum=ShopProduct.count(sql.toString());
	par.append("&pos=");

%>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<table id="tablecenter" cellspacing="0" style="background:none;" >
<form action="">
<input name="inpname" value="<%= inpname %>" type="hidden" />
<input name="str" value="<%= str %>" type="hidden" />

	<tr>
		<td>查询</td><td><input name="hosname" /></td><td><input class="btn btn-primary" type="submit" value="查询" /></td>
	</tr>
</form>
</table>
<table id="tablecenter" cellspacing="0" style="background:none;">
			<tr id="tableonetr">
				<td>名称</td><td>销售价</td>
			</tr>
				<%
				if(sum<1)
				{
				  out.print("<tr><td  colspan='20'>暂无记录!</td></tr>");
				}else
				{
					List<ShopProduct> shlist = ShopProduct.find(sql.toString(), pos, 20);
					for(int i=0;i<shlist.size();i++){
						ShopProduct sh = shlist.get(i);
						if(sh.category==ShopCategory.getCategory("lzCategory"))continue;
						out.print("<tr data='{name:\""+sh.name[1]+"\"}'><td><a href='javascript:void(0);' onclick=ret('"+sh.product+"',this,'"+sh.price+"');>"+sh.name[1]+"</a></td><td>"+sh.price+"</td></tr>");
					}
				}
				
				%>
			<%
  				if(sum>20)out.print("<tr><td>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
			%>
			</table>
<script type="text/javascript">
	var pmt=parent.parent.mt;
	function ret(h,t,price){
		var tr=mt.ftr(t);
		eval('d='+tr.getAttribute('data'));
		pmt.addtr(h,d.name,price);
		pmt.close();
	}
	
</script>
</body>
</html>