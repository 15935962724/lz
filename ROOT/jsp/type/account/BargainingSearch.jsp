<%@page contentType="text/html;charset=UTF-8" %><%


String community=request.getParameter("community");
%>

<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<script type="text/javascript">
function td_calendar(fieldname)
{
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/tea/inc/calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
</script>
<style type="text/css">
<!--
body{margin:0;padding:10px;border:1px solid #ccc;}
img {border:0;}
-->
</style>
<form name="form1" method="post" action="">
  <TABLE border="0" cellPadding="0" cellSpacing="0"  id="tablecenter">
    <tr>
      <td>帐号</td>
      <td><input name="account" type="text" size="15">
      </td>
      <td>开始日期 </td>
      <td><input name="startdate" type="text" size="12">
        <a href="#" onClick="td_calendar('form1.startdate')"><img src="/tea/image/public/Calendar2.gif" ></a></td>
      <td>终止日期 </td>
      <td><input name="enddate" type="text" size="12">
        <a href="#" onClick="td_calendar('form1.enddate')"><img src="/tea/image/public/Calendar2.gif" ></a></td>
    </tr>
    <tr>
      <td>排序</td>
      <td><select name="order">
          <option value="[date]">日期</option>
          <option value="adopt">支出</option>
          <option value="memory">收入</option>
          <option value="balance">余额</option>
        </select>
      </td>
      <td><input type="submit" name="submit" value="查询"/></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table>
</form>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
    <td>账号</td>
    <td>日期</td>
    <td>支出</td>
    <td>收入</td>
    <td>余额</td>
    <td>说明</td>
  </tr>
  <%
  String account=request.getParameter("account");
  if(account!=null)
  {
      String startdate=request.getParameter("startdate");
      if(startdate.length()>0)
      startdate=" and [date]>"+tea.db.DbAdapter.cite(tea.htmlx.TimeSelection.makeTime(startdate));
      String enddate=request.getParameter("enddate");
      if(enddate.length()>0)
      enddate=" and [date]<"+tea.db.DbAdapter.cite(tea.htmlx.TimeSelection.makeTime(enddate));

      tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
      try
      {
        dbadapter.executeQuery("select [date],adopt,memory,balance,explain from Bargaining where account='"+account+"'"+enddate+startdate+" order by "+request.getParameter("order"));
        while(dbadapter.next())
        {
          %>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
            <td><%=account%>
              <td>
                <td><%=(new java.text.SimpleDateFormat("yyyy-MM-dd")).format(dbadapter.getDate(1))%></td>
                <td><%=dbadapter.getString(2)%></td>
                <td><%=dbadapter.getString(3)%></td>
                <td><%=dbadapter.getString(4)%></td>
                <td><%=(dbadapter.getString(5))%></td>
          </tr>
          <%}
          }finally
          {
            dbadapter.close();
          }
            %>
  <TR>
    <TD><input type="Button"  onclick=window.open("/servlet/BargainingSave?where=<%=org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("account="+tea.db.DbAdapter.cite(account)+startdate+enddate+" order by "+request.getParameter("order"), request.getCharacterEncoding())%>") value="保存" >
      <%  }%>
</table>

