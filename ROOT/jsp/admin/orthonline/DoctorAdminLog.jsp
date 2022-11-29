<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.orthonline.*"%>
<%@page import="java.util.Date"%>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);

String community = teasession.getParameter("community");
%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>骨科医生管理员登录</title>
</head>
<body id="bodynone">
<script>
 function f_button()
 {
   if(form1.member.value=='')
   {
      alert('请填写用户名');
      form1.member.focus();
      return  false;
   }
   if(form1.paw.value=='')
   {
      alert('请填写密码');
      form1.paw.focus();
      return  false;
   }
   sendx("/jsp/admin/orthonline/city_ajax.jsp?community="+form1.community.value+"&act=memberlog&member="+form1.member.value+"&paw="+form1.paw.value,
   function(data)
   {
     if(data.trim().length>0)
     {
       alert(data);
      // form1.youxiaozhengjianhao.focus();
     //  form1.submitx.disabled=true;
      // return false;
     }else
     {
       window.returnValue='1';
       window.close();
     }
   }
   );
 }

</script>
<h1>骨科医生管理员登录</h1>
<div id="head6"><img height="6" src="about:blank"></div>
   <form action="?" name="form1"  method="POST"><!--/servlet/EditDoctor-->
   <input type="hidden" name="community" value="<%=community%>">
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td nowrap>用户名：</td>
       <td nowrap><input type="text" name="member"> </td>
     </tr>
     <tr>
       <td nowrap>密码</td>
       <td nowrap><input type="password" name="paw"> </td>
     </tr>
   </table>
   <br>
  <input type="button" value="管理员登录" onclick="f_button();" >
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
