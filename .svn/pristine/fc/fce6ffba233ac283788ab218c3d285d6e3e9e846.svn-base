<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}
boolean flag=request.getParameter("PickNode")==null;

r.add("/tea/resource/Interlocution");

ListingDetail ld=ListingDetail.find(iListing,84,teasession._nLanguage);



%><html>
<head>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
  <body>
  <h1><%=r.getString(teasession._nLanguage, "Interlocution")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
    <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
    <FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
      <input type='hidden' name="Node" value="<%=iNode%>">
      <input type="hidden" name="ListingType" value="84"/>
      <%if(!flag){%>
      <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
      <%        }else{%>
      <input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
      <%   }%>
      <input type="hidden" name="Listing" value="<%=iListing%>"/>

      <TABLE border="0" CELLPADDING="0" CELLSPACING="0"  id="tablecenter">
        <TR>
          <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Subject")%>:</TD>
          <TD><input  id="CHECKBOX" type="CHECKBOX" name="subject" value="checkbox"  <%=getCheck(ld.getIstype("subject"))%>><%=r.getString(teasession._nLanguage, "Show")%>
            <%=r.getString(teasession._nLanguage, "Before")%><input name="subject_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("subject"))%>" type="text" >
              <%=r.getString(teasession._nLanguage, "After")%><input name="subject_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("subject"))%>" type="text" >
                <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="subject_3" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" type="text"  value="<%=ld.getSequence("subject")%>" maxlength="3" size="4">
                  <input  id=CHECKBOX type="CHECKBOX" name="subject_4"   <%=getCheck(ld.getAnchor("subject"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                  <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="subject_5"  onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;"  type="text" value="<%=ld.getQuantity("subject")%>" maxlength="3" size="4">
          </TD>
        </TR>

        <TR>
          <td ID=RowHeader><%=r.getString(teasession._nLanguage, "NEW")%>:</TD>
          <TD><input  id="CHECKBOX" type="CHECKBOX" name="newgif" value="checkbox"  <%=getCheck(ld.getIstype("newgif"))%>><%=r.getString(teasession._nLanguage, "Show")%>
            <%=r.getString(teasession._nLanguage, "Before")%><input name="newgif_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("newgif"))%>" type="text" >
              <%=r.getString(teasession._nLanguage, "After")%><input name="newgif_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("newgif"))%>" type="text" >
                <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="newgif_3" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" type="text"  value="<%=ld.getSequence("newgif")%>" maxlength="3" size="4">
          </TD>
        </TR>

        <TR>
          <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Name")%>:</TD>
          <TD><input  id="CHECKBOX" type="CHECKBOX" name="name" value="checkbox"  <%=getCheck(ld.getIstype("name"))%>><%=r.getString(teasession._nLanguage, "Show")%>
            <%=r.getString(teasession._nLanguage, "Before")%><input name="name_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("name"))%>" type="text" >
              <%=r.getString(teasession._nLanguage, "After")%><input name="name_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("name"))%>" type="text" >
                <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="name_3" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" type="text"  value="<%=ld.getSequence("name")%>" maxlength="3" size="4">
                  <input  id=CHECKBOX type="CHECKBOX" name="name_4"   <%=getCheck(ld.getAnchor("name"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
          </TD>
        </TR>
        <TR>
          <td ID=RowHeader><%=r.getString(teasession._nLanguage, "integral")%>:</TD>
          <TD><input  id="CHECKBOX" type="CHECKBOX" name="integral" value="checkbox"  <%=getCheck(ld.getIstype("integral"))%>><%=r.getString(teasession._nLanguage, "Show")%>
            <%=r.getString(teasession._nLanguage, "Before")%><input name="integral_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("integral"))%>" type="text" >
              <%=r.getString(teasession._nLanguage, "After")%><input name="integral_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("integral"))%>" type="text" >
                <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="integral_3" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" type="text"  value="<%=ld.getSequence("integral")%>" maxlength="3" size="4">
                  <input  id=CHECKBOX type="CHECKBOX" name="integral_4"   <%=getCheck(ld.getAnchor("integral"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
          </TD>
        </TR>

        <TR>
          <td ID=RowHeader><%=r.getString(teasession._nLanguage, "types")%>:</TD>
          <TD><input  id="CHECKBOX" type="CHECKBOX" name="types" value="checkbox"  <%=getCheck(ld.getIstype("types"))%>><%=r.getString(teasession._nLanguage, "Show")%>
            <%=r.getString(teasession._nLanguage, "Before")%><input name="types_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("types"))%>" type="text" >
              <%=r.getString(teasession._nLanguage, "After")%><input name="types_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("types"))%>" type="text" >
                <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="types_3" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" type="text"  value="<%=ld.getSequence("types")%>" maxlength="3" size="4">
                  <input  id=CHECKBOX type="CHECKBOX" name="types_4"   <%=getCheck(ld.getAnchor("types"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
          </TD>
        </TR>




        <TR>
          <td ID=RowHeader><%=r.getString(teasession._nLanguage, "phone")%>:</TD>
          <TD><input  id="CHECKBOX" type="CHECKBOX" name="phone" value="checkbox"  <%=getCheck(ld.getIstype("phone"))%>><%=r.getString(teasession._nLanguage, "Show")%>
            <%=r.getString(teasession._nLanguage, "Before")%><input name="phone_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("phone"))%>" type="text" >
              <%=r.getString(teasession._nLanguage, "After")%><input name="phone_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("phone"))%>" type="text" >
                <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="phone_3" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" type="text"  value="<%=ld.getSequence("phone")%>" maxlength="3" size="4">
                  <input  id=CHECKBOX type="CHECKBOX" name="phone_4"   <%=getCheck(ld.getAnchor("phone"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
          </TD>
        </TR>
        <TR>
          <td ID=RowHeader><%=r.getString(teasession._nLanguage, "mobile")%>:</TD>
          <TD><input  id="CHECKBOX" type="CHECKBOX" name="mobile" value="checkbox"  <%=getCheck(ld.getIstype("mobile"))%>><%=r.getString(teasession._nLanguage, "Show")%>
            <%=r.getString(teasession._nLanguage, "Before")%><input name="mobile_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("mobile"))%>" type="text" >
              <%=r.getString(teasession._nLanguage, "After")%><input name="mobile_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("mobile"))%>" type="text" >
                <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="mobile_3" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" type="text"  value="<%=ld.getSequence("mobile")%>" maxlength="3" size="4">
                  <input  id=CHECKBOX type="CHECKBOX" name="mobile_4"   <%=getCheck(ld.getAnchor("mobile")==1)%> ><%=r.getString(teasession._nLanguage, "Anchor")%>
          </TD>
        </TR>
        <TR>
          <td ID=RowHeader>E-Mail:</TD>
          <TD><input  id="CHECKBOX" type="CHECKBOX" name="email" value="checkbox"  <%=getCheck(ld.getIstype("email"))%>><%=r.getString(teasession._nLanguage, "Show")%>
            <%=r.getString(teasession._nLanguage, "Before")%><input name="email_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("email"))%>" type="text" >
              <%=r.getString(teasession._nLanguage, "After")%><input name="email_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("email"))%>" type="text" >
                <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="email_3" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" type="text"  value="<%=ld.getSequence("email")%>" maxlength="3" size="4">
                  <input  id=CHECKBOX type="CHECKBOX" name="email_4"   <%=getCheck(ld.getAnchor("email"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
          </TD>
        </TR>
        <TR>
          <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Hint")%>:</TD>
          <TD><input  id="CHECKBOX" type="CHECKBOX" name="hint" value="checkbox"  <%=getCheck(ld.getIstype("hint"))%>><%=r.getString(teasession._nLanguage, "Show")%>
            <%=r.getString(teasession._nLanguage, "Before")%><input name="hint_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("hint"))%>" type="text" >
              <%=r.getString(teasession._nLanguage, "After")%><input name="hint_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("hint"))%>" type="text" >
                <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="hint_3" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" type="text"  value="<%=ld.getSequence("hint")%>" maxlength="3" size="4">
                  <input  id=CHECKBOX type="CHECKBOX" name="hint_4"   <%=getCheck(ld.getAnchor("hint"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
          </TD>
        </TR>
        <TR>
          <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Creator")%>:</TD>
          <TD><input  id="CHECKBOX" type="CHECKBOX" name="creator" value="checkbox"  <%=getCheck(ld.getIstype("creator"))%>><%=r.getString(teasession._nLanguage, "Show")%>
            <%=r.getString(teasession._nLanguage, "Before")%><input name="creator_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("creator"))%>" type="text" >
              <%=r.getString(teasession._nLanguage, "After")%><input name="creator_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("creator"))%>" type="text" >
                <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="creator_3" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" type="text"  value="<%=ld.getSequence("creator")%>" maxlength="3" size="4">
                  <input  id=CHECKBOX type="CHECKBOX" name="creator_4"   <%=getCheck(ld.getAnchor("creator"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
          </TD>
        </TR>
        <TR>
          <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
          <TD><input  id="CHECKBOX" type="CHECKBOX" name="text" value="checkbox"  <%=getCheck(ld.getIstype("text"))%>><%=r.getString(teasession._nLanguage, "Show")%>
            <%=r.getString(teasession._nLanguage, "Before")%><input name="text_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("text"))%>" type="text" >
              <%=r.getString(teasession._nLanguage, "After")%><input name="text_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("text"))%>" type="text" >
                <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="text_3" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" type="text"  value="<%=ld.getSequence("text")%>" maxlength="3" size="4">
                  <input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                  <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="text_5"  onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;"  type="text" value="<%=ld.getQuantity("text")%>" maxlength="3" size="4">
          </TD>
        </TR>

        <TR>
          <td ID=RowHeader><%=r.getString(teasession._nLanguage, "IssueTime")%>:</TD>
          <TD><input  id="CHECKBOX" type="CHECKBOX" name="issue" value="checkbox"  <%=getCheck(ld.getIstype("issue"))%>><%=r.getString(teasession._nLanguage, "Show")%>
            <%=r.getString(teasession._nLanguage, "Before")%><input name="issue_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("issue"))%>" type="text" >
              <%=r.getString(teasession._nLanguage, "After")%><input name="issue_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("issue"))%>" type="text" >
                <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="issue_3" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" type="text"  value="<%=ld.getSequence("issue")%>" maxlength="3" size="4">
                  <input  id=CHECKBOX type="CHECKBOX" name="issue_4"   <%=getCheck(ld.getAnchor("issue"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
          </TD>
        </TR>

        <TR>
          <td ID=RowHeader><%=r.getString(teasession._nLanguage, "ReplyButton")%>:</TD>
          <TD><input  id="CHECKBOX" type="CHECKBOX" name="replybutton" value="checkbox"  <%=getCheck(ld.getIstype("replybutton"))%>><%=r.getString(teasession._nLanguage, "Show")%>
            <%=r.getString(teasession._nLanguage, "Before")%><input name="replybutton_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("replybutton"))%>" type="text" >
              <%=r.getString(teasession._nLanguage, "After")%><input name="replybutton_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("replybutton"))%>" type="text" >
                <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="replybutton_3" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" type="text"  value="<%=ld.getSequence("replybutton")%>" maxlength="3" size="4">
                  <input  id=CHECKBOX type="CHECKBOX" name="replybutton_4"   <%=getCheck(ld.getAnchor("replybutton"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
          </TD>
        </TR>
         <tr>
          <td colspan="2"><hr size="1"></td>
        </tr>
        <tr>
          <td colspan="2">最佳答案<hr size="1"></td>
        </tr>

        <!--最佳答案-->



         <TR>
          <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Creator")%>:</TD>
          <TD><input  id="CHECKBOX" type="CHECKBOX" name="z_r_creator" value="checkbox"  <%=getCheck(ld.getIstype("z_r_creator"))%>><%=r.getString(teasession._nLanguage, "Show")%>
            <%=r.getString(teasession._nLanguage, "Before")%><input name="z_r_creator_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("z_r_creator"))%>" type="text" >
              <%=r.getString(teasession._nLanguage, "After")%><input name="z_r_creator_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("z_r_creator"))%>" type="text" >
                <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="z_r_creator_3" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" type="text"  value="<%=ld.getSequence("z_r_creator")%>" maxlength="3" size="4">
                  <input  id=CHECKBOX type="CHECKBOX" name="z_r_creator_4"   <%=getCheck(ld.getAnchor("z_r_creator"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
          </TD>
        </TR>
        <TR>
          <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
          <TD><input  id="CHECKBOX" type="CHECKBOX" name="z_r_text" value="checkbox"  <%=getCheck(ld.getIstype("z_r_text"))%>><%=r.getString(teasession._nLanguage, "Show")%>
            <%=r.getString(teasession._nLanguage, "Before")%><input name="z_r_text_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("z_r_text"))%>" type="text" >
              <%=r.getString(teasession._nLanguage, "After")%><input name="z_r_text_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("z_r_text"))%>" type="text" >
                <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="z_r_text_3" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" type="text"  value="<%=ld.getSequence("z_r_text")%>" maxlength="3" size="4">
                  <input  id=CHECKBOX type="CHECKBOX" name="z_r_text_4"   <%=getCheck(ld.getAnchor("z_r_text"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                  <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="z_r_text_5"  onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;"  type="text" value="<%=ld.getQuantity("z_r_text")%>" maxlength="3" size="4">
          </TD>
        </TR>
        <TR>
          <td ID=RowHeader><%=r.getString(teasession._nLanguage, "IssueTime")%>:</TD>
          <TD><input  id="CHECKBOX" type="CHECKBOX" name="z_r_issue" value="checkbox"  <%=getCheck(ld.getIstype("z_r_issue"))%>><%=r.getString(teasession._nLanguage, "Show")%>
            <%=r.getString(teasession._nLanguage, "Before")%><input name="z_r_issue_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("z_r_issue"))%>" type="text" >
              <%=r.getString(teasession._nLanguage, "After")%><input name="z_r_issue_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("z_r_issuz_r_issue"))%>" type="text" >
                <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="z_r_issue_3" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" type="text"  value="<%=ld.getSequence("z_r_issue")%>" maxlength="3" size="4">
                  <input  id=CHECKBOX type="CHECKBOX" name="z_r_issue_4"   <%=getCheck(ld.getAnchor("z_r_issue"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
          </TD>
        </TR>
        <TR>
          <td ID=RowHeader><%=r.getString(teasession._nLanguage, "CBDelete")%>:</TD>
          <TD><input  id="CHECKBOX" type="CHECKBOX" name="z_r_delete" value="checkbox"  <%=getCheck(ld.getIstype("z_r_delete"))%>><%=r.getString(teasession._nLanguage, "Show")%>
            <%=r.getString(teasession._nLanguage, "Before")%><input name="z_r_delete_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("z_r_delete"))%>" type="text" >
              <%=r.getString(teasession._nLanguage, "After")%><input name="z_r_delete_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("z_r_delete"))%>" type="text" >
                <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="z_r_delete_3" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" type="text"  value="<%=ld.getSequence("z_r_delete")%>" maxlength="3" size="4">
                  <input  id=CHECKBOX type="CHECKBOX" name="z_r_delete_4"   <%=getCheck(ld.getAnchor("z_r_delete"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
          </TD>
        </TR>

    <TR>
          <td ID=RowHeader><%=r.getString(teasession._nLanguage, "ReplyStatic")%>:</TD>
          <TD><input  id="CHECKBOX" type="CHECKBOX" name="z_r_replystatic" value="checkbox"  <%=getCheck(ld.getIstype("z_r_replystatic"))%>><%=r.getString(teasession._nLanguage, "Show")%>
            <%=r.getString(teasession._nLanguage, "Before")%><input name="z_r_replystatic_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("z_r_replystatic"))%>" type="text" >
              <%=r.getString(teasession._nLanguage, "After")%><input name="z_r_replystatic_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("z_r_replystatic"))%>" type="text" >
                <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="z_r_replystatic_3" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" type="text"  value="<%=ld.getSequence("z_r_replystatic")%>" maxlength="3" size="4">
                  <input  id=CHECKBOX type="CHECKBOX" name="z_r_replystatic_4"   <%=getCheck(ld.getAnchor("z_r_replystatic"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
          </TD>
        </TR>








        <tr>
          <td colspan="2"><hr size="1"></td>
        </tr>


        <TR>
          <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Creator")%>:</TD>
          <TD><input  id="CHECKBOX" type="CHECKBOX" name="r_creator" value="checkbox"  <%=getCheck(ld.getIstype("r_creator"))%>><%=r.getString(teasession._nLanguage, "Show")%>
            <%=r.getString(teasession._nLanguage, "Before")%><input name="r_creator_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_creator"))%>" type="text" >
              <%=r.getString(teasession._nLanguage, "After")%><input name="r_creator_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_creator"))%>" type="text" >
                <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="r_creator_3" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" type="text"  value="<%=ld.getSequence("r_creator")%>" maxlength="3" size="4">
                  <input  id=CHECKBOX type="CHECKBOX" name="r_creator_4"   <%=getCheck(ld.getAnchor("r_creator"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
          </TD>
        </TR>
        <TR>
          <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
          <TD><input  id="CHECKBOX" type="CHECKBOX" name="r_text" value="checkbox"  <%=getCheck(ld.getIstype("r_text"))%>><%=r.getString(teasession._nLanguage, "Show")%>
            <%=r.getString(teasession._nLanguage, "Before")%><input name="r_text_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_text"))%>" type="text" >
              <%=r.getString(teasession._nLanguage, "After")%><input name="r_text_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_text"))%>" type="text" >
                <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="r_text_3" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" type="text"  value="<%=ld.getSequence("r_text")%>" maxlength="3" size="4">
                  <input  id=CHECKBOX type="CHECKBOX" name="r_text_4"   <%=getCheck(ld.getAnchor("r"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                  <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="r_text_5"  onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;"  type="text" value="<%=ld.getQuantity("r_text")%>" maxlength="3" size="4">
          </TD>
        </TR>
        <TR>
          <td ID=RowHeader><%=r.getString(teasession._nLanguage, "IssueTime")%>:</TD>
          <TD><input  id="CHECKBOX" type="CHECKBOX" name="r_issue" value="checkbox"  <%=getCheck(ld.getIstype("r_issue"))%>><%=r.getString(teasession._nLanguage, "Show")%>
            <%=r.getString(teasession._nLanguage, "Before")%><input name="r_issue_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_issue"))%>" type="text" >
              <%=r.getString(teasession._nLanguage, "After")%><input name="r_issue_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_issue"))%>" type="text" >
                <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="r_issue_3" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" type="text"  value="<%=ld.getSequence("r_issue")%>" maxlength="3" size="4">
                  <input  id=CHECKBOX type="CHECKBOX" name="r_issue_4"   <%=getCheck(ld.getAnchor("r_issue"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
          </TD>
        </TR>




        <TR>
          <td ID=RowHeader><%=r.getString(teasession._nLanguage, "CBDelete")%>:</TD>
          <TD><input  id="CHECKBOX" type="CHECKBOX" name="r_delete" value="checkbox"  <%=getCheck(ld.getIstype("r_delete"))%>><%=r.getString(teasession._nLanguage, "Show")%>
            <%=r.getString(teasession._nLanguage, "Before")%><input name="r_delete_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_delete"))%>" type="text" >
              <%=r.getString(teasession._nLanguage, "After")%><input name="r_delete_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_deletr_delete"))%>" type="text" >
                <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="r_delete_3" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" type="text"  value="<%=ld.getSequence("r_delete")%>" maxlength="3" size="4">
                  <input  id=CHECKBOX type="CHECKBOX" name="r_delete_4"   <%=getCheck(ld.getAnchor("r_delete"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
          </TD>
        </TR>

    <TR>
          <td ID=RowHeader><%=r.getString(teasession._nLanguage, "ReplyStatic")%>:</TD>
          <TD><input  id="CHECKBOX" type="CHECKBOX" name="r_replystatic" value="checkbox"  <%=getCheck(ld.getIstype("r_replystatic"))%>><%=r.getString(teasession._nLanguage, "Show")%>
            <%=r.getString(teasession._nLanguage, "Before")%><input name="r_replystatic_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_replystatic"))%>" type="text" >
              <%=r.getString(teasession._nLanguage, "After")%><input name="r_replystatic_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_replystatic"))%>" type="text" >
                <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="r_replystatic_3" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" type="text"  value="<%=ld.getSequence("r_replystatic")%>" maxlength="3" size="4">
                  <input  id=CHECKBOX type="CHECKBOX" name="r_replystatic_4"   <%=getCheck(ld.getAnchor("r_replystatic"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
          </TD>
        </TR>

        <!--tr>
        <td>
        </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="objshow" onclick="fshow()"  ><%=r.getString(teasession._nLanguage, "SelectAll")%>
          <%=r.getString(teasession._nLanguage, "Before")%><input    name="objbefore1"  mask="max" onfocus="fbefore()"  onchange="fbefore()" value="" type="text">
            <%=r.getString(teasession._nLanguage, "After")%><input    name="objafter2"  onfocus="fafter()"  mask="max" onchange="fafter()" value="" type="text">
              <%=r.getString(teasession._nLanguage, "Sequence")%>:<a href="#" onclick="fsequ()"  ><%=r.getString(teasession._nLanguage, "Default")%></a>
              <input  id="CHECKBOX" type="CHECKBOX" name="objanchor_4" onclick="fanchor()"  ><%=r.getString(teasession._nLanguage, "SelectAll")%>
        </td>
</tr-->


        <tr>
          <td colspan="2"><hr size="1"></td>
        </tr>


          <TR>
          <td ID=RowHeader>回复框：</TD>
          <TD><input  id="CHECKBOX" type="CHECKBOX" name="r_backtable" value="checkbox"  <%=getCheck(ld.getIstype("r_backtable"))%>><%=r.getString(teasession._nLanguage, "Show")%>
            <%=r.getString(teasession._nLanguage, "Before")%><input name="r_backtable_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_backtable"))%>" type="text" >
              <%=r.getString(teasession._nLanguage, "After")%><input name="r_backtable_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_backtable"))%>" type="text" >
                <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="r_backtable_3" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" type="text"  value="<%=ld.getSequence("r_backtable")%>" maxlength="3" size="4">
                  <input  id=CHECKBOX type="CHECKBOX" name="r_backtable_4"   <%=getCheck(ld.getAnchor("r_backtable"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
          </TD>
        </TR>
</table>
<center >
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
    } 
  }
}
</script>
<SCRIPT><%if(request.getParameter("edit")==null)out.println("fsequ();");%>document.form1.subject_1.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
  </body>
</html>

