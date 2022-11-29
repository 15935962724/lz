<%@page import="tea.entity.admin.AdminRole"%>
<%@page import="tea.entity.admin.AdminUnit"%>
<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@page import="java.net.URLEncoder"%>
<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="java.util.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
String community=teasession._strCommunity;
java.util.Date date = new java.util.Date();


if(teasession._rv==null)
{
	out.println("您还没有登录，没有权限查看，请登录");
	return;
}
  String nexturl =  request.getRequestURI()+"?"+request.getQueryString();

StringBuffer sql=new StringBuffer(" and community = ").append(DbAdapter.cite(community));
StringBuffer param=new StringBuffer();


param.append("?community="+teasession._strCommunity);

//是什么类型的志愿者 如果是 3 membertype可以管理  注册和登记的全部用户
int membertype = 0;
if(teasession.getParameter("membertype")!=null && teasession.getParameter("membertype").length()>0)
{
	membertype = Integer.parseInt(teasession.getParameter("membertype"));	
}

String adminrole = teasession.getParameter("adminrole");//哪个区域的用户

if(membertype==3)
{
	sql.append(" and exists (select member from Volunteer v where v.member = p.member and v.membertype != 2 )");
}else
{
	sql.append(" and exists (select member from Volunteer v where v.member = p.member and v.membertype = "+(membertype)+")");
}

param.append("&membertype=").append(membertype);

param.append("&id=").append(request.getParameter("id"));



//姓名
String firstname=teasession.getParameter("firstname");
if(firstname!=null && firstname.length()>0)
{
  firstname=firstname.trim();
  
  sql.append(" and  exists (select member from ProfileLayer pl where p.member=pl.member and pl.firstname like "+DbAdapter.cite("%"+firstname+"%")+" ) ");
  param.append("&firstname=").append(URLEncoder.encode(firstname,"UTF-8")); 
}
 
//手机号mobile
String mobile =teasession.getParameter("mobile");
if(mobile!=null && mobile.length()>0)
{
	mobile = mobile.trim();
  sql.append(" and mobile like "+DbAdapter.cite("%"+mobile+"%"));
  param.append("&mobile=").append(DbAdapter.cite(mobile));
}

//性别
int sex=3;
if(teasession.getParameter("sex")!=null && teasession.getParameter("sex").length()>0)
{

  sex=Integer.parseInt(teasession.getParameter("sex"));
  if(sex!=3)
  {
	   sql.append("  and sex="+sex);
	    param.append("&sex+").append(sex);
  }
  
}
//邮件
String email=teasession.getParameter("email");


if(email!=null &&email.length()>0)
{

	email=email.trim();

    sql.append(" and email like "+DbAdapter.cite("%"+email+"%"));
     param.append("&email+").append(DbAdapter.cite(email));
}

//所在区县
String city=teasession.getParameter("city");
if(city!=null && city.length()>0)
{
    sql.append(" and  exists (select member from ProfileLayer pl where p.member=pl.member and pl.city  = "+DbAdapter.cite(city)+" ) ");
    param.append("&city=").append(city);

}
//所在区县
String cityname=teasession.getParameter("cityname");
if(cityname!=null && cityname.length()>0)
{
    sql.append(" and  exists (select member from ProfileLayer pl where p.member=pl.member and pl.city  = "+DbAdapter.cite(cityname)+" ) ");
    param.append("&cityname=").append(cityname);

}

//判断有权限的用户 
if("role".equals(adminrole))
{
	AdminUsrRole arobj = AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());
	StringBuffer sp = new StringBuffer("/");
	
	for(int i=0;i<Volunteer.CITYS.length;i++)
	{
		sp.append(Volunteer.CITYS[i]).append("/");
	}
	
	StringBuffer sp2 = new StringBuffer();
	int cc = 0;
	for(int i=1;i<arobj.getRole().split("/").length;i++)
	{
		int adid = Integer.parseInt(arobj.getRole().split("/")[i]);
		AdminRole auobj = AdminRole.find(adid);
		if(sp.toString().indexOf("/"+auobj.getName()+"/")!=-1)
		{
			cc++;
			if(cc==1)
			{
				sp2.append(" and ( pl.city = ").append(DbAdapter.cite(Volunteer.getCITYS(auobj.getName())));
			}else  
			{
				sp2.append(" or pl.city = ").append(DbAdapter.cite(Volunteer.getCITYS(auobj.getName())));
			}
			
			 
			
		
			 
		}
	} 
	if(cc>=1)
	{
		sp2.append(")"); 
	}
	
	sql.append(" and  exists (select member from ProfileLayer pl where p.member=pl.member "+sp2.toString()+" ) ");
   
	if(cc==0)
	{
		out.println("您没有权限查看，请联系管理员");
		return;
	}
	
}
param.append("&adminrole=").append(adminrole);
 

