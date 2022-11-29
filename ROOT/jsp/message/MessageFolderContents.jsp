<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.html.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

if(!teasession._rv.isSupport())
{
  response.sendError(403);
  return;
}
Resource r=new Resource("/tea/ui/member/message/MessageFolders").add("/tea/ui/member/message/Messages").add("/tea/ui/member/email/EmailBoxs").add("/tea/ui/member/contact/CGroups").add("/tea/ui/member/contact/Contacts").add("/tea/ui/member/messagefolder/ManageMessageFolders");


int s =Integer.parseInt(request.getParameter("messagefolder"));

MessageFolder obj=MessageFolder.find(s);

String s1 = obj.getMember();
int i = obj.getType();
boolean flag = s1.equals(teasession._rv._strR);

int byte0 = 25;

java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyy.MM.dd hh:mm aaa");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Messages")%></h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>



<%
if(flag)
{
  String s2 = obj.getName(teasession._nLanguage);
  String s4 = request.getParameter("Pos");
  int j = s4 != null ? Integer.parseInt(s4) : 0;
  int l = Message.count(teasession._strCommunity,s1,s);//MessageFolderContent.count(teasession._rv._strR, s);

  out.print("<div id=pathdiv >"+TeaServlet.hrefGlance(teasession._rv) + ">" + new Anchor("ManageMessageFolders.jsp", r.getString(teasession._nLanguage, "ManageFolders")) + ">" + new Anchor("MessageFolderContents.jsp?messagefolder=" + s, s2) + " &nbsp; " + l + " " + r.getString(teasession._nLanguage, "Messages")+"</div>");
  %>
  <FORM NAME=foDelete METHOD=GET ACTION="/servlet/DeleteMessageFolderContents">
    <INPUT TYPE="HIDDEN" NAME="Operation" VALUE=""/>
    <INPUT TYPE="HIDDEN" NAME="MessageFolder0" VALUE="<%=s%>"/>
      <INPUT TYPE="HIDDEN" NAME="MessageFolder" VALUE="<%=s%>"/>


          <TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr ID=tableonetr>
              <td>&nbsp;</td>
              <td><%=r.getString(teasession._nLanguage, "Sender")%></td>
              <td><%=r.getString(teasession._nLanguage, "Subject")%></td>
              <td><%=r.getString(teasession._nLanguage, "Time")%></td>
            </TR>
            <%
            if(l != 0)
            {
              boolean flag1 = true;

              //for(Enumeration enumeration = MessageFolderContent.find(teasession._rv._strR, s, j, byte0); enumeration.hasMoreElements(); )
              //{
                //    int j1 = ((Integer)enumeration.nextElement()).intValue();
                Enumeration enumeration = Message.find(teasession._strCommunity,teasession._rv._strR, s, j, byte0);
                while(enumeration.hasMoreElements())
                {
                  int j1 = ((Integer)enumeration.nextElement()).intValue();
                  Message message = Message.find(j1);
                  String s6=message.getFMember();
                  Date date = message.getTime();
                  boolean flag4 = message.isReader(teasession._rv._strR);

                  out.print("<tr onmouseover=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\" ><TD>"+new CheckBox("messages", false,Integer.toString(j1)));
                  out.print("<TD><a href=/jsp/message/NewMessage.jsp?receiver="+s6+" _blank>"+s6+"</a><TD>");
                  if(!flag4)
                  out.print("<B>");
                  out.print(new Anchor("/jsp/message/Message.jsp?messagefolder=" + s + "&message=" + j1, message.getSubject(teasession._nLanguage)));
                  out.print("<TD>"+sdf.format(date));
                }
              }
                out.print("<tr><td colspan=4 >"+new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+"?MessageFolder=" + s + "&Pos=", j, l));

                out.print("<tr><td colspan=4>"+new Button(1, "CB", "CBNewMessage", r.getString(teasession._nLanguage, "CBNewMessage"), "window.open('/jsp/message/NewMessage.jsp', '_blank');"));
                if(l > 0)
                {
                    out.print(new Button(1, "CB", "CBDelete", r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + r.getString(teasession._nLanguage, "ConfirmDeleteSelected") + "')){window.open('javascript:foDelete.submit();" + "', '_self');}"));
                    out.print(new Button(1, "CB", "CBDeleteAll", r.getString(teasession._nLanguage, "CBDeleteAll"), "if(confirm('" + r.getString(teasession._nLanguage, "ConfirmDeleteAll") + "')){window.open('DeleteAllMessageFolderContents?MessageFolder=" + s + "', '_self');}"));
                    out.print(tea.htmlx.MessageUI.getMessageFolderSelection(r, teasession));
                    out.print(new CheckBox("DeleteOriginal", false));
                    out.print(new Text(r.getString(teasession._nLanguage, "DeleteOriginal")));
                }
%>
</table>
</form>
<%


}



