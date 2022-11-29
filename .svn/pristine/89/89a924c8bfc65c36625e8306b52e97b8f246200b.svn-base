<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.io.*" %><%@page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

Http h=new Http(request);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String community=h.community;


Resource r=new Resource("/tea/resource/fun");


int id=Integer.parseInt(request.getParameter("id"));
String name=null,url=null,target=null,icon=null,urlig=null,urlim=null,content=null,tipoffilepath=null;
boolean show=true;
int type=0,sequence=1,sort=0,len=0,status=0;
AdminFunction af=AdminFunction.find(id);
if(id!=0)
{
  if(!af.isExists())
  {
    response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("该菜单已经不存在了.","UTF-8"));
    return;
  }
  name=af.getName(h.language);
  url=af.getUrl(h.language);
  content=af.getContent(h.language);

  urlig=af.getUrlig();
  urlim=af.getUrlim();
  sequence=af.getSequence();
  type=af.getType();
  target=af.getTarget();
  icon=af.getIcon();
  show=af.isHidden();
  sort=af.getSort();
  status=af.getStatus();
  tipoffilepath = af.getTipoffilepath();
  if(icon!=null&&icon.length()>0)
  {
    len=(int)new java.io.File(application.getRealPath(icon)).length();
  }
}else
{
  name="";
  target="m";
}

AdminFunction root=AdminFunction.getRoot(h.community,h.status);

%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script language="JavaScript">
function sub1()
{
  if((form1.name.value=="<%=name%>") && (form1.url.value=="<%=url%>") && (form1.menutype.value=="<%=type%>") )
  {
    alert("<%=r.getString(h.language, "CannotAddHomonymyManage")%>");
    return false;
  }else
  {
    form1.sub.value=1;
  }
  return submitText(form1.name,'<%=r.getString(h.language, "InvalidParameter")%>');
}

function sub2()
{
  if((form1.name.value=="<%=name%>") && (form1.url.value=="<%=url%>") && (form1.menutype.value=="<%=type%>") )
  {
    alert("<%=r.getString(h.language, "CannotAddHomonymyManage")%>");
    return false;
  }else
  {
    form1.sub.value=2;
  }
  return submitText(form1.name,'<%=r.getString(h.language, "InvalidParameter")%>');
}

function sub3()
{
  form1.sub.value=3;
  return submitText(form1.name,'<%=r.getString(h.language, "InvalidParameter")%>');
}

function sub4()
{
  form1.sub.value=4;
  return (confirm('<%=r.getString(h.language, "ConfirmDelete")%>'));
}

function sub5()
{
  form1.sub.value=5;
  return submitInteger(form1.clone,'<%=r.getString(h.language, "InvalidParameter")%>');
}

function sub6()
{
  form1.sub.value=6;
  return submitInteger(form1.move,'<%=r.getString(h.language, "InvalidParameter")%>');
}

function sub7()
{
  form1.sub.value=7;
  form1.submit();
}
function f_change()
{
  for(var i=0;i<5;i++)
  {
    $("trurl"+i).style.display="none";
  }
  var t=parseInt(form1.menutype.value);
  switch(t)
  {
    case 0:break;
    case 1:for(var i=0;i<4;i++){$("trurl"+i).style.display="";}break;
    case 2:$('trurl4').style.display="";
  }
}
</script>
</head>
<body onLoad="f_change(); form1.name.focus();">
<h1 ID="h1_teshu"><%=r.getString(h.language, "MenuManage")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2><%=r.getString(h.language, "ChoiceMenus")%></h2>


<form name="form1" action="/servlet/EditAdminPopedom" method="post" enctype="multipart/form-data">
<input type="hidden" name="community" value="<%=h.community%>">
<input type="hidden" name="status" value="<%=status%>">
<input type="hidden" name="act" value="editfunction">
<input type="hidden" name="sub" value="0">
<input type="hidden" name="id" value="<%=id%>">

