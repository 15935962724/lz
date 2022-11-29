<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ page import="tea.entity.*" %><%@ page import="tea.db.*,java.util.*" %><%@page import="tea.entity.zs.Ctf"%>
<script src="/jsp/zhengshu/jquery-1.9.1.js" type="text/javascript"></script>
<script type="text/javascript">
function fn1(){
	var name=form1.name.value;
	var creNum=form1.creNum.value;
	var creNumber=form1.creNumber.value;
	if((name!=""&&creNum!="")||(creNumber!=""&&creNum!="")||(creNumber!=""&&name!="")){
		form1.submit();
	}else{
		$("#span").html("注：任意输入以上两项内容即可查询。");
	}
}
</script>

<%
List list=new ArrayList();

	Http http=new Http(request);
	String name=http.get("name");
	String creNum=http.get("creNum");
	String creNumber=http.get("creNumber");
	StringBuffer sql=new StringBuffer();
	if(name!=""){
		sql.append(" and name="+DbAdapter.cite(name));
	}
	if(creNum!=""){
		sql.append(" and cre_num="+DbAdapter.cite(creNum));
	}
	if(creNumber!=""){
		sql.append(" and cre_number="+DbAdapter.cite(creNumber));
	}
	if((name!=null&&name!=""&&creNum!=null&&creNum!="")||(name!=null&&name!=""&&creNumber!=null&&creNumber!="")||(creNum!=null&&creNum!=""&&creNumber!=null&&creNumber!="")){
		
		list=Ctf.findCtf(sql.toString(), 0, 1);
		if(list==null||list.size()<1){
			out.print("<script>$('#span').html('无符合条件证书信息，请核对后查询');</script>");
		}
	}
	



  for(int i=0;i<list.size();i++){
	  Ctf ctf=(Ctf)list.get(i);
  
	
%>
<style>
table.polling_list{width:90%;margin:0px auto 20px;}
table.polling_list td{line-height:20px;padding:5px 6px;font-size:14px;}
td.polling_title{font-size:16px;font-weight:bold;padding-left:10px;width:100%;color:#25435F;background:#D5E6F4;}
td.polling_title span{text-align:left;width:auto;display:block;padding:0px 8px;}
</style>
<table border="1" cellpadding="0" cellspacing="0" bordercolor="#87B5DE" class="polling_list">
  <tr>
    <td class="polling_title" colspan="2">基本信息<font style="font-weight:lighter;padding-left:10px;">Essential information</font></td>
    </tr>
  <tr>
	<td class="tdimg" colspan="2" style="padding:5px;"><img src="<%=ctf.getPhoto() %>" width="120" height="120" /></td>
  </tr>
  <tr>
    <td class="tdr">姓名</td>
    <td align="left"><%=ctf.getName() %>&nbsp;</td>
  </tr>
  <tr>
    <td class="tdr">性别</td>
    <td align="left"><%=ctf.getSex()==0?"男":"女" %>&nbsp;</td>
  </tr>
  <tr>
    <td class="tdr">证件号码</td>
    <td align="left"><%=ctf.getCreNum() %>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" class="polling_title">证书信息<font style="font-weight:lighter;padding-left:10px;">Certificate information</font></td>
  </tr>
  <tr>
    <td class="tdr">证书编号</td>
    <td align="left"><%=ctf.getCreNumber() %>&nbsp;</td>
  </tr>
  <tr>
    <td class="tdr">证书级别</td>
    <td align="left" colspan=""><%=ctf.getCreLv() %>&nbsp;</td>
  </tr>
  <tr>
    <td class="tdr">证书名称</td>
    <td align="left" colspan=""><%=ctf.getCreName() %>&nbsp;</td>
    
  </tr>
  <tr>
    <td class="tdr" nowrap="nowrap">&nbsp;<%=ctf.getMarkName1() %></td>
    <td align="left" nowrap="nowrap"><%=ctf.getMark1() %>&nbsp;</td>
  </tr>
  <tr>
    <td class="tdr" nowrap="nowrap">&nbsp;<%=ctf.getMarkName2() %></td>
    <td align="left" nowrap="nowrap" colspan=""><%=ctf.getMark2() %>&nbsp;</td>
  </tr>
  <tr>
    <td class="tdr">&nbsp;<%=ctf.getMarkName3() %></td>
    <td align="left"><%=ctf.getMark3() %>&nbsp;</td>
  </tr>
  <tr>
    <td class="tdr">&nbsp;<%=ctf.getMarkName4() %></td>
    <td align="left" colspan=""><%=ctf.getMark4() %>&nbsp;</td>
  </tr>
  <tr>
    <td class="tdr">&nbsp;<%=ctf.getMarkName5() %></td>
    <td align="left"><%=ctf.getMark5() %>&nbsp;</td>
  </tr>
  <tr>
    <td class="tdr">&nbsp;<%=ctf.getMarkName6() %></td>
    <td align="left" colspan=""><%=ctf.getMark6() %>&nbsp;</td>
  </tr>
  <tr>
    <td class="tdr">&nbsp;<%=ctf.getOtherName() %></td>
    <td align="left" colspan=""><%=ctf.getOther() %>&nbsp;</td>
   
  </tr>
  <tr>
    <td colspan="2" class="polling_title" >数据信息<font style="font-weight:lighter;padding-left:10px;">Data and information</font></td>
  </tr>
  <tr>
    <td class="tdr" nowrap="nowrap">数据上报单位</td>
    <td align="left"><%=ctf.getDanwei() %>&nbsp;</td>
  </tr>
  <tr>
    <td class="tdr">发证时间</td>
    <td colspan="" align="left"><%=ctf.getTime() %>&nbsp;</td>
  </tr>
</table>
<%} %>

