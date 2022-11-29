<%@page contentType="text/html;charset=UTF-8" %>
<%@page  import="tea.entity.contract.*" %>
<%@include file="/jsp/Header.jsp"%>
<%
  request.setCharacterEncoding("UTF-8");

  TeaSession teasession = new TeaSession(request);
  String id=null;
  String itemid=null;
  if(teasession.getParameter("itemid")!=null&&teasession.getParameter("itemid").length()>0){
  itemid=teasession.getParameter("itemid");
  }
  Iteminfo obj=Iteminfo.find(itemid);
  String itemtype=obj.getItemtype();
  if(itemid==null){
    id="insert";
  }
%>
<script type="text/javascript">


function dosubmit()
{

 var itemtype = document.getElementById("itemtype").value
  if(itemtype ==""){
	 alert("类型名不能为空");
         form1.itemtype.focus();
         return false;
	}
}

</script>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<title>

</title>
</head>
<body>
<form action="/servlet/editItemInfo" name="form1" method="POST" onSubmit="return dosubmit();">

<h1>创建类型</h1>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td>类型:</td>
<td><input type="text" name="itemtype"  value="<%if(itemtype!=null)out.println(itemtype);%>"/>
  <input  type="hidden" name="itemid" value="<%=obj.getItemid()%>"/>
 <input  type="hidden" name="id" value="<%=id%>"/></td>
</tr>
<tr>
<td><input type="submit" value="提交"/></td>
</tr>
</table>
</form>

</body>
</html>
