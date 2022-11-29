<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="tea.entity.node.*"%>
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

int adminunit=Integer.parseInt(teasession.getParameter("adminunit"));
String member=teasession.getParameter("member");
String firstname=null,password=null,lastname=null,email=null;
boolean sex=true;
String role="/",classes="/",dept="/",bbs="/";
int raclass = 0,wagetype=0,polity=-1;
boolean option1=false;
String job,title,birth,fax,etime,telephone,mobile,functions,address,photopath2,degree;
int nomanager=0;
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
  nomanager=p.getNomanager();
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
  role=aur.getRole();
  classes=aur.getClasses();
  dept=aur.getDept();
  bbs=aur.getBbs(); 
  if(bbs==null)
  {
	  bbs="/";
  }
  option1=aur.isProvider(1);
  adminunit=aur.getUnit();
}else
{
  nomanager=0;
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
<SCRIPT language="JavaScript">
function CheckForm()
{
  var arr=new Array("role","classes","dept","bbs");
  for(var i=0;i<arr.length;i++)
  { 
    var v="/";
    var op=document.all(arr[i]+"1").options;
    for(var j=0;j<op.length; j++)
    {
      v=v+op[j].value+"/";
    }
    document.all(arr[i]).value=v;
  }
	if(document.form1.nomanager.checked){
		document.form1.nomanager2.value="1";
	}else{
		
		document.form1.nomanager2.value="0";
	}
  return submitMemberid(form1.newmember,"用户名不正确,格式:长度最小3位,内容只能是 数字，字母，下划线(_)和减号(-)")
  &&submitText(form1.firstname,"<%=r.getString(teasession._nLanguage,"InvalidName")%>")
  &&submitBirth(form1.birth,'无效-日期格式')
  &&submitSize(form1.photopath2,'您上传的照片太大!')
  &&submitOptions(form1.role1,"<%=r.getString(teasession._nLanguage,"无效-角色")%>");
}

function submitOptions(obj,text)
{
  if(form1.role1.options.length==0)
  {
    alert(text);
    form1.role1.focus();
    return false;
  }
}

function f_clear(member)
{
  if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmClearPassword")%>'))
  {
    form1.member.value=member;
    form1.act.value='clearpassword';
    form1.submit();
  }
}

function f_edit(obj,member)
{
  form1.nexturl.value=location;
  form1.action="?adminunit=<%=adminunit%>";
  form1.member.value=member;
  form1.adminunit.value="<%=adminunit%>";
  form1.submit();
}

function f_sms(m)
{
  form1.action="/jsp/sms/EditSMSMoney.jsp";
  form1.member.value=m;
  form1.submit();
}

function f_move(member,bool)
{
  form1.nexturl.value=location;
  form1.member.value=member;
  form1.sequence.value=bool;
  form1.adminunit.value="<%=adminunit%>";
  form1.act.value="moveadminusrrole";
  form1.submit();
}

function f_delete(member)
{
  if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'))
  {
    form1.member.value=member;
    form1.act.value='deleteadminusrrole';
    form1.submit();
  }
}

function f_desktop(member)
{
  if(confirm('<%=r.getString(teasession._nLanguage, "1176693988281")%>'))
  {
    sendx('/servlet/EditIg?community=<%=teasession._strCommunity%>&member='+member+'&act=reset',function(date)
    {
      alert('还原默认桌面完成.');
    } );
  }
}

function f_load()
{
  if(form1.nexturl.value.length<5)
  {
    form1.nexturl.value=location;
  }
  try
  {
    form1.newmember.focus();
  }catch(ex)
  {
    form1.firstname.focus();
  }
}
function f_key(m)
{
  window.open("/jsp/admin/popedom/KeySerialNum.jsp?community=<%=teasession._strCommunity%>&member="+encodeURIComponent(m),"","top=300px,left=400px,height=170px,width=400px");
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

function f_edit2(igd)
{
    var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:557px;dialogHeight:457px;';
	 var url = '/jsp/admin/popedom/MemberNodeRole.jsp?member='+encodeURIComponent(igd)+"&t="+new Date().getTime();
	 var rs = window.showModalDialog(url,self,y);
	 if(rs==1)
	 {
		 window.location.reload();
	 }
}
</script>
</head>
<BODY onLoad="f_load();">
<h1><%=r.getString(teasession._nLanguage, "UserManage")+"（"+unitname+"）"%></h1>
<div id="head6"><img height="6" src="about:blank"></div>



<h2><%=r.getString(teasession._nLanguage,"UserManage")%></h2>
<table  cellSpacing="0" cellPadding="0" width="100%" border="0" id="tablecenter">
  <TR id="tableonetr">
    <td align="center">序号</td>
    <td><%=r.getString(teasession._nLanguage, "ID")%></td>
    <td><%=r.getString(teasession._nLanguage, "Username")%></td>
    <td><%=r.getString(teasession._nLanguage, "Dept")%></td>
    <td><%=r.getString(teasession._nLanguage, "排序")%></td>
    <td><%=r.getString(teasession._nLanguage, "operation")%></td>
  </tr>
  <%
  //AdminUsrRole.findByCommunity(teasession._strCommunity," AND unit="+adminunit);
  Enumeration e=AdminUnitSeq.findByCommunity(teasession._strCommunity,adminunit);
  for(int i=1;e.hasMoreElements();i++)
  {
    String _member=(String)e.nextElement();
    AdminUsrRole obj=AdminUsrRole.find(teasession._strCommunity,_member);
    Profile pf_obj_temp=Profile.find(_member);
    AdminUnit au=AdminUnit.find(obj.getUnit());
    %>
    <tr onMouseOver="bgColor='#BCD1E9'" onMouseOut="bgColor=''">
      <td align="center"><%=i%></td>
      <td><%=obj.getMember()%></td>
      <td align="center"><%=pf_obj_temp.getName(teasession._nLanguage)%></td>
      <td align="center"><%if(au.isExists())out.print(au.getName());%></td>
      <td align="center"><%
      if(i>1)
      out.write("<a href=javascript:f_move('"+_member+"',true)><img src=/tea/image/public/arrow_up.gif></a>");
      else
      out.write("　&nbsp;");
      if(e.hasMoreElements())
      out.write("<a href=javascript:f_move('"+_member+"',false)><img src=/tea/image/public/arrow_down.gif></a>");
      %></td>
      <td><A href="javascript:f_edit(this,'<%=_member%>');"><%=r.getString(teasession._nLanguage, "CBEdit")%></A>
      <a href="javascript:f_edit2('<%=_member %>');">内容权限</a>
        <A href="javascript:f_delete('<%=_member%>');"><%=r.getString(teasession._nLanguage, "CBDelete")%></A>
        <A id="Edn_ClearPassword" href="javascript:f_clear('<%=_member%>');"><%=r.getString(teasession._nLanguage, "ClearPassword")%></a>
	<A id="Edn_SMS" href="javascript:f_sms('<%=_member%>');"><%=r.getString(teasession._nLanguage, "SMS")%></a>
        <!-- 1176693988281=还原默认桌面 -->
        <A id="Edn_Reduction" href="javascript:f_desktop('<%=_member%>');"><%=r.getString(teasession._nLanguage, "1176693988281")%></a>
        <A id="Edn_Key" href="javascript:f_key('<%=_member%>');">Key</a>
      </td>
    </tr>
<%}
%>
  </TABLE>
  
<h2><%=r.getString(teasession._nLanguage, "AddUser")%></h2>
<form name="form1" method="post" action="/servlet/EditAdminPopedom" enctype="multipart/form-data">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="act" value="editadminusrrole"/>
  <input type="hidden" name="member" value="<%=member%>">
  <input type="hidden" name="nexturl" value="<%=nexturl%>">
  <input type="hidden" name="options" value="/1/">
  <input type="hidden" name="sequence" >

  <table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "ID")%>:</td>
      <td>
      <%
      out.print("<input name=newmember maxlength=20 ");
      if(member!=null)
      {
        out.print("value="+member);
        out.print(" disabled ");
      }
      out.print(">");
      %></td>
      <td nowrap><%=r.getString(teasession._nLanguage, "性别")%>:</td>
      <td><select name="sex">
          <option value="true" selected><%=r.getString(teasession._nLanguage, "Man")%></option>
          <option value="false" <%if(!sex)out.print(" selected ");%>><%=r.getString(teasession._nLanguage, "Woman")%></option>
        </select>
      </td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "FirstName")%>:</td>
      <td><input  maxlength="10" name="firstname" value="<%=firstname%>"></td>
      <td nowrap><%=r.getString(teasession._nLanguage, "LastName")%>:</td>
      <td><input type="TEXT"  name=lastname VALUE="<%=lastname%>" SIZE=20 MAXLENGTH=20>      </td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</td>
      <td><input type="TEXT"  name=email VALUE="<%=email%>"  MAXLENGTH=40></td>
      <td nowrap><%=r.getString(teasession._nLanguage, "Dept")%>:</td>
      <td><select name="adminunit">
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
        <input type="button" value="..." onClick="window.showModalDialog('/jsp/admin/popedom/UnitSelect.jsp?community=<%=teasession._strCommunity%>&index=form1.adminunit',self,'edge:raised;status:0;help:0;resizable:1;dialogWidth:550px;dialogHeight:500px;dialogTop:100;dialogLeft:150');"/></td>
    </tr>
    <tr>
    <td nowrap><%=r.getString(teasession._nLanguage, "Password")%>:</td>
    <td><input type="password" maxLength="10" size="10" name="password" value="<%=password%>"></td>
      <td nowrap>职务:</td>
      <td><input name="job" type="text" value="<%=job%>"></td>
    </tr>
    <tr id=editdisp>
      <td nowrap>考勤排班类型:</td>
      <td>
      <select name="rclass">
      <option value="0">-------------</option>
      <%
          Enumeration en= RankClass.findByCommunity(teasession._strCommunity,"");
          while(en.hasMoreElements())
          {
            int c_id=((Integer)en.nextElement()).intValue();
            RankClass cl_obj=RankClass.find(c_id);
            out.print("<option value="+c_id);
            if(raclass==c_id)
            out.print(" selected ");
            out.println(" >"+cl_obj.getRankClass()+"</option>");
          }
          %>
      </select>      </td>
      <td nowrap ><%=r.getString(teasession._nLanguage, "工资标准")%>:</td>
      <td ><input type="text" name="wagetype" size="10" value="<%= wagetype %>">(如:2000/月) </td>
