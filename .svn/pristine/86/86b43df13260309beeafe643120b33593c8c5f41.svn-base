<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.criterion.*" %>
<%@ include file="/jsp/Header.jsp" %>
<%@page import="tea.entity.admin.*" %>
<%request.setCharacterEncoding("UTF-8");


String community=request.getParameter("community");
if(community==null)
community=node.getCommunity();

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
  }else
  {
    member=request.getParameter("member");
    pf_obj=tea.entity.member.Profile.find(member);
  }
  int unitid=Integer.parseInt(request.getParameterValues("UnitId")[request.getParameterValues("UnitId").length-1]);
  String act=request.getParameter("act");
  tea.entity.admin.AdminUsrRole aur_obj=tea.entity.admin.AdminUsrRole.find(community,member);
  if(!aur_obj.isExists())
  {
    tea.entity.admin.AdminUsrRole.create(community,member,"/","/",0,0);
    aur_obj=tea.entity.admin.AdminUsrRole.find(community,member);
  }
  if("del".equals(act))
  {
   // aur_obj.delete();//删除角色
   aur_obj.setRole("/");
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
    pf_obj.setOrganization(request.getParameter("organization"),teasession._nLanguage);
    pf_obj.setJob(request.getParameter("job"),teasession._nLanguage);
    pf_obj.setTelephone(request.getParameter("telephone"),teasession._nLanguage);
    pf_obj.setMobile(teasession.getParameter("mobile"));



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

    int oldunit=Integer.parseInt(request.getParameter("oldunit"));
    tea.entity.criterion.Itemmember itemmember=tea.entity.criterion.Itemmember.find(member,community);
    if(itemmember.isExists())
    {
      itemmember.set(oldunit);
    }else
    {
      tea.entity.criterion.Itemmember.create(member,  community,  oldunit);
    }
  }
  response.sendRedirect(request.getRequestURI()+"?UnitId="+unitid+"&node="+teasession._nNode);
  return ;
}
r.add("/tea/resource/deptuser");

%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT language="JavaScript">
function CheckForm()
{
  //alert("SS");
  if(!document.form1.yhm.disabled && !submitMemberid(document.form1.yhm,"用户名不正确,格式:长度最小3位,内容只能是 数字，字母，下划线(_)和减号(-)"))
  {
    return (false);
  }

  if(document.form1.zsxm.value=="")
  {
    alert("<%=r.getString(teasession._nLanguage,"InvalidName")%>");
    document.form1.zsxm.focus();
    return (false);
  }

  if(!submitEmail(document.form1.email,"无效电子邮箱"))
  {
    return (false);
  }
  if(!submitText(form1.mobile,'无效手机号.'))
  {
    return (false);
  }
  if(!submitText(form1.mm,'无效密码.'))
  {
    return (false);
  }

  select1= document.forms[0].toList;
  if(select1.options.length<1)
  {
    alert("无效角色.");
    select1.focus();
    return (false);
  }
  for (i=0; i< select1.options.length; i++)
  {
    select1[i].selected=true;
  }

}

