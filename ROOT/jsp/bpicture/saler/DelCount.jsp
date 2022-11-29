<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="java.util.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.math.BigDecimal" %>
<%@page import="java.io.*" %>
<%@ page import="java.awt.image.*" %>
<%@ page import="javax.imageio.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.entity.member.*" %>
<%

DbAdapter db  = new DbAdapter();
DbAdapter db1  = new DbAdapter();
DbAdapter db2  = new DbAdapter();
db.executeQuery("select node from baudit where received < '2009-02-11' and member='leemac@263.net'");
while(db.next()){
  db1.executeUpdate("delete from picture where node="+db.getInt(1));
}
db2.executeUpdate("delete from baudit where received < '2009-02-11' and member='leemac@263.net'");
db.close();
db1.close();
db2.close();
%>
