<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.Entity"%><%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.*"%><%@page import="java.util.regex.*"%>

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


String nexturl = request.getRequestURI();

int locking = 0;
if(teasession.getParameter("locking")!=null && teasession.getParameter("locking").length()>0)
{
	locking = Integer.parseInt(teasession.getParameter("locking"));
}

StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);

StringBuffer sql=new StringBuffer("  AND community="+DbAdapter.cite(teasession._strCommunity)+" AND member !="+DbAdapter.cite("webmaster"));

if(locking==0)
{
		sql.append("  AND (locking=0 or locking is null )");
}else
{
	sql.append("  AND locking=1");
}

param.append("&locking=").append(locking);
//用户名
String memberid = teasession.getParameter("memberid");
if(memberid!=null && memberid.length()>0)
{
	memberid = memberid.trim();
	sql.append(" and member like "+DbAdapter.cite("%"+memberid+"%")+"  ");
	param.append("&memberid=").append(URLEncoder.encode(memberid,"UTF-8"));

}
//注册时间
String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND time >=").append(DbAdapter.cite(time_c+" 00:00"));
  param.append("&time_c=").append(time_c);

}

String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND time <=").append(DbAdapter.cite(time_d+" 23:59"));
  param.append("&time_d=").append(time_d);

}

//姓名
String membername = teasession.getParameter("membername");
if(membername!=null && membername.length()>0)
{
	membername = membername.trim();
	sql.append(" and exists (select member from ProfileLayer pl where pl.member=p.member AND pl.firstname like "+DbAdapter.cite("%"+membername+"%")+"  )");
	param.append("&membername=").append(URLEncoder.encode(membername,"UTF-8"));

}

//性别
int sex= -1;
if(teasession.getParameter("sex")!=null && teasession.getParameter("sex").length()>0)
{
	sex = Integer.parseInt(teasession.getParameter("sex"));
}
if(sex>=0)
{
	sql.append(" and p.sex= "+sex+"  ");
	param.append("&sex=").append(sex);

}

//工作地点城市
String city0 = teasession.getParameter("city0");
if(city0!=null && city0.length()>0)
{
		//province
	sql.append(" and exists (select member from ProfileLayer pl where pl.member=p.member AND pl.province like "+DbAdapter.cite("%"+city0+"%")+"  )");
	param.append("&city0=").append(city0);


}

String city1 = teasession.getParameter("city1");
if(city1!=null && city1.length()>0)
{
		//province
	sql.append(" and exists (select member from ProfileLayer pl where pl.member=p.member AND pl.province like "+DbAdapter.cite("%"+city1+"%")+"  )");
	param.append("&city1=").append(city1);
	city0 = city1;


}
//手机
String mobile = teasession.getParameter("mobile");
if(mobile!=null && mobile.length()>0)
{
	mobile = mobile.trim();
	sql.append(" and mobile like "+DbAdapter.cite("%"+mobile+"%")+"  ");
	param.append("&mobile=").append(mobile);

}


int pos=0,pageSize=10;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}



int count=Profile.count(sql.toString());
sql.append(" order by time desc ");




%><html>
<head>
<title>系统会员管理</title>

<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
<script LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></script>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/tea/city.js"></script>
<script src="/jsp/custom/westrac/script.js"></script>



<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
#xlsize{color:#000000;padding-top:5px;}
h3{color:#CE0829;font-size:12px;margin:5px 0px 5px 0px;display: block;height:20px;padding-left:10px;line-height:20px;text-align:left;width:95%;background-color: #F2F2F2;

clear: both;}
</style>
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


	if(checkname[0].checked)
	{

		document.getElementById("checkall2").checked=true;
	}
	else
	{
		document.getElementById("checkall2").checked=false;
	}


}
function CheckAll2()
{
	var checkname=document.getElementsByName("checkall2");
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
	if(checkname[0].checked)
	{

		document.getElementById("checkall").checked=true;
	}
	else
	{
		document.getElementById("checkall").checked=false;
	}
}




