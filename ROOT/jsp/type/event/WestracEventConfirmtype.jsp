<%@page import="tea.entity.westrac.WestracIntegralLog"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="tea.entity.westrac.Eventregistration"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.Event"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.admin.AdminRole"%>
<%@page import="tea.entity.admin.AdminUnit"%>
<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="java.util.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
String community=teasession._strCommunity;



if(teasession._rv==null)
{
	out.println("您还没有登录，没有权限查看，请登录");
	return;
}

int eid = Integer.parseInt(teasession.getParameter("eid"));
Eventregistration eobj = Eventregistration.find(eid);

if("POST".equals(request.getMethod()))
{
	int confirmtype = 0;
	if(teasession.getParameter("confirmtype")!=null && teasession.getParameter("confirmtype").length()>0)
	{
		confirmtype = Integer.parseInt(teasession.getParameter("confirmtype"));
	}
	
	if(confirmtype!=0)
	{
		
		Event ev = Event.find(eobj.getNode(),teasession._nLanguage);
		Node nobj = Node.find(eobj.getNode());
			eobj.setConfirmtype(confirmtype);
			
			//添加到会
			if(confirmtype==1)
			{//到会
				Profile p = Profile.find(eobj.getMember());
				p.setMyintegral(p.getMyintegral()+ev.getIntegral()); 
				WestracIntegralLog.create(eobj.getMember(),0,nobj.getSubject(teasession._nLanguage),eobj.getNode(),ev.getIntegral(),null,new Date(),0,teasession._strCommunity);
	
				//发送短信
					String c = "感谢您参加了我们的”"+nobj.getSubject(teasession._nLanguage)+"“活动，为您增加"+ev.getIntegral()+"积分，您现在的总积分为"+p.getMyintegral()+"分！";
					
					SMSMessage.create(teasession._strCommunity,p.getMember(),p.getMobile(),teasession._nLanguage,c);
				
			}else if(confirmtype==2) 
			{//没有到会 减分
				Profile p = Profile.find(eobj.getMember());
				p.setMyintegral(p.getMyintegral()-ev.getIntegral());
				WestracIntegralLog.create(eobj.getMember(),1,nobj.getSubject(teasession._nLanguage),eobj.getNode(),0,null,new Date(),-ev.getIntegral(),teasession._strCommunity);
			}
			
			 
			out.println("<script>alert('信息确定成功');window.close();</script>");
			return;
		
	}
	
	out.println("<script>window.close();</script>");
	return;
}

 
%>
<html>
<base target="tar"/>
<HEAD>
  <link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <link href="/tea/CssJs/Home.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
  <script src="/tea/mt.js" type="text/javascript"></script>
  <script src="/tea/city.js"></script>
</HEAD>

<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" scroll="yes">
<script type="text/javascript">
window.name='tar';

</script>

<h1>确认会员是否到会</h1>
<form name="form1" action="?" method="POST" target="tar" >
<input type="hidden" name="id" value="<%=request.getParameter("id") %>">
<input type="hidden" name="node" value="<%=teasession._nNode %>">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">

<input type="hidden" name="eid" value="<%=eid %>">
<input type="hidden" name="act" >



<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
 <tr><td><input type="radio" name="confirmtype" value="1"  <%if(eobj.getConfirmtype()==1){out.println(" checked");} %>>&nbsp;已经到会&nbsp;
 <input type="radio" name="confirmtype" value="2" <%if(eobj.getConfirmtype()==2){out.println(" checked");} %>>&nbsp;没有到会</td>
 <td ><input type="submit" name="" value="确认"></td>
 </tr>

  </table>
</form>
</body>
</html>
