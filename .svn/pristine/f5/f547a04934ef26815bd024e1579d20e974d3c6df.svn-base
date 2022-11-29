<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.resource.*"%>
<%@include file="/jsp/Header.jsp"%>

<%
Resource r = new Resource();
r.add("/tea/resource/Download");
int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}
boolean flag=request.getParameter("PickNode")==null;


tea.entity.node.ListingDetail subject=tea.entity.node.ListingDetail.find(iListing,63,"subject",teasession._nLanguage);
tea.entity.node.ListingDetail language=tea.entity.node.ListingDetail.find(iListing,63,"language",teasession._nLanguage);
tea.entity.node.ListingDetail size=tea.entity.node.ListingDetail.find(iListing,63,"size",teasession._nLanguage);
tea.entity.node.ListingDetail picture=tea.entity.node.ListingDetail.find(iListing,63,"picture",teasession._nLanguage);
tea.entity.node.ListingDetail small=tea.entity.node.ListingDetail.find(iListing,63,"small",teasession._nLanguage);
tea.entity.node.ListingDetail commend=tea.entity.node.ListingDetail.find(iListing,63,"commend",teasession._nLanguage);
tea.entity.node.ListingDetail developer=tea.entity.node.ListingDetail.find(iListing,63,"developer",teasession._nLanguage);
tea.entity.node.ListingDetail text=tea.entity.node.ListingDetail.find(iListing,63,"text",teasession._nLanguage);
tea.entity.node.ListingDetail access=tea.entity.node.ListingDetail.find(iListing,63,"access",teasession._nLanguage);
tea.entity.node.ListingDetail url=tea.entity.node.ListingDetail.find(iListing,63,"url",teasession._nLanguage);
tea.entity.node.ListingDetail software=tea.entity.node.ListingDetail.find(iListing,63,"software",teasession._nLanguage);
tea.entity.node.ListingDetail article=tea.entity.node.ListingDetail.find(iListing,63,"article",teasession._nLanguage);
tea.entity.node.ListingDetail article2=tea.entity.node.ListingDetail.find(iListing,63,"article2",teasession._nLanguage);
tea.entity.node.ListingDetail search=tea.entity.node.ListingDetail.find(iListing,63,"search",teasession._nLanguage);
//tea.entity.node.ListingDetail correlation=tea.entity.node.ListingDetail.find(iListing, 63, "software",teasession._nLanguage);//相关
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Download")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
  <input type='hidden' name="Node" value="<%=iNode%>">
  <input type="hidden" name="ListingType" value="63"/>
  <%if(!flag){%>
  <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
  <%        }else{%>
  <input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
  <%   }%>
  <input type="hidden" name="Listing" value="<%=iListing%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Subject")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="subject" value="checkbox"  <%=getCheck(ld.getIstype("subject"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="subject_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("subject"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="subject_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("subject"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="subject_3" type="text" class="edit_input" value="<%=ld.getSequence("subject")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="subject_4"   <%=getCheck(ld.getAnchor("subject"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="subject_5" class="edit_input" type="text" value="<%=ld.getQuantity("subject")%>" maxlength="3" size="4">
      </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Languages")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="language" value="checkbox"  <%=getCheck(ld.getIstype("language"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="language_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("language"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="language_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("language"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="language_3" type="text" class="edit_input" value="<%=ld.getSequence("language")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="language_4"   <%=getCheck(ld.getAnchor("language"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Size")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="size" value="checkbox"  <%=getCheck(ld.getIstype("size"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="size_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("size"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="size_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("size"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="size_3" type="text" class="edit_input" value="<%=ld.getSequence("size")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="size_4"   <%=getCheck(ld.getAnchor("size"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Picture")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="picture" value="checkbox"  <%=getCheck(ld.getIstype("picture"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="picture_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("picture"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="picture_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("picture"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="picture_3" type="text" class="edit_input" value="<%=ld.getSequence("picture")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="picture_4"   <%=getCheck(ld.getAnchor("picture"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "SmallPicture")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="small" value="checkbox"  <%=getCheck(ld.getIstype("small"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="small_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("small"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="small_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("small"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="small_3" type="text" class="edit_input" value="<%=ld.getSequence("small")%>" maxlength="3" size="4">
        <select name="small_4"   <%=getSelect(ld.getAnchor("small")==1)%> >
          <option value="0">-----</option>
          <option value="1" <%=getSelect(ld.getAnchor("small")==1)%> ><%=r.getString(teasession._nLanguage, "Node")%></option>
          <option value="2" <%=getSelect(ld.getAnchor("small")==2)%> ><%=r.getString(teasession._nLanguage, "Picture")%></option>
        </select>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Commend")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="commend" value="checkbox"  <%=getCheck(ld.getIstype("commend"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="commend_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("commend"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="commend_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("commend"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="commend_3" type="text" class="edit_input" value="<%=ld.getSequence("commend")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="commend_4"   <%=getCheck(ld.getAnchor("commend"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Access")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="access" value="checkbox"  <%=getCheck(ld.getIstype("access"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="access_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("access"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="access_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("access"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="access_3" type="text" class="edit_input" value="<%=ld.getSequence("access")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="access_4"   <%=getCheck(ld.getAnchor("access"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Developer")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="developer" value="checkbox"  <%=getCheck(ld.getIstype("developer"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="developer_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("developer"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="developer_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("developer"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="developer_3" type="text" class="edit_input" value="<%=ld.getSequence("developer")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="developer_4"   <%=getCheck(ld.getAnchor("developer"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="text" value="checkbox"  <%=getCheck(ld.getIstype("text"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="text_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("text"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="text_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("text"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="text_3" type="text" class="edit_input" value="<%=ld.getSequence("text")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="text_5" class="edit_input" type="text" value="<%=ld.getQuantity("text")%>" maxlength="3" size="4">
      </TD>
    </TR>
    <TR>
      <TD>URL:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="url" value="checkbox"  <%=getCheck(ld.getIstype("url"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="url_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("url"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="url_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("url"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="url_3" type="text" class="edit_input" value="<%=ld.getSequence("url")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="url_4"   <%=getCheck(ld.getAnchor("url"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TD><%=r.getString(teasession._nLanguage, "Software")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="software" value="checkbox"  <%=getCheck(ld.getIstype("software"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="software_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("software"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="software_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("software"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="software_3" type="text" class="edit_input" value="<%=ld.getSequence("software")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="software_4"   <%=getCheck(ld.getAnchor("software"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="software_5" class="edit_input" type="text" value="<%=ld.getQuantity("software")%>" maxlength="3" size="4">
      </TD>
    </TR>
    <TD><%=r.getString(teasession._nLanguage, "Article")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="article" value="checkbox"  <%=getCheck(ld.getIstype("article"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="article_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("article"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="article_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("article"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="article_3" type="text" class="edit_input" value="<%=ld.getSequence("article")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="article_4"   <%=getCheck(ld.getAnchor("article"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="article_5" class="edit_input" type="text" value="<%=ld.getQuantity("article")%>" maxlength="3" size="4">
      </TD>
    </TR><tr>
        <TD><%=r.getString(teasession._nLanguage, "Article")%>2:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="article2" value="checkbox"  <%=getCheck(ld.getIstype("article2"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="article2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("article2"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="article2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("article2"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="article2_3" type="text" class="edit_input" value="<%=ld.getSequence("article2")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="article2_4"   <%=getCheck(ld.getAnchor("article2"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="article2_5" class="edit_input" type="text" value="<%=ld.getQuantity("article2")%>" maxlength="3" size="4">
      </TD>
    </TR><tr>
        <TD><%=r.getString(teasession._nLanguage, "Search")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="search" value="checkbox"  <%=getCheck(ld.getIstype("search"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="search_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("search"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="search_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("search"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="search_3" type="text" class="edit_input" value="<%=ld.getSequence("search")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="search_4"   <%=getCheck(ld.getAnchor("search"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="search_5" class="edit_input" type="text" value="<%=ld.getQuantity("search")%>" maxlength="3" size="4">
      </TD>
    </TR>
    <!--tr>
    <td colspan="2"><hr size="1"></td>
</tr>
  <tr>
      <td>
      </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="objshow" onclick="fshow()"  ><%=r.getString(teasession._nLanguage, "SelectAll")%>
          <%=r.getString(teasession._nLanguage, "Before")%><input   class="edit_input" name="objbefore1"  mask="max" onfocus="fbefore()"  onchange="fbefore()" value="" type="text">
              <%=r.getString(teasession._nLanguage, "After")%><input   class="edit_input" name="objafter2"  onfocus="fafter()"  mask="max" onchange="fafter()" value="" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<a href="#" onclick="fsequ()"  ><%=r.getString(teasession._nLanguage, "Default")%></a>
    <input  id="CHECKBOX" type="CHECKBOX" name="objanchor_4" onclick="fanchor()"  ><%=r.getString(teasession._nLanguage, "SelectAll")%>
                                                </td>
                      </tr-->
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

