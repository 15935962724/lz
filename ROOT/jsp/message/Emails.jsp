<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.ui.*" %>
<%@ page import="tea.entity.member.*" %><%@ page import="tea.resource.*" %>
<%@ page import="javax.mail.*" %><%@ page import="java.util.*" %>
<%@page import="javax.mail.internet.*"%>
<%
TeaSession teasession = new TeaSession(request);
if (teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Resource r=new Resource();
r.add("/tea/ui/member/email/EmailBoxs").add("/tea/ui/member/email/Emails");

StringBuffer par=new StringBuffer();
par.append("?community=").append(teasession._strCommunity);

int s =Integer.parseInt( request.getParameter("emailbox"));
par.append("&emailbox=").append(s);

EmailBox emailbox = EmailBox.find(s);
if(request.getMethod().equals("POST"))
{
  String s2 = request.getParameter("Pop3Passwd");
  emailbox.set(s2);
}
int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
par.append("&pos=");

int i = -1;
Folder folder = emailbox.openFolder();
if (folder != null)
{
  i = folder.getMessageCount();
}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>

<h1><%=r.getString(teasession._nLanguage, "EmailBoxs")+" ( "+i+" )"%></h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<div id="pathdiv"><%=TeaServlet.hrefGlance(teasession._rv)%>><A HREF="/jsp/message/EmailBoxs.jsp"><%=r.getString(teasession._nLanguage, "EmailBoxs")%></A>><A HREF="/jsp/message/Emails.jsp?emailbox=<%=s%>"><%=emailbox.getEmail()%></A></div>
<%
if (i == -1)
{
%>
<FORM NAME=foEmailBox METHOD=POST ACTION="<%=request.getRequestURI()%>">
  <INPUT TYPE="HIDDEN" NAME="community" VALUE="<%=teasession._strCommunity%>"/>
  <INPUT TYPE="HIDDEN" NAME="emailbox" VALUE="<%=s%>"/>
  <TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage, "InfEnterPop3Password")%>:</td>
      <td><INPUT TYPE=PASSWORD NAME=Pop3Passwd></td>
    </tr>
    <tr>
      <td colspan="2"><INPUT TYPE="SUBMIT" VALUE="提交"/></td>
    </tr>
  </table>
</FORM>
<SCRIPT type="javascript">document.foEmailBox.Pop3Passwd.focus();</SCRIPT>


<%
}
if (i == 0)
{
  out.print(new tea.html.Text(r.getString(teasession._nLanguage, "0MessageInMailBox") + "<br><br>"));
}

out.print(new tea.html.Button(1, "CB", "CBNewMessage", r.getString(teasession._nLanguage, "CBNewMessage"), "window.open('/jsp/message/EmailSend.jsp?community="+teasession._strCommunity+"&emailbox="+s+"', '_blank');"));
if (i > 0)
{
  out.print(new tea.html.Button(1, "CB", "Reply", r.getString(teasession._nLanguage, "Reply"), "window.open('/servlet/NewMessage?receiver="+s+"', '_blank');"));
  out.print(new tea.html.Button(1, "CB", "CBDelete", r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + r.getString(teasession._nLanguage, "ConfirmDeleteSelected") + "')){window.open('javascript:foDelete.submit();" + "', '_self');}"));
  out.print(new tea.html.Button(1, "CB", "CBDeleteAll", r.getString(teasession._nLanguage, "CBDeleteAll"), "if(confirm('" + r.getString(teasession._nLanguage, "ConfirmDeleteAll") + "')){window.open('DeleteAllEmails?EmailBox=" + s + "', '_self');}"));
}
%>
<FORM NAME=foDelete METHOD=GET ACTION="/servlet/DeleteEmails">
<INPUT TYPE="HIDDEN" NAME="EmailBox" VALUE="<%=s%>"/>

  <TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr ID=tableonetr>
      <td nowrap>序号</td>
      <td><%=r.getString(teasession._nLanguage, "EmailBoxs")%></td>
      <td><%=r.getString(teasession._nLanguage, "Subject")%></td>
      <td><%=r.getString(teasession._nLanguage, "Time")%></td>
    </tr>
<%
if (folder != null)
{
  i = folder.getMessageCount();
  javax.mail.Message ms[] = folder.getMessages();

  boolean flag = true;
  int type =9;


  for (int j = ms.length - 1-pos;j >=0 && j >= ms.length - 1-pos-type; j--)
  {
    out.print("<tr onmouseover=bgColor='#BCD1E9'; onMouseOut=bgColor=''; ><td>"+new tea.html.CheckBox("Emails", false,Integer.toString(j + 1))+"</td><td>");
    try
    {
      InternetAddress ias[]=(InternetAddress[]) ms[j].getFrom();//<liangdx.hichina.com@eachnichost.com.cn (@)>
      if (ias != null)
      {
        for (int k = 0; k < ias.length; k++)
        {
          String name=ias[k].getPersonal();
          String email=ias[k].getAddress();
          name=name==null?email:EmailBox.decode(name);
          out.print("<a href=/servlet/NewMessage?receiver=" + email+" target=_blank >"+ name+"</a>");
        }
      }
    }catch(AddressException ae)
    {}
    String s3 = EmailBox.decode(ms[j].getSubject());
    out.print("<td><a href=/jsp/message/Email.jsp?community="+teasession._strCommunity+"&emailbox="+ s + "&emailno=" + (j + 1)+">"+s3+"</a></TD>");
    java.util.Date date = ms[j].getSentDate();
    if (date != null)
    {
      out.print("<TD nowrap>"+(new java.text.SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(date));
    } else
    {
      out.print("<TD>&nbsp;</TD>");
    }
    out.flush();
  }
  emailbox.closeFolder();
  out.print("<tr><td><td colspan=30>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(), pos, ms.length,10)+"</td></tr>");
}
%>
</table>
</FORM>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<%=new tea.htmlx.Languages(teasession._nLanguage, request)%>

</body>
</html>
