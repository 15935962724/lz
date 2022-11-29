<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;
String nexturl=request.getParameter("nexturl");


Resource r=new Resource();

String name=null,content=null;
int flow=-1;

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function defaultfocus()
{
  form1.name.focus();
}

function f_submit()
{
	  var param="/jsp/admin/flow/QueryResults.jsp?";
	  var el=form1.elements;
	  for(var i=0;i<el.length;i++)
      {
        if(el[i].name.length>0&&el[i].value.length>0)
		  param=param+"&"+el[i].name+"="+encodeURIComponent(el[i].value);
      }
      window.opener.location=param;
      window.close();
      return false;
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>请输入你曾参加过的工作事务名称</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<BR>
<form name="form1" method="post" onSubmit="return f_submit();">
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="act" value="queryflowbusiness"/>
     
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
        <td>工作事务名称</td>
         <td nowrap><input name="name" type="text" value="<%if(name!=null)out.print(name);%>" size="40"></td>
       </tr>
       <tr>
        <td>工作事务说明</td>
         <td nowrap><textarea name="content" rows="5" cols="40" ><%if(content!=null)out.print(content);%></textarea></td>
       </tr>
  </table>
   <input type="submit" value="提交">
  <input type="reset" value="重置" onClick="defaultfocus();">
    <input type="button" value="关闭" onClick="window.close();">
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</HTML>


