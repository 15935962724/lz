<%@page contentType="text/html;charset=UTF-8"%><%@page import="tea.entity.node.access.*" %><%@page import="tea.db.*" %><%@page import="java.text.*" %><%@page import="tea.ui.*" %>

<%
TeaSession teasession=new TeaSession (request);
//int oldpv= 10809664 ;
//int oldip=8366701;

if (teasession.getParameter("act")!=null&&teasession.getParameter("act").equals("set"))
{
 int pv=Integer.parseInt(teasession.getParameter("pv"));
 int ip=Integer.parseInt(teasession.getParameter("ip"));
 NodeAccessLast.setOldAccess(teasession._strCommunity,pv,ip);
}

 
int oldpv= NodeAccessLast.countOldPv(teasession._strCommunity) ;
int oldip= NodeAccessLast.countOldIp(teasession._strCommunity) ;
%>

<html>
<head>
<title>旧统计数据</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<style type="text/css">
.gra{border:1px solid #666666;width:12px;height:12px}
</style>

<script type="">
  function check_num()
  {
  var pv=document.getElementById("pv").value;
  var ip=document.getElementById("ip").value;
   if (isNaN(pv))
   {alert("pv请输入数字");
    return false;
   }

  if (isNaN(ip))
   {alert("ip请输入数字");
    return false;
   }
  return  true;
  }
  </script>
</head>
<body>
<form name="form1" action="/jsp/count/setoldaccess.jsp" method="post" onsubmit="return check_num();">
<input type="hidden" name="act" value="set"/>
PV<input type="text" name="pv" value="<%=oldpv %>" size="20"/><br/>
IP<input  type="text" name="ip" value="<%=oldip %>" size="20"/><br/>
<input type="submit" value= "提交">
</form>

</body>

</html>