<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.cebbank.*" %>
<%@page import="tea.resource.*"%>
<%@page import="java.net.URLEncoder"%><%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

/////Annuity_8004.jsp/////////////////////////////////


TeaSession teasession=new TeaSession(request);

Resource r=new Resource("/tea/resource/Annuity");

String code=(String)session.getAttribute("code");

if(code==null)
{
	response.sendRedirect("/jsp/info/Alert.jsp?community="+teasession._strCommunity+"&info="+URLEncoder.encode(r.getString(teasession._nLanguage,"1186555649328"),"UTF-8")+"&nexturl=/servlet/Node%3FNode%3D"+teasession._nNode);
	return;
}
ArrayList atn=(ArrayList)session.getAttribute("annuity.trade_no");
if(atn==null||atn.indexOf("8004")==-1)
{
  response.sendError(403);
  return;
}

String alert=request.getParameter("alert");
if(alert!=null)
{
  out.print("<script>alert('"+alert+"');</script>");
}

%>
<jsp:include page="/jsp/admin/cebbank/AnnuityFrame.jsp" >
<jsp:param name="frame" value="mainheader"/>
</jsp:include>


<div id="new"></div><div style="width:100%;overflow: auto;"><div id="neirong">



<!-- target="password_info"  &&f_open()-->
<form name="form1" action="/servlet/EditAnnuity" method="post" onsubmit="return submitText(this.psword1,'无效-原密码')&&submitText(this.psword2,'无效-新密码')&&submitLength(6,16,this.psword2,'密码长度,在6-16之间.')&&submitEqual(this.psword2,this.psword3,'新密码 和 确认新密码 不相同');">
<input type=hidden name=community value="<%=teasession._strCommunity%>">
<input type=hidden name=trade_no value="<%=Annuity.encode("8004")%>">
<input type=hidden name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>">

<div id="neibiao"><span id="biaol"></span><span id="neibiaozi"><%=r.getString(teasession._nLanguage,"1186539091609")%></span><span id="biaor"></span></div>
<table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse">
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186538899578")%>：</td>
    <td ><input class="biaodan" type="password" name="psword1"/></td>
  </tr>
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186538940093")%>：</td>
    <td ><input class="biaodan" type="password" name="psword2"/></td>
  </tr>
  <tr>
    <td class="zuoge"><%=r.getString(teasession._nLanguage,"1186539013625")%>：</td>
    <td ><input class="biaodan" type="password" name="psword3"/></td>
  </tr>
</table>
<input class="bdanniu" type="submit" value="<%=r.getString(teasession._nLanguage,"1186542726218")%>"/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input class="bdanniu" type="button" value="<%=r.getString(teasession._nLanguage,"1186542790281")%>" onclick="clearFrom(form1);"/>

</form>




</div>

<jsp:include page="/jsp/admin/cebbank/AnnuityFrame.jsp" >
<jsp:param name="frame" value="mainfooter"/>
</jsp:include>

</div>





