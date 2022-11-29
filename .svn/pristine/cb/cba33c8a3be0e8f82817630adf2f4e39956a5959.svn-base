<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.member.*" %><%@page import="tea.entity.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.ui.TeaSession" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");
int flowprocess=Integer.parseInt(request.getParameter("flowprocess"));
Flowprocess fp=Flowprocess.find(flowprocess);

String nexturl=request.getParameter("nexturl");
if(request.getMethod().equals("POST"))
{
  String manager=request.getParameter("manager");
  int extend=0;
  String tmp=request.getParameter("extend");
  if(tmp!=null)
  {
    extend=Integer.parseInt(tmp);
  }
  fp.setMember(manager,extend);
  out.print("<script>alert('您的修改信息已成功提交！');window.open('"+nexturl+"','_parent');</script>");
  return;
}

tea.resource.Resource r=new tea.resource.Resource();
//r.add("tea/resource/deptuser");

%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT SRC="/tea/mt.js" type="text/javascript"></SCRIPT>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<SCRIPT language="JavaScript">
function f_submit()
{
  var v="/";
  var op=form1.m1.options;
  for(var i=0;i<op.length;i++)
  {
    v=v+op[i].value+"/";
  }
  form1.manager.value=v;
}
function f_change()
{
  var bool=form1.extend.selectedIndex!=0;
  form1.m1.disabled=bool;
  form1.m2.disabled=bool;
}
function f_load()
{
  if(form1.extend)
  {
    form1.extend.value="<%=fp.getExtend()%>";
    f_change();
  }
}
</SCRIPT>
</head>
<BODY onLoad="f_load()">
<h1>编辑经办人</h1>
<div id="head6"><img  height="6"></div>


<form name="form1" action="?" method="post" target="_ajax" onSubmit="return f_submit();">
<input type="hidden" name="community" value="<%=community%>" >
<input type="hidden" name="nexturl" value="<%=nexturl%>" >
<input type="hidden" name="flowprocess" value="<%=flowprocess%>">
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type=hidden name=manager value="/">

<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap></td>
    <td nowrap>选定经办人</td>
    <td></td>
    <td nowrap>备选经办人</td>
  </tr>
  <tr>
    <td>经办人:</td>
    <td width="300px">
<select name="m1" size="20" style="width:280px" multiple ondblclick="move(form1.m1,form1.m2,true);">
<%
String manager = fp.getMember();
String str[] = manager.split("/");
for (int i = 1; i < str.length; i++)
{
  //Profile p = Profile.find(str[i]);
  //AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,str[i]);
  //if(MT.f(aur.getRole()).length()<2)continue;
  out.print("<option value=\"" + str[i] + "\" >" + str[i]);
}
%>
</select>
<%
if(!fp.isCheckbox())
{
  out.print("<select name=extend style=width:280px onchange='f_change()'>");
  out.print("<option value='0'>--------同哪步经办人----------");
  Enumeration e3=Flowprocess.find(fp.getFlow()," AND flowprocess!="+flowprocess+" AND checkbox=0");
  while(e3.hasMoreElements())
  {
    int fpid=((Integer)e3.nextElement()).intValue();
    Flowprocess fp2=Flowprocess.find(fpid);
    out.print("<option value="+fpid+">"+fp2.getStep()+". "+fp2.getName(teasession._nLanguage));
  }
  out.print("</select>");
}
%>

<td>
  <input type=button value=" ← " onClick="move(form1.m2,form1.m1,false);">
  <br>
  <input type=button value=" → " onClick="move(form1.m1,form1.m2,true);">

  <td>
    <select name="m2" size="22" style="width:280px" multiple onDblClick="move(form1.m2,form1.m1,false);">
    <%
    int root=AdminUnit.getRootId(teasession._strCommunity);
    Enumeration e = AdminUnit.findByCommunity(teasession._strCommunity, "");
    for (int intCount = 1; e.hasMoreElements(); intCount++)
    {
      AdminUnit au_fp=(AdminUnit)e.nextElement();
      int unltid=au_fp.getId();
      Enumeration e2 = AdminUsrRole.findByUnit(unltid, teasession._strCommunity);
      if (e2.hasMoreElements())
      {
        int fid=au_fp.getFather();
        out.print("<optgroup label="+(fid!=root?AdminUnit.find(fid).getName()+"-":"")+au_fp.getName()+"></optgroup>");
        while (e2.hasMoreElements())
        {
          String _member = (String) e2.nextElement();
          //AdminUsrRole fp=AdminUsrRole.find(teasession._strCommunity,member);
          Profile p = Profile.find(_member);
          if (p == null)continue;
          String name=p.getName(teasession._nLanguage);
          out.print("<option value=\"" + _member+"\" >　"+_member+"</option>");
        }
      }
    }
    %>
    </select>

  </tr>
</table>
      <%--<input type=button value=添加 onclick="window.showModalDialog('/jsp/sms/psmanagement/FrameGU.jsp?type=1&field=member&index=form1.manager','','edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:400px;dialogHeight:320px;');" >--%>



<input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
<input type="button" value="返回" onClick="history.back();">


<div id="head6"><img  height="6"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</BODY>
</HTML>
