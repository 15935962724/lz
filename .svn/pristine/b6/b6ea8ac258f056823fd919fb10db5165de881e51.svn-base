<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%


int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();
Node node = Node.find(iNode);

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
   response.sendError(403);
   return;
}
r.add("/tea/resource/Landscape");
boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(iListing,81,teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
var textObj;
function showMax(obj){
 myleft=document.body.scrollLeft+event.clientX-event.offsetX-40;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+18;

	textarea.value=obj.value;
    textObj=    obj;
    Layer1.style.left=myleft
    Layer1.style.top=mytop
	Layer1.style.visibility="";
    textarea.focus();
	}

function hideMax(bool)
{
    if(bool)
    {
       eval(textObj).value=textarea.value;
       eval(textObj).focus();
    }
	Layer1.style.visibility="hidden";
    eval(textObj).focus();
}
</script>
</head>
<body>
<body onload="fload(foNew);">
<h1><%=r.getString(teasession._nLanguage, "Landscape")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
 <div id="pathdiv">
<%=node.getAncestor(teasession._nLanguage)%></div>
<div id="Layer1" style="position:absolute; left:120px; top:300px; width:214px; height:168px; z-index:1; background-color: #FFFFFF; layer-background-color: #FFFFFF; overflow: 隐藏; visibility: hidden;">
  <textarea name="textarea" cols="50" rows="10"></textarea>
  <input type="reset"  class="edit_button" name="Submit" value="<%=r.getString(teasession._nLanguage, "CBBack")%>" onClick="javascript:hideMax();" >
  <input type="button"  class="edit_button" name="Submit2" value="<%=r.getString(teasession._nLanguage, "Submit")%>" onClick="javascript:hideMax(true);">
</div>
<form name="form1" method="post" action="/servlet/EditListingDetail">
<input type='hidden' name="Node" VALUE="<%=iNode%>">
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" VALUE="<%=request.getParameter("PickManual")%>">
<%   }%>
    <input type="hidden" name="ListingType" value="81"/>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>

  <table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
  <tr>
    <TD><%=r.getString(teasession._nLanguage, "Subject")%>: </TD>
    <td>
        <input  id="CHECKBOX" type="CHECKBOX" name="getSubject" value="checkbox"  <%=getCheck(ld.getIstype("getSubject"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getSubject_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getSubject"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getSubject_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getSubject"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getSubject_3" type="text" value="<%=ld.getSequence("getSubject")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getSubject_4"   <%=getCheck(ld.getAnchor("getSubject"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
      <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="getSubject_5" class="edit_input" type="text" value="<%=ld.getQuantity("getSubject")%>" maxlength="3" size="4">
     </td>
  </tr>
  <tr>
    <TD><%=r.getString(teasession._nLanguage, "Area")%>1:</TD>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getArea1" value="checkbox"  <%=getCheck(ld.getIstype("getArea1"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getArea1_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getArea1"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getArea1_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getArea1"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getArea1_3" type="text" value="<%=ld.getSequence("getArea1")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getArea1_4"   <%=getCheck(ld.getAnchor("getArea1"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <TD><%=r.getString(teasession._nLanguage, "Area")%>2:</TD>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getArea2" value="checkbox"  <%=getCheck(ld.getIstype("getArea2"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getArea2_1" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getBeforeItem("getArea2")))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getArea2_2" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getAfterItem("getArea2")))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getArea2_3" type="text" value="<%=ld.getSequence("getArea2")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getArea2_4"   <%=getCheck(ld.getAnchor("getArea2"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <!--tr>
    <TD><%=r.getString(teasession._nLanguage, "Map")%>:</TD>
  <td><input  id="CHECKBOX" type="CHECKBOX" name="map" value="checkbox"  <%=getCheck(ld.getIstype("map"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="map_1" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getBeforeItem("map")))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="map_2" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getAfterItem("map")))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="map_3" type="text" value="<%=ld.getSequence("map")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="map_4"   <%=getCheck(ld.getAnchor("map"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>

  </tr-->
    <tr>
    <TD><%=r.getString(teasession._nLanguage, "Style")%>:</TD>
  <td><input  id="CHECKBOX" type="CHECKBOX" name="getStyle" value="checkbox"  <%=getCheck(ld.getIstype("getStyle"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getStyle_1" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getBeforeItem("getStyle")))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getStyle_2" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getAfterItem("getStyle")))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getStyle_3" type="text" value="<%=ld.getSequence("getStyle")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getStyle_4"   <%=getCheck(ld.getAnchor("getStyle"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>

  </tr>
  <tr>
    <TD><%=r.getString(teasession._nLanguage, "Homeland")%>:</TD>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="isHomeland" value="checkbox"  <%=getCheck(ld.getIstype("isHomeland"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="isHomeland_1" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getBeforeItem("isHomeland")))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="isHomeland_2" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getAfterItem("isHomeland")))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="isHomeland_3" type="text" value="<%=ld.getSequence("isHomeland")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="isHomeland_4"   <%=getCheck(ld.getAnchor("isHomeland"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>
    <TD><%=r.getString(teasession._nLanguage, "Weather")%>:</TD>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getWeather" value="checkbox"  <%=getCheck(ld.getIstype("getWeather"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getWeather_1" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getBeforeItem("getWeather")))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getWeather_2" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getAfterItem("getWeather")))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getWeather_3" type="text" value="<%=ld.getSequence("getWeather")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getWeather_4"   <%=getCheck(ld.getAnchor("getWeather"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <TD><%=r.getString(teasession._nLanguage, "Logograph")%>: </TD>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getLogograph" value="checkbox"  <%=getCheck(ld.getIstype("getLogograph"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getLogograph_1" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getBeforeItem("getLogograph")))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getLogograph_2" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getAfterItem("getLogograph")))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getLogograph_3" type="text" value="<%=ld.getSequence("getLogograph")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getLogograph_4"   <%=getCheck(ld.getAnchor("getLogograph"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
	<%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="getLogograph_5" class="edit_input" type="text" value="<%=ld.getQuantity("getLogograph")%>" maxlength="3" size="4"></td>
  </tr>
  <tr>
    <TD><%=r.getString(teasession._nLanguage, "Picture")%>: </TD>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getPicture" value="checkbox"  <%=getCheck(ld.getIstype("getPicture"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getPicture_1" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getBeforeItem("getPicture")))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getPicture_2" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getAfterItem("getPicture")))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getPicture_3" type="text" value="<%=ld.getSequence("getPicture")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getPicture_4"   <%=getCheck(ld.getAnchor("getPicture"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <TD><%=r.getString(teasession._nLanguage, "Distinction")%>: </TD>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getDistinction" value="checkbox"  <%=getCheck(ld.getIstype("getDistinction"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getDistinction_1" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getBeforeItem("getDistinction")))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getDistinction_2" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getAfterItem("getDistinction")))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getDistinction_3" type="text" value="<%=ld.getSequence("getDistinction")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getDistinction_4"   <%=getCheck(ld.getAnchor("getDistinction"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <TD><%=r.getString(teasession._nLanguage, "Text")%>: </TD>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getText" value="checkbox"  <%=getCheck(ld.getIstype("getText"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getText_1" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getBeforeItem("getText")))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getText_2" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getAfterItem("getText")))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getText_3" type="text" value="<%=ld.getSequence("getText")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getText_4"   <%=getCheck(ld.getAnchor("getText"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
        <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="getText_5" class="edit_input" type="text" value="<%=ld.getQuantity("getText")%>" maxlength="3" size="4">
        </td>
  </tr>
  <tr><td colspan="5"><hr></td></tr>
    <tr>
    <TD><%=r.getString(teasession._nLanguage, "Correlation")%>: </TD>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getCorrelation" value="checkbox"  <%=getCheck(ld.getIstype("getCorrelation"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getCorrelation_1" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getBeforeItem("getCorrelation")))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getCorrelation_2" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getAfterItem("getCorrelation")))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getCorrelation_3" type="text" value="<%=ld.getSequence("getCorrelation")%>" maxlength="3" size="4">
    <input type="hidden" name="getCorrelation_4" value="ON">
        <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="getCorrelation_5" class="edit_input" type="text" value="<%=ld.getQuantity("getCorrelation")%>" maxlength="3" size="4">
        </td>
  </tr>

  <tr>
    <TD><%=r.getString(teasession._nLanguage, "CorrelativeLandscape")%>: </TD>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getCLandscape"    <%=getCheck(ld.getIstype("getCLandscape"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getCLandscape_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getCLandscape"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getCLandscape_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getCLandscape"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getCLandscape_3" type="text" value="<%=ld.getSequence("getCLandscape")%>" maxlength="3" size="4">
            <input type="hidden" name="getCLandscape_4" value="ON">
        <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="getCLandscape_5" class="edit_input" type="text" value="<%=ld.getQuantity("getCLandscape")%>" maxlength="3" size="4">
        </td>
  </tr>
  <tr>
    <TD><%=r.getString(teasession._nLanguage, "CorrelativeHostel")%>: </TD>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getCHostel"    <%=getCheck(ld.getIstype("getCHostel"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getCHostel_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getCHostel"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getCHostel_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getCHostel"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getCHostel_3" type="text" value="<%=ld.getSequence("getCHostel")%>" maxlength="3" size="4">
                    <input type="hidden" name="getCHostel_4" value="ON">
        <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="getCHostel_5" class="edit_input" type="text" value="<%=ld.getQuantity("getCHostel")%>" maxlength="3" size="4">
        </td>
  </tr>
  <tr>
    <TD><%=r.getString(teasession._nLanguage, "CorrelativeTravel")%>: </TD>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getCTravel"    <%=getCheck(ld.getIstype("getCTravel"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getCTravel_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getCTravel"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getCTravel_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getCTravel"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getCTravel_3" type="text" value="<%=ld.getSequence("getCTravel")%>" maxlength="3" size="4">
       <input type="hidden" name="getCTravel_4" value="ON">
        <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="getCTravel_5" class="edit_input" type="text" value="<%=ld.getQuantity("getCTravel")%>" maxlength="3" size="4">
        </td>
  </tr>
    <tr>
    <TD><%=r.getString(teasession._nLanguage, "CorrelativeLandscapeStyle")%>: </TD>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getCLStyle"    <%=getCheck(ld.getIstype("getCLStyle"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getCLStyle_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getCLStyle"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getCLStyle_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getCLStyle"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getCLStyle_3" type="text" value="<%=ld.getSequence("getCLStyle")%>" maxlength="3" size="4">
               <input type="hidden" name="getCLStyle_4" value="ON">
        <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="getCLStyle_5" class="edit_input" type="text" value="<%=ld.getQuantity("getCLStyle")%>" maxlength="3" size="4">
        </td>
  </tr>
</table>
    <input type=SUBMIT name="GoBack" class="edit_button"  value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </form>

  <SCRIPT type="">
  function fsequ()
  {
    var paramvalue=0;
      for(var counter=0;counter<form1.elements.length;counter++)
      {
          if(form1.elements[counter].type=="text"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-2)=="_3")
          {
              form1.elements[counter].value=++paramvalue*10;
          }
      }
  }
  <%if(request.getParameter("edit")==null)out.println("fsequ();");%>document.form1.getSubject_1.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