function f_sub(igd,strigd)
{

  if(submitCheckbox(form1.memberorder,strigd))
  {
		//删除
		if(igd=='delete')//
		{
			if(confirm('删除操作成功以后，会员不能登录，但信息还在\n您确定要删除吗？'))
			{
				form1.action='/servlet/EditMember';
				form1.act.value='WestracMemberDelete';
				form1.nexturl.value=location.pathname+location.search;
	    		form1.submit();
			}
		}else if(igd=='locking')
		{

				form1.action='/servlet/EditMember';
				form1.act.value='WestracMemberlocking';
				form1.nexturl.value=location.pathname+location.search;
	    		form1.submit();

		}else if(igd=='deleteall')
		{
			if(confirm('彻底删除操作系统会把会员相关的所以信息清空\n您确定要删除吗？'))
			{
				form1.action='/servlet/EditMember';
				form1.act.value='WestracMemberDeleteAll';
				form1.nexturl.value=location.pathname+location.search;
	    		form1.submit();
			}
		}
     }
}
//导出数据
function f_excel()
{
			if(confirm("您确定要导出数据吗?"))
		    {
				form1.action='/servlet/EditExcel';
				form1.act.value='ednMember';
				form1.submit();
			}
}
//发送邮件
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
	 var url = '/jsp/westrac/WestracEmail.jsp?t='+new Date().getTime()+"&member="+encodeURIComponent(lname)+"&sql="+encodeURIComponent(form1.sql.value);
	 var rs = window.showModalDialog(url,self,y);
	 if(rs==1)
	 {
		 window.location.reload();
	 }
}
//发送站内信
function f_mailbox()
{
		var fname=document.getElementsByName("memberorder");
	    var lname="";

	    for(var i=0; i<fname.length; i++)
	    {
	    	if( fname[i].checked==true)
	       {
	       	   lname = lname + fname[i].value+"/";
	       }
	     }


	var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:830px;dialogHeight:710px;';
	 var url = '/jsp/westrac/WestracMailbox.jsp?t='+new Date().getTime()+"&member="+encodeURIComponent(lname)+"&sql="+encodeURIComponent(form1.sql.value);
	 var rs = window.showModalDialog(url,self,y);
	 if(rs==1)
	 {
		 window.location.reload();
	 }
}
//发送短信
function f_message()
{
	var fname=document.getElementsByName("memberorder");
    var lname="";

    for(var i=0; i<fname.length; i++)
    {
    	if( fname[i].checked==true){
       	   lname = lname + fname[i].value+"/";
       }
     }
	 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:630px;dialogHeight:270px;';
	 var url = '/jsp/westrac/WestracMessage.jsp?t='+new Date().getTime()+"&member="+encodeURIComponent(lname)+"&sql="+encodeURIComponent(form1.sql.value);
	 var rs = window.showModalDialog(url,self,y);
}

//点击操作显示
function f_cz(igd)
{
	if(document.getElementById('trid'+igd).style.display=='')
	{
		document.getElementById('trid'+igd).style.display='none';
	}
	else if(document.getElementById('trid'+igd).style.display=='none')
	{
		document.getElementById('trid'+igd).style.display='';
	}
}

//删除
function f_delete(igd)
{
	if(confirm('确认删除')){
	  sendx("/jsp/admin/edn_ajax.jsp?act=WestracMemberdelete&member="+encodeURIComponent(igd),
				 function(data)
				 {
				    alert('用户删除成功');
				    window.location.reload();
				 }
				 );
	}
}

//设置积分
function f_act(igd)
{

    var rs=window.showModalDialog('/jsp/orth/SetIntegral.jsp?members2='+encodeURIComponent("/"+igd+"/"),self,'scroll:0;status:0;help:0;resizable:1;dialogWidth:600px;dialogHeight:280px;');
    if(!rs)return;
    window.location.reload();
  //  var arr=rs;
	//form2.integral.value=rs;
  //  form2.submit();
 }
 //批量设置积分

function f_jfall()
{
  if(!submitCheckbox(form1.memberorder,'请选择要设置积分的用户'))return;

	  var members2="/";

	  if(typeof(form1.memberorder.length)=='undefined')
	 {
		  members2 =members2+form1.memberorder.value+"/";
	 }else{
		  for(var i=0;i<form1.memberorder.length;i++)
		  {
			  if(form1.memberorder[i].checked){
			     members2 =members2+form1.memberorder[i].value+"/";
			   }
		  }

	  }
    var rs=window.showModalDialog('/jsp/orth/SetIntegral.jsp?members2='+encodeURIComponent(members2),self,'scroll:0;status:0;help:0;resizable:1;dialogWidth:600px;dialogHeight:280px;');
    if(!rs)return;

    window.location.reload();
 }

function fal(igd)
{
	 sendx("/jsp/admin/edn_ajax.jsp?act=editpassword&member="+igd,
			 function(data)
			 {

			  //alert("4444->>>>."+data.length);
			   if(data!=''&&data.length>1)//如果有这个用户  则写入Cookie .trim()
			   {
				  alert(data.trim());

			   }
			 }
			 );
}



</script>

<h1>系统会员管理</h1>


<form name="form1" action ="?" method="post">
<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>

<input type="hidden" name="nexturl">
<input type="hidden" name="membertype"/>

<input type="hidden" name="nexturl">

<input type="hidden" name="id" value="<%=request.getParameter("id") %>">

<input type="hidden" name="act">
<input type="hidden" name="memberlist_act" value="MemberList">
<input type="hidden" name="files" value="会员列表"/>
<input type="hidden" name="sql" value="<%=MT.enc(sql.toString())%>">
<input type="hidden" name="locking" value="<%=locking %>">
<input type="hidden" name="id" value="<%=request.getParameter("id") %>">

