<%@page contentType="text/html; charset=UTF-8" %><%@page import="java.sql.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.*" %><%@page import="java.util.Date" %><%


Http h=new Http(request);
String destaddr=h.get("destaddr","15811276787");
String messagecontent=h.get("messagecontent","测试中文——花地");


if("POST".equals(request.getMethod()))
{
  DbAdapter db=new DbAdapter(9);
  try
  {
    db.executeUpdate("Insert into sms_outbox (sismsid, extcode, destaddr, messagecontent, reqdeliveryreport,msgfmt,sendmethod,requesttime,applicationid)VALUES ('"+System.currentTimeMillis()+"',null, "+DbAdapter.cite(destaddr)+","+DbAdapter.cite(messagecontent)+", 1, 15, 0,"+DbAdapter.cite(new Date())+", 'db')");
  }finally
  {
    db.close();
  }
  out.print("OK");
}



%>
<form action="?" method="post">
<table width="200">
  <tr>
    <td>手机:</td>
    <td><input name="destaddr" value="<%=destaddr%>" size="40" /></td>
  </tr>
  <tr>
    <td>内容：</td>
    <td><textarea name="messagecontent" cols="50" rows="8"><%=messagecontent%></textarea></td>
  </tr>
</table>
<input type="submit" value="提交" />
</form>
