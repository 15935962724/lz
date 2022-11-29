<%@page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/Header.jsp" %>
<%
r.add("/tea/ui/node/type/buy/EditCommodity");
            if(!node.isCreator(teasession._rv))
            {
                response.sendError(403);
                return;
            }
            int i = node.getType();
            Commodity commodity = Commodity.find(teasession._nNode);
int k = node.getOptions1();
			%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBEditBid")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<input type='hidden' name="rmember" VALUE="webmaster">
<input type='hidden' name=vmember VALUE="webmaster">
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<FORM name=foEdit METHOD=POST action="/servlet/EditBid">
  <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
  <table cellspacing="0" cellpadding="0" bordr="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Options")%>:</td>
      <%
       switch(i)
                {
                case 4: // '\004'%>
      <td><input  id="CHECKBOX" type="CHECKBOX" name=BuyOFast value=null <%=getCheck((k & 1) != 0)%>>
        <%=r.getString(teasession._nLanguage, "BuyOFast")%>
        <%       break;
                case 5: // '\005'%>
      <td><input  id="CHECKBOX" type="CHECKBOX" name=BidOOnce value=null <%=getCheck((k & 1) != 0)%>>
        <%=r.getString(teasession._nLanguage, "BidOOnce")%>
        <%                   break;
                case 6: // '\006'%>
      <td><input  id="CHECKBOX" type="CHECKBOX" name=BargainOOnce value=null <%=getCheck((k & 1) != 0)%>>
        <%=r.getString(teasession._nLanguage, "BargainOOnce")%>
        <%                  break;
                }
%>
        <input  id="CHECKBOX" type="CHECKBOX" name=BuyOFreeShipping value=null <%=getCheck((k & 2) != 0)%>>
        <%=r.getString(teasession._nLanguage, "BuyOFreeShipping")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Supplier")%>:</td>
      <td><input type="TEXT" class="edit_input"  name=Supplier SIZE=20 MAXLENGTH=40 value=<%=getNull(commodity.getSupplier())%>></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "SKU")%>:</td>
      <td><input type="TEXT" class="edit_input"  name=SKU SIZE=40 MAXLENGTH=40 value=<%=getNull(commodity.getSKU())%>></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "SerialNumber")%>:</td>
      <td><input type="TEXT" class="edit_input"  name=SerialNumber SIZE=40 MAXLENGTH=40 value=<%=getNull(commodity.getSerialNumber())%>></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Quality")%>:</td>
      <td><input  id="radio" type="radio" id="radio" name=Quality VALUE=0 <%=getCheck(0== commodity.getQuality())%>>
        <%=r.getString(teasession._nLanguage, Commodity.QUALITY[0])%>
        <input  id="radio" type="radio" id="radio" name=Quality VALUE=1 <%=getCheck(1== commodity.getQuality())%>>
        <%=r.getString(teasession._nLanguage, Commodity.QUALITY[1])%>
        <input  id="radio" type="radio" id="radio" name=Quality VALUE=2 <%=getCheck(2== commodity.getQuality())%>>
        <%=r.getString(teasession._nLanguage, Commodity.QUALITY[2])%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Inventory")%>:</td>
      <td><input type="TEXT" class="edit_input"  name=Inventory VALUE="<%=commodity.getInventory()%>" SIZE=10></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "MinQuantity")%>:</td>
      <td><input type="TEXT" class="edit_input"  name=MinQuantity VALUE="<%=commodity.getMinQuantity()%>" SIZE=10></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "MaxQuantity")%>:</td>
      <td><input type="TEXT" class="edit_input"  name=MaxQuantity VALUE="<%=commodity.getMaxQuantity()%>" SIZE=10></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Delta")%>:</td>
      <td><input type="TEXT" class="edit_input"  name=Delta VALUE="<%=commodity.getDelta()%>" SIZE=10></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Weight")%>:</td>
      <td><input type="TEXT" class="edit_input"  name=Weight VALUE="<%=commodity.getWeight()%>" SIZE=10>
        <%=r.getString(teasession._nLanguage, "gram")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Volume")%>:</td>
      <td><input type="TEXT" class="edit_input"  name=Volume VALUE="<%=commodity.getVolume()%>" SIZE=10>
        <%=r.getString(teasession._nLanguage, "cm3")%></td>
    </tr>
  </table>
  <P ALIGN=CENTER>
    <input type="submit" name="GoBack" id="edit_GoBack" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <input type=SUBMIT name="GoNext" id="edit_GoNext" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "CBNext")%>">
    <input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
  </P>
</FORM>
<SCRIPT>document.foEdit.SKU.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage, request)%></div>
<%----%>
</body>
</html>