</tr>

      <tr id=editdisp>
        <td nowrap>职称:</td>
        <td><input name="title" type="text" value="<%=title%>"></td>
        <td nowrap>出生日期:</td>
        <td><input name="birth" type="text" size="12" value="<%=birth%>" ><a href="#" onClick="showCalendar('form1.birth');"><img src="/tea/image/public/Calendar2.gif" ></a></td>
      </tr>
      <tr id=editdisp>
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
      <tr id=editdisp>
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
          <br>
          <span style="color:red">注意：</span>请上传宽高128x180照片
        <%
        if(len>0L)
        {
          out.print("<a href="+photopath2+" target=_blank>"+len+r.getString(teasession._nLanguage,"Bytes")+"</a>");
          out.print("<input type=checkbox name=clear onclick=form1.photopath2.disabled=checked >"+r.getString(teasession._nLanguage,"Clear"));
        }
        %>　</td>
        <td><input type="checkbox" name="option1" <%if(option1)out.print(" checked ");%> >
        不显到部门信息中&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="nomanager" <%if(nomanager==1)out.print("checked"); %> ><input type="hidden" name="nomanager2">管理员
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


<!--ROLE-->
      <tr><td nowrap><%=r.getString(teasession._nLanguage, "Role")%>:<input type="hidden" size="1000" name="optionsvalue"></td>
      <td colspan="3">
      <table>
      <tr align="center">
      <td ><%=r.getString(teasession._nLanguage, "SelectRole")%></td>
      <td >&nbsp;</td>
      <td ><%=r.getString(teasession._nLanguage, "StandbyRole")%></td>
      </tr>
      <tr><td>
      <input type="hidden" name="role" >
      <select name="role1" size="8" multiple style="WIDTH:140px;"  ondblclick="move(form1.role1,form1.role2,true);">
      <%
      String rs[]=role.split("/");
      for(int i=1;i<rs.length;i++)
      {
        if(rs[i]!=null && rs[i].length()>0){
          int id=Integer.parseInt(rs[i]);
          AdminRole ar_obj=AdminRole.find(id);
          if(ar_obj.isExists())
          {
            out.print("<option value="+id+" >"+ar_obj.getName());
          }
        }
      }
      %>
    </select>
    </td>
    <td>
    <input type="button" value=" ← " onClick="move(form1.role2,form1.role1,true);" >
    <br>
    <input type="button" value=" → "  onClick="move(form1.role1,form1.role2,true);">    </td>
    <td>
    <select name="role2" ondblclick="move(form1.role2,form1.role1,true);" multiple style="WIDTH:140px;" size="8">
    <%
    if(teasession._rv._strR.equals(License.getInstance().getWebMaster())||teasession._rv.isOrganizer(teasession._strCommunity))//如果当前会员是webmaster,则列出所有角色
    {
      Enumeration ar_enumer=AdminRole.findByCommunity(teasession._strCommunity,teasession._nStatus);
      while(ar_enumer.hasMoreElements())
      {
        int ar_id=((Integer)ar_enumer.nextElement()).intValue();
        if(role.indexOf("/"+ar_id+"/")==-1)
        {
          AdminRole obj=AdminRole.find(ar_id);
          if(obj.getType()!=1)//1为默认角色
          out.print("<option value="+ar_id+" >"+obj.getName()+"</option>");
        }
      }
    }else//如果当前会员并非webmaster,则列出自已所居用的角色
    {
      StringBuffer sb2=new StringBuffer("/");
      AdminUsrRole aur_obj=AdminUsrRole.find(teasession._strCommunity,teasession._rv._strR);
      rs=aur_obj.getRole().split("/");
      for (int i = 1; i < rs.length; i++)
      {
        AdminRole ar = AdminRole.find(Integer.parseInt(rs[i]));
        String cs[] =(rs[i]+ar.getConsign()).split("/");
        for (int j = 0; j < cs.length; j++)
        {
          int arid=Integer.parseInt(cs[j]);
          if(role.indexOf("/"+arid+"/")==-1&&sb2.indexOf("/"+arid+"/")==-1)
          {
            out.print("<option value="+arid+" >"+AdminRole.find(arid).getName());
            sb2.append(arid).append("/");
          }
        }
      }
    }%>
    </select>
    </td>
    </tr>
  </table>
