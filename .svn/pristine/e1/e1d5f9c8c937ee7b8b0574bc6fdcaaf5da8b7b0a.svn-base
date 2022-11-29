<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>


<%
r.add("/tea/resource/Perform");

int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();
Node node = Node.find(iNode);

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}

boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(iListing,55,teasession._nLanguage);

ListingDetail name=ListingDetail.find(iListing,55,"name",teasession._nLanguage);
int nameOrder=10;
if(name.getSequence()>0)
nameOrder=name.getSequence();

ListingDetail sex=ListingDetail.find(iListing,55,"sex",teasession._nLanguage);
int sexOrder=20;
if(sex.getSequence()>0)
sexOrder=sex.getSequence();

ListingDetail birthday=ListingDetail.find(iListing,55,"birthday",teasession._nLanguage);
int birthdayOrder=30;
if(birthday.getSequence()>0)
birthdayOrder=birthday.getSequence();

ListingDetail blood=ListingDetail.find(iListing,55,"request",teasession._nLanguage);
int bloodOrder=40;
if(blood.getSequence()>0)
bloodOrder=blood.getSequence();

ListingDetail cardType=ListingDetail.find(iListing,55,"cardType",teasession._nLanguage);
int cardTypeOrder=50;
if(cardType.getSequence()>0)
cardTypeOrder=cardType.getSequence();

ListingDetail cardNum=ListingDetail.find(iListing,55,"cardNum",teasession._nLanguage);
int cardNumOrder=60;
if(cardNum.getSequence()>0)
cardNumOrder=cardNum.getSequence();

ListingDetail workPlace=ListingDetail.find(iListing,55,"workPlace",teasession._nLanguage);
int workPlaceOrder=70;
if(workPlace.getSequence()>0)
workPlaceOrder=workPlace.getSequence();

ListingDetail job=ListingDetail.find(iListing,55,"job",teasession._nLanguage);
int jobOrder=80;
if(job.getSequence()>0)
jobOrder=job.getSequence();

ListingDetail email=ListingDetail.find(iListing,55,"email",teasession._nLanguage);
int emailOrder=90;
if(email.getSequence()>0)
emailOrder=email.getSequence();

ListingDetail address=ListingDetail.find(iListing,55,"address",teasession._nLanguage);
int addressOrder=100;
if(address.getSequence()>0)
addressOrder=address.getSequence();


ListingDetail phone=ListingDetail.find(iListing,55,"phone",teasession._nLanguage);
int phoneOrder=100;
if(phone.getSequence()>0)
phoneOrder=phone.getSequence();

ListingDetail fax=ListingDetail.find(iListing,55,"fax",teasession._nLanguage);
int faxOrder=100;
if(fax.getSequence()>0)
faxOrder=fax.getSequence();
ListingDetail mobile=ListingDetail.find(iListing,55,"mobile",teasession._nLanguage);
int mobileOrder=100;
if(mobile.getSequence()>0)
mobileOrder=mobile.getSequence();

ListingDetail richDate=ListingDetail.find(iListing,55,"richDate",teasession._nLanguage);
int richDateOrder=100;
if(richDate.getSequence()>0)
richDateOrder=richDate.getSequence();
ListingDetail richTime=ListingDetail.find(iListing,55,"richTime",teasession._nLanguage);
int richTimeOrder=100;
if(richTime.getSequence()>0)
richTimeOrder=richTime.getSequence();


ListingDetail flightNum=ListingDetail.find(iListing,55,"flightNum",teasession._nLanguage);
int flightNumOrder=100;
if(flightNum.getSequence()>0)
flightNumOrder=flightNum.getSequence();
ListingDetail trainNum=ListingDetail.find(iListing,55,"trainNum",teasession._nLanguage);
int trainNumOrder=100;
if(trainNum.getSequence()>0)
trainNumOrder=trainNum.getSequence();

