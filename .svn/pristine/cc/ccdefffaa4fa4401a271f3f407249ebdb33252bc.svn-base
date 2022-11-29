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
/*
if(request.getMethod().equals("POST"))
{
  int states=Integer.parseInt(request.getParameter("states"));
  String aim=request.getParameter("aim");
  int planyear=Integer.parseInt(request.getParameter("planyear"));
  java.math.BigDecimal outlay=new java.math.BigDecimal(request.getParameter("outlay"));
  String principal=request.getParameter("principal");
  String content=request.getParameter("content");

  Item obj=Item.find(item);
  obj.setInit(states,aim,content,planyear,outlay,principal);

  response.sendRedirect("/jsp/info/Succeed.jsp?nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));
  return;
}
*/

Resource r=new Resource();

String code=null,name=null,aim=null,content=null,principal=null;
int planyear=0;
java.math.BigDecimal outlay=null;

Item obj=Item.find(item);

content=obj.getContent();


%>
<!--
标准所高级管理员登陆系统后，能够看到状态为“下达编制组”项目，并对该项目分配“标准所管理员"。
-->
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function defaultfocus()
{
  form1.director.focus();
}


</script>
</head>
<body onLoad="defaultfocus();">

<h1>分配-<%=Item.ROLE_DIRECTOR%></h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form name="form1" action="/servlet/EditItem" method="post" onSubmit="return submitText(this.director, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-<%=Item.ROLE_DIRECTOR%>')">
<input type=hidden name="act" value="director"/>
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
         <td><%=Item.ROLE_DIRECTOR%></td>
         <td nowrap>
         <select name="director">
         <option value="">------------</option>
         <%
           int adminrole_id=tea.entity.admin.AdminRole.findByName(Item.ROLE_DIRECTOR,community);//"标准所管理员"
           java.util.Enumeration enumer=tea.entity.admin.AdminUsrRole.findByRole(adminrole_id);
           while(enumer.hasMoreElements())
           {
             String member=(String)enumer.nextElement();
             out.print("<option value="+member);
             if(member.equals(obj.getDirector()))
             out.print(" SELECTED ");
             out.print(" >"+member);
           }
         %>
         </select></td>
       </tr>
       <tr>
         <td>&nbsp;</td>
         <td nowrap>
           <input type="submit" name="Submit" value="提交">
           <input type="reset" name="Submit2" value="重置" onClick="defaultfocus();">
           <input type="button" value="返回" onClick="history.back();">
         </td>
       </tr>
  </table>
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


