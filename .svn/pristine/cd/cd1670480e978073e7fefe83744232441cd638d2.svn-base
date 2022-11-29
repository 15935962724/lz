<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.Entity"%>
<%@page import="tea.entity.member.ProfileConsulting"%>
<%@page import="java.util.Enumeration"%>
<%@page import="tea.entity.member.Profile"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.ui.TeaSession" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);



String code = teasession.getParameter("code");


Profile pobj = Profile.find(Profile.getMember(code));

if(!pobj.isExisted(pobj.getMember()))
{
	//如果不存在	
	
	out.println("您的会员编号不存在，请确认是否正确");
	return;
}

StringBuffer sql=new StringBuffer(" and member="+DbAdapter.cite(code)+" and community = ").append(DbAdapter.cite(teasession._strCommunity));
StringBuffer param=new StringBuffer();

param.append("&code=").append(code);
param.append("&id=").append(teasession.getParameter("id"));

int pos=0,size = 20;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);

int count = ProfileConsulting.count(teasession._strCommunity,sql.toString());





sql.append(" order by times desc ");







%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

</head>

<script>
	function f_sub()
	{
		if(form1.text.value=='')
		{
			alert("咨询信息不能为空");
			form1.text.focus();
			return false;
		}
		
		 sendx("/jsp/admin/edn_ajax.jsp?act=WestracMemberConsul&text="+encodeURIComponent(form1.text.value)+"&code="+form1.code.value,
				 function(data)
				 {

				   if(data!=''&&data.length>1)//如果有这个用户  则写入Cookie .trim()
				   { 
						
					   window.location.reload();
				   }
				 }
				 );
	}
</script>
<body>

<h1>会员咨询记录</h1>
<form action="?" method="post" name="form1">
<input type="hidden" name="code" value="<%=code %>">
<input type="hidden" name="id" value="<%=teasession.getParameter("id") %>">
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <tr>
      <td colspan="2" >会员编号：<%=code %>&nbsp;&nbsp;会员用户名：<%=pobj.getMember() %>&nbsp;&nbsp;会员姓名：<%=pobj.getFirstName(teasession._nLanguage) %></td>
     
    </tr>
	<tr>
      <td align="right">会员咨询：</td>
      <td>
      		<textarea rows="3" cols="60" name="text"></textarea>&nbsp;
      		<input type="button" value="提交" onclick="f_sub();">
       </td>
    </tr>
    </table>

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

    <%
    	Enumeration e = ProfileConsulting.find(teasession._strCommunity,sql.toString(),pos,size);
	    if(!e.hasMoreElements())
	    {
	        out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
	    }
    	while(e.hasMoreElements())
    	{
    		int cid = ((Integer)e.nextElement()).intValue();
    		ProfileConsulting pcobj = ProfileConsulting.find(cid);
    %>
     <tr>
      <td align="right"><%=pcobj.getText() %></td>
      <td><%=Entity.sdf2.format(pcobj.getTimes()) %></td>
    </tr>
 <%} %>
 
  <% 
  	if(count>size){
  %>
  <tr><td colspan="20"  align="center" style="padding-right:5px;"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%></td></tr>
<%} %>
    
  </table>
</form>


</body>
</html>