//职业
String zhiye=teasession.getParameter("zhiye");
if(zhiye!=null && zhiye.length()>0)
{
  zhiye= zhiye.trim();
 
  sql.append(" and exists (select member from Volunteer v where v.member = p.member and v.zhiye LIKE "+DbAdapter.cite("%"+zhiye+"%")+")");
  param.append("&zhiye=").append(URLEncoder.encode(zhiye,"UTF-8"));
}




int pos=0,size = 20;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);

int count = Profile.count(sql.toString());



String members = teasession.getParameter("members");
if(teasession.getParameter("delete")!=null && teasession.getParameter("delete").length()>0)
{
  if(teasession.getParameter("delete").equals("1"))
  {
    String memberd = teasession.getParameter("memberd");
    Volunteer.delete(memberd);
    Profile.delete(memberd);
    
  }
}



%>
<html>
<HEAD>
  <link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <link href="/tea/CssJs/Home.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
  
  <style>
#tablecenter{border:1px solid #dfdfdf;width:1002px;margin-bottom:15px;border-collapse:collapse;}
</style>

</HEAD>
<body id="bodyvl">
<script type="text/javascript">

function CheckAll()
{
	var checkname=document.getElementsByName("checkall");   
	var fname=document.getElementsByName("membercheckbox");
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
function f_excel2()
{
	if(confirm("您确定要导出数据吗?"))
	    {
			form1.action='/servlet/EditVolunteerExcel';
			form1.act.value='EditVolunteer';
			form1.submit();
		}
}
function f_email()
{
	 if(submitCheckbox(form1.membercheckbox,"请选择有邮箱的会员，如果没有会员没有邮箱\n\r系统是不发送信息"))
	  {
		 var fname=document.getElementsByName("membercheckbox");
			var lname="/"; 

			    for(var i=0; i<fname.length; i++)
			    { 
			    	if( fname[i].checked==true){
			       	   lname = lname + fname[i].value+"/"; 
			       }
			     }

			    
			    
			
			var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:830px;dialogHeight:710px;';
			 var url = '/jsp/volunteer/VolunteerEmail.jsp?t='+new Date().getTime()+"&member="+encodeURIComponent(lname);
			 var rs = window.showModalDialog(url,self,y);
			 
	  }

		 
}
</script>
<h1 style="width:1002px;margin-left:0px;">志愿者报名列表</h1>
<form name="form2" action="?" method="POST">
<input type="hidden" name="id" value="<%=request.getParameter("id") %>">
<table border="1" CELLPADDING="0" CELLSPACING="0" id="tablecenter" bordercolor="#dfdfdf"> 
  <tr>
  <td align="right" nowrap>姓名：</td><td><input type="text" size="20" name="firstname" value="<%=Entity.getNULL(firstname) %>"></td>
  <td align="right" nowrap>手机号：</td><td><input type="text" name="mobile" size="20"  mask="int" value="<%=Entity.getNULL(mobile) %>"></td>
  
    <td align="right" nowrap>性别：</td><td><select name="sex">
      <option value="3"   <%if(sex==3)out.print("selected");%> >---</option>
      <option value="1"   <%if(sex==1)out.print("selected");%> >男</option>
      <option value="0" <%if(sex==0)out.print("selected");%>>女</option></select></td></tr>
      <tr><td align="right" nowrap>邮箱：</td><td><input type="text" name="email" size="20" value="<%=Entity.getNULL(email)%>" ></td>
      <td align="right" nowrap>现居住地所在区县：</td><td>
      
      <%
      if(membertype==2)
      {
    	  out.println("<input type=text size=20 name=cityname value = "+Entity.getNULL(cityname)+">"); 
      }else{
      
      %>
      
        <select name="city">
        <option value="">-选择区县-</option>
      <%
      for(int i=0;i<Volunteer.CITYS.length;i++)
      {
        out.print("<option value="+i);
        if(String.valueOf(i).equals(city))
        {
          out.print(" selected ");
        }
        out.print(" >"+Volunteer.CITYS[i]+"</option>");
      }

      %>
      </select>
      <%} %>
      </td><td align="right" nowrap>职业：</td><td><input type="text" name="zhiye" size="20" value="<%=Entity.getNULL(zhiye)%>"  ></td></tr>
      <tr><td colspan="10" align="center"><input type="submit" value="查询" /></td></tr>

</table>
</form>
<h2 style="width:1002px;margin-left:0px;height:25px;*height:30px;padding-top:5px;">列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="2"><%=count%></font>&nbsp;位新注册志愿者&nbsp;)&nbsp;&nbsp;
<input type="button" value="导出信息EXCEL" onClick="f_excel2();">&nbsp;&nbsp;
<input type="button" value="导入信息EXCEL" onClick="window.open('/jsp/volunteer/Imports.jsp?nexturl=<%=nexturl %>','_self')">&nbsp;&nbsp;
<input type="button" value="发送Email" onClick="f_email();">&nbsp;&nbsp;