ListingDetail welcome=ListingDetail.find(iListing,55,"welcome",teasession._nLanguage);
int welcomeOrder=100;
if(welcome.getSequence()>0)
welcomeOrder=welcome.getSequence();

ListingDetail subject=ListingDetail.find(iListing,55,"subject",teasession._nLanguage);
int subjectOrder=100;
if(subject.getSequence()>0)
subjectOrder=subject.getSequence();

ListingDetail addition=ListingDetail.find(iListing,55,"addition",teasession._nLanguage);
int additionOrder=100;
if(addition.getSequence()>0)
additionOrder=addition.getSequence();

ListingDetail employee=ListingDetail.find(iListing,55,"employee",teasession._nLanguage);
int employeeOrder=100;
if(employee.getSequence()>0)
employeeOrder=employee.getSequence();

ListingDetail checkbox=ListingDetail.find(iListing,55,"checkbox",teasession._nLanguage);
int checkboxOrder=100;
if(checkbox.getSequence()>0)
checkboxOrder=checkbox.getSequence();

ListingDetail export=ListingDetail.find(iListing,55,"export",teasession._nLanguage);
int exportOrder=100;
if(export.getSequence()>0)
exportOrder=export.getSequence();
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Register")%><%=r.getString(teasession._nLanguage, "Detail")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv">
<%=node.getAncestor(teasession._nLanguage)%></div>

<form name="form1" method="post" action="/servlet/EditListingDetail">
<input type='hidden' name="Node" value="<%=iNode%>">
    <input type="hidden" name="ListingType" value="55"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
