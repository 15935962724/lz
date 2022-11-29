<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.node.*" %><%@ page import="java.util.*" %><%@ page import="tea.ui.*" %><%@ page import="tea.html.*" %><%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
Resource r=new Resource();

r.add("/tea/resource/Classes");

String type=teasession.getParameter("type");
int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null)pos=Integer.parseInt(tmp);
String sql=" AND type = "+type+" AND community="+DbAdapter.cite(teasession._strCommunity);
StringBuffer par=new StringBuffer();
par.append("?community=").append(java.net.URLEncoder.encode(teasession._strCommunity,"UTF-8"));
par.append("&type=").append(type);
par.append("&pos=");
int sum=Classes.count(sql);
String title=r.getString(teasession._nLanguage, "ManageClasses");
%>
<html>
<head>
<title><%=title%></title>
<base target="dialog"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="text/javascript">
window.name="dialog";
function f_edit(id)
{
  var rs=window.showModalDialog('/jsp/type/classes/EditClasses.jsp?type='+form2.type.value+'&community='+form2.community.value+"&classid="+id,self,'status:0;help:0;dialogWidth:300px;dialogHeight:200px;scroll:0;');
  if(rs)window.open(location.href+"&t="+new Date().getTime(),window.name);
}
function f_edit2(id,vv)
{
  var rs=window.showModalDialog('/jsp/type/classes/EditClassesChild.jsp?classid='+id+'&type='+form2.type.value+'&community='+form2.community.value+"&cid="+vv,self,'status:0;help:0;dialogWidth:300px;dialogHeight:200px;scroll:0;');
  if(rs)window.open(location.href+"&t="+new Date().getTime(),window.name);
}
function f_edit3(id)
{
  var rs=window.showModalDialog('/jsp/type/classes/ClassesChild.jsp?community='+form2.community.value+"&cid="+id,self,'status:0;help:0;dialogWidth:400px;dialogHeight:600px;scroll:0;');
  if(rs)window.open(location.href+"&t="+new Date().getTime(),window.name);
}
function f_delete2(igd,igd2)
{
  form2.act.value='delete2';
  form2.clchid.value=igd2;
  form2.classid.value=igd;


  form2.action='/servlet/EditClasses';
  form2.submit();
}
</script>
</head>
<body>
<h1><%=title%>（点击名称编辑子类）</h1>
<form name="form2" action="/servlet/EditClasses" method="post">
<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="classid" value="0"/>
<input type="hidden" name="clchid"/>
<input type="hidden" name="type" value="<%=type%>"/>
<input type="hidden" name="act" value="del"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td>&nbsp;</td>
    <td><%=r.getString(teasession._nLanguage, "名称")%></td>
    <td><%=r.getString(teasession._nLanguage, "使用数")%></td>
    <td>&nbsp;</td>
  </tr>
<%
Enumeration e=Classes.find(sql,pos,10);
for(int i=pos+1;e.hasMoreElements();i++)
{
  int j=((Integer)e.nextElement()).intValue();
  Classes c=Classes.find(j);
  int use=Node.count(" AND node IN(SELECT node FROM Report WHERE classes="+j+")");
  out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
  out.print("<td>"+i+"</td>");
  out.print("<td><a style='cursor:hand' onClick=f_edit3("+j+") >"+c.getName()+"</a></td>");
  out.print("<td>"+use+"</td>");
  out.print("<td><input type='button' value="+r.getString(teasession._nLanguage, "CBEdit")+" onClick=f_edit("+j+");>");
  out.print(" <input type='button' value="+r.getString(teasession._nLanguage, "CBDelete")+" onClick=if(confirm('"+r.getString(teasession._nLanguage, "ConfirmDelete")+"')){form2.classid.value="+j+";form2.submit();}>");
  out.print(" <input type='button' value='创建子类' onClick=f_edit2(0,"+j+");>");
  out.print("</td>");
  out.print("</tr>");
  //显示子类
 if(ClassesChild.count(teasession._strCommunity," and class_id ="+j)>0)
 {
   java.util.Enumeration e2 = ClassesChild.findByCommunity(teasession._strCommunity," AND class_id="+j,0,Integer.MAX_VALUE);
   while(e2.hasMoreElements())
   {
     int clchid = ((Integer)e2.nextElement()).intValue();
     ClassesChild cchobj = ClassesChild.find(clchid);
     int use2=Node.count(" AND node IN(SELECT node FROM Report WHERE classes2="+clchid+")");
     out.print("<tr>");
     out.print("<td>&nbsp;</td>");
     out.print("<td>");
        out.print("&nbsp;&nbsp;&nbsp;└&nbsp;");
        out.print(cchobj.getName());
     out.print("</td>");
     out.print("<td>");
        out.print(use2);
     out.print("</td>");
     out.print("<td>");
        out.print("<input type='button' value="+r.getString(teasession._nLanguage, "CBEdit")+" onClick=f_edit2("+clchid+","+j+");>");
        out.print(" <input type='button' value="+r.getString(teasession._nLanguage, "CBDelete")+" onClick=f_delete2("+j+","+clchid+");>");

     out.print("</td>");
     out.print("</tr>");
   }
 }
}
if(sum>10)
{
  out.print("<tr><td colspan='4' align='right'>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,sum,10));
}
%>
</table>
<input type="button" value="创建类别" ID="CBNew" CLASS="CB" onClick="f_edit(0)">
</form>
</body>
</html>
