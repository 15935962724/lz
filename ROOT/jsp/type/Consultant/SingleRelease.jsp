<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.entity.Http" %>
<%@ page import="tea.resource.Resource" %>
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
	int menuid=h.getInt("id");
	
	int type=h.getInt("type");
	 String title="";
	if(type==0)
		title="套单解单";
	else if(type==1)
		title="交易计划";
	else if(type==2)
		title="数据分析";
	
	String nexturl = request.getRequestURI()+"?community="+h.community+"&id="+menuid+"&type="+type;
	
	int psrid = h.getInt("psrid");
	PoSingleRelease psr = PoSingleRelease.find(psrid);
	
	//Resource res=new Resource().add("/tea/resource/Consultant");

%>

<title><%=title%></title>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/script.js" type="text/javascript"></script>
<style>
#tablecenter td table td{border:0}
</style>


<div id="head6"><img height="6" src="about:blank"></div><!-- onSubmit="if(mt.check(this)){mt.show(null,0);mt.usubmit(this);}return false;" -->
<form name="form1" method="post" action="/EditSingleRelease.do?repository=singlerelease/<%=type%>"  enctype="multipart/form-data" target="_ajax" onSubmit="return mt.check(this)&&checkFile();" >

<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="psrid" value="<%=psrid %>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="member">
<input type="hidden" name="type" value="<%=type%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
	<tr >
		<td class="th">姓名:</td>
		<td class="td01"><input name="name" type="text" value="<%=MT.f(psr.getName()) %>" size="50" alt="姓名"></td>
	</tr>
	<tr >
		<td class="th">联系方式:</td>
		<td class="td01"><input name="contactway" type="text" value="<%= MT.f(psr.getContactway()) %>" size="50" alt="联系方式"></td>
	</tr>
	<tr >
		<td class="th">上传资料:</td>
		<td colspan="3" class="td01">
			<%-- <input type="text" name="uploadFile" value="<%=psr.getUploadFile()%>" data='<%=psr.getUploadFile()<1?"":Attch.find(psr.getUploadFile()).toString3()%>' /><input readonly class="file0" title="资料" types="*.doc;*.docx;*.xls;*.xlsx;*.pdf" alt="资料"/><input type="button" class="file1" value="上传..."/><input class='file2' type='button' value='删除' onclick='mt.adel(this)'/>　<em class="ems">注：格式应为 .doc,.docx,.xls,.xlsx,.pdf。 </em> --%>
			<input name="uploadFile" type="file" id="uploadFile" size="50" accept="*.doc;*.docx;*.xls;*.xlsx;*.pdf" data='<%=psr.getUploadFile()%>'/>
			注：格式应为 .doc,.docx,.xls,.xlsx,.pdf。
		</td>
	</tr>
	
</table>
<div align="center" style="width:100%;height:43px;margin-top:45px;padding-bottom:76px;border-bottom:1px #ddd dashed;"><input type="submit" value="<%out.print(psr.getId()>0?"编辑":"申请"+title+"服务"); %>" style="font-size:16px;height:43px;width:276px;color:#fff;font-weight:bold;background: url(/res/Home/structure/bg11.gif) center no-repeat;border:none;cursor:pointer;"/></div>
</form>

<div class="sqjl">申请记录</div>
<form name="form2" action="/EditSingleRelease.do" target="" method="post">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<div class="sqjl_list">
<table border=0 cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td>姓名</td>
    <td>联系方式</td>
    <td>申请时间</td>
    <td>资料</td>
    <td>操作</td>
  </tr>
<%
StringBuffer sql=new StringBuffer(),par=new StringBuffer();

par.append("?id="+menuid);

sql.append(" AND type="+type+" AND member=" + h.member);
par.append("&type="+type+"&member=" + h.member);

int pos=h.getInt("pos");
par.append("&pos=");

int sum=PoSingleRelease.count(sql.toString());
if(sum<1){
  out.print("<tr><td colspan='10' style='text-align:center;'>暂无记录！</td></tr>");
}else{
  sql.append(" order by applyTime desc");
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
      <td>
      	 <a href="javascript:mt.act('edit',<%=obj.getId()%>)">编辑</a>
      	 <a href="javascript:mt.act('del',<%=obj.getId()%>)">删除</a>
      </td>
    </tr>
    <%
  }
  if(sum>20)out.print("<tr><td colspan='10' style='text-align:center;'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}
%>
</table>
</div>
</form>

<script type="text/javascript">
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

function checkFile(){
    //用元素的id获得该元素的值，从而进行判断选择的文件是否合法
    var file = document.form1.uploadFile.value;
    if(file==null||file==""){
    	var data = document.form1.uploadFile.data;
    	if(data<1){
    		alert("你还没有选择任何文件，不能上传!");
            return false;
    	}        
    }else{
    	if(file.lastIndexOf(".")==-1){
            alert("路径不正确!") ;
            return false;
        }
        var allImgExt = ".doc|.docx|.xls|.xlsx|.pdf|" ;
        var extName = file.substring(file.lastIndexOf(".")) ;
        if(allImgExt.indexOf(extName+"|")==-1){
            errMsg="该文件类型不允许上传。请上传 "+allImgExt+" 类型的文件，当前文件类型为"+extName;
            alert(errMsg);
            return false;
        }
    }
    return true;
}
</script>
