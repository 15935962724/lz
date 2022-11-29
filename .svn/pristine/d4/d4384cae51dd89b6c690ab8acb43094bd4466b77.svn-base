<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"  %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.Item" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

if(!"webmaster".equals(teasession._rv.toString()))
{
  response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("你无权,清空数据库.", "UTF-8"));
  return;
}

String community=request.getParameter("community");
String nexturl=request.getParameter("nexturl");
if(nexturl==null)
nexturl=request.getRequestURI()+"?"+request.getQueryString();

Resource r=new Resource();

%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<body onLoad="">

<h1>清空数据库</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form name="form1" action="/servlet/EditItem" method="post" onSubmit="return confirm('你真想清空数据库吗?')&&confirm('请你再次确定,你真想清空数据库吗?')&&confirm('请你再再次确定,你真想清空数据库吗? ^_^');">
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<input type=hidden name="act" value="ItemClear"/>
<input type=hidden name="item" value="0"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <TD><input name="Item" type="checkbox" value="Item" checked>
    项目</TD>
  </tr>
  <tr>
    <td><input name="ItemBudget" type="checkbox" value="ItemBudget" checked>
    项目预算</TD>
  </tr>
  <tr>
    <td><input name="Itemfilehistory" type="checkbox" disabled value="Itemfilehistory" checked>
    项目历史文件</TD>
  </tr>
  <tr>
    <td><input name="Itemoutlay" type="checkbox" value="Itemoutlay" checked>
    项目津费
    </TD>
  </tr>
  <tr>
    <td><input name="Outlay" type="checkbox" value="Outlay" checked>
    津费

</TD>
     </tr>
     <tr>
       <td><input  name="checkbox" type="checkbox" disabled="disabled" value="Egqb" checked>
       季报入库

</TD>
     </tr>
     <tr>
       <td><input  name="checkbox" type="checkbox" disabled="disabled" value="Expertres" checked>
       专家资源

</TD>
     </tr>
     <tr>
       <td><input name="checkbox" type="checkbox" disabled="disabled" value="Referenceres" checked>
       参考文献
</TD>
     </tr>
	 <tr>
       <td><input name="checkbox" type="checkbox" disabled="disabled" value="Unitres" checked>
       编制单位资源

	   </TD>
     </tr>
       <tr>
         <td nowrap>
           <input type="submit"  value="提交" onClick="">
           <input type="reset" value="重置" onClick="defaultfocus();"></td>
       </tr>
  </table>
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>

</body>
</html>

