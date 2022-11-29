<%@page contentType="text/html;charset=utf-8"  %>
<%@page import="tea.service.Email"%>
<%//\��վ�������
  String webname = request.getParameter("webname");   //��վ��
  if (webname==null)
  webname="www.officebill.net";
 String mailserver="211.144.143.146";    //�ʼ�������
 String mailuser="zhangliang";           //�û���
 String mailpassword="1234";             //����
 String mailto="zhangliang919@163.com";  //���յ�ַ
  Email email= new Email(mailserver,mailuser,mailpassword,webname,mailto);
  email.sendEmail();
%>
