<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
//h.member=teasession._rv.toString();

int rsearch=h.getInt("rsearch");
RSearch t=RSearch.find(rsearch);

if("POST".equals(request.getMethod()))
{
  String act=h.get("act");
  String nexturl=h.get("nexturl");
  if("del".equals(act))
  {
    t.delete();
  }else if("edit".equals(act))
  {
    t.name=h.get("name");
    t.sex=h.getInt("sex");
    t.age=h.getInt("age");
    t.degree=h.get("degree");
    t.expectcity=h.get("expectcity");
    t.experience=h.getInt("experience");
    t.expectcareer=h.get("expectcareer");
    t.majorcategory=h.getInt("majorcategory");
    if(t.time==null)
    {
      t.member=h.member;
      t.time=new Date();
    }
    t.set();
  }
  out.print("<script>parent.mt.show('数据操作成功！',1,'"+nexturl+"');</script>");
  return;
}

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="rsearch" value="<%=rsearch%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>名称</td>
    <td><input name="name" value="<%=MT.f(t.name)%>" alt="名称"/></td>
  </tr>
  <tr>
    <td>性别</td>
    <td><input type="radio" name="sex" value="1" checked="checked"/>男 <input type="radio" name="sex" value="0" <%=t.sex==0?" checked":""%>/>女</td>
  </tr>
  <tr>
    <td>年龄</td>
    <td><select name="age">
      <option value="-1">----------------
      <option value="1">18-25
      <option value="2">25-30
      <option value="3">30-35
      <option value="4">35-40
      <option value="5">40-45
      <option value="6">45-50
      <option value="7">>50
      </select></td>
  </tr>
  <tr>
    <td>学历</td>
    <td><SELECT NAME="degree"  >
        <OPTION VALUE="">--------------</OPTION>
          <OPTION VALUE="Z0" >小学</OPTION>
          <OPTION VALUE="Z1" >初中</OPTION>
          <OPTION VALUE="Z2" >高中</OPTION>
          <OPTION VALUE="Z3" >技校/职高</OPTION>
          <OPTION VALUE="Z4" >中专</OPTION>
          <OPTION VALUE="Z5" >大专</OPTION>
          <OPTION VALUE="Z8" >大学本科</OPTION>
          <OPTION VALUE="Z9" >硕士研究生</OPTION>
          <OPTION VALUE="ZA" >博士研究生</OPTION>
          <OPTION VALUE="ZB" >无学历</OPTION>
        </SELECT></td>
  </tr>
  <tr>
    <td>期望工作地区</td>
    <td>
<select name="expectcity">
    <option value="">---------</option>
<%
java.util.Enumeration bigjobcity=Jobcity.findByFather(Jobcity.getRootId(h.community));
for(int index=0;bigjobcity.hasMoreElements();index++)
{
  int occupation=((Integer)bigjobcity.nextElement()).intValue();
  Jobcity occ_obj=Jobcity.find(occupation);
  out.print("<option value="+occ_obj.getCode()+">"+occ_obj.getSubject()+"</option>");
}
%>
</select>
     </td>
  </tr>
  <tr>
    <td>工作经验</td>
    <td><input name="experience" type="text" maxlength="2" mask="int" value="<%=MT.f(t.experience)%>" />年</td>
  </tr>
  <tr>
    <td>期望工作职业</td>
    <td><select  name="expectcareer" >
        <option value="">--------</option>
        <%
        java.util.Enumeration bigOcc=Occupation.findByFather(Occupation.getRootId(h.community));
        for(int index=0;bigOcc.hasMoreElements();index++)
        {
          int occupation=((Integer)bigOcc.nextElement()).intValue();out.print(occupation);
          Occupation occ_obj=Occupation.find(occupation);
          String code=occ_obj.getCode();
          out.print("<option value="+code+">"+occ_obj.getSubject()+"</option>");
        }
        %>
      </select></td>
  </tr>
  <tr>
    <td>专业</td>
    <td><SELECT NAME="majorcategory" >
        <option value="-1">--------</option>
        <%
        for(int i =0;i<Educate.ME.length;i++)
        {
          out.print("<option value="+i+">"+Educate.ME[i]+"</option>");
        }
        %></select>
     </td>
  </tr>
</table>
<script>
form1.age.value="<%=t.age%>";
form1.degree.value="<%=MT.f(t.degree)%>";
form1.expectcity.value="<%=MT.f(t.expectcity)%>";
form1.expectcareer.value="<%=MT.f(t.expectcareer)%>";
form1.majorcategory.value="<%=MT.f(t.majorcategory)%>";
</script>
<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