<table border="0" cellPadding="0" cellSpacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(h.language, "CurrentlyChoiceMenu")%>:</td>
    <td><%=id%>:<%=name%></td>
  </tr>
  <tr>
    <td><%=r.getString(h.language, "Name")%>：</td>
    <td><input name="name" value="<%=name%>" size="35"></td>
  </tr>
  <tr>
    <td  height="22" ><%=r.getString(h.language, "Type")%>：</td>
    <td>
      <select name="menutype" onChange="f_change()">
      <%
      for(int i=0;i<AdminFunction.MENU_TYPE.length;i++)
      {
        out.print("<option value="+i);
        if(i==type)out.print(" selected");
        out.print(">"+AdminFunction.MENU_TYPE[i]);
      }
      %>
      </select>
    </td>
  </tr>
  <tr id="trurl0">
    <td>URI：</td>
    <td><input name="url" mask="max" value="<%if(type!=2&&url!=null)out.print(url);%>" size="45"></td>
  </tr>
  <tr id="trurl1">
    <td><%=r.getString(h.language, "1174884224453")%>：</td>
    <td><input name="urlig" value="<%if(urlig!=null)out.print(urlig);%>"  size="45"></td>
  </tr>
  <tr id="trurl2">
    <td><%=r.getString(h.language, "1215676936631")%>：</td>
    <td><input name="urlim" value="<%if(urlim!=null)out.print(urlim);%>"  size="45"></td>
  </tr>
  <tr id="trurl3">
    <td><%=r.getString(h.language, "1215677010131")%>：</td>
    <td><input name="tipoffilepath" value="<%if(tipoffilepath!=null)out.print(tipoffilepath);%>"  size="45"></td>
  </tr>
  <tr id="trurl4">
    <td>节点号:</td>
    <td><input name="url_node" mask="int" value="<%if(type==2)out.print(url);%>" size="45"></td>
  </tr>
  <tr>
    <td><%=r.getString(h.language, "Sequence")%>：</td>
    <td><input name="sequence"  value="<%=sequence%>" size="35"></td>
  </tr>
  <tr>
    <td>提醒：</td>
    <td><select name="remind"><%=h.options(AdminFunction.REMIND_TYPE,af.remind)%></select></td>
  </tr>
  <tr>
    <td><%=r.getString(h.language, "Icon")%>：</td>
    <td>
      <input name="icon" type="file" id="icon">
      <%
      out.print(r.getString(h.language, "Or"));
      out.print("<select name=iconpath >");
      out.print("<option value=\"\">-------------");
      if(len>0)
      out.print("<option value="+icon+" selected >"+r.getString(h.language, "CurrentlyIcon")+" ("+len+r.getString(h.language, "Bytes")+")");
      String names[]=new java.io.File(application.getRealPath("/tea/image/igicon/")).list();
      if(names!=null)
      for(int index=0;index<names.length;index++)
      {
        if(!"Thumbs.db".equals(names[index]))
        out.print("<option value=/tea/image/igicon/"+names[index]+" >"+names[index]+"</option>");
      }
      out.print("</select>");
      %><input type=button value=... onClick="window.open('/jsp/admin/popedom/SelectIgIcon.jsp?community=<%=h.community%>&field=form1.iconpath','','edge=raised,help=0,resizable=1,width=650px,height=500px');" >
      </td>
  </tr>
  <tr>
    <td><%=r.getString(h.language, "Content")%>：</td>
    <td><textarea name="content" cols="40" rows="4"><%if(content!=null)out.print(content.replaceAll("</","&lt;/"));%></textarea></td>
  </tr>
  <tr>
    <td ><%=r.getString(h.language, "Target")%>:</td>
    <td ><input  name="target" value="<%=target%>" id="target">
      <select onChange="form1.target.value=this.options[this.selectedIndex].value;">
        <option value="">--------</option>
        <option value="m"><%=r.getString(h.language, "RightFrame")%></option>
        <option value="_blank">_blank</option>
        <option value="_parent">_parent</option>
        <option value="_self">_self</option>
        <option value="_top">_top</option>
      </select>
    </td>
  </tr>
  <tr>
    <td><%=r.getString(h.language, "CBSetVisible")%>:</td>
    <td><input type="checkbox" name="hidden" <%if(!show)out.print(" checked ");%> /></td>
  </tr>
  <tr>
    <td colspan="2" align="center" >
    <%
    if(root.id!=id)
    {
      out.println("<input type=submit onClick=\"return sub1()\" value="+r.getString(h.language, "AddMateMenu")+" name=Submit1 >");
    }
    if(type==0)
    {
      out.println("<input type=submit onClick=\"return sub2()\" value="+r.getString(h.language, "AddSubmenu")+" name=Submit2 >");
    }
    %>
    <input id="Submit2" type="submit" onClick="return sub3()" value="<%=r.getString(h.language, "CBEdit")%>" name="Submit2">
    <input id="Submit2" type="submit" onClick="return sub4()" value="<%=r.getString(h.language, "CBDelete")%>" name="Submit2">
    </td>
  </tr>
</TABLE>


<br>
<h2><%=r.getString(h.language,"1215573880053")%></h2>
<br>
<table border="0" cellPadding="0" cellSpacing="0"  id="tablecenter">
  <tr>
    <td><%=r.getString(h.language, "CBClone")%>:</td>
    <td>
      <input name="clone"/>
      <input type="CHECKBOX" name="sonclone" id="sonclone"/><label for="sonclone"><%=r.getString(h.language, "IncSubmenu")%></label>
      <input type="submit" onClick="return sub5()" value="<%=r.getString(h.language, "Submit")%>"/>
    </td>
  </tr>
  <tr>
    <td><%=r.getString(h.language, "CBMove")%>:</td>
    <td>
      <input name="move"/>
      <input type="submit" onClick="return sub6()" value="<%=r.getString(h.language, "Submit")%>"/>
    </td>
  </tr>
</table>
<br>

<!-- input type="button" onClick="window.open('/jsp/admin/popedom/AdminFunctionGroup.jsp?community=<%=h.community%>','_self');" value="<%=r.getString(h.language,"1215739969069")%>"/-->

<%
if(type==0&&request.getParameter("bg")!=null)
{
  out.print("<h2>菜单组创建</h2>");
  out.print("<select name=name7 onchange=sub7()><option value=''>----------------");
  for(int i=0;i<AdminFunction.GROUP_NAME.length;i++)
  {
    String tmp=AdminFunction.GROUP_NAME[i];
    out.print("<option value="+tmp+">"+tmp);
  }
  out.print("</select>");
}
if(h.debug)
{
  out.print("<input type='button' value='ACTION' onclick=form1.act.value='action';form1.submit(); />");
}
%>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(h.language,request)%></div>--%>
</body>
</html>
