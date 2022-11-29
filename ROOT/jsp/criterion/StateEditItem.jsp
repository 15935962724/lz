<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.Item" %><%@ page import="tea.ui.TeaSession" %><%request.setCharacterEncoding("UTF-8");
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
  int states=Integer.parseInt(request.getParameter("states"));

  boolean defer=new Boolean(request.getParameter("defer")).booleanValue();

  Item obj=Item.find(item);
  obj.set(states,defer);

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
  form1.states.focus();
}



</script>
</head>
<body onLoad="defaultfocus();">

<h1>修改项目状态</h1>
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
         <td>项目状态</td>
         <td nowrap><select name="states">
         <%
         for(int index=1;index<Item.STATES_TYPE.length;index++)
         {
           out.print("<option value="+index);
           if(obj.getStates()==index)
           out.print(" SELECTED ");
           out.println(">"+Item.STATES_TYPE[index]);
         }
         %>
           </select>         </td>
       </tr>

	        <tr><td>是否延迟</td>
              <TD>
                <input name="defer" type="radio" value="false" id="defer0" checked><label for="defer0">否</label>
                  <input type="radio" name="defer" value="true" id="defer1" <%if(obj.isDefer())out.print(" checked ");%>><label for="defer1">是</label></TD>
	        </tr>
       <tr>
         <td>&nbsp;</td>
         <td nowrap>
           <input type="submit"  value="提交" onClick="return confirm('确认修改状态?');">
           <input type="reset"  value="重置" onClick="defaultfocus();">
           <input type="button" value="返回" onClick="history.back();">
         </td>
       </tr>
  </table>
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

