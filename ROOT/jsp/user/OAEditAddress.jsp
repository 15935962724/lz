<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<% request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}



Resource r=new Resource().add("/tea/resource/deptuser");

String nexturl=teasession.getParameter("nexturl");

String member=teasession._rv._strV;

if("POST".equals(request.getMethod()))
{
  Profile p= Profile.find(member);
  String email = teasession.getParameter("email");
  p.setEmail(email);
  boolean sex = "true".equals(teasession.getParameter("sex"));
  String firstname = teasession.getParameter("firstname");
  String lastname = teasession.getParameter("lastname");
  int unitid = Integer.parseInt(teasession.getParameter("adminunit"));
  p.setSex(sex);
  p.setFirstName(firstname,teasession._nLanguage);
  p.setLastName(lastname,teasession._nLanguage);
  // ////
  String job = teasession.getParameter("job");
  String title = teasession.getParameter("title");
  String tmp = teasession.getParameter("birth");
  Date birth = null;
  if(tmp != null && tmp.length() > 0)
  {
    try
    {
      birth = p.sdf.parse(tmp);
    } catch(Exception ex)
    {
      // 如果没有月
      try
      {
        birth = p.sdf3.parse(tmp + "-01 00:00:01");
      } catch(Exception ex2)
      {
      }
    }
  }
  String fax = teasession.getParameter("fax");
  String etime = teasession.getParameter("etime");
  String telephone = teasession.getParameter("telephone");
  String mobile = teasession.getParameter("mobile");
  String functions = teasession.getParameter("functions");
  String address = teasession.getParameter("address");
  String degree = teasession.getParameter("degree");
  int polity = Integer.parseInt(teasession.getParameter("polity"));
  // 大照片
  String photopath2 = p.getPhotopath2(teasession._nLanguage);
  String photo = teasession.getParameter("photopath2");
  if(photo != null)
  {
    photopath2=photo;
  } else if(teasession.getParameter("clear") != null)
  {
    photopath2 = "";
  }
  p.set(etime,teasession._nLanguage,job,title,functions,photopath2);
  p.setBirth(birth);
  p.setFax(fax,teasession._nLanguage);
  p.setTelephone(telephone,teasession._nLanguage);
  p.setMobile(mobile);
  p.setAddress(address,teasession._nLanguage);
  p.setDegree(degree,teasession._nLanguage);
  p.setPolity(polity);
  //

  AdminUsrRole aur_obj = AdminUsrRole.find(teasession._strCommunity,member);
  aur_obj.setUnit(unitid);
  out.print("<script>parent.mt.show('信息修改成功!');</script>");
  return;
}


String firstname=null,password=null,lastname=null,email=null;
boolean sex=true;
int raclass = 0,wagetype=0,polity=-1,adminunit=0;
String job,title,birth,fax,etime,telephone,mobile,functions,address,photopath2,degree;
long len=0L;
if(member!=null)
{
  Profile p=Profile.find(member);
  firstname=p.getFirstName(teasession._nLanguage);
  lastname=p.getLastName(teasession._nLanguage);
  email=p.getEmail();
  sex=p.isSex();
  password="********";
  raclass = p.getRclass();
  wagetype= p.getWagetype();
  job=p.getJob(teasession._nLanguage);
  birth=p.getBirthToString();
  fax=p.getFax(teasession._nLanguage);
  telephone=p.getTelephone(teasession._nLanguage);
  mobile=p.getMobile();
  address=p.getAddress(teasession._nLanguage);
  title=p.getTitle(teasession._nLanguage);
  etime=p.getETimeToString();
  functions=p.getFunctions(teasession._nLanguage);
  photopath2=p.getPhotopath2(teasession._nLanguage);
  if(photopath2!=null)
  {
    len=new File(application.getRealPath(photopath2)).length();
  }
  degree=p.getDegree(teasession._nLanguage);
  polity=p.getPolity();

  AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,member);
  adminunit=aur.getUnit();
}else
{
  password=firstname=lastname=email="";
  job=title=birth=fax=etime=telephone=mobile=functions=address=photopath2=degree="";
}

String unitname;
if(adminunit==0)
{
  unitname=r.getString(teasession._nLanguage, "NoDept");
}else
{
  AdminUnit au_obj=AdminUnit.find(adminunit);
  unitname=au_obj.getName();
}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<SCRIPT language="JavaScript">
function CheckForm()
{
  return submitText(form1.firstname,"<%=r.getString(teasession._nLanguage,"InvalidName")%>")
  &&submitBirth(form1.birth,'无效-日期格式')
  &&submitSize(form1.photopath2,'您上传的照片太大!');
}



function f_pic(a)
{
  var img=new Image();
  img.src=a;
  alert(img.width+":"+img.height);
}
function submitSize(obj,text)
{
  if(obj.value!="")
  {
    var img=new Image();
    img.src=obj.value;
    if(img.width>300||img.height>300)
    {
      alert(text);
      obj.focus();
      return false;
    }
  }
  return true;
}

