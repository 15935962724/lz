<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/node/type/category/EditCategory");

AccessMember am=AccessMember.find(node._nNode, teasession._rv._strV);
if(!node.isCreator(teasession._rv)&&am.getPurview()<1)
{
  response.sendError(403);
  return;
}
Category category = Category.find(teasession._nNode);

String c=am.getCategory();

int i = node.getOptions1();
int type= category.getCategory();

int template = category.getTemplate();
int clewtype = category.getClewtype();
String clewcontent = category.getClewcontent();
//审核权限
int i2 = category.getPermissions();

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script language="javascript" src="/tea/load.js" type="text/javascript"></script>
</head>

<body>
<h1><%=r.getString(teasession._nLanguage, "Type")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<form name="form1" METHOD=POST action="/servlet/EditCategory" >
<input type='hidden' name="node" value="<%=teasession._nNode%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td><%=r.getString(teasession._nLanguage, "Category")%>:</td>
  <td>
 	<!--  <%=new tea.htmlx.TypeSelection(node.getCommunity(),teasession._nLanguage, type,true)%> -->
 	 <select name="type">
 	 <%
 	 String sp_category = AccessMember.find(teasession._nNode,teasession._rv._strV).getCategory();
 	CLicense cobj=CLicense.find(node.getCommunity());
 	if(sp_category!=null && sp_category.length()>0)
 	{
	 	 for(int ci=1;ci<sp_category.split("/").length;ci++)
	 	 {
	 		 
	 		 int cc = 0;
	 		 if(sp_category.split("/")[ci]!=null && sp_category.split("/")[ci].length()>0)
	 		 {
	 			 cc = Integer.parseInt(sp_category.split("/")[ci]);
	 		 }
	 		 
	 		 if(cobj.getType()!=null && cobj.getType().indexOf("/"+cc+"/")!=-1)//判断社区中是否勾选
	 		 {
		 		 out.print("<option value ="+cc);
		 		 if(cc==type)
	 			 {
	 				 out.println(" selected ");
	 			 }
		 		 if(cc<1024)
		 		 {
		 			
		 			out.print(">"+r.getString(teasession._nLanguage,Node.NODE_TYPE[cc]));
		 		 }else
		 		 {
		 			Dynamic d=Dynamic.find(cc);
		 			
		 			 out.print(">"+d.getName(teasession._nLanguage));
		 		 }
		 		 out.print("</option>");
	 		 }
	 	 }
 	}
 	// System.out.println(AccessMember.find(teasession._nNode,teasession._rv._strV).getType());
 	 	//for(int i=1;i<)
 	 //	out.print("<option value= ");
 	 %>
 	 </select>
  </td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage, "Options")%>:</td>
  <td>
    <input id="CHECKBOX" type="CHECKBOX" name=CategoryOOpen value=null <%=getCheck((i & 1) != 0)%>><%=r.getString(teasession._nLanguage, "CategoryOOpen")%>&nbsp;
    <input id="CHECKBOX" type="CHECKBOX" name=CategoryONeedGrant value=null <%=getCheck((i & 2) != 0)%>><%=r.getString(teasession._nLanguage, "CategoryONeedGrant")%>&nbsp;
    <input id="CHECKBOX" type="CHECKBOX" name=CategoryOContributors value=null <%=getCheck((i & 4) != 0)%>><%=r.getString(teasession._nLanguage, "是否投稿使用")%>&nbsp;
    <input id="CHECKBOX" type="CHECKBOX" name=CategoryORole value=null <%=getCheck((i & 8) != 0)%>><%=r.getString(teasession._nLanguage, "是否内容权限使用")%>&nbsp;
    (注：只有新闻资讯能使用投稿)
  <br>
    <input id="CHECKBOX" type="CHECKBOX" name=Permissions1 value=null <%=getCheck((i2 & 1) != 0)%>><%=r.getString(teasession._nLanguage, "是否需要一级初审")%>&nbsp;
    <input id="CHECKBOX" type="CHECKBOX" name=Permissions2 value=null <%=getCheck((i2 & 2) != 0)%>><%=r.getString(teasession._nLanguage, "是否需要一级终审")%>&nbsp;
    <input id="CHECKBOX" type="CHECKBOX" name=Permissions3 value=null <%=getCheck((i2 & 4) != 0)%>><%=r.getString(teasession._nLanguage, "是否需要二级初审")%>&nbsp;
    <input id="CHECKBOX" type="CHECKBOX" name=Permissions4 value=null <%=getCheck((i2 & 8) != 0)%>><%=r.getString(teasession._nLanguage, "是否需要二级终审")%>&nbsp;
 
    <%=Mark.toHtml(teasession._strCommunity,1,node.getMark())%>
  </td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage, "提示框选项")%>:</td>
  <td><input  id="CHECKBOX" type="CHECKBOX" name=clewtype value="1" <%if(clewtype!=0)out.print("checked=true");%>><%=r.getString(teasession._nLanguage, "是否弹出提示框")%></td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage,"提示内容") %>:</td>
  <td><textarea name="clewcontent"  rows="8" cols="70" class="edit_input"><%if(clewcontent!=null)out.print(clewcontent); %></textarea></td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage,"Template")%>:</td>
  <td><input type=button class="edit_button" onClick="window.open('/jsp/template/Templates.jsp?node=<%=teasession._nNode%>');" value="<%=r.getString(teasession._nLanguage, "New")%>"></td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td>
    <input type="submit" name="GoBack" id="edit_GoBack" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>" >
    <input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
  </td>
</tr>
</table>
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
