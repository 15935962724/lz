<%@page import="tea.entity.westrac.WestracClue"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.Event"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.admin.AdminRole"%>
<%@page import="tea.entity.admin.AdminUnit"%>
<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="java.util.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
String nexturl = teasession.getParameter("nexturl");

Http h = new Http(request);
int wcid = h.getInt("wcid");

WestracClue wcobj = WestracClue.find(wcid);

String myact = teasession.getParameter("myact");
%>

<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/tea/city.js"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
<script>
function f_sub()
{
	if(formwc.wcname.value=='')
	{
		alert('请填写个人信息中的姓名');
		formwc.wcname.focus();
		return false;
	}
	
	if(formwc.mobile.value=='')
	{
		 alert('请填写个人信息中的移动电话');
	 		fromwc.mobile.focus();
	 		return false;
	}else
	{
		
	
		var str = formwc.mobile.value;
	    var reg=/^(((13[0-9]{1})|(18[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
		   if(!reg.test(str))
		  {
		    	 alert('您填写的个人信息中的移动电话格式不正确');
		 		fromwc.mobile.focus();
		 		return false;
		  }
	}
	
	if(formwc.clientname.value==''){
		alert('请填写购买人名称');
		formwc.clientname.focus();
		return false;
	}
	if(formwc.contactname.value==''){
		alert('请填写联系人姓名');
		formwc.contactname.focus();
		return false;
	}
	/*
	if(formwc.phone.value==''){
		alert('请填写公司电话');
		formwc.phone.focus();;
		return false;
	}
	*/
	if(formwc.clientmobile.value=='')
	{
		 alert('请填写公司的移动电话');
	 		fromwc.clientmobile.focus();
	 		return false;
	}else
	{
		
	
		var str = formwc.clientmobile.value;
	    var reg=/^(((13[0-9]{1})|(18[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
		   if(!reg.test(str))
		  {
		    	 alert('您填写的公司的移动电话格式不正确');
		 		fromwc.clientmobile.focus();
		 		return false;
		  }
	}
	
	if(formwc.city0.value=='')
	{
		alert('购买人所在地省份不能为空');
		formwc.city0.focus();
   	    return false;
	}
	
	if(formwc.city1.value=='')
	{
		alert('购买人所在地市不能为空');
		formwc.city1.focus();
   	    return false;
	}

	
	
	
	
	
	formwc.submit();	
}
</script>

<style>
#tablecenter td{padding:5px;font-size:12px;}
</style>

<form name="formwc" method="POST" action="/servlet/EditWestracClue" >

<input type="hidden" name="act" value="EditWestracClue">
<input type="hidden" name="nexturl" value="<%=nexturl %>">
<input type="hidden" name="wcid" value="<%=wcid %>">
<input type="hidden" name="myact" value="<%=myact %>">

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
      <td colspan="2" >个人基本信息</td>
   
    </tr>
    
    
    <%
    
    if(!wcobj.isExists()){
    //注册
    
    	if(teasession._rv==null)
    	{//没有登陆
    %>
   <tr>
      <td align="right"><span id="btid">*</span>&nbsp;姓名：</td>
      <td><input type="text" name="wcname" value=""></td>
    </tr> 
     
      <tr>
      <td align="right"><span id="btid">*</span>&nbsp;移动电话：</td>
      <td><input type="text" name="mobile" value=""></td>
    </tr>
    <%
    	}else{
    		
    		Profile pobj = Profile.find(teasession._rv.toString());
    %>
     <tr>
      <td align="right"><span id="btid">*</span>&nbsp;姓名：</td>
      <td>
      <%
      	if(pobj.getMembertype()==0)
      	{
      		//普通会员
      		out.print("<input type=\"text\" name=\"wcname\" value=\""+pobj.getFirstName(teasession._nLanguage)+"\">");
      	}else
      	{
      		out.print("<input type=\"hidden\" name=\"wcname\" value=\""+pobj.getFirstName(teasession._nLanguage)+"\">");
      		out.print(pobj.getFirstName(teasession._nLanguage));
      	}
      %>
     
      </td>
    </tr> 
     
      <tr>
      <td align="right"><span id="btid">*</span>&nbsp;移动电话：</td>
      <td>
      <%
      	if(pobj.getMembertype()==0)
      	{
      		//普通会员
      		out.print("<input type=\"text\" name=\"mobile\" value=\""+pobj.getMobile()+"\">");
      	}else
      	{
      		out.print("<input type=\"hidden\" name=\"mobile\" value=\""+pobj.getMobile()+"\">");
      		out.print(pobj.getMobile());
      	}
      %>
      </td>
    </tr>
    <%
    	}
    }else{
    %>
    
     <tr>
      <td align="right"><span id="btid">*</span>&nbsp;姓名：</td>
      <td><input type="text" name="wcname" value="<%=Entity.getNULL(wcobj.getWcname()) %>"></td>
    </tr> 
     
      <tr>
      <td align="right"><span id="btid">*</span>&nbsp;移动电话：</td>
      <td><input type="text" name="mobile" value="<%=Entity.getNULL(wcobj.getMobile()) %>"></td>
    </tr>
    
    <%} %>
    
    
    
    
    
    <tr>
      <td colspan="2" >销售线索信息</td>
   
    </tr>
	 <tr>
      <td align="right">所属行业：</td>
      <td>
      <select name="industrys">
			<%
				for(int i=0;i<WestracClue.INDUSTRYS_TYPE.length;i++)
				{
					out.print("<option value="+i);
					if(wcobj.getIndustrys()==i)
					{
						out.print(" selected ");
					}
					out.print(">"+WestracClue.INDUSTRYS_TYPE[i]);
					out.print("</option>");
				}
			%>
			</select>
	</td>
    </tr>
     <tr>
      <td align="right"><span id="btid">*</span>&nbsp;购买人名称：</td>
      <td><input type="text" name="clientname" value="<%=Entity.getNULL(wcobj.getClientname()) %>">&nbsp;（公司名称或机主姓名）</td>
    </tr>
     <tr> 
      <td align="right"><span id="btid">*</span>&nbsp;联系人姓名：</td>
      <td><input type="text" name="contactname" value="<%=Entity.getNULL(wcobj.getContactname()) %>"></td>
    </tr>
     <tr>
      <td align="right">&nbsp;公司电话：</td>
      <td><input type="text" name="phone" value="<%=Entity.getNULL(wcobj.getPhone()) %>"></td>
    </tr>
     <tr>
      <td align="right"><span id="btid">*</span>&nbsp;移动电话：</td>
      <td><input type="text" name="clientmobile" value="<%=Entity.getNULL(wcobj.getClientmobile()) %>"></td>
    </tr>
     <tr>
      <td align="right"><span id="btid">*</span>&nbsp;购买人所在地：</td>
      <td>	<script>mt.city("city0","city1",null,"<%=wcobj.getCity() %>");</script></td>
    </tr>
     <tr>
      <td align="right">预计购买日期：</td>
      <td>
        <input id="buytime" name="buytime" size="7"  value="<%if(wcobj.getBuytime()!=null)out.print(Entity.sdf.format(wcobj.getBuytime())); %>"  style="cursor:pointer" readonly="readonly" onClick="new Calendar().show('formwc.buytime');"> 
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('formwc.buytime');" />
        </td>
    </tr>
     <tr>
      <td align="right">购买需求描述：</td>
      <td><textarea rows="3" cols="50" name="remarks"><%=Entity.getNULL(wcobj.getRemarks()) %></textarea><br>&nbsp;（机型、工作内容、工况等）</td>
    </tr>
  </table>

<br>
  <center> 
 
  <INPUT TYPE="button" ID="submit1" class="edit_button" VALUE="提交" onClick="f_sub();">&nbsp;
  <%
  	if("my".equals(myact))
  	{
  %>
 <INPUT TYPE="button"  VALUE="返回" onclick="parent.ymPrompt.close();">&nbsp;
  <%}else{ %>
  <INPUT TYPE="button"  VALUE="返回" onClick="window.open('<%=nexturl%>','_self');">&nbsp;
  <%} %>
  
</center></form>

