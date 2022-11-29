<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&menu="+menu);



String name=h.get("name","");





%><!DOCTYPE html><html><head>

<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/jquery-1.3.1.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="/tea/new/css/style.css">
<script src="/tea/yl/mtDiag.js"></script>
<style>
	.right-tab td{
		height:auto;
		padding:8px 5px;
	}
</style>
</head>
<body style='padding:15px 20px;min-height:600px'>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>

<div class="query">
<table id="tablecenter" cellspacing="0" class="w100">
<tr>
	<td nowrap="" style="width:70px;font-size:14px;">医院名称：</td>
	<td style="width:240px"><input name="name" value="<%=name %>" class="form-control" style="height:auto;width: 200px;"/></td>
  
  	<td><input type="submit" class="btn btn-primary btn-blue" value="查询" style="height:32px;padding:0px 20px;"/></td>
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
<table id="tablecenter" cellspacing="0" class="right-tab">
<tr id="tableonetr">
  <th nowrap="">序号</th>
  <th>医院名称</th>
  <th nowrap="">操作</th>
  
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
		if(sh.getName()!=null) {
			if (name.length() > 0) {
				if (sh.getName().indexOf(name) > -1) {
					lst.add(sh.getName());
				}
			} else {
				lst.add(sh.getName());
			}
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
if(end>lst.size()){
	end=lst.size();
}
List<String> lst2=null;
if(pageindex>0){
	lst2=lst.subList(begin, end);
}else if(pageindex==0&&lst.size()<size){
	lst2=lst.subList(0, lst.size());
}else if(pageindex==0&&lst.size()>size){
	lst2=lst.subList(0, size);
}else{
	lst2=lst.subList(0, lst.size());
}

if(lst2!=null){
	for(int i=0;i<lst2.size();i++){
		out.print("<tr>");
		out.print("<td>"+(i+1)+"</td>");
		out.print("<td>"+lst2.get(i)+"</td>");
		out.print("<td><a id='sel' href='javascript:void(0)' onclick=f_ok('"+lst2.get(i)+"')>选择</a></td>");
		out.print("</tr>");
	}
}
if(totalpage>1){
	
	out.print("<tr><td colspan='3' id='ggpage'>");
	for(int i=0;i<totalpage;i++){
		if((i+1)==pageindex){
			out.print("<span>"+(i+1)+"</span>&nbsp;&nbsp;");
		}else{
			out.print("<a href='/jsp/yl/shopwebnew/Selhospital.jsp?pageindex="+(i+1)+"&name="+name+"' >"+(i+1)+"</a>&nbsp;&nbsp;");
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
</form>
<script>

	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	function f_ok(a)
	{
	    var pmt=parent.mt;
		var v=a,n='',h='';
	  	pmt.receive(v,n,h);
        parent.layer.close(index);
	}
	mt.fit();
</script>
</body>
</html>
