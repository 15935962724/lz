<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"%><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><%@page import="tea.entity.*"%><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}

String _strId=request.getParameter("id");

Resource r=new Resource("/tea/resource/Group");

StringBuffer sql=new StringBuffer();
StringBuffer param=new StringBuffer();
param.append("?community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);


String name=request.getParameter("name");
if(name!=null&&name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name.replaceAll(" ","%")+"%"));
  param.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
}

int groupid=0;
if(request.getParameter("groupid")!=null)
{
  groupid=Integer.parseInt(request.getParameter("groupid"));
}
if(groupid!=0)
{
  sql.append(" AND groupid=").append(groupid);
  param.append("&groupid=").append(groupid);
}

param.append("&pos=");

int count=SMSPhoneBook.count(teasession._strCommunity,Entity.DEFAULT_MEMBER,sql.toString());

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<br>
<h1><%=r.getString(teasession._nLanguage,"朋友")+"( "+count+" )"%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<h2><%=r.getString(teasession._nLanguage,"Search")%></h2>
<form action="<%=request.getRequestURI()%>" method="get">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=_strId%>"/>


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td><%=r.getString(teasession._nLanguage,"Name")%>:<input type="text" value="<%if(name!=null)out.print(name);%>" name="name"/></td>
  <td><%=r.getString(teasession._nLanguage,"GroupName")%>:<select name=groupid size=1 >
<option value=0 >---------</option>
<%
java.util.Enumeration enumer=SMSGroup.findByMember(teasession._strCommunity,Entity.DEFAULT_MEMBER);
while(enumer.hasMoreElements())
{
    SMSGroup smsg=SMSGroup.find(((Integer)enumer.nextElement()).intValue());
  out.print("<option value="+smsg.getId());
  if(groupid==smsg.getId())
  out.print(" SELECTED ");
  out.print(">"+smsg.getName()) ;
} %>
        </select></td>
        <td><input type="submit" value="GO"/>
        </td>
</tr>
</table>
</form>
<br>

<h2><%=r.getString(teasession._nLanguage,"列表")%></h2>
<form name=form1 method=post action="/servlet/EditContact">
<input type=hidden name="community" value="<%=teasession._strCommunity%>">
<script>document.write("<input type=hidden name=nexturl value="+document.location+" >");</script>
<input type=hidden name="act" value="communitydeletephonebook">

   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr  id="tableonetr">
      <td nowrap width="1">&nbsp;</td>
      <td><%=r.getString(teasession._nLanguage,"Name")%></td>
      <td><%=r.getString(teasession._nLanguage,"mobile")%></td>
      <td><%=r.getString(teasession._nLanguage,"phone")%></td>
      <td><%=r.getString(teasession._nLanguage,"GroupName")%></td>
      <td>E-mail</td>
      <td><%=r.getString(teasession._nLanguage,"MemberId")%></td>
      <td><%=r.getString(teasession._nLanguage,"operation")%></td>
    </tr>
    <%

    enumer= SMSPhoneBook.find(teasession._strCommunity,Entity.DEFAULT_MEMBER,sql.toString(),pos,10);
    while(enumer.hasMoreElements())
    {
      SMSPhoneBook smspb=SMSPhoneBook.find(((Integer)enumer.nextElement()).intValue());
      SMSGroup smsg=SMSGroup.find(smspb.getGroupid());

      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td  nowrap width="1"><input type="CHECKBOX" name="id"  value="<%=smspb.getId()%>"></td>
          <td><%=smspb.getName()%>&nbsp;</td>
          <td><%=smspb.getMobile()%>&nbsp;</td>
          <td><%=smspb.getTelephone()%>&nbsp;</td>
          <td><%if(smsg.getName()!=null)out.print(smsg.getName());%>&nbsp;</td>
          <td ><%=smspb.getEmail()%>&nbsp;</td>
          <td ><%=smspb.getMemberx()%>&nbsp;</td>
          <td><input type="button" onclick="window.open('/jsp/sms/psmanagement/CommunityEditPhoneBook.jsp?community=<%=teasession._strCommunity%>&id=<%=smspb.getId()%>&nexturl='+encodeURIComponent(document.location),'_self');" value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" ></td>
      </tr>
      <%
      }
      %>

    <tr>
      <td   nowrap colspan="2"><input type="CHECKBOX" onClick="javascript:selectall(this);" value="0"><%=r.getString(teasession._nLanguage,"SelectAll")%>
      </td>
      <td  colspan="4" align=right >
      <%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(), pos, count)%>
      <td>
    </tr>
  </table>

<input type="button" onClick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){javascript:form1.submit();}"  value="<%=r.getString(teasession._nLanguage,"CBDelete")%>">
<input type="button" onClick="window.location='/jsp/sms/psmanagement/CommunityEditPhoneBook.jsp?id=0&nexturl='+encodeURIComponent(document.location);" name="Submit" value="<%=r.getString(teasession._nLanguage,"Add")%>">
</form>
<br><br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>

<p>
  <script language=JavaScript type="text/javascript">
 function judge(id,name){
   if (confirm("是否要从电话本中删除这些联系人?"))
   {
     document.forms["form1"].submit();
   }
 }
 function CheckValue(myform)
 {
    if(myform.pname.value=="")
    {
       alert("请输入姓名！");
       return false;
    }
    if(myform.mobile.value=="")
    {
       alert("请输入手机号码！");
       return false;
    }
/*    if(myform.gid.value==0)
    {
       alert("请选择组！");
       return false;
    }
*/
    return true;
 }
 function changegroup(select){
       window.location="<%=request.getRequestURI()%>?groupid="+select.options[select.selectedIndex].value;
 }
 function notice()
 {

 }
function selectall(check)
{
   var myform=document.forms["form1"];
   var i;
   for(i=0;i<myform.elements.length;i++)
   {
      if(myform.elements[i].type=='checkbox') myform.elements[i].checked=check.checked;
   }
}
</script>
</p>
</body>
</html>
