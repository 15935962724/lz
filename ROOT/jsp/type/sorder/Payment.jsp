<%@page contentType="text/html;charset=UTF-8" %><%@include file="/jsp/Header.jsp"%>
<%
String community=request.getParameter("community");
if(community==null)
community=node.getCommunity();





tea.entity.node.SOrder so=tea.entity.node.SOrder.find(teasession._nNode,teasession._nLanguage);

String member=request.getParameter("member");

if(request.getMethod().equals("POST"))
{
  try
  {
    tea.entity.member.SClient sc=tea.entity.member.SClient.find(community,member);
    int ptype=Integer.parseInt(request.getParameter("ptype"));
    if(ptype==1)
    {
      System.out.println(sc.getPrice());
      if(sc.getPrice().compareTo(so.getTotal())>=0)
      {
        System.out.println(new java.math.BigDecimal("-1").multiply(so.getTotal()));
        System.out.println(sc.getPrice().add(new java.math.BigDecimal("-1").multiply(so.getTotal())));
        sc.setPrice(new java.math.BigDecimal("-1").multiply(so.getTotal()));
      }else
      {
        response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("对不起,易洁卡中余额不足,请充值,或更换<a href=\"javascript:history.back();\" >支付方式</A>","UTF-8"));
        return;
      }
    }
    node.finished(teasession._nNode);
    so.setPtype(ptype);
    tea.ui.node.type.sorder.EditSOrder.sendMail(community,teasession._nNode,teasession._nLanguage,member,0);

    String nexturl=request.getParameter("nexturl");
    if(nexturl==null)
    nexturl="/servlet/SOrder?node=" + teasession._nNode;
    response.sendRedirect(nexturl);
    return;
  }catch(Exception ex)
  {
    ex.printStackTrace();
  }
}
%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function flen(obj,text)
{
  if(obj.value<1||obj.value>1000)
  {
    alert(text);
    obj.focus();
    return false;
  }
  return true;
}
</script>
</head>

<body>

<div id="head6"><img height="6" alt=""></div>
<form name="form1" method="post" action="<%=request.getRequestURI()%>" onSubmit="this.submit.disabled=true;return true;">
<%
String nexturl=request.getParameter("nexturl");
if(nexturl!=null&&nexturl.length()>5)
out.print("<input type=hidden name=nexturl value="+nexturl+" >");
%>
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="member" value="<%=member%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

<tr><td>会员</td><td><%=member%></td></tr>

<tr><td>余额</td><td><%=tea.entity.member.SClient.find(community,member).getPrice()%></td></tr>

<tr><td>金额</td><td><%=so.getTotal()%></td></tr>

<tr><td colspan="2"><input name="ptype" type="radio" value="1" checked>易洁卡</td></tr>

<tr><td colspan="2"><input name="ptype" type="radio" value="2">现场支付</td></tr>

</table>
<input  type="submit" name="submit" value="提交" onClick="">
</form>

<div id="head6"><img height="6" alt=""></div>
</body>
</html>

