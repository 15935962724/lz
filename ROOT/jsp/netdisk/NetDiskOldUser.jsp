<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.resource.*" %>
<%
TeaSession teasession=new TeaSession(request);

Resource r=new Resource();

if("POST".equals(request.getMethod()))
{
  String member=request.getParameter("member").trim().toLowerCase();
  if(!Profile.isExisted(member))
  {
    out.print(new tea.html.Script("alert('"+r.getString(teasession._nLanguage,"InvalidMemberId")+".');history.back();"));
    return;
  }

  out.print(new tea.html.Script("window.opener.location='/jsp/netdisk/NetDiskNewUser2.jsp?community="+teasession._strCommunity+"&member="+java.net.URLEncoder.encode(member,"UTF-8")+"';window.close();"));
  return;
}

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
</SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Add")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM name=form1 METHOD=POST action="?" onSubmit="return(submitText(this.member,'<%=r.getString(teasession._nLanguage,"InvalidMemberId")%>'));">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td align="center">
          <%=r.getString(teasession._nLanguage,"MemberId")%>:<input name="member">

     <%--
            <select onchange="form1.Members.value=this.options[this.selectedIndex].value;">
		          <option value="" selected>-----------</option>
                          <%
                          java.util.Enumeration enumer=tea.entity.member.Profile.findByCommunity(node.getCommunity());
                          while(enumer.hasMoreElements())
                          {
                            String value=enumer.nextElement().toString();
                            out.println("<option VALUE="+value+">"+value+"</option>");
                          }

                          enumer=tea.entity.site.Subscriber.find(node.getCommunity(),0,Integer.MAX_VALUE);
                          while(enumer.hasMoreElements())
                          {
                            RV rv=(RV)enumer.nextElement();
                            out.println("<option VALUE="+rv._strR+">"+rv._strR+"</option>");
                          }
                          %>
		        </select>
         --%>
        </td>
      </tr>
    </table>

    <input type="submit"  value="<%=r.getString(teasession._nLanguage,"Submit")%>">

<input type="button" onclick="window.close();" value="<%=r.getString(teasession._nLanguage,"Close")%>">
  </form>

<div id="head6"><img height="6" src="about:blank"></div>
<script>form1.member.focus()</script>
</body>
</html>
