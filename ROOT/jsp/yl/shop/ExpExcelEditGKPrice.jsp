<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.sup.*"%>
<%@page import="tea.entity.yl.shop.ShopHospital"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}






%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/yl/jquery-1.7.js"></script>
<script src="/tea/yl/top.js"></script>
<!-- <script src="/tea/mt.js" type="text/javascript"></script>
<script src='/tea/jquery.js'></script> -->
</head>
<body >

<form id='form1' name="form1" action="/ShopHospitals.do" method="post"  enctype="multipart/form-data" onSubmit="return mt.check(this)">
<input name='nexturl' type="hidden" value="/jsp/yl/shop/ExpExcelGKPrice.jsp" />
<input name='act' type="hidden" value="uploadfile_gkprice" />
<table id="tablecenter">
	<tr><td >模板</td><td ><a href="/res/Excel/gkprice.xlsx">点击下载</a></td></tr>
	<tr><td>文件：</td><td><input name='execl' type="file" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.ms-excel" /></td></tr>
	<tr><td colspan="2">（请上传xls、xlsx格式文件）</td></tr>
	<tr><td colspan="2"><button class="btn btn-primary" type="submit" >提交</button></td></tr>
</table>
   
</form>

<script type="text/javascript">
</script>
</body>
</html>
