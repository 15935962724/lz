<%@page contentType="text/html;charset=utf-8" %>
<%@include file="/jsp/include/Header.jsp"%>

<%

String community=node.getCommunity();
if(teasession._rv==null)
{
  if((node.getOptions1()& 1) == 0)
  {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
  }
}else
{/*
  tea.entity.node.AccessMember obj_am = tea.entity.node.AccessMember.find(node._nNode, teasession._rv._strV);
  if (!node.isCreator(teasession._rv)&&!obj_am.isProvider(81))
  {
    response.sendError(403);
    return;
  }*/
}



%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
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
<body onload="">
<h1><%=r.getString(teasession._nLanguage, "EditCorrelative")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%> </div>
  <%
String types[]=request.getParameterValues("types");
if(types!=null)
{
  StringBuffer hidden=new StringBuffer();
  for(int index=0;index<types.length;index++)
  {
    hidden.append("&types="+types[index]);
  }
  StringBuffer sb=new StringBuffer();
  for(int index=0;index<types.length;index++)
  {
    int type=Integer.parseInt(types[index]);
    %>
    <FORM name="foNew<%=types[index]%>" METHOD=POST action="/servlet/EditCorrelative"   onsubmit="" >
      <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
      <input type='hidden' name=type VALUE="<%=type%>">
      <input type='hidden' name=types VALUE="<%=hidden.toString()%>">
      <input type='hidden' name=act VALUE="next">
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
          <td nowrap><input type="button" onclick="foNew<%=types[index]%>.correlative.value=<%=id%>;fc(foNew<%=types[index]%>.cnode,<%=lc.getCnode()%>);foNew<%=types[index]%>.submit.value='<%=r.getString(teasession._nLanguage, "Submit")%>';" value="<%=r.getString(teasession._nLanguage, "Edit")%>"/>
            <input type="submit" name="delete" onclick="if( confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){foNew<%=type%>.correlative.value=<%=id%>;return true;}else return false;" value="<%=r.getString(teasession._nLanguage, "Delete")%>"/></td>
        </tr>
        <%
        }
        %>

        <tr>
          <td nowrap><%=r.getString(teasession._nLanguage, Node.NODE_TYPE[type])%>:</td>
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
          <td><input type="submit" name="submit" onclick="return submitSelect(foNew<%=type%>.cnode, '<%=r.getString(teasession._nLanguage, "InvalidNode")%>');" value="<%=r.getString(teasession._nLanguage, "CBNew")%>"/></td>
        </tr>


      </table>
</form>
<br/>
<%
}
}
%>

<%--
  <FORM name=foNew2 METHOD=POST action="/servlet/EditLandscape"   onsubmit="" >
     <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
     <input type='hidden' name=type VALUE="81">
          <input type='hidden' name=act VALUE="next">
          <input type='hidden' name=correlative VALUE="0">

    <table cellspacing="0" class="section">
    <%
java.util.Enumeration enumerLandscape=    tea.entity.node.Correlative.findLandscapeByNode(teasession._nNode);
while(enumerLandscape.hasMoreElements())
{
int id=((Integer)  enumerLandscape.nextElement()).intValue();
tea.entity.node.Correlative lc=tea.entity.node.Correlative.find(id);
%>
      <tr>
        <td nowrap><%=id%></td>
        <td nowrap><A target="_blank" href="/servlet/Landscape?node=<%=lc.getCorrelative()%>" ><%=tea.entity.node.Node.find(lc.getCorrelative()).getSubject(teasession._nLanguage)%></A></td>
        <td nowrap><input type="button"  onclick="foNew2.correlative.value=<%=id%>;fc(foNew2.correlative,<%=lc.getCorrelative()%>);foNew2.submit.value='<%=r.getString(teasession._nLanguage, "Submit")%>';" value="<%=r.getString(teasession._nLanguage, "Edit")%>"/>
        <input type="submit" name="delete" onclick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){foNew2.correlative.value=<%=id%>;return true;}else return false;" value="<%=r.getString(teasession._nLanguage, "Delete")%>"/></td>
      </tr>
<%
}
    %>

      <tr>
        <td nowrap><%=r.getString(teasession._nLanguage, "Landscape")%>:</td>
        <td nowrap>
          <select name="correlative">
          <option value="0">--------------------</option>
          <%
          enumer=    tea.entity.node.Node.findByType(81,node.getCommunity());
while(enumer.hasMoreElements())
{
  int id=((Integer)  enumer.nextElement()).intValue();
  tea.entity.node.Node lc=tea.entity.node.Node.find(id);
  out.print("<option value="+id+">"+lc.getSubject(teasession._nLanguage));
 }
%>
</select>
          </td>
          <td><input type="submit" onclick="return submitSelect(this.correlative, '<%=r.getString(teasession._nLanguage, "Landscape")%>')" name="submit" value="<%=r.getString(teasession._nLanguage, "CBNew")%>"/></td>
      </tr>


     </table>
</form>

--%>
    <center>
      <!--input type=button name="GoBack" id="edit_GoBack" onClick="window.location='/jsp/type/landscape/EditLandscape.jsp?node=<%=teasession._nNode%>';" class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>" -->
      <input type=button name="GoFinish" ID="edit_GoFinish"  onClick="window.location='/servlet/Landscape?node=<%=teasession._nNode%>';" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Finish")%>">
    </center>

<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

