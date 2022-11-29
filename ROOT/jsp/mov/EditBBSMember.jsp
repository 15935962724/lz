<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.Entity"%><%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.admin.*"%><%@page import="tea.entity.site.*"%>

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


String nexturl =teasession.getParameter("nexturl");
String memberid = teasession.getParameter("memberid");
int type=0;
if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0){
	type = Integer.parseInt(teasession.getParameter("type"));
}
if("NO".equals(memberid))
{
	memberid = "";
}

Profile p= Profile.find(memberid);
%>

<html>
<head>
<title>BBS论坛版块会员注册</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/Calendar.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<script>

function f_member()
{
  if(frmsrch.MemberId.value=='')
  {
    if(true)
    {
      //alert("【用户名】不能为空！");
      document.getElementById("show").innerHTML='<font color=red>用户名不能为空</font>';

    }

     frmsrch.MemberId.focus();
    return false;
  }

  return true;
}

function f_ajax()
{
  var value = frmsrch.MemberId.value;
  if(f_member()){
    var name ="MemberId";



     sendx("/jsp/mov/member_ajax.jsp?value="+encodeURIComponent(value)+"&name="+name,
		 function(data)
		 {

		  //alert("4444->>>>."+data.length);
		   if(data!=''&&data.length>1)//如果有这个用户  则写入Cookie
		   {
		document.getElementById('show').innerHTML=data

		   }
		 }
		 );



  }else
  {
    return false;
  }




}

function f_edit()
{


  if(f_member()){

    if(frmsrch.EnterPassword.value.length<6 || frmsrch.EnterPassword.value.length>18)
    {
        //alert("");
        document.getElementById("passwordshow").innerHTML='<font color=red>密码必须为6到18位之间.</font>';
        frmsrch.EnterPassword.focus();
        return false;
    }
     document.getElementById("passwordshow").innerHTML='';

    if(frmsrch.ConfirmPassword.value!=frmsrch.EnterPassword.value)
    {
       document.getElementById("confirmpasswordshow").innerHTML='<font color=red>两次密码输入不一致.</font>';
       frmsrch.ConfirmPassword.focus();
       return false;
   }
    	document.getElementById("confirmpasswordshow").innerHTML='';

 if(frmsrch.firstname.value=='')
	{

		document.getElementById("show2").innerHTML='<font color=red>姓名不能为空.</font>';
		 frmsrch.firstname.focus();
		 return false;
	}


  if(frmsrch.email.value!=''){


      var temp = document.getElementById("email");
	  //对电子邮件的验证
	  var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	  var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
	  if(!myreg.test(temp.value))
	  {

	   document.getElementById("emailid").innerHTML='<font color=red>请输入正确的邮箱地址.</font>';
       frmsrch.email.focus();
	    return false;
	  }
  }

  if(submitCheckbox(frmsrch.bbspermissions,'请选择论坛版块')){

	    document.getElementById("submits").disabled=true;
	    document.getElementById("submits").value='提交...';
	    frmsrch.action='/servlet/EditMember';
	    frmsrch.submit();
    }

  }else
  {
    return false;
  }


}

</script>

<body >
<h1>会员注册或编辑</h1>

<form name="frmsrch" method="POST" action="?">
<input type="hidden" name="nexturl" value="<%=nexturl %>"/>
<input type="hidden" name="act" value="EditBBSMember"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	   <tr><td  align="right">*&nbsp;用户名：<td><input type=text name=MemberId value= "<%if(memberid!=null&&memberid.length()>0)out.print(memberid); %>"
 <%if(memberid==null || memberid==""){out.print(" onkeyup=\"f_ajax();\" ");} %> <%if(memberid!=null&&memberid.length()>0)out.print(" readonly "); %> >&nbsp;&nbsp;<span id="show">&nbsp;</span></td>
<td></td></tr>
<tr><td nowrap align="right" ></td>
  <td width="620" align="left" colspan="2"><span style="line-height:22px;font-size:12px;">您的电子邮件地址将作为您的用户名。您可以通过点击邮件中的确认链接，来激活您的帐号。</span></td>
</tr>
<tr>
  <td nowrap align="right">*&nbsp;密码：</td>

  <td><input type="password" name="EnterPassword" value="<%=p.getNULL(p.getPassword()) %>"/>&nbsp;&nbsp;<span id="passwordshow">&nbsp;</span>
  </td>
  <td >

    </td>
</tr>
<tr><td nowrap align="right" ></td>
  <td align="left" ><span style="line-height:22px;font-size:12px;">6-10 个字符</span></td></tr>
<tr>
  <td nowrap  align="right">*&nbsp;确认密码：</td>
  <td><input type="password" name="ConfirmPassword" value="<%=p.getNULL(p.getPassword()) %>"/>&nbsp;&nbsp;<span id="confirmpasswordshow">&nbsp;</span></td>

   <td>
   </td>
