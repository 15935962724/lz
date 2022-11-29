<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/resource/Download");
int listingid= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(listingid).getNode();

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}
boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(listingid,2,teasession._nLanguage);
String title=r.getString(teasession._nLanguage, "Report")+r.getString(teasession._nLanguage, "Detail");

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Pages")%><%=r.getString(teasession._nLanguage, "Edit")%></h1>
 <div id="head6"><img height="6" src="about:blank"></div>
  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

   <br>
   <FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">


     <input type="hidden" name="ListingType" value="2"/>
     <input type="hidden" name="Listing" value="<%=listingid%>"/>
     <input type="hidden" name="node" value="<%=teasession._nNode%>"/>
     <%
     if(!flag)
     {
       out.print("<input type='hidden' name='PickNode' value="+request.getParameter("PickNode")+" />");
     }else
     {
       out.print("<input type='hidden' name='PickManual' value="+request.getParameter("PickManual")+" />");
     }
     if(request.getParameter("Edit")!=null)
     {
       out.print("<input type='hidden' name='Edit' value="+request.getParameter("Edit")+" />");
     }
     %>



          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

            <!--主题-->
            <tr>
              <td><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
              <td>
                <select name="Subject">
                <%
                for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
                {
                  out.print("<option value='"+st+"'");
                  if(st==ld.getIstype("Subject"))out.print(" selected=''");
                  out.print(">"+ListingDetail.SHOW_TYPE[st]);
                }
                %>
                </select>
                <%=r.getString(teasession._nLanguage, "Before")%><input name="Subject_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Subject"))%>" type="text"/>
                  <%=r.getString(teasession._nLanguage, "After")%><input name="Subject_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Subject"))%>" type="text"/>
                    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Subject_3" class="edit_input" type="text" value="<%=ld.getSequence("Subject")%>" mask="int" maxlength="3" size="4"/>
                      <input  id=CHECKBOX type="CHECKBOX" name="Subject_4"  <%if(0!=ld.getAnchor("Subject"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>


                      <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="Subject_5" class="edit_input" type="text" value="<%=ld.getQuantity("Subject")%>" mask="int" maxlength="3" size="4"/>
              </td>
            </tr>


                 <!--内容-->
            <tr>
              <td><%=r.getString(teasession._nLanguage, "内容")%>:</td>
              <td>
                <select name="Content">
                <%
                for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
                {
                  out.print("<option value='"+st+"'");
                  if(st==ld.getIstype("Content"))out.print(" selected=''");
                  out.print(">"+ListingDetail.SHOW_TYPE[st]);
                }
                %>
                </select>
                <%=r.getString(teasession._nLanguage, "Before")%><input name="Content_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Content"))%>" type="text"/>
                  <%=r.getString(teasession._nLanguage, "After")%><input name="Content_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Content"))%>" type="text"/>
                    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Content_3" class="edit_input" type="text" value="<%=ld.getSequence("Content")%>" mask="int" maxlength="3" size="4"/>
                      <input  id=CHECKBOX type="CHECKBOX" name="Content_4"  <%if(0!=ld.getAnchor("Content"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>


                      <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="Content_5" class="edit_input" type="text" value="<%=ld.getQuantity("Content")%>" mask="int" maxlength="3" size="4"/>
              </td>
            </tr>
            <!--内容-->
            <tr>
              <td><%=r.getString(teasession._nLanguage, "图片")%>:</td>
              <td>
                <select name="Picture">
                <%
                for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
                {
                  out.print("<option value='"+st+"'");
                  if(st==ld.getIstype("Picture"))out.print(" selected=''");
                  out.print(">"+ListingDetail.SHOW_TYPE[st]);
                }
                %>
                </select>
                <%=r.getString(teasession._nLanguage, "Before")%><input name="Picture_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Picture"))%>" type="text"/>
                  <%=r.getString(teasession._nLanguage, "After")%><input name="Picture_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Picture"))%>" type="text"/>
                    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Picture_3" class="edit_input" type="text" value="<%=ld.getSequence("Picture")%>" mask="int" maxlength="3" size="4"/>
                       <select name="Picture_4" >
                         <option  value="0">-----</option>
                         <option <%=getSelect(ld.getAnchor("Picture")==1)%> value="1"><%=r.getString(teasession._nLanguage, "Node")%></option>
                         <option <%=getSelect(ld.getAnchor("Picture")==3)%> value="3"><%=r.getString(teasession._nLanguage, "大图")%></option>
                       </select><%=r.getString(teasession._nLanguage, "Anchor")%>
              </td>
            </tr>

            <!--重定向URL-->
             <tr>
              <td><%=r.getString(teasession._nLanguage, "RedirectUrl")%>:</td>
              <td>
                <select name="RedirectUrl">
                <%
                for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
                {
                  out.print("<option value='"+st+"'");
                  if(st==ld.getIstype("RedirectUrl"))out.print(" selected=''");
                  out.print(">"+ListingDetail.SHOW_TYPE[st]);
                }
                %>
                </select>
                <%=r.getString(teasession._nLanguage, "Before")%><input name="RedirectUrl_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("RedirectUrl"))%>" type="text"/>
                  <%=r.getString(teasession._nLanguage, "After")%><input name="RedirectUrl_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("RedirectUrl"))%>" type="text"/>
                    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="RedirectUrl_3" class="edit_input" type="text" value="<%=ld.getSequence("RedirectUrl")%>" mask="int" maxlength="3" size="4"/>
                        <select name="RedirectUrl_4" >
                         <option  value="0">-----</option>
                         <option <%=getSelect(ld.getAnchor("RedirectUrl")==1)%> value="1"><%=r.getString(teasession._nLanguage, "Node")%></option>
                         <option <%=getSelect(ld.getAnchor("RedirectUrl")==2)%> value="2"><%=r.getString(teasession._nLanguage, "RedirectUrl")%></option>
                       </select><%=r.getString(teasession._nLanguage, "Anchor")%>



              </td>
            </tr>


</table>
<center >
    <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
      </center>
  </form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>


<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>

