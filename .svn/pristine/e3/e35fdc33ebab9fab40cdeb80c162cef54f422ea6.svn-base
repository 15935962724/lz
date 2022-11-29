<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/member/contact/AddToContact");
if(!teasession._rv.isSupport())
{
  response.sendError(403);
  return;
}%>
<html>
  <head>
    <link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
  </head>
  <body>
  <h1><%=r.getString(teasession._nLanguage, "CBAddToContact")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
  <%
  //PrintWriter printwriter = ts.beginOut(response, teasession);
  String s = request.getParameter("Member");
  if(s == null)
  s = Node.find(teasession._nNode).getCreator().toString();
  String as[] = request.getParameterValues("CGroups");
  if(as == null)
  {%>
  <%=RequestHelper.format(r.getString(teasession._nLanguage, "InfAddToContact"), s)%>
  <FORM name=foAdd METHOD=POST action="/servlet/AddToContact">
    <input type='hidden' name=community VALUE="<%=node.getCommunity()%>">
    <input type='hidden' name=Member VALUE="<%=s%>">
    <%

    String s1;
    String s4;
    for(Enumeration enumeration = CGroup.find(teasession._rv._strR); enumeration.hasMoreElements(); out.print(new Anchor("/servlet/Contacts?CGroup=" + s1, "_blank", new Text(s4))))
    {
      s1 = (String)enumeration.nextElement();
      String s6 = CGroup.getMember(s1);
      CGroup cgroup1 = CGroup.find(s6, s1);
      s4 = cgroup1.getName(teasession._nLanguage);%>
      <input type='hidden' name=CGroups VALUE=<%=s1%>>
      <input id="CHECKBOX" type="CHECKBOX" name="<%=s1%>" value="false">
      <%              }

      String s2;
      String s5;
      for(Enumeration enumeration1 = CGroup.findCGroupLayerxII(teasession._rv._strR); enumeration1.hasMoreElements(); out.print(new Anchor("/servlet/Contacts?CGroup=" + s2, "_blank", new Text(s5))))
      {
        s2 = (String)enumeration1.nextElement();
        String s7 = CGroup.getMember(s2);
        CGroup cgroup2 = CGroup.find(s7, s2);
        s5 = cgroup2.getName(teasession._nLanguage);%>
        <input type='hidden' name=CGroups VALUE="<%=s2%>">
        <input id="CHECKBOX" type="CHECKBOX" name="<%=s2%>" value=false>
        <%              }%>
        <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </FORM>
  <div id="head6"><img height="6" src="about:blank"></div>
    <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
    <%          } else
    {
      RV rv = new RV(s);
      StringBuffer stringbuffer = new StringBuffer();
      for(int i = 0; i < as.length; i++)
      if(request.getParameter(as[i]) != null)
      {
        String s3 = CGroup.getMember(as[i]);
        CGroup cgroup = CGroup.find(s3, as[i]);
        stringbuffer.append(new Anchor("/servlet/Contacts?CGroup=" + as[i], "_blank", new Text(cgroup.getName(teasession._nLanguage))));
        Contact.create(s3, as[i], rv);
      }

      Object aobj[] = {
        s, stringbuffer.toString()
      };%>
      <%=(r.getString(teasession._nLanguage, "InfContactAdded"))%>
      <input type=SUBMIT name="<%=r.getString(teasession._nLanguage, "Close")%>" VALUE="Close" onClick="window.close();">
      <%           }
      %>
      </body>
</html>



