<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/ui/member/profile/ProfileServlet");
int i = BuyInstruction.count(teasession._rv._strR);
%>


<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=i%><%=r.getString(teasession._nLanguage, "BuyInstructions")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<div id="PathDiv"><%=ts.hrefGlance(teasession._rv)%>
><A href="/servlet/Profile"><%=r.getString(teasession._nLanguage, "Profile")%></A> ><%=r.getString(teasession._nLanguage, "BuyInstructions")%></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter"><%
 if(i != 0)
{
%> <tr ID=tableonetr><TD><%=r.getString(teasession._nLanguage, "Currency")%></TD><TD></TD><TD></TD></tr><%              for(Enumeration enumeration = BuyInstruction.find(teasession._rv._strR); enumeration.hasMoreElements();)
                {
                    int j = ((Integer)enumeration.nextElement()).intValue();
                    BuyInstruction buyinstruction = BuyInstruction.find(j);
%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''"><TD><%=r.getString(teasession._nLanguage, Common.CURRENCY[buyinstruction.getCurrency()])%></TD>
<td><%=buyinstruction.getText(teasession._nLanguage)%></td>
<td><input type="button" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" ID="CBEdit" CLASS="CB" onClick="window.open('/servlet/EditBuyInstruction?BuyInstruction=<%=j%>', '_self');">
<%if(buyinstruction.isLayerExisted(teasession._nLanguage))
{%>
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" ID="CBDelete" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){window.open('/servlet/DeleteBuyInstruction?BuyInstruction=<%=j%>', '_self');}"></td></tr><%
}
}
}
%>
</table>
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBNew")%>" ID="CBNew" CLASS="CB" onClick="window.open('/servlet/EditBuyInstruction', '_self');">

 <div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>

