<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/ui/member/notification/NotificationServlet");

			RV rv = teasession._rv;
            Notification notification = Notification.find(rv);
            if(!notification.isExisted(rv))
                Notification.create(rv);
            Date date = Log.getLastTime(rv);
            int i = notification.getOptions();

%>

<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Reminders")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>



<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%>  </div>
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td>
<%=r.getString(teasession._nLanguage, "LastLogin")%>: <%=(new SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(date)%>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
 			if((i & 2) != 0)
            {
                int j =tea.entity.member.Message.countNew("Inbox", rv, date);
                if(j != 0)
                {
                    int k = 0;
                    for(Enumeration enumeration = tea.entity.member.Message.find(new String("Inbox"), rv); enumeration.hasMoreElements();)
                    {
                        int i1 = ((Integer)enumeration.nextElement()).intValue();
                        if(!MessageReader.isRead(i1, rv))
                            k++;
                    }
%>
  					<tr><td><A href="/servlet/Messages?Folder=Inbox" TARGET="_blank"><%=j%>  <%=r.getString(teasession._nLanguage, "InboxNewMessages")%></A> </td>
					<td>
					<A href="/servlet/Messages?Folder=Inbox" TARGET="_blank"><%=k%>  <%=r.getString(teasession._nLanguage, "InboxUnreadMessages")%></A> </td></tr></table>
                    <EMBED SRC="/tea/audio/<%=teasession._nLanguage%>/yougotmail.wav"  AUTOSTART=true WIDTH=0 HEIGHT=0>
     <%           }
            }%>
			<TABLE CELLSPACING=0 CELLPADDING=3 border="0">
<%
			if((i & 0x10) != 0)
			{%>
                <tr><%if(JoinRequest.countRequestCommunities(rv) != 0)
				{%>
						<td>
						<A href="/servlet/JoinRequestCommunities" TARGET="_blank"><%=JoinRequest.countRequestCommunities(rv)%>  <%=r.getString(teasession._nLanguage, "JoinRequestCommunities")%></A> </td>
	    		<%}if(AccessRequest.countNodes(rv) != 0)
                	{    %>
						<td><A href="/servlet/AccessRequestNodes" TARGET="_blank"><%=AccessRequest.countNodes(rv)%> <%=r.getString(teasession._nLanguage, "AccessRequestNodes")%></A> </td>
                <%}if(Aded.countRequestNodes(rv) != 0)
				{%>
						<td><A href="/servlet/AdRequestNodes" TARGET="_blank"><%=Aded.countRequestNodes(rv)%>  <%=r.getString(teasession._nLanguage, "AdRequestNodes")%></A> </td>
				<%}if(Node.countRequestNodes(rv) != 0)
					{%>
						<td><A href="/servlet/NodeRequestNodes" TARGET="_blank"><%=Node.countRequestNodes(rv)%>  <%=r.getString(teasession._nLanguage, "NodeRequestNodes")%></A> </td>
					<%}if(rv.isSupport() && ProfileRequest.countRequests(rv._strR) != 0)
                    {%>
						<td><A href="/servlet/ProfileRequests" TARGET="_blank"><%=ProfileRequest.countRequests(rv._strR)%>  <%=r.getString(teasession._nLanguage, "ProfileRequests")%></A> </td>
<%					}
				}%>
</tr></table>



<TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <%        if((i & 4) != 0)
            {
                for(int l = 0; l < Trade.TRADE_TYPE.length; l++)
                {
                    int j1 = Trade.count(false, rv, l,teasession._strCommunity);%>
					<tr><%if(j1 != 0)
                    {
                        int i2 = Trade.count(false, rv, l, 0,teasession._strCommunity);
                        int j2 = Trade.count(false, rv, l, 4,teasession._strCommunity);
                        int l2 = Trade.count(false, rv, l, 6,teasession._strCommunity);
                        if(i2 != 0)
                        {%>
							<td><A href="/servlet/SaleOrders?type=<%=l%>&Status=<%=0%>" TARGET="_blank"><%=i2%>  <%=r.getString(teasession._nLanguage, Trade.TRADE_STATUS[0])%>  <%=r.getString(teasession._nLanguage, Trade.TRADE_TYPE[l])%>  <%=r.getString(teasession._nLanguage, "SaleOrders")%></A> </td>
                        <%}if(j2 != 0)
						{%>
							<td><A href="/servlet/SaleOrders?type=<%=l%>&Status=4" TARGET="_blank"><%=j2%>  <%=r.getString(teasession._nLanguage, Trade.TRADE_STATUS[4])%>  <%=r.getString(teasession._nLanguage, Trade.TRADE_TYPE[l])%>  <%=r.getString(teasession._nLanguage, "SaleOrders")%></A> </td>
						<%}if(l2 != 0)
						{%>	<td><A href="/servlet/SaleOrders?type=<%=l%>&Status=6" TARGET="_blank"><%=l2%>  <%=r.getString(teasession._nLanguage, Trade.TRADE_STATUS[6])%>  <%=r.getString(teasession._nLanguage, Trade.TRADE_TYPE[l])%>  <%=r.getString(teasession._nLanguage, "SaleOrders")%></A> </td>
                <%      }
				  }
                }

            }%>

</tr></table>

<Table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<% if((i & 8) != 0)
            {
                for(int k1 = 0; k1 < Trade.TRADE_TYPE.length; k1++)
                {
                    int l1 = Trade.count(true, rv, k1,teasession._strCommunity);%>
<tr><td>
       <%             if(l1 != 0)
                    {
                        int k2 = Trade.count(true, rv, k1, 3,teasession._strCommunity);
                        int i3 = Trade.count(true, rv, k1, 7,teasession._strCommunity);
                        int j3 = Trade.count(true, rv, k1, 10,teasession._strCommunity);
                        if(k2 != 0){%>
							<A href="/servlet/PurchaseOrders?type=<%=k1%>&Status=3" TARGET="_blank"><%=k2%>  <%=r.getString(teasession._nLanguage, Trade.TRADE_STATUS[3])%>  <%=r.getString(teasession._nLanguage, Trade.TRADE_TYPE[k1])%>  <%=r.getString(teasession._nLanguage, "PurchaseOrders")%></A> </td><td>
                        <%}if(i3 != 0)
                          {%>
							<A href="/servlet/PurchaseOrders?type=<%=k1%>&Status=7" TARGET="_blank"><%=i3%>  <%=r.getString(teasession._nLanguage, Trade.TRADE_STATUS[7])%>  <%=r.getString(teasession._nLanguage, Trade.TRADE_TYPE[k1])%>  <%=r.getString(teasession._nLanguage, "PurchaseOrders")%></A> 
                        <%}if(j3 != 0)
							{%>
							<A href="/servlet/PurchaseOrders?type=<%=k1%>&Status=10" TARGET="_blank"><%=j3%>  <%=r.getString(teasession._nLanguage, Trade.TRADE_STATUS[10])%>  <%=r.getString(teasession._nLanguage, Trade.TRADE_TYPE[k1])%>  <%=r.getString(teasession._nLanguage, "PurchaseOrders")%></A> 
                    <%		}
						}
                }

            }%>
</tr></table>




<form name="foDelete"  action="/servlet/DeleteReminders">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter"><tr><td><%=r.getString(teasession._nLanguage, "Reminders")%></td></tr><tr><td >
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

<%       boolean flag = false;
		if((i & 0x20) != 0)
            {
                Date date1 = new Date(System.currentTimeMillis());
                Enumeration enumeration1 = Reminder.find(rv, date1);
                if(enumeration1.hasMoreElements())
                {
                    flag = true;
                   // table4.setBorder(1);%>
<tr>
<td>[]</td>
<td><%=r.getString(teasession._nLanguage, "Subject")%></td>
<td><%=r.getString(teasession._nLanguage, "StartTime")%></td>
<td><%=r.getString(teasession._nLanguage, "StopTime")%></td>
<td><%=r.getString(teasession._nLanguage, "DeltaTime")%>(<%=r.getString(teasession._nLanguage, "Days")%>)</td>
<td><%=r.getString(teasession._nLanguage, "RepeatTimes")%></td>
<td><%=r.getString(teasession._nLanguage, "Memo")%></td><td></td></tr><%  for(; enumeration1.hasMoreElements(); )
                    {   int k3 = ((Integer)enumeration1.nextElement()).intValue();
                        Reminder reminder = Reminder.find(k3);
                        int i4 = reminder.getNode();
                        Node node = Node.find(i4);
                        String s = node.getSubject(teasession._nLanguage);
                        String s1 = s;
                        try
                        {
                            byte abyte0[] = s.getBytes();
                            s1 = new String(abyte0, "ISO-8859-1");
                        }
                        catch(Exception exception1) { }
                        String s2 = reminder.getNote();
                        String s3;
                        if(s != null)
                            s3 = s1;
                        else
                            s3 = s2;
                        int i5 = reminder.getOptions();
                        int j5 = reminder.getStatus();
                        String s4 = reminder.getToEmail();
                        Profile profile = Profile.find(rv._strV);
                        String s5 = profile.getEmail();
 						if((i5 & 2) != 0 && (j5 & 2) == 0)
                        {
                            String s6 = "<a href='/servlet/Node?node=" + i4 + "'>" + s3 + "</a><br/>" + s2;
                            int k5 =tea.entity.member. Message.create(teasession._strCommunity, rv, null, 0, 0, 0, 0, teasession._nLanguage, s3, s6, null, null, "", null, rv._strR, "", "", null, null, 0, 0);
                            j5 += 2;
                            reminder.set(j5);
                        }
                        if((i5 & 4) != 0 && (j5 & 4) == 0)
                        {
                            String s7 = "<a href='http://" + request.getServerName() + "/servlet/Node?node=" + i4 + "'>" + s3 + "</a><br/>" + s2;
                            int l5 = tea.entity.member.Message.create(teasession._strCommunity,rv, null, 0, 0, 2, 0, teasession._nLanguage, s3, s7, null, null, "", null, s4, "", "", null, null, 0, 0);
                            try
                            {
                                tea.service.Robot.activateRobot(l5);
                            }
                            catch(Exception exception2) { }
                            j5 += 4;
                            reminder.set(j5);
                        }%>
<tr><td><input  id="CHECKBOX" type="CHECKBOX" name=Reminders VALUE=<%=k3%>></td>
<td><A href="/servlet/Node?node=<%=i4%>"><%=getNull(s)%></A>&nbsp;</td>
<td><%=(new SimpleDateFormat("yyyy.MM.dd hh:mm")).format(reminder.getStartTime())%></td>
<td><%=(new SimpleDateFormat("yyyy.MM.dd hh:mm")).format(reminder.getStopTime())%></td>
<td> <%=reminder.getDeltaTime()%></td>
<td> <%=reminder.getRepeatTimes()%></td>
<td><%=r.getString(teasession._nLanguage, reminder.getNote())%>&nbsp;</td>
<td><input type="button" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" ID="CBEdit" CLASS="CB" onClick="window.open('/servlet/EditReminder?Reminder=<%=k3%>', '_blank');"><input type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" ID="CBDelete" CLASS="CB" onClick="window.open('/servlet/DeleteReminder?Reminder=<%=k3%>', '_blank');"></td></tr><%}%>
<tr><td COLSPAN=9>
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" ID="CBDelete" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteSelected")%>')){window.open('javascript:foDelete.submit();', '_self');}">
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBNew")%>" ID="CBNew" CLASS="CB" onClick="window.open('/servlet/NewReminder', '_blank');">
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBEditAll")%>" ID="CBEditAll" CLASS="CB" onClick="window.open('/servlet/Reminders', '_blank');">
</td></tr></table></td></tr></table>
              <%}
 				Enumeration enumeration2 = Reminder.findPast(rv, date1);
                if(enumeration2.hasMoreElements())
                {
                    Reminder reminder1;
                    int k4;
                    Date date2;
                    Date date3;
                    int l4;
                    for(; enumeration2.hasMoreElements(); reminder1.set(date2, date3, k4, l4))
                    {
                        int l3 = ((Integer)enumeration2.nextElement()).intValue();
                        reminder1 = Reminder.find(l3);
                        int j4 = reminder1.getDeltaTime();
                        k4 = reminder1.getRepeatTimes();
                        date2 = reminder1.getStartTime();
                        date3 = reminder1.getStopTime();
                        date2 = new Date(date2.getTime() + (long)j4 * 0x5265c00L);
                        date3 = new Date(date3.getTime() + (long)j4 * 0x5265c00L);
                        k4--;
                        l4 = 0;
                    }

                }
            }

          /*  if(table != null)
                printwriter.println(table);
            if(table1 != null)
                printwriter.println(table1);
            if(table2 != null)
                printwriter.println(table2);
            if(table3 != null)
                printwriter.println(table3);
            if(flag)
                printwriter.println(form);*/%>
</form>
<input type=SUBMIT name="Submit" class="edit_button" id="edit_submit" VALUE="<%=r.getString(teasession._nLanguage, "Edit")%>" onClick="window.open('/servlet/EditNotification')">

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%>  </div>
</body>
</html>



