<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.Entity"%><%@page import="tea.entity.qcjs.*" %>

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





String nexturl = teasession.getParameter("nexturl");
int mid =0;
if(teasession.getParameter("mid")!=null && teasession.getParameter("mid").length()>0)
{
	mid = Integer.parseInt(teasession.getParameter("mid"));
}
QcMember mobj = QcMember.find(mid);
 
%>

<html>
<head>
<title>会员管理</title>
<script src="/tea/tea.js" type="text/javascript"></script>

<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/Calendar.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >
<script type="text/javascript">
function f_sub()
{
	if(form1.name.value==''){
		alert('姓名不能为空!');
		form1.name.focus();
		return false;
	}
	if(form1.card.value==''){
		alert('驾驶证号不能为空!');
		form1.card.focus();
		return false;
	}else{
		  var sID = form1.card.value;
	     if(!(/^\d{15}$|^\d{18}$|^\d{17}[xX]$/.test(sID)))
	     {
	       alert("请输入15位或18位驾驶证号");
	       form1.card.focus();
	      // document.form1.youxiaozhengjianhao.focus();
	      // form1.submitx.disabled=false;
	       return false;
	     }
	}
	if(form1.registratime.value==''){
		alert('报名时间不能为空!');
		form1.registratime.focus();
		return false;
	}
	if(form1.archives.value==''){
		alert('档案编号不能为空!');
		form1.archives.focus();
		return false;
	}
	if(form1.outtime.value==''){
		alert('出证日期不能为空!');
		form1.outtime.focus();
		return false;
	}

}

</script>
<h1>会员管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form action="/servlet/EditQcMember" name="form1" method="POST" onsubmit="return f_sub();" >
<input type="hidden" name="nexturl" value="<%=nexturl %>"/>  
<input type="hidden" name="act" value="EditMember"/>
<input type="hidden" name="mid" value="<%=mid %>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id=tableonetr>
	       <td nowrap align="right"><font color="red">*</font>&nbsp;姓名：</td>
	       <td nowrap><input type="text" name="name" value="<%=Entity.getNULL(mobj.getName()) %>"/></td>
	       <td nowrap align="right"><font color="red">*</font>&nbsp;性别：</td>
	       <td nowrap>
				<select name ="sex">
					<option value="0" <%if(mobj.getSex()==0)out.print(" selected "); %>>男</option>
					<option value="1" <%if(mobj.getSex()==1)out.print(" selected "); %>>女</option>
				</select>
			</td>
    </tr>
    <tr id=tableonetr>
	       <td nowrap align="right"><font color="red">*</font>&nbsp;驾驶证号：</td>
	       <td nowrap><input type="text" name="card" value="<%=Entity.getNULL(mobj.getCard()) %>"/></td>
	       <td nowrap align="right">电话：</td>
	       <td nowrap><input type="text" name="telephone" value="<%=Entity.getNULL(mobj.getTelephone()) %>"/></td>
    </tr>
     <tr id=tableonetr>
	       <td nowrap align="right">手机：</td>
	       <td nowrap><input type="text" name="mobile" value="<%=Entity.getNULL(mobj.getMobile()) %>"/></td>
	       <td nowrap align="right">地址：</td>
	       <td nowrap><input type="text" name="address" value="<%=Entity.getNULL(mobj.getAddress()) %>"/></td>
    </tr>
     <tr id=tableonetr>
	       <td nowrap align="right"><font color="red">*</font>&nbsp;报名时间：</td>
	       <td nowrap>
				<input id="registratime" name="registratime" size="7"  style="cursor:pointer" onclick="new Calendar().show('form1.registratime');"  value="<%if(mobj.getRegistratime()!=null)out.print(Entity.sdf.format(mobj.getRegistratime())); %>" readonly="readonly">
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.registratime');" />
				
			</td>
	       <td nowrap align="right"><font color="red">*</font>&nbsp;档案编号：</td>
	       <td nowrap><input type="text" name="archives" value="<%=Entity.getNULL(mobj.getArchives()) %>"/></td>
    </tr>
     <tr id=tableonetr>
	       <td nowrap align="right"><font color="red">*</font>&nbsp;出证日期：</td>
	       <td nowrap> 
				<input id="outtime" name="outtime" size="7"  style="cursor:pointer" onclick="new Calendar().show('form1.outtime');"  value="<%if(mobj.getOuttime()!=null)out.print(Entity.sdf.format(mobj.getOuttime())); %>" readonly="readonly">
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.outtime');" />
				
			</td>
	       <td nowrap align="right">来源：</td>
	      <td nowrap colspan="2"><input type="text" name="source" value="<%=Entity.getNULL(mobj.getSource()) %>"/></td>
    </tr>

  </table>
  <br/>
  <input type="submit" value="　提交　"/>&nbsp;<input type="reset" value="　清空　"> &nbsp;<input type="button" value="　返回　" onclick="window.open('<%=nexturl %>','_self');">&nbsp;
</form>
</body>
</html>
