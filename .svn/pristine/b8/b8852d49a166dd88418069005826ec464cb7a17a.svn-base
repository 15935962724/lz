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


int cnode=Integer.parseInt(request.getParameter("cnode"));
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
<h1><%=r.getString(teasession._nLanguage, "TravelHostelCorrelative")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%> </div>

  <%
    int type=0;
    %>
    <FORM name="foNew<%=type%>" METHOD=POST action="/servlet/EditCorrelative"   onsubmit="" >
      <input type='hidden' name=Node VALUE="<%=cnode%>">
      <input type='hidden' name=type VALUE="<%=type%>">
      <input type='hidden' name=nexturl VALUE="<%=request.getRequestURI()+"?"+request.getQueryString()%>">
      <input type='hidden' name=correlative VALUE="0">

      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <%
      java.util.Enumeration enumer=    tea.entity.node.Correlative.find(cnode,0);
      while(enumer.hasMoreElements())
      {
        int id=((Integer)  enumer.nextElement()).intValue();
        tea.entity.node.Correlative lc=tea.entity.node.Correlative.find(id);
        %>
        <tr>
          <td nowrap><%=id%></td>
          <td nowrap><A target="_blank" href="/servlet/Hostel?node=<%=lc.getCnode()%>" ><%=tea.entity.node.Node.find(lc.getCnode()).getSubject(teasession._nLanguage)%></A></td>
          <td nowrap><%=lc.getPrice()%></td>
          <td nowrap>
            <input type="button" onClick="foNew<%=type%>.correlative.value=<%=id%>;fc(foNew<%=type%>.cnode,<%=lc.getCnode()%>);foNew<%=type%>.correlative.value=<%=id%>;foNew<%=type%>.price.value='<%=lc.getPrice()%>';foNew<%=type%>.submit.value='<%=r.getString(teasession._nLanguage, "Submit")%>';" value="<%=r.getString(teasession._nLanguage, "Edit")%>"/>
            <input type="submit" name="delete" onClick="if( confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){foNew<%=type%>.correlative.value=<%=id%>;return true;}else return false;" value="<%=r.getString(teasession._nLanguage, "Delete")%>"/></td>
        </tr>
        <%
        }
        %>
        </table>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
          <td nowrap><%=r.getString(teasession._nLanguage, Node.NODE_TYPE[48])%>:</TD>
          <td nowrap>
            <select name="cnode">
              <option value="0">--------------------</option>
              <%
              enumer=    tea.entity.node.Node.findByType(48,node.getCommunity());
              while(enumer.hasMoreElements())
              {
                int id=((Integer)  enumer.nextElement()).intValue();
                tea.entity.node.Node lc=tea.entity.node.Node.find(id);
                out.print("<option value="+id+">"+lc.getSubject(teasession._nLanguage));
              }
              %>
              </select>
          </td>
          </tr>
          <tr>
          <td nowrap><%=r.getString(teasession._nLanguage, "Price")%>:</TD>
          <td><input name="price" value="">
          </td>
          </tr>
                    <tr>
          <td nowrap><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
          <td><input name="synopsis" value="">
          </td>
          </tr>

          <tr>
          <td><input type="submit" name="submit" onClick="return submitSelect(foNew<%=type%>.cnode, '<%=r.getString(teasession._nLanguage, "InvalidNode")%>')&&submitFloat(foNew<%=type%>.price, '<%=r.getString(teasession._nLanguage, "InvalidPrice")%>');" value="<%=r.getString(teasession._nLanguage, "CBNew")%>"/></td>
        </tr>


      </table>
</form>
    <center>
      <!--input type=button name="GoBack" id="edit_GoBack" onClick="window.location='/jsp/type/landscape/EditLandscape.jsp?node=<%=teasession._nNode%>';" class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>" -->
      <input type=button name="GoFinish" ID="edit_GoFinish"  onClick="window.location='/jsp/type/travel/EditTravelCorrelative.jsp?types=81&types=49&node=<%=teasession._nNode%>';" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Finish")%>">
    </center>
 <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

