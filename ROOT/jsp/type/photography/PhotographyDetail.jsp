<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.html.*" %><%@ page import="java.math.*" %>
<%@page import="tea.ui.node.general.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %>
<%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %>
<% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
int listingid= Integer.parseInt(teasession.getParameter("Listing"));
int realnode = Listing.find(listingid).getNode();
Node node = Node.find(realnode);
if(realnode>0&&!node.isCreator(teasession._rv)&&AccessMember.find(realnode,teasession._rv).getPurview()<2)
{
	response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/Report");

boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(listingid, 94, teasession._nLanguage);

//String arr[]={"name","MediaName", "MediaLogo", "ClassName", "Picture", "Locus", "Logograph", "text", "getSubhead", "getAuthor", "IssueTime", "correlation39", "correlation44"};

String title=r.getString(teasession._nLanguage, "Photography")+r.getString(teasession._nLanguage, "Detail");

%><html>
<head>
<title><%=title%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<form name="form1" method="post" action="/servlet/EditListingDetail">
<input type="hidden" name="ListingType" value="94"/>
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
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Title")%>:</td><%-- --%>
    <td>
    <select name="name">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("name"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="name_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("name"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "After")%><input name="name_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("name"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="name_3" class="edit_input" type="text" value="<%=ld.getSequence("name")%>" mask="int" maxlength="3" size="4"/>
    <input  id=CHECKBOX type="CHECKBOX" name="name_4"  <%if(0!=ld.getAnchor("name"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>

    <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="name_5" class="edit_input" type="text" value="<%=ld.getQuantity("name")%>" mask="int" maxlength="3" size="4"/>
    </td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "By")%>:</td>
    <td>
    <select name="byname">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("byname"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="byname_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("byname"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "After")%><input name="byname_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("byname"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="byname_3" class="edit_input" type="text" value="<%=ld.getSequence("byname")%>" mask="int" maxlength="3" size="4"/>
    <input  id=CHECKBOX type="CHECKBOX" name="byname_4"  <%if(0!=ld.getAnchor("byname"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>

    <%=r.getString(teasession._nLanguage, "连接的node号")%>:<input name="byname_5" class="edit_input" type="text" value="<%=ld.getQuantity("byname")%>" mask="int"  size="4"/>
    (说明：node是创建一个node来放include文件/jsp/type/photography/MyPhotography_2.jsp)
    </td>
  </tr>

    <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "CameraBrand")%>:</td><!--相机信息 -->
    <td>
    <select name="camerabrand">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("camerabrand"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="camerabrand_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("camerabrand"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "After")%><input name="camerabrand_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("camerabrand"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="camerabrand_3" class="edit_input" type="text" value="<%=ld.getSequence("camerabrand")%>" mask="int" maxlength="3" size="4"/>
    <input  id=CHECKBOX type="CHECKBOX" name="camerabrand_4"  <%if(0!=ld.getAnchor("camerabrand"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>

    <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="camerabrand_5" class="edit_input" type="text" value="<%=ld.getQuantity("camerabrand")%>" mask="int" maxlength="3" size="4"/>
    </td>
  </tr>


    <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Categories")%>:</td><!-- 类型 -->
    <td>
    <select name="categories">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("categories"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="categories_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("categories"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "After")%><input name="categories_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("categories"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="categories_3" class="edit_input" type="text" value="<%=ld.getSequence("categories")%>" mask="int" maxlength="3" size="4"/>
    <input  id=CHECKBOX type="CHECKBOX" name="categories_4"  <%if(0!=ld.getAnchor("categories"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>

    <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="categories_5" class="edit_input" type="text" value="<%=ld.getQuantity("categories")%>" mask="int" maxlength="3" size="4"/>
    </td>
  </tr>

  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Caption")%>:</td><!-- 描述 -->
    <td>
    <select name="caption">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("caption"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="caption_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("caption"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "After")%><input name="caption_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("caption"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="caption_3" class="edit_input" type="text" value="<%=ld.getSequence("caption")%>" mask="int" maxlength="3" size="4"/>
    <input  id=CHECKBOX type="CHECKBOX" name="caption_4"  <%if(0!=ld.getAnchor("caption"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>

    <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="caption_5" class="edit_input" type="text" value="<%=ld.getQuantity("caption")%>" mask="int" maxlength="3" size="4"/>
    </td>
  </tr>

	<tr>
	    <td align="right"><%=r.getString(teasession._nLanguage, "图片")%>:</td>
	    <td>
	    <select name="picpath">
	    <%
	    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
	    {
	      out.print("<option value='"+st+"'");
	      if(st==ld.getIstype("picpath"))out.print(" selected=''");
	      out.print(">"+ListingDetail.SHOW_TYPE[st]);
	    }
	    %>
	    </select>
	    <%=r.getString(teasession._nLanguage, "Before")%><input name="picpath_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("picpath"))%>" type="text"/>
	    <%=r.getString(teasession._nLanguage, "After")%><input name="picpath_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("picpath"))%>" type="text"/>
	    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="picpath_3" class="edit_input" type="text" value="<%=ld.getSequence("picpath")%>" mask="int" maxlength="3" size="4"/>
	    <input  id=CHECKBOX type="CHECKBOX" name="picpath_4"  <%if(0!=ld.getAnchor("picpath"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>


	    </td>
	  </tr>
  <tr>
	    <td align="right"><%=r.getString(teasession._nLanguage, "缩略图片")%>:</td>
	    <td>
	    <select name="abbpicpath">
	    <%
	    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
	    {
	      out.print("<option value='"+st+"'");
	      if(st==ld.getIstype("abbpicpath"))out.print(" selected=''");
	      out.print(">"+ListingDetail.SHOW_TYPE[st]);
	    }
	    %>
	    </select>
	    <%=r.getString(teasession._nLanguage, "Before")%><input name="abbpicpath_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("abbpicpath"))%>" type="text"/>
	    <%=r.getString(teasession._nLanguage, "After")%><input name="abbpicpath_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("abbpicpath"))%>" type="text"/>
	    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="abbpicpath_3" class="edit_input" type="text" value="<%=ld.getSequence("abbpicpath")%>" mask="int" maxlength="3" size="4"/>
	    <input  id=CHECKBOX type="CHECKBOX" name="abbpicpath_4"  <%if(0!=ld.getAnchor("abbpicpath"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>


	    </td>
	  </tr>

<tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "创建用户")%>:</td>
    <td>
    <select name="member">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("member"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="member_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("member"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "After")%><input name="member_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("member"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="member_3" class="edit_input" type="text" value="<%=ld.getSequence("member")%>" mask="int" maxlength="3" size="4"/>
    <input  id=CHECKBOX type="CHECKBOX" name="member_4"  <%if(0!=ld.getAnchor("member"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>

    <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="member_5" class="edit_input" type="text" value="<%=ld.getQuantity("member")%>" mask="int" maxlength="3" size="4"/>
    </td>
  </tr>
	<tr>
	    <td align="right"><%=r.getString(teasession._nLanguage, "票数")%>:</td>
	    <td>
	    <select name="votenumber">
	    <%
	    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
	    {
	      out.print("<option value='"+st+"'");
	      if(st==ld.getIstype("votenumber"))out.print(" selected=''");
	      out.print(">"+ListingDetail.SHOW_TYPE[st]);
	    }
	    %>
	    </select>
	    <%=r.getString(teasession._nLanguage, "Before")%><input name="votenumber_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("votenumber"))%>" type="text"/>
	    <%=r.getString(teasession._nLanguage, "After")%><input name="votenumber_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("votenumber"))%>" type="text"/>
	    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="votenumber_3" class="edit_input" type="text" value="<%=ld.getSequence("votenumber")%>" mask="int" maxlength="3" size="4"/>

	    </td>
	  </tr>
<tr>
	    <td align="right"><%=r.getString(teasession._nLanguage, "投票按钮")%>:</td>
	    <td>
	    <select name="vote">
	    <%
	    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
	    {
	      out.print("<option value='"+st+"'");
	      if(st==ld.getIstype("vote"))out.print(" selected=''");
	      out.print(">"+ListingDetail.SHOW_TYPE[st]);
	    }
	    %>
	    </select>
	    <%=r.getString(teasession._nLanguage, "Before")%><input name="vote_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("vote"))%>" type="text"/>
	    <%=r.getString(teasession._nLanguage, "After")%><input name="vote_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("vote"))%>" type="text"/>
	    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="vote_3" class="edit_input" type="text" value="<%=ld.getSequence("vote")%>" mask="int" maxlength="3" size="4"/>

	    </td>
	  </tr>
	  <tr>
	  	<td></td>
	  	<td>
	  		<textarea rows="4" cols="60">
function f_vote(igd,d,language)
{
	sendx("/servlet/EditPhotography?act=edivote&node="+igd+"&1-11111111-1111111111111-a="+d,
		function(data)
		{
			alert(data);
			window.open(location.href,'_self');
		}
	);
}
	  		</textarea>
	  	</td>
	  </tr>

     <tr>
	    <td align="right"><%=r.getString(teasession._nLanguage, "相关作品")%>:</td>
	    <td>
	    <select name="related">
	    <%
	    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
	    {
	      out.print("<option value='"+st+"'");
	      if(st==ld.getIstype("related"))out.print(" selected=''");
	      out.print(">"+ListingDetail.SHOW_TYPE[st]);
	    }
	    %>
	    </select>
	    <%=r.getString(teasession._nLanguage, "Before")%><input name="related_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("related"))%>" type="text"/>
	    <%=r.getString(teasession._nLanguage, "After")%><input name="related_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("related"))%>" type="text"/>
	    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="related_3" class="edit_input" type="text" value="<%=ld.getSequence("related")%>" mask="int" maxlength="3" size="4"/>

	    </td>
	  </tr>
	   <tr>
		    <td align="right"><%=r.getString(teasession._nLanguage, "查看大图")%>:</td>
		    <td>
		    <select name="enlargepic">
		    <%
		    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
		    {
		      out.print("<option value='"+st+"'");
		      if(st==ld.getIstype("enlargepic"))out.print(" selected=''");
		      out.print(">"+ListingDetail.SHOW_TYPE[st]);
		    }
		    %>
		    </select>
		    <%=r.getString(teasession._nLanguage, "Before")%><input name="enlargepic_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("enlargepic"))%>" type="text"/>
		    <%=r.getString(teasession._nLanguage, "After")%><input name="enlargepic_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("enlargepic"))%>" type="text"/>
		    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="enlargepic_3" class="edit_input" type="text" value="<%=ld.getSequence("enlargepic")%>" mask="int" maxlength="3" size="4"/>

		    </td>
	  </tr>



</table>



<INPUT TYPE=SUBMIT class="edit_button"  NAME="GoBack" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
<INPUT TYPE=SUBMIT  class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </form>


</DIV>
<div id="head6"><img height="6" src="about:blank"></div>
 <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>

</body>
</html>
