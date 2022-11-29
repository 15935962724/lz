<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.db.*"%>
<%@page import="tea.entity.node.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.ui.*" %>
<html>
<head>

</head>
<%
TeaSession teasession;
teasession = new TeaSession(request);
String community = teasession._strCommunity;
session.setAttribute("fnode",request.getParameter("node"));
///
String sql = "select logotype,logoname,logoimage,logouse,regnum,regdate from sheet1$";
DbAdapter db = new DbAdapter();
ArrayList ar = new ArrayList();
try{
  db.executeQuery(sql);
  Logo logo = null;
  while(db.next()){
    logo = new Logo();
    logo.setLogotype(db.getString(1));
    logo.setLogoname(db.getString(2));
    logo.setLogoimage(db.getString(3));
    logo.setLogouse(db.getString(4));
    logo.setRegnum(db.getString(5));
    logo.setRegdate(db.getDate(6));

    ar.add(logo);
  }
}
catch(SQLException ex)
{
  ex.printStackTrace();
}
finally{
  db.close();
}

String act = request.getParameter("act");
if(act != null)
{
  if(act.equals("change")){
    Logo logo2 = new Logo();
    logo2.change();
  }
  if(act.equals("deleteAll")){
    String sql2 = "select node from Logo";
    DbAdapter db2 = new DbAdapter();
    ArrayList ar2 = new ArrayList();
    try{
      db2.executeQuery(sql2);
      while(db2.next()){
        ar2.add(String.valueOf(db2.getInt(1)));
      }
    }
    catch(SQLException ex)
    {
      ex.printStackTrace();
    }
    finally{
      db2.close();
    }
    for(int i = 0;i < ar2.size();i++){
      int nid = Integer.parseInt(ar2.get(i).toString());
      Node nobj = Node.find(nid);
      nobj.delete(nid);
      Logo obj = Logo.find(nid);
      obj.delete();
    }
  }
}
%>
<title>
LogoImport<%=session.getAttribute("fnode")%>
</title>
<body bgcolor="#ffffff">
<form name="form1" action="?">
  <input type="hidden" name="act" value="change">
  <input type="submit" value="更换照片路径">
</form>

<form name="form2" action="/servlet/EditLogo" method="POST">
  <input type="hidden" name="act" value="import">
  <input type="hidden" name="node" value="<%=request.getParameter("node")%>"/>
  <input type="hidden" name="nexturl" value="/jsp/type/logo/LogoImport.jsp">
  <input type="submit" value="导入">
</form>
<form name="form1" action="?">
  <input type="hidden" name="act" value="deleteAll">
  <input type="submit" value="删除全部">
</form>
<%
for(int i = 0; i < ar.size();i++){
Logo logo2 = (Logo)ar.get(i);
out.print((i+1) + "&nbsp;&nbsp;&nbsp;&nbsp;" + logo2.getLogotype() + "&nbsp;&nbsp;&nbsp;&nbsp;" + logo2.getLogoname() + "&nbsp;&nbsp;&nbsp;&nbsp;"
+ logo2.getLogoimage() + "&nbsp;&nbsp;&nbsp;&nbsp;" + logo2.getLogouse() + "&nbsp;&nbsp;&nbsp;&nbsp;"
+ logo2.getRegnum() + "&nbsp;&nbsp;&nbsp;&nbsp;" + logo2.getRegdate() + "<br><br>");
}
%>
</body>
</html>