</h2>

<form name="form1" action="?" method="GET">

<input type="hidden" name="act" >
<input type="hidden" name="files" value="志愿者信息表"/> 
<input type="hidden" name="sql" value="<%=MT.enc(sql.toString())%>">


<table border="1" CELLPADDING="0" CELLSPACING="0" id="tablecenter" bordercolor="#dfdfdf">
 <tr id="tableonetr">
 <td width="1"><input type='checkbox' name="checkall" onclick='CheckAll()' title="全选" style="cursor:pointer"></td>
      <td nowrap>会员ID
      </td><td nowrap>姓名</td>
      <td nowrap>性别</td>
      <td nowrap>职业</td>
      
      <td nowrap>手机号</td>
      <td nowrap>座机电话</td>
      <td nowrap>邮箱</td>
      <TD NOWRAP>所在区县</TD>
       <TD NOWRAP>用户状态</TD>      
       <TD NOWRAP>注册时间</TD> 
      <td>操作</td>
     

</tr>
<%
java.util.Enumeration eu = Profile.find(sql.toString(),pos,size);
if(!eu.hasMoreElements())
{
	out.print("<tr><td colspan=20 align=center>暂无记录</td></tr>");
}
for(int i=0;eu.hasMoreElements();i++)
{
	
  String member = String.valueOf(eu.nextElement());
  Profile pobj = Profile.find(member);
  Volunteer vt  =  Volunteer.find(member);
  Profile pro = Profile.find(member);
  String sexy = pro.isSex()?"男":"女";
  String cstring = null;
  if(pobj.getCity(teasession._nLanguage).matches("\\d+"))     //正则表达式 详细见java.util.regex 类 Pattern
  {
	  cstring = Volunteer.CITYS[Integer.parseInt(pobj.getCity(teasession._nLanguage))];
  }else
  {
	  cstring =pobj.getCity(teasession._nLanguage);
  }

 

  
  %>
 <tr onMouseOver=bgColor="#BCD1E9" onMouseOut=bgColor="">
   <td width=1><input type=checkbox name=membercheckbox value="<%=member%>" style="cursor:pointer"></td>
      <td nowrap="nowrap"><%=member%></td>
    <td nowrap="nowrap"><%=pro.getName(teasession._nLanguage)%></td>
    <td nowrap="nowrap"><%=sexy%></td>
    <td nowrap="nowrap"><%=Entity.getNULL(vt.getZhiye())%></td>
   
    <td nowrap><%=pro.getMobile()%></td>
    <td nowrap><%=pro.getTelephone(teasession._nLanguage)%></td>
     <td nowrap><%=pro.getEmail()%></td>
     <td><%=cstring %></td>
     <td nowrap="nowrap"><%
     	if(vt.getMembertype()==0)
     	{
     		out.println("新注册用户");
     	}else if(vt.getMembertype()==1)
     	{
     		out.println("老用户登记");
     	}else if(vt.getMembertype()==2)
     	{
     		out.println("老用户未登记");
     	}else if(vt.getMembertype()==3)
     	{
     		out.println("网站导入");
     	}else if(vt.getMembertype()==4)
     	{
     		out.println("快速注册用户");
     	}
     %></td>
     <td><%=Entity.sdf.format(vt.getTimes()) %></td>

    <td>
    <input type="button" value="编辑" onClick="window.open('/jsp/volunteer/EditVolunteer.jsp?members=<%=member%>&membertypeact=dj&membertype=<%=membertype%>&nexturl=<%=nexturl%>','_self');">
      <input type="button" value="删除" onClick="if(confirm('确认删除')){window.open('/jsp/volunteer/VolunteerAdminList.jsp?delete=1&memberd=<%=member%>&membertype=<%=membertype%>&adminrole=<%=adminrole%>', '_self');this.disabled=true;};" >
      
     
    </td> 
  </tr>
  <%
  }
  %>
  <% 
  	if(count>size){
  %>
  <tr><td colspan="20"  align="center" style="padding-right:5px;"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%></td></tr>
<%} %>
  </table>
</form>
</body>
</html>
