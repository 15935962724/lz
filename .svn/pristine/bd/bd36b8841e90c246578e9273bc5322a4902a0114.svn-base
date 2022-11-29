	<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %><%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<% request.setCharacterEncoding("UTF-8");

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
if(h.isIllegal())
{
  response.sendError(404,request.getRequestURI());
  return;
}

Resource res=new Resource().add("/tea/resource/deptuser");

String acts=h.get("acts","");

String key=h.get("member");
int member=key.length()<1?0:Integer.parseInt(MT.dec(key));

Profile p=Profile.find(member);
String avatar=MT.f(p.getPhotopath2(h.language),"/tea/image/avatar.gif");

AdminUsrRole r=AdminUsrRole.find(h.community,p.profile);
String role=r.getRole(),classes=r.classes,depts=r.getDept();
String servicerole = "r.servicerole";
if(servicerole==null){
	servicerole = "/";
}
int dept=r.getUnit();
if(member<1)
{
  dept=h.getInt("dept");
}

String htm=AdminUnit.options(0,AdminUsrRole.find(h.community,h.username).classes);

%>
<html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/script/md5.js" type="text/javascript"></script>
<!--[if IE 6]><style>.tfont{font-family:宋体;}</style><![endif]-->
<style>
#tablecenter td table td{border:0}
</style>
</head>
<body>
<h1>添加/编辑——用户管理11</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form name="form1" method="post" action="/DeptSeqs.do" target="_ajax" enctype="multipart/form-data" onSubmit="return mt.submit(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="member" value="<%=key%>">
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>">
<input type="hidden" name="options" value="/1/">
<input type="hidden" name="password">
<%
int agent=h.getInt("agent");
if(agent>0)out.print("<input type='hidden' name='agent' value='"+agent+"' >");
%>
<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
  <tr>
    <td class="th"><em>*</em>用户名：</td>
    <td>
    <%
    String password="";
    out.print("<input name=username maxlength=20 alt='用户名'");
    if(member>0)
    {
      out.print(" value='"+p.getMember()+"'");
      out.print(" disabled ");
      password="********";
    }
    out.print(">");
    %></td>
    <td class="th"><em>*</em>密码：</td>
    <td><input type="password" id="password1" value="<%=password%>" min="6" alt="密码"></td>
    <td rowspan="6" align="center"><input type="hidden" name="avatar" value="<%=avatar%>" id="avatar"/><img id="avatar_img" src="<%=avatar%>"/><br/><a href="###" onClick="mt.show('/jsp/profile/MemberSetAvatar.jsp?invite=3205',2,'上传照片',450,277);">上传照片</a></td>
  </tr>
  <tr>
    <td class="th"><em>*</em>姓名：</td>
    <td><input name="name" value="<%=p.getName(h.language)%>" alt="姓名"></td>
    <td class="th"><%=res.getString(h.language, "性别")%>：</td>
    <td><select name="sex">
        <option value="true" selected><%=res.getString(h.language, "Man")%></option>
        <option value="false" <%if(!p.isSex())out.print(" selected ");%>><%=res.getString(h.language, "Woman")%></option>
      </select>
    </td>
  </tr>
  <tr>
    <td class="th"><em>*</em>部门：</td>
    <td><input type="hidden" name="dept" value="<%=dept%>"/>
       <input name="dept_name" value="<%=MT.f(AdminUnit.find(dept).name)%>" alt_="部门" readonly size="30" /> <input type="button" value="选择..." onClick="mt.show('/jsp/admin/popedom/DeptSel.jsp?itype=radio&depts='+form1.dept.value,2,'选择部门',500)"/> 
       
      <%--<select name="dept"><option value="0">-------------</option><%=htm%></select>--%>
      </td>
    <td class="th"><em>*</em>手机号码：</td>
    <td><input name="mobile" value="<%=MT.f(p.mobile)%>" alt_="手机号码"></td>
  </tr>
  <tr>
    <td class="th"><em>*</em>电子邮箱：</td>
    <td><input name="email" value="<%=MT.f(p.email)%>" alt_="电子邮箱"></td>
    <td class="th">腾讯QQ：</td>
    <td><input name="qq" value="<%=MT.f(p.qq)%>"/></td>
  </tr>
  <tr>
    <td class="th">职务：</td>
    <td><input name="job" value="<%=MT.f(p.getJob(h.language))%>" /></td>
    <td class="th">职称：</td>
    <td><input name="title" value="<%=MT.f(p.getTitle(h.language))%>" /></td>
  </tr>
