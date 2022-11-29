<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%


int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = tea.entity.node.Listing.find(iListing).getNode();

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}
boolean flag=request.getParameter("PickNode")==null;

//r.add("/tea/resource/Weblog");

ListingDetail ld=ListingDetail.find(iListing,1,teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
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
</head>
<body onLoad="<%if(request.getParameter("edit")==null)out.println("fsequ();");%>document.form1.getSubject_1.focus();">
<h1><%=r.getString(teasession._nLanguage, "Category")%><%=r.getString(teasession._nLanguage, "Detail")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

   <br>
  <FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
    <input type='hidden' name="Node" value="<%=iNode%>">
    <input type="hidden" name="ListingType" value="1"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
    <%        }else{%>
    <input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
    <%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>

    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
        <TD nowrap>
          <input  id="CHECKBOX" type="CHECKBOX" name="getSubject" value="checkbox"  <%=getCheck(ld.getIstype("getSubject"))%> ID="radio"><%=r.getString(teasession._nLanguage, "Show")%>
          <%=r.getString(teasession._nLanguage, "Before")%>:<input name="getSubject_1" mask="max" value="<%=MT.f(ld.getBeforeItem("getSubject"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>:<input name="getSubject_2" mask="max" value="<%=MT.f(ld.getAfterItem("getSubject"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getSubject_3" type="text" class="edit_input" value="<%=ld.getSequence("getSubject")%>" maxlength="3" size="4" mask="int">
          <input type=checkbox name="getSubject_4" <%=getCheck(ld.getAnchor("getSubject"))%> ID="radio"><%=r.getString(teasession._nLanguage, "Anchor")%>
          <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="getSubject_5" class="edit_input" type="text" value="<%=ld.getQuantity("getSubject")%>" maxlength="3" size="4" mask="int">
        </td>
      </tr>


      <tr>
        <td><%=r.getString(teasession._nLanguage, "Quantity")%>:</td>
        <TD nowrap>
          <input  id="CHECKBOX" type="CHECKBOX" name="countSons" value="checkbox"  <%=getCheck(ld.getIstype("countSons"))%> ID="radio"><%=r.getString(teasession._nLanguage, "Show")%>
          <%=r.getString(teasession._nLanguage, "Before")%>:<input name="countSons_1" mask="max" value="<%=MT.f(ld.getBeforeItem("countSons"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>:<input name="countSons_2" mask="max" value="<%=MT.f(ld.getAfterItem("countSons"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="countSons_3" type="text" class="edit_input" value="<%=ld.getSequence("countSons")%>" maxlength="3" size="4" mask="int">
          <input type=checkbox name="countSons_4" <%=getCheck(ld.getAnchor("countSons"))%> ID="radio"><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "新节点")%>:</td>
        <TD nowrap>
          <input  id="CHECKBOX" type="CHECKBOX" name="news" value="checkbox"  <%=getCheck(ld.getIstype("news"))%> ID="radio"><%=r.getString(teasession._nLanguage, "Show")%>
          <%=r.getString(teasession._nLanguage, "Before")%>:<input name="news_1" mask="max" value="<%=MT.f(ld.getBeforeItem("news"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>:<input name="news_2" mask="max" value="<%=MT.f(ld.getAfterItem("news"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="news_3" type="text" class="edit_input" value="<%=ld.getSequence("news")%>" maxlength="3" size="4" mask="int">
          <input type=checkbox name="news_4"   <%=getCheck(ld.getAnchor("news"))%> ID="radio"><%=r.getString(teasession._nLanguage, "Anchor")%>
        </td>
      </tr>

      <tr>
        <td><%=r.getString(teasession._nLanguage, "今天节点数")%>:</td>
        <TD nowrap>
          <input  id="CHECKBOX" type="CHECKBOX" name="todry" value="checkbox"  <%=getCheck(ld.getIstype("todry"))%> ID="radio"><%=r.getString(teasession._nLanguage, "Show")%>
          <%=r.getString(teasession._nLanguage, "Before")%>:<input name="todry_1" mask="max" value="<%=MT.f(ld.getBeforeItem("todry"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>:<input name="todry_2" mask="max" value="<%=MT.f(ld.getAfterItem("todry"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="todry_3" type="text" class="edit_input" value="<%=ld.getSequence("todry")%>" maxlength="3" size="4" mask="int">
          <input type=checkbox name="todry_4"   <%=getCheck(ld.getAnchor("todry"))%> ID="radio"><%=r.getString(teasession._nLanguage, "Anchor")%>
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "贴子数")%>:</td>
        <TD nowrap>
          <input  id="CHECKBOX" type="CHECKBOX" name="post" value="checkbox"  <%=getCheck(ld.getIstype("post"))%> ID="radio"><%=r.getString(teasession._nLanguage, "Show")%>
          <%=r.getString(teasession._nLanguage, "Before")%>:<input name="post_1" mask="max" value="<%=MT.f(ld.getBeforeItem("post"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>:<input name="post_2" mask="max" value="<%=MT.f(ld.getAfterItem("post"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="post_3" type="text" class="edit_input" value="<%=ld.getSequence("post")%>" maxlength="3" size="4" mask="int">
          <input type=checkbox name="post_4"   <%=getCheck(ld.getAnchor("post"))%> ID="radio"><%=r.getString(teasession._nLanguage, "Anchor")%>
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "访问量")%>:</td>
        <TD nowrap>
          <input  id="CHECKBOX" type="CHECKBOX" name="hits" value="checkbox"  <%=getCheck(ld.getIstype("hits"))%> ID="radio"><%=r.getString(teasession._nLanguage, "Show")%>
          <%=r.getString(teasession._nLanguage, "Before")%>:<input name="hits_1" mask="max" value="<%=MT.f(ld.getBeforeItem("hits"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>:<input name="hits_2" mask="max" value="<%=MT.f(ld.getAfterItem("hits"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="hits_3" type="text" class="edit_input" value="<%=ld.getSequence("hits")%>" maxlength="3" size="4" mask="int">
          <input type=checkbox name="hits_4"   <%=getCheck(ld.getAnchor("hits"))%> ID="radio"><%=r.getString(teasession._nLanguage, "Anchor")%>
        </td>
      </tr>

      <tr>
        <td><%=r.getString(teasession._nLanguage, "论坛版主")%>:</td>
        <TD nowrap>
          <input  id="CHECKBOX" type="CHECKBOX" name="bbshost" value="checkbox"  <%=getCheck(ld.getIstype("bbshost"))%> ID="radio"><%=r.getString(teasession._nLanguage, "Show")%>
          <%=r.getString(teasession._nLanguage, "Before")%>:<input name="bbshost_1" mask="max" value="<%=MT.f(ld.getBeforeItem("bbshost"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>:<input name="bbshost_2" mask="max" value="<%=MT.f(ld.getAfterItem("bbshost"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="bbshost_3" type="text" class="edit_input" value="<%=ld.getSequence("bbshost")%>" maxlength="3" size="4" mask="int">
          <%--<input type=checkbox name="bbshost_4"  <%=getCheck(ld.getAnchor("bbshost"))%> ID="radio"><%=r.getString(teasession._nLanguage, "Anchor")%>--%>
        </td>
      </tr>
    </table>
    <center >
      <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
      <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
    </center>
  </form>

<div id="head6"><img height="6" alt=""></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
