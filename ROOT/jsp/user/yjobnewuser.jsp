<%@page contentType="text/html;charset=UTF-8"%><%@page import="java.util.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%request.setCharacterEncoding("UTF-8");

Http h=new Http(request,response);
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
//h.member=teasession._rv.toString();

String community=teasession._strCommunity;
Communityjob communityjob=Communityjob.find(community);

if(!teasession._rv.toString().equalsIgnoreCase(communityjob.getJobmember())&&!License.getInstance().getWebMaster().equals(teasession._rv.toString()))
{
  response.sendError(403);
  return;
}
Resource r=new Resource("/tea/resource/Job");

StringBuffer scriptsb=new StringBuffer();

String member=h.get("member").trim().toLowerCase();

String nexturl=h.get("nexturl");
if(nexturl==null)
nexturl="/jsp/community/yjobsubscribers.jsp?community="+community;

String act=h.get("act");
if("POST".equals(request.getMethod()))
{
  out.print("<script>var mt=parent.mt</script>");
  if("del".equals(act))
  {
    Profile p=Profile.find(member);
    p.delete(h.language);
  }else
  {
    String email=h.get("email");
    String password=h.get("password");
    boolean booledit=h.getBool("edit");
    if(!booledit)
    {
      if(Profile.isExisted(member))
      {
        out.print("<script>mt.show('"+r.getString(h.language,"1167443364859")+"');</script>");
        return;
      }
      Profile.create(member,password,community,email,request.getServerName());
    }
    Profile p=Profile.find(member);
    p.setFirstName(h.get("firstname"),h.language);
    p.setOrganization(h.get("organization"),h.language);
    p.setEmail(email);
    p.setTelephone(h.get("telephone"),h.language);
    p.setJob(h.get("job"),h.language);
    p.setTelephone(h.get("telephone"),h.language);

    AdminUsrRole aur_obj=AdminUsrRole.find(community,member);
    aur_obj.setCompany(h.get("company").replace('|','/'));

    String role=aur_obj.getRole();
    boolean bjob=h.get("rolejob")!=null;
    int rolejobvalue=Integer.parseInt(h.get("rolejobvalue"));
    if(role.indexOf("/"+rolejobvalue+"/")!=-1)
    {
      if(!bjob)
      role=role.replaceAll("/"+rolejobvalue+"/","/");
    }else
    {
      if(bjob)
      role=role+(rolejobvalue+"/");
    }

    boolean bresume=h.get("roleresume")!=null;
    int roleresumevalue=Integer.parseInt(h.get("roleresumevalue"));
    if(role.indexOf("/"+roleresumevalue+"/")!=-1)
    {
      if(!bresume)
      role=role.replaceAll("/"+roleresumevalue+"/","/");
    }else
    {
      if(bresume)
      role=role+(roleresumevalue+"/");
    }
    boolean bapply=h.get("roleapp")!=null;
    int roleappvalue=Integer.parseInt(h.get("roleappvalue"));
    if(role.indexOf("/"+roleappvalue+"/")!=-1)
    {
      if(!bapply)
      role=role.replaceAll("/"+roleappvalue+"/","/");
    }else
    {
      if(bapply)
      role=role+(roleappvalue+"/");
    }
    boolean bcompany=h.get("rolecom")!=null;
    int rolecomvalue=Integer.parseInt(h.get("rolecomvalue"));
    if(role.indexOf("/"+rolecomvalue+"/")!=-1)
    {
      if(!bcompany)
      role=role.replaceAll("/"+rolecomvalue+"/","/");
    }else
    {
      if(bcompany)
      role=role+(rolecomvalue+"/");
    }
    aur_obj.setRole(role);

    //Organizer.create(community, member);//组织者
  }
  out.print("<script>mt.show('操作成功！',1,'"+nexturl+"');</script>");
  return;
}


%><html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<SCRIPT language="javascript">

function submitSelect(obj,text)
{
  if(obj.selectedIndex!=-1)
  return true;
  alert(text);
  obj.focus();
  return false;
}

