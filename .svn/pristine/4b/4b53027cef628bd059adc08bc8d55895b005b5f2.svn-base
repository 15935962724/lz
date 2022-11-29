<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.*" %>
<%@ page import="tea.entity.member.*" %>
<%
	Resource r=new Resource("/tea/resource/Genergy");
	Http h=new Http(request,response);
	String url=h.get("nexturl", "/jsp/genergy/Mmembers.jsp");
	
	Profile p=Profile.find(h.get("member"));
	String email="",name="",unit="",position="",pnumber="",ifield="",member="";
	if(Profile.isExisted(h.get("member"))){
		member=p.getMember();
		email=p.getEmail();
		name=p.getName(h.language);
		unit=p.getOrganization(h.language);
		position=p.getTitle(h.language);
		pnumber=p.getMobile();
		ifield=p.getField(h.language);
	}
%>
<html>
<head>
<title></title>
</head>
<body>
<h1 id="hs"><%=r.getString(h.language,"register") %></h1>
<form action="/servlet/EditMember" name="form1" >
<input type="hidden" name="act" value="EditGenergy"/>
<input type="hidden" name="nexturl" value="<%=url%>"/>
<input type="hidden" name="member" value="<%=member %>" />
<input type="hidden" name="membertype" value="17"/>
<table id="tablecenter">
	<tr>
		<td><%=r.getString(h.language, "email") %>:</td>
		<td><input type="text"   name="email" value="<%=email%>"/></td>
	</tr>

	<tr>
		<td><%=r.getString(h.language, "name") %>:</td>
		<td><input type="text"  name="name" value="<%=name%>"/></td>
	</tr>
	<tr>
		<td><%=r.getString(h.language, "unit") %>:</td>
		<td><input type="text"   name="unit" value="<%=unit%>"/></td>
	</tr>
	<tr>
		<td><%=r.getString(h.language, "position") %>:</td>
		<td><input type="text"  name="position" value="<%=position%>"/></td>
	</tr>
	<tr>
		<td><%=r.getString(h.language, "pnumber") %>:</td>
		<td><input type="text"  name="pnumber" value="<%=pnumber%>"/></td>
	</tr>
	<tr>
		<td><%=r.getString(h.language, "ifield") %>:</td>
		<td>
		<%
			for(int i=0;i<Profile.FIELD_EN_TYPE.length;i++){
				out.print("<input type='checkbox' value='"+(i+1)+"' name='ifield' id='ifield"+(i+1)+"'");
				if(ifield!=null&&ifield.indexOf("/"+(i+1)+"/")>=0){
					out.print(" checked ");
				}
				out.print("><label for='ifield"+(i+1)+"'>"+r.getString(h.language, Profile.FIELD_EN_TYPE[i]) +"</label>");
				if((i+1)%5==0){
					out.print("<br>");
				}
			}
		%>
		
		</td>
	</tr>
	<tr><td colspan="2" text-align="center"><input type="submit"   name="fsubmit" value="保存"/></td></tr>
	</table>
	</form>
</body>
</html>