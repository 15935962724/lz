<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
 tea.entity.node.Indict indict= tea.entity.node.Indict .find(teasession._nNode,teasession._nLanguage);
r.add("/tea/resource/Indict");
%>
<head>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
  </head>
   <body><h1><%=r.getString(teasession._nLanguage, "BgEditIndict")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

  <FORM NAME="form1" METHOD="post" ACTION="/servlet/EditIndict" onsubmit="return submitText(form1.handler, '处理人 无效')&&submitText(form1.result, '处理结果 无效')">
    <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Subject")%></TD>
      <TD><%=tea.html.HtmlElement.htmlToText(node.getSubject(teasession._nLanguage))%></TD>
    </TR>
       <TR>
      <TD><%=r.getString(teasession._nLanguage, "Plaintiff")%></TD>
      <TD><%=node.getCreator()%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Appellee")%></TD>
      <TD><%=indict.getAppellee()%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "SOrder")%></TD>
      <TD><%=indict.getSorder()%></TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Text")%></TD>
      <TD><%=tea.html.HtmlElement.htmlToText(node.getText(teasession._nLanguage))%></TD>
    </TR>
        <TR>
      <TD><%=r.getString(teasession._nLanguage, "Time")%></TD>
      <TD><%=node.getTime()%></TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Handler")%></TD>
      <TD><INPUT NAME="handler" TYPE="text" SIZE="70" value="<%
      if(indict.getHandler()!=null&&indict.getHandler().length()>0)
      out.print(indict.getHandler());
      else
      out.print(teasession._rv);
      %>" MAXLENGTH="50"></TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Result")%></TD>
      <TD><TEXTAREA NAME="result" COLS="60" ROWS="6"><%=tea.html.HtmlElement.htmlToText(indict.getResult())%></TEXTAREA></TD>
    </TR>
  </TABLE>
  <INPUT TYPE="submit" NAME="Submit" VALUE="Submit">
  </FORM><div id="head6"><img height="6" src="about:blank"></div>

  <script type="text/javascript">form1.handler.focus();</script>