<h2>查询</h2>

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>

 <td align="right">用户名：<input type="text" name=memberid value="<%=Entity.getNULL(memberid) %>"></td>
		<td align="right">姓名：<input type="text" name="membername" value="<%=Entity.getNULL(membername) %>"></td>
		<td align="right">注册时间：从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null){out.println(time_c);} %>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_c');">
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null){out.println(time_d);} %>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_d');" >
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"   style="cursor:pointer" onclick="new Calendar().show('form1.time_d');" />
     </td>
		</tr>

		<tr>
		<td align="right">性别：
			<select name="sex">
			<option value="">性别</option>
			<option value="0" <%if(sex==0)out.println(" selected "); %>>男</option>
			<option value="1" <%if(sex==1)out.println(" selected "); %>>女</option>

		</select>
		</td>

		<td align="right">工作地点：
		 	<script>mt.city("city0","city1",null,"<%=city0%>");</script>
		</td>
		<td align="right">手机号：<input type="text" name="mobile" value="<%=Entity.getNULL(mobile) %>">
		</td>

		</tr>



		<tr>
	    <td colspan="10" align="center"><input type="submit" value="查询"/></td>
	    </tr>

 </table>



<h2>会员列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;位会员&nbsp;)&nbsp;</h2>





<h2 class="cnclass">

<div class="cnlistLeft">

<input type="button" value="批量删除" onClick="f_sub('delete','请选择您要删除的会员!');">&nbsp;
<input type="button" value="导出Excel" onClick="f_excel();">&nbsp;

<input type="button" value="发E-mail" onClick="f_email();">&nbsp;
<input type="button" value="发送站内信" onClick="f_mailbox();">&nbsp;
  <input type=button value="积分设置" onclick="f_jfall();">&nbsp;
<input type="button" value="发送短信" onclick="f_message();">&nbsp;
<input type="button" value="锁定会员" onclick="f_sub('locking','请选择要锁定的会员');">&nbsp;

<%
if(locking==0)
{
	out.println("<input type=\"button\" value=\"查看删除用户\" onclick=\"form1.locking.value=1;form1.submit();\">&nbsp;");
}else
{
	out.println("<input type=\"button\" value=\"查看正常用户\" onclick=\"form1.locking.value=0;form1.submit();\">&nbsp;");
	out.println("<input type=\"button\" value=\"彻底删除\" onClick=\"f_sub('deleteall','请选择您要彻底删除的会员!');\">&nbsp;");
}
%>



</div>

 </h2>
   <span id="rorderid" ></span>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	   <tr id=tableonetr>
  			  <td width="1"><input type='checkbox' id="checkall" name="checkall" onclick='CheckAll()' title="全选" style="cursor:pointer"></td>


  			  	<td nowrap>用户名</td>
  		       <td nowrap>姓名</td>
  		       <td nowrap>性别</td>
  			  <td nowrap>工作地点</td>
  			  <td nowrap>手机号</td>
  			  <td nowrap>注册时间</td>
  			  <td nowrap>操作</td>
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

    <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
      <td width=1><input type=checkbox name=memberorder id="memberorder" value="<%=member%>" style="cursor:pointer"></td>

    <td><a href="/jsp/community/EditednMember.jsp?member=<%=member%>&nexturl=<%=nexturl %>"><%=member%></a>
    <% if(pobj.isLocking())out.print(" <font color='#FF0000'>[锁定]</font>"); %>

    </td>
      <td><a href="/jsp/community/EditednMember.jsp?member=<%=member%>&nexturl=<%=nexturl %>"><%=pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage)%></a></td>

        <td><%if(pobj.isSex()){out.print("女");}else {out.print("男");} %></td>

      <td nowrap><%=cname %></td>
      <td nowrap><%=pobj.getMobile() %></td>

      <td nowrap><%if(pobj.getTime()!=null)out.print(Entity.sdf2.format(pobj.getTime()));%></td>


	    <td nowrap> <a href="###" onclick="f_cz('<%=member%>');" >操作</a></td>

    </tr>

    <tr id="trid<%=member %>" style="display:none">
  	<td align="right" colspan="20">
  		<a href="###"  onclick="window.open('/jsp/community/EditednMember.jsp?member=<%=URLEncoder.encode(member,"UTF-8")%>&nexturl=<%=nexturl%>','_self');">编辑</a>&nbsp;
  		<a href="###" onclick="return confirm('<%=r.getString(teasession._nLanguage, "密码重置后为:111111.")%>')&&fal('<%=member%>');" >密码重置</a>
  		<a href="###" onclick="f_act('<%=member%>');">积分</a>
  		<a href="###"  onClick="f_delete('<%=member%>');" >删除</a>&nbsp;
  		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  	</td>
  </tr>
<%} %>
     <%if(count>0){ %>
      <tr>
       <td colspan="2"><input type='checkbox' name="checkall2" id="checkall2" onclick='CheckAll2()' title="全选" style="cursor:pointer">&nbsp;全选/反选</td>
        <td colspan="20" align="right">
      <%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>
      </td> </tr>
      <%} %>

  </table>
</form>
</body>
</html>

