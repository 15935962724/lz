<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.*" %>
<%@include file="/jsp/Header.jsp" %>
<%
r.add("/tea/resource/fun");
int strid=Integer.parseInt(request.getParameter("id"));
if(request.getMethod().equals("POST"))
{
  tea.entity.admin.SFAccount af_obj=tea.entity.admin.SFAccount.find(strid);
  int act=Integer.parseInt(request.getParameter("act"));
  String name=request.getParameter("name");
  boolean type=Integer.parseInt(request.getParameter("menutype"))!=0;
  int sequence=Integer.parseInt(request.getParameter("sequence"));
   switch(act)
   {
     case 1://添加兄弟
     tea.entity.admin.SFAccount.create(name,type,sequence,af_obj.getFather(),node.getCommunity(),teasession._nLanguage);
     break;
     case 2://添加子
     tea.entity.admin.SFAccount.create(name,type,sequence,strid,node.getCommunity(),teasession._nLanguage);
     break;
     case 3://修改
     af_obj.set(name,type,sequence,af_obj.getFather(),node.getCommunity(),teasession._nLanguage);
     break;
     case 4://删除
     af_obj.delete();
     strid=af_obj.getFather();
     break;
     //case 5://复制
    // tea.entity.admin.SFAccount.clone(strid,Integer.parseInt(teasession.getParameter("clone")),node.getCommunity(),teasession.getParameter("sonclone")!=null);
   }
  response.sendRedirect(request.getRequestURI()+"?node="+teasession._nNode+"&id="+strid);
  return;
}
int root=SFAccount.getRootId(teasession._strCommunity);
if(strid==0)strid=root;

SFAccount af_obj=SFAccount.find(strid);
String name=af_obj.getName(teasession._nLanguage);
int sequence=af_obj.getSequence();
boolean type=af_obj.isType();

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT language="JavaScript">
function sub1()
{
	if((document.fun.name.value=='<%=name%>') )
	{
		alert("<%=r.getString(teasession._nLanguage, "CannotAddHomonymyManage")%>");
		return false;
	}
          fun.act.value="1";
return submitText(fun.name,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')&&submitInteger(fun.sequence,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>');
}

function sub2()
{
  if((document.fun.name.value=='<%=name%>') &&(document.fun.menutype.value=='<%=(type?"1":"0")%>') )
  {
    alert("<%=r.getString(teasession._nLanguage, "CannotAddHomonymyManage")%>");
    return false;
  }else
  fun.act.value="2";
  return submitText(fun.name,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')&&submitInteger(fun.sequence,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>');
}

function sub5()
{
  fun.act.value="5";
  return        submitInteger(fun.clone,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>');
}
</SCRIPT>


</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "户头管理")%></h1>
<div id="head6"><img height="6" alt=""></div>

<form id="fun" name="fun" action="/jsp/admin/schoolfinance/EditSFAccount.jsp" method="POST">
  <input type="hidden" value="1" name="act"/>
  <input id="id" type="hidden" name="id" value="<%=strid%>">
  <table border="0" cellPadding="0" cellSpacing="0"  id="tablecenter">
    <tr>
      <td>
        <%=r.getString(teasession._nLanguage, "CurrentlyChoiceMenu")%>：</td>
      <td>
        <%=strid%>:<%=name%>
      </td>
    </tr>
    <tr>
      <td  ><%=r.getString(teasession._nLanguage, "Name")%>：</td>
      <td  >
        <input name="name" type="text" id="name"   value="<%=name%>" size="35"></td>
    </tr>
    <tr>
      <td  height="22" ><%=r.getString(teasession._nLanguage, "Type")%>：</td>
      <td  ><SELECT id="menutype" name="menutype">
          <OPTION value="0" selected <%--if strlx=0 then%>selected<%end if--%>><%=r.getString(teasession._nLanguage, "Folder")%></OPTION>
          <OPTION value="1" <%if(type)out.print(" selected ");%>><%=r.getString(teasession._nLanguage, "Item")%></OPTION>
        </SELECT>
        </td>
    </tr>
    <tr>
      <td  ><%=r.getString(teasession._nLanguage, "Sequence")%>：</td>
      <td  >
        <input name="sequence"  type="text" value="<%=sequence%>" size="35">
      </td>
    </tr>
    <tr>
      <td height="40" colspan="4" align="middle"  >
<%
if(strid!=root)
{
  out.print("<input id='Submit1' type='submit' onclick='fun.act.value=1;return sub1();' value='"+r.getString(teasession._nLanguage, "AddMateMenu")+"' name='1'>");
}
if(!type)
{
  out.print("<input id='Submit2' type='submit' onclick='fun.act.value=2;return sub2();' value='"+r.getString(teasession._nLanguage, "AddSubmenu")+"' name='2'>");
}
%>
        <input id="Submit2" type="submit" onclick="fun.act.value=3;return submitText(fun.name,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>');" value="<%=r.getString(teasession._nLanguage, "Edit")%>" name="3">
        <input id="Submit2" type="submit" onclick="fun.act.value=4;return confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>');" value="<%=r.getString(teasession._nLanguage, "Delete")%>" name="4"></td>
    </tr>
  </TABLE>
<%--
<br>
<%=r.getString(teasession._nLanguage, "CBClone")%>:
<input type="text" name="clone"/>
<input  id="CHECKBOX" type="CHECKBOX" name="sonclone" id="sonclone"/>
<label for="sonclone"><%=r.getString(teasession._nLanguage, "IncSubmenu")%></label>
<input type="submit" onClick="return sub5()" value="<%=r.getString(teasession._nLanguage, "Submit")%>"/>
  <br>
<br>--%>
  </form>
<div id="head6"><img height="6" src="about:blank"></div>



   <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>



