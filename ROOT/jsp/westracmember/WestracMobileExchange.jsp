<%@page import="tea.entity.integral.IntegralPrize"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.ui.TeaSession"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

int gid = 0;
if(teasession.getParameter("gid")!=null && teasession.getParameter("gid").length()>0)
{
	gid = Integer.parseInt(teasession.getParameter("gid"));	
}
String member = teasession.getParameter("member");
IntegralPrize ipobj = IntegralPrize.find(gid);

%><HTML>
<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
  <script>
 
  </script>
  </HEAD>

<body class="membercenter">

    <h2><span>手机在线兑换</span></h2>

      <form name="form1" method="POST" action="/jsp/westracmember/WestracMobileExchange2.jsp" onSubmit="return f_sub();">

       <input type="hidden" name="gid" value="<%=gid %>"/>

 	   <input type="hidden" name="member" value="<%=member %>"/>
       
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
         
          <td><img src="<%=ipobj.getSpic() %>"></td>
        </tr>
        <tr> 
         
          <td><%=ipobj.getShopping()%></td>
        </tr>
        <tr>
          <td  >商品编码：<%=ipobj.getCoding() %></td>
         
        </tr> 
       <tr>
          <td  >所需积分：<%=ipobj.getShop_integral() %>&nbsp;积分</td>
         
        </tr> 
      </table>
      <br>
<center>
        <input type=SUBMIT id="buttonid" value="立即兑换" >&nbsp;
      
</center>

      </form>


  </body>
</html>