<%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="name" value="checkbox"  <%=getCheck(ld.getIstype("name"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="name_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("name"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="name_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("name"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="name_3" class="edit_input"  type="text" value="<%=nameOrder%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="name_4"   <%=getCheck(ld.getAnchor("name"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Sex")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="sex" value="checkbox"  <%=getCheck(ld.getIstype("sex"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="sex_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("sex"))%>" class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="sex_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("sex"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="sex_3" class="edit_input"  type="text" value="<%=sexOrder%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="sex_4"   <%=getCheck(ld.getAnchor("sex"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Birthday")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="birthday" value="checkbox"  <%=getCheck(ld.getIstype("birthday"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="birthday_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("birthday"))%>" class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="birthday_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("birthday"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="birthday_3" class="edit_input"  type="text" value="<%=birthdayOrder%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="birthday_4"   <%=getCheck(ld.getAnchor("birthday"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Blood")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="blood" value="checkbox"  <%=getCheck(ld.getIstype("blood"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="blood_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("blood"))%>" class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="blood_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("blood"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="blood_3" class="edit_input"  type="text" value="<%=bloodOrder%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="blood_4"   <%=getCheck(ld.getAnchor("blood"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "CardType")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="cardType" value="checkbox"  <%=getCheck(ld.getIstype("cardType"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="cardType_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("cardType"))%>" class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="cardType_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("cardType"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="cardType_3" class="edit_input"  type="text" value="<%=cardTypeOrder%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="cardType_4"   <%=getCheck(ld.getAnchor("cardType"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <%--
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Synopsis")%>: </td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="cardNum" value="checkbox"  <%=getCheck(ld.getIstype("cardNum"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="cardNum_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("cardNum"))%>" class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="cardNum_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("cardNum"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="cardNum_3" class="edit_input"  type="text" value="<%=cardNumOrder%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="cardNum_4"   <%=getCheck(ld.getAnchor("cardNum"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>--%>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "WorkPlace")%>: </td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="workPlace" value="checkbox"  <%=getCheck(ld.getIstype("workPlace"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="workPlace_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("workPlace"))%>" class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="workPlace_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("workPlace"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="workPlace_3" class="edit_input"  type="text" value="<%=workPlaceOrder%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="workPlace_4"   <%=getCheck(ld.getAnchor("workPlace"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Job")%>: </td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="job" value="checkbox"  <%=getCheck(ld.getIstype("job"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="job_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("job"))%>" class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="job_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("job"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="job_3" class="edit_input"  type="text" value="<%=jobOrder%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="job_4"   <%=getCheck(ld.getAnchor("job"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Email")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="email" value="checkbox"  <%=getCheck(ld.getIstype("email"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="email_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("email"))%>" class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="email_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("email"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="email_3" class="edit_input"  type="text" value="<%=emailOrder%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="email_4"   <%=getCheck(ld.getAnchor("email"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>

  <tr>
    <td><%=r.getString(teasession._nLanguage, "Address")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="address" value="checkbox"  <%=getCheck(ld.getIstype("address"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="address_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("address"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="address_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("address"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="address_3" class="edit_input"  type="text" value="<%=addressOrder%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="address_4"   <%=getCheck(ld.getAnchor("address"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
     <tr>
    <td><%=r.getString(teasession._nLanguage, "Phone")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="phone" value="checkbox"  <%=getCheck(ld.getIstype("phone"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="phone_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("phone"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="phone_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("phone"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="phone_3" class="edit_input"  type="text" value="<%=phoneOrder%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="phone_4"   <%=getCheck(ld.getAnchor("phone"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Fax")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="fax" value="checkbox"  <%=getCheck(ld.getIstype("fax"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="fax_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("fax"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="fax_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("fax"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="fax_3" class="edit_input"  type="text" value="<%=faxOrder%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="fax_4"   <%=getCheck(ld.getAnchor("fax"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Mobile")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="mobile" value="checkbox"  <%=getCheck(ld.getIstype("mobile"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="mobile_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("mobile"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="mobile_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("mobile"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="mobile_3" class="edit_input"  type="text" value="<%=mobileOrder%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="mobile_4"   <%=getCheck(ld.getAnchor("mobile"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>


    <tr>
    <td><%=r.getString(teasession._nLanguage, "RichDate")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="richDate" value="checkbox"  <%=getCheck(ld.getIstype("richDate"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="richDate_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("richDate"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="richDate_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("richDate"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="richDate_3" class="edit_input"  type="text" value="<%=richDateOrder%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="richDate_4"   <%=getCheck(ld.getAnchor("richDate"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
      <tr>
    <td><%=r.getString(teasession._nLanguage, "RichTime")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="richTime" value="checkbox"  <%=getCheck(ld.getIstype("richTime"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="richTime_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("richTime"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="richTime_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("richTime"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="richTime_3" class="edit_input"  type="text" value="<%=richTimeOrder%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="richTime_4"   <%=getCheck(ld.getAnchor("richTime"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>


    <tr>
    <td><%=r.getString(teasession._nLanguage, "FlightNum")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="flightNum" value="checkbox"  <%=getCheck(ld.getIstype("flightNum"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="flightNum_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("flightNum"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="flightNum_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("flightNum"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="flightNum_3" class="edit_input"  type="text" value="<%=flightNumOrder%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="flightNum_4"   <%=getCheck(ld.getAnchor("flightNum"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "TrainNum")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="trainNum" value="checkbox"  <%=getCheck(ld.getIstype("trainNum"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="trainNum_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("trainNum"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="trainNum_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("trainNum"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="trainNum_3" class="edit_input"  type="text" value="<%=trainNumOrder%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="trainNum_4"   <%=getCheck(ld.getAnchor("trainNum"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>


    <tr>
    <td><%=r.getString(teasession._nLanguage, "Welcome")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="welcome" value="checkbox"  <%=getCheck(ld.getIstype("welcome"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="welcome_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("welcome"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="welcome_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("welcome"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="welcome_3" class="edit_input"  type="text" value="<%=welcomeOrder%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="welcome_4"   <%=getCheck(ld.getAnchor("welcome"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
     <tr>
    <td><%=r.getString(teasession._nLanguage, "Subject")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="subject" value="checkbox"  <%=getCheck(ld.getIstype("subject"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="subject_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("subject"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="subject_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("subject"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="subject_3" class="edit_input"  type="text" value="<%=subjectOrder%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="subject_4"   <%=getCheck(ld.getAnchor("subject"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>


    <tr>
    <td><%=r.getString(teasession._nLanguage, "Addition")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="addition" value="checkbox"  <%=getCheck(ld.getIstype("addition"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="addition_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("addition"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="addition_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("addition"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="addition_3" class="edit_input"  type="text" value="<%=additionOrder%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="addition_4"   <%=getCheck(ld.getAnchor("addition"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
     <tr>
    <td><%=r.getString(teasession._nLanguage, "Employee")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="employee" value="checkbox"  <%=getCheck(ld.getIstype("employee"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="employee_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("employee"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="employee_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("employee"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="employee_3" class="edit_input"  type="text" value="<%=employeeOrder%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="employee_4"   <%=getCheck(ld.getAnchor("employee"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
    <tr>
    <td colspan="2"><hr></td>
</tr>
 <tr>
    <td><%=r.getString(teasession._nLanguage, "Checkbox")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="checkbox" value="checkbox"  <%=getCheck(ld.getIstype("checkbox"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="checkbox_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("checkbox"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="checkbox_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("checkbox"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="checkbox_3" class="edit_input"  type="text" value="<%=checkboxOrder%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="checkbox_4"   <%=getCheck(ld.getAnchor("checkbox"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Export")%>: </td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="export" value="checkbox"  <%=getCheck(ld.getIstype("export"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="export_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("export"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="export_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("export"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="export_3" class="edit_input"  type="text" value="<%=exportOrder%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="export_4"   <%=getCheck(ld.getAnchor("export"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2"><hr></td>
</tr>
  <tr>
      <td>
      </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="objshow" onClick="fshow()"  ><%=r.getString(teasession._nLanguage, "SelectAll")%>
          <%=r.getString(teasession._nLanguage, "Before")%><input   class="edit_input" name="objbefore1"  mask="max" onFocus="fbefore()"  onchange="fbefore()" value="" type="text">
              <%=r.getString(teasession._nLanguage, "After")%><input   class="edit_input" name="objafter2"  onfocus="fafter()"  mask="max" onChange="fafter()" value="" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<a href="#" onClick="fsequ()"  ><%=r.getString(teasession._nLanguage, "Default")%></a>
    <input  id="CHECKBOX" type="CHECKBOX" name="objanchor_4" onClick="fanchor()"  ><%=r.getString(teasession._nLanguage, "SelectAll")%>
                                                </td>
                      </tr>
</table><center >
    <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
      </center>
  </form>

  <script>
  function fshow()
  {
      for(var counter=0;counter<form1.elements.length;counter++)
      {
          if(form1.elements[counter].type=="checkbox"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-2)!="_4")
          {
              form1.elements[counter].checked=form1.elements["objshow"].checked;
          }
      }
  }function fafter()
  {
      for(var counter=0;counter<form1.elements.length;counter++)
      {
          if(form1.elements[counter].type=="text"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-1)=="2")
          {
              form1.elements[counter].value=form1.elements["objafter2"].value;
          }
      }
  }

  function fbefore()
  {
      for(var counter=0;counter<form1.elements.length;counter++)
      {
          if(form1.elements[counter].type=="text"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-1)=="1")
          {
              form1.elements[counter].value=form1.elements["objbefore1"].value;
          }
      }
  }

  function fanchor()
  {
      for(var counter=0;counter<form1.elements.length;counter++)
      {
          if(form1.elements[counter].type=="checkbox"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-2)=="_4")
          {
              form1.elements[counter].checked=form1.elements["objanchor_4"].checked;
          }
      }
  }
  function fsequ()
  {
    var paramvalue=0;
    for(var counter=0;counter<form1.elements.length;counter++)
    {
      if(form1.elements[counter].type=="text"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-2)=="_3")
      {
        form1.elements[counter].value=++paramvalue*10;
        //form1.elements[counter].focus();
      }
    }
  }
</script>
<div id="head6"><img height="6" src="about:blank"></div>
 <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>

