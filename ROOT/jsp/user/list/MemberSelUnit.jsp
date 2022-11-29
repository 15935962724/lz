<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.*" %>
<%@page import="tea.resource.Resource"%><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.*" %><%@page import="java.util.*" %>
<%
request.setCharacterEncoding("UTF-8");




Resource r=new Resource();


Http h=new Http(request);


String field=h.get("field");
String[] member=h.get("member","").split("；");




%><html><head>
<title>添加收件人</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>

<form name="form1" onSubmit="f_ok();return false;">
<input type="hidden" name="act">


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>部门</td><td colspan="4">
<select name="sel1" onchange="f_act(this);">
<option value="0">--------</option>
<%
Enumeration e=AdminUnit.findByCommunity(h.community," ORDER BY sequence",0,200);
while(e.hasMoreElements())
{
  AdminUnit au=(AdminUnit)e.nextElement();
  out.print("<option value="+au.getId()+" member=\"");

  Enumeration e2=AdminUnitSeq.findByCommunity(h.community,au.getId(),true);
  while(e2.hasMoreElements())
  {
    String mid=(String)e2.nextElement();
    out.print(",'"+mid+"'");
  }
  out.print("\">"+au.getPrefix()+au.getName());
}
%>
  </select>
</td></tr>
<tr>
  <td>选择</td>
  <td>
  <table cellpadding="0" cellspacing="0">
  <tr><td>备选</td><td></td><td>已选</td>
  <tr><td>
  <select name="sel2" size="12" multiple style="width:140px" ondblclick="mt.move(form1.sel2,form1.sel3,true)">
  </select>
  </td>
  <td>
<input type="button" value=" &gt;&gt; " onclick="form1.sel2.ondblclick()"><br><br>
<input type="button" value=" &lt;&lt; " onclick="form1.sel3.ondblclick()"><br>
  </td>
  <td>
  <select name="sel3" size="12" multiple style="width:140px" ondblclick="mt.move(form1.sel3,form1.sel2,true);">
  <%
  for(int i=1;i<member.length;i++)
  {
    out.print("<option value='"+member[i]+"'>"+member[i]);
  }
  %>
  </select>
   </td></tr>
  </table>
  </td>
</tr>
</table>

<input type="submit" value="确定" onclick=""/>
<input type="button" value="关闭" onclick="pmt.close();"/>

</form>

<script>
var pmt=parent.mt,doc=parent.document;
function f_ise(op,v)
{
  for(var j=0;j<op.length;j++)
  {
    if(op[j].value==v)return true;
  }
  return false;
}
function f_act(a)
{
  var op=form1.sel2.options;
  while(op.length>0)op[0]=null;
  var arr=eval("[''"+a.options[a.selectedIndex].getAttribute('member')+"]");
  for(var i=1;i<arr.length;i++)
  {
    if(f_ise(op,arr[i]))continue;
    op[op.length]=new Option(arr[i],arr[i]);
  }
}
function f_ok()
{
  var m='',op=form1.sel3.options;
  for(var i=0;i<op.length;i++)m+=op[i].value+'；';
  doc.<%=field%>.value=m;
  pmt.close();
}
var m='',arr=form1.sel1.options;
for(var i=1;i<arr.length;i++)
{
  m+=arr[i].getAttribute('member');
}
arr[0].setAttribute('member',m);
form1.sel1.onchange();
</script>

</body>
</html>