<!-- ----------------------------classes------------------------- -->
  <tr><td nowrap><%=r.getString(teasession._nLanguage, "1169018539109")%></td>
  <td colspan="3">
  <table>
  <tr><td>
  <input type="hidden" name="classes" >
  <select name="classes1" size="5" multiple style="WIDTH:140px;" ondblclick="move(form1.classes1,form1.classes2,true);">
  <%
  rs=classes.split("/");
  for(int i=1;i<rs.length;i++)
  {
    int id=Integer.parseInt(rs[i]);
    AdminUnit au=AdminUnit.find(id);
    if(au.isExists())
    {
      out.print("<option value="+id+" >"+au.getName());
    }
  }
  %>
  </select>
  <td>
    <input type="button" value=" ← " onClick="move(form1.classes2,form1.classes1,false);" >
    <br>
    <input type="button" value=" → "  onClick="move(form1.classes1,form1.classes2,true);">    </td>
  <td>
  <select name="classes2" size="5" multiple style="WIDTH:140px;" ondblclick="move(form1.classes2,form1.classes1,false);">
  <%
  Enumeration e1=AdminUnit.findByCommunity(teasession._strCommunity,"");
  while(e1.hasMoreElements())
  {
    AdminUnit au=(AdminUnit)e1.nextElement();
    //if(classes==null||classes.indexOf("/"+id+"/")==-1)
    {

      out.print("<option value="+au.getId()+">"+au.getPrefix()+au.getName());
    }
  }
  %>
  </select>   </td></tr>
  </table>  </td>
  </tr>

