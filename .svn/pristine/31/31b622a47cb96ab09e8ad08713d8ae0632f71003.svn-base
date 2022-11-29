<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

if("POST".equals(request.getMethod()))
{
  String tmp=request.getParameter("sumprint");
  int sumprint=tmp==null||tmp.length()<1?0:Integer.parseInt(tmp);
  String[] arr=request.getParameter("flowview").split("/");
  for(int i=1;i<arr.length;i++)
  {
    Flowview fv=Flowview.find(Integer.parseInt(arr[i]));
    fv.setSumPrint(sumprint);
  }
  out.print("<script>alert('修改成功!');window.close();</script>");
  return;
}
int flowbusiness=Integer.parseInt(request.getParameter("flowbusiness"));
int flowprocess=Integer.parseInt(request.getParameter("flowprocess"));



%><html>
<head>
<title>补发</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script>
function f_name()
{
  var op=form1.s2.options;
  for(var i=0;i<op.length;i++)
  {
    var j=op[i].text.indexOf('[');
    if(j!=-1)op[i].text=op[i].text.substring(0,j);
  }
}
</script>
</head>
<body onload="window.focus();">

<form name="form1" action="?" method="post" onsubmit="form1.flowview.value=mt.value(form1.s2,'/');return f_sub()">
<input type="hidden" name="flowview" value="/"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr class="TableHeader">
    <td>备选</td>
    <td></td>
    <td>已选</td>
  </tr>
<tr>
  <td>
<select name="s1" size="10" style="width:150px" multiple ondblclick="move(form1.s1,form1.s2,false);f_name();">
<%
Enumeration e=Flowview.find(flowbusiness,flowprocess);
while(e.hasMoreElements())
{
  int flowview=((Integer)e.nextElement()).intValue();
  Flowview fv=Flowview.find(flowview);
  String t=fv.getTransactor(),r="["+fv.getUsePrint()+"/"+fv.getSumPrint()+"]";
  out.print("<option value="+flowview);
  out.print(">"+t);
  for(int i=t.getBytes().length+r.length();i<21;i++)
  out.print("&nbsp;");
  out.print(r);
}
%>
</select>
</td>
<td>
<input type="button" value=" &gt;&gt; " onclick="move(form1.s1,form1.s2,false);f_name();"/><br/><br/><input type="button" value=" &lt;&lt; " onclick="move(form1.s2,form1.s1,true)"/>
</td>
<td>
<select name="s2" size="10" style="width:150px" multiple ondblclick="move(form1.s2,form1.s1,true)"></select>
</td>
</tr>
<tr><td>补发</td><td><input name="sumprint" size="8" mask="int">份</td>
</table>

<input type="submit" value="提交"/>
<input type="button" value="关闭" onClick="window.close();">

</form>


</body>
</html>