<%--
    <tr>
      <td nowrap>出生日期：</td>
      <td><input name="birth" value="<%=MT.f(p.getBirth())%>" class="date" onclick="mt.date(this)" ></td>
    </tr>
    <tr>
      <td nowrap>学历：</td>
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
          <input name="degree" value="<%=p.getDegree(h.language)%>" style="position:absolute;top:0px; width: 95px; height:21px; left:0px;">
          </span>&nbsp;        </td>
        <td nowrap>政治面貌：</td>
        <td><select name="polity">
        <%
        for(int i=0;i<Profile.POLITY_TYPE.length;i++)
        {
          out.print("<option value="+i);
          if(i==p.getPolity())out.print(" selected ");
          out.print(">"+res.getString(h.language,Profile.POLITY_TYPE[i]));
        }
        %>
        </select></td>
      </tr>
      <tr>
        <td class="th">岗位职责：</td>
        <td colspan="4"><textarea name="functions" cols="50" rows="4"><%=p.getFunctions(h.language)%></textarea></td>
      </tr>
--%>
      <tr>
        <td class="th">办公电话：</td>
        <td><input name="telephone" value="<%=p.getTelephone(h.language)%>"></td>
        <td class="th">传真：</td>
        <td><input name="fax" value="<%=p.getFax(h.language)%>"></td>
      </tr>
      <tr>
        <td class="th">地址：</td>
        <td colspan="4"><input name="address" size="70" value="<%=p.getAddress(h.language)%>"></td>
      </tr>


<!--ROLE-->
      <tr>
	  <td valign="top" class="th">角色：<input type="hidden" size="1000" name="optionsvalue"></td>
      <td colspan="4">
      <table>
      <tr align="center"><td>选定</td><td>&nbsp;</td><td>备选</td></tr>
      <tr><td>
      <input type="hidden" name="role" >
      <select name="role1" size="8" multiple style="width:240px;" ondblclick="mt.move(form1.role1,form1.role2,true);">
      <%
      Iterator it=AdminRole.find(" AND id IN("+role.substring(1).replace('/',',')+"0)",0,Integer.MAX_VALUE).iterator();
      while(it.hasNext())
      {
        AdminRole r2=(AdminRole)it.next();
        out.print("<option value="+r2.id+" >"+r2.name);
      }
      %>
    </select>
    </td>
    <td>
    <input type="button" value=" ← " onClick="mt.move(form1.role2,form1.role1,true);" >
    <br>
    <input type="button" value=" → " onClick="mt.move(form1.role1,form1.role2,true);">    </td>
    <td>
    <select name="role2" ondblclick="mt.move(form1.role2,form1.role1,true);" multiple style="width:240px;" size="8">
    <%
    String sql=" AND community="+DbAdapter.cite(h.community);
    if(!"webmaster".equals(h.username))//如果当前会员是webmaster,则列出所有角色
    {
      AdminUsrRole aur_obj=AdminUsrRole.find(h.community,h.member);
      String roles=AdminRole.getConsign(aur_obj);
      sql+=" AND id IN("+roles.substring(1).replace('|',',')+"0)";
    }
    it=AdminRole.find(sql,0,Integer.MAX_VALUE).iterator();
    while(it.hasNext())
    {
      AdminRole t=(AdminRole)it.next();
      if(role.contains("/"+t.id+"/"))continue;
      out.print("<option value="+t.id+" >"+t.name);
    }
    %>
    </select>    </td>
    </tr>
  </table>