<!-- ----------------------------兼职部门------------------------- -->
  <tr><td nowrap><%=r.getString(teasession._nLanguage, "1234418373575")%></td>
  <td colspan="3">
  <table>
  <tr><td>
  <input type="hidden" name="dept" >
  <select name="dept1" size="5" multiple style="WIDTH:140px;" ondblclick="move(form1.dept1,form1.dept2,true);">
  <%
  rs=dept.split("/");
  for(int i=1;i<rs.length;i++)
  {
    int id=Integer.parseInt(rs[i]);
    AdminUnit au=AdminUnit.find(id);
    if(au.isExists())
    {
      out.print("<option value="+id+" >"+au.getName());
    }
  }
  %>
  </select>
  <td>
    <input type="button" value=" ← " onClick="move(form1.dept2,form1.dept1,false);" >
    <br>
    <input type="button" value=" → "  onClick="move(form1.dept1,form1.dept2,true);">    </td>
  <td>
  <select name="dept2" size="5" multiple style="WIDTH:140px;" ondblclick="move(form1.dept2,form1.dept1,false);">
  <%
  Enumeration e2=AdminUnit.findByCommunity(teasession._strCommunity,"");
  while(e2.hasMoreElements())
  {
    AdminUnit au=(AdminUnit)e2.nextElement();
    //if(classes==null||classes.indexOf("/"+id+"/")==-1)
    {
      out.print("<option value="+au.getId()+">"+au.getPrefix()+au.getName());
    }
  }
  %>
  </select>   </td></tr>
  </table>  </td>
  </tr>
  <!-- ----------------------------论坛用户板块------------------------- -->
  <tr><td nowrap><%=r.getString(teasession._nLanguage, "论坛板块")%></td>
  <td colspan="3">
  <table>
  <tr><td>
  <input type="hidden" name="bbs" >
  <select name="bbs1" size="5" multiple style="WIDTH:140px;" ondblclick="move(form1.bbs1,form1.bbs2,true);">
  <%
  rs=bbs.split("/");
  System.out.print(rs.length);
  for(int i=1;i<rs.length;i++)
  {
    int id=Integer.parseInt(rs[i]);
    Node bnobj = Node.find(id);
    
      out.print("<option value="+id+" >"+bnobj.getSubject(teasession._nLanguage));
    
  }
  %>
  </select>
  <td>
    <input type="button" value=" ← " onClick="move(form1.bbs2,form1.bbs1,false);" >
    <br>
    <input type="button" value=" → "  onClick="move(form1.bbs1,form1.bbs2,true);">    </td>
  <td>
  <select name="bbs2" size="5" multiple style="WIDTH:140px;" ondblclick="move(form1.bbs2,form1.bbs1,false);">
  <%
  boolean a = true;
  int b = 0;
  int c = 0;
  Enumeration e3  = Node.find(" and type=0 and hidden =0  ",0,Integer.MAX_VALUE);
  while(e3.hasMoreElements()) 
  {
	  int nid = ((Integer)e3.nextElement()).intValue();
    Node nobj = Node.find(nid);
   
    Enumeration e3_4  = Node.find("   and exists (select node from Category c where n.node= c.node and c.category=57) and type=1 and hidden =0  and father = "+nid,0,Integer.MAX_VALUE);
    
    if(e3_4.hasMoreElements()){
    	
	    out.print("<option value="+nid+">"+nobj.getSubject(teasession._nLanguage)+"</option>"); 
	    Enumeration e4  = Node.find("   and exists (select node from Category c where n.node= c.node and c.category=57) and type=1 and hidden =0  and father = "+nid,0,Integer.MAX_VALUE);
	    while(e4.hasMoreElements()){
	    	int nid4 =((Integer)e4.nextElement()).intValue();
	    	Node nobj4 = Node.find(nid4);
	    	out.print("<option value="+nid4+">　├"+nobj4.getSubject(teasession._nLanguage)+"</option>");
	    }
	   
  
    }
    
   
  }
  %>
  </select>   </td></tr>
  </table>  </td>
  </tr>
  
  

  <tr align="center">
    <td colSpan="6"  class="TableControl"><input class="BigButton" type="submit" onClick="return CheckForm();" value="<%=r.getString(teasession._nLanguage,"CBRegEdit")%>" name="add"></td>
  </tr>
</TABLE>
  <br>
  <div id="head6"><img height="6" src="about:blank"></div>
  <br>
  <input type="button" value="<%=r.getString(teasession._nLanguage, "CBAddMember")%>" onClick="window.open('adduser.jsp?community=<%=teasession._strCommunity%>&adminunit=<%=adminunit%>','','height=170px,width=400px,left=250,top=150,resizable=no,scrollbars=no,toolbar=no,location=no,directories=no,status=no,menubar=no');">
  <br>
</FORM>

<br/>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</BODY>
</html>

