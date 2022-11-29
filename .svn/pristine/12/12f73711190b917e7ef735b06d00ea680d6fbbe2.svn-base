<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.admin.sales.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.net.URLEncoder" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
//////////////////////任务委托/////////////////////////////////

String community=teasession.getParameter("community");
String nexturl=teasession.getParameter("nexturl");
int taid=Integer.parseInt(request.getParameter("taid"));

Task obj=Task.find(taid);
int flowitem=obj.getFlowitem();

Flowitem fi=Flowitem.find(flowitem);
if(!fi.isExists())
{
	response.sendRedirect("/jsp/info/Alert.jsp?info="+URLEncoder.encode("项目不存在.","UTF-8"));
	return;
}
String member=fi.getMember();
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<SCRIPT language="JavaScript">
function f_submit()
{
  var op=form1.consign1.options;
  if(op.length==0)
  {
  	alert('无效-委托代办人');
  	form1.consign1.focus();
  	return false;
  }
  
  var str="/";
  for(var i=0;i<op.length;i++)
  {
    str=str+op[i].value+"/";
  }
  form1.consign.value=str;
}
</SCRIPT>
</head>
<body onload="">
<h1>委托代办人</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>所属项目:</td><td><%=fi.getName(teasession._nLanguage)%></td></tr>
<tr><td>任务主题:</td><td><%=obj.getMotif()%></td></tr>
<tr><td>状态:</td><td><%=Task.FETTLE[obj.getFettle()]%></td></tr>
</table>
<form name="form1" action="/servlet/EditTask" method="POST" onsubmit="return f_submit();">
<input type="hidden" name="taid" value="<%=taid%>"/>
<input type="hidden" name="community" value="<%=community%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="act" value="edittaskconsign"/>
<input type="hidden" name="consign" value="/"/>

    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr><td>委托代办人:</td>
        <td>
        <table><tr><td>选定委托人</td><td></td><td>备选委托人</td></tr>
        <tr><td>
		<select name="consign1" size="9" style="width:180px" multiple onDblClick="move(form1.consign1,form1.consign2,true);">        
		</select>
		<td>
		<input type=button value=" ← " onClick="move(form1.consign2,form1.consign1,true);">
        <br>
        <input type=button value=" → " onClick="move(form1.consign1,form1.consign2,true);">
		<td>
        <select name="consign2" size="9" style="width:180px" multiple onDblClick="move(form1.consign2,form1.consign1,true);">
        <%
	        String members[]=member.split("/");
	        for(int i=1;i<members.length;i++)
	        {
				//被委托的人不能是:接纳人,自已,任务分配人
		       String ass=obj.getAssignerid();
	           if(ass.indexOf("/"+members[i]+"/")==-1&&!members[i].equals(teasession._rv._strV)&&!members[i].equals(obj.getMember()))
	           {
 	            Profile p=Profile.find(members[i]);
 	            if(p.getTime()!=null)//会员必须存在
 	            {
	              out.println("<option value='"+members[i]+"'>"+p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage));
	            }
	           }
	        }
        %>
        </select>
        </table>
        </td></tr>
    </table>

<input type="submit" value="提交"/>
<input type="button" value="返回" onclick="window.history.back();"/>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
</body>
</html>


