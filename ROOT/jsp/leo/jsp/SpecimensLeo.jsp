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
 String level = h.get("level");
 String levels = h.get("level2");
 StringBuffer sql = new StringBuffer();
 StringBuffer result = new StringBuffer();
 sql.append("select secondlevel from Specimen where firstlevel = '"+level+"' group by secondlevel");
 DbAdapter db = new DbAdapter();
	try {
		java.sql.ResultSet rs = db
				.executeQuery( sql.toString(), 0, Integer.MAX_VALUE);
		while (rs.next()) {
			int i = 1;
			String level2 = rs.getString(i++);
			if(null == level2 || "".equals(level2)){
				result.append("<option value=\"\">---</option>");
			}else{
				if(level2.equals(levels))
					result.append("<option value=\""+level2+"\" selected=\"selected\">"+level2+"</option>");
				else
					result.append("<option value=\""+level2+"\">"+level2+"</option>");
			}
		}
		rs.close();
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		out.print(result.toString());
		db.close();
	}
%>

