<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"  %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.Item" %><%@ page import="tea.ui.TeaSession" %><%request.setCharacterEncoding("UTF-8");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");
String nexturl=request.getParameter("nexturl");

int item=Integer.parseInt(request.getParameter("item"));
if(request.getMethod().equals("POST"))
{
  int states=Integer.parseInt(request.getParameter("states"));
  int editgroup=Integer.parseInt(request.getParameter("editgroup"));

  String personnel=request.getParameter("personnel");
  String supermanager=request.getParameter("supermanager");
  String manager=request.getParameter("manager");

  Item obj=Item.find(item);
  obj.setEg(states,editgroup,personnel,supermanager,manager);

  response.sendRedirect("/jsp/info/Succeed.jsp?nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));
  return;
}


Resource r=new Resource();


Item obj=Item.find(item);




%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function defaultfocus()
{
  fch(form1.editgroup.value);
  form1.editgroup.focus();
}
function fcheck()
{
  /*
  var value="/";
  for(var index=0;index<form1.toList.length;index++)
  {
    value+=form1.toList.options[index].value+"/";
  }
  form1.personnel.value=value;
  */
}
function func_insert(select2,select1)
{
  //select2= eval('document.forms[0].fromList');
  //select1= eval('document.forms[0].toList');
  if(select2.selectedIndex!=-1)
  {
    option_text=select2.options[select2.selectedIndex].text;
    option_value=select2.options[select2.selectedIndex].value;

    found=0;

    for (i=0; i< select1.options.length; i++)
    {
      if(select1.options[i].value==option_value)
      {
        return;
      }
    }

    if(found==0)
    {
      var my_option = document.createElement("OPTION");
      my_option.text=option_text;
      my_option.value=option_value;


      if(select1.selectedIndex==-1)
      {
        select1.options[select1.length]=(my_option);
        new_index=select1.options.length-1;
      }else
      {
        new_index=select1.selectedIndex+1;
        select1.add(my_option,new_index);
      }

      select1.selectedIndex=new_index;
      select2.remove(select2.selectedIndex);
    }
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

    select1.remove(select1.selectedIndex);
  }
}


function func_up(select2,select1)
{

  if(select1.selectedIndex!=-1 && select1.selectedIndex!=0)
  {
    option_text=select1.options(select1.selectedIndex).text;
    option_value=select1.options(select1.selectedIndex).value;

    var my_option = document.createElement("OPTION");
    my_option.text=option_text;
    my_option.value=option_value;

    new_index=select1.selectedIndex-1;
    select1.remove(select1.selectedIndex);
    select1.add(my_option,new_index);
    select1.selectedIndex=new_index;
  }
}


function func_down(select2,select1)
{

  if(select1.selectedIndex!=-1 && select1.selectedIndex!=(select1.options.length-1))
  {
    option_text=select1.options(select1.selectedIndex).text;
    option_value=select1.options(select1.selectedIndex).value;

    var my_option = document.createElement("OPTION");
    my_option.text=option_text;
    my_option.value=option_value;

    new_index=select1.selectedIndex+1;
    select1.remove(select1.selectedIndex);
    select1.add(my_option,new_index);
    select1.selectedIndex=new_index;
  }
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>下达编制组</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form name="form1" action="" method="post" onSubmit="return fcheck();">
<input type=hidden name="item" value="<%=item%>"/>
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr><td>项目计划号</td>
         <TD><%=obj.getCode()%></TD>
</tr>
       <tr>

        <td>项目名称</td>
         <td nowrap><%=obj.getName()%></td>
       </tr>
       <input type="hidden" name="states" value="2">
       <!--tr>
         <td>项目状态</td>
         <td nowrap><select name="states">
		 <option value=1 SELECTED>初始化
 		 <option value=2 <%if(obj.getStates()==2)out.print(" SELECTED ");%>>下达编辑组
           </select>         </td>
       </tr-->
	   <tr>
         <td>编制组</td>
         <td nowrap><select name="editgroup" id="editgroup" onChange="fch(this.value);" style="width:200px">
           <%
  int adminrole_id_supermanager=tea.entity.admin.AdminRole.findByName(Item.ROLE_SUPERMANAGER,community);//"编制组高级管理员"
  int adminrole_id_manager=tea.entity.admin.AdminRole.findByName(Item.ROLE_MANAGER,community);//"编制组管理员"
  int adminrole_id_personnel=tea.entity.admin.AdminRole.findByName(Item.ROLE_PERSONNEL,community);//"编制组项目成员"

StringBuffer script=new StringBuffer();
java.util.Enumeration enumer  = tea.entity.admin.AdminUnit.findByCommunity(community," AND other3=1");
while(enumer.hasMoreElements())
{
  AdminUnit obj_au=(AdminUnit)e.nextElement();
  int id=obj.getId();

  out.print("<OPTION VALUE="+id);
  if(id==obj.getEditgroup())
  out.print(" SELECTED ");
  out.print(" >"+obj_au.getName());

  script.append("case '"+id+"':\r\n");


  DbAdapter dbadapter = new DbAdapter();
  try
  {
    dbadapter.executeQuery("SELECT DISTINCT aur.member,aur.role FROM AdminUsrRole aur,Profile p WHERE aur.member=p.member AND p.adminunit="+id+" AND (aur.role LIKE " + dbadapter.cite("%/" + adminrole_id_supermanager + "/%")+" OR aur.role LIKE " + dbadapter.cite("%/" + adminrole_id_manager + "/%")+" OR aur.role LIKE " + dbadapter.cite("%/" + adminrole_id_personnel + "/%")+")");
    while (dbadapter.next())
    {
      String member=(dbadapter.getString(1));
      String role=(dbadapter.getString(2));
      if(role.indexOf("/"+adminrole_id_personnel+"/")!=-1)
      {
        script.append("form1.fromList.options[form1.fromList.length]=new Option('"+member+"','"+member+"');");
      }else
      if(role.indexOf("/"+adminrole_id_supermanager+"/")!=-1)
      {
        script.append("form1.supermanager.options[form1.supermanager.length]=new Option('"+member+"','"+member+"');");
      }else
      if(role.indexOf("/"+adminrole_id_manager+"/")!=-1)
      {
        script.append("form1.manager.options[form1.manager.length]=new Option('"+member+"','"+member+"');");
      }
    }
  } catch (Exception ex)
  {
    ex.printStackTrace();
  } finally
  {
    dbadapter.close();
  }

  script.append("break;\r\n");
}
           %></select>
         </td>
       </tr>
	   <tr style="display:none"><td><!--编制组高级管理员-->主编单位管理员</td>
             <td><select name="supermanager" style="width:150px;">
             <%
             /*
             int adminrole_id_supermanager=tea.entity.admin.AdminRole.findByName(Item.ROLE_SUPERMANAGER,community);//"编制组高级管理员"
             if(adminrole_id_supermanager>0)
             {
               java.util.Enumeration enumer_supermanager= tea.entity.admin.AdminUsrRole.findByRole(adminrole_id_supermanager);
               while(enumer_supermanager.hasMoreElements())
               {
                 String profile_id=(String)enumer_supermanager.nextElement();
                 out.print("<option value="+profile_id+" >"+profile_id);
               }
             }
             */
             %>
	     </select>
	   </td></tr>
	   <tr style="display:none"><td><!--编制组管理员-->参编单位管理员</td><td><select name="manager" style="width:150px;border:0px;">
             <%/*
             int adminrole_id_manager=tea.entity.admin.AdminRole.findByName(Item.ROLE_MANAGER,community);//"编制组管理员"
             if(adminrole_id_manager>0)
             {
               java.util.Enumeration enumer_manager= tea.entity.admin.AdminUsrRole.findByRole(adminrole_id_manager);
               while(enumer_manager.hasMoreElements())
               {
                 String profile_id=(String)enumer_manager.nextElement();
                 out.print("<option value="+profile_id+" >"+profile_id);
               }
             }*/
             %>
	     </select></td></tr>
       <tr style="display:none">
         <td>参加人员</td>
         <td nowrap>

		 <table cellSpacing="0" borderColorDark="#ffffff" cellPadding="0" align="left" borderColorLight="#666666" border="1">
          <tr align="center">
            <td width="140" valing=middle>选定人员</td>
            <td width="50"  valing=middle>&nbsp;</td>
            <td width="140"  valing=middle>备选人员</td>
          </tr>
          <tr>
            <td width="140" height="182" valing=bottom>
			<input type=hidden name=personnel value="">
			<select name="toList"  size="15" style="border-width:0px; WIDTH: 140px; HEIGHT: 100px"  ondblclick="func_delete(form1.fromList,form1.toList);" idth="100%" >
             <%
             if(obj.getPersonnel()!=null)
             {
               String str[]=obj.getPersonnel().split("/");
               for(int index=1;index<str.length;index++)
               out.println("<option value="+str[index]+" >"+str[index]);
             }
             %>
                        </select>
			  </td>
            <td width="50" align="center"  valing=middle><input onClick="func_insert(form1.fromList,form1.toList);" type="button" value=" ← " id=button1 name=button1>
              <br>
              <input  onClick="func_delete(form1.fromList,form1.toList);" type="button" value=" → " id=button2 name=button2>
              <br>
              <input onClick="func_up(form1.fromList,form1.toList);" type="button" value=" ↑ " id=button3 name=button3>
              <br>
              <input onClick="func_down(form1.fromList,form1.toList);" type="button" value=" ↓ " id=button4 name=button4>
            </td>
            <td  valing=middle width="140">
              <select ondblclick="func_insert(form1.fromList,form1.toList);" width="100%" style="WIDTH: 140px; HEIGHT: 100px" size="15" name="fromList" >
              </select>
            </td>
          </tr>
        </table>

		 </td>
       </tr>
       <tr>
         <td>&nbsp;</td>
         <td nowrap>
           <input type="submit" name="Submit" value="提交">
           <input type="reset" name="Submit2" value="重置" onClick="defaultfocus();">
           <input type="button" value="返回" onClick="history.back();">
         </td>
       </tr>
  </table>
</form>
<script type="">

function fch(value)
{
  while(form1.fromList.length>0 || form1.supermanager.length>0 || form1.manager.length>0)
  {
    form1.fromList.options[0]=null;
    form1.supermanager.options[0]=null;
    form1.manager.options[0]=null;
  }
  switch(value)
  {
    <%=script.toString()%>
  }

  for(index=0;index<form1.toList.length;index++)
  {
    for(i=0;i<form1.fromList.length;i++)
    {
      if(form1.toList[index].value==form1.fromList[i].value)
      {
        form1.fromList.options[i]=null;
      }
    }
  }

}
</script>



<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

