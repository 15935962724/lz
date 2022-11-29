<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="tea.htmlx.*" %>
<%@ page import="java.math.*" %>
<%@ page import="tea.entity.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.ui.*" %>

<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/ui/member/message/MessageFolders").add("/tea/ui/member/message/Messages").add("/tea/ui/member/email/EmailBoxs").add("/tea/ui/member/contact/CGroups").add("/tea/ui/member/contact/Contacts").add("/tea/ui/member/messagefolder/ManageMessageFolders");

String s ="Sent";

boolean flag = true;

String s1 = request.getParameter("Pos");
int i = s1 == null ? 0 : Integer.parseInt(s1);
int j = Message.count(teasession._strCommunity,s, teasession._rv);

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
<h1><%=j%> <%=r.getString(teasession._nLanguage, s)%><%=r.getString(teasession._nLanguage, "Messages")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<FORM name=foDelete METHOD=GET action="/servlet/DeleteMessages">
        <input type='hidden' name=Operation VALUE="">
        <input type='hidden' name=MessageFolder VALUE="">
        <input type='hidden' name=Folder VALUE="<%=s%>">
        <input type='hidden' name="nexturl" VALUE="<%=request.getRequestURI()+"?"+request.getQueryString()%>">

 <tr>
            <td><input type="button" value="<%=r.getString(teasession._nLanguage, "CBNewMessage")%>" ID="CBNewMessage" CLASS="CB" onClick="window.open('/servlet/NewMessage', '_blank');">
              <%          if(j > 0)
            {%>
              <% if(s.equals("Draft"))
                  {%>
              <input type="button" value="<%=r.getString(teasession._nLanguage, "CBSend")%>" ID="CBSend" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmSendSelected")%>')){window.open('javascript:document.foDelete.Operation.value=\'Trash\';foDelete.submit();', '_self');}">
              <%				  }
                if(!s.equals("Trash"))
                {%>
              <input type="button" value="<%=r.getString(teasession._nLanguage, "CBTrash")%>" ID="CBTrash" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmTrashSelected")%>')){window.open('javascript:document.foDelete.Operation.value=\'Trash\';foDelete.submit();', '_self');}">
              <input type="button" value="<%=r.getString(teasession._nLanguage, "CBTrashAll")%>" ID="CBTrashAll" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmTrashAll")%>')){window.open('/servlet/DeleteAllMessages?Operation=TrashAll&Folder=<%=s%>', '_self');}">
              <% //                  form.add(new Button(1, "CB", "CBTrashAll", r.getString(teasession._nLanguage, "CBTrashAll"), "if(confirm('" + r.getString(teasession._nLanguage, "ConfirmTrashAll") + "')){window.open('DeleteAllMessage?Operation=TrashAll&Folder=" + s + "', '_self');}"));
                }
%>
              <input type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" ID="CBDelete" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteSelected")%>')){window.open('javascript:foDelete.submit();', '_self');}">
              <input type="button" value="<%=r.getString(teasession._nLanguage, "CBDeleteAll")%>" ID="CBDeleteAll" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteAll")%>')){window.open('/servlet/DeleteAllMessages?Folder=<%=s%>', '_self');}">
              <%                if(s.equals("Inbox") || s.equals("Trash"))
           			{	%>
              <input type="button" value="<%=r.getString(teasession._nLanguage, "CBBlock")%>" ID="CBBlock" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmBlockSelected")%>')){window.open('javascript:document.foDelete.Operation.value=\'Block\';foDelete.submit();', '_self');}">
              <%}%>
              <%=MessageUI.getMessageFolderSelection(r, teasession)%>
              <%            }
%></td>
          </tr>
          <% if(j != 0)
{

java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyy.MM.dd hh.mm aaa");
%>
<TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
            <td><input type="checkbox" onclick="for(var i=0;i<foDelete.elements.length;i++)if(foDelete.elements[i].type=='checkbox')foDelete.elements[i].checked=this.checked;"/></td>
            <td><%=r.getString(teasession._nLanguage, "Receiver")%></td>
            <td><%=r.getString(teasession._nLanguage, "Subject")%></td>
            <td><%=r.getString(teasession._nLanguage, "Time")%></td>
          </tr>
          <%


boolean flag1 = true;
for(Enumeration enumeration = Message.find(teasession._strCommunity,s, teasession._rv, i, 25); enumeration.hasMoreElements(); )
{
  int k = ((Integer)enumeration.nextElement()).intValue();
  Message message = Message.find(k);
  RV rv = message.getFrom();
  String s3 = message.getFEmail();
  java.util.Date date = message.getTime();
//  int l = message.getType();
  int j1 = message.getHint();
  message.getOptions();
  String s6 = message.getSubject(teasession._nLanguage);
  boolean flag3 = false;
  boolean flag4 = false;
  RV rv1 = null;
  String s7 = "";
  if(rv._strR.length() != 0)
  if(message.isSingleEmailReceiver(rv))
  s7 = message.findSingleEmailReceiver(rv);
  else
  if(message.isSingleRVReceiver(rv))
  {
    rv1 = message.findSingleRVReceiver(rv);
    flag4 = MessageRead.isRead(k, rv1);
  }
  boolean flag5 = message.isMultipleReceiver(rv);
  boolean flag6 = message.getMessageCGroup().length() != 0;
  boolean flag7 = message.getMessageCommunity().length() != 0;

  if(rv1 == null && s7.length() == 0 && !flag5 && !flag6 && !flag7)
  flag3 = flag ? MessageRead.isRead(k) : MessageRead.isRead(k, teasession._rv);
  else
  flag3 = flag ? MessageRead.isReadExcludeSender(k, rv) : MessageRead.isRead(k, teasession._rv);

 %>
 <tr onmouseover="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
   <td><input  id="CHECKBOX" type="CHECKBOX" name=<%=Integer.toString(k)%> value=null></td>
     <td >
     <%
     if(flag5 || flag6 || flag7)
     {%>
     <A href="/servlet/MessageReaders?Message=<%=k%>" TARGET="_blank"><%=r.getString(teasession._nLanguage, "MessageReaders")%></A></td>
     <%
     } else
     if(s7.length() != 0)
     {%>
     <A href="/servlet/NewMessage?receiver=<%=s7%>" TARGET="_blank"><%=s7%></A>
     <%

   } else
   if(rv1 != null)
   {
     out.println(rv1);
     %>
            <%//=ts.hrefGlanceWithName(rv1, teasession._nLanguage).toString()%>
            <%                 //         cell1.add(new Text(hrefGlanceWithName(rv1, teasession._nLanguage).toString()));
                            if(flag4)
                            {
                                 date = MessageRead.getTime(k, rv1);
                            }
                        } else
                        {%>
            <%=TeaServlet.hrefGlanceWithName(teasession._rv, teasession._nLanguage)%>
            <%//                            cell1.add(new Text(hrefGlanceWithName(teasession._rv, teasession._nLanguage).toString()));


                        }


                        out.print("<TD><A href=/servlet/Message?Folder="+s+"&Message="+k+" >"+(flag3?"":"<B>")+new HintImg( j1)+s6+"</a>");

            out.print("<td>"+sdf.format(date));

%>
              <input type='hidden' name=Messages VALUE="<%=Integer.toString(k)%>">
              <%
                    flag1 = !flag1;
                }
%>
        <tr>
            <td><%=new FPNL(teasession._nLanguage, request.getRequestURI()+"?Pos=", i, j)%> </td>
          </tr>
        </table>
<%
            }
%>


        <br/>

      </form>
</table>


<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

