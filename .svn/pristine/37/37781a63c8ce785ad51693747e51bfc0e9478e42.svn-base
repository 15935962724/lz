<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
String community = h.get("community","");
if(community.equals("")){
community = h.getCook("community", "Home");
}
h.setCook("community", community, Integer.MAX_VALUE);

	String openid=h.getCook("openid",null);
	if(openid==null){
		response.sendRedirect("/PhoneProjectReport.do?act=openid&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString()+"&r="+Math.random()));
		return;
	}
	List<Profile> lstp= Profile.find1(" and openid="+DbAdapter.cite(openid), 0, 1);
	if(lstp.size()==0){
		String param = request.getQueryString();
		String url = request.getRequestURI();
		if(param != null)
			url = url + "?" + param;
		response.sendRedirect("/mobjsp/yl/user/login_mob.html?nexturl="+Http.enc(url));
		return;
	}
	Profile p1=lstp.get(0);
	if(p1.profile>0){
		h.member=p1.profile;
		session.setAttribute("member",h.member);
	}
/* if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
} */ 
int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&menu="+menu);



String name=h.get("name","");





%><!DOCTYPE html><html><head>

<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>

<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">
<link href="webcss.css" rel="stylesheet" type="text/css">

<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/jquery-1.3.1.min.js" type="text/javascript"></script>
<style>
.mt_data td,.mt_data th{padding:3px}
#tableweb td input[name='name']{width: 110px !important;}
#tableweb td {
    padding: 5px 5px  !important;
    color: #333;
}
</style>
</head>
<body style='min-height:600px'>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>

<div class="query">
<table id="tableweb" cellspacing="0">
<tr>
  <td>医院名称：<input name="name" value="<%=name %>" /></td>
  
  <td><input type="submit" class="button" value="查询"/></td>
</tr>
</table>
</div>
</form>

<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
<input type="hidden" name="orderId"/>
<input type="hidden" name="status"/>
<input type="hidden" name="cancelReason"/>

<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<div class="results">
<table id="tableweb" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td width="76%">医院名称</td>
  <td>操作</td>
  
</tr>
<%

Profile p=Profile.find(h.member);
String hospitals=p.hospitals;
	List<String> lst=new ArrayList<String>();
	if(hospitals!=null) {
		String[] hospitalarr = hospitals.split("\\|");
		for(int i=1;i<hospitalarr.length;i++){
			String hospital=hospitalarr[i];
			ShopHospital sh=ShopHospital.find(Integer.parseInt(hospital));
			if(name.length()>0){
				if(sh.getName().indexOf(name)>-1){
					lst.add(sh.getName());
				}
			}else{
				lst.add(sh.getName());
			}


		}
	}

if(lst.size()>0){
int size=10;//每页10条
int yu=lst.size()%size;
int totalpage=0;//总页数
if(yu>0){
	totalpage=lst.size()/size+1;
}else{
	totalpage=lst.size()/size;
}
int pageindex=h.getInt("pageindex");
int begin=(pageindex-1)*size;
int end=((pageindex-1)*size)+size;
//out.print("<script>alert('"+pageindex+","+begin+","+end+","+lst.size()+"')</script>");
if(end>lst.size()){
	end=lst.size();
}
List<String> lst2=new ArrayList<String>();
if(pageindex>0){
	lst2=lst.subList(begin, end);
}else if(pageindex==0&&lst.size()<=size){
	
	lst2=lst.subList(0, lst.size());
}else if(pageindex==0&&lst.size()>size){
	lst2=lst.subList(0, size);
}

for(int i=0;i<lst2.size();i++){
	out.print("<tr>");
	out.print("<td>"+(i+1)+"</td>");
	out.print("<td>"+MT.f(lst2.get(i),28)+"</td>");
	out.print("<td><a id='sel' href='javascript:void(0)' onclick=f_ok('"+lst2.get(i)+"')>选择</a></td>");
	out.print("</tr>");
}
if(totalpage>1){
	
	out.print("<tr><td colspan='3'>");
	for(int i=0;i<totalpage;i++){
		if((i+1)==pageindex){
			out.print("<a href='/mobjsp/yl/shopwebnew/Selhospital.jsp?pageindex="+(i+1)+"&name="+name+"' style='color:red' >"+(i+1)+"</a>&nbsp;&nbsp;");
		}else{
			out.print("<a href='/mobjsp/yl/shopwebnew/Selhospital.jsp?pageindex="+(i+1)+"&name="+name+"' >"+(i+1)+"</a>&nbsp;&nbsp;");
		}
		
	}
	out.print("</td></tr>");
} 

}else{
	out.print("<tr><td colspan='10'>暂无记录！</td></tr>");
}
  %>
 
</table>
<!-- <input type="button" name="multi" value="确定" onclick="f_ok()"/> -->
</div>

<script>

/* $(document).ready(function(){
	
	$("#sel").click(function(){
		alert("1");
		var val=$(this).parent().prev().html();
		alert(val);
		parent.mt.receive(val);
		alert("22")
		parent.mt.close();
		
	}) 
	}); */
	function f_ok(a)
	{
		
		var pmt=parent.mt;
		var v=a,n='',h='';
	  pmt.receive(v,n,h);
	  pmt.close();
	}
mt.fit();
</script>
</body>
</html>
