<%@page contentType="text/html; charset=UTF-8" %><%@ page import="tea.entity.*"%><%@ page import="tea.entity.admin.*"%><%@ page import="tea.resource.*"%><%@ page import="tea.entity.doctor.*"%><%

//
//Http h=new Http(request);
//String str=h.get("Filedata");
//out.print(str);
//String[] arr=h.getValues("Filedata");
//for(int i=0;i<arr.length;i++)
//{
//  System.out.println(arr[i]);
//}
java.io.InputStream is = request.getInputStream();
int v = 0;
while ((v = is.read()) != -1)
{
  //Thread.currentThread().sleep(10L);
  System.out.print((char) v);
}
is.close();

out.print("/res/1006/logo.png");

if(true)return;
%>
