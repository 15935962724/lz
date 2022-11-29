<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%

int listing= Integer.parseInt(teasession.getParameter("listing"));
Listing obj = Listing.find(listing);

Node node = Node.find(obj.getNode());
if(!node.isCreator(teasession._rv)&&AccessMember.find(node._nNode, teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}
int i1=255;

r.add("/tea/resource/Search");

Search search=Search.find(listing);
String strSubmit;
int nodeCode;
int termOrder[]=new int[9];
String searchListing;
boolean context;
if(search.exists())
{
  context=search.isContext();
  strSubmit=search.getTerm(8,teasession._nLanguage);
  nodeCode=search.getSearchNode();
  for(int index=0;index<termOrder.length;index++)
  {
    termOrder[index]=search.getOrder(index+1,teasession._nLanguage);
  }
}else
{
  for(int index=0;index<termOrder.length;index++)
  termOrder[index]=index+1;
  searchListing="";
  strSubmit="<INPUT TYPE=SUBMIT VALUE=SUBMIT >";
  nodeCode=teasession._nNode;
  context=true;
}
int type=search.getType();
if(request.getParameter("type")!=null)
type=Integer.parseInt(request.getParameter("type"));


%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Search")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<br>

<FORM name=foEdit METHOD=POST action="/servlet/EditSearch" >
  <input type=hidden name="listing" value="<%=listing%>">
  <input type=hidden name="node" value="<%=teasession._nNode%>">

  <TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <TD><%=r.getString(teasession._nLanguage, "Node")%></TD>
      <td><input type="text" class="edit_input" name="searchnode" value="<%=nodeCode%>"></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <TD><%=r.getString(teasession._nLanguage, "Listing")%></TD>
      <td colspan="3"> <%
        java.util.Enumeration  enumeration=search.getSearchListing();
        while(enumeration.hasMoreElements())
        {%>
        <input type="text" name="searchlisting"  class="edit_input"  value="<%=enumeration.nextElement()%>" size="5">
        <%}
        %>
        <input type="text" name="searchlisting"  class="edit_input"  size="5" onChange="this.onkeyup();" onKeyUp="document.getElementById('sl_1').style.display='';">
        <input type="text" name="searchlisting"  class="edit_input"  size="5" onChange="this.onkeyup();"  onkeyup="document.getElementById('sl_2').style.display='';" id="sl_1"  style="display:none">
        <input type="text" name="searchlisting"  class="edit_input"  size="5"  onchange="this.onkeyup();" onKeyUp="document.getElementById('sl_3').style.display='';" id="sl_2"  style="display:none">
        <input type="text" name="searchlisting"  class="edit_input"  size="5" onChange="this.onkeyup();"  onkeyup="document.getElementById('sl_4').style.display='';" id="sl_3"  style="display:none">
        <input type="text" name="searchlisting"   class="edit_input"  size="5" onChange="this.onkeyup();" onKeyUp="document.getElementById('sl_5').style.display='';" id="sl_4"  style="display:none">
        <input type="text" name="searchlisting"  class="edit_input"  size="5" onChange="this.onkeyup();"  onkeyup="document.getElementById('sl_6').style.display='';" id="sl_5"  style="display:none">
        <input type="text" name="searchlisting"  class="edit_input"  size="5" onChange="this.onkeyup();"  onkeyup="document.getElementById('sl_7').style.display='';" id="sl_6"  style="display:none">
        <input type="text" name="searchlisting"  class="edit_input"  size="5" onChange="this.onkeyup();"  onkeyup="document.getElementById('sl_8').style.display='';" id="sl_7"  style="display:none">
        <input type="text" name="searchlisting"  class="edit_input"  size="5" onChange="this.onkeyup();"  onkeyup="document.getElementById('sl_9').style.display='';" id="sl_8"  style="display:none">
        <input type="text" name="searchlisting"  class="edit_input"  size="5" onChange="this.onkeyup();"  onkeyup="document.getElementById('sl_10').style.display='';" id="sl_9"  style="display:none">
        <input type="text" name="searchlisting"  class="edit_input"  size="5" id="sl_10"  style="display:none">
      </td>
    </tr>
    <tr>
      <TD><%=r.getString(teasession._nLanguage, "Type")%></TD>
      <td><SELECT name=type onChange="window.open('EditSearch.jsp?node=<%=teasession._nNode%>&listing=<%=listing%>&type='+window.document.foEdit.type.options[window.document.foEdit.type.selectedIndex].value,'_self');">
          <OPTION <%=getSelect(type==255)%> VALUE="255" ><%=r.getString(teasession._nLanguage, "AllTypes")%></OPTION>
          <%
            for(int ii=2;ii<Node.NODE_TYPE.length;ii++)
            {
              out.print("<OPTION VALUE="+ii);
              if(type==ii)
              out.print(" selected ");
              out.println(">"+r.getString(teasession._nLanguage,Node.NODE_TYPE[ii]));
            }
            %>
        </SELECT></td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="context" <%=getCheck(context)%>/>
        <%=r.getString(teasession._nLanguage, "Context")%></td>
    </tr>
    <tr>
      <TD><%=r.getString(teasession._nLanguage, "Term")%>1</TD>
      <td><input name="term1" type="text"  class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(search.getTerm(1,teasession._nLanguage))%>" size="50"></td>
      <td>
      <jsp:include page="/jsp/include/Type.jsp">
      <jsp:param name="type" value="<%=type%>" />
      <jsp:param name="name" value="field1" />
      <jsp:param name="value" value="<%=search.getField(1,teasession._nLanguage)%>" />
      </jsp:include>
	</td>
      <td><%=r.getString(teasession._nLanguage, "Sequence")%>
        <input name="sequence1" type="text" value="<%=(termOrder[0])%>" maxlength="3" size="4"></td>
    </tr>
    <tr>
      <TD><%=r.getString(teasession._nLanguage, "Term")%>2</TD>
      <td><input name="term2" type="text"  class="edit_input"  mask="max" value="<%=HtmlElement.htmlToText(search.getTerm(2,teasession._nLanguage))%>" size="50"></td>
      <td>
      <jsp:include page="/jsp/include/Type.jsp">
	      <jsp:param name="type" value="<%=type%>" />
	      <jsp:param name="name" value="field2" />
	      <jsp:param name="value" value="<%=search.getField(2,teasession._nLanguage)%>" />
      </jsp:include>
      </td>
      <td><%=r.getString(teasession._nLanguage, "Sequence")%>
        <input name="sequence2" type="text" value="<%=(termOrder[1])%>" maxlength="3" size="4"></td>
    </tr>
    <tr>
      <TD><%=r.getString(teasession._nLanguage, "Term")%>3</TD>
      <td><input name="term3" type="text"  class="edit_input"  mask="max" value="<%=HtmlElement.htmlToText(search.getTerm(3,teasession._nLanguage))%>" size="50"></td>
      <td>
            <jsp:include page="/jsp/include/Type.jsp">
	      <jsp:param name="type" value="<%=type%>" />
	      <jsp:param name="name" value="field3" />
	      <jsp:param name="value" value="<%=search.getField(3,teasession._nLanguage)%>" />
      </jsp:include>
	</td>
      <td><%=r.getString(teasession._nLanguage, "Sequence")%>
        <input name="sequence3" type="text" value="<%=(termOrder[2])%>" maxlength="3" size="4"></td>
    </tr>
    <tr>
      <TD><%=r.getString(teasession._nLanguage, "Term")%>4</TD>
      <td><input name="term4" type="text"  class="edit_input" mask="max"  value="<%=HtmlElement.htmlToText(search.getTerm(4,teasession._nLanguage))%>" size="50"></td>
      <td>
                  <jsp:include page="/jsp/include/Type.jsp">
	      <jsp:param name="type" value="<%=type%>" />
	      <jsp:param name="name" value="field4" />
	      <jsp:param name="value" value="<%=search.getField(4,teasession._nLanguage)%>" />
      </jsp:include>
      </td>
      <td><%=r.getString(teasession._nLanguage, "Sequence")%>
        <input name="sequence4" type="text" value="<%=(termOrder[3])%>" maxlength="3" size="4"></td>
    </tr>
    <tr>
      <TD><%=r.getString(teasession._nLanguage, "TermBig")%></TD>
      <td><input name="termBig" type="text"  class="edit_input" title="检索库中的'大于等于'本条件的数据"  mask="max" value="<%=HtmlElement.htmlToText(search.getTerm(5,teasession._nLanguage))%>" size="50"></td>
      <td>
      <jsp:include page="/jsp/include/Type.jsp">
	      <jsp:param name="type" value="<%=type%>" />
	      <jsp:param name="name" value="field5" />
	      <jsp:param name="than" value="ON" />
	      <jsp:param name="value" value="<%=search.getField(5,teasession._nLanguage)%>" />
      </jsp:include>
        <%--<select name="">
  <OPTION  VALUE="0" ><%=r.getString(teasession._nLanguage, "None")%></OPTION>
  <OPTION  VALUE="255"   ><%=r.getString(teasession._nLanguage, "Text")%></OPTION>
  <OPTION  VALUE="255"  ><%=r.getString(teasession._nLanguage, "Subject")%></OPTION>
  <option value="Name"><%=r.getString(teasession._nLanguage,"Name")%></option>
  <option value="Type"><%=r.getString(teasession._nLanguage,"Type")%></option>
  <option value="Area"><%=r.getString(teasession._nLanguage,"Area")%></option>
  <option value="MusicType"><%=r.getString(teasession._nLanguage,"MusicType")%></option>
  <option value="DeilStyle"><%=r.getString(teasession._nLanguage,"DeilStyle")%></option>
  <option value="Circumstance"><%=r.getString(teasession._nLanguage,"Circumstance")%></option>
  <option value="Synopsis"><%=r.getString(teasession._nLanguage,"Synopsis")%></option>
  <option value="Capability"><%=r.getString(teasession._nLanguage,"Capability")%></option>
  <option value="Payment"><%=r.getString(teasession._nLanguage,"Payment")%></option>
  <option value="Intro"><%=r.getString(teasession._nLanguage,"Intro")%></option>
  <option value="Trait"><%=r.getString(teasession._nLanguage,"Grade")%></option>
  <option value="Depreciate"><%=r.getString(teasession._nLanguage,"Depreciate")%></option>
  <option value="Address"><%=r.getString(teasession._nLanguage,"Address")%></option>
  <option value="Principal"><%=r.getString(teasession._nLanguage,"Principal")%></option>
  <option value="Phone"><%=r.getString(teasession._nLanguage,"Phone")%></option>
  <option value="Fax"><%=r.getString(teasession._nLanguage,"Fax")%></option>
  <option value="Postalcode"><%=r.getString(teasession._nLanguage,"Postalcode")%></option>
  <option value="Cooperate"><%=r.getString(teasession._nLanguage,"Cooperate")%></option>
  <option value="Sponsor"><%=r.getString(teasession._nLanguage,"Sponsor")%></option>
  <option value="Acreage"><%=r.getString(teasession._nLanguage,"Acreage")%></option>
  <option value="AverageConsume"><%=r.getString(teasession._nLanguage,"AverageConsume")%></option>
  <option value="Consume"><%=r.getString(teasession._nLanguage,"Consume")%></option>
  <option value="Price"><%=r.getString(teasession._nLanguage,"Price")%></option>
  <option value="Among"><%=r.getString(teasession._nLanguage,"Among")%></option>
  <option value="Operation"><%=r.getString(teasession._nLanguage,"Operation")%></option>
  <option value="Loo"><%=r.getString(teasession._nLanguage,"Loo")%></option>
  <option value="Destine"><%=r.getString(teasession._nLanguage,"Destine")%></option>
  <option value="Block"><%=r.getString(teasession._nLanguage,"Block")%></option>
  <option value="CoverCharge"><%=r.getString(teasession._nLanguage,"CoverCharge")%></option>
  <option value="Member"><%=r.getString(teasession._nLanguage,"Member")%></option>
  <option value="[Browse]"><%=r.getString(teasession._nLanguage,"Browse")%></option>
  <option value="Email"><%=r.getString(teasession._nLanguage,"Email")%></option>
  <option value="Ticket"><%=r.getString(teasession._nLanguage,"Ticket")%></option>
  <option value="HolisticMark"><%=r.getString(teasession._nLanguage,"HolisticMark")%></option>
  <option value="AuraMark"><%=r.getString(teasession._nLanguage,"AuraMark")%></option>
  <option value="ServeMark"><%=r.getString(teasession._nLanguage,"ServeMark")%></option>
  <option value="MusicMark"><%=r.getString(teasession._nLanguage,"MusicMark")%></option>
  <option value="CrowdMark"><%=r.getString(teasession._nLanguage,"CrowdMark")%></option>
  <option value="DrinkMark"><%=r.getString(teasession._nLanguage,"DrinkMark")%></option>
  <option value="DeliMark"><%=r.getString(teasession._nLanguage,"DeliMark")%></option>
  <option value="ToiletMark"><%=r.getString(teasession._nLanguage,"ToiletMark")%></option>
  <option value="RelaxMark"><%=r.getString(teasession._nLanguage,"RelaxMark")%></option>
  <option value="LamplightMark"><%=r.getString(teasession._nLanguage,"LamplightMark")%></option>
  <option value="TemperatureMark"><%=r.getString(teasession._nLanguage,"TemperatureMark")%></option>
  <option value="AirMark"><%=r.getString(teasession._nLanguage,"AirMark")%></option>
  <option value="SafetyMark"><%=r.getString(teasession._nLanguage,"SafetyMark")%></option>
  <option value="BelleMark"><%=r.getString(teasession._nLanguage,"BelleMark")%></option>
  <option value="PriceMark"><%=r.getString(teasession._nLanguage,"PriceMark")%></option>
</select>--%></td>
      <td><%=r.getString(teasession._nLanguage, "Sequence")%>
        <input name="sequenceBig" type="text" value="<%=(termOrder[4])%>" maxlength="3" size="4"></td>
    </tr>
    <tr>
      <TD><%=r.getString(teasession._nLanguage, "TermSmall")%></TD>
      <!--.offsetLeft-->
      <td><input name="termSmall" type="text" class="edit_input"  ondblclick="showMax(document.foEdit.termSmall,120)"  value="<%=HtmlElement.htmlToText(search.getTerm(6,teasession._nLanguage))%>" size="50"></td>
      <td>
                        <jsp:include page="/jsp/include/Type.jsp">
	      <jsp:param name="type" value="<%=type%>" />
	      <jsp:param name="name" value="field6" />
	      <jsp:param name="value" value="<%=search.getField(6,teasession._nLanguage)%>" />
      </jsp:include>
	</td>
      <td><%=r.getString(teasession._nLanguage, "Sequence")%>
        <input name="sequenceSmall" type="text" value="<%=(termOrder[5])%>" maxlength="3" size="4"></td>
    </tr>
    <tr>
      <TD><%=r.getString(teasession._nLanguage, "Order")%></TD>
      <td><input name="termOrder" type="text"  class="edit_input" onDblClick="showMax(document.foEdit.termOrder)"  value="<%=HtmlElement.htmlToText(search.getTerm(7,teasession._nLanguage))%>" size="50" ></td>
      <td><!----------------------------------------------------------------------------------------------------->
      <jsp:include page="/jsp/include/Type.jsp">
	      <jsp:param name="type" value="<%=type%>" />
	      <jsp:param name="name" value="fieldOrder" />
	      <jsp:param name="order" value="ON" />
	      <jsp:param name="value" value="<%=search.getField(7,teasession._nLanguage)%>" />
      </jsp:include>
        <!-----------------------------------------------------------------------------------------------------> </td>
      <td><%=r.getString(teasession._nLanguage, "Sequence")%>
        <input name="sequenceOrder" type="text" value="<%=(termOrder[6])%>" maxlength="3" size="4"></td>
    </tr>
    <tr>
      <TD><%=r.getString(teasession._nLanguage, "Amount")%></TD>
      <!--.offsetLeft-->
      <td><input name="termAmount" type="text" class="edit_input"  ondblclick="showMax(document.foEdit.termAmount,120)"  value="<%=HtmlElement.htmlToText(search.getTerm(9,teasession._nLanguage))%>" size="50"></td>
      <td>
            <jsp:include page="/jsp/include/Type.jsp">
	      <jsp:param name="type" value="<%=type%>" />
	      <jsp:param name="name" value="fieldAmount" />
	      <jsp:param name="order" value="ON" />
	      <jsp:param name="value" value="<%=search.getField(9,teasession._nLanguage)%>" />
      </jsp:include>
    	</td>
      <td><%=r.getString(teasession._nLanguage, "Sequence")%>
        <input name="sequenceAmount" type="text" value="<%=(termOrder[8])%>" maxlength="3" size="4"></td>
    </tr>
    <tr>
      <TD><%=r.getString(teasession._nLanguage, "Submit")%></TD>
      <td><input name="termSubmit" type="text"  class="edit_input"   ondblclick="showMax(document.foEdit.termSubmit)"  value="<%=HtmlElement.htmlToText(strSubmit)%>" size="50"></td>
      <td>&nbsp;</td>
      <td><%=r.getString(teasession._nLanguage, "Sequence")%>
        <input class="edit_input" name="sequenceSubmit" type="text" value="<%=(termOrder[7])%>" maxlength="3" size="4"></td>
    </tr>
  </table>
  <input type="submit" name="GoBack" id="edit_GoBack"  class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
  <input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
</FORM>
<SCRIPT>document.foEdit.searchnode.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

