<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.lang.*,java.util.*,java.text.SimpleDateFormat,java.text.DateFormat" %>
<%@page import="tea.entity.node.access.*" %>
<%
String community=request.getParameter("community");
NodeAccessHour hour_obj=NodeAccessHour.find(community);
//	String strNode;
//	strNode =((java.lang.Integer) session.getAttribute("tea.Node")).toString();
//  dispcount dcount = new dispcount(strNode);
	int[] ihour =hour_obj.getCount();// new int[24];
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	java.text.SimpleDateFormat formatter2 = new java.text.SimpleDateFormat("hh");
	java.util.Date tcur = new java.util.Date();
	String sql;
	int i,j;
        java.util.Calendar ca=java.util.Calendar.getInstance();
	String strcurtime;
	strcurtime = formatter.format(tcur);
	int ncurday = ca.get(11);

 // ihour= dcount.get24hour(strcurtime);

 	int MaxHour=hour_obj.getCountMax(),avgheight,avgcount=0,k=0,sHeight;

	double vPoint;

	vPoint = 100.0/MaxHour;



%>

<p>
<table border="0" cellspacing="0" cellpadding="0" style="border: 1px solid #CCCCCC;padding:10px">

    <td align="center"><table border=0 cellpadding=0>
        <tr>
          <td align=center><h2><%=r.getString(teasession._nLanguage,"1216027843627")%></h2></td>
        </tr>
        <tr>
          <td align=center><table align=center cellpadding="0" cellspacing="0">
              <tr valign=bottom >
                <td valign=top><table border=0 align=center cellpadding=0 cellspacing=0 height=100>
                    <tr>
                      <td height=25 valign=top  align="right" nowrap><%=df.format(MaxHour)%> </td>
                    </tr>
                    <tr>
                      <td  height=25 valign=top align="right" nowrap><%=df.format(MaxHour*0.75) %></td>
                    </tr>
                    <tr>
                      <td  height=25 valign=top align="right" nowrap><%=df.format(MaxHour*0.5) %></td>
                    </tr>
                    <tr>
                      <td  height=25 valign=top align="right" nowrap><%=df.format(MaxHour*0.25) %></td>
                    </tr>
                  </table></td>
                <%
	for(int vL = (ncurday+1);vL< 24;vL++)
        {
		sHeight =(int)(ihour[vL]*vPoint);
		k = k+1;
		avgcount  = avgcount + ihour[vL];
		avgheight = (int) ((avgcount/k)*vPoint);
                %>
                <td align=center width=15    height=120 nowrap><img src="/tea/image/other/bar3.gif" style="background-color: #3775CA" width=15 height="<%=sHeight%>" id=htav avgheight="<%=avgheight%>"   title="<%=r.getString( teasession._nLanguage,"1216085236162" )+df.format(ihour[vL])%>"><br>
                  <%=(vL)%></td>
                <%}
                for(int vL = 0;vL<= ncurday;vL++)
                {
                  sHeight =(int)(ihour[vL]*vPoint);
                  k = k+1;
                  avgcount  = avgcount + ihour[vL];
                  avgheight = (int) ((avgcount/k)*vPoint);
%>
                <td align=center width=15   height=120 nowrap><img src="/tea/image/other/bar3.gif" style="background-color: #3775CA" width=15 height="<%=sHeight%>" id=htav avgheight="<%=avgheight%>"   title=<%=r.getString( teasession._nLanguage,"1216085236162" )+df.format(ihour[vL])%>><br>
                  <%=(vL)%><A href="/jsp/count/HourIp.jsp?community=<%=community%>&hour=<%=(vL)%>"></A></td>
                  <%	}
                  MaxHour=hour_obj.getSumMax();
                  %>
                <td><%=r.getString(teasession._nLanguage,"1216027901518")%></td>
              </tr>
            </table></td>
        </tr>
      </table>

      <table border=0 cellpadding=0 cellspacing="0">
        <tr>
          <td align=center><h2><%=r.getString(teasession._nLanguage,"1216027956643")%></h2></td>
        </tr>
        <tr>
          <td align=center><table border="0" align=center cellpadding="0" cellspacing="0">
              <tr valign=bottom >
                <td valign=top><table border=0 align=center cellpadding=0 cellspacing=0 height=100>
                    <tr>
                      <td height=25 valign=top align="right" nowrap><%=df.format(MaxHour)%></td>
                    </tr>
                    <tr>
                      <td  height=25 valign=top align="right" nowrap><%=df.format(MaxHour*0.75) %></td>
                    </tr>
                    <tr>
                      <td  height=25 valign=top align="right" nowrap><%=df.format(MaxHour*0.5) %></td>
                    </tr>
                    <tr>
                      <td  height=25 valign=top align="right" nowrap><%=df.format(MaxHour*0.25)%></td>
                    </tr>
                  </table></td>
                <%

                vPoint = 100.0/MaxHour;
                ihour=hour_obj.getSum();
	for(int vL = 0;vL< 24;vL++) {
		sHeight =(int)(ihour[vL]*vPoint);
		k = k+1;
		avgcount  = avgcount + ihour[vL];
		avgheight = (int) ((avgcount/k)*vPoint);
                %>
                <td align=center width=15 height="120" nowrap><img src="/tea/image/other/bar3.gif"  style="background-color: #3775CA" width=15 height="<%=sHeight%>" title="<%=r.getString( teasession._nLanguage,"1216085236162" )+df.format(ihour[vL])%>" ><br>
                  <%=(vL)%></td>
                <%	}%>
                <td><%=r.getString(teasession._nLanguage,"1216027901518")%></td>
              </tr>
            </table></td>
        </tr>
      </table>




