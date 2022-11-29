<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.Entity"%><%@page import="tea.entity.admin.mov.*"%>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}



Resource r=new Resource("/tea/resource/Photography");


String nexturl = request.getRequestURI()+"?"+request.getQueryString();

StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);

StringBuffer sql=new StringBuffer(" AND  p.member !="+DbAdapter.cite("webmaster"));

//用户ID
String member = teasession.getParameter("member");
if(member!=null && member.length()>0){
	member = member.trim();
	sql.append(" and p.member like ").append(DbAdapter.cite("%"+member+"%"));
	param.append("&member=").append(URLEncoder.encode(member,"UTF-8"));
}

//昵称
String membername = teasession.getParameter("membername");
if(membername!=null && membername.length()>0){
	membername = membername.trim();
	sql.append(" and exists( select member from ProfileLayer pl where p.member=pl.member and firstname like "+DbAdapter.cite("%"+membername+"%")+" ) ");
	param.append("&membername=").append(URLEncoder.encode(membername,"UTF-8"));
}


//申请时间
String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND m.times >=").append(DbAdapter.cite(time_c+" 00:00"));
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND m.times <=").append(DbAdapter.cite(time_d+" 23:59"));
  param.append("&time_d=").append(time_d);
}
//年龄段
int age = 0;
if(teasession.getParameter("age")!=null && teasession.getParameter("age").length()>0)
{
	age = Integer.parseInt(teasession.getParameter("age"));
}
if(age>0)
{
	sql.append(" and p.agent= ").append(age);
	param.append("&age=").append(age);
}
//性别
int sex= -1;
if(teasession.getParameter("sex")!=null && teasession.getParameter("sex").length()>0){
	sex = Integer.parseInt(teasession.getParameter("sex"));
}
if(sex>=0){
	sql.append(" and p.sex= ").append(sex);
	param.append("&sex=").append(sex);
}

//是否订阅电子报
int newsletter = -1;
if(teasession.getParameter("newsletter")!=null && teasession.getParameter("newsletter").length()>0){
	newsletter = Integer.parseInt(teasession.getParameter("newsletter"));
}
if(newsletter>=0){
	sql.append(" and m.newsletter= ").append(newsletter);
	param.append("&newsletter=").append(newsletter);
}

//国家
String country = "AA";
if(teasession.getParameter("country")!=null && teasession.getParameter("country").length()>0){
	country = teasession.getParameter("country");
}

if(country!=null && country.length()>0 &&!"AA".equals(country))
{
	sql.append(" and exists (select pl.member from ProfileLayer pl where pl.member=p.member and pl.country="+DbAdapter.cite(country)+" ) ");
	param.append("&country=").append(country);
}
//审核状态
int valid = -1;
if(teasession.getParameter("valid")!=null && teasession.getParameter("valid").length()>0)
{
	valid = Integer.parseInt(teasession.getParameter("valid"));

}
if(valid>=0)
{
	sql.append(" and p.valid ="+valid);
	param.append("&valid=").append(valid);
}


int pos=0,pageSize=30;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}




int count=MemberOrder.countMP(teasession._strCommunity,sql.toString());
sql.append(" order by times desc ");

%>

<html>
<head>
<title>会员审核管理</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/Calendar.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >
<script type="text/javascript">

