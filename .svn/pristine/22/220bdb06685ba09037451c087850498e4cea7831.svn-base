<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.resource.*" %><%@ page import="tea.ui.*" %><%@ page import="tea.entity.notices.*" %><%@ page import="tea.entity.node.*" %><%@ page import="java.util.*" %>
<%

Resource r=new Resource("/tea/resource/Notices");
TeaSession tea=new TeaSession(request);
if(tea._rv==null){
	  response.sendRedirect("/servlet/StartLogin?node="+tea._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	    return;
}
String noteid="",nname="",address="",ownerName="",generalName="",editname="",content="",time="";//工程编号

java.util.Enumeration en=Notices.fintList(" and node="+tea._nNode, 0, 10);
if(en.hasMoreElements()){
	int nid=(Integer)en.nextElement();
	Notices n=Notices.find(nid);
	if(n.isExsit()){
		noteid=n.getNoteid();
		nname=n.getNname();
		address=n.getAddress();
		ownerName=n.getOwnerName();
		generalName=n.getGeneralName();
		editname=n.getEditname();
		content=n.getContent();
		if(n.getTime()!=null){
			time=Notices.sdf2.format(n.getTime());	
		}
		
	}
	
}else{



if(Category.find(tea._nNode).getCategory()!=99){
	List list=Category.find(tea._strCommunity, 99, 0, Integer.MAX_VALUE);
	Iterator it=list.iterator();
	while(it.hasNext()){
		int nodeid=(Integer)it.next();
		Node node=Node.find(nodeid);
		if(node.getType()==1){
			tea._nNode=node._nNode;
			break;
		}
	}
}
}
String nextUrl="";
if(request.getParameter("nextUrl")!=null){
	nextUrl=request.getParameter("nextUrl");
}
%>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> --%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=r.getString(tea._nLanguage, "EditNotices") %></title>
<link href="/res/<%=tea._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript" ></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script type="text/javascript">
	
</script>
</head>
<body>
<h1><%=r.getString(tea._nLanguage, "EditNotices") %></h1>
<form  name="form1" action="/servlet/EditNotices" onSubmit="return submitText(this.ProjectName, '<%=r.getString(tea._nLanguage, "ProjectNameIsNull") %>')"  target="_ajax"> 
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nextUrl" value="<%=nextUrl%>"/>
<input type="hidden" name="node" value="<%=tea._nNode %>" />

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr >
    <td nowrap align="right" ><%=r.getString(tea._nLanguage, "ProjectNumber") %>:</TD>
    <td nowrap ><input type="TEXT"   name="ProjectNumber" value="<%=noteid%>"></td>
  </tr>
  <tr id="">
    <td nowrap align="right" ><span id="btid">*</span><%=r.getString(tea._nLanguage, "ProjectName") %>:</TD>
    <td nowrap><input type="TEXT"   name="ProjectName" value="<%=nname%>"></td>
  </tr>
  <tr id="">
    <td nowrap align="right" ><%=r.getString(tea._nLanguage, "ProjectAddresss") %>:</TD>
    <td nowrap><input type="TEXT"   name="ProjectAddresss" value="<%=address%>"></td>
  </tr>
  <tr id="">
    <td nowrap align="right" ><%=r.getString(tea._nLanguage, "OwnerName") %>:</TD>
    <td nowrap><input type="TEXT" name="OwnerName"   value="<%=ownerName%>"></td>
  </tr>
 <tr id="">
    <td nowrap align="right"><%=r.getString(tea._nLanguage, "PackageName") %>:</TD>
    <td nowrap><input type="TEXT"  name="PackageName" value="<%=generalName%>"></td>
  </tr>
  <tr id="">
    <td nowrap align="right"><%=r.getString(tea._nLanguage, "EditPerson") %>:</TD>
    <td nowrap><input type="TEXT"    name="EditPerson" value="<%=editname%>"></td>
  </tr>
  
	<tr id="EditReport_10">
    <td nowrap align="right"><%=r.getString(tea._nLanguage, "Text")%>:</TD>
    <td nowrap>

      <textarea style="display:none" name="content" rows="12" cols="90" class="edit_input"><%=content%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=tea._strCommunity%>" width="740" height="300" frameborder="no" scrolling="no"></iframe>

    </td>
  </tr>
  


  <tr id="">
    <td nowrap align="right"><%=r.getString(tea._nLanguage, "ReleaseTime") %>:</TD>
    <td nowrap>
		<input id="datestime" name="vtime" size="7"  value="<%=time %>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.vtime');"> 
  <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.vtime');" />
    
 	</td>
  </tr>
   
 
</table>

  
  <span id="submitshow">
  <input id="submit1" class="edit_button" value="<%=r.getString(tea._nLanguage, "Save") %>" onclick="" type="submit">&nbsp;
  <input name="reset" value="<%=r.getString(tea._nLanguage, "Back") %>" onclick="window.open('<%=nextUrl %>','_self');" type="button">
</span>

</form>
</body>
</html>