</tr>
<tr>
	<td align="right"><span id=firstnameid>*&nbsp;姓名</span>：</td>
	<td><input type="text" id="firstname" name="firstname"  value="<%=p.getNULL(p.getFirstName(teasession._nLanguage)) %>"> <span id="show2">&nbsp;</span></td>
	</td>
</tr>
<tr>
	<td align="right">*&nbsp;性别：</td>
	<td>
		<input type="radio" name="sex" value="1"  <%if(!p.isSex())out.print(" checked "); %>  > 男
		<input type="radio" name="sex" value="0"  <%if(p.isSex())out.print(" checked "); %>  /> 女
	</td>
</tr>
<tr>
	<td align="right">邮箱地址：</td>
	<td><input type="text" name=email id="email" value="<%=p.getNULL(p.getEmail())%>">
	<span id=emailid>&nbsp;</span>
	</td></tr>
<tr><td align="right">手机号码：</td>
	<td> <input type=text  name=phonenumber value="<%=p.getNULL(p.getMobile())%>" maxlength="11"> <span id=phonenumbershow></span>
	</td>
</tr>


<tr><td align="right">论坛板块：</td>
	<td>
		<%

			//Profile pobj = Profile.find(teasession._rv._strR());
            String forum="/";
            if(teasession._rv._strR.equals(Communitybbs.find(teasession._strCommunity).getSuperhost()))
            {
              java.util.Enumeration enumer=Forum.findByCommunity(teasession._strCommunity);
              while(enumer.hasMoreElements())forum+=((Integer)enumer.nextElement()).intValue()+"/";
            }else
            forum=AdminUsrRole.find(teasession._strCommunity,teasession._rv._strR).getBbsHost();
			if(forum.length()>1)
			{
              String[] arr=forum.split("/");
				for(int i=1;i<arr.length;i++){

					int bbs = Integer.parseInt(arr[i]);
					if(Node.find(bbs).getType()==0){
						Enumeration e = Node.find(" and hidden = 0 and  exists (select node from Category c where n.node= c.node and c.category=57) and father = "+bbs,0,Integer.MAX_VALUE);
						while(e.hasMoreElements()){
							int nid = ((Integer)e.nextElement()).intValue();
							Node nobj = Node.find(nid);

							out.print(" <input type=\"checkbox\" name=\"bbspermissions\" value=\""+nid+"\" ");

							if(p.getBbspermissions()!=null && p.getBbspermissions().indexOf("/"+nid+"/")!=-1)
							{
								out.print(" checked ");
							}

							out.print(">&nbsp;"+nobj.getSubject(teasession._nLanguage));
						}
					}else if(Node.find(bbs).getType()==1){
						Node nobj2 = Node.find(bbs);
						out.print(" <input type=\"checkbox\" name=\"bbspermissions\" value=\""+bbs+"\" ");
						if(p.getBbspermissions()!=null && p.getBbspermissions().indexOf("/"+bbs+"/")!=-1)
						{
							out.print(" checked ");
						}
						out.print(">&nbsp;"+nobj2.getSubject(teasession._nLanguage));
					}

				}
			}else
			{
				for(int i=1;i<Profile.find(teasession._rv._strR).getBbspermissions().split("/").length;i++){
					int si = Integer.parseInt(Profile.find(teasession._rv._strR).getBbspermissions().split("/")[i]);
					Node n = Node.find(si);
					out.print(" <input type=\"checkbox\" name=\"bbspermissions\" value=\""+si+"\" ");

					out.print(" checked  ");

					out.print(">&nbsp;11"+n.getSubject(teasession._nLanguage));
				}
			}

		%>
	</td>
</tr>
<%if(type==1){//园长添加班主任时候可以显示 %>
<tr>
	<td  align="right">用户角色：</td>
	<td>
		<%
			AdminUsrRole aurobj = AdminUsrRole.find(teasession._strCommunity,teasession._rv._strR);
			if(aurobj.getRole()!=null){

				String role[] = aurobj.getRole().split("/");
				for(int i=1;i<role.length;i++)
				{
					AdminRole adrobj = AdminRole.find(Integer.parseInt(role[i]));
					out.print(" <input type=\"checkbox\" name=\"bbsrole\" value=\""+role[i]+"\" ");

					if(AdminUsrRole.find(teasession._strCommunity,memberid).getRole().indexOf("/"+role[i]+"/")!=-1){
						out.print(" checked  ");
					}

					out.print(">&nbsp;"+adrobj.getName());
				}
			}
		%>
	</td>
</tr>
<%} %>
  </table>
  <input type="button" id="submits" value="提交" onclick="f_edit(this);" style="width:80px;height:20px;margin:10px 0;"/>&nbsp;&nbsp;
<input type="reset" value="重设" style="width:80px;height:20px;margin:10px 0;"/>
  <input type="button"  value="返回" onClick="javascript:history.go(-1)"  style="width:80px;height:20px;margin:10px 0;">

</form>
</body>
</html>

