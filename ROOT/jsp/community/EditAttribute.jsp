<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.site.*" %>


<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int goodstype=Integer.parseInt(request.getParameter("goodstype"));

GoodsType gt_obj=GoodsType.find(goodstype);


tea.resource.Resource r=new tea.resource.Resource("/tea/ui/member/community/EditCommunity");

String community=request.getParameter("community");

String nexturl=request.getRequestURI()+"?"+request.getQueryString();
Community communitys=Community.find(teasession._strCommunity);
%>

<script Language="JavaScript">

function delete_add(ADD_ID)
{
 msg='<%=r.getString(teasession._nLanguage, "DeleteTemplate")%>';
 if(window.confirm(msg))
 {
  URL="delete.jsp?id=" + ADD_ID;
  window.location=URL;
 }
}
</script>


<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body id="bodynone">




<h1><%=r.getString(teasession._nLanguage, "AttributeManage")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=gt_obj.getAncestor(teasession._nLanguage)%></div>
<h2><%=r.getString(teasession._nLanguage, "AttributeManage")%></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

  <tr id=tableonetr>
    <td><%=r.getString(teasession._nLanguage, "Code")%></td>
    <td width="100"><%=r.getString(teasession._nLanguage, "Name")%></td>
    <td width="100"><%=r.getString(teasession._nLanguage, "Text")%></td>
    <td width="80"><%=r.getString(teasession._nLanguage, "operation")%></td>
  </tr>
        <%
        java.util.Enumeration enumeration=Attribute.findByGoodstype(goodstype);
        int id=0;
        while(enumeration.hasMoreElements())
        {
          id=((Integer)enumeration.nextElement()).intValue();
          Attribute obj=Attribute.find(id);

%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
  <td><%=id%></td>
  <td><%=obj.getName(teasession._nLanguage)%>&nbsp;</td>
  <td><%=obj.getText(r,teasession._nLanguage)%>&nbsp;</td>
  <td>
    <a href ="###" onClick="form1.name.value='<%=obj.getName(teasession._nLanguage)%>';form1.text.value='<%=obj.getText(teasession._nLanguage)%>';form1.attribute.value='<%=id%>';for(var index=0;index<form1.types.length;index++)if(form1.types[index].value=='<%=obj.getTypes()%>')form1.types[index].selected=true;form1.name.focus();" ><%=r.getString(teasession._nLanguage, "CBEdit")%></a>
    <a href ="###" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteTree")%>')){window.open('/servlet/EditAttribute?delete=ON&attribute=<%=id%>&nexturl='+encodeURIComponent('<%=nexturl%>'), '_self');}" ><%=r.getString(teasession._nLanguage, "Delete")%></a>
  </td>
</tr>
<%
}
%>
                        </table>
 <h2><%=r.getString(teasession._nLanguage, "AddAttribute")%></h2>
<form method="POST" action="/servlet/EditAttribute" name="form1" onSubmit="return(submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidParamter")%>'));">
<input type="hidden" name="community" value="<%=community%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="attribute" value="0"/>
<input type="hidden" name="goodstype" value="<%=goodstype%>"/>


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>*<%=r.getString(teasession._nLanguage, "Name")%></td>
    <td> <input name="name" type="text" class="edit_input" size="20" ></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Text")%></td>
    <td> <input name="text"  type="text" class="edit_input" size="20" >如: XXX1/XXX2/XXX3</td>
  </tr>
  <tr><td><%=r.getString(teasession._nLanguage, "Type")%></td>
    <td>
      <select name="types">
        <option value="text" selected><%=r.getString(teasession._nLanguage, "TextControl")%></option>
        <option value="img"><%=r.getString(teasession._nLanguage, "ImgControl")%></option>
        <option value="file"><%=r.getString(teasession._nLanguage, "FileControl")%></option>
        <option value="select"><%=r.getString(teasession._nLanguage, "SelectControl")%></option>
        <option value="radio"><%=r.getString(teasession._nLanguage, "RadioControl")%></option>
        <option value="checkbox"><%=r.getString(teasession._nLanguage, "CheckboxControl")%></option>
        <option value="textarea"><%=r.getString(teasession._nLanguage, "TextareaControl")%></option>
      </select>
    </td>
</tr>
<%--tr><td><%=r.getString(teasession._nLanguage, "Type")%></td><td>
  <%=new tea.htmlx.TypeSelection(teasession._nLanguage, 34, 0)%></td>
</tr--%>
<tr>
  <td colspan="2">
    <input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>" class="edit_button" id="edit_submit" name="submit">
    <input name="Submit" type="button" class="edit_button" value="<%=r.getString(teasession._nLanguage, "CBBack")%>" onClick="javascript:window.history.back(); return false;"></td>
</tr>
</table>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>



</body>
</html>


