<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@page import="tea.entity.Http"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.trust.TrustCompany"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
.con{border-color: red}
</style>
</head>
<body>
<%
Http h=new Http(request);
String nname=h.get("nname", "");
StringBuffer sql=new StringBuffer("");
StringBuffer par=new StringBuffer("");
sql.append(" AND n.hidden=0 AND n.finished=1  AND n.type=111");
par.append("?nname="+nname);
if(nname.length()>0){
	
	sql.append(" and nameMsg like "+DbAdapter.cite("%"+nname.trim()+"%"));
}
int count =TrustCompany.count(sql.toString());
int size=10;

int pos=h.getInt("pos",0);
par.append("&pos=");

%>
<form name="form1" action="?" onsubmit="mt.query(this.name.value);return false;">
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">名称：</td><td><input name="nname" /></td>
  
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>
<form name="form2" action="?" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="subqualification"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>

<div class="list" id="list">
<%
if(count==0){
	out.print("暂无记录！");
}else{
	List list=TrustCompany.find(sql.toString(), pos, size);
	Iterator it=list.iterator();
	while(it.hasNext()){
		TrustCompany tc=(TrustCompany) it.next();
	%>
	<input name="id" id="<%=tc.node %>"  type="radio"  data='{id:<%=tc.node %>,name:"<%=tc.nameMsg %>"}' value="<%=tc.node %>"/><%=tc.nameMsg %>
	
	<%
}
	if(count>size)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language,par.toString(),pos,count,size));
	}
%>
</div>

<input type="button" value="确 定" onclick="f_ok()"/>
<input type="button" value="取 消" onclick="pmt.close()"/>
</form>
<script>
var pmt=parent.mt;
function f_ok()
{
  var attr=['name','value','data'];
  var arr=form2.id,h='';
  if(!arr.length)arr=[arr];
  for(var i=0;i<arr.length;i++)
  {
    var t=arr[i];
    if(t.disabled||!t.checked)continue;
    eval('d='+t.getAttribute('data'));
    h+="<span id='_q"+t.value+"' ><input type='hidden' name='companyNode'";
    for(var j=0;j<attr.length;j++)
      h+=" "+attr[j]+"='"+t.getAttribute(attr[j])+"'";
    h+=" />"+d.name+"<img src='/tea/image/d7.gif' onclick='mt.fdel(this)' /></span>";
    //删除旧的
    //t=parent.$('_q'+t.value);
    //if(t)t.parentNode.removeChild(t);textContent
  }
  pmt.receive(h);
  pmt.close();
}
</script>
</body>
</html>