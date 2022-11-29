<%@page import="tea.entity.yl.shop.ShopQualification"%>
<%@page import="tea.entity.yl.shop.ShopHospital"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  //out.println("<script>alert('您还没有登陆或登陆已超时！请重新登陆');location.replace('/my/Login.jsp?nexturl='+encodeURIComponent(location.pathname+location.search));</script>");
  out.println("<script>parent.mt.show('您还没有登陆或登陆已超时！请重新登陆',1,'/xhtml/folder/14102033-1.htm?community="+h.community+"')</script>");
  return;
}

/* Member m=Member.find(h.member); */
Profile m=Profile.find(h.member);

/* Site s=Site.find(1); */


%><!doctype html><html><head>
<title><%=Res.get(h.language,"个人资料")%></title>
<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}
</script></head>
<body>
<form action="/servlet/Logout" target="_parent" name="logform" method="post">
<input type="hidden" name="community" value="<%=h.community%>" /><!-- /servlet/Logout?community=Home&amp;node=14100002 -->
<input type="hidden" name="node" value="14102033" />
<input type="hidden" name="em" value="0" />
<input type="hidden" name="language" value="<%=h.language %>" />
<input type="hidden" name="nexturl" value="/servlet/Node?node=14102033&em=0&language=1&nexturl=/xhtml/folder/14110001-1.htm" />

</form>
<div class="Mytop">
<div class="my_name"><span><%= MT.f(m.member) %></span><em style="font-style:normal;color:#FF8000;"><%= (MT.f(m.mobile).length()==0?MT.f(m.email):MT.f(m.mobile)) %></em><a href="javascript:void(0)" onclick="logform.submit()" target="_parent" style="float:right;">退出登录</a></div>
<div class="my_status"><span>您的身份：<%= Profile.MEMBER_TYPE[m.membertype] %>　　</span>
<span>
	资质审核：
<span class="i"><%
boolean flag = false;
	ShopQualification sq = ShopQualification.findByMember(m.profile);
	if(m.membertype==2){//2 代理商
		out.print("无");
	}else if(m.member.equals("zyadmin")){
		out.print("<a href=\"/xhtml/folder/15030201-1.htm?status=0,1\" target=\"_parent\" style=\"float:right;\">订单管理</a>");
	}else{
		if(m.qualification==1){
			out.print("<i>已通过审核</i>");
		}else{
			if(sq.status==0){
				out.print("未提交审核");
			}else if(sq.status==0){
				out.print("未提交");
			}else if(sq.status==1){
				out.print("正在审核");
			}else if(sq.status==3){
				out.print("未通过审核");
				out.print("&nbsp;<a href='javascript:void(0);' onclick=mt.show(nextSibling.value)>退回原因  </a><textarea style='display:none'>"+MT.f(sq.returnv,"没有填写原因！").replaceAll("\r\n","<br/>")+"</textarea>");
			}else if(sq.status==4){
				out.print("资质过期");
			}else if(sq.status==5){
				out.print("正在审核");
			}else if(sq.status==6){
				out.print("未通过审核");
				out.print("&nbsp;<a href='javascript:void(0);' onclick=mt.show(nextSibling.value)>退回原因  </a><textarea style='display:none'>"+MT.f(sq.returnv,"没有填写原因！").replaceAll("\r\n","<br/>")+"</textarea>");
			}
		}
	}
%></span>
</span>

<span style="display:none;">
	订单提醒：(0)
</span>
</div>
<div class="my_time">上次登陆时间：<%= MT.f(m.ltime[0],3) %></div>
</div>

<script>
mt.fit();
</script>

</body>
</html>