/*

             else
            if(i != 0)
            {



              MessageFolder messagefolder1 = MessageFolder.find(s1, s);
                String s3 = messagefolder1.getName(teasession._nLanguage);
                String s5 = request.getParameter("Pos");
                int k = s5 != null ? Integer.parseInt(s5) : 0;
                int i1 = MessageFolderContent.count(s1, s);

                out.print("<div id=pathdiv >"+TeaServlet.hrefGlance(new RV(s1, s1)) + ">" + new Anchor("ManageMessageFolders", r.getString(teasession._nLanguage, "ManageFolders")) + ">" + new Anchor("MessageFolderContents?MessageFolder=" + s, s3) + " &nbsp; " + i1 + " " + r.getString(teasession._nLanguage, "Messages")+"</div>");

                %>

                                <FORM NAME=foDelete METHOD=GET ACTION="/servlet/DeleteMessageFolderContents">
          <INPUT TYPE="HIDDEN" NAME="Operation" VALUE=""/>
          <INPUT TYPE="HIDDEN" NAME="MessageFolder0" VALUE="<%=s%>"/>
          <INPUT TYPE="HIDDEN" NAME="MessageFolder" VALUE="<%=s%>"/>


          <TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">

                <%
                Form form1 = new Form("foDelete", "GET", "DeleteMessageFolderContents");
                form1.add(new HiddenField("Operation", ""));
                form1.add(new HiddenField("MessageFolder0", s));
                form1.add(new HiddenField("MessageFolder", s));
                Table table1 = new Table();
                table1.setId("MessageBodyInnerDiv");
                table1.setCellPadding(0);

                if(i1 != 0)
                {
                    out.print("<tr ID=tableonetr><td>&nbsp;<td>" + r.getString(teasession._nLanguage, "Sender") + "<td>" + r.getString(teasession._nLanguage, "Subject") + "<td>" + r.getString(teasession._nLanguage, "Time"));
                    boolean flag2 = true;

                    for(Enumeration enumeration1 = MessageFolderContent.find(s1, s, k, byte0); enumeration1.hasMoreElements(); )
                    {
                        int k1 = ((Integer)enumeration1.nextElement()).intValue();
                        tea.entity.member.Message message1 = tea.entity.member.Message.find(k1);
                        RV rv1 = message1.getFrom();
                        String s7 = message1.getFEmail();
                        java.util.Date date1 = message1.getTime();
                        //int i2 = message1.getType();
                        int k2 = message1.getHint();
                        message1.getOptions();
                        String s9 = message1.getSubject(teasession._nLanguage);
                        boolean flag5 = false;
                        flag5 = MessageRead.isRead(k1, teasession._rv);

                        out.print("<TR><TD>"+new CheckBox("Messages", false,Integer.toString(k1)));

                        String s11 = "";
                        if(s7 != null && s7.length() != 0)
                            s11 = (new Anchor("/jsp/message/NewMessage.jsp?receiver=" + s7, "_blank", new Text(s7))).toString();
                        else
                            s11 = TeaServlet.hrefGlanceWithName(rv1, teasession._nLanguage).toString();

                        out.print("<TD>"+s11+"<TD>");
                        if(!flag5)out.print("<B>");
                        out.print(new Anchor("/jsp/message/Message.jsp?MessageFolder=" + s + "&Message=" + k1, new Text(new tea.htmlx.HintImg( k2) + " <font>" + s9 + "</font>")));

                        out.print("<TD>"+sdf.format(date1));


                    }

                }



                boolean flag3 = MessageFolder.isUseAsMyOwnMessageFolder(teasession._rv._strR, s);

                out.print("<tr><tr><td colspan=4>"+r.getString(teasession._nLanguage, "UseAsMyOwnMessageFolder") + ": " + new Radio("UseAsMyOwnMessageFolder", 1, flag3) + r.getString(teasession._nLanguage, "Yes") + " " + new Radio("UseAsMyOwnMessageFolder", 0, !flag3) + r.getString(teasession._nLanguage, "No") + " &nbsp;" + new Anchor("javascript:foDelete.submit();", r.getString(teasession._nLanguage, "Submit")));
                out.print("<tr><td colspan=4>"+new tea.htmlx.FPNL(teasession._nLanguage, "MessageFolderContents?MessageFolder=" + s + "&Pos=", k, i1));

                out.print("<tr><td colspan=4>"+new Button(1, "CB", "CBNewMessage", r.getString(teasession._nLanguage, "CBNewMessage"), "window.open('NewMessage', '_blank');"));
                if(i1 != 0)
                {
                    if(i == 3)
                    {
                        out.print(new Button(1, "CB", "CBDelete", r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + r.getString(teasession._nLanguage, "ConfirmDeleteSelected") + "')){window.open('javascript:foDelete.submit();" + "', '_self');}"));
                        out.print(new Button(1, "CB", "CBDeleteAll", r.getString(teasession._nLanguage, "CBDeleteAll"), "if(confirm('" + r.getString(teasession._nLanguage, "ConfirmDeleteAll") + "')){window.open('DeleteAllMessageFolderContents?MessageFolder=" + s + "', '_self');}"));
                    }
                    out.print(tea.htmlx.MessageUI.getMessageFolderSelection(r, teasession));
                    if(i == 3)
                    {
                        out.print(new CheckBox("DeleteOriginal", false));
                        out.print(new Text(r.getString(teasession._nLanguage, "DeleteOriginal")));
                    }
                }


            } else
            {
                out.print( r.getString(teasession._nLanguage, "Unviewable"));
                return;
            }*/
%>
  <tr>
    <td ID=MessageBottomDiv ALIGN=CENTER COLSPAN=2></td>
  </tr>
</table>

<div id="head6"><img height="6" src="about:blank" alt=""></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>

</body>
</html>
