<%@page import="tea.entity.Entity"%>
<%@page import="java.net.URLEncoder"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.csvclub.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.integral.*"%>



<jsp:directive.page import="tea.resource.Common"/><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
Resource r=new Resource();
String memberid =request.getParameter("memberid");

String iprizenameid = teasession.getParameter("iprizenameid");

StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer(" and (membertype=0 or membertype=1 or membertype is null)");//and (linetype=-1 or linetype =1)
String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}

String members = request.getParameter("members");
if(members!=null && members.length()>0)
{

	sql.append(" and member like '%"+members+"%'");
	param.append("&members="+java.net.URLEncoder.encode(members,"UTF-8"));
}
String membername =request.getParameter("membername");
if(membername!=null &&membername.length()>0)
{
	
	sql.append(" and exists (select member from ProfileLayer pl where pl.member=p.member and firstname like "+DbAdapter.cite("%"+membername+"%")+") ");
	param.append("&membername="+URLEncoder.encode(membername,"UTF-8"));
}

String membermobile = request.getParameter("membermobile");
if(membermobile!=null && membermobile.length()>0)
{

	sql.append(" and mobile like '%"+membermobile+"%'");
	param.append("&membermobile="+membermobile);
}


int pos=0;
int size = 10;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos); 
int count=Profile.count(sql.toString());


sql.append(" ORDER BY member desc");
%>
<html>
<base target="tar"/>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js"></SCRIPT>
</head>
<body>
<script>
window.name='tar';

function f_sub(igd,igd2,igd3)
{
	window.returnValue='#'+igd+'#'+igd2+'#'+igd3+'#';
	window.close();
}

</script>
<h1>会员查询选择</h1>

<h2>查询</h2>
   <FORM name=form1 METHOD=get action="<%=request.getRequestURI()%>"  target="tar">
     <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>


<input type=hidden name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>

   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

     <tr>
     <td>用户名：<input type="text" name="members" value="<%=Entity.getNULL(members) %>" /></td>
     <td>会员名称：<input type="text" name="membername" value="<%=Entity.getNULL(membername) %>" /></td>
     <td>会员手机：<input type="text" name="membermobile" value="<%=Entity.getNULL(membermobile) %>" /></td>
     <td><input type="submit" value="查询"/></td>
       </tr>
</table> 

<h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;个会员&nbsp;)

     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
        <td width="1"></td>
		
		<td nowrap>用户名</td>
       <td nowrap>会员名称</td>
        <td nowrap>会员类型</td>
       <td nowrap>会员手机</td>
       
   
       </tr>
     <%
   out.print(iprizenameid);
     java.util.Enumeration enumer = Profile.find(sql.toString(),pos,size);
     if(!enumer.hasMoreElements())
     {
       out.print("<tr><td colspan=6  align=center>暂无记录</td></tr>");
     }
     for(int index=1;enumer.hasMoreElements();index++)
     {
	 
       String member = ((String)enumer.nextElement());
       Profile pobj = Profile.find(member);
       
      
       %>
       <tr onMouseOver="javascript:this.bgColor='#FFFDE4'" onMouseOut="javascript:this.bgColor=''" style="cursor:pointer" onclick="f_sub('<%=member%>','<%=pobj.getFirstName(teasession._nLanguage)%>','<%= pobj.getMobile()%>');">
         <td width=1><input type=checkbox name=checkeid value="<%=member%>" style="cursor:pointer" <%if(iprizenameid!=null && iprizenameid.length()>0 && (member.equals(iprizenameid))){out.println(" checked ");} %>></td>
         <td><%=member%></td>
         <td><%=pobj.getFirstName(teasession._nLanguage)%></td>
         <td><%
         	if(pobj.getMembertype()==0){out.print("普通用户");}else if(pobj.getMembertype()==1){out.print("履友");}
         %></td>
         <td><%=pobj.getMobile()%></td>
      
        
       </tr>
       <%
       }
       %>
       
       <%
       	if(count>size){
       %>
       <tr><td colspan="7" align="right"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%></td></tr>
	<%} %>
</table>

</form>

</body>
</html>



