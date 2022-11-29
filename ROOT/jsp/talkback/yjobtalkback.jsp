<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.io.*" %><%@page import="tea.resource.*" %>
<%@page import="javax.servlet.ServletConfig" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.html.*"%>
<%response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
Resource r = new Resource();TeaSession teasession = new TeaSession(request);
     Node   node=Node.find(teasession._nNode);
            long i = node.getOptions();
            boolean flag = (i & 0x8000) != 0;
if(teasession._rv == null && !flag)
            {response.sendRedirect("/servlet/StartLogin");
return;
}
boolean flag1 = node.isCreator(teasession._rv);

r.add("/tea/ui/node/talkback/TalkbackServlet");
            int l = Integer.parseInt(request.getParameter("Talkback"));
                    Talkback talkback = Talkback.find(l);
                    RV rv = talkback.getCreator();
                    java.util.Date date = talkback.getTime();
                     String dat=(new SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(date);
                    talkback.getStatus();
                    int kk=talkback.getHint();
                    String pic=HintImg.HINT[kk];
					String subject=talkback.getSubject(1);
				    String creator=rv._strR;
					if (creator=="")
						creator="匿名";
					String content=talkback.getContent(teasession._nLanguage);
            int j = talkback.findNext();
            int k = talkback.findPrev();

            Purview purview=Purview.find(teasession._rv.toString(),teasession._strCommunity);
%>

<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<body>
<%@include file="/jsp/type/job/cnoocjobheader.jsp" %>

    <div id="edit_BodyDiv">

<TABLE CELLSPACING=0 CELLPADDING=0 class="section">
<TR><TD><%=r.getString(teasession._nLanguage, "Poster")%>:</TD><TD><%=creator%></TD></TR>
<TR><TD><%=r.getString(teasession._nLanguage, "Time")%>:</TD><TD><%=dat%></TD></TR>
<TR><TD><%=r.getString(teasession._nLanguage, "Subject")%>:</TD><TD>
<IMG BORDER=0 SRC="/tea/image/hint/<%=pic%>.gif"><%=subject%></TD>
</TR></TABLE><br><%=content%>

  <%/*
              String picturefile1 =getServletContext().getRealPath("/tea/image/talkback/"+i+".jpg");
            File file1=new File(picturefile1);
			if (file1.exists())
			{
			   Image image1 = new Image("/tea/image/talkback/" + i+".jpg");
               				  out.print(image1);

			  } */
			  String picture=talkback.getPicture(teasession._nLanguage);
			    if(picture!=null&&picture.length()>0)
			    {
			      out.print(new Image(picture));
			    }
			    String voice=talkback.getVoice(teasession._nLanguage);
			    if(voice!=null&&voice.length()>0)
    {%>
	<input type=button class="edit_input" onClick="window.open('<%=voice%>','_self');" value="<%=r.getString(teasession._nLanguage, "CBPlay")%>" >

  <%}
			    String file=talkback.getFileData(teasession._nLanguage);
			    if(file!=null&&file.length()>0)
    {%><%=new String(talkback.getFileName(teasession._nLanguage).getBytes("iso-8859-1"))%><input type=button class="edit_input" onClick="window.open('<%=file%>','_self');" value="<%=r.getString(teasession._nLanguage, "Download")%>" >

<%  }
    %>
<HR SIZE=1><%
if(j != 0)
{
	subject=Talkback.find(j).getSubject(1);
	%>
<%=r.getString(teasession._nLanguage, "CBPrevious")%>:<A HREF="cnoocjobtalkback.jsp?node=<%=teasession._nNode%>&Talkback=<%=j%>" ID=TalkbackIndex><%=subject%></A> <br/>
<%}
if(k != 0)
{	subject=Talkback.find(k).getSubject(1);

%><%=r.getString(teasession._nLanguage, "Next")%>: <A HREF="cnoocjobtalkback.jsp?node=<%=teasession._nNode%>&Talkback=<%=k%>" ID=TalkbackIndex><%=subject%></A> <br/>
<%
}%>
</div>
<%@include file="/jsp/type/job/cnoocjobfooter.jsp" %>
</body>
</html>

