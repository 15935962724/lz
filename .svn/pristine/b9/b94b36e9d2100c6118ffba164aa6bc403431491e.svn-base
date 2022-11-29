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
String community=teasession._strCommunity;
java.util.Date date = new java.util.Date();


if(teasession._rv==null)
{
	out.println("您还没有登录，没有权限查看，请登录");
	return;
}

  
 

 
String adminrole = teasession.getParameter("adminrole");
StringBuffer sql=new StringBuffer(" and type =37 and community = ").append(DbAdapter.cite(community));
StringBuffer param=new StringBuffer();

String nexturl =  request.getRequestURI()+"?"+request.getQueryString()+"&adminrole="+adminrole;

param.append("?community="+teasession._strCommunity);
param.append("&id=").append(request.getParameter("id"));
param.append("&adminrole=").append(adminrole);


//姓名
String subject=teasession.getParameter("subject");
if(subject!=null && subject.length()>0)
{
	subject=subject.trim();
  
  sql.append(" and  exists (select node from NodeLayer nl where n.node=nl.node and nl.subject like "+DbAdapter.cite("%"+subject+"%")+" ) ");
  param.append("&subject=").append(URLEncoder.encode(subject,"UTF-8")); 
}
 

//所在区县
String city=teasession.getParameter("city");
if(city!=null && city.length()>0)
{
    sql.append(" and  exists (select member from ProfileLayer pl where p.member=pl.member and pl.city  = "+DbAdapter.cite(city)+" ) ");
    param.append("&city=").append(city);

}

//判断有权限的用户 
if("role".equals(adminrole))
{
	AdminUsrRole arobj = AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());
	StringBuffer sp = new StringBuffer("/");
	
	for(int i=0;i<Volunteer.CITYS.length;i++)
	{
		sp.append(Volunteer.CITYS[i]).append("/");
	}
	
	StringBuffer sp2 = new StringBuffer();
	int cc = 0;
	for(int i=1;i<arobj.getRole().split("/").length;i++)
	{
		int adid = Integer.parseInt(arobj.getRole().split("/")[i]);
		AdminRole auobj = AdminRole.find(adid);
		if(sp.toString().indexOf("/"+auobj.getName()+"/")!=-1)
		{
			cc++;
			if(cc==1)
			{
				sp2.append(" and ( e.city = ").append(Event.getCITYS(auobj.getName()));
			}else  
			{
				sp2.append(" or e.city = ").append(Event.getCITYS(auobj.getName()));
			}
			
			 
			
		
			 
		}
	} 
	if(cc>=1)
	{
		sp2.append(")"); 
	}
	
	sql.append(" and  exists (select node from Event e where e.node=n.node "+sp2.toString()+" ) ");
   
	if(cc==0)
	{
		out.println("您没有权限查看，请联系管理员");
		return;
	}
	
}

 




int pos=0,size = 20;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);

int count = Node.count(sql.toString());



String members = teasession.getParameter("members");
if(teasession.getParameter("delete")!=null && teasession.getParameter("delete").length()>0)
{
  if(teasession.getParameter("delete").equals("1"))
  {
    String memberd = teasession.getParameter("memberd");
    Volunteer.delete(memberd);
    Profile.delete(memberd);
    
  }
}



%>
<html>
<HEAD>
  <link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <link href="/tea/CssJs/Home.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
  <style>
#bodyvl h1{width:1002px;margin-left:0px;}
#bodyvl h2{width:1002px;margin-left:0px;}
#bodyvl #tablecenter{border:1px solid #dfdfdf;width:1002px;margin-bottom:15px;}
</style>
</HEAD>
<body id="bodyvl">
<script type="text/javascript">
function f_delete(igd)
{
	if(confirm('确认删除')){
	  sendx("/jsp/admin/edn_ajax.jsp?act=BjrrocEventdelete&node="+igd,
				 function(data)
				 {

				    alert('信息删除成功');
				    window.location.reload();
				 }
				 );	
	}
}
function f_reg(igd)
{
	var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:630px;dialogHeight:510px;';
	 var url = '/jsp/type/event/BjrrocEventReg.jsp?t='+new Date().getTime()+"&node="+igd;
	 var rs = window.showModalDialog(url,self,y);
	 if(rs==1)
	 {
		 window.location.reload(); 
	 }
}
</script>
<h1>志愿者报名列表</h1>
<form name="form2" action="?" method="POST">
<input type="hidden" name="id" value="<%=request.getParameter("id") %>">
<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter"> 
	<tr>
		<td align="right">活动名称：</td>
		<td><input type="text" name="subject" value="<%=Entity.getNULL(subject) %>"> </td>
	</tr>

  <tr>
  
      <tr><td colspan="10" align="center"><input type="submit" value="查询" /></td></tr>

</table>
</form>
<h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="2"><%=count%></font>&nbsp;个活动&nbsp;)&nbsp;&nbsp;
<input type="button" value="创建活动" onClick="window.open('/jsp/type/event/BjrrocEditEvent.jsp?NewNode=ON&Type=37&node=<%=teasession._nNode%>&nexturl=<%=nexturl%>','_self');">

</h2>

<form name="form1" action="?" method="GET">

<input type="hidden" name="act" >




<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
 <tr id="tableonetr">
 
      <td nowrap>活动名称</td>
      <td nowrap>区域</td>
      <td nowrap>特殊规定 </td>
      <td nowrap>组织者联系方式</td>
      
      <td nowrap>活动时间</td>
     
      <td>操作</td>
     

</tr>
<%

java.util.Enumeration eu = Node.find(sql.toString(),pos,size);
if(!eu.hasMoreElements())
{
	out.print("<tr><td colspan=20 align=center>暂无记录</td></tr>");
}
for(int i=0;eu.hasMoreElements();i++)
{
	
 	int nid = ((Integer)eu.nextElement()).intValue();
  	Node nobj = Node.find(nid);
  	Event eobj = Event.find(nid,teasession._nLanguage);

 

  
  %>
 <tr onMouseOver=bgColor="#BCD1E9" onMouseOut=bgColor="">  
    <td nowrap="nowrap"><%=nobj.getSubject(teasession._nLanguage)%></td>
    <td nowrap="nowrap"><%=Event.CITYS[eobj.getCity()] %></td>
    <td nowrap="nowrap"><%=eobj.getPrescribe() %></td>
    <td nowrap="nowrap"><%=eobj.getLinkman() %></td>
    <td nowrap="nowrap"><%=eobj.getTimeToString(eobj.getTimeStart()) %></td>

    <td> 
    
     <input type="button" value="志愿者报名" onClick="f_reg('<%=nid%>');">
    <input type="button" value="编辑" onClick="window.open('/jsp/type/event/BjrrocEditEvent.jsp?node=<%=nid%>&nexturl=<%=nexturl%>','_self');">
      <input type="button" value="删除" onClick="f_delete('<%=nid%>');" >

    </td> 
  </tr>
  <%
  }
  %>
  <% 
  	if(count>size){
  %>
  <tr><td colspan="20"  align="center" style="padding-right:5px;"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%></td></tr>
<%} %>
  </table>
</form>
</body>
</html>
