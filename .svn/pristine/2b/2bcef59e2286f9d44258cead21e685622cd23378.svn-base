<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" import="tea.resource.Resource" %><%@ page import="tea.entity.Entity" %><%@ page import="tea.entity.criterion.Item" %><%@ page import="tea.ui.TeaSession" %><%request.setCharacterEncoding("UTF-8");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");
String nexturl=request.getParameter("nexturl");

int item=Integer.parseInt(request.getParameter("item"));
if(request.getMethod().equals("POST"))
{
  int states=8;//Integer.parseInt(request.getParameter("states"));
  String number=request.getParameter("number");
  java.util.Date granttime=Entity.sdf.parse(request.getParameter("granttimeYear")+"-"+request.getParameter("granttimeMonth")+"-"+request.getParameter("granttimeDay"));
  java.util.Date issuetime=Entity.sdf.parse(request.getParameter("issuetimeYear")+"-"+request.getParameter("issuetimeMonth")+"-"+request.getParameter("issuetimeDay"));
  java.util.Date actualizetime=Entity.sdf.parse(request.getParameter("actualizetimeYear")+"-"+request.getParameter("actualizetimeMonth")+"-"+request.getParameter("actualizetimeDay"));
  boolean nonce=new Boolean(request.getParameter("nonce")).booleanValue();

  Item obj=Item.find(item);
  obj.set(states,number,granttime,issuetime,actualizetime,nonce);

  response.sendRedirect("/jsp/info/Succeed.jsp?nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));
  return;
}


Resource r=new Resource();


Item obj=Item.find(item);



%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function defaultfocus()
{
  form1.number.focus();
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>标准发布</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form name="form1" action="" method="post" onSubmit="">
<input type=hidden name="item" value="<%=item%>"/>
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr><td>项目计划号</td>
         <TD><%=obj.getCode()%></TD>
</tr>
       <tr>

        <td>项目名称</td>
         <td nowrap><%=obj.getName()%></td>
       </tr>
       <tr>
         <td>标准编号</td>
         <td nowrap><input name="number" type="text" id="number" value="<%if(obj.getNumber()!=null)out.print(obj.getNumber());%>"></td>
       </tr>
	   <tr>
        <td>批准时间</td>
         <td nowrap><%=new tea.htmlx.TimeSelection("granttime",obj.getGranttime())%></td>
	   </tr>
	   	   <tr>
        <td>发布时间</td>
         <td nowrap><%=new tea.htmlx.TimeSelection("issuetime", obj.getIssuetime())%></td>
	   </tr>
	   	   	   <tr>
        <td>实施时间</td>
         <td nowrap><%=new tea.htmlx.TimeSelection("actualizetime",obj.getActualizetime())%></td>
	   </tr>
	        <tr>
	          <td>是否现行标准</td>
              <TD>
                <input type="radio" name="nonce" value="true" id="defer1" checked><label for="defer1">是</label>
                <input name="nonce" type="radio" value="false" id="defer0" <%if(!obj.isNonce())out.print(" checked ");%>><label for="defer0">否</label>
                </TD>
	        </tr>
       <tr>
         <td>&nbsp;</td>
         <td nowrap>
           <input type="submit"  value="提交">
           <input type="reset"  value="重置" onClick="defaultfocus();">
           <input type="button" value="返回" onClick="history.back();"/>
         </td>
       </tr>
  </table>
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

