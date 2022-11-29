<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
            if(!node.isCreator(teasession._rv))
            {
                response.sendError(403);
                return;
            }
			String s = request.getParameter("Currency");
                boolean flag = s == null;
                int j = 0;
                BigDecimal bigdecimal2 = new BigDecimal(0.0D);
                BigDecimal bigdecimal4 = new BigDecimal(0.0D);
                BigDecimal bigdecimal6 = new BigDecimal(0.0D);
                BigDecimal bigdecimal8 = new BigDecimal(0.0D);
                BigDecimal bigdecimal10 = new BigDecimal(0.0D);
                if(!flag)
                {
                    j = Integer.parseInt(s);
                    BidPrice bidprice1 = BidPrice.find(teasession._nNode, j);
                    bigdecimal2 = bidprice1.getSupply();
                    bigdecimal4 = bidprice1.getList();
                    bigdecimal6 = bidprice1.getAsk();
                    BigDecimal bigdecimal9 = bidprice1.getReserve();
                    bigdecimal10 = bidprice1.getIncrement();
                }
				%>



<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>CBEditBid
<h1><%=r.getString(teasession._nLanguage, "CBEditBid")%></h1>
<div id="head6"><img height="6" src="about:blank"></div> 
<input type='hidden' name=vmember VALUE="webmaster">
 <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%>
      <input type='hidden' name="rmember" value="webmaster">
    </div>
		<FORM name=foEdit METHOD=POST action="/servlet/EditBidPrice" onSubmit="return(submitFloat(this.Supply,'<%=r.getString(teasession._nLanguage, "InvalidSupply")%>')&&submitFloat(this.List,'<%=r.getString(teasession._nLanguage, "InvalidList")%>')&&submitFloat(this.Ask,'<%=r.getString(teasession._nLanguage, "InvalidAsk")%>')&&submitFloat(this.Reserve,'<%=r.getString(teasession._nLanguage, "InvalidReserve")%>')&&submitFloat(this.Increment,'<%=r.getString(teasession._nLanguage, "InvalidIncrement")%>'));">
          <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
          <%if(flag){%>
                 <input type='hidden' name=New VALUE="ON">
          <%}%>
          <table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
            <tr><td><%=r.getString(teasession._nLanguage, "Currency")%>:</td>
<%			if(flag){%>
              <td><input  id="radio" type="radio" name=Currency VALUE=0 CHECKED>
                US$
                <input  id="radio" type="radio" name=Currency VALUE=1>
                &yen;
                <input  id="radio" type="radio" name=Currency VALUE=2>
                HK$
                <input  id="radio" type="radio" name=Currency VALUE=3>
                NT$
                <input  id="radio" type="radio" name=Currency VALUE=4>
                &euro;
                <input  id="radio" type="radio" name=Currency VALUE=5>
                J&yen;
                <input  id="radio" type="radio" name=Currency VALUE=6>
                CC</td>
<%			}else
{%><input type='hidden' name=Currency value=<%=s%>><td>
<%
switch(Integer.parseInt(s))
{ 	case 0:%>US$<%break;
 	case 1:%>&yen;<%break;
	case 2:%>HK$<%break;
 	case 3:%>NT$<%break;
 	case 4:%>&euro;<%break;
 	case 5:%>J&yen;<%break;
 	case 6:%>CC<%break;
}
}%>
            </tr><tr><td><%=r.getString(teasession._nLanguage, "Supply")%>:</td>
              <td><input type="TEXT" class="edit_input"  name=Supply VALUE="<%=bigdecimal2%>" SIZE=4></td>
            </tr><tr><td><%=r.getString(teasession._nLanguage, "List")%></td>
              <td><input type="TEXT" class="edit_input"  name=List VALUE="<%=bigdecimal4%>" SIZE=4></td>
            </tr><tr><td><%=r.getString(teasession._nLanguage, "Ask")%></td>
              <td><input type="TEXT" class="edit_input"  name=Ask VALUE="<%=bigdecimal6%>" SIZE=4></td>
            </tr><tr><td><%=r.getString(teasession._nLanguage, "Reserve")%>:</td>
              <td><input type="TEXT" class="edit_input"  name=Reserve VALUE="<%=bigdecimal6%>" SIZE=4></td>
            </tr><tr><td><%=r.getString(teasession._nLanguage, "Increment")%></td>
              <td><input type="TEXT" class="edit_input"  name=Increment VALUE="<%=bigdecimal10%>" SIZE=4></td>
            </tr></table>
          <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
        </FORM>
        <SCRIPT>document.foEdit.List.focus();</SCRIPT>
		<div id="head6"><img height="6" src="about:blank"></div>
        <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

<%----%>
</body>
</html>

