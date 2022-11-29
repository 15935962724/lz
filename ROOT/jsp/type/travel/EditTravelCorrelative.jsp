<%@page contentType="text/html;charset=utf-8" %>
<%@include file="/jsp/include/Header.jsp"%>

<%

String community=node.getCommunity();
if((node.getOptions1()& 1) == 0)
{
  if(teasession._rv==null)
  {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
  }
  if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(79))
  {
    response.sendError(403);
    return;
  }
}

r.add("/tea/resource/Ticket");
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

<script type="">
function fc(obj,value)
{
  for(var index=0;index<obj.length;index++)
  {
    if( obj.options[index].value==value)
    {
      obj.options[index].selected=true;
      obj.focus();
      break;
    }
  }
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "EditTravelCorrelative")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%> </div>

  <%
    int type=81;
    %>
    <FORM name="foNew<%=type%>" METHOD=POST action="/servlet/EditCorrelative"   onsubmit="" >
      <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
      <input type='hidden' name=type VALUE="<%=type%>">
      <input type='hidden' name=nexturl VALUE="/jsp/type/travel/EditTravelCorrelative.jsp?types=49&types=81&node=<%=teasession._nNode%>">
      <input type='hidden' name=correlative VALUE="0">

      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <%
      java.util.Enumeration enumer=    tea.entity.node.Correlative.find(teasession._nNode,type);
      while(enumer.hasMoreElements())
      {
        int id=((Integer)  enumer.nextElement()).intValue();
        tea.entity.node.Correlative lc=tea.entity.node.Correlative.find(id);
        %>
        <tr>
          <td nowrap><%=id%></td>
          <td nowrap><A target="_blank" href="/servlet/Hostel?node=<%=lc.getCnode()%>" ><%=tea.entity.node.Node.find(lc.getCnode()).getSubject(teasession._nLanguage)%></A></td>
          <td nowrap><%=lc.getOptions()%></td>
          <td nowrap>
            <input type="button" onClick="window.location='/jsp/type/travel/EditTravelHostelCorrelative.jsp?node=<%=teasession._nNode%>&cnode=<%=id%>';" value="<%=r.getString(teasession._nLanguage, "Hostel")%>"/>

            <input type="button" onClick="foNew<%=type%>.correlative.value=<%=id%>;fc(foNew<%=type%>.cnode,<%=lc.getCnode()%>);foNew<%=type%>.correlative.value=<%=id%>;fc(foNew<%=type%>.options,<%=lc.getOptions()%>);foNew<%=type%>.submit.value='<%=r.getString(teasession._nLanguage, "Submit")%>';" value="<%=r.getString(teasession._nLanguage, "Edit")%>"/>
            <input type="submit" name="delete" onClick="if( confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){foNew.correlative.value=<%=id%>;return true;}else return false;" value="<%=r.getString(teasession._nLanguage, "Delete")%>"/></td>
        </tr>
        <%
        }
        %>

        <tr>
          <td nowrap><%=r.getString(teasession._nLanguage, Node.NODE_TYPE[type])%>:</TD>
          <td nowrap>
            <select name="cnode">
              <option value="0">--------------------</option>
              <%
              enumer=    tea.entity.node.Node.findByType(type,node.getCommunity());
              while(enumer.hasMoreElements())
              {
                int id=((Integer)  enumer.nextElement()).intValue();
                tea.entity.node.Node lc=tea.entity.node.Node.find(id);
                out.print("<option value="+id+">"+lc.getSubject(teasession._nLanguage));
              }
              %>
              </select>
          </td>
          <td nowrap><%=r.getString(teasession._nLanguage, "Time")%>:</TD>
          <td><select name="options">
  <option value="1" selected>1</option>
  <option value="2">2</option>
  <option value="3">3</option>
  <option value="4">4</option>
  <option value="5">5</option>
  <option value="6">6</option>
  <option value="7">7</option>
  <option value="8">8</option>
  <option value="9">9</option>
</select><%=r.getString(teasession._nLanguage, "Days")%>
          </td>
          <td><input type="submit" name="submit" onClick="return submitSelect(foNew<%=type%>.cnode, '<%=r.getString(teasession._nLanguage, "InvalidNode")%>');" value="<%=r.getString(teasession._nLanguage, "CBNew")%>"/></td>
        </tr>


      </table>
</form>

  <%
     type=0;
    %>
    <FORM name="foNew<%=type%>" METHOD=POST action="/servlet/EditCorrelative"   onsubmit="" >
      <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
      <input type='hidden' name=type VALUE="<%=type%>">
      <input type='hidden' name=nexturl VALUE="/jsp/type/travel/EditTravelCorrelative.jsp?types=49&types=81&node=<%=teasession._nNode%>">
      <input type='hidden' name=correlative VALUE="0">
<input type='hidden' name=cnode VALUE="0">
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <%
       enumer=    tea.entity.node.Correlative.find(teasession._nNode,type);
      while(enumer.hasMoreElements())
      {
        int id=((Integer)  enumer.nextElement()).intValue();
        tea.entity.node.Correlative lc=tea.entity.node.Correlative.find(id);

        %>
        <tr>
          <td nowrap><%=id%></td>
          <td nowrap><%=lc.getSynopsis(teasession._nLanguage)%></A></td>
          <td nowrap>
            <input type="button" onClick="window.location='/jsp/type/travel/EditTravelTicketCorrelative.jsp?node=<%=teasession._nNode%>&cnode=<%=id%>';" value="<%=r.getString(teasession._nLanguage, Node.NODE_TYPE[49])%>"/>
            <input type="button" onClick="foNew<%=type%>.correlative.value=<%=id%>;foNew<%=type%>.synopsis.value='<%=lc.getSynopsis(teasession._nLanguage)%>';foNew<%=type%>.submit.value='<%=r.getString(teasession._nLanguage, "Submit")%>';" value="<%=r.getString(teasession._nLanguage, "Edit")%>"/>
            <input type="submit" name="delete" onClick="if( confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){foNew<%=type%>.correlative.value=<%=id%>;return true;}else return false;" value="<%=r.getString(teasession._nLanguage, "Delete")%>"/></td>
        </tr>
        <%
        }
        %>

        <tr>
          <td nowrap><%=r.getString(teasession._nLanguage, "Course")%>:</TD>
          <td nowrap>

            <input  name="synopsis">
              </input>
          </td>
          <td nowrap></TD>
          <td>
          </td>
          <td><input type="submit" name="submit" onClick="return submitSelect(foNew<%=type%>.cnode, '<%=r.getString(teasession._nLanguage, "InvalidNode")%>');" value="<%=r.getString(teasession._nLanguage, "CBNew")%>"/></td>
        </tr>


      </table>
</form>
<br/>














    <center>
      <!--input type=button name="GoBack" id="edit_GoBack" onClick="window.location='/jsp/type/landscape/EditLandscape.jsp?node=<%=teasession._nNode%>';" class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>" -->
      <input type=button name="GoFinish" ID="edit_GoFinish"  onClick="window.location='/servlet/Landscape?node=<%=teasession._nNode%>';" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Finish")%>">
    </center>

 <div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>

