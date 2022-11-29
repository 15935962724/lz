<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.admin.express.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}


String _strId=request.getParameter("id");

String scrbid=request.getParameter("scrbid");
String classno=request.getParameter("classno");
String swname=request.getParameter("swname");
String author=request.getParameter("author");

StringBuffer param = new StringBuffer();
param.append("&community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);

StringBuffer sql = new StringBuffer();
if (scrbid != null && (scrbid = scrbid.trim()).length() > 0)
{
	sql.append(" AND scrbid LIKE ").append(DbAdapter.cite("%"+scrbid+"%"));
	param.append("&scrbid=").append(java.net.URLEncoder.encode(scrbid,"UTF-8"));
}
if (classno != null && (classno = classno.trim()).length() > 0)
{
	sql.append(" AND classno LIKE ").append(DbAdapter.cite("%"+classno+"%"));
	param.append("&classno=").append(java.net.URLEncoder.encode(classno,"UTF-8"));
}
if (swname != null && (swname = swname.trim()).length() > 0)
{
	sql.append(" AND swname LIKE ").append(DbAdapter.cite("%"+swname+"%"));
	param.append("&swname=").append(java.net.URLEncoder.encode(swname,"UTF-8"));
}
if (author != null && (author = author.trim()).length() > 0)
{
	sql.append(" AND author LIKE ").append(DbAdapter.cite("%"+author+"%"));
	param.append("&author=").append(java.net.URLEncoder.encode(author,"UTF-8"));
}

String order=request.getParameter("order");
if(order==null)
order="crbookin";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc=").append(desc);

sql.append(" ORDER BY ").append(order).append(" ").append(desc);

int pos=0;
String _strPos=request.getParameter("pos");
if(_strPos!=null)
{
	pos=Integer.parseInt(_strPos);
}
param.append("&pos=");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>配送价格表</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" action="/servlet/EditExpress">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="act" value="editexpresspricezjs">
<script>document.write("<input type=hidden name=nexturl value="+document.location+">");</script>
<input type="hidden" name="expresspricezjs" value="0">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>单票重量:</td><td><input name="wfrom" type="text" size="10" onKeyPress="if(event.keyCode!=46&&event.keyCode<48||event.keyCode>57)event.returnValue=false;">-<input name="wto" type="text" size="10" onKeyPress="if(event.keyCode!=46&&event.keyCode<48||event.keyCode>57)event.returnValue=false;"> Kg</td></tr>
<tr><td>省内城市:</td><td><input name="province" type="text" onKeyPress="if(event.keyCode!=46&&event.keyCode<48||event.keyCode>57)event.returnValue=false;"></td></tr>
<tr><td>省会城市:</td><td><input name="capital" type="text" onKeyPress="if(event.keyCode!=46&&event.keyCode<48||event.keyCode>57)event.returnValue=false;"></td></tr>
<tr><td>中转城市:</td><td><input name="interim" type="text" onKeyPress="if(event.keyCode!=46&&event.keyCode<48||event.keyCode>57)event.returnValue=false;"></td></tr>
</table>
<input type="submit" value="提交" onclick="return submitFloat(form1.wfrom,'单票重量')&&submitFloat(form1.wto,'单票重量')&&submitFloat(form1.province,'省内城市')&&submitFloat(form1.capital,'省会城市')&&submitFloat(form1.interim,'中转城市');"><input type="reset" value="重置">


   <h2>列表</h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
	     <td width="1"></td>
         <td>单票重量</td>
         <td>省内城市24小时</td>
         <td>省会(地市）城市48-72小时</td>
         <td>中转城市3-4天</td>
         <td>&nbsp;</td>
       </tr>
<%
java.util.Enumeration enumer=ExpressPricezjs.find(teasession._strCommunity);
for(int index=1;enumer.hasMoreElements();index++)
{
  int id=((Integer)enumer.nextElement()).intValue();
  ExpressPricezjs obj=ExpressPricezjs.find(id);
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=index%></td>
    <td>&nbsp;<%=obj.getWfrom()%> - <%=obj.getWto()%></td>
    <td>&nbsp;<%=obj.getProvince()%></td>
    <td>&nbsp;<%=obj.getCapital()%></td>
    <td>&nbsp;<%=obj.getInterim()%></td>
    <td><input type=button value=编辑 onClick="form1.act.value='editexpresspricezjs'; form1.expresspricezjs.value='<%=id%>'; form1.wfrom.value='<%=obj.getWfrom()%>'; form1.wto.value='<%=obj.getWto()%>'; form1.province.value='<%=obj.getProvince()%>'; form1.capital.value='<%=obj.getCapital()%>'; form1.interim.value='<%=obj.getInterim()%>'; form1.wfrom.focus();" >
        <input type=button value=删除 onClick="if(confirm('确定删除吗？')){ form1.act.value='deleteexpresspricezjs'; form1.expresspricezjs.value='<%=id%>'; form1.submit(); this.disabled=true; }" ></td>
 </tr>
<%
}
%>
</table>

</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


