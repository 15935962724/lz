<%@page import="java.net.URLEncoder"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.ui.TeaSession"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Resource r=new Resource();



StringBuffer param=new StringBuffer();

StringBuffer sql=new StringBuffer(" and membertype=1 AND community="+DbAdapter.cite(teasession._strCommunity)+" AND member !="+DbAdapter.cite("webmaster"));

param.append("?community="+teasession._strCommunity+"&id="+request.getParameter("id"));

String name = teasession.getParameter("name");
if(name!=null && name.length()>0){
	param.append("&name=").append(URLEncoder.encode(name,"UTF-8"));
}else
{
	name="";	
}


String memberids = teasession.getParameter("memberids");
if(memberids!=null && memberids.length()>0)
{
   sql.append(" and member like ").append(DbAdapter.cite("%"+memberids+"%"));
   param.append("&memberids=").append(java.net.URLEncoder.encode(memberids,"UTF-8"));
}
String membername = teasession.getParameter("membername");
if(membername!=null && membername.length()>0)
{
  sql.append(" and member in (select member from ProfileLayer  where FirstName like "+DbAdapter.cite("%"+membername+"%")+" or LastName like   "+DbAdapter.cite("%"+membername+"%")+" )");
  param.append("&membername=").append(java.net.URLEncoder.encode(membername,"UTF-8"));
} 
int count=0;
int pos=0;
int pageSize=10;
if( teasession.getParameter("pos")!=null)
{
  pos=Integer.parseInt(  teasession.getParameter("pos"));
}
count = Profile.count(sql.toString());

%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
window.name='tar';
function CheckAll(){
var checkname=document.getElementsByName("checkall");
var fname=document.getElementsByName("fname");
var lname="";
if(checkname[0].checked){
    for(var i=0; i<fname.length; i++){
      fname[i].checked=true;
}
}else{
   for(var i=0; i<fname.length; i++){
      fname[i].checked=false;
   }
}
}

//点击提交
function f_submit()
{
  var s = document.getElementsByName("fname");
  var s2 = "/";
  for( var i = 0; i < s.length; i++ ) {
    if ( s[i].checked ){
      s2 =s2+ s[i].value.trim()+'/';
    }
  }
 // s2 = s2.substr(0,s2.length-1);
 /*
var n = form1.name.value;
 if(n!='' && n!='/' )
	 { 
	   s2 = n.substring(0,n.length-1) +s2;
	 }
 */
 

  window.returnValue=s2;
  window.close();
}
function f_close()
{
  window.returnValue="";
  window.close();
}
</script>
</head>
<body >
<h1>选择会员</h1>
<form name="form1" action="?" method="GET" target="tar">

<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="act">
<input type="hidden" name="name" value="<%=name %>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">

    <td nowrap>会员ID:</td>
    <td nowrap><input type="text" name="memberids" value="<%if(memberids!=null)out.print(memberids);%>"></td>
    <td nowrap>会员名称</td>
      <td nowrap><input type="text" name="membername" value="<%if(membername!=null)out.print(membername);%>"></td>
      <td nowrap><input type="submit"  value="提交"></td>
  </tr>
</table>


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr">
<td width="1" nowrap="nowrap"><input type="checkbox" name="checkall" onclick="CheckAll('fname','checkall')" /></td>
    <td nowrap>会员ID</td>
	<td nowrap>会员名称</td>
</tr>
<%

java.util.Enumeration e = Profile.find(sql.toString(),pos,pageSize);
if(!e.hasMoreElements())
{
    out.print("<tr><td colspan=100 align=center>暂无记录</td></tr>");
}
for(int i=1;e.hasMoreElements();i++)
{
	String member =((String)e.nextElement());

   Profile pobj = Profile.find(member);




   	tea.entity.util.Card cobj = tea.entity.util.Card.find(pobj.getProvince(teasession._nLanguage));
   	
   	String cname = cobj.toString2();

    
    
%>
 <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
 <td><input type="checkbox" name="fname" value="<%=member%>" <%if(name!=null && name.length()>0 && name.indexOf("/"+member+"/")!=-1){out.print(" checked ");} %>></td>
    <td><%=member%></td>
	<td nowrap><%=pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage) %></td>

</tr>
<%}%>
  <%if (count > pageSize) { %>
   <tr> <td colspan="10" id="tdpage"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
  <%
 out.print("<script>document.getElementById('go').style.display='none';</script>");
}  %>
</table>

<input type="button" value="确定" onclick="f_submit();"/>
<input type="button" value="关闭" onclick="f_close();"/>

</form>
<script>
var as=document.getElementById("tdpage");
if(as)
{
  as=as.getElementsByTagName("A");

  for(var i=0;i<as.length;i++)
  {
    as[i].setAttribute("target","tar");
  }
}

</script>
</body>
</html>
<!--
参数说明:
type
0:通迅录人员
1:内部人员(可以进后台的)

field:
没有:手机号
email:邮箱
member:会员ID
-->

