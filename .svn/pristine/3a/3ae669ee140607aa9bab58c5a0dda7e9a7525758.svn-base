<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%
request.setCharacterEncoding("UTF-8");


TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/Photography");
String nexturl = teasession.getParameter("nexturl");//request.getRequestURI()+"?"+request.getContextPath();
if(nexturl!=null && nexturl.length()>0){}else{
	nexturl = request.getRequestURI()+"?"+request.getContextPath(); 
}
String memberorder = teasession.getParameter("memberorder");

if(memberorder!=null && memberorder.length()>0){
	
}else{
	memberorder = "1-1-1-1";
}
MemberOrder moobj = MemberOrder.find(memberorder);
String mname ="";
if(moobj.getMember()!=null && moobj.getMember().length()>0){
	mname = moobj.getMember();
}else{
	mname = teasession._rv._strR;
}

Profile pobj = Profile.find(mname);
String act = teasession.getParameter("act");



%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>

<body bgcolor="#ffffff" >
<script>
function f_submit()
{
	if(form1.firstname.value==''){
		mt.show('<%=r.getString(teasession._nLanguage,"Pleasefillin")%><%=r.getString(teasession._nLanguage,"5477641348")%>!');
		form1.firstname.focus();
		return false;
	}
	if(form1.telephone.value==''){
		mt.show('<%=r.getString(teasession._nLanguage,"Pleasefillin")%><%=r.getString(teasession._nLanguage,"3156528885")%>!');
		form1.telephone.focus();
		return false;
	}
	if(form1.Country.value=='AA'){
		mt.show('<%=r.getString(teasession._nLanguage,"Pleaseselect")%><%=r.getString(teasession._nLanguage,"8438735291")%>!');
		form1.Country.focus();
		return false;
	}
	if(form1.address.value==''){
		mt.show('<%=r.getString(teasession._nLanguage,"Pleasefillin")%><%=r.getString(teasession._nLanguage,"1475973085")%>!');
		form1.address.focus();
		return false;
	}
	if(form1.member_audit.value==-1){
		mt.show('请选择审核状态!');
		form1.member_audit.focus();
		return false;
	}
	
	
	
}
</script>
<h1><%=r.getString(teasession._nLanguage,"6284508238") %></h1>
<form method="POST" action="/servlet/EditMemberType" name="form1" onSubmit="return f_submit();" >
<input type="hidden" name="memberorder" value="<%=memberorder %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>
<input type="hidden" name="act" value="EditMember"/>
<input type="hidden" name="nexturl" value="<%=nexturl %>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <tr>
   <td align="right"><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage,"2969876073") %>：</td>
   <td><%=mname %></td>
  </tr>
  <tr>
   <td align="right"><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage,"5477641348") %>：</td>
   <td><%=pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage)%>
   <input type="hidden" name="firstname" value="<%=pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage)%>"/>
   </td>
  </tr>
  <tr>
   <td align="right"><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage,"3156528885") %>：</td>
   <td><input type="text" name="telephone" value="<%=pobj.getTelephone(teasession._nLanguage)%>"/></td>
  </tr>
  <tr> 
   <td align="right"><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage,"0966659109") %>：</td>
   <td> <input type="radio" name="sex" value="1" <%if(!pobj.isSex()){out.print(" checked ");} %> >&nbsp;<%=r.getString(teasession._nLanguage,"4872416891") %>&nbsp;&nbsp;
   <input type="radio" name="sex" value="0" <%if(pobj.isSex()){out.print(" checked ");} %> >&nbsp;<%=r.getString(teasession._nLanguage,"1050228713") %></td>
  </tr>
  <tr>
   <td align="right"><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage,"8438735291") %>：</td>
   <td><%=new tea.htmlx.CountrySelection("Country",teasession._nLanguage,pobj.getCountry(teasession._nLanguage))%></td>
  </tr>

 <tr>
   <td align="right"><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage,"1475973085") %>：</td>
   <td><input type="text" name="address" value="<%=pobj.getAddress(teasession._nLanguage)%>"/></td>
 </tr>

<%if("member_audit".equals(teasession.getParameter("act"))){ %>
       <tr>
        <td align="right"><font color="red">*</font>&nbsp;审核状态：</td>
        <td><select name="member_audit">
        	<option value="-1">-评论状态-</option>
        	<option value="1" <%if(moobj.getVerifg()==1)out.print(" selected "); %>>-审核通过-</option>
        	<option value="2" <%if(moobj.getVerifg()==2)out.print(" selected "); %>>-拒绝会员-</option>
        	
        </select></td>
      </tr>
      <%}else{//编辑使用
    	  out.print("<input type=hidden name=member_audit value=0>"); 
      } %>

 

</table>
<div style="text-align:center;margin-top:10px;">
	<input type="submit" value="<%=r.getString(teasession._nLanguage,"0718244641") %>">&nbsp;<input type="button" value="<%=r.getString(teasession._nLanguage,"1315968283") %>"  onClick="javascript:history.back()"></div>
</form>

</body>
</html>