function CheckAll()
{
	var checkname=document.getElementsByName("checkall");
	var fname=document.getElementsByName("memberorder");
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




function f_sub(igd,strigd)
{

  if(submitCheckbox(form1.memberorder,strigd))
  {


		//删除

		if(igd=='delete')//
		{
			if(confirm('删除操作系统会把会员信息清空\n您确定要删除吗？'))
			{
				form1.action='/servlet/EditMemberType';
				form1.act.value='member_delete';
				form1.nexturl.value=location.pathname+location.search;
	    		form1.submit();
			}
		}



     }
}

function f_excel()
		{
			if(confirm("您确定要导出数据吗?"))
		    {
				form1.action='/servlet/EditExcel';
				form1.act.value='WomenMember';
				form1.submit();
			}
	   }


function f_order(v)
  {
    var aq=form1.aq.value=="true";
    if(form1.o.value==v)
    {
      form1.aq.value=!aq;
    }else
    {
      form1.o.value=v;
    }
    form1.action="?";
    form1.submit();
  }

function f_s(igd,igd2)
{
	form1.membertype.value=igd;
	form1.divid.value=igd2;
	form1.action="?";
	form1.submit();
}
function f_email()
{
	var fname=document.getElementsByName("memberorder");
	var lname="/";

	    for(var i=0; i<fname.length; i++)
	    {
	    	if( fname[i].checked==true){
	       	   lname = lname + fname[i].value+"/";
	       }
	     }



	var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:830px;dialogHeight:710px;';
	 var url = '/jsp/mov/ClssnEmail.jsp?t='+new Date().getTime()+"&member="+encodeURIComponent(lname)+"&sql="+encodeURIComponent(form1.sql.value);
	 var rs = window.showModalDialog(url,self,y);
	 if(rs==1)
	 {
		 window.location.reload();
	 }
}


</script>

<h1>会员审核管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form action="?" name="form1">
<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>
<input type="hidden" name="nexturl">
<input type="hidden" name="membertype"/>
<input type="hidden" name="divid"/>

<input type="hidden" name="act">
<input type="hidden" name="memberlist_act" value="MemberList">
<input type="hidden" name="files" value="会员列表"/>
<input type="hidden" name="sql" value="<%=sql.toString() %>"/>

<input type="hidden" name="id" value="<%=request.getParameter("id") %>">

<h2>查询</h2>

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
		<td align="right">用户名：</td>
		<td><input type="text" name="member" value="<%=Entity.getNULL(member) %>"/></td>
		<td align="right">昵称：</td>
		<td><input type="text" name="membername" value="<%=Entity.getNULL(membername) %>"/></td>
		<td align="right">申请时间：</td>
		<td>
		 从&nbsp;
	        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>"  style="cursor:pointer" readonly="readonly" onClick="new Calendar().show('form1.time_c');">
	        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.time_c');" />
	        &nbsp;到&nbsp;
	        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>"  style="cursor:pointer" readonly="readonly" onClick="new Calendar().show('form1.time_d');" >
	        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"   style="cursor:pointer" onclick="new Calendar().show('form1.time_d');" />

		</td>
	</tr>
	<tr>
		<td align="right">年龄段：</td>
		<td>
			<select name="age">
		   		<option value="0" <%if(age==0){out.print(" selected ");} %>>-年龄段-</option>
	             <%
	                 for(int i=1;i<Common.AGE_TYPE.length;i++)
	                 {
	                     out.print("<option value="+i);
	                     if(age==i)
	                    	 {
	                    	 	out.print(" selected ");
	                    	 }
	                     out.print(">"+Common.AGE_TYPE[i]);
	                     out.print("</option>");
	                 }
	             %>

		</select>
		</td>
	    <td align="right">性别：</td>
		<td>
			<select name="sex">
				<option value="-1">-性别-</option>
				<option value="0" <%if(sex==0)out.print(" selected "); %>>男</option>
				<option value="1" <%if(sex==1)out.print(" selected "); %>>女</option>
			</select>
		</td>
		<td align="right">订阅电子报：</td>
		<td>
			<select name="newsletter">
				<option value="-1">-是否订阅-</option>
				<option value="1" <%if(newsletter==1)out.print(" selected "); %>>是</option>
				<option value="0" <%if(newsletter==0)out.print(" selected "); %>>否</option>
			</select>
		</td>
		 </tr>
		 <tr>
		<td align="right">国家：</td>
		<td><%=new tea.htmlx.CountrySelection("country",0,country) %></td>
		<td align="right">邮箱验证状态</td>
		<td>
			<select name="valid">
				<option value="">-验证状态-</option>
				<option value="0" <%if(valid==0){out.println(" selected ");} %>>-未通过-</option>
				<option value="1"  <%if(valid==1){out.println(" selected ");} %>>-已通过-</option>
			</select>
		</td>
	    <td colspan="12" align="center"><input type="submit" value="查询"/></td>
	</tr>
 </table>

<h2>会员列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;位会员&nbsp;)&nbsp;</h2>
<h2 class="cnclass">
<div class="cnlistLeft">

<input type="button" value="批量删除" onClick="f_sub('delete','请选择您要删除的会员!');">&nbsp;
<input type="button" value="导出EXCEL" onClick=f_excel();>&nbsp;
<input type="button" value="发送Email" onClick=f_email();>&nbsp;
</div>

 </h2>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	   <tr id=tableonetr>
  			  <td width="1"><input type='checkbox' name="checkall" onclick='CheckAll()' title="全选" style="cursor:pointer"></td>

  			  <td nowrap>会员昵称</td>
  			  <td nowrap>年龄段</td>
  			  <td nowrap>性别</td>
  			  <td nowrap>地区</td>
  			 <td nowrap>邮箱地址</td>
  			  <td nowrap>注册时间</td>

  			  <td nowrap>邮箱验证</td>

  			  <td nowrap>操作</td>
	    </tr>

    <%


	    java.util.Enumeration e = MemberOrder.findMP(teasession._strCommunity,sql.toString(),pos,pageSize);
		 if(!e.hasMoreElements())
		 {
		     out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
		 }
    	for(int i=1;e.hasMoreElements();i++)
    	{
    		String memberorder =((String)e.nextElement());
    	    MemberOrder  moobj = MemberOrder.find(memberorder);
    	    Profile pobj = Profile.find(moobj.getMember());
    	    MemberType mtobj = MemberType.find(moobj.getMembertype());
    	    int cid=0;
    	    String cname=pobj.getCity(teasession._nLanguage);



    %>
    <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
      <td width=1><input type=checkbox name=memberorder value="<%=memberorder%>" style="cursor:pointer"></td>

      <td><%=pobj.getFirstName(teasession._nLanguage) %></td>
  	  <td><%if(pobj.getAgent()!=0){out.print(Common.AGE_TYPE[pobj.getAgent()]);} %></td>
     <td><%if(pobj.isSex()){out.print("女");}else {out.print("男");} %></td>

      <td nowrap><%=cname %></td>
      <td nowrap><%=pobj.getEmail() %></td>
      <td nowrap><%=pobj.sdf.format(pobj.getTime()) %></td>

      <td>
      	<%
      		if(Profile.findValid(moobj.getMember())==1)
      		{
      			out.print("<font color=#00ab00>已通过</font>");
      		}else
      		{
      			out.print("<font color=red>未通过</font>");
      		}
      	%>
      </td>


	   <td nowrap>

		   <a href="/jsp/mov/EditWomenRegister.jsp?member=<%=URLEncoder.encode(moobj.getMember(),"UTF-8") %>&membertype=<%=moobj.getMembertype() %>&nexturl=<%=URLEncoder.encode(nexturl,"UTF-8") %>">编辑</a>&nbsp;

	   </td>

    </tr>
<%} %>
     <%if (count > pageSize) {  %>
      <tr> <td colspan="20"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>
</form>
</body>
</html>
