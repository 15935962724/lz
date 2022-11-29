<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<jsp:directive.page import="java.util.Calendar"/>
<%
request.setCharacterEncoding("UTF-8");


response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=teasession._strCommunity;

String cause=null,time_w=null,time_h=null;
int type =0;


String member = teasession._rv.toString();//当前用户

Outs obj=Outs.findByMember(teasession._strCommunity,member);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<script>
function f_delete()
{
  form1.nexturl.value=location;
  form1.act.value="deleteout";
  form1.submit();
}
function f_submit()
{
  form1.nexturl.value=location;
  form1.act.value="editout";

  if(form1.cause.value=="")
  {
  	alert("请填写原因!");
  	form1.cause.focus();
  	return false;
  }
  if(form1.time_w.value=="")
  {
  	alert("请填写开始时间!");
  	return false;
  }
  if(form1.time_h.value=="")
  {
  	alert("请填写结束时间!");
  	return false;
  }
  if(form1.name.value=="")
  {
       alert("请选择申请人!");
       return false;
  }
}
</script>

<h1>今日外出登记</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>请按格式：00：00---00：00 输入时间</h2>
<form name=form1 action="/servlet/EditOut" METHOD=POST>
<input type="hidden" name="community" value="<%=community%>">
<input type="hidden" name="nexturl" >
<input type="hidden" name="act" >

<%
if(obj.isExists())
{
	switch(obj.getType())
	{
		case 2:
			out.print("今日，因"+obj.getCause()+"由"+obj.getTime_w()+"至"+obj.getTime_h()+"申请外出，领导尚未批准<br><br>");
			out.print("<input type=\"button\" value=\"撤销申请\" onClick=f_delete() >");
			break;
		case 1:
			out.print("今日，因"+obj.getCause()+"由"+obj.getTime_w()+"至"+obj.getTime_h()+"申请外出，领导批示:已批准 <br><br>");
			out.print("<input type=\"button\" value=\"外出归来\" onClick=f_delete() >");
			break;
		case -1:
			out.print("今日，因"+obj.getCause()+"由"+obj.getTime_w()+"至"+obj.getTime_h()+"申请外出，领导批示:不批准 <br><br>");
			out.print("<input type=\"button\" value=\"删除申请\" onClick=f_delete() >");
	}
}else
{
Calendar c=Calendar.getInstance();
c.setTimeInMillis(System.currentTimeMillis());
String s=c.get(c.HOUR_OF_DAY)+":"+c.get(c.MINUTE);
String t=c.get(c.HOUR_OF_DAY)+3+":"+c.get(c.MINUTE);

%>



<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr">
  <td nowrap>因<input type="text" name="cause" size="20">由<input type="text" name="time_w" value="<%=s%>" size="5">至<input type="text" name="time_h" value="<%=t%>" size="5">
<%
    AdminUsrRole au_obj=AdminUsrRole.find(teasession._strCommunity,member);
	out.print("<input type=\"hidden\" value="+au_obj.getUnit()+" name=\"un\">");
	out.print("<input type=\"hidden\" value="+au_obj.getClasses()+" name=\"cl\">");


	String sql=" AND member!="+DbAdapter.cite(member);
    if(au_obj.getUnit()==0)//无部门
    {
    	sql+=" AND classes!='' AND classes!='/'";
    }else
    {
    	sql+=" AND classes LIKE '%/"+au_obj.getUnit()+"/%'";
    }
	out.print("<select name=name>");
    java.util.Enumeration enu=AdminUsrRole.findByCommunity(teasession._strCommunity,sql);
    while(enu.hasMoreElements())
    {
       String _member = (String)enu.nextElement();
       Profile p=Profile.find(_member);
       if(p.getTime()!=null)
       {
	       AdminUsrRole obj1=AdminUsrRole.find(teasession._strCommunity,_member);
    	   out.print("<option value="+obj1.getMember()+":"+obj1.getClasses()+":"+obj1.getUnit()+"> "+p.getName(teasession._nLanguage));
       }
    }
    out.print("</select>");

%>
<input type="submit" value="申请外出" onclick="return f_submit();"></td>
    </tr>
    </table>
</form>
<%

	}
 %>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


