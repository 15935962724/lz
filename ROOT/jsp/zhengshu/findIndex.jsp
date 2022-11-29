<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ page import="tea.entity.*" %><%@ page import="tea.db.*,java.util.*" %><%@page import="tea.entity.zs.Ctf"%>
<%
List list=new ArrayList();

	Http http=new Http(request);
	String name=http.get("name");
	String creNum=http.get("creNum");
	String creNumber=http.get("creNumber","");
	StringBuffer sql=new StringBuffer();
	if(name!=""){
		sql.append(" and name="+DbAdapter.cite(name));
	}
	if(creNum!=""){
		sql.append(" and cre_num="+DbAdapter.cite(creNum));
	}
	if(creNumber.length()>0){
		sql.append(" and cre_number="+DbAdapter.cite(creNumber));
	}
	if(name!=null&&name!=""&&creNum!=null&&creNum!=""){
		
		list=Ctf.findCtf(sql.toString(), 0, 1);
		if(list==null||list.size()<1){
			out.print("<script>$('#span').html('无符合条件证书信息，请核对后查询');</script>");
		}
	}
	



  for(int i=0;i<list.size();i++){
	  Ctf ctf=(Ctf)list.get(i);
  
	
%>
<style>
table.polling_list{width:700px;margin:0px auto;}
table.polling_list td{line-height:30px;padding:0px 6px;}
td.polling_title{font-size:14px;font-weight:bold;padding-left:10px;width:100%;color:#25435F;background:#D5E6F4;}
td.polling_title span{text-align:left;width:auto;display:block;padding:0px 8px;}
</style>
<table border="1" cellpadding="0" cellspacing="0" bordercolor="#87B5DE" class="polling_list">
  <tr>
    <td class="polling_title" colspan="4">基本信息<font style="font-weight:lighter;padding-left:10px;">Essential information</font></td>
	<td width="120" height="120" rowspan="4" style="padding:5px;"><img src="<%=ctf.getPhoto() %>" width="120" height="120" /></td>
  </tr>
  <tr>
    <td width="104" align="right" style="color:#2C669A;">姓名</td>
    <td align="left" width="160"><%=ctf.getName() %>&nbsp;</td>
    <td width="83" align="right" style="color:#2C669A;">性别</td>
    <td align="left" width="157"><%=ctf.getSex()==0?"男":"女" %>&nbsp;</td>
  </tr>
  <tr>
    <td align="right" style="color:#2C669A;">证件号码</td>
    <td align="left"><%=ctf.getCreNum() %>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="4" class="polling_title">证书信息<font style="font-weight:lighter;padding-left:10px;">Certificate information</font></td>
  </tr>
  <tr>
    <td align="right" style="color:#2C669A;">证书编号</td>
    <td align="left"><%=ctf.getCreNumber() %>&nbsp;</td>
    <td align="right" style="color:#2C669A;">证书级别</td>
    <td align="left" colspan="2"><%=ctf.getCreLv() %>&nbsp;</td>
  </tr>
  <tr>
    <td align="right" style="color:#2C669A;">证书名称</td>
    <td align="left" colspan="4"><%=ctf.getCreName() %>&nbsp;</td>
    
  </tr>
  <tr>
    <td align="right" style="color:#2C669A;" nowrap="nowrap">&nbsp;<%=ctf.getMarkName1() %></td>
    <td align="left" nowrap="nowrap"><%=ctf.getMark1() %>&nbsp;</td>
    <td align="right" style="color:#2C669A;" nowrap="nowrap">&nbsp;<%=ctf.getMarkName2() %></td>
    <td align="left" nowrap="nowrap" colspan="2"><%=ctf.getMark2() %>&nbsp;</td>
  </tr>
  <tr>
    <td align="right" style="color:#2C669A;">&nbsp;<%=ctf.getMarkName3() %></td>
    <td align="left"><%=ctf.getMark3() %>&nbsp;</td>
    <td align="right" style="color:#2C669A;">&nbsp;<%=ctf.getMarkName4() %></td>
    <td align="left" colspan="2"><%=ctf.getMark4() %>&nbsp;</td>
  </tr>
  <tr>
    <td align="right" style="color:#2C669A;">&nbsp;<%=ctf.getMarkName5() %></td>
    <td align="left"><%=ctf.getMark5() %>&nbsp;</td>
    <td align="right" style="color:#2C669A;">&nbsp;<%=ctf.getMarkName6() %></td>
    <td align="left" colspan="2"><%=ctf.getMark6() %>&nbsp;</td>
  </tr>
  <tr>
    <td align="right" style="color:#2C669A;">&nbsp;<%=ctf.getOtherName() %></td>
    <td align="left" colspan="4"><%=ctf.getOther() %>&nbsp;</td>
   
  </tr>
  <tr>
    <td colspan="5" class="polling_title" >数据信息<font style="font-weight:lighter;padding-left:10px;">Data and information</font></td>
  </tr>
  <tr>
    <td align="right" style="color:#2C669A;" nowrap="nowrap">数据上报单位</td>
    <td align="left"><%=ctf.getDanwei() %>&nbsp;</td>
    <td align="right" style="color:#2C669A;">发证时间</td>
    <td colspan="2"><%=ctf.getTime() %>&nbsp;</td>
  </tr>
</table>
<%} %>

