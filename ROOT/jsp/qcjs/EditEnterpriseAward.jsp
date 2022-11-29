<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.Entity"%><%@page import="tea.entity.qcjs.*" %>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);


String nexturl = teasession.getParameter("nexturl");

int eaid = 0;
if(teasession.getParameter("eaid")!=null && teasession.getParameter("eaid").length()>0){
	eaid = Integer.parseInt(teasession.getParameter("eaid"));
}
EnterpriseAward eaobj = EnterpriseAward.find(eaid);

if("POST".equals(request.getMethod())&&"EditEnterpriseAward".equals(teasession.getParameter("act")))//添加修改
{
	String name = teasession.getParameter("name");
	String address = teasession.getParameter("address");
	String natures = teasession.getParameter("natures");
	String legal = teasession.getParameter("legal");
	String contact = teasession.getParameter("contact");
	String description = teasession.getParameter("description");
	String remarks = teasession.getParameter("remarks");
	int eatype = 0;
	if(teasession.getParameter("eatype")!=null && teasession.getParameter("eatype").length()>0)
	{
		eatype = Integer.parseInt(teasession.getParameter("eatype"));
	}
	
	if(eaid>0){
		eaobj.set(name,address,natures,legal,contact,description,remarks,eatype);
	}else{
		EnterpriseAward.create(name,address,natures,legal,contact,description,remarks,new Date(),teasession._strCommunity,eatype);
	}
	
	out.print("<script  language='javascript'>alert('报名成功!');window.location.href='" + nexturl +"';</script> ");
	return;
}else if("EnterpriseAward-DELETE".equals(teasession.getParameter("act"))){
	
	String value[] = request.getParameterValues("eaid");
    
    if(value != null)
    {
    	String next_str ="删除成功";
    	//boolean f = false;
        for(int index = 0;index < value.length;index++)
        {
            int i = Integer.parseInt(value[index]);
            EnterpriseAward mobj = EnterpriseAward.find(i);
         	mobj.delete();
        }
		out.print("<script  language='javascript'>alert('" + next_str + "');window.location.href='" + nexturl + "&id="+teasession.getParameter("id")+"';</script> ");
	
		return;
    }
	
}
%>

<script type="text/javascript">
function f_sub()
{
	if(form1.name.value==''){
		alert('请填写企业名称!');
		form1.name.focus();
		return false;
	}

}

</script>

<div id="head6"><img height="6" src="about:blank"></div>
<form action="?" name="form1" method="POST" onsubmit="return f_sub();" >
<input type="hidden" name="nexturl" value="<%=nexturl %>"/>  
<input type="hidden" name="act" value="EditEnterpriseAward"/>
<input type="hidden" name="eaid" value="<%=eaid %>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  
  <%
  int eatype = 0;
	if(teasession.getParameter("eatype")!=null && teasession.getParameter("eatype").length()>0)
	{
		eatype = Integer.parseInt(teasession.getParameter("eatype"));
	}
  
  
  	if(eatype==0){
  		
  %>
  <tr id=tableonetr>
	       <td nowrap align="right"><font color="red">*</font>&nbsp;第几届：</td>
	       <td nowrap><input type="text" name="eatype" value="<%=eaobj.getEatype() %>" maxlength="50">
	       <br>
	       注：第一届 就是“1”，第二届 就是“2”
	       </td>
	      
    </tr>
  <%}else
  {
	  out.print("<input type=hidden name=eatype value="+eatype+">");	  
  }
	  %>
  
    <tr id=tableonetr>
	       <td nowrap align="right"><font color="red">*</font>&nbsp;企业名称：</td>
	       <td nowrap><input type="text" name="name" value="<%=Entity.getNULL(eaobj.getName()) %>" maxlength="50"></td>
	       <td nowrap align="right">企业地址：</td>
	       <td nowrap><input type="text" name="address" value="<%=Entity.getNULL(eaobj.getAddress()) %>" maxlength="150"></td>
    </tr>
    <tr id=tableonetr> 
	       <td nowrap align="right">企业性质：</td>
	       <td nowrap colspan="3"><input type="text" name="natures" value="<%=Entity.getNULL(eaobj.getNatures()) %>" maxlength="50"></td>
    </tr>
     <tr id=tableonetr>
	       <td nowrap align="right">企业法人：</td>
	       <td nowrap><input type="text" name="legal" value="<%=Entity.getNULL(eaobj.getLegal()) %>" maxlength="50"></td>
	       <td nowrap align="right">联系方式：</td>
	       <td nowrap><input type="text" name="contact" value="<%=Entity.getNULL(eaobj.getContact()) %>" maxlength="50"></td>
    </tr>
     <tr id=tableonetr>
	       <td nowrap align="right">企业描述：</td>
	       <td nowrap colspan="3"><textarea rows="4" cols="60" name="description"><%=Entity.getNULL(eaobj.getDescription()) %></textarea></td>
    </tr>
         <tr id=tableonetr>
	       <td nowrap align="right">备 注：</td>
	       <td nowrap colspan="3"><textarea rows="4" cols="60" name="remarks"><%=Entity.getNULL(eaobj.getRemarks()) %></textarea></td>
	       
    </tr>

  </table>
  <br/>
  <input type="submit" value="　提交　"/>&nbsp;<input type="reset" value="　清空　"> &nbsp;

