<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%>
<%@page import="tea.entity.admin.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  //out.println("<script>alert('您还没有登陆或登陆已超时！请重新登陆');location.replace('/my/Login.jsp?nexturl='+encodeURIComponent(location.pathname+location.search));</script>");
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
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
<div class="Mytop">
<span>您的身份：<%= Profile.MEMBER_TYPE[m.membertype] %></span>
<span>
	资质审核：
<%
boolean flag = false;
	ShopQualification sq = ShopQualification.findByMember(m.profile);
	if(m.membertype==2){//2 代理商
		out.print("无");
	}else{
		if(m.qualification==1){
			out.print("审核通过");
		}else{
			if(sq.status==0){
				out.print("未提交审核");
			}else if(sq.status==0){
				out.print("未提交");
			}else if(sq.status==1){
				out.print("待审核");
			}else if(sq.status==3){
				out.print("未通过审核");
				out.print("&nbsp;<a href='javascript:void(0);' onclick=mt.show(nextSibling.value)>退回原因  </a><textarea style='display:none'>"+MT.f(sq.returnv,"没有填写原因！").replaceAll("\r\n","<br/>")+"</textarea>");
			}else if(sq.status==4){
				out.print("资质过期");
			}else if(sq.status==5){
				out.print("待审核");
			}else if(sq.status==6){
				out.print("未通过审核");
				out.print("&nbsp;<a href='javascript:void(0);' onclick=mt.show(nextSibling.value)>退回原因  </a><textarea style='display:none'>"+MT.f(sq.returnv,"没有填写原因！").replaceAll("\r\n","<br/>")+"</textarea>");
			}
		}
	}
%>
</span>
<span>
<%
//订单中“未付款”和“未确认收货”的数量
int orderopersum = 0;
List<ShopOrder> solist = ShopOrder.find(" AND member="+h.member+" AND status=0",0,Integer.MAX_VALUE);
if(solist!=null&&solist.size()>0)
	orderopersum = solist.size();
%>
	订单提醒：(<%=orderopersum%>)
</span>


</div>

<script>
mt.fit();
</script>

</body>
</html>
