<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"%><%@page import="java.util.*" %><%@page import="tea.entity.site.*" %><%@ page import="tea.resource.Resource"%><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

String menuid=request.getParameter("id");

CommunityOption co=CommunityOption.find(teasession._strCommunity);
String csunit=co.get("flowcsunit");
String csmember=co.get("flowcsmember");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script type="">
function f_submit()
{
  var h='/';
  var op=form1.unit2.options;
  for(var i=0;i<op.length;i++)
  {
    h=h+op[i].value+'/';
  }
  form1.flowcsunit.value=h;
  h='/';
  op=form1.member2.options;
  for(var i=0;i<op.length;i++)
  {
    if(op[i].value!='')h=h+op[i].value+'/';
  }
  form1.flowcsmember.value=h;
}
</script>
</head>
<body>

<h1>管理会签候选人员或部门</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>部门</h2>
<form name="form1" action="/servlet/EditCommunityOption" target="_ajax" method="post" onsubmit="return f_submit();">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="name" value="/flowcsunit/flowcsmember/">
<input type="hidden" name="flowcsunit" value="<%=csunit%>"/>
<input type="hidden" name="flowcsmember" value="<%=csmember%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap>备选部门</td>
    <td nowrap>&nbsp;</td>
    <td nowrap>选定部门</td>
  </tr>
  <tr>
    <td>
      <select name="unit1" size="15" multiple style="width:200" ondblclick="move(form1.unit1,form1.unit2,false);">
      <%
      StringBuilder sb=new StringBuilder();
      StringBuilder js=new StringBuilder();
      Enumeration au_enumer=AdminUnit.findByCommunity(teasession._strCommunity,"");
      while(au_enumer.hasMoreElements())
      {
        AdminUnit au=(AdminUnit)au_enumer.nextElement();
        int id=au.getId();
        String pre=au.getPrefix();
        String name=pre+au.getName();
        String str="<option value='"+id+"'>"+name;
        out.print(str);
        sb.append(str);
        js.append("if(v==''||v=='").append(id).append("'){ if(v=='')op[op.length]=new Option('"+name+"','');");
        pre=pre.replaceFirst("├","");
        Enumeration aus_enumer=AdminUnitSeq.findByCommunity(teasession._strCommunity,id,true);
        while(aus_enumer.hasMoreElements())
        {
          String member=(String)aus_enumer.nextElement();
          js.append("text='"+member+"'; if(v=='')text='　　"+pre+"'+text;  op[op.length]=new Option(text,'"+member+"');");
        }
        js.append("}");
      }
      %>
      </select>
    </td>
    <td><input type="button" name="u1" value=" → " onClick="move(form1.unit1,form1.unit2,false);">
      <br>
      <input type="button" name="u2" value=" ← " onClick="move(form1.unit2,form1.unit1,true);"></td>
    <td>
      <select name="unit2" size="15" multiple style="width:200" ondblclick="move(form1.unit2,form1.unit1,true);">
      <%
      if(csunit!=null)
      {
        String csu[]=csunit.split("/");
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

<h2>人员</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap>备选人员</td>
    <td nowrap>&nbsp;</td>
    <td nowrap>选定人员</td>
  </tr>
  <tr>
    <td>
      <select onchange="f_addmember(value)" style="width:200">
      <option value="">---------------------------------------------</option>
      <%=sb.toString()%>
      </select><br>
      <select name="member1" size="14" multiple style="width:200" ondblclick="move(form1.member1,form1.member2,false);">
    </select>
    </td>
    <td><input type="button" name="m1" value=" → " onClick="move(form1.member1,form1.member2,false);">
        <br>
        <input type="button" name="m2" value=" ← " onClick="move(form1.member2,form1.member1,true);"></td>
    <td><select name="member2" size="15" multiple style="width:200" ondblclick="move(form1.member2,form1.member1,true);">
    <%
    if(csmember!=null)
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
  </tr>
</table>
<input type="submit" value="<%=r.getString(teasession._nLanguage,"CBSubmit")%>" >
</form>

<script type="">
function f_addmember(v)
{
  var op=form1.member1.options;
  while(op.length>0)
  {
    op[0]=null;
  }
  <%=js.toString()%>
}
f_addmember('');
function f_time()
{
  var flag=form1.unit1.selectedIndex==-1;
  form1.u1.disabled=flag;
  form1.u1.style.backgroundColor=flag?"#CCCCCC":"";

  flag=form1.unit2.selectedIndex==-1;
  form1.u2.disabled=flag;
  form1.u2.style.backgroundColor=flag?"#CCCCCC":"";
  //
  var flag=form1.member1.selectedIndex==-1;
  form1.m1.disabled=flag;
  form1.m1.style.backgroundColor=flag?"#CCCCCC":"";

  flag=form1.member2.selectedIndex==-1;
  form1.m2.disabled=flag;
  form1.m2.style.backgroundColor=flag?"#CCCCCC":"";
}
setInterval(f_time,100);
</script>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
