<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>


<%
            if(!node.isCreator(teasession._rv))
            {
                response.sendError(403);
                return;
            }
            News news = News.find(teasession._nNode);
%>



<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "EditNews")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<input type='hidden' name="rmember" VALUE="webmaster">
<input type='hidden' name=vmember VALUE="webmaster">


  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>


 <FORM name=foEdit METHOD=POST action="/servlet/EditNews">
          <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr><TD><A href="/servlet/Search?type=27" TARGET="_blank"><%=r.getString(teasession._nLanguage, "Reporter")%>:</A> </TD>
              <td><input type="TEXT" class="edit_input"  name=Reporter SIZE=40 VALUE="<%=getNull(news.getReporter(teasession._nLanguage))%>" MAXLENGTH=40></td>
            </tr><tr><TD><A href="/servlet/Search?type=22" TARGET="_blank"><%=r.getString(teasession._nLanguage, "Press")%>:</A> </TD>
              <td><input type="TEXT" class="edit_input"  name=Press SIZE=40 VALUE="<%=getNull(news.getPress(teasession._nLanguage))%>" MAXLENGTH=40></td>
            </tr><tr><TD><A href="/servlet/Search?type=16" TARGET="_blank"><%=r.getString(teasession._nLanguage, "Location")%>:</A> </TD>
              <td><input type="TEXT" class="edit_input"  name=Location SIZE=40 VALUE="<%=getNull(news.getLocation(teasession._nLanguage))%>" MAXLENGTH=40></td>
            </tr>
            <!--tr><TD><%=r.getString(teasession._nLanguage, "media")%>:</TD>
              <td><SELECT name=dropdown>
                  <OPTION VALUE="1">新华社</OPTION>
                  <OPTION VALUE="2">人民日报</OPTION>
                  <OPTION VALUE="32">光明日报</OPTION>
                </SELECT>
                <br/></td>
            </tr><tr><TD><%=r.getString(teasession._nLanguage, "class")%>:</TD>
              <td><SELECT name=class>
                  <OPTION VALUE="1">媒体</OPTION>
                  <OPTION VALUE="2">股票</OPTION>
                  <OPTION VALUE="3">工程</OPTION>
                </SELECT>
                <br/></td>
            </tr--><tr><TD><%=r.getString(teasession._nLanguage, "IssueTime")%>:</TD>
   <td><%=new TimeSelection("Issue", news.getIssueTime())%></tr></table>
          <P ALIGN=CENTER>
            <input type="submit" name="GoBack" id="edit_GoBack" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
            <input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
          </P>
</form>
		<div id="head6"><img height="6" src="about:blank"></div>
        <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>

