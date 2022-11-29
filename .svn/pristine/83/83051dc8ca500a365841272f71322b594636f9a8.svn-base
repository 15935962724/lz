<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.util.*"%>
<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.eon.*"%>
<%@page import="tea.ui.TeaSession"%><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control", "no-cache");

TeaSession teasession=new TeaSession(request);

Resource r=new Resource();

int eonrecord=Integer.parseInt(request.getParameter("eonrecord"));
EonRecord er = EonRecord.find(eonrecord);

String member=er.getMember();
String tel=er.getCallTel();

Profile p=Profile.find(member);

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script type="">
function f_ajax()
{
  var re=document.getElementById("result");
  sendx("/servlet/EonRecords?act=result&eonrecord=<%=eonrecord%>",function f(d)
  {
    var info;
    switch(parseInt(d))
    {
      case 0:
      info="连接中....";
      break;
      case 1:
      info="通";
      break;
      case 2:
      info="无中继通道";
      break;
      case 3:
      info="无人接听";
      break;
      case 4:
      info="线忙";
      break;
      case 5:
      info="对方挂机";
      break;
      case 6:
      info="未知";
      break;
    }
    re.innerHTML=info;
  });
}
setInterval(f_ajax,1000);
</script>
</head>
<body>

<h1><%=r.getString(teasession._nLanguage, "拨打中")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=tel%></td>
    <td><img src="/tea/image/public/load2.gif"/></td>
    <td><%=p.getTelephone(teasession._nLanguage)%></td>
  </tr>
</table>

状态:<span id="result"></span>

<input type="button" value="关闭" onclick="window.close();">

</body>
</html>
