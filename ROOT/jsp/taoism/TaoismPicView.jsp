<%@page import="tea.entity.taoism.Situation"%>
<%@page import="tea.entity.taoism.Taoism"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%

Http h=new Http(request,response);
int tidd=h.getInt("tid",0);
Taoism t= Taoism.find(tidd);
String tid=t.c_pic;
int picnode=h.getInt("picnode",0);
String pic[]={"|"};
if(tid!=null){
tid=tid.replace(picnode+"|", "");
pic= tid.split("[|]");
}
String act=h.get("act","");
if("POST".equals(request.getMethod())){
	if("delpic".equals(act)){
		
		if(tidd>0)
			t.set("c_pic", t.c_pic.replace(picnode+"|", ""));
			
	}
}
%>
<script src="/tea/mt.js" type="text/javascript"></script>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<h1>证书图片列表</h1>
<form name="form1" action="?" method="POST">
<input type="hidden" name="picnode">
<input type="hidden" name="id" value="<%=tid%>">
<input type="hidden" name="tid" value="<%=tidd%>">
<input type="hidden" name="act" value="delpic">
<table cellpadding="0" cellspacing="0" id="tablecenter">
<% 
if(pic.length<2)out.print("<td>暂无记录！</td>");
for(int i=1;i<pic.length;i++){
%>
<tr>
  <td><a href="<%=Attch.find(Integer.parseInt(pic[i])).path %>" target="_blank"><%=Attch.find(Integer.parseInt(pic[i])).path %></a></td>
  <td><input type="button" onclick=sub('<%=pic[i] %>') value="删除"></td>
</tr>
<%} %>
</table>
<script>
function sub(a){
	form1.picnode.value=a;
	form1.submit();
}
</script>
<input type="button" onclick="goback()" value="返回">
</form>
<script>
function goback(){
	parent.mt.close();
}
</script>