<!-- ----------------------------classes------------------------- -->
<% 
AdminUsrRole aur=AdminUsrRole.find(h.community,h.member);
String rs[]=aur.getRole().split("/");
if(rs[1].equals("14100022")){//14100022超级管理员

%>
  <tr class="auths">
    <td valign="top" class="th">管理权限：</td>
    <td colspan="4">
  <table>
  <tr><td>
  <input type="hidden" name="classes" >
  <select name="classes1" size="5" multiple style="width:240px;" ondblclick="mt.move(form1.classes1,form1.classes2,true);">
  <%
  it=AdminUnit.find(" AND id IN("+classes.substring(1).replace('/',',')+"0)",0,Integer.MAX_VALUE).iterator();
  while(it.hasNext())
  {
    AdminUnit d2=(AdminUnit)it.next();
    out.print("<option value="+d2.id+" >"+d2.name);
  }
  %>
  </select>
  <td>
    <input type="button" value=" ← " onClick="mt.move(form1.classes2,form1.classes1,false);" >
    <br>
    <input type="button" value=" → "  onClick="mt.move(form1.classes1,form1.classes2,true);">    </td>
  <td>
  <select name="classes2" size="5" multiple style="width:240px;" class="tfont" ondblclick="mt.move(form1.classes2,form1.classes1,false);"><%=htm%></select>
  </td></tr>
  </table>  </td>
  </tr>

<!-- ----------------------------兼职部门------------------------- -->
  <tr class="depts">
    <td class="th" valign="top"><%=res.getString(h.language, "1234418373575")%>：</td>
    <td colspan="4">
  <table style="border:0" border="0">
  <tr><td>
  <input type="hidden" name="depts" >
  <select name="dept1" size="5" multiple style="width:240px;" ondblclick="mt.move(form1.dept1,form1.dept2,true);">
  <%
  it=AdminUnit.find(" AND id IN("+depts.substring(1).replace('/',',')+"0)",0,Integer.MAX_VALUE).iterator();
  while(it.hasNext())
  {
    AdminUnit d2=(AdminUnit)it.next();
    out.print("<option value="+d2.id+" >"+d2.name);
  }
  %>
  </select>
  <td>
    <input type="button" value=" ← " onClick="mt.move(form1.dept2,form1.dept1,false);" >
    <br>
    <input type="button" value=" → "  onClick="mt.move(form1.dept1,form1.dept2,true);">    </td>
  <td>
    <select name="dept2" size="5" multiple style="width:240px;" class="tfont" ondblclick="mt.move(form1.dept2,form1.dept1,false);"><%=htm
//    Iterator it=Dept.find(" AND father=35",0,100).iterator();
//    while(it.hasNext())
//    {
//      Dept t=(Dept)it.next();
//      out.print("<option value="+t.dept+">"+t.name);
//    }
    %></select>
  </td></tr>
  </table>  </td>
  </tr>
  <!-- --------------------------------------------- -->
  <%}else{ %>
  <input type="hidden" name="depts" >
  <input type="hidden" name="classes" >
  <%} %>
</table>

<input type="submit" value="提交">
<input type="button" value="返回" onClick="history.back()"/>
</form>

<script>
mt.submit=function(f)
{
  f.role.value=mt.value(f.role1,'/');
  f.classes.value=mt.value(f.classes1,'/');
  f.depts.value=mt.value(f.dept1,'/');
  //f.kefus.value=mt.value(f.kefu1,'/');
  //
  t=f.password1.value;
  f.password.value=t=='********'?t:(t);
  if(t!='********'&&_weak(t))
  {
    mt.show("“密码”不能是弱口令，建议字母、数字、标点的组合！");
    return false;
  }
  return mt.check(f);
};

mt.receive=function(a,b,h)
{
  form1.dept.value=a.split("|")[1];
  form1.dept_name.value=b.substring(0,b.length-1);
};

//form1.username.focus();
//mt.focus();
</script>
</body>
</html>
