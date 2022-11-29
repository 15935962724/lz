<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.*"%>
<%@page import="java.io.PrintWriter"%>
<%
/**
 * 动态改变二级分类内容
 * 
 */
 response.setContentType("text/html; charset=UTF-8");
 Http h = new Http(request,response);
 String type = h.get("type","");
 String order1 = h.get("order1","");
 StringBuffer sql = new StringBuffer();
 StringBuffer result = new StringBuffer();
 DbAdapter db = new DbAdapter();
	try {
		 if("".equals(type)){
			 result.append("<option value=\"\">不限</option>");
		 }else{
			 if(!"".equals(order1) && !"0".equals(order1)){
				 sql.append("select distinct family from animal where 1=1 ");
				 sql.append(" AND type = "+type);
				 sql.append(" AND order1 like '"+order1+"'");
			 }else{
				 sql.append("select distinct order1 from animal where 1=1 ");
				 sql.append(" AND type = "+type);
			 }
			java.sql.ResultSet rs = db
				.executeQuery( sql.toString(), 0, Integer.MAX_VALUE);
			while (rs.next()) {
				int i = 1;
				String val = rs.getString(i++);
				result.append("<option value=\""+val+"\">"+val+"</option>");
			}
			rs.close();
		 }
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		out.print(result.toString());
		db.close();
	}
%>