function submitBirth(obj,text)
{
  if(obj.value!="")
  {
    var ymd=obj.value.split("-");
    if(ymd.length==2)
    {
      ymd[2]="01";
    }
    var d = new Date(ymd[0],ymd[1]-1,ymd[2]);
    if(isNaN(d))
    {
      alert(text);
      obj.focus();
      return false;
    }
  }
  return true;
}
</script>
</head>
<BODY onLoad="form1.firstname.focus()">
<h1>个人信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<FORM name="form1" method="post" action="/jsp/user/OAEditAddress.jsp" enctype="multipart/form-data" target="_ajax">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>


  <TABLE cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
    <TR>
      <td nowrap><%=r.getString(teasession._nLanguage, "ID")%>:</td>
      <TD><%=member%></TD>
      <TD nowrap><%=r.getString(teasession._nLanguage, "姓别")%>:</TD>
      <TD><select name="sex">
          <option value="true" selected><%=r.getString(teasession._nLanguage, "Man")%></option>
          <option value="false" <%if(!sex)out.print(" selected ");%>><%=r.getString(teasession._nLanguage, "Woman")%></option>
        </select>
      </TD>
    </TR>
    <TR>
      <td nowrap><%=r.getString(teasession._nLanguage, "FirstName")%>:</td>
      <TD><INPUT  maxlength="10" name="firstname" value="<%=firstname%>"></TD>
      <TD nowrap><%=r.getString(teasession._nLanguage, "LastName")%>:</TD>
      <td><input type="TEXT"  name=lastname VALUE="<%=lastname%>" SIZE=20 MAXLENGTH=20>      </td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</td>
      <td><input type="TEXT"  name=email VALUE="<%=email%>"  MAXLENGTH=40></td>
      <TD nowrap><%=r.getString(teasession._nLanguage, "Dept")%>:</TD>
      <TD><select name="adminunit">
          <option value="0">-------------</option>
          <%
          Enumeration au_enumer=AdminUnit.findByCommunity(teasession._strCommunity,"");
          while(au_enumer.hasMoreElements())
          {
            AdminUnit _au=(AdminUnit)au_enumer.nextElement();
            int id=_au.getId();
            out.print("<option value="+id);
            if(adminunit==id)
            out.print(" selected ");
            out.println(" >"+_au.getPrefix()+_au.getName());
          }
          %>
        </select>
        <input type="button" value="..." onClick="window.showModalDialog('/jsp/admin/popedom/UnitSelect.jsp?community=<%=teasession._strCommunity%>&index=form1.adminunit',self,'edge:raised;status:0;help:0;resizable:1;dialogWidth:550px;dialogHeight:500px;dialogTop:100;dialogLeft:150');"/></TD>
    </TR>

      <tr>
        <td nowrap>职称:</td>
        <td><input name="title" type="text" value="<%=title%>"></td>
        <td nowrap>出生日期:</td>
        <td><input name="birth" type="text" size="12" value="<%=birth%>" ><a href="#" onClick="showCalendar('form1.birth');"><img src="/tea/image/public/Calendar2.gif" ></a></td>
      </tr>
      <tr>
        <td nowrap>学历:</td>
        <td>
          <span style="position:absolute;">
          <select name="selectmenu" style="position:absolute;top:0px; width: 110px; height: 0px; left: 0px; clip: rect(0 180 110 90)" onChange="degree.value=value">
            <option value="">--------------
            <option value="博士">博士
            <option value="硕士">硕士
            <option value="本科">本科
            <option value="大专">大专
            <option value="高中">高中
          </select>
          <input name="degree" type="text" value="<%=degree%>" style="position:absolute;top:0px; width: 95px; height:21px; left:0px;">
          </span>&nbsp;
        </td>
        <td nowrap>政治面貌:</td>
        <td><select name="polity">
        <%
        for(int i=0;i<Profile.POLITY_TYPE.length;i++)
        {
          out.print("<option value="+i);
          if(i==polity)
          {
            out.print(" SELECTED ");
          }
          out.print(">"+r.getString(teasession._nLanguage,Profile.POLITY_TYPE[i]));
        }
        %>
        </select></td>
      </tr>
      <tr>
        <td nowrap>传真:</td>
        <td><input name="fax" type="text" value="<%=fax%>"></td>
        <td nowrap>入职时间:</td>
        <td><input name="etime" type="text" size="12" value="<%=etime%>" ><a href="#" onClick="showCalendar('form1.etime');"><img src="/tea/image/public/Calendar2.gif" ></a></td>
      </tr>
      <tr>
        <td nowrap>办公电话:</td>
        <td><input name="telephone" type="text" value="<%=telephone%>"></td>
          <td nowrap>手机号码:</td>
          <td><input name="mobile" type="text" value="<%=mobile%>"></td>
      </tr>
      	 <tr>
        <td nowrap>照片:</td>
        <td colspan="2"><input name="photopath2" type="file" size="20">
        <%
        if(len>0L)
        {
          out.print("<a href="+photopath2+" target=_blank>查看</a> <input type=checkbox name=clear onclick=form1.photopath2.disabled=checked >删除");
        }
        %>
        <br>
        <span style="color:red">注意：</span>请上传宽高128x180照片
        　</td>
      </tr>
      <tr>
        <td nowrap>岗位职责:</td>
        <td colspan="3"><textarea name="functions" cols="50" rows="4"><%=functions%></textarea></td>
      </tr>
      <tr>
        <td nowrap>地址:</td>
        <td colspan="3"><input name="address" type="text" size="70" value="<%=address%>"></td>
      </tr>

  <tr align="center">
    <td colSpan="6"  class="TableControl"><INPUT class="BigButton" type="submit" onClick="return CheckForm();" value="提交"></td>
  </tr>
</TABLE>



</BODY>
</html>
