<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%!
final String BROKAGE_STATES[]={"开通试用","正式开通","未开通"};
%>
<%
if (!tea.entity.site.License.getInstance().getWebMaster().equals(teasession._rv._strR))
{
  response.sendError(403);
  return;
}
String member=request.getParameter("member");
tea.entity.site.YellowPage yp=tea.entity.site.YellowPage.find(member);
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function ShowCalendar(fieldname)
{
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/jsp/include/Calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
function fclick()
{
  if(  form1.states[0].checked)
  {
    form1.bnexttime.disabled=true;
    form1.btime.disabled=true;
    form1.price.disabled=true;
  }else
  {
    form1.bnexttime.disabled=false;
    form1.btime.disabled=false;
    form1.price.disabled=false;
  }
}
</script>
</head>
<body>
<DIV ID="edit_BodyDiv">

  <form name="form1" method="post" action="/servlet/EditYellowPage" onsubmit="return submitText(this.domain[0],'无效域名')&&submitEqual(this.mailpw,this.confirmpassword,'Mail的密码不相等')">
    <input name="member" type="hidden" value="<%=new String(member.getBytes("ISO-8859-1"))%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td rowspan="5" nowrap>我的网站        </TD>
        <td colspan="4" align="left" nowrap><input name="domain" type="text" value="<%=getNull(yp.getDomain()[0])%>" size="50"></td>
      <tr>
        <td> <input name="domain" type="text" value="<%=getNull(yp.getDomain()[1])%>" size="50"></td>
      </tr>
	        <tr>
        <td> <input name="domain" type="text" value="<%=getNull(yp.getDomain()[2])%>" size="50"></td>
      </tr>
	        <tr>
        <td> <input name="domain" type="text" value="<%=getNull(yp.getDomain()[3])%>" size="50"></td>
      </tr>
	        <tr>
        <td> <input name="domain" type="text" value="<%=getNull(yp.getDomain()[4])%>" size="50"></td>
      </tr>
      <tr>
        <td nowrap>开通现状</TD>
        <td colspan="4" nowrap><input name="states" onclick="fclick()"  id="radio" type="radio" value="0" checked>
          开通试用
          <input name="states"  id="radio" type="radio" onclick="fclick()"  value="1" <%if(yp.getStates()==1)out.print(" checked ");%>>
          交费,日期
          <input name="time" type="text" readonly="readonly" size="9" value="<%=yp.getTime("yyyy-MM-dd")%>">
          <input type="button"  name="btime" value="..." onclick="ShowCalendar('form1.time')">
          金额:￥
          <input name="price" type="text"  size="5" value="<%=getNull(yp.getPrice())%>">
          下次交费日期
          <input name="nexttime" type="text" readonly="readonly" size="9" value="<%=yp.getNextTime("yyyy-MM-dd")%>">
          <input type="button" name="bnexttime"  value="..." onclick="ShowCalendar('form1.nexttime')"></td>
      </tr>
      <tr>
        <td nowrap>E-Mail</TD>
        <td colspan="4" align="left" nowrap>ID
          <input type="text" name="mailid" value="<%=getNull(yp.getMailid())%>">
          密码
          <input type="password" name="mailpw" value="<%=getNull(yp.getMailpw())%>">
          确认密码
          <input type="password" name="confirmpassword" value="<%=getNull(yp.getMailpw())%>"></td>
      </tr>
      <tr ID=tableonetr >
        <td rowspan="300" nowrap>代理客户</TD>
        <td  nowrap>客户名称</TD>
        <td   nowrap>缴费</TD>
        <td nowrap>开通状况</TD>
        <td  nowrap>应收代理费</TD>
        <td   nowrap>日期
        <td   nowrap>操作
      </tr>
      <tr>
        <td nowrap><input type="text" name="brokage" value=""></td>
        <td nowrap>￥
          <input name="brokage_pay" type="text" value="" size="9"></td>
        <td nowrap><select name="brokage_states">
            <%
          for(int index=0;index<BROKAGE_STATES.length;index++)
{          %>
            <option value="<%=index%>"><%=BROKAGE_STATES[index]%></option>
            <%}%>
          </select></td>
        <td nowrap>￥
          <input name="brokage_price" type="text" size="9"></td>
        <td nowrap></td>
        <td nowrap></td>
      </tr>
      <%
java.util.Enumeration enumer=  tea.entity.site.YellowPageBrokage.findByMember(member);
while(enumer.hasMoreElements())
{
String memberx=(String)enumer.nextElement();
tea.entity.site.YellowPageBrokage ypb_temp=tea.entity.site.YellowPageBrokage.find(member,memberx);

%>
     <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td nowrap><%=memberx%></td>
        <td nowrap>￥<%=getNull(ypb_temp.getPay())%></td>
        <td nowrap><%=BROKAGE_STATES[ypb_temp.getStates()]%></td>
        <td nowrap>￥<%=getNull(ypb_temp.getPrice())%></td>
        <td nowrap><%=ypb_temp.getTime("yyyy-MM-dd")%></td>
        <td nowrap><input type="button" name="Submit" onclick="form1.brokage.value='<%=memberx%>';form1.brokage_pay.value='<%=getNull(ypb_temp.getPay())%>';form1.brokage_states.selectedIndex=<%=ypb_temp.getStates()%>;form1.brokage_price.value='<%=getNull(ypb_temp.getPrice())%>'" value="编辑">
          <input type="button" name="Submit" value="删除" onclick="if(confirm('确认删除')){window.open('/servlet/EditYellowPage?member=<%=member%>&brokage=<%=memberx%>&act=del', '_self');}"></td>
      </tr>
      <%}%>
    </table>
    <input type="submit" name="Submit" value="提交">
    <input type="reset" name="Submit" value="重置">
  </form>
  <div id="language"><%=new Languages(teasession._nLanguage, request)%></div>
</DIV>
<script type="">
fclick();
form1.domain[0].focus();
</script>
</body>
</html>

