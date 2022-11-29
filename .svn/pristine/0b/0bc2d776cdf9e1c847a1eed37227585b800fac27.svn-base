<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.entity.*" %>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.ui.*" %>
<%@ page import="java.io.*" %>
<%
	Http h=new Http(request);
	Resource r=new Resource();
	Node node=Node.find(h.node);
	Subject subject= Subject.find(h.node, h.language);
	String name="",keywords="",abstracts="",unit="",team="",main="",attach="";
	if(subject.isExists()&&node.getType()==109){
		name=node.getSubject(h.language);
		keywords=node.getKeywords(h.language);
		abstracts=node.getDescription(h.language);
		unit=subject.getUnit();
		team=subject.getMembers();
		main=node.getText(h.language);
		attach="";
	}
	
%>
<html>
<head>
<title><%=r.getString(h.language, "Edit")+r.getString(h.language, "Subjects")%></title>
<script src="/tea/tea.js" type="text/javascript" ></script>
<script src="/tea/mt.js" type="text/javascript" ></script>
<script src="/tea/mt.upload.js" type="text/javascript"></script>
<script src="/res/<%=h.community %>/cssjs/community.js" type="text/javascript" defer="defer"></script>
<link href="/res/<%=h.community %>/cssjs/community.css" type="text/css" rel="stylesheet">

</head>
<body onLoad="f_editor();">
<form  name="form1"  enctype="multipart/form-data"  action="/EditSubject" method="post"  onsubmit="return submitText(this.name,'<%=r.getString(h.language, "Projectnamecannotbeempty") %>')">
<input type="hidden"  name="repository" value="subject">
<input type="hidden"  name="act" value="edit">
<input  type="hidden" name="url"  value="<%=h.get("nexturl","")%>"/>
<input type="hidden"  name="node" value="<%=h.node%>">
<table  border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
		<td><%=r.getString(h.language, "SubjectName") %>:</td>
		<td><input type="text" size="70" maxlength="255" class="edit_input"   name="name"   value="<%=name%>"/>
		</td>
	</tr>
	<tr>
		<td><%=r.getString(h.language, "Keywords") %>:</td>
		<td><input type="text" name="keywords" class="edit_input"  size="70" maxlength="255"  value="<%=keywords%>"/></td>
	</tr>
	<tr>
		<td><%=r.getString(h.language, "Abstract") %>:</td>
		<td><textarea name="abstracts" rows="8" cols="70" class="edit_input"><%=abstracts%></textarea></td>
	</tr>
	<tr>
		<td><%=r.getString(h.language, "SubjectUnit") %>:</td>
		<td><input type="text" name="unit"   value="<%=unit%>"  size="50"/></td>
	</tr>
	<tr>
		<td><%=r.getString(h.language, "MembersOfTheTeam") %>:</td>
		<td><input type="text" name="team"   value="<%=team%>"  size="50"/></td>
	</tr>
	<tr>
		<td><%=r.getString(h.language, "MainBody") %>:</td>
		 <td nowrap><input  id="radio" type="radio" name=TextOrHtml value=0 checked="checked">
      <%=r.getString(h.language, "TEXT")%>
      <input  id="radio" type="radio" name=TextOrHtml value=1 <%if((node.getOptions() & 0x40) != 0)out.print(" CHECKED ");%> >HTML

      <input  id="CHECKBOX" type="checkbox" name="nonuse" value="checkbox" onClick="f_editor(this)"><label for="nonuse"><%=r.getString(h.language, "NonuseEditor")%></label>
        <input type="checkbox" name="srccopy"/>源网站的图片贴入本地
        </td>
	</tr>
	<tr>
		<td colspan="2">
      
      <textarea style="display:none" name="content" rows="12" cols="90" class="edit_input"><%=MT.f(main)%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=node.getCommunity()%>" width="740" height="300" frameborder="no" scrolling="no"></iframe>
		</td>
	</tr>
	<tr>
		<td><%=r.getString(h.language, "Attachment") %>:</td>
		<td><input type="button"  id="add"   value="添加附件"/>
			<table  style="width:auto;">
				<tbody>
				<%
				 String[] arr=MT.f(node.getFile(h.language),"|").split("[|]");
		        if(arr.length>1)
		        {
		          String[] narr=node.getFileName(h.language).split("[|]");
		          for(int z=1;z<arr.length;z++)
		          {
		            out.print("<tr><td>"+Utils.f(arr[z])+"<td align='right'>"+MT.f(new File(application.getRealPath(arr[z])).length()/1024F)+" KB");
		            out.print("<td><input type='hidden' name='attach' value='"+arr[z]+"'><input type='hidden' name='attachName' value='"+narr[z]+"'>");
		            out.print("<td><a href=javascript:; onclick=up.del(this)><img src='/tea/image/public/del2.gif' width='10' /></a>");
		          }
		        }
				%>
				</tbody>
			</table>
		</td>
	</tr>
	<tr><td colspan="2" align="center"><input type="submit"  value="<%=r.getString(h.language, "Submit")%>"/></td></tr>
</table>
<script type="text/javascript">
	mt.upload(document.getElementById("add"));
</script>
</form>
</body>
</html>