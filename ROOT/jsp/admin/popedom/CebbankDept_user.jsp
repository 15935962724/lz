<%@page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/Header.jsp" %>
<%request.setCharacterEncoding("UTF-8");

String community=node.getCommunity();
if(request.getMethod().equals("POST"))
{
  String member=request.getParameter("yhm");
  tea.entity.member.Profile pf_obj=null;
  if(member!=null)//新建后台用户
  {
    if( tea.entity.member.Profile.isExisted(member))
    {
      out.print(new tea.html.Script("alert('用户已经存在.');history.back();"));
      return;
    }
    pf_obj= tea.entity.member.Profile.create(member,community,request.getParameter("mm"));
//    pf_obj.setCommunity(community);
  }else
  {
    member=request.getParameter("member");
    pf_obj=tea.entity.member.Profile.find(member);
  }
  int unitid=Integer.parseInt(request.getParameterValues("UnitId")[request.getParameterValues("UnitId").length-1]);
  String act=request.getParameter("act");
  tea.entity.admin.AdminUsrRole aur_obj=tea.entity.admin.AdminUsrRole.find(member,community);
  if("del".equals(act))
  {
   // aur_obj.delete();//删除角色
    aur_obj.setRole("/");
//    pf_obj.setAdminUnit(0);
  }else
  if("clear".equals(act))
  {
    pf_obj.setPassword("");
  }else
  {
    pf_obj.setSex(Integer.parseInt(request.getParameter("xb"))!=0);
    pf_obj.setPassword(request.getParameter("mm"));
    pf_obj.setFirstName(request.getParameter("zsxm"),teasession._nLanguage);
    pf_obj.setLastName(request.getParameter("lastname"),teasession._nLanguage);
    pf_obj.setEmail(request.getParameter("email"));


    StringBuffer role_sb=new StringBuffer("/");
    String toList[]=  request.getParameterValues("toList");
    if(toList!=null)
    for(int index=0;index<toList.length;index++)
    {
      role_sb.append(toList[index]+"/");
    }
    aur_obj.setRole(role_sb.toString());
    //aur_obj.setBrand(role_sb.toString());
    aur_obj.setUnit(unitid);
  }
  response.sendRedirect(request.getRequestURI()+"?UnitId="+unitid);
  return ;
}
r.add("/tea/resource/deptuser");

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!--#include file="../public.inc"-->
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT language="JavaScript">
function CheckForm()
{
  if(!submitMemberid(document.form1.yhm,"用户名不正确,格式:长度最小2位,内容只能是 数字，字母，下划线(_)和减号(-)"))
  {
    return (false);
  }

  if(document.form1.zsxm.value=="")
  {
    alert("<%=r.getString(teasession._nLanguage,"InvalidName")%>");
    document.form1.zsxm.focus();
    return (false);
  }

return(submitMemberid(document.form1.yhm,'<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>')&&submitIdentifier(document.form1.mm,'<%=r.getString(teasession._nLanguage, "InvalidPassword")%>')&&submitEmail(document.form1.email,'<%=r.getString(teasession._nLanguage, "InvalidEmailAddress")%>'));

}
function func_insert(select2,select1)
{
  //select2= eval('document.forms[0].fromList');
  //select1= eval('document.forms[0].toList');
  if(select2.selectedIndex!=-1)
  {
    option_text=select2.options(select2.selectedIndex).text;
    option_value=select2.options(select2.selectedIndex).value;

    found=0;
    /*
    for (i=0; i< select1.options.length; i++)
    {
      alert(select1.options(i).value);
      if(select1.options(i).value==option_value)
      {
        found=1;
        break;
      }
    }
    */
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

			</SCRIPT>

</head>
<BODY onLoad="document.form1.zsxm.focus();">
<h1><%=r.getString(teasession._nLanguage, "UserManage")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>


 <%  int unitid=Integer.parseInt(request.getParameter("UnitId"));
                                String member=request.getParameter("UsrId");
                                String zsxm=null,mm=null,lastname=null,email=null;
                                boolean xb=true;
                                if(member!=null)
                                {
                                  tea.entity.member.Profile pf_obj=tea.entity.member.Profile.find(member);
                                  zsxm=pf_obj.getFirstName(teasession._nLanguage);
                                  lastname=pf_obj.getLastName(teasession._nLanguage);
                                  email=pf_obj.getEmail();
                                  xb=pf_obj.isSex();
                                  mm=pf_obj.getPassword();
                                }else
                                {
                                  mm=zsxm=lastname=email="";
                                }

                                String unitname;
                                if(unitid==0)
                                {
                                  unitname=r.getString(teasession._nLanguage, "NoDept");
                                }else
                                {
                                  tea.entity.admin.AdminUnit au_obj=tea.entity.admin.AdminUnit.find(unitid);
                                  unitname=au_obj.getName();
                                }
	%>
<h2><%=r.getString(teasession._nLanguage, "AddUser")%>（<%=unitname%>）</h2>

<form name="form1"   method="post">
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
  <table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
       <tr>
        <td noWrap class="huititable" ><%=r.getString(teasession._nLanguage, "ID")%>：</td>
        <td  noWrap class="huititable">
          <input class="SmallInput" maxLength="20" name="yhm" value=<%if(member!=null){out.print(member); out.print(" disabled ");}%>>
          <input type=hidden value="<%=member%>" name=member>
&nbsp; </td>
        <td  noWrap class="huititable"><%=r.getString(teasession._nLanguage, "Sex")%>：</td>
        <td  noWrap class="huititable"><select class="BigSelect" name="xb">
          <option value="1" selected><%=r.getString(teasession._nLanguage, "Man")%></option>
          <option value="0" <%if(!xb)out.print(" selected ");%>><%=r.getString(teasession._nLanguage, "Woman")%></option>
        </select></td>

      </tr>
      <tr>
        <td  noWrap class="huititable"><%=r.getString(teasession._nLanguage, "FirstName")%>：</td>
        <td  noWrap class="huititable"><input class="SmallInput" maxLength="10" size="10" name="zsxm" value="<%=zsxm%>">
&nbsp; </td>
        <td><%=r.getString(teasession._nLanguage, "LastName")%>:</td>
<td>
<input type="TEXT" class="edit_input"  name=lastname VALUE="<%=lastname%>" SIZE=20 MAXLENGTH=20>
        </td>
           </tr>
        <tr>
        <td><%=getNull(r.getString(teasession._nLanguage, "EmailAddress"))%>:</td>
        <td><input type="TEXT" class="edit_input"  name=email VALUE="<%=email%>"  MAXLENGTH=40></td>
        <td  noWrap class="huititable"><%=r.getString(teasession._nLanguage, "Dept")%>：</td>
        <td  noWrap class="huititable"><select class="BigSelect" name="UnitId">
        <option value="0">-------------</option>
          <%java.util.Enumeration au_enumer=tea.entity.admin.AdminUnit.findByCommunity(node.getCommunity(),"");
									/*strQuery = "select UnitId,UnitName from tabunit"
									set rsu=server.CreateObject ("ADODB.Recordset")
									rsu.CursorLocation = 3
									rsu.Open strQuery , conn
									while not rsu.EOF*/
                                                            while(au_enumer.hasMoreElements())
                                                            {
                                                              int id=((Integer)au_enumer.nextElement()).intValue();
                                                          tea.entity.admin.AdminUnit au_obj_temp=tea.entity.admin.AdminUnit.find(id);
								%>
          <option value="<%=id%>" <%if(unitid==id)out.print(" selected ");%>>
          <%--=rsu("UnitName").Value--%>
          <%=au_obj_temp.getName()%></option>
          <%}
								%>
        </select></td>

      </tr>
      <tr>
        <td  noWrap class="huititable"><%=r.getString(teasession._nLanguage, "Password")%>：</td>
        <td colspan="3"  noWrap class="huititable"><input class="SmallInput" type="password" maxLength="10" size="10" name="mm" value=<%=mm%>>
&nbsp; </td>

      </tr>

      <tr align="center">
        <td colSpan="6" noWrap class="TableControl" valing=middle>          <input class="BigButton" title="" type="submit" onClick="return CheckForm();" value="<%=r.getString(teasession._nLanguage,"Add")%>" name="add">
        </td></tr>

  </TABLE>
  <h2><%=r.getString(teasession._nLanguage,"UserManage")%> （<%=unitname%>）
 </h2>
  <input type="hidden" name="act" value=""/>

    <table  cellSpacing="0" cellPadding="0" width="100%" border="0" id="tablecenter">
     <TR id="tableonetr">
          <td valing=middle><%=r.getString(teasession._nLanguage, "ID")%></td>
          <td valing=middle><%=r.getString(teasession._nLanguage, "Username")%></td>
          <td valing=middle><%=r.getString(teasession._nLanguage, "Dept")%></td>
          <td valing=middle><%=r.getString(teasession._nLanguage, "operation")%></td>
      </tr>
        <%
java.util.Enumeration pfbyu_enumer=tea.entity.admin.AdminUsrRole.findByUnit(unitid,community);
for(int iCount=1;pfbyu_enumer.hasMoreElements();iCount++)
{
	String member_temp=(String)pfbyu_enumer.nextElement();
	//tea.entity.admin.AdminUsrRole aur=tea.entity.admin.AdminUsrRole.find(id_temp);
	Profile pf_obj_temp=Profile.find(member_temp);
	if(unitid!=0||  community.equals( pf_obj_temp.getCommunity()))
	{
%>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
          <td ><%=member_temp%></td>
          <td ><%=pf_obj_temp.getFirstName(teasession._nLanguage)%>　<%=pf_obj_temp.getLastName(teasession._nLanguage)%>　</td>
          <td ><%=unitname%></td>
          <td ><A href="<%=request.getRequestURI()%>?node=<%=teasession._nNode%>&UsrId=<%=member_temp%>&UnitId=<%=unitid%>"><%=r.getString(teasession._nLanguage, "Edit")%></A>&nbsp;&nbsp;
            <%if(!member_temp.equals("admin")){%>
            <A href="#"  onclick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){form1.member.value='<%=member_temp%>';form1.yhm.disabled=true;form1.act.value='del';form1.submit();}"><%=r.getString(teasession._nLanguage, "Delete")%></A>
            <%}%>
            <A href="#"  onclick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmClearPassword")%>')){form1.member.value='<%=member_temp%>';form1.yhm.disabled=true;form1.act.value='clear';form1.submit();}"><%=r.getString(teasession._nLanguage, "ClearPassword")%></a> </td>
        </tr>
        <%
                                }}
				%>



    </TABLE>
    <br>
    <div id="head6"><img height="6" src="about:blank"></div>
    <br>
    <!--input name="" type="button" value="<%=r.getString(teasession._nLanguage, "Add")%>" onclick="window.open('adduser.jsp?node=<%=teasession._nNode%>&UnitId=<%=unitid%>','','height=170px,width=400px,left=250,top=150,resizable=no,scrollbars=no,toolbar=no,location=no,directories=no,status=no,menubar=no');"-->

  <br>
</FORM>
<br/> <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</BODY>
</html>



