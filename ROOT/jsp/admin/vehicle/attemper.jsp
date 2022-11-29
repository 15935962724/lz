<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%> 
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>

<%
request.setCharacterEncoding("UTF-8");


response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

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
<SCRIPT language="JavaScript">
function CheckForm()
{
  //alert("SS");
  if(!submitMemberid(document.form1.yhm,"用户名不正确,格式:长度最小3位,内容只能是 数字，字母，下划线(_)和减号(-)"))
  {
    return (false);
  }

  if(document.form1.zsxm.value=="")
  {
    alert("无效名字");
    document.form1.zsxm.focus();
    return (false);
  }
  select1= eval('document.forms[0].toList');
  fld_str="";
  for (i=0; i< select1.options.length; i++)
  {
    select1[i].selected=true;
    //                                          options_value=select1.options(i).value;
    //                                          fld_str+=options_value+",";
  }
/*
  for (i=0; i< form1.toList.options.length; i++)
  {
    form1.toList[i].selected=true;
    //                                          options_value=select1.options(i).value;
    //                                          fld_str+=options_value+",";
  }*/
  //alert(fld_str);
  //document.forms[0].optionsvalue.value= fld_str;
}

function func_insert(select2,select1)
{
  if(select2.selectedIndex!=-1)
  {
    option_text=select2.options[select2.selectedIndex].text;
    option_value=select2.options[select2.selectedIndex].value;

    for (i=0; i< select1.options.length; i++)
    {
      if(select1.options[i].value==option_value)
      {
        return ;
      }
    }


    var my_option = document.createElement("OPTION");
    my_option.text=option_text;
    my_option.value=option_value;

    select1.options[select1.length]=(my_option);

    select1.selectedIndex=select1.length-1;
    select2.options[select2.selectedIndex]=null;
  }
}

function func_delete(select2,select1)
{
  if(select1.selectedIndex!=-1)
  {
    option_text=select1.options[select1.selectedIndex].text;
    option_value=select1.options[select1.selectedIndex].value;
    var my_option = document.createElement("OPTION");
    my_option.text=option_text;
    my_option.value=option_value;
    select2.options[select2.length]=(my_option);

    select1.options[select1.selectedIndex]=null;
  }
}



function mysubmit()
{

   fld_str="";
   for (i=0; i< document.form1.toList.options.length; i++)
   {
      options_value=document.form1.toList.options(i).value;
      fld_str+=options_value+",";
    }
   document.form1.MANAGERS.value=fld_str;
 
   document.form1.submit();
}


</SCRIPT>
<body class="bodycolor" topmargin="5" onload="func_init();">
<h1>指定车辆调度人员</h1>
<div id="head6"><img height="6" src="about:blank"></div>

 <form action="/jsp/admin/vehicle/submit.jsp" method="post" name="form1">
<br> 
<table width="500" border="1" cellspacing="0" cellpadding="3" align="center" bordercolorlight="#000000" bordercolordark="#FFFFFF" class="big">
  <tr bgcolor="#CCCCCC">
    <td align="center"><b>调度人员</b></td>
    <td align="center">&nbsp;</td>
    <td align="center" valign="top"><b>备选人员</b></td>
  </tr>
  <tr>
    <td valign="top" align="center" bgcolor="#CCCCCC">

          <select name="toList"  size="10" multiple style="WIDTH: 140px;"  ondblclick="func_delete(form1.fromList,form1.toList);" width="100%" >
                  <%
    	 java.util.Enumeration en =Attemper.findByCommunity(teasession._strCommunity,"");
    
    	 while(en.hasMoreElements())
    	 {
    	 	String comm = ((String)en.nextElement()).toString();
    	 
    	 	Attemper obj = Attemper.find(comm);
    	 	String a[] = obj.getNames().split(",");
			for(int i=0;i<a.length;i++)
			{
	
		           AdminUsrRole au_obj=AdminUsrRole.find(teasession._strCommunity,a[i]);
		              
		             if(au_obj.isExists())
		             {
		             AdminUnit au_obj_temp=AdminUnit.find(au_obj.getUnit());
		             
			            tea.entity.member.Profile pf_obj=tea.entity.member.Profile.find(a[i]);
						out.print("<option value="+pf_obj.getMember()+">");
						String bumen = "";
						
						if(au_obj_temp.getName()==null )
						{
							bumen = "无部门";
						}else{bumen=au_obj_temp.getName();}
						out.print("["+bumen+"]"+pf_obj.getLastName(1)+pf_obj.getFirstName(1));
						out.print("</option>");
					}
				
			}	
		
    	 	
    	 }
    	 
     %>
                </select></td>
                
              <td width="50" align="center"  valing=middle><input onClick="func_insert(form1.fromList,form1.toList);" type="button" value=" ← " id=button1 name=button1>
                <br>
                <br>
                <br>
                <input  onClick="func_delete(form1.fromList,form1.toList);" type="button" value=" → " id=button2 name=button2>
                <br>
              
              </td>
              
             <td valign="top" align="center" bgcolor="#CCCCCC">
                <select ondblclick="func_insert(form1.fromList,form1.toList);" width="100%" style="WIDTH: 140px; " size="10" name="fromList" >
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
						}else{bumen=au_obj_temps.getName();}
						out.print("["+bumen+"]"+pf_obj.getLastName(1)+pf_obj.getFirstName(1));
						out.print("</option>"); 
		               
		        }
				
		
    	 %>
                </select>
                <script type="">
                for(index=0;index<form1.toList.length;index++)
                {
                  for(i=0;i<form1.fromList.length;i++)
                  {
                    if( form1.toList[index].value==form1.fromList[i].value)
                    {
                      form1.fromList.remove(i);
                    }
                  }
                }
                </script>
              </td>
            </tr>

  <tr bgcolor="#CCCCCC">
    <td align="center" valign="top" colspan="3">
  
      
   <br>
    <input type="hidden" name="MANAGERS" value="">
      <input type="submit" class="BigButton" value="保 存" onclick="return mysubmit(this);">&nbsp;&nbsp;

  
    </td>
  </tr>
</table>
  </form>
</body>


</html>
	


