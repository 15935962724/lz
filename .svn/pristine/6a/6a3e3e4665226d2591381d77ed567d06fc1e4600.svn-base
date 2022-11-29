<%@page contentType="text/html;charset=UTF-8"  %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body scroll="no" style="padding:0px; margin:0px; border:none;background-color=transparent"><table width="325" border="0" cellpadding="0" cellspacing="0" bgcolor="#D3D4B6" style="font-size: 9pt;color: #635531">
  <tr>
    <td scope="row">
<FORM name="form1" method="POST">
<SELECT name="year">
<%request.setCharacterEncoding("UTF-8");
  java.util.Calendar calendar = java.util.Calendar.getInstance();
  int year = calendar.get(1);
  int yearvalue=year;
  int month=1,week=1;
    if (request.getMethod().equals("POST")) {
      yearvalue=Integer.parseInt(request.getParameter("year"));
      month=Integer.parseInt(request.getParameter("month"));
      week=Integer.parseInt(request.getParameter("week"));
  }
  for (int index = 2003; index <= year; index++) {
%>
  <OPTION<%if(yearvalue==index)out.print(" selected ");%>><%=index%>  </OPTION>
<%}%>
</SELECT>
年
<SELECT name="month">
<%for (int index = 1; index <= 12; index++) {%>
  <OPTION<%if(index==month)out.print(" selected ");%>><%=index%>  </OPTION>
<%}%>
</SELECT>
月
<SELECT name="week">
  <OPTION>1</OPTION>
  <OPTION<%if(2==week)out.print(" selected ");%>>2</OPTION>
  <OPTION<%if(3==week)out.print(" selected ");%>>3</OPTION>
  <OPTION<%if(4==week)out.print(" selected ");%>>4</OPTION>
</SELECT>
周
<input type="submit">
</FORM></td>
  </tr>
  <tr>
    <td scope="row">
      <div align="center">
        <%
  if (request.getMethod().equals("POST")) {
    tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
    java.util.Enumeration poll_enumer=    tea.entity.node.Poll.findByNode(teasession._nNode, teasession._nLanguage);
    while(poll_enumer.hasMoreElements())
    {
      int poll_id=((Integer)poll_enumer.nextElement()).intValue();

      tea.entity.node.Poll poll = tea.entity.node.Poll.find(poll_id);
      calendar.set(1,yearvalue);
      calendar.set(2,month-1);
      int weekvalue;
      if(week>1)
      weekvalue=(week-1)*7+1;
      else
      weekvalue=week;
      calendar.set(5,weekvalue);
      java.text.SimpleDateFormat df=new java.text.SimpleDateFormat("yyyy-MM-dd");
      String start=df.format(calendar.getTime());
      if(week<4)
      weekvalue=(week)*7+1;
      else
      {
        calendar.set(2,month);
        weekvalue=1;
      }
      calendar.set(5,weekvalue);
      String stop=df.format(calendar.getTime());
      String sql=" AND CONVERT(varchar(10),time,120)>='"+start+"' AND CONVERT(varchar(10),time,120)<'"+stop+"'";
      calendar.set(5,week*7);%>
      <%=start%> 至 <%=stop%>
      </div>
      <br></td>
  </tr>
  <tr>
    <td width="100%"><table width="100%"  border="0" cellpadding="4" cellspacing="0"  class="huod" style="font-size: 9pt;color: #635531">
      <tr>
        <%
        java.util.Enumeration enumer = tea.entity.node.PollChoice.find(poll_id, poll.getTop(), sql);
        int id;int sum=0;
        while (enumer.hasMoreElements()) {

          id = ((Integer) enumer.nextElement()).intValue();
          tea.entity.node.PollChoice pc = new tea.entity.node.PollChoice(id);
          if(sum%2==0){
            %>
        <tr><%}%><td width="25%" align="right" ID="PollIDMonthChoice"><div align="left"><%=pc.getChoice()%></div></td> <td width="25%" id="PollIDMonthRequest"><div style="width:<%=tea.entity.node.PollResult.getResult(teasession._nNode, teasession._nLanguage, id, sql, true)%>%; background-image: url(<%=poll.getPicture()%>);"></div></td>
              <%sum++;}}
              }
        %>
    </table></td></tr>
</table>

  <div id="head6"><img height="6" src="about:blank"></div>

</body>

