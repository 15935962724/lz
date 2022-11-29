<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp" %>
<%
int strid=Integer.parseInt(request.getParameter("MenuId"));
if(request.getMethod().equals("POST"))
{
  int act=Integer.parseInt(request.getParameter("act"));
  tea.entity.admin.Area af_obj=tea.entity.admin.Area.find(strid);
  String name=request.getParameter("name");
  int sequence=Integer.parseInt(request.getParameter("sequ"));
  switch(act)
  {
    case 1://添加兄弟
    tea.entity.admin.Area.create(af_obj.getFather(),sequence,name,node.getCommunity());
    break;
    case 2://添加子
    tea.entity.admin.Area.create(strid,sequence,name,node.getCommunity());
    break;
    case 3://修改
    af_obj.set(af_obj.getFather(),sequence,name,node.getCommunity());
    break;
    case 4://删除
    af_obj.delete();
    strid=af_obj.getFather();
    break;
    case 5://复制
    tea.entity.admin.Area.clone(strid,Integer.parseInt(teasession.getParameter("clone")),node.getCommunity(),teasession.getParameter("sonclone")!=null);
  }
  response.sendRedirect(request.getRequestURI()+"?MenuId="+strid);
  return;
}

String name=null;
int sequ=0;
if(strid!=0)
{
  tea.entity.admin.Area af_obj=tea.entity.admin.Area.find(strid);
  name=af_obj.getName();
  sequ=af_obj.getSequence();
}else
{
  name="";
}
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

<SCRIPT language="JavaScript">
function sub1()
{
  if((document.fun.name.value=='<%=name%>'))
  {
    alert("不能添加同名地区！");
    document.fun.name.focus();
    return false;
  }else
  {
    fun.act.value=1;
  }
}
function sub2()
{
  if((document.fun.name.value=='<%=name%>'))
  {
    alert("不能添加同名地区！");
    document.fun.name.focus();
    return false;
  }
  else
  {
    fun.act.value=2;
  }
}
function sub3()
{
  fun.act.value=3;
}
function sub4()
{
  fun.act.value=4;
  return (confirm('确认删除'));
}
function sub5()
{
  fun.act.value=5;
  return submitInteger(fun.clone,'请输入正确的ID');
}
</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<body >

<h1>地区管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>请选择左侧地区列表</h2>


  <br>
<form name="fun" action="?" method="post">
<input type="hidden" name="act" value="1"/>

  <table border="0" cellPadding="0" cellSpacing="0" id=tablecenter>
    <tr>
      <td width="25%" nowrap class="huititable"><font face="宋体"><br>
      当前选中地区：</font></td>
      <td width="35%" nowrap class="huititable"><font face="宋体"><br>
            <%=strid%>:<%=name%>
            <input id="bh" type="hidden" name="MenuId" value="<%=strid%>">
      </font></td>

    </tr>
    <tr>
      <td width="20%" nowrap class="huititable"><font face="宋体">　地区名称：</font></td>
      <td width="40%" nowrap class="huititable"><font face="宋体">
        <input id="mc" type="text" name="name" value="<%=name%>">
      </font></td>
      <td width="20%" nowrap class="huititable"><font face="宋体">　　</font></td>
    </tr>
    <tr>
      <td width="20%" nowrap class="huititable"><font face="宋体">　地区顺序号：</font></td>
      <td width="40%" nowrap class="huititable"><font face="宋体">
        <input  type="text" name="sequ" value="<%=sequ%>">
      </font></td>
      <td width="20%" nowrap class="huititable"><font face="宋体">　</font></td>
    </tr>
    <tr>
      <td height="40" colspan="4" align="middle" nowrap  class="huititable"><font face="宋体">
        <input id="Submit1" type="submit" onclick="return sub1()" value="增加同级地区" name="Submit1">
        <input id="Submit2" type="submit" onclick="return sub2()" value="增加子地区" name="Submit2">
        <input id="Submit2" type="submit" onclick="return sub3()" value="修改" name="Submit2">
        <input id="Submit2" type="submit" onclick="return sub4()" value="删除" name="Submit2">
      </font></td>
    </tr>
    <tr><td></td>
    </tr>
    <tr>
      <td height="40" colspan="4" align="middle" nowrap  class="huititable"><font face="宋体">复制:
            <input type="text" name="clone"/>
            <input name="sonclone"  id="CHECKBOX" type="CHECKBOX" id="sonclone" checked/>
            <label for="sonclone">包括子菜单</label>
            <input type="submit" onClick="return sub5()" value="提交"/>
      </font></td>
    </tr>
  </TABLE>
  <br>
</form>
<SCRIPT language="JavaScript">
function clickMenu(ID)
{

    targetelement=document.all(ID);
    if (targetelement.style.display=="none")
        targetelement.style.display='';
    else
        targetelement.style.display="none";

    parent.dept_user.location="dept_user.asp?UnitId="+ID;
}
		</SCRIPT>
		<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



