<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
if(request.getMethod().equals("POST"))
{
  tea.entity.member.SClient client_obj=tea.entity.member.SClient.find(node.getCommunity(),request.getParameter("client"));
  if(client_obj.isExists())
  {
    client_obj.setPrice(new java.math.BigDecimal(request.getParameter("price")));
    //response.sendRedirect(request.getRequestURI());
    response.sendRedirect("/jsp/user/EjMember.jsp?node="+teasession._nNode);
  }else
  {
    out.print(new tea.html.Script("alert('对不起,不存在');history.back();"));
  }
  return;
}
%><html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<LINK href="add_fund.files/mystyle.css" type=text/css rel=stylesheet>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "EditSClientPrice")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<script>
function fsubmit()
{
 if(isNaN( parseFloat(form1.price.value)))
 {
   alert('请正确输入.');
   form1.price.focus();
   return false;
 }else
 form1.price.value= parseFloat(form1.price.value);
 return true;
}
</script>
<form name="form1" method="post" action="" onsubmit="return fsubmit()">
<br><br>  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>客户</td>
    <td>
      <%
      tea.html.DropDown select=new tea.html.DropDown("client");
      java.util.Enumeration enumer=    tea.entity.member.SClient.find(node.getCommunity());
      while(enumer.hasMoreElements())
      {
        String fbt_node=enumer.nextElement().toString();
        select.addOption(fbt_node,fbt_node);
      }
      out.print(select.toString());
      %>
</td>
  </tr>
  <tr>
    <td>充值</td>
    <td><input type="text" name="price"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="Submit" value="提交"></td>
  </tr>
</table><br><br>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