function func_insert(select2,select1)
{
  if(select2.selectedIndex!=-1)
  {
    option_text=select2.options[select2.selectedIndex].text;
    option_value=select2.options[select2.selectedIndex].value;

    for (i=0; i< select1.options.length; i++)
    {
      if(select1.options(i).value==option_value)
      {
        return ;
      }
    }


    var my_option = document.createElement("OPTION");
    my_option.text=option_text;
    my_option.value=option_value;

    select1.options[select1.length]=(my_option);


    select1.selectedIndex=select1.length-1;
    select2.remove(select2.selectedIndex);
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


  <%
  int unitid=Integer.parseInt(request.getParameter("UnitId"));
  int oldunit=0;
  String member=request.getParameter("UsrId");
  String zsxm=null,mm=null,lastname=null,email=null,organization=null,job=null,telephone=null,mobile=null;
  boolean xb=true;
  if(member!=null)
  {
    tea.entity.member.Profile pf_obj=tea.entity.member.Profile.find(member);
    zsxm=pf_obj.getFirstName(teasession._nLanguage);
    lastname=pf_obj.getLastName(teasession._nLanguage);
    email=pf_obj.getEmail();
    xb=pf_obj.isSex();
    mm=pf_obj.getPassword();
    organization=pf_obj.getOrganization(teasession._nLanguage);
    job=pf_obj.getJob(teasession._nLanguage);
    telephone=pf_obj.getTelephone(teasession._nLanguage);
    mobile=pf_obj.getMobile();

    tea.entity.criterion.Itemmember itemmember=    tea.entity.criterion.Itemmember.find(member,community);
    oldunit=itemmember.getOldunit();
  }else
  {
    mm=zsxm=lastname=email=organization=job=telephone=mobile="";
  }

  String unitname;
  if(unitid==0)
  {
    unitname="无单位";//r.getString(teasession._nLanguage, "NoDept");
  }else
  {
    tea.entity.admin.AdminUnit au_obj=tea.entity.admin.AdminUnit.find(unitid);
    unitname=au_obj.getName();
  }
	%>
<h2><%=r.getString(teasession._nLanguage, "AddUser")%>（<%=unitname%>）</h2>

<FORM name="form1" action="<%=request.getRequestURI()%>"   method="post">
<input type="hidden" name="community" value="<%=community%>"/>
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
  <TABLE cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
       <TR>
        <TD noWrap class="huititable" ><%=r.getString(teasession._nLanguage, "ID")%>：</TD>
        <TD  noWrap class="huititable">
          <INPUT class="SmallInput" maxLength="20" name="yhm" value=<%if(member!=null){out.print(member); out.print(" disabled ");}%>>
          <input type=hidden value="<%=member%>" name=member>
*        </TD>
        <TD  noWrap class="huititable"><%=r.getString(teasession._nLanguage, "Sex")%>：</TD>
        <TD  noWrap class="huititable"><select class="BigSelect" name="xb">
          <option value="1" selected><%=r.getString(teasession._nLanguage, "Man")%></option>
          <option value="0" <%if(!xb)out.print(" selected ");%>><%=r.getString(teasession._nLanguage, "Woman")%></option>
        </select>
        </TD>

      </TR>
      <TR>
        <TD  noWrap class="huititable">姓名<%//=r.getString(teasession._nLanguage, "FirstName")%>：</TD>
        <TD  noWrap class="huititable"><INPUT class="SmallInput" maxLength="10" size="10" name="zsxm" value="<%if(zsxm!=null)out.print(zsxm); if(lastname!=null)out.print(lastname);%>">
&nbsp; *</TD>
<%--
        <TD><%=r.getString(teasession._nLanguage, "LastName")%>:</TD>
<td>
<input type="TEXT" class="edit_input"  name=lastname VALUE="<%if(lastname!=null)out.print(lastname);%>" SIZE=20 MAXLENGTH=20>
        </td>--%>

        <TD><%=getNull(r.getString(teasession._nLanguage, "EmailAddress"))%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=email VALUE="<%if(email!=null)out.print(email);%>"  MAXLENGTH=40>
        *</td>
          </tr>
        <tr>
        <TD  noWrap class="huititable">编制组<%//=r.getString(teasession._nLanguage, "Dept")%>：</TD>
        <TD  noWrap class="huititable"><select class="BigSelect" name="UnitId">
        <option value="0">-------------</option>

<%
java.util.Enumeration au_enumer=tea.entity.admin.AdminUnit.findByCommunity(community," AND other3=1");
if(!tea.entity.site.License.getInstance().getWebMaster().equals(teasession._rv.toString()))
{
//  sb.append(" AND creator="+DbAdapter.cite(teasession._rv.toString()));
}
while(au_enumer.hasMoreElements())
{
  AdminUnit au_obj_temp=(AdminUnit)au_enumer.nextElement();
  int id=au_obj_temp.getId();
  out.print("<option value="+id);
  if(unitid==id)out.print(" selected ");
  out.print(" >"+au_obj_temp.getName());
}
%>
</select><input type="button" value="..." onclick="window.showModalDialog('/jsp/admin/popedom/UnitSelect.jsp?community=<%=community%>&sql=+AND+other3%3D1&index=form1.UnitId',self,'edge:raised;status:0;help:0;resizable:1;dialogWidth:550px;dialogHeight:500px;dialogTop:100;dialogLeft:150');"/>
 <TD  noWrap class="huititable">编制单位：</TD>
<TD  noWrap class="huititable"><select class="BigSelect" name="oldunit">
  <option value="0">-------------</option>
          <%
          java.util.Enumeration au_enumer2=tea.entity.admin.AdminUnit.findByCommunity(community," AND other3=0");
          while(au_enumer2.hasMoreElements())
          {
            int id=((Integer)au_enumer2.nextElement()).intValue();
            tea.entity.admin.AdminUnit au_obj_temp=tea.entity.admin.AdminUnit.find(id);
            %>
            <option value="<%=id%>" <%if(oldunit==id)out.print(" selected ");%>>
              <%=au_obj_temp.getName()%></option>
              <%}
              %>
        </select><input type="button" value="..." onclick="window.showModalDialog('/jsp/admin/popedom/UnitSelect.jsp?community=<%=community%>&sql=+AND+other3%3D0&index=form1.oldunit',self,'edge:raised;status:0;help:0;resizable:1;dialogWidth:550px;dialogHeight:500px;dialogTop:100;dialogLeft:150');"/>
</TD>
      </TR>
<tr><td>职称:</td><td><input name="organization" type="text" id="organization" value="<%if(organization!=null)out.print(organization);%>"></td>
<td>职务:</td><td><input name="job" type="text" id="job" value="<%if(job!=null)out.print(job);%>"></td>
</tr>
<tr><td>电话:</td><td><input name="telephone" type="text" id="telephone" value="<%if(telephone!=null)out.print(telephone);%>"></td>
<td>手机:</td><td><input name="mobile" type="text" id="mobile" value="<%if(mobile!=null)out.print(mobile);%>">
* </td>
</tr>
      <TR>
        <TD  noWrap class="huititable"><%=r.getString(teasession._nLanguage, "Password")%>：</TD>
        <TD colspan="3"  noWrap class="huititable"><INPUT class="SmallInput" type="password" maxLength="10" size="10" name="mm" value=<%=mm%>>
&nbsp; * </TD>

      </TR>
      <TR>
        <%



java.util.Enumeration az_enumer=tea.entity.admin.AdminZone.findByCommunity(community);
String role=null,zone=null;
if(member!=null)
{
  tea.entity.admin.AdminUsrRole aur_obj=tea.entity.admin.AdminUsrRole.find(community,member);
  role=aur_obj.getRole();
  zone=aur_obj.getZone();
}
if(role==null)
{
  role="";
}
if(zone==null)
{
  zone="";
}					%>
        <TD class="huititable" noWrap ><%=r.getString(teasession._nLanguage, "Role")%>：
          <input  type="hidden" size="1000" name="optionsvalue"></TD>
        <TD colspan="3"  align="left" noWrap class="huititable"><table cellSpacing="0" borderColorDark="#ffffff" cellPadding="0" align="left" borderColorLight="#666666" border="1">
            <tr align="center">
              <td width="140" valing=middle><%=r.getString(teasession._nLanguage, "SelectRole")%></td>
              <td width="50"  valing=middle>&nbsp;</td>
              <td width="140"  valing=middle><%=r.getString(teasession._nLanguage, "StandbyRole")%></td>
            </tr>
            <tr>
              <td width="140" height="182" valing=bottom><select name="toList"  size="12" multiple style="border-width:0px; WIDTH: 140px; "  ondblclick="func_delete(form1.fromList,form1.toList);" width="100%" >
                  <%

                  if(member!=null)
                  {
                    java.util.StringTokenizer tokenizer_obj=new java.util.StringTokenizer(role,"/");
                    while(tokenizer_obj.hasMoreTokens())
                    {
                      int id=Integer.parseInt((String)tokenizer_obj.nextElement());
                      tea.entity.admin.AdminRole ar_obj=tea.entity.admin.AdminRole.find(id);
                      %>
                      <option value="<%=id%>"><%=ar_obj.getName()%></option>
                      <%
                    }
                  }
                    %>
                </select></td>
              <td width="50" align="center"  valing=middle><input onClick="func_insert(form1.fromList,form1.toList);" type="button" value=" ← " id=button1 name=button1>
                <br>
                <input  onClick="func_delete(form1.fromList,form1.toList);" type="button" value=" → " id=button2 name=button2>
                <br>
                <input onClick="func_up(form1.fromList,form1.toList);" type="button" value=" ↑ " id=button3 name=button3>
                <br>
                <input onClick="func_down(form1.fromList,form1.toList);" type="button" value=" ↓ " id=button4 name=button4>
              </td>
              <td  valing=middle width="140">
                <select ondblclick="func_insert(form1.fromList,form1.toList);" width="100%" style="WIDTH: 140px;" size="12" name="fromList" >
                  <%--
                  if(teasession._rv._strR.equals(tea.entity.site.License.getInstance().getWebMaster()))
                  {//如果当前会员是webmaster,则列出所有角色
                    java.util.Enumeration ar_enumer=tea.entity.admin.AdminRole.findByCommunity(node.getCommunity());
                    while(ar_enumer.hasMoreElements())
                    {
                      int ar_id=((Integer)ar_enumer.nextElement()).intValue();
                      out.print("<option value="+ar_id+" >"+tea.entity.admin.AdminRole.find(ar_id).getName()+"</option>");
                    }
                  }else
                  {//如果当前会员并非webmaster,则列出自已所居用的角色
                    tea.entity.admin.AdminUsrRole aur_obj=tea.entity.admin.AdminUsrRole.find(teasession._rv._strR);
                    if(aur_obj.getRole()!=null)
                    {
                      java.util.StringTokenizer tokenizer_obj=new java.util.StringTokenizer(aur_obj.getRole(),"/");
                      while(tokenizer_obj.hasMoreTokens())
                      {
                        int id=Integer.parseInt((String)tokenizer_obj.nextElement());
                        out.print("<option value="+id+" >"+tea.entity.admin.AdminRole.find(id).getName()+"</option>");
                      }
                    }
                  } --%>
                  <%
                  int role_supermanager=tea.entity.admin.AdminRole.findByName(Item.ROLE_SUPERMANAGER,community);
                  if(role_supermanager!=0)
                  {
                    out.println("<option value="+role_supermanager+" >"+Item.ROLE_SUPERMANAGER);
                  }
                  int role_manager=tea.entity.admin.AdminRole.findByName(Item.ROLE_MANAGER,community);
                  if(role_manager!=0)
                  {
                    out.println("<option value="+role_manager+" >"+Item.ROLE_MANAGER);
                  }
                  %>
                  <!--<option value="40">编制组项目成员</option>-->
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
          </table>
		  *</TD>

      </TR>
      <tr align="center">
        <TD colSpan="6" noWrap class="TableControl" valing=middle>          <INPUT class="BigButton" title="" type="submit" onClick="return CheckForm();" value="<%=r.getString(teasession._nLanguage,"Add")%>" name="add">
        </TD></TR>

  </TABLE>
  <h2><%=r.getString(teasession._nLanguage,"UserManage")%> （<%=unitname%>）
    <%//=rs.RecordCount%>
 </h2>
  <input type="hidden" name="act" value=""/>

    <TABLE  cellSpacing="0" cellPadding="0" width="100%" border="0" id="tablecenter">
     <TR id="tableonetr">
          <TD valing=middle><%=r.getString(teasession._nLanguage, "ID")%></TD>
          <TD valing=middle><%=r.getString(teasession._nLanguage, "Username")%></TD>
          <TD valing=middle><%=r.getString(teasession._nLanguage, "Dept")%></TD>
          <TD valing=middle><%=r.getString(teasession._nLanguage, "operation")%></TD>
      </TR>
        <%    java.util.Enumeration pfbyu_enumer=tea.entity.admin.AdminUsrRole.findByUnit(unitid,community);
                                for(int iCount=1;pfbyu_enumer.hasMoreElements();iCount++)
                                {
                                  String member_temp=(String)pfbyu_enumer.nextElement();
                                  AdminUsrRole aur=AdminUsrRole.find(community,member_temp);
                                    tea.entity.member.Profile pf_obj_temp=tea.entity.member.Profile.find(member_temp);

                                    if(unitid!=0||community.equals(pf_obj_temp.getCommunity()))
                                    {
                                      //member_temp=  new String(member_temp.getBytes("ISO-8859-1"));
                                      %>

                                      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
                                        <TD ><%=member_temp%></TD>
                                        <TD ><%=pf_obj_temp.getFirstName(teasession._nLanguage)%>　<%=pf_obj_temp.getLastName(teasession._nLanguage)%>　</TD>
                                        <TD ><%=unitname%></TD>
                                        <TD ><A href="<%=request.getRequestURI()%>?node=<%=teasession._nNode%>&UsrId=<%=member_temp%>&UnitId=<%=unitid%>"><%=r.getString(teasession._nLanguage, "Edit")%></A>&nbsp;&nbsp;
                                          <%if(!member_temp.equals("admin")){%>
                                          <A href="#"  onclick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){form1.member.value='<%=member_temp%>';form1.yhm.disabled=true;form1.act.value='del';form1.submit();}"><%=r.getString(teasession._nLanguage, "Delete")%></A>
                                          <%}%>
                                          <A href="#"  onclick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmClearPassword")%>')){form1.member.value='<%=member_temp%>';form1.yhm.disabled=true;form1.act.value='clear';form1.submit();}"><%=r.getString(teasession._nLanguage, "ClearPassword")%></a> </TD>
</TR>
<%}
}
				%>
    </TABLE>
    <br>
    <div id="head6"><img height="6" src="about:blank"></div>
    <br>
    <input name="" type="button" value="<%=r.getString(teasession._nLanguage, "Add")%>" onClick="window.open('/jsp/admin/popedom/adduser.jsp?node=<%=teasession._nNode%>&UnitId=<%=unitid%>','','height=170px,width=400px,left=250,top=150,resizable=no,scrollbars=no,toolbar=no,location=no,directories=no,status=no,menubar=no');">

  <br>
</FORM>
<br/> <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

  <!--TABLE cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
  <tr><td>注:</td><td>删除按扭,并非是删除会员.</td></tr>
  </table-->

</BODY>
</html>


