<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
tea.entity.site.YellowPage yp=tea.entity.site.YellowPage.find(teasession._rv._strR);
if(getNull(yp.getMailid()).length()>0)
{
  %>
        <FORM NAME="logon" METHOD="POST" ACTION="http://211.144.143.146:8383/login.cgi">
          <INPUT TYPE="hidden" NAME="page" VALUE="login">
            <INPUT TYPE="hidden" SIZE="32" NAME="userid" value="<%=yp.getMailid()%>">
              <INPUT TYPE="hidden" SIZE="32" NAME="passwd" value="<%=yp.getMailpw()%>">
                <script type="">logon.submit();</script>
                </form>
<%}else
out.print("你的E-Mail还未开通");
%>

