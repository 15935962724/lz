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
String community=teasession._strCommunity;
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
}


function add_all()
{
	var ul=document.all('unitlist');
	if(!ul.length)
	 ul.onclick();
	else
	for(var i=0;i<ul.length;i++)
	{
	  ul[i].onclick();
	}
	window.close();
}

</SCRIPT>


<body class="bodycolor" onMouseover="borderize_on(event);" onMouseout="borderize_off(event);" onclick="borderize_on1(event);" topmargin="5">
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <thead class="TableControl">
  <th bgcolor="#d6e7ef" align="center">选择部门</th>
</thead>

	<%
	String member = teasession._rv.toString();//当前用户


         AdminUsrRole au_obj=AdminUsrRole.find(teasession._strCommunity,member);
         if(au_obj.isExists())
         {


       			  String sql = " and unit="+au_obj.getUnit()+" and classes="+au_obj.getClasses()+" and creator = '"+member+"'";
        		 if(au_obj.getUnit()!=0 && au_obj.getClasses()==0)
            	{
            		 AdminUnit obj_au=  AdminUnit.find(au_obj.getUnit());
            		out.print("<tr class=\"TableControl\"><td id=unitlist nowrap class=\"menulines\" align=\"center\" onclick=\"add_dept('"+obj_au.getName()+"');\" style=\"cursor:hand\">"+obj_au.getName()+"</td></tr>");
            	}
            	if(au_obj.getClasses()==1)
            	{
            		 AdminUnit obj_au=  AdminUnit.find(au_obj.getUnit());
            		out.print("<tr class=\"TableControl\"><td id=unitlist nowrap class=\"menulines\" align=\"center\" onclick=\"add_dept('"+obj_au.getName()+"');\" style=\"cursor:hand\">"+obj_au.getName()+"</td></tr>");
            	}
				if(au_obj.getClasses()==2)
				{
					sql ="";

				  java.util.Enumeration enumer = AdminUnit.findByCommunity(teasession._strCommunity,sql);
				  %>
				   <tr id="TableControl">
     						<td class="menulines" onclick="javascript:add_all();" style="cursor:hand" align="center">以下全部添加</td>
					</tr>
				  <%
				  while(enumer.hasMoreElements())
				  {
                    AdminUnit obj_au=(AdminUnit)enumer.nextElement();
                    int id=obj_au.getId();
				  	out.print("<tr class=\"TableControl\"><td id=unitlist nowrap class=\"menulines\" align=\"center\" onclick=\"add_dept('"+obj_au.getName()+"');\" style=\"cursor:hand\">"+obj_au.getName()+"</td></tr>");
				  }
				}
 		 }

 %>
</table>
<a href="#" onclick="javascript:window.close();">关闭</a>

</body>
</html>




