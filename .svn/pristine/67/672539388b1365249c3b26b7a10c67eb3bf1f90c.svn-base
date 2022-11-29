<%@page contentType="text/html;charset=UTF-8"
%><%@page import="tea.db.DbAdapter" %><%@page import="tea.entity.member.*"
%><%@page import="tea.entity.site.*" %><%@page import="tea.entity.*"
%><%@page import="tea.htmlx.*" %><%@page import="tea.resource.*"
%><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.*"
%><%@page import="tea.ui.TeaSession" %><%@page import="java.util.*"%><%@page import="tea.entity.integral.*" %>
<%@page import="tea.entity.admin.mov.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

tea.entity.node.AccessMember am = null;
if (teasession._rv != null)
{

  am = tea.entity.node.AccessMember.find(teasession._nNode, teasession._rv._strV);

}


tea.entity.node.Node node = tea.entity.node.Node.find(teasession._nNode);


String community = teasession._strCommunity;

Resource r=new Resource("/tea/htmlx/HtmlX");
r.add("/tea/ui/member/community/Subscribers");
r.add("/tea/ui/member/community/Communities");

String s1 = request.getParameter("pos");
int pos = s1 == null ? 0 : Integer.parseInt(s1);

//StringBuffer sql=new StringBuffer(" AND s.vmember NOT IN(SELECT member FROM AdminUsrRole WHERE role!='/' AND community="+DbAdapter.cite(community)+")");
StringBuffer sql=new StringBuffer("");
StringBuffer param=new StringBuffer();

String act = teasession.getParameter("act");
param.append("&act=").append(act);
String member=request.getParameter("member");
if(member!=null&&(member=member.trim()).length()>0)
{
  sql.append(" AND m.member LIKE "+DbAdapter.cite("%"+member.replaceAll(" ","%")+"%"));
  param.append("&member="+java.net.URLEncoder.encode(member, "UTF-8"));
}

String states=request.getParameter("states");
int size = 15;
int count=MemberOrder.countMP(teasession._strCommunity,sql.toString());//Profile.count(community,sql.toString());

sql.append(" ORDER BY time DESC");
%>
<html>
<head>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
function fcheck()
{
  if(form2.members)
  {
    if(form2.members.checked)
    return true;
    for (var index=0;index<form2.members.length;index++)
    {
      if(form2.members[index].checked)
      return true;
    }
  }
  alert('无效选择');
  return false;
}

function fal(val)
{
  form2.members.checked=(form2.members.value==val);
  for (var index=0;index<form2.members.length;index++)
  {
    form2.members[index].checked=(form2.members[index].value==val);
  }
}

function f_act()
{
  if(!submitCheckbox(form2.members,'<%=r.getString(teasession._nLanguage, "InvalidSelect")%>'))return;
  
	  var members2="/";
	 
	  if(typeof(form2.members.length)=='undefined')
	 {
		  members2 =members2+form2.members.value+"/";
	 }else{
		  for(var i=0;i<form2.members.length;i++)
		  { 
			  if(form2.members[i].checked){
			     members2 =members2+form2.members[i].value+"/";
			   }
		  }

	  }
    var rs=window.showModalDialog('/jsp/orth/SetIntegral.jsp?members2='+encodeURIComponent(members2)+'&act='+form2.act.value,self,'scroll:0;status:0;help:0;resizable:1;dialogWidth:600px;dialogHeight:220px;');
    if(!rs)return;
    window.location.reload();  
  //  var arr=rs;
	//form2.integral.value=rs; 
  //  form2.submit();
 } 
</script>
</head>
<body>

<h1><%=r.getString(teasession._nLanguage, "CBSubscribers")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

  <h2><%=r.getString(teasession._nLanguage, "查询")%></h2>
  <FORM name=form1 METHOD=get action="<%=request.getRequestURI()%>">
  <input type="hidden" name="community" value="<%=community%>">
 <input type="hidden" name="act" value="<%=act%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
  <td><%=r.getString(teasession._nLanguage, "MemberId")%>:<input type=text name="member" value="<%if(member!=null)out.print(member);%>" ></td>
 
    <td><input type=submit value="<%=r.getString(teasession._nLanguage, "查询")%>" ></td>
  </tr>
  </table>
  </FORM>
<br/>

  <h2><%=r.getString(teasession._nLanguage, "列表")+" ( "+count+" )"%>
  &nbsp;   <input type="button" name="addIntegral" value="积分设置" onclick="f_act();">
  </h2>
  <FORM name=form2 METHOD=post action="/servlet/OrthSubscribers">
    <input type="hidden" name="community" value="<%=community%>">
  <input type="hidden" name="integral" value="">
   <input type="hidden" name="act" value="<%=act%>">
    <input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>">

    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr id=tableonetr>
        <td width="1"><input type="CHECKBOX" onClick="selectAll(form2.members ,this.checked)"  style="cursor:pointer"/></td>
        <td><%=r.getString(teasession._nLanguage, "MemberId")%> </td>
        <td><%=r.getString(teasession._nLanguage, "投稿积分")%> </td>
        <td><%=r.getString(teasession._nLanguage, "论坛积分")%></td>
        <td><%=r.getString(teasession._nLanguage, "加分项目")%></td>
        <td><%=r.getString(teasession._nLanguage, "减分项目")%></td>
        <td><%=r.getString(teasession._nLanguage, "可用积分")%></td>

      </tr>
<%
//Enumeration e=Profile.find(community,sql.toString(),pos,size);

java.util.Enumeration e = MemberOrder.findMP(teasession._strCommunity,sql.toString(),pos,size);
while(e.hasMoreElements())
{
  String memberorder =((String)e.nextElement());
  MemberOrder  moobj = MemberOrder.find(memberorder);
	 String s2=moobj.getMember();

	   Profile p = Profile.find(s2);
	   

  
  
  
%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td width="1"><input type="CHECKBOX"  name="members" value="<%=s2%>" <%if("webmaster".equals(s2))out.print(" disabled ");%>  style="cursor:pointer"></td>
  <td><%=s2%></td>
  <td><%=p.getContributeintegral() %></td>
  <td><%=p.getPoint()%></td>
  <td><%=IntegralRecord.getIntegral(teasession._strCommunity,s2," and reason=10 and  integral>=0 ") %></td>
  <td><%=IntegralRecord.getIntegral(teasession._strCommunity,s2," and reason=10 and  integral<0 ") %></td>
  <td><%=p.getIntegral()%></td>


  <!--td id="smstd">
    <input type="submit" value="清空密码" name="clearpassword"  onclick="return confirm('<%=r.getString(teasession._nLanguage, "确认清空?")%>')&&fal('<%=s2%>');"  >
    <input type='button' onClick="window.location='/jsp/sms/EditSMSMoney.jsp?node=<%=teasession._nNode%>&member=<%=s2%>';" name=Subscribers VALUE="<%=r.getString(teasession._nLanguage, "SMS")%>">
</td-->
</tr>
<%
 }
if(count>size){
%>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  
    <td colspan="20" align="center">
    
    <%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+"?community="+community+"&node=" + teasession._nNode+param.toString() + "&pos=", pos, count,size )%> </td>
    </tr>
    <%} %>
  </table>

 


  </FORM>

<br>
<div id="head6"><img height="6" alt=""></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>

