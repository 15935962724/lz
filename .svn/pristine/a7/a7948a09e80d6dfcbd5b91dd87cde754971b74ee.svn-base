<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.entity.Http" %>
<%@page import="java.util.Date"%>
<%@page import="tea.db.DbAdapter"%>
<%@ page import="tea.entity.MT" %>
<%@ page import="tea.entity.member.Profile" %>
<%@page import="tea.entity.pm.PoSingleRelease"%>
<%@page import="java.util.ArrayList"%>
<%@page import="tea.entity.Attch"%>
<%
	Http h=new Http(request); 
	if(h.member<1)
	{
	  response.sendRedirect("/servlet/StartLogin?community="+h.community);
	  return;
	}
	/*
	if(h.isIllegal())
	{
	  response.sendError(404,request.getRequestURI());
	  return;
	}
	*/
	StringBuffer sql=new StringBuffer(),par=new StringBuffer();
	
	int menuid=h.getInt("id");
	par.append("?id="+menuid);
	
	int type=h.getInt("type");
	sql.append(" AND type="+type);
	par.append("&type="+type);
	
    String title="";
	if(type==0)
		title="套单解单";
	else if(type==1)
		title="交易计划";
	else if(type==2)
		title="数据分析";
	
	
	String name=h.get("name","");
	if(name.length()>0)
	{
	  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
	  par.append("&name="+h.enc(name));
	}
	
	String contactway=h.get("contactway","");
	if(contactway.length()>0)
	{
	  sql.append(" AND contactway LIKE "+DbAdapter.cite("%"+contactway+"%"));
	  par.append("&contactway="+h.enc(contactway));
	}
	
	Date applyTime0=h.getDate("applyTime0");
	if(applyTime0!=null)
	{
	  sql.append(" AND applyTime>"+DbAdapter.cite(applyTime0));
	  par.append("&applyTime0="+MT.f(applyTime0));
	}

	Date applyTime1=h.getDate("applyTime1");
	if(applyTime1!=null)
	{
	  sql.append(" AND applyTime<"+DbAdapter.cite(applyTime1));
	  par.append("&applyTime1="+MT.f(applyTime1));
	}
	
	int pos=h.getInt("pos");
	par.append("&pos=");
	
	int sum=PoSingleRelease.count(sql.toString());

%>
<html>
<head>
<title><%=title%></title>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/script.js" type="text/javascript"></script>
<style>
#tablecenter td table td{border:0}
</style>
</head>
<body>
<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div><!-- onSubmit="if(mt.check(this)){mt.show(null,0);mt.usubmit(this);}return false;" -->
<h2>查询</h2>
<form name="form1" action="?" >

<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="type" value="0">
<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
	<tr >
		<td class="th">姓名:</td>
		<td><input type="text" name="name" value="<%=name%>"></td>
		<td class="th">联系方式:</td>
		<td><input type="text" name="contactway" value="<%=contactway%>"></td>
		<td class="th">申请时间:</td>
		<td><input name="applyTime0" value="<%=MT.f(applyTime0)%>" onClick="mt.date(this)" class="date"/>-<input name="applyTime1" value="<%=MT.f(applyTime1)%>" onClick="mt.date(this)" class="date"/>　<input type="submit" value="查询"/></td>
	</tr>
	
</table>
</form>

<h2>申请记录</h2>
<form name="form2" action="/EditSingleRelease.do" target="" method="post">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table border=0 cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td>姓名</td>
    <td>联系方式</td>
    <td>申请时间</td>
    <td>资料</td>
  </tr>
<%
if(sum<1){
  out.print("<tr><td colspan='10' align='center'>暂无记录！</td></tr>");
}else{
  ArrayList<PoSingleRelease> al = PoSingleRelease.find(sql.toString(),pos,20);
  for(int i=0;i<al.size();i++){
	  PoSingleRelease obj = al.get(i);
	  String fileHref = "";
	  if(obj.getUploadFile()>0){
		  Attch a = Attch.find(obj.getUploadFile());
		  fileHref="<a href='" + Http.HOST + "/Attchs.do/" + Http.enc(a.name) + "?act=down&attch=" + MT.enc(a.attch) + "' title='" + MT.f(a.name) + "'>" + MT.f(a.name)+ "</a>";
	  }else{
		  fileHref="无";
	  }
	  
    %>
    <tr>
      <td><%=MT.f(obj.getName())%></td>
      <td><%=MT.f(obj.getContactway())%></td>
      <td><%=MT.f(obj.getApplyTime(),1)%></td>
      <td><%=fileHref%></td>
    </tr>
    <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}
%>
</table>

</form>

<script type="text/javascript">
/* mt.uploads(form1); */
form1.nexturl.value=location.pathname+location.search;
mt.act=function(a,t,b){
  	form1.act.value = a;
  	form1.psrid.value = t;
  	if(a=='edit'){
  		form1.action="?";
    	form1.target=form1.method='';
    	form1.submit();
  	}else if(a == 'del'){
  		mt.show("确认删除？资料也会被删除。",2,"form1.submit()");
	}
};

function checkFile(obj){
    //用元素的id获得该元素的值，从而进行判断选择的文件是否合法
    var file = document.form1.uploadFile.value;
    if(file==null||file==""){
    	var data = document.form1.uploadFile.data;
    	if(data<1){
    		alert("你还没有选择任何文件，不能上传!");
            return;
    	}        
    }else{
    	if(file.lastIndexOf(".")==-1){
            alert("路径不正确!") ;
            return ;
        }
        var allImgExt = ".doc|.docx|.xls|.xlsx|.pdf|" ;
        var extName = file.substring(file.lastIndexOf(".")) ;
        if(allImgExt.indexOf(extName+"|")==-1){
            errMsg="该文件类型不允许上传。请上传 "+allImgExt+" 类型的文件，当前文件类型为"+extName;
            alert(errMsg);
            return;
        }
    }    
    //document.form1.target="_ajax";
    obj.disabled=true;
    document.form1.submit() ;
}
</script>
</body>
</html>