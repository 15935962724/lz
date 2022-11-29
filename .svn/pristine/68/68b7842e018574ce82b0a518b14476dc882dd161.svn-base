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


function add_dept(dept_name)
{
   window.returnValue = dept_name;
   	  window.close();	
}




</SCRIPT>


<body class="bodycolor" onMouseover="borderize_on(event);" onMouseout="borderize_off(event);" onclick="borderize_on1(event);" topmargin="5">
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <thead class="TableControl">
  <th bgcolor="#d6e7ef" align="center">选择人员</th>
</thead>
	 
	<% 
				java.util.Enumeration au_enumers=AdminUsrRole.findByCommunity(teasession._strCommunity,"");
			
		        while(au_enumers.hasMoreElements())
		        {
		           String _member=(String)au_enumers.nextElement();
		         
		           AdminUsrRole au_objs=AdminUsrRole.find(teasession._strCommunity,_member);//用户名id
		              AdminUnit au_obj_temps=AdminUnit.find(au_objs.getUnit());//用户的部门
		              tea.entity.member.Profile pf_objs=tea.entity.member.Profile.find(au_objs.getMember());//用户的真是名字
		             
		               tea.entity.member.Profile pf_obj=tea.entity.member.Profile.find(au_objs.getMember());
						out.print("<option value="+pf_obj.getMember()+">");
						String bumen = "";
						
						if(au_obj_temps.getName()==null )
						{
							bumen = "无部门";
						}else{
							bumen=au_obj_temps.getName();
						}
		               out.print("<tr class=\"TableControl\"><td id=unitlist nowrap class=\"menulines\" align=\"center\" onclick=\"add_dept('"+au_objs.getMember()+","+pf_obj.getLastName(1)+pf_obj.getFirstName(1)+"');\" style=\"cursor:hand\">"+"["+bumen+"]"+pf_obj.getLastName(1)+pf_obj.getFirstName(1)+"</td></tr>");
		        }
				  	
				  
				
 	
  
%>
</table>



</body>
</html>




