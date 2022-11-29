<%@ page contentType="text/html; charset=UTF-8" %>
<%
Cookie[] cookie = request.getCookies();
for (int i = 0; i < cookie.length; i++)
  {
    if (cookie[i].getName().equals("param"))
    {
      String totelNum = cookie[i].getValue();
      out.print(totelNum);
    }
  }
%>
