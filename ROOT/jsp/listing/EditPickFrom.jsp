<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.html.*" %><%@ page import="java.math.*" %><%@page import="tea.ui.node.general.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");


TeaSession teasession=new TeaSession(request);

int listing=Integer.parseInt(request.getParameter("listing"));
int pickfrom=Integer.parseInt(request.getParameter("pickfrom"));

int k = 0;
String s1=teasession._strCommunity;
int i1 = teasession._nNode;
if(pickfrom>0)
{
  PickFrom obj = PickFrom.find(pickfrom);
  listing=obj.getListing();
  k = obj.getFromStyle();
  s1 = obj.getFromCommunity();
  i1 = obj.getFromNode();
}

int realnode = Listing.find(listing).getNode();
if(realnode>0&&!Node.find(realnode).isCreator(teasession._rv)&&AccessMember.find(realnode,teasession._rv).getPurview()<2)
{
	response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

Node node = Node.find(teasession._nNode);

Resource r=new Resource("/tea/ui/node/listing/Picks");

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "PickFrom")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<FORM name=foEdit METHOD=POST action="/servlet/EditPickFrom" target="_ajax" onSubmit="return mt.check(this)">
  <input type='hidden' name="node" VALUE="<%=teasession._nNode%>">
  <input type='hidden' name="listing" VALUE="<%=listing%>">
  <input type=hidden name="pickfrom" value="<%=pickfrom%>">

  <table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage, "FromStyle")%>:</td>
      <td><SELECT name=FromStyle>
          <OPTION <%if(k==0)out.print(" selected='true'");%> VALUE="0"><%=r.getString(teasession._nLanguage, PickFrom.FROM_STYLE[0])%></OPTION>
          <OPTION <%if(k==1)out.print(" selected='true'");%> VALUE="1"><%=r.getString(teasession._nLanguage, PickFrom.FROM_STYLE[1])%></OPTION>
          <OPTION <%if(k==2)out.print(" selected='true'");%> VALUE="2"><%=r.getString(teasession._nLanguage, PickFrom.FROM_STYLE[2])%></OPTION>
          <OPTION <%if(k==3)out.print(" selected='true'");%> VALUE="3"><%=r.getString(teasession._nLanguage, PickFrom.FROM_STYLE[3])%></OPTION>
        </SELECT></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "FromCommunity")%>:</td>
      <td><!--input type="TEXT" class="edit_input"  name=FromCommunity VALUE="<%=s1%>"-->
        <%
          Community community_currently=Community.find(teasession._strCommunity);
          if(community_currently.getType()==2)
          {
            out.print("<select name=FromCommunity>");
            ArrayList al= Community.find("",0,Integer.MAX_VALUE);
            for(int i=0;i<al.size();i++)
            {
              Community c=(Community)al.get(i);
              if(c.getType()==2)
              {
                out.print("<option ");
                if(c.community.equals(s1))
                out.print("SELECTED");
                out.print(" value="+c.community+" >"+c.community);
              }
            }
            out.print("</select>");
          }else
          {
            out.print("<input type=hidden name=FromCommunity value="+node.getCommunity()+">"+node.getCommunity());
          }
          %> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "FromNode")%>:</td>
      <td><input type="TEXT" class="edit_input"  name=FromNode VALUE="<%=i1%>" alt="<%=r.getString(teasession._nLanguage, "FromNode")%>" /></td>
    </tr>
  </table>
  <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
