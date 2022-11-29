<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.member.*"%>
<%
request.setCharacterEncoding("UTF-8");


TeaSession teasession=new TeaSession(request);
//if(teasession._rv==null)
//{
//  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
//  return;
//}
tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);
String nexturl = teasession.getParameter("nexturl");
int membertype=0;
if(teasession.getParameter("membertype")!=null && teasession.getParameter("membertype").length()>0)
{
  membertype= Integer.parseInt(teasession.getParameter("membertype"));
}
 MemberType obj = MemberType.find(membertype);
 java.util.Enumeration e1= MemberPay.find(teasession._strCommunity," AND membertype="+membertype,0,Integer.MAX_VALUE);

 //要注册的用户
 String memberid = (String)session.getAttribute("member_id");
 
 if(memberid!=null && memberid.length()>0)
 {
	 
 }else
 {
	 memberid = teasession._rv.toString();
 }


String memberorder ="0";
RegisterInstall riobjs = RegisterInstall.find(membertype);
int v = 0;
RegisterInstall riobj = RegisterInstall.find(membertype);
if(!MemberOrder.isMemberOrder(teasession._strCommunity,membertype,0,memberid)){
  if(riobj.getVerify()==0)//如果这个用户类型注册时候不需要审核，则，把标示修改成3
  {
    v=3;
  }
  MemberOrder.create(membertype,0,memberid,teasession._strCommunity,v,0,0);
  memberorder = MemberOrder.getMemberOrder(teasession._strCommunity,membertype,memberid);
}else
{
   memberorder = MemberOrder.getMemberOrder(teasession._strCommunity,membertype,memberid);
}
//判断是 如果 MemberRecord 表中没有着个类型的用户  和 MemberPay 表中 有记录时候
//System.out.print(!MemberRecord.isMemberRecord(teasession._rv.toString(),membertype) +"--"+MemberPay.isMembertype(membertype));
if(!MemberRecord.isMemberRecord(memberid,membertype) ){//&& MemberPay.isMembertype(membertype)
  MemberRecord.create(memberid,membertype,teasession._strCommunity);
}


if(obj.getAppemail()==1)//说明要验证邮箱
{
	//发送Email 
    //发送外部邮件
    tea.service.SendEmaily se = new tea.service.SendEmaily(teasession._strCommunity);
	
	Profile pobj = Profile.find(memberid);
     tea.entity.admin.orthonline.ProfileOrth.send(teasession,pobj);
	 session.setAttribute("membertype",String.valueOf(membertype));

   // se.sendEmail(p.getEmail(),"注册会员确认",sp.toString());
	response.sendRedirect("/jsp/user/UserConfirm.jsp?membertype="+membertype+"&user="+java.net.URLEncoder.encode(memberid,"utf-8")+"&community="+teasession._strCommunity);
    return;
} 


/*
if(riobj.getVerify()==0)//判断这个类型不通过审核，则直接跳转到 起始注册页面
{
  out.println("<script>alert('您已经注册成功，您的用户名是："+memberid+",点击确定，系统会跳转到注册其他会员类型！');</script>");
  out.println("<script>self.location='/jsp/mov/AdminTransfer.jsp'</script>");
//  response.sendRedirect("/jsp/mov/AdminTransfer.jsp");
//  return;
}

*/
//
// if(riobj.getVerify() == 1)//如果不审核 则建立session，用户可以直接登陆
// {
//     session.removeAttribute("tea.RV");
// }

MemberOrder mobj = MemberOrder.find(MemberOrder.getMemberOrder(teasession._strCommunity,membertype,memberid));
mobj.setType(1);


%> 
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body bgcolor="#ffffff" class="Success">
<%=community.getJspBefore(teasession._nLanguage)%>
 <%=tea.entity.admin.mov.RegisterInstall.getNavigation((membertype),teasession._nLanguage,"lzj_zccg",5) %>
<div id =ednlog >
<span class="logname"><span><%=memberid%></span>&nbsp;恭喜您帐号注册成功！&nbsp;</span>


<%

   if(e1.hasMoreElements()){

%>
<form action="/jsp/mov/Success2.jsp" name="form1" method="POST" >
<input type="hidden" name="memberorder" value="<%=memberorder%>"/>
<input type="hidden" name="membertype" value="<%=membertype%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td align="center" colspan="5">您注册的是 (<b><%=obj.getMembername() %></b>) 下面列表是显示此类会员的收费情况，请您选择缴费！</td></tr>
  <tr id="tableonetr">
  <td width="1">&nbsp;</td>
      <td nowrap="nowrap">服务费用</td>
      <td  nowrap="nowrap">服务期限</td>
       <td nowrap="nowrap">服务说明</td>
     </tr>
     <%

        for(int i = 0;e1.hasMoreElements();i++)
        {
          int payid = ((Integer)e1.nextElement()).intValue();
          MemberPay pobj = MemberPay.find(payid);
     %>
     <tr>
     <td width="1"><input type="radio" name="payid" value="<%=payid%>"  <%if(i==0)out.print(" checked=\"checked\"");%>></td>
    <td nowrap><%=pobj.getPaymoney() %>元</td>
    <td><%=pobj.getPaytime()%>年</td>
    <td><%=pobj.getPaycontent()%></td>
  </tr>

<%} %>

</table>
<p>
<input type="submit" value="下一步" />
</p>
</form>
<%
 

}else{

  if(obj.getSkips()==0 && riobj.getVerify()==0){
    //out.print("<a href="+obj.getFileurl()+">进入网站首页</a>");
    out.print("<input type=button  class=homeid value=返回首页 onclick=window.open('"+"http://"+request.getServerName()+":"+request.getServerPort()+"','_parent');>&nbsp;<input type=button  class=adminid value=进入后台 onclick=window.open('/jsp/admin/indextop.jsp','_self'); >&nbsp;<input class=\"closeid\" onclick=\"parent.mt.close()\" type=\"button\" value=\"关闭\" />");
    
  }else  if(obj.getSkips()==0 && riobj.getVerify()==1)
  { 
	  out.print("我们工作人员会最快给您审核...<br>");
	  out.print("<input type=button class=homeid value=返回首页  onclick=window.open('"+"http://"+request.getServerName()+":"+request.getServerPort()+"','_self');>&nbsp;<input type=button class=adminid value=进入后台 onclick=window.open('/jsp/admin/indextop.jsp','_self'); >");
  }else { 
	
    out.print("<script>alert('setTimeout('window.location.replace(\""+obj.getFileurl()+"\");',10000);</script>");
  }

}
  %>
  </div>
<%=community.getJspAfter(teasession._nLanguage)%>

</body>
</html>
