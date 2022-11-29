<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.lang.*,java.util.*,java.text.SimpleDateFormat,java.text.DateFormat" %>
<%

String community=request.getParameter("community");




%>

<p>
<table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
  <tr>
    <td><h2><%=r.getString(teasession._nLanguage,"1216027669329")%></h2></td>
  </tr>
  <tr>
    <td align="center">



           <table border="0" cellspacing="0" cellpadding="0" >
              <%
              java.util.Enumeration correlationenumer=      tea.entity.util.Keywords.findByKeywords(community,"",15);
              boolean bool=true;
              float f=0.0F;
              while(correlationenumer.hasMoreElements())
              {
                String k=(String)correlationenumer.nextElement();
                tea.entity.util.Keywords key=tea.entity.util.Keywords.find(community,k);
                if(bool)
                {
                  f=350F/key.getClick();
                  bool=false;
                }

%>
              <tr>
                <td nowap ><%=key.getKeywords()%></td>
                <td align=left  valign=middle width=350><img src="/tea/image/other/bar2.gif" width="<%=f*key.getClick()%>" height=15   ></td>
                <td nowap align="right"><%=df.format(key.getClick())%></td>
          <%--      <td nowap align="right"><%=df.format(key.getCount())%></td> --%>
              </tr>
              <%}%>

      </table></td>
  </tr>
</table>


