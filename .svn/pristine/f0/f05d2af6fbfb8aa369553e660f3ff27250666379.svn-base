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
<title>骨科医生登录</title>
</head>
<body id="bodynone">
<script>
 function f_button()
 {

   if(form1.xingming.value=='')
   {
      alert('请填写姓名');
      form1.xingming.focus();
      return  false;
   }
   if(form1.zjhm.value=='')
   {
      alert('请填写有效证件');
      form1.zjhm.focus();
      return  false;
   }

   sendx("/jsp/admin/orthonline/city_ajax.jsp?community="+form1.community.value+"&act=parlog&xingming="+encodeURIComponent(form1.xingming.value)+"&zjhm="+encodeURIComponent(form1.zjhm.value),
   function(data)
   {
     if(data.trim().length>0)
     {
       alert(data);
     }else
     {
       window.returnValue='/'+form1.xingming.value+'/'+form1.zjhm.value+'/';
       window.close();
     }
   }
   );
 }

</script>
<h1>骨科医生登录</h1>
<div id="head6"><img height="6" src="about:blank"></div>
   <form action="?" name="form1"  method="POST"><!--/servlet/EditDoctor-->
   <input type="hidden" name="community" value="<%=community%>">
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td nowrap>姓名(以登记表上填写的姓名为准)：</td>
       <td nowrap><input type="text" name="xingming"> </td>
     </tr>
     <tr>
       <td nowrap>证件号码(以登记表上填写的有效证件号为准)</td>
       <td nowrap><input type="text" name="zjhm"> </td>
     </tr>
   </table>
   <br>
  <input type="button" value="骨科医生登录" onclick="f_button();" >
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
