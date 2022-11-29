<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%

if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(29))
{
  response.sendError(403);
  return;
}
tea.entity.node.Career career =  tea.entity.node.Career.find(teasession._nNode);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Career")%><%=r.getString(teasession._nLanguage, "Edit")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
  <FORM name=foEdit METHOD=POST action="/servlet/EditCareer">
    <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td><%=r.getString(teasession._nLanguage, "TimeType")%>:</td>
        <td><SELECT name=TimeType>
            <OPTION SELECTED VALUE="0"><%=r.getString(teasession._nLanguage, tea.entity.node.Career.CAREER_TIMETYPE[0])%></OPTION>
            <OPTION <%=getSelect(career.getTimeType()==1)%> VALUE="1"><%=r.getString(teasession._nLanguage, tea.entity.node.Career.CAREER_TIMETYPE[1])%></OPTION>
          </SELECT></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Salary") %>: </td>
        <td><input type="TEXT" class="edit_input"  name=Salary value="<%=getNull(career.getSalary(teasession._nLanguage))%>"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Location")%>:</td>
        <td><input type="TEXT" class="edit_input"  name="Location" value="<%=getNull(career.getLocation(teasession._nLanguage))%>"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Skill")%>:</td>
        <td><input type="TEXT" class="edit_input"  name="Skill" value="<%=getNull(career.getSkill(teasession._nLanguage))%>"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Target")%>:</td>
        <td><input type="TEXT" class="edit_input"  name="Target" value="<%=getNull(career.getTarget(teasession._nLanguage))%>"></td>
      </tr>
    </table>
    <P ALIGN=CENTER>
      <input type="submit" name="GoBack" id="edit_GoBack" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
      <input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
    </P>
  </form>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

