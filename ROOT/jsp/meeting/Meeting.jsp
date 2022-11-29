<%@page contentType="text/html;charset=UTF-8" buffer="none" %>
<%@include file="/jsp/Header.jsp"%>
<html>
<head>
<META HTTP-EQUIV=Content-Type CONTENT="text/html; charset=<%=TeaServlet.CHARSET[teasession._nLanguage]%>">
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="__refresh" content="2">
</head>
<body onload="">
<h1><%=r.getString(teasession._nLanguage, "Meeting")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>


<%
            int i = 0;
            boolean loop=true;
            do
            {
              System.out.println(i);
                for(Enumeration enumeration = Meeting.findByMember(teasession._rv, i); enumeration.hasMoreElements(); out.flush())
                {
                    i = ((Integer)enumeration.nextElement()).intValue();

                    Meeting meeting = Meeting.find(i);
                    RV rv = meeting.getFrom();
                    int j = meeting.getAction();
                    if(j == 2 || j == 3)
                    {%>
                    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>
<%=rv%>
(<%=(new SimpleDateFormat("HH:mm")).format(meeting.getTime())%>)
<td>
<%                      if(meeting.getPictureFlag())
                        {%>
<br/>
<IMG BORDER=0 SRC="/servlet/MeetingPicture?Meeting=<%=i%>" ALT="<%=meeting.getAlt(teasession._nLanguage)%>" ALIGN="<%=meeting.getAlign()%>">
<%                      }%>
<%=meeting.getText(teasession._nLanguage)%>
<%                      if(meeting.getVoiceFlag())
                        {%>
<A href="/servlet/MeetingVoice?Meeting=<%=i%>"><%=r.getCommandImg(teasession._nLanguage, "Play")%></A>
<%                      }%>
<%                      if(meeting.getFileFlag())
                        {%>
<A href="/servlet/MeetingFile?Meeting=<%=i%>"><%=r.getCommandImg(teasession._nLanguage, "Download")%></A> <BR CLEAR=ALL>
<%                      }// printwriter.print(new Break(2));%>
</td></tr></table>
<%                    }
                    if(j == 3 && rv.equals(teasession._rv))
                    {
                        out.close();
                        return;
                    }
%>
<SCRIPT type="">self.scrollBy(0,801);</SCRIPT>
<%              }


                try
                {
                    Thread.currentThread().sleep(2000L);
                }catch(Exception exception1)
                {
                    exception1.printStackTrace();
                }
            } while(loop);//true
%>

















<span id=showImport></span>
<IE:Download ID="oDownload" STYLE="behavior:url(#default#download)" />
<script type="">
function onDownloadDone(downDate)
{
showImport.innerHTML=downDate
}
function load()
{
//oDownload.startDownload('/jsp/meeting/MeetingList.jsp?community=<%=node.getCommunity()%>&node=<%=teasession._nNode%>',onDownloadDone);
};
//window.setInterval(load,2000);
</script>
<div id="head6"><img height="6" alt=""></div>
</body>
</html>

