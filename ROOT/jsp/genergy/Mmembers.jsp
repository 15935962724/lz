<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.entity.*" %>
<%@ page import="java.util.*" %>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.db.*" %>

<%
	Http h=new Http(request);
    
    if(h.member<1){
    	response.sendRedirect("/servlet/StartLogin?node="+h.node);
    	return;
    }
    Resource r=new Resource("/tea/resource/Genergy");
    StringBuffer sp=new StringBuffer(" and (locking is null or locking<>1)  and  member not in ( SELECT  distinct member FROM AdminUnitSeq )");
    StringBuffer sb=new StringBuffer();
    int size =h.getInt("size", 10);
    int pages=h.getInt("pages", 0);
    int pid=h.getInt("id", 132403);
    sb.append("?id="+pid);
    String email=h.get("email","");
    if(email.length()>0){
    	sp.append(" and email like ").append(DbAdapter.cite("%"+email+"%"));
    	sb.append("&email=").append(email);
    }
    String name=h.get("name","");
    if(name.length()>0){
    	sp.append(" and member in  (select member from profilelayer where  firstname like  ").append(DbAdapter.cite("%"+name+"%")).append(" )  ");
    	sb.append("&name=").append(name);
    }

    sb.append("&size="+size);
    sb.append("&pages=");
    
    int count=Profile.countByCommunity(h.community, sp.toString());
    
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<script type="text/javascript" src="/tea/tea.js"></script>
<script src="/res/<%=h.community %>/cssjs/community.js" type="text/javascript" defer="defer"></script>
<link href="/res/<%=h.community %>/cssjs/community.css" type="text/css" rel="stylesheet">
<script type="text/javascript">
	function f_delete(member){
		if(confirm('<%=r.getString(h.language,"ays")%>?')){
			sendx("/jsp/admin/edn_ajax.jsp?act=Genergydelete&member="+encodeURIComponent(member),function(data){
				 if(data.trim()=='true'){
					 alert("<%=r.getString(h.language,"success")%>!");
					 location.reload();
				 }
			});
		}
	}
</script>
</head>
<body>
<h1><%=r.getString(h.language,"mm") %></h1>
<form name="tform" action="?">
<input type="hidden" name="id" value="<%=pid%>"/>

<table id="tablecenter" cellspacing="0"">
	<tr>
		<td><%=r.getString(h.language, "email") %>:</td>
		<td><input type="text" value="<%=email %>" name="email"/></td>
		<td><%=r.getString(h.language, "name") %>:</td>
		<td><input type="text" value="<%=name %>" name="name"     /></td>
	</tr>
	<tr><td colspan="4"  align='center'><input type="submit"  value="<%=r.getString(h.language,"sub")%>"/></td></tr>
</table>
</form>

<h2><%=r.getString(h.language, "mls") %></h2>
<table id="tablecenter" cellspacing="0"">
<tr>
	<td><%=r.getString(h.language,"name") %></td>
	<td><%=r.getString(h.language,"unit") %></td>
	<td><%=r.getString(h.language,"position") %></td>
	<td><%=r.getString(h.language,"pnumber") %></td>
	<td><%=r.getString(h.language,"ifield") %></td>
	<td><%=r.getString(h.language,"RegistrationTime") %></td>
	<td><%=r.getString(h.language,"WhethertoActivate") %></td>
	<td><%=r.getString(h.language,"email") %></td>
	<td><%=r.getString(h.language,"operating") %></td>
</tr>
<%
	  Enumeration e=Profile.find(h.community, sp.toString()+" order by profile desc", pages, size);
	  if(e.hasMoreElements()){
		  while(e.hasMoreElements()){
		  RV  rv=(RV)e.nextElement();
		   Profile p=new Profile(rv.toString());
		   StringBuffer field=new StringBuffer("");
		   if(p.getField(h.language)!=null&&p.getField(h.language).indexOf("/")>=0){
			   String[]  fields=p.getField(h.language).split("/");
			   for(int i=0;i<fields.length;i++){
				   if(fields[i].trim().length()>0){
					     int id=Integer.parseInt(fields[i]);
				   		field.append(r.getString(h.language, Profile.FIELD_EN_TYPE[id-1])+";");
				   }
			   }
		   }
			String mobile=p.getMobile();
		   String validate=p.isValidate()?"已激活":"未激活";
		  out.print("<tr>");
		  out.print("<td>"+p.getName(h.language)+"</td>");
		  out.print("<td>"+p.getOrganization(h.language)+"</td>");
		  out.print("<td>"+p.getTitle(h.language)+"</td>");
		  out.print("<td>"+mobile+"</td>");
		  out.print("<td>"+field.toString()+"</td>");
		  out.print("<td>"+p.getTimeToString()+"</td>");
		  out.print("<td>"+validate+"</td>");
		  out.print("<td>"+p.getEmail()+"</td>");
		  out.print("<td><a href='/jsp/genergy/EditGenergyInfo.jsp?member="+p.getMember()+"'>"+r.getString(h.language, "edit")+"</a><a href='javascript:f_delete(\""+p.getMember()+"\");'>"+r.getString(h.language, "delete")+"</a></td>");
		  out.print("</tr>");
		  }
		  if(count>size){
			  out.print("<td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, request.getRequestURI()+sb.toString(), pages, count,size));
				
		  }
	  }else{
		  out.print("<tr><td colspan='10'>"+r.getString(h.language, "Norecord")+"!</td></tr>");
	  }
%>
</table>
</body>
</html>