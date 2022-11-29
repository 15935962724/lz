<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
String member=teasession._rv._strR;
tea.entity.site.YellowPage yp=tea.entity.site.YellowPage.find(member);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>有标题文档</title>
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
<h1><%=r.getString(teasession._nLanguage, "MemberBrokage")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" method="post" action="/servlet/EditYellowPage" onsubmit="return submitText(this.domain,'无效域名')&&submitEqual(this.mailpw,this.confirmpassword,'Mail的密码不相等')">
<input name="member" type="hidden" value="<%=member%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td nowrap>客户名称</TD>
    <td nowrap>缴费</TD>
    <td nowrap>开通状况</TD>
    <td nowrap>应收代理费</TD>
    <td nowrap>日期
  </tr>
  <%
java.util.Enumeration enumer=  tea.entity.site.YellowPageBrokage.findByMember(member);
while(enumer.hasMoreElements())
{
String memberx=(String)enumer.nextElement();
tea.entity.site.YellowPage yp_temp=tea.entity.site.YellowPage.find(memberx);
tea.entity.site.YellowPageBrokage ypb_temp=tea.entity.site.YellowPageBrokage.find(member,memberx);
%>
<tr>
  <td nowrap><%=new String(memberx.getBytes("ISO-8859-1"))%></td>
    <td nowrap><%=getNull(yp_temp.getPrice())%></td>
      <td nowrap><%
      if(yp_temp.getStates()!=0)
      {
        if(System.currentTimeMillis() - yp_temp.getNextTime().getTime() >0)
        {
          out.print("未开通");
        }else
        out.print("运行中");
      }else
      out.print("试用期中");%></td>
      <td nowrap><%=getNull(ypb_temp.getPrice())%></td>
        <td nowrap><%=ypb_temp.getTime("yyyy-MM-dd")%></td>
        </tr>
<%}%>
</table>
</form>  
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

