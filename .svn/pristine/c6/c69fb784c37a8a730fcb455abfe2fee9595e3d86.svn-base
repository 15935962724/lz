<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"%><%@page import="java.util.*" %><%@page import="tea.entity.site.*" %><%@ page import="tea.resource.Resource"%><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String nu=request.getParameter("nexturl");
int flowbusiness=Integer.parseInt(request.getParameter("flowbusiness"));
Flowbusiness fb=Flowbusiness.find(flowbusiness);

if("POST".equals(request.getMethod()))
{
  String fbcsunit=request.getParameter("fbcsunit");
  String fbcsmember=request.getParameter("fbcsmember");
  fb.setCSign(fbcsunit,fbcsmember);
  response.sendRedirect("/jsp/admin/flow/EditFlowbusinessNext.jsp?community=" + teasession._strCommunity + "&flowbusiness=" + flowbusiness + "&nexturl=" + java.net.URLEncoder.encode(nu, "UTF-8"));
  return;
}

Resource r=new Resource();

String menuid=request.getParameter("id");

//备选
CommunityOption co=CommunityOption.find(teasession._strCommunity);
String csunit=co.get("flowcsunit");
String csmember=co.get("flowcsmember");

//事务
String fbcsunit=fb.getCSUnit();
String fbcsmember=fb.getCSMember();

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function f_submit()
{
  var h='/';
  var op=form1.unit2.options;
  for(var i=0;i<op.length;i++)
  {
    h=h+op[i].value+'/';
  }
  form1.fbcsunit.value=h;
  h='/';
  op=form1.member2.options;
  for(var i=0;i<op.length;i++)
  {
    if(op[i].value!='')h=h+op[i].value+'/';
  }
  form1.fbcsmember.value=h;
}
</script>
</head>
<body>

<h1>会签候选人员或部门</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="post" onsubmit="return f_submit();">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="fbcsunit" value="<%=fbcsunit%>"/>
<input type="hidden" name="fbcsmember" value="<%=fbcsmember%>"/>
<input type="hidden" name="flowbusiness" value="<%=flowbusiness%>"/>
<input type="hidden" name="nexturl" value="<%=nu%>"/>

<%
if(csunit!=null&&csunit.length()>1)
{
%>
<h2>部门</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap>备选部门</td>
    <td nowrap>&nbsp;</td>
    <td nowrap>选定部门</td>
  </tr>
  <tr>
    <td>
      <select name="unit1" size="10" multiple style="width:200" ondblclick="move(form1.unit1,form1.unit2,false);">
      <%
      if(csunit!=null)
      {
        String csu[]=csunit.split("/");
        for(int i=1;i<csu.length;i++)
        {
          int id=Integer.parseInt(csu[i]);
          AdminUnit au=AdminUnit.find(id);
          if(au.isExists())
          {
            out.print("<option value='"+id+"'>"+au.getName());
          }
        }
      }
      %>
      </select>
    </td>
    <td><input type="button" name="u1" value=" → " onClick="move(form1.unit1,form1.unit2,false);">
      <br>
      <input type="button" name="u2" value=" ← " onClick="move(form1.unit2,form1.unit1,true);"></td>
    <td>
      <select name="unit2" size="10" multiple style="width:200" ondblclick="move(form1.unit2,form1.unit1,true);">
      <%
      if(fbcsunit!=null)
      {
        String csu[]=fbcsunit.split("/");
        for(int i=1;i<csu.length;i++)
        {
          AdminUnit au=AdminUnit.find(Integer.parseInt(csu[i]));
          if(au.isExists())
          {
            out.print("<option value="+csu[i]+">"+au.getName());
          }
        }
      }
      %>
      </select>
    </td>
  </tr>
</table>
<%
}
if(csmember!=null&&csmember.length()>1)
{
%>
<h2>人员</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap>备选人员</td>
    <td nowrap>&nbsp;</td>
    <td nowrap>选定人员</td>
  </tr>
  <tr>
    <td>
      <select name="member1" size="10" multiple style="width:200" ondblclick="move(form1.member1,form1.member2,true);">
      <%
      {
        String csm[]=csmember.split("/");
        for(int i=1;i<csm.length;i++)
        {
          out.print("<option value="+csm[i]+">"+csm[i]);
        }
      }
      %>
      </select>
    </td>
    <td><input type="button" name="m1" value=" → " onClick="move(form1.member1,form1.member2,true);">
      <br>
        <input type="button" name="m2" value=" ← " onClick="move(form1.member2,form1.member1,true);"></td>
        <td><select name="member2" size="10" multiple style="width:200" ondblclick="move(form1.member2,form1.member1,true);">
        <%
        if(fbcsmember!=null)
        {
          String csm[]=fbcsmember.split("/");
          for(int i=1;i<csm.length;i++)
          {
            out.print("<option value="+csm[i]+">"+csm[i]);
          }
        }
        %>
        </select>
        </td>
  </tr>
</table>
<%}%>
<input type="submit" value="<%=r.getString(teasession._nLanguage,"CBSubmit")%>" >
<input type="button" value="返回" onclick="history.back()"/>
</form>

<script type="">
function f_time()
{
  if(form1.unit1)
  {
    var flag=form1.unit1.selectedIndex==-1;
    form1.u1.disabled=flag;
    form1.u1.style.backgroundColor=flag?"#CCCCCC":"";

    flag=form1.unit2.selectedIndex==-1;
    form1.u2.disabled=flag;
    form1.u2.style.backgroundColor=flag?"#CCCCCC":"";
  }
  if(form1.member1)
  {
    var flag=form1.member1.selectedIndex==-1;
    form1.m1.disabled=flag;
    form1.m1.style.backgroundColor=flag?"#CCCCCC":"";

    flag=form1.member2.selectedIndex==-1;
    form1.m2.disabled=flag;
    form1.m2.style.backgroundColor=flag?"#CCCCCC":"";
  }
}
setInterval(f_time,100);

if(!confirm("你是否设置会签人员?"))
{
  form1.submit();
}
</script>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
