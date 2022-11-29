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
<h1><%=r.getString(teasession._nLanguage, "Custom")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
<form name="form1" method="post" action="/servlet/EditYellowPage" onsubmit="return submitText(this.domain,'无效域名')&&submitEqual(this.mailpw,this.confirmpassword,'Mail的密码不相等')">
<input name="member" type="hidden" value="<%=member%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td nowrap>我的网站</TD>
    <td colspan="4" align="left" nowrap>
      <%
      boolean exist=false;
      for(int index=0;index<yp.getDomain().length;index++)
      {
        if(yp.getDomain()[index]!=null&&yp.getDomain()[index].length()>0)
        {exist=true;
        %>
        <A href="<%=yp.getDomain()[index]%>"><%=yp.getDomain()[index]%></A><br/>
        <%}
      }
      %></td>
  </tr>
  <tr>
    <td nowrap>开通现状</TD>
    <td colspan="4" nowrap>
      <%if(yp.getStates()==0){%>
      开通试用
<%}else if(yp.getStates()==1){
        /*  if(System.currentTimeMillis() - yp.getNextTime().getTime() >0)
        {
          out.print("未开通");
        }else
        out.print("运行中");*/
  %>

      交费日期<%=yp.getTime("yyyy-MM-dd")%>
      金额:<%=getNull(yp.getPrice())%>
      下次交费日期<%=yp.getNextTime("yyyy-MM-dd")%>
<%}%></td>
  </tr>
</table>
<%
if(!exist)
{

%>
<script type="">
document.all('section').style.display='none';
</script>
  <table>
    <tr><td>您的网站未开通,请和我们联系,开通试用</td>
    </tr>
  </table>
<%}%>

<div id="language"><%=new Languages(teasession._nLanguage, request)%></div>

</body>
</html>

