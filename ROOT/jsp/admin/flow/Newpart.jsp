<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=request.getParameter("community");

String text=request.getParameter("text");

String hidden=request.getParameter("hidden");
%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>

<style>
.menulines{}
</style>

<SCRIPT>
<!--

var menu_enter="";

function borderize_on(e)
{
 color="#708DDF";
 source3=event.srcElement;

 if(source3.className=="menulines" && source3!=menu_enter)
    source3.style.backgroundColor=color;
}

function borderize_on1(e)
{
 for (i=0; i<document.all.length; i++)
 { document.all(i).style.borderColor="";
   document.all(i).style.backgroundColor="";
   document.all(i).style.color="";
   document.all(i).style.fontWeight="";
 }

 color="#003FBF";
 source3=event.srcElement;

 if(source3.className=="menulines")
 { source3.style.borderColor="black";
   source3.style.backgroundColor=color;
   source3.style.color="white";
   source3.style.fontWeight="bold";
 }

 menu_enter=source3;
}

function borderize_off(e)
{
 source4=event.srcElement;

 if(source4.className=="menulines" && source4!=menu_enter)
    {source4.style.backgroundColor="";
     source4.style.borderColor="";
    }
}

var v="";
function add_dept(dept_name)
{
  if(v!="")
    v=v;
  v=v+","+dept_name;
 //alert(dept_name);
 //return false;
   window.returnValue = v;
   window.close();
}


//function add_all()
//{
//	var ul=document.all('unitlist');
//	if(!ul.length)
//	 ul.onclick();
//	else
//	for(var i=0;i<ul.length;i++)
//	{
//	  ul[i].onclick();
//	}
//	window.close();
//}
function add_all()
{
 // var ul=document.all('unitlist');
 var hidden="";
 var check=document.all('checkbox2');
 var sunsk= document.all('checkbox1');
  for(var i=0;i<check.length;i++)
  {
    if(check[i].checked)
    {
      if(v!="")
      v=v;
      v=v+"/"+check[i].value;
      hidden=hidden+"/"+sunsk[i].value;
    }
  }
  window.dialogArguments.<%=text%>.value=v;
  window.dialogArguments.<%=hidden%>.value=hidden;
  //window.returnValue = v;
  window.close();
}
function selectAll(form,check)
{
  for(index=0;index<form.checkbox2.length;index++)
  {
    if(form.checkbox2[index].type=='checkbox')
    {
      form.checkbox2[index].checked=check.checked;
    }
  }
}
</SCRIPT>


<body class="bodycolor">
<form action="" name="form2">

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <thead class="TableControl">
  <tr><td align="center" colspan="3" >选择角色</td></tr>
</thead>

	<%
	String member = teasession._rv.toString();//当前用户
	//out.print(AdminUsrRole.find("DEV","webmaster").getRole());//取出当前会员的角色

 java.util.Enumeration adme=AdminRole.findByCommunity(teasession._strCommunity,-1);
 while(adme.hasMoreElements())
 {
   int adid=((Integer)adme.nextElement()).intValue();
   AdminRole adobj = AdminRole.find(adid);
   // out.print(adobj.getName()+"<br>");
   //out.print("<tr class=\"TableControl\"><td id=unitlist nowrap class=\"menulines\" align=\"center\" onclick=\"add_dept('"+adobj.getName()+"/"+adid+"/');\" style=\"cursor:hand\">"+adobj.getName()+"</td></tr>");

   %>
   <input type="hidden" value="<%=adid%>" name="checkbox1">
     <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >

	     <td id=unitlist nowrap class="menulines" align="center" ><input type="checkbox" name="checkbox2" value="<%=adobj.getName()%>" style="cursor:hand"></td>
	     <td><%=adobj.getName()%></td>
      </tr>

   <%
   }
 %>
 <tr>
       <td id=unitlist nowrap class="menulines" align="center"><input type="CHECKBOX" onclick="selectAll(form2,this)" value="0" style="cursor:hand">全选</td>
       <td><input name="button"  type="button" value="提交" onclick="add_all()" /></td>
  </tr>

</table>

</form>
</body>
</HTML>