function chkit()
{
  //管辖机构
  var t='|',op=form1.toList.options;
  for(var i=0;i<op.length;i++)t+=op[i].value+"|";
  form1.company.value=t;
  //权限
  if(!form1.rolejob.checked&&!form1.roleresume.checked&&!form1.roleapp.checked&&!form1.rolecom.checked)
  {
    mt.show("至少要选择一个权限！");
    return false;
  }
  return mt.check(form1);
}

function account()
{

    var sum = 0;
    var count = document.form1.chkRights.length;
    for(var i = 0; i <= count - 1; i++)
    {
        if (document.form1.chkRights[i].checked)
        {
            sum += parseInt(document.form1.chkRights[i].value);
        }
    }
    document.form1.hiddenCount.value = sum;
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

function fchange(member)
{
  window.location='<%=request.getRequestURI()%>?member='+member+'&community=<%=community%>&nexturl='+encodeURIComponent('<%=nexturl%>');
}
</SCRIPT>
</head>
<BODY onload="form1.firstname.focus();">
<h1><%=r.getString(h.language, "1167442215187")%><!--新增/编辑用户--></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM NAME="form1" METHOD="post" action="?" target="_ajax" onSubmit="return chkit();">
<input type="hidden" name="community" value="<%=community%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>

<TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%

String firstname=null,organization=null,email=null,telephone=null,job=null,checkOption=null,password=null,role=null,company=null;
boolean bjob=false,bresume=false,bapply=false,bcompany=false;
if(member==null||member.length()<1)
{
  firstname=organization=email=telephone=job=checkOption=password=role=company="";
}else
{
  out.print("<input type=hidden name=edit value=true />");

  Profile profile=Profile.find(member);
  firstname=profile.getFirstName(h.language);
  profile.getOrganization(h.language);
  email=profile.getEmail();
  telephone=profile.getTelephone(h.language);
  job=profile.getJob(h.language);
  password=profile.getPassword();
  organization=profile.getOrganization(h.language);

  AdminUsrRole aur_obj=AdminUsrRole.find(community,member);
  role=aur_obj.getRole();
  company=aur_obj.getCompany();
  /*
  Purview purview=Purview.find(member,community);
  checkOption=purview.getNode();
  bjob=purview.isJob();
  bresume=purview.isResume();
  bapply=purview.isApply();
  bcompany=purview.isCompany();*/
}
%>
      <%if(member==null||member.length()<1)
      {%>
      <TR>
        <TD COLSPAN="0"><%=r.getString(h.language, "1167442262453")%><!--选择已存在用户-->:</TD>
              <td><select onchange="fchange(this.value)"><option value="">----------------</option>
          <%
          java.util.Enumeration af_enumer=Profile.findByCommunity(teasession._strCommunity);
          while(af_enumer.hasMoreElements())
          {
            String af_enumer_value=(String)af_enumer.nextElement();
            out.print("<option value="+af_enumer_value+" >"+af_enumer_value);
          }
      %>
          </select></td>
      </tr><%}%>
      <TR>
        <TD COLSPAN="4"><HR SIZE="1">
        </TD>
      </TR>
      <TR>
        <TD COLSPAN="4"><SPAN>* <%=r.getString(h.language, "1167442294640")%><!--必须填写--></SPAN></TD>
      </TR>
      <TR>
        <TD><SPAN>*</SPAN> <%=r.getString(h.language, "1167442318656")%><!--姓名--></TD>
        <TD><INPUT TYPE="text" class="edit_input" NAME="firstname" MAXLENGTH="50" VALUE="<%=firstname%>" alt="<%=r.getString(h.language, "1167442318656")%>" >
        </TD>
        <TD ><SPAN>* </SPAN><%=r.getString(h.language, "1167442343250")%><!--所在机构--></TD>
        <TD><input type="text" name="organization" value="<%=organization%>" alt="<%=r.getString(h.language, "1167442343250")%>"/>

<%--          <SELECT NAME="selOrg" STYLE="width:172px">
            <%java.util.Enumeration enumeration=Node.findByType(21,community);int nodeCode;
while(enumeration.hasMoreElements())
{
   nodeCode =((Integer)enumeration.nextElement()).intValue();
   String strTempSubject=Node.find(nodeCode).getSubject(1);
%>
            <OPTION VALUE="<%=nodeCode%>"<%//=getSelect(strTempSubject.equals(organization))%>><%=strTempSubject%></OPTION>
            <%}%>
          </SELECT>
--%>        </TD>
      </TR>
      <TR>
        <TD  ><SPAN >*</SPAN> E-mail&nbsp;</TD>
        <TD><INPUT TYPE="text" class="edit_input" NAME="email" MAXLENGTH="120" VALUE="<%=email%>" alt="E-mail">
        </TD>
        <TD ><%=r.getString(h.language, "1167442368500")%><!--电话--></TD>
        <TD><INPUT TYPE="text" class="edit_input" NAME="telephone" MAXLENGTH="40" VALUE="<%=telephone%>">
        </TD>
      </TR>
      <TR>
        <TD  ><%=r.getString(h.language, "1167442391078")%><!--职位--></TD>
        <TD><INPUT TYPE="text" class="edit_input" NAME="job" MAXLENGTH="60" VALUE="<%=job%>">
        </TD>
        <TD >&nbsp;</TD>
        <TD>&nbsp;</TD>
      </TR>
      <TR>
        <TD COLSPAN="4"><HR SIZE="1">
        </TD>
      </TR>
      <TR>
        <TD ><SPAN >*</SPAN><%=r.getString(h.language, "1167442412359")%><!--管辖机构--></TD>

        <TD COLSPAN="3">

          <TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr align="center">
              <td width="140" valing=middle><%=r.getString(h.language, "1167443014593")%><!--选定公司--></td>
              <td width="50"  valing=middle>&nbsp;</td>
              <td width="140"  valing=middle><%=r.getString(h.language, "1167443031671")%><!--备选公司--></td>
            </tr>
            <tr>
              <td width="140" height="182" valing=bottom>
            <input type="hidden" name="company" value="/" alt="<%=r.getString(h.language, "1167442412359")%>"/>
            <select name="toList" size="10" multiple style="WIDTH: 140px; "  ondblclick="func_delete(form1.fromList,form1.toList);" width="100%" >
            <%
            StringBuffer sb=new StringBuffer();
            java.util.Enumeration enumerationabc=Node.findByType(21,community);
            while(enumerationabc.hasMoreElements())
            {
              int nodeCode =((Integer)enumerationabc.nextElement()).intValue();
              String name=Node.find(nodeCode).getSubject(h.language);
              if(company.indexOf("/"+nodeCode+"/")!=-1)
                out.print("<OPTION VALUE="+nodeCode+" >"+name);
              else
                sb.append("<OPTION VALUE="+nodeCode+" >"+name);
            }
		%>
                </select></td>
              <td width="50" align="center" ><input onclick="func_insert(form1.fromList,form1.toList);" type="button" value=" ← " id=button1 name=button1>
                <br>
                <input  onClick="func_delete(form1.fromList,form1.toList);" type="button" value=" → " id=button2 name=button2>
                <br>
                <input onclick="func_up(form1.fromList,form1.toList);" type="button" value=" ↑ " id=button3 name=button3>
                <br>
                <input onclick="func_down(form1.fromList,form1.toList);" type="button" value=" ↓ " id=button4 name=button4>
                <br>
              </td>
              <td  valing=middle width="140">
                <select ondblclick="func_insert(form1.fromList,form1.toList);" width="100%" style="WIDTH: 140px;" size="10" name="fromList" >
                  <%=sb.toString()%>
                </select>
              </td>
            </tr>
          </table>
          <SPAN CLASS="note"><%=r.getString(h.language, "1167442497062")%><!--该用户可以对所选机构的信息进行操作--></SPAN></TD>
      </TR>
      <TR>
        <TD  ><%=r.getString(h.language, "1167442525218")%><!--权限--></TD>
        <TD COLSPAN="3">
        <%
        AdminRole ar_obj;
        int rolejob=communityjob.getRolejob();
        out.print("<input type=hidden name=rolejobvalue value="+rolejob+" >");
        if(rolejob>1&&(ar_obj=AdminRole.find(rolejob)).isExists())
        {
          out.print("<input type=checkbox name=rolejob ");
          if(role.indexOf("/"+rolejob+"/")!=-1)
          {
            out.print(" checked ");
          }
          out.println(" >"+ar_obj.getName());
        }else
        {
          out.println(r.getString(h.language, "1167442560656"));//职位管理所对应的角色无效
        }
        int roleresume=communityjob.getRoleresume();
        out.print("<input type=hidden name=roleresumevalue value="+roleresume+" >");
        if(roleresume>1&&(ar_obj=AdminRole.find(roleresume)).isExists())
        {
          out.print("<input type=checkbox name=roleresume ");
          if(role.indexOf("/"+roleresume+"/")!=-1)
          {
            out.print(" checked ");
          }
          out.println(" >"+ar_obj.getName());
        }else
        {
          out.println(r.getString(h.language, "1167442583593"));//简历管理所对应的角色无效
        }
        int roleapp=communityjob.getRoleapp();
        out.print("<input type=hidden name=roleappvalue value="+roleapp+" >");
        if(roleapp>1&&(ar_obj=AdminRole.find(roleapp)).isExists())
        {
          out.print("<input type=checkbox name=roleapp ");
          if(role.indexOf("/"+roleapp+"/")!=-1)
          {
            out.print(" checked ");
          }
          out.println(" >"+ar_obj.getName());
        }else
        {
          out.println(r.getString(h.language, "1167442610953"));//应聘管理所对应的角色无效
        }
        int rolecom=communityjob.getRolecom();
        out.print("<input type=hidden name=rolecomvalue value="+rolecom+" >");
        if(rolecom>1&&(ar_obj=AdminRole.find(rolecom)).isExists())
        {
          out.print("<input type=checkbox name=rolecom ");
          if(role.indexOf("/"+rolecom+"/")!=-1)
          {
            out.print(" checked ");
          }
          out.println(" >"+ar_obj.getName());
        }else
        {
          out.println(r.getString(h.language, "1167442644125"));//公司设置所对应的角色无效
        }
        %>
          </TD>
      </TR>
      <TR>
        <TD COLSPAN="4"><HR SIZE="1">
        </TD>
      </TR>
      <TR>
        <TD  ><SPAN >*</SPAN><%=r.getString(h.language, "1167441890296")%><!--用户名--></TD>
        <TD COLSPAN="3">
          <%
          if(member!=null&&member.length()>1)
          {
            out.print(member+"<input type=hidden name=member value="+member+" >");
          }else
          {
            out.print(member+"<input type=text name=member MAXLENGTH=20 alt='"+r.getString(h.language, "1167441890296")+"' >   <SPAN CLASS=note>"+r.getString(h.language, "1167442720218")+"</SPAN>");//3-20位，字母、数字、下划线的组合
          }%>
 </TD>
      </TR>
      <TR>
        <TD  ><SPAN >*</SPAN><%=r.getString(h.language, "Password")%><!--密码--></TD>
        <TD COLSPAN="3"><INPUT class="edit_input" TYPE="password" NAME="password" MAXLENGTH="12" min="3" value="<%=(password)%>" alt="<%=r.getString(h.language, "Password")%>" >
          <SPAN CLASS="note"><%=r.getString(h.language, "1167442804484")%><!--3-12位--></SPAN> </TD>
      </TR>
      <TR>
        <TD  ><SPAN >*</SPAN><%=r.getString(h.language, "ConfirmPassword")%><!--确认密码--></TD>
        <TD ><INPUT class="edit_input" TYPE="password" NAME="password2" MAXLENGTH="12" value="<%=password%>" alt="<%=r.getString(h.language, "ConfirmPassword")%>">
        </TD>
        <TD  >&nbsp;</TD>
        <TD >&nbsp;</TD>
      </TR>
      <TR>
        <TD HEIGHT="50" COLSPAN="4" ALIGN="CENTER"><INPUT TYPE="hidden" NAME="hiddenCount" VALUE="">
          <INPUT TYPE="hidden" NAME="hiddenSubmit" VALUE="1">
&nbsp;
          <input class="edit_button"  type="submit" name="Submit" value="<%=r.getString(h.language, "CBSubmit")%>">
          <input class="edit_button"  name="reset" type="reset" value="<%=r.getString(h.language, "Reset")%>">
          <input class="edit_button"  type="button" value="<%=r.getString(h.language,"CBBack")%>" onclick="window.open('<%=nexturl%>','_self');">
        </TD>
      </TR>
  </TABLE>
</FORM>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(h.language,request)%></div>
</BODY>
</html>
