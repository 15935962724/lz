<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %><%@page import="tea.html.*" %><%@page import="java.math.*" %><%@page import="tea.ui.node.general.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.db.DbAdapter" %><%@page  import="tea.resource.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.*" %><%@page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

Http h=new Http(request,response);

int listing=h.getInt("listing");
int pickmanual=h.getInt("pickmanual");


PickManual t=PickManual.find(pickmanual);

int _nNode=Listing.find(listing).getNode();
Node node=Node.find(_nNode);
if(!node.isCreator(h.member)&&AccessMember.find(_nNode,h.username).getPurview()<2)
{
  response.sendRedirect("/servlet/StartLogin?node=" + h.node);
  return;
}


Resource r=new Resource("/tea/ui/node/listing/EditPickManual").add("/tea/ui/node/listing/Picks");


%><html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(h.language, "PickManual")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(h.language)%></div>
<form name=foEdit METHOD=POST action="/servlet/EditPickManual">
<input type='hidden' name=node VALUE="<%=h.node%>">
<input type='hidden' name=listing VALUE="<%=listing%>">
<input type='hidden' name=pickmanual value="<%=t.pickmanual%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td class="th"><%=r.getString(h.language, "Community")%>:</td>
    <td><select name="community"><option value=""><%=r.getString(h.language,"AllCommunities")%></option><%=Community.options(t.community)%></select></td>
  </tr>
  <tr>
    <td class="th"><%=r.getString(h.language, "Type")%>:</td>
    <td><%=new tea.htmlx.TypeSelection(h.community, h.language,t.type)%></td>
  </tr>
  <tr>
    <td class="th"><%=r.getString(h.language, "Classes")%>:</td>
    <td><select name="classes">
    <%
    for(int i=0;i<PickManual.CLASSES_TYPE.length;i++)
    {
      out.print("<option value="+i);
      if(t.classes==i)out.print(" selected ");
      out.print(">"+r.getString(h.language,PickManual.CLASSES_TYPE[i]));
    }
    %>
    </select>
    </td>
  </tr>
</table>

<input type="submit" class="edit_button" id="edit_next"  name="GoNext" value="<%=r.getString(h.language, "CBNext")%>">
<input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(h.language, "Submit")%>">
</form>


<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(h.language, request)%></div>
</body>
</html>
