<%@page import="tea.entity.bbs.BBSLevel"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.Entity"%><%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.*"%>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
Http h = new Http(request);
/*
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
*/
 

Resource r=new Resource("/tea/resource/Photography");


String nexturl = request.getRequestURI();

StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);

StringBuffer sql=new StringBuffer(" and remembertype=1 and membertype=1 AND community="+DbAdapter.cite(teasession._strCommunity)+" AND member !="+DbAdapter.cite("webmaster"));

int pos=0,pageSize=20;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

int count=Profile.count(sql.toString());
sql.append(" order by rememberorder asc "); 

%>


<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<script>
form2.nexturl.value=location.pathname+location.search;
function f_act(a,id,b)
{
  form2.act.value=a;
  form2.member.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='add')
  {
    form2.nexturl.value='';
    form2.submit();
  }
}
function f_ym()
{
	var html = "<table class=SystemRemind><tr><td>您还未登录，登陆后才能申请加为好友，点击<a href='/html/folder/41-1.htm'>登录</a></td></tr><tr><td>还不是履友会员，<a href='/html/folder/17-1.htm'>马上注册</a></td></tr></table>";
	ymPrompt.win(html,300,200,'系统提示');
} 

</script>
<form name="form2" action="/FriendLists.do" method="post" target="_ajax">
<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>  
<input type="hidden" name="member"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<ul>  
<%
 

	    java.util.Enumeration e = Profile.find(sql.toString(),pos,pageSize);
		 if(!e.hasMoreElements())
		 {
		     out.print("<li>暂无记录</li>");
		 }
    	for(int i=1;e.hasMoreElements();i++)
    	{
    		String member =((String)e.nextElement());
    	 
    	    Profile pobj = Profile.find(member);
 
    	    	tea.entity.util.Card cobj = tea.entity.util.Card.find(pobj.getProvince(teasession._nLanguage));
    	    	
    	    	String cname = cobj.toString2();
    	    	ProfileBBS pb=ProfileBBS.find(h.community,member);
    	    	BBSLevel bl=BBSLevel.find(pobj.getBbslevel());
    	    	
    	    	out.print("<li>");
    	    	out.print("<div class=MemberLeft><span class=img><img src=\""+MT.f(pb.getPortrait(h.language),"/tea/image/avatar.jpg")+"\" /></span>");
    	    	out.print("<span class=member>");
    	    	out.print(member);
    	    	out.print("</span></div><div class=MemberRight><table border=0 cellSpacing=0 cellPadding=0><tr><td class=gongfen>");
    	    	out.print("论坛工分</td><td>"+pobj.getIntegral());
    	    	out.print("</td></tr><tr><td class=dengji>");
    	    	out.print("论坛等级</td><td>"+MT.f(bl.getName()));    	    	
    	    	out.print("</td></tr><tr><td class=lvyou>");
    	    	out.print("履友积分</td><td>"+pobj.getMyintegral());    	    	
    	    	out.print("</td></tr><tr><td class=laizi>");
    	    	out.print("来自</td><td>"+cname);
    	    	out.print("</td></tr><tr><td class=zhuce>");
    	    	out.print("注册时间</td><td>"+pobj.getTimeToString()); 
    	    	out.print("</td></tr></table>");
    	    	out.print("<span class=anniu>");
    	    	if(teasession._rv!=null){
    	    		
    	    	
	    	    	if(FriendList.find(teasession._rv._strR,member).time==null)
	    	    	{
	    	    		  out.print("<input type=button value=加为好友  onClick=\"f_act('add','"+member+"')\">");
	    	    	}else{
	    	    		out.print("<input type=button value=删除好友   onClick=\"f_act('del','"+member+"')\">");
	    	    	}
	    	    	out.print("<input type=button value=个人中心  onclick=\"window.open('/html/folder/3-1.htm?member="+URLEncoder.encode(member,"UTF-8")+"','_self');\">");
	    	    		
	    	    	
    	    	}else
    	    	{
    	    		  out.print("<input type=button value=加为好友  onClick=\"f_ym();\">");
    	    		  out.print("<input type=button value=个人中心  onclick=\"f_ym();\">");
    	    	}
    	    	
    	    	out.print("</span>");
    	    	out.print("</div></li>");

			} 

%>

 <%if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>

</ul>
</form>

