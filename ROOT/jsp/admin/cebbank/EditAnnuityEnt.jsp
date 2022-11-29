<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.io.*" %><%@page import="tea.entity.admin.cebbank.*" %><%@page import="java.math.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;


Resource r=new Resource("/tea/resource/Annuity");


int strid=Integer.parseInt(request.getParameter("annuityent"));
int sequence=0;
int plansum=0;
int fundsum=0;
BigDecimal assets=null;
int personsum=0;
String code=null;
String psword=null;

String name=null;
String content=null;
if(strid!=0)
{
  AnnuityEnt af_obj=AnnuityEnt.find(strid);
  if(!af_obj.isExists())
  {
    response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("该项已经不存在了.","UTF-8"));
    return;
  }

  sequence=af_obj.getSequence();
  plansum=af_obj.getPlansum();
  fundsum=af_obj.getFundsum();
  assets=af_obj.getAssets();
  personsum=af_obj.getPersonsum();
  code=af_obj.getCode();
  psword=af_obj.getPsword();

  name=af_obj.getName(teasession._nLanguage);
  content=af_obj.getContent(teasession._nLanguage);
}

%>
<html>
<head>
<title>DeskTop</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">
<SCRIPT language="JavaScript">
function sub1()
{
  if((document.fun.name.value==document.fun.hmc.value))
  {
    alert("<%=r.getString(teasession._nLanguage, "CannotAddHomonymyManage")%>");
    return false;
  }else
  {
    fun.sub.value=1;
  }
  return submitText(fun.name,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')&&submitInteger(fun.sx,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>');
}

function sub2()
{
  if((document.fun.name.value==document.fun.hmc.value))
  {
    alert("<%=r.getString(teasession._nLanguage, "CannotAddHomonymyManage")%>");
    return false;
  }else
  {
    fun.sub.value=2;
  }
  return submitText(fun.name,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')&&submitInteger(fun.sx,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>');
}

function sub3()
{
  fun.sub.value=3;
  return submitText(fun.name,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')&&submitInteger(fun.sx,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>');
}

function sub4()
{
  fun.sub.value=4;
  return (confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'));
}

function sub5()
{
  fun.sub.value=5;
  return submitInteger(fun.clone,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>');
}

function sub6()
{
  fun.sub.value=6;
  return true;
}

function sub7(value)
{
  fun.sub.value=7;
  fun.name7.value=value;
  return true;
}

</SCRIPT>
</head>
<body onload="fun.name.focus();">
<h1><%=r.getString(teasession._nLanguage, "企业管理")%></h1>
<div id="head6"><img height="6" alt=""></div>
<br>


<form method="post" enctype="multipart/form-data" name="fun" id="fun" action="/servlet/EditAnnuityEnt">
<input  type="hidden" name="Node" value="<%=teasession._nNode%>">
<input  type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input  type="hidden" name="act" value="editannuityent">
<input  type="hidden" name="sub" value="0">

<h2>添加/编辑</h2>
  <table border="0" cellPadding="0" cellSpacing="0"  id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage, "当前所选择的企业")%>:</td>
      <td><input type="hidden" name="annuityent" value="<%=strid%>"><%=name%></td>
    </tr>
    <tr>
      <td  ><%=r.getString(teasession._nLanguage, "Name")%>:</td>
      <td  ><input id="hmc" type="hidden" name="hmc" value="<%=name%>">
        <input name="name" type="text"  size="45" value="<%=name%>" ></td>
    </tr>

    <tr>
      <td>参加计划数:</td>
      <td><input name="plansum" type="hidden" value="<%=plansum%>">
        <input name="plansum" type="text" value="<%=plansum%>"  onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "投资组合数目")%>:</td>
      <td><input type="text" name="fundsum" value="<%=fundsum%>" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;"></td>
    </tr>
	<tr>
      <td><%=r.getString(teasession._nLanguage, "总资产")%>:</td>
      <td><input name="assets" value="<%if(assets!=null)out.print(assets);else out.print("0.00");%>" onKeyPress="if(event.keyCode!=46&&(event.keyCode<48||event.keyCode>57))event.returnValue=false;"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "总人数")%>:</td>
      <td><input  name="personsum" value="<%=personsum%>"  onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Sequence")%>:</td>
      <td><input name="sequence"  type="text" value="<%=sequence%>"  onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;"></td>
    </tr>
<!--
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Content")%>:</td>
      <td><textarea name="content" cols="40" rows="4"><%if(content!=null)out.print(content.replaceAll("</","&lt;/"));%></textarea></td>
    </tr>
-->
    <tr><td colspan="2"><hr size="1"/></td></tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "客户号")%>:</td>
    <td><%=strid%></td>
    </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "用户名")%>:</td>
    <td><input type="text" name="code" value="<%if(code!=null)out.print(code);%>" /></td>
    </tr>
    <tr>
      <td colspan="2" align="center" >
      <%
      if(AnnuityEnt.getRootId(teasession._strCommunity)!=strid)
      {
        out.println("<input type=submit onClick=\"return sub1()\" value="+r.getString(teasession._nLanguage, "添加同级企业")+" name=Submit1 >");
      }
      %>
      <input type=submit onClick="return sub2()" value="<%=r.getString(teasession._nLanguage, "添加子级企业")%>" name=Submit2 >
      <input id="Submit2" type="submit" onClick="return sub3()" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" name="Submit2">
      <input id="Submit2" type="submit" onClick="return sub4()" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" name="Submit2"></td>
    </tr>
  </TABLE>


<br>
<h2>移动/复制</h2>
  <table border="0" cellPadding="0" cellSpacing="0"  id="tablecenter">
    <tr>
      <td>
<%=r.getString(teasession._nLanguage, "CBClone")%>:
</td><td>
<input type="text" name="clone"/>
<input type="CHECKBOX" name="sonclone" id="sonclone"/><label for="sonclone"><%=r.getString(teasession._nLanguage, "IncSubmenu")%></label>
<input type="submit" onClick="return sub5()" value="<%=r.getString(teasession._nLanguage, "Submit")%>"/>
</td></tr>
    <tr>
      <td>
<%=r.getString(teasession._nLanguage, "CBMove")%>:
</td><td>
<input type="text" name="move"/>
<input type="submit" onClick="return sub6()" value="<%=r.getString(teasession._nLanguage, "Submit")%>"/>
</td></tr>
</table>
<!-- input type="submit" onClick="return sub6()" value="　"/-->

<br>

</form>

<br>
<div id="head6"><img height="6" alt=""></div>
<br>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>



