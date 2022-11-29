<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%r.add("/tea/ui/member/profile/ProfileServlet");
if(!teasession._rv.isAccountant())
            {
                 response.sendError(403);
                return;
            }
            String s =  request.getParameter("BuyInstruction");
            boolean flag = s == null;
			int i = 0;
                String s1 = "";
                if(!flag)
                {
                    BuyInstruction buyinstruction = BuyInstruction.find(Integer.parseInt(s));
                    i = buyinstruction.getCurrency();
                    s1 = buyinstruction.getText(teasession._nLanguage);
                }

%>










<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<input type='hidden' name="rmember" VALUE="webmaster">
<input type='hidden' name=vmember VALUE="webmaster">

<h1><%=r.getString(teasession._nLanguage, "Edit")%><%=r.getString(teasession._nLanguage, "BuyInstruction")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<FORM name=foEdit METHOD=POST action="/servlet/EditBuyInstruction">
<%if(!flag){%>
	<input type='hidden' name=BuyInstruction VALUE="<%=s%>">
<%}%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter"><tr><TD><%=r.getString(teasession._nLanguage, "Currency")%>:</TD>
<td>
<%if(!flag)
{%><input type='hidden' name=Currency VALUE="<%=i%>">
<%	switch(i)
	{	 case 0:%>US$<%break;
		 case 1:%>&yen;<%break;
		case 2:%>HK$<%break;
		 case 3:%>NT$<%break;
		 case 4:%>&euro;<%break;
		 case 5:%>J&yen;<%break;
		 case 6:%>CC<%
    }
}else
{%>
<input  id="radio" type="radio" name=Currency VALUE=0 checked>US$
<input  id="radio" type="radio" name=Currency VALUE=1 >&yen;
<input  id="radio" type="radio" name=Currency VALUE=2 >HK$
<input  id="radio" type="radio" name=Currency VALUE=3 >NT$
<input  id="radio" type="radio" name=Currency VALUE=4 >&euro;
<input  id="radio" type="radio" name=Currency VALUE=5 >J&yen;
<input  id="radio" type="radio" name=Currency VALUE=6 >CC</td></tr><%}%>
<tr><TD><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
<td>
<TEXTAREA name="Text" ROWS=8 COLS=60><%=HtmlElement.htmlToText(s1)%></TEXTAREA></td></tr><tr><td></td><td>
<input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
</td></tr></table>
</FORM>
<SCRIPT>document.foEdit.Text.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div><%----%>
</body>
</html>

