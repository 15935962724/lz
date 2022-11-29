<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/include/Header.jsp"%>

<%


if(teasession._rv==null)
{
  if((node.getOptions1()& 1) == 0)
  {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
  }
}else
{
  if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(49))
  {
    response.sendError(403);
    return;
  }
}

r.add("/tea/resource/Flight");
  int berth=0;
  if(request.getParameter("berth")!=null)
  berth=Integer.parseInt(request.getParameter("berth"));

  String name;
  int aagio=0;
  float price=0.0f;
  if(berth!=0)
  {
    Berth obj=Berth.find(berth);
    name=obj.getName(teasession._nLanguage);
    aagio=obj.getAagio();
    price=obj.getPrice();
  }else
  {
    name="";
  }

 java.util.Enumeration enumeration=Berth.findByNode(teasession._nNode);
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "EditBerth")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%>  </div>
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
      <td><%=r.getString(teasession._nLanguage, "Berth")%></td>
      <td><%=r.getString(teasession._nLanguage, "Aagio")%></td>
      <td><%=r.getString(teasession._nLanguage, "Price")%></td>
    <td>&nbsp;</td>
  </tr>
         <%
while(enumeration.hasMoreElements())
{
  int id=((Integer)enumeration.nextElement()).intValue();
  Berth flightObj=Berth.find(id);
%>
 <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
    <td><%if(flightObj.getBerth()==berth)out.print("<font color=\"#FF0000\">");out.print(flightObj.getName(teasession._nLanguage));%></td>
    <td><%=flightObj.getAagio()%></td>
    <td><%=flightObj.getPrice()%></td>
    <td><input name="button" type=button class="edit_button" onClick="window.open('EditBerth.jsp?node=<%=teasession._nNode%>&berth=<%=id%>','_self')" value="<%=r.getString(teasession._nLanguage, "Edit")%>">
        <input name="button" type=button class="edit_button" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteTree")%>')){window.open('/servlet/EditTicket?node=<%=teasession._nNode%>&berth=<%=id%>&delete=ON','_self');}" value="<%=r.getString(teasession._nLanguage, "Delete")%>">

        </td>
    </tr>
<%    }%>
</table>


<form name=f1 action="/servlet/EditTicket" method="post"  onsubmit="return(submitText(this.name, '<%=r.getString(teasession._nLanguage, "Berth")%>')&&submitInteger(this.aagio, '<%=r.getString(teasession._nLanguage, "Aagio")%>')&&submitFloat(this.price, '<%=r.getString(teasession._nLanguage, "Price")%>'))">
         <INPUT type="hidden" name="Node" value="<%=teasession._nNode%>">

                   <INPUT type="hidden" name="berth" value="<%=berth%>">
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Berth")%>:</td>
        <td><input type="text" name="name" value="<%=name%>"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Aagio")%>:</td>
        <td><input type="text" name="aagio" value="<%=aagio%>"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Price")%>:</td>
        <td><input type="text" name="price" value="<%=price%>"></td>
      </tr>
      <tr><td><INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
        </td>
      </tr>
    </table>
  <input type="button"  class="edit_button" name="CBBack" value="<%=r.getString(teasession._nLanguage, "GoBack")%>" onClick="window.open('EditFlight.jsp?node=<%=teasession._nNode%>','_self')" >
<INPUT TYPE=button name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>" onClick="location='/servlet/Flight?node=<%=teasession._nNode%>';">
</form>
   <script>document.f1.name.focus()</script><div id="head6"><img height="6" src="about:blank"></div>
      <div id="language"><%=new Languages(teasession._nLanguage,request)%>  </div>

</body>
</html>

