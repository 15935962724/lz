<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.Entity"%><%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.*"%>

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


if("actpaw".equals(teasession.getParameter("act")))
{
	String m = teasession.getParameter("member");
	Profile pobj = Profile.find(m);

	String contents = "亲爱的订户您好，您的密码已经被系统自动修改，您现在的新密码为："+pobj.getPassword()+"。造成的这种情况的原因可能是您当天登录超过5次，或是您的帐户被盗。如有疑问或者反映登录问题请致电010-84229199与我们联系。";
	tea.service.SendEmaily se = new tea.service.SendEmaily(teasession._strCommunity);
    se.sendEmail(pobj.getEmail(),"用户密码提示",contents);//p.getEmail()

}

String nexturl = request.getRequestURI();

StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);

StringBuffer sql=new StringBuffer(" AND  p.member !="+DbAdapter.cite("webmaster"));

//用户ID
String member = teasession.getParameter("member");
if(member!=null && member.length()>0){
	member = member.trim();
	sql.append(" and p.member like ").append(DbAdapter.cite("%"+member+"%"));
	param.append("&member=").append(URLEncoder.encode(member,"UTF-8"));
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
/*
//性别
int sex= -1;
if(teasession.getParameter("sex")!=null && teasession.getParameter("sex").length()>0){
	sex = Integer.parseInt(teasession.getParameter("sex"));
}
if(sex>=0){
	sql.append(" and p.sex= ").append(sex);
	param.append("&sex=").append(sex);
}
*/
//审核状态
int verifg= -1;
if(teasession.getParameter("verifg")!=null && teasession.getParameter("verifg").length()>0){
	verifg = Integer.parseInt(teasession.getParameter("verifg"));
}
if(verifg>=0){
	  sql.append(" AND m.verifg =").append(verifg);
	  param.append("&verifg=").append(verifg);
}

//省份

String city = teasession.getParameter("city");
if(city==null || city.length()==0)
 city = teasession.getParameter("state");
if(city!=null && city.length()>0)
{
	sql.append(" and exists (select pl.member from ProfileLayer pl where p.member = pl.member and pl.city like "+DbAdapter.cite(city+"%")+") ");
	param.append("&city=").append(city);
}
//姓名


String firstname = teasession.getParameter("firstname");

if(firstname!=null && firstname.length()>0)
{
	firstname =firstname.trim();
	sql.append(" and exists (select pl.member from ProfileLayer pl where p.member = pl.member and pl.firstname like "+DbAdapter.cite("%"+firstname+"%")+") ");
	param.append("&firstname=").append(URLEncoder.encode(firstname,"UTF-8"));
}

//工作单位查询


String organization = teasession.getParameter("organization");

if(organization!=null && organization.length()>0)
{

	sql.append(" and exists (select pl.member from ProfileLayer pl where p.member = pl.member and pl.organization like "+DbAdapter.cite("%"+organization+"%")+") ");
	param.append("&organization=").append(URLEncoder.encode(organization,"UTF-8"));
}


//会员类型
int membertype = 0;
if(teasession.getParameter("membertype")!=null && teasession.getParameter("membertype").length()>0)
{
	membertype = Integer.parseInt(teasession.getParameter("membertype"));
}
if(membertype>0)
{
	if(membertype==100)
	{
		sql.append(" and m.period > 0");
	}else
	{
		sql.append("  and m.period =0 and m.membertype = ").append(membertype);
	}
	param.append("&membertype=").append(membertype);
}
//汇款会员

int remittance = -1;
if(teasession.getParameter("remittance")!=null && teasession.getParameter("remittance").length()>0)
{
	remittance = Integer.parseInt(teasession.getParameter("remittance"));
}
if(remittance>=0)
{
	if(remittance==0){
		sql.append(" and ( m.remittance =0 or m.remittance is null ) ");
	}else{
		sql.append(" and m.remittance >0");
	}
		param.append("&remittance=").append(remittance);
}

// 阅读有效期

String becometime_c = teasession.getParameter("becometime_c");
if(becometime_c!=null && becometime_c.length()>0)
{
  sql.append(" AND m.becometime >=").append(DbAdapter.cite(becometime_c+" 00:00"));
  param.append("&becometime_c=").append(becometime_c);
}
String becometime_d = teasession.getParameter("becometime_d");
if(becometime_d!=null && becometime_d.length()>0)
{
  sql.append(" AND m.becometime <=").append(DbAdapter.cite(becometime_d+" 23:59"));
  param.append("&becometime_d=").append(becometime_d);
}
//邮寄状态状态
int invoicetype =-1;
if(teasession.getParameter("invoicetype")!=null && teasession.getParameter("invoicetype").length()>0){
	invoicetype = Integer.parseInt(teasession.getParameter("invoicetype"));
}
if(invoicetype>=0){
	if(invoicetype==0){
		sql.append(" and ( m.invoicetype =").append(invoicetype).append(" or m.invoicetype is null )");
	}else
	{
		sql.append(" and  m.invoicetype =").append(invoicetype);
	}

	param.append("&invoicetype=").append(invoicetype);
}
// 汇款状态
int remtype  = -1;
if(teasession.getParameter("remtype")!=null && teasession.getParameter("remtype").length()>0){
	remtype = Integer.parseInt(teasession.getParameter("remtype"));
}
if(remtype>=0){
	sql.append(" and m.remtype = ").append(remtype);
	param.append("&remtype=").append(remtype);
}
//汇款金额
String remittance2 = teasession.getParameter("remittance2");
int rt = 0;
if(remittance2!=null && remittance2.length()>0){
	rt = Integer.parseInt(teasession.getParameter("remittance2"));

}
if(rt>0)
{
	sql.append(" and m.remittance = ").append(rt);
	param.append("&remittance2=").append(remittance2);
}
//是否锁定
int servicetype = -1;
if(teasession.getParameter("servicetype")!=null && teasession.getParameter("servicetype").length()>0)
{
	servicetype = Integer.parseInt(teasession.getParameter("servicetype"));
}

if(servicetype>-1)
{
	sql.append(" and servicetype = ").append(servicetype);
	param.append("&servicetype=").append(servicetype);
}
//电子报查看 是否锁定
int newlock = -1;
if(teasession.getParameter("newlock")!=null && teasession.getParameter("newlock").length()>0)
{
	newlock = Integer.parseInt(teasession.getParameter("newlock"));
}

if(newlock==0)
{
	  sql.append("   AND ( p.newlockingdata <=").append(DbAdapter.cite(Entity.sdf.format(new Date())+" 00:00") +" or p.newlockingdata  is null )");

	  param.append("&newlock=").append(newlock);
}else  if(newlock==1)
{
	  sql.append("   AND p.newlockingdata >").append(DbAdapter.cite(Entity.sdf.format(new Date())+" 00:00"));

	  param.append("&newlock=").append(newlock);
}

int pos=0,pageSize=10;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

String divid = "cnlistid_cmid";//默认最新投稿
if(teasession.getParameter("divid")!=null && teasession.getParameter("divid").length()>0)
{
	divid = teasession.getParameter("divid");
	param.append("&divid=").append(divid);
}



int count=MemberOrder.countMP(teasession._strCommunity,sql.toString());


String o=request.getParameter("o");
if(o==null)
{
  o="times";
}

boolean aq=Boolean.parseBoolean(request.getParameter("aq"));
sql.append(" ORDER BY ").append(o).append(" ").append(aq?"ASC":"DESC");
param.append("&o=").append(o).append("&aq=").append(aq);

//sql.append(" order by times desc ");







if("ClssnMemberEmailValid".equals(teasession.getParameter("actvalid"))){//劳动报用户邮箱验证
	String membervalid = teasession.getParameter("membervalid");

	Profile pmembervalid = Profile.find(membervalid);
	pmembervalid.setValidate(true);
	out.print("true");
	return;
}


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

		if(igd=='audit')//审核
		{
			if(confirm('您确定要审核选中会员吗？'))
			{
				form1.action='/servlet/EditMemberType';
				form1.act.value='member_audit';
				form1.nexturl.value=location.pathname+location.search;
	    		form1.submit();
			}
		}

		//还原

		if(igd=='cancel_audit')//
		{

			if(confirm('您确定要还原选中会员吗？'))
			{
				form1.action='/servlet/EditMemberType';
				form1.act.value='member_cancel_audit';
				form1.nexturl.value=location.pathname+location.search;
	    		form1.submit();
			}
		}
		//拒绝
			if(igd=='refusal')//
		{
			if(confirm('您确定要拒绝选中会员吗？'))
			{
				form1.action='/servlet/EditMemberType';
				form1.act.value='member_refusal';
				form1.nexturl.value=location.pathname+location.search;
	    		form1.submit();
			}
		}
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

		//代理
		if(igd=='proxymember')
		{
			if(confirm('您确定要设置代理会员吗？'))
			{
				form1.action='/servlet/EditMemberType';
				form1.act.value='member_proxymember';
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
				form1.act.value='ClssnMember';
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
function f_Upgrade(igd)
{
	 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:757px;dialogHeight:650px;';
	 var url = '/jsp/mov/UpgradeMember.jsp?memberorder='+igd+'&t='+new Date().getTime();
	 var rs = window.showModalDialog(url,self,y);
	 if(rs==1)
	 {
		 window.location.reload();
	 }
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
function f_mailbox()
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
	 var url = '/jsp/mov/ClssnMailbox.jsp?t='+new Date().getTime()+"&member="+encodeURIComponent(lname)+"&sql="+encodeURIComponent(form1.sql.value);
	 var rs = window.showModalDialog(url,self,y);
	 if(rs==1)
	 {
		 window.location.reload();
	 }
}
/*
 * 锁定电子报查看 会员
 */
function f_locking(igd)
{


		 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:630px;dialogHeight:310px;';
		 var url = '/jsp/mov/ClssnLocking.jsp?t='+new Date().getTime()+"&member="+encodeURIComponent(igd);
		 var rs = window.showModalDialog(url,self,y);


}
//汇款信息统计
function f_remittance()
{
	var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:530px;dialogHeight:610px;';
	 var url = '/jsp/mov/ClssnRemittance.jsp?t='+new Date().getTime();
	 var rs = window.showModalDialog(url,self,y);

}
//金牌会员设置有效期
function f_goldmedal()
{
	 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:630px;dialogHeight:410px;';
	 var url = '/jsp/mov/ClssnGoldmedal.jsp?t='+new Date().getTime();
	 var rs = window.showModalDialog(url,self,y);
	 if(rs==1)
	 {
		 window.location.reload();
	 }
}
//导入打印的邮寄地址word
function f_word()
{

	 if(submitCheckbox(form1.memberorder,"请选中要导出的会员"))
	  {

			var fname=document.getElementsByName("memberorder");
			var lname="/";

			    for(var i=0; i<fname.length; i++)
			    {
			    	if( fname[i].checked==true){
			       	   lname = lname + fname[i].value+"/";
			       }
			     }


			    window.open('/jsp/mov/ClssnexpWord.jsp?t='+new Date().getTime()+"&memberorderall="+encodeURIComponent(lname),'_self');

		//	var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:830px;dialogHeight:710px;';
		//	 var url = '/jsp/mov/ClssnexpWord.jsp?t='+new Date().getTime()+"&memberorderall="+encodeURIComponent(lname);
		//	 var rs = window.showModalDialog(url,self,y);
		//	 if(rs==1)
		//	 {
			//	 window.location.reload();
		//	 }
	  }
}


//邮箱验证
function f_email_valid(igd)
{

	sendx("/jsp/mov/ClssnMember.jsp?actvalid=ClssnMemberEmailValid&membervalid="+encodeURIComponent(igd),
		 function(data)
		 {
		   if(data!=''&&data.length>1)//如果有这个用户  则写入Cookie
		   {
			   alert('邮箱验证成功');
			   window.location.reload();
		   }
		 }
	);
}
//点击锁定次数 ，显示用户状态
function f_cms(igd)
{

	var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:257px;dialogHeight:250px;';
	 var url = '/jsp/mov/ClssnMemberStatus.jsp?memberorder='+igd+'&t='+new Date().getTime();
	 var rs = window.showModalDialog(url,self,y);

}
//点击金额查询
function f_rem()
{

	 sendx("/jsp/admin/edn_ajax.jsp?act=ClssnMember_rem",
			 function(data)
			 {


			   if(data!=''&&data.length>1)//如果有这个用户  则写入Cookie
			   {

				   document.getElementById("showrem").innerHTML=data;
			   }
			 }
			 );

}
//发送密码
function f_paw(igd)
{
	sendx("?act=actpaw&member="+encodeURIComponent(igd),
			 function(data)
			 {
			   if(data!=''&&data.length>1)//如果有这个用户  则写入Cookie
			   {
				   alert('密码发送成功');
				   window.location.reload();
			   }
			 }
		);
}
//其他显示
function f_qt()
{

	var hid = document.getElementById("hiddenid").style.display;

	if(hid=='none')
	{
		document.getElementById("hiddenid").style.display='';
	}else
	{
		document.getElementById("hiddenid").style.display='none';
	}
}
//邮寄状态设置初始化
var str = "";
document.writeln("<div id=\"_contents\" style=\"padding:6px; background-color:#E3E3E3; font-size: 12px; border: 1px solid #777777;  position:absolute; left:?px; top:?px; width:?px; height:?px; z-index:1; visibility:hidden\">");


str += '<select id="invoicetype" name="invoicetype">';

    str += '<option value="0">不需要</option>';
    str += '<option value="1">未寄</option>';
    str += '<option value="2">已寄</option>';


	str += '</select>&nbsp;';
	str += '<input  type="button" onclick="_Determine()" value="确定" style="font-size:12px" >&nbsp;';
	str += '<input  type="button" onclick="_Cancel()" value="取消" style="font-size:12px" >';
	str += '</div>';

document.writeln(str);
var _fieldname;
//邮寄状态设置
function _Setshoudong(tt) {


	if(document.all._contents.style.visibility=='hidden')
	{
	    _fieldname = tt;
	    var ttop = tt.offsetTop;    //TT控件的定位点高
	    var thei = tt.clientHeight;    //TT控件本身的高
	    var tleft = tt.offsetLeft;    //TT控件的定位点宽
	    while (tt = tt.offsetParent)
	    {
	        ttop += tt.offsetTop;
	        tleft += tt.offsetLeft;
	    }
	    document.all._contents.style.top = ttop + thei + 4;
	    document.all._contents.style.left = tleft;
	    document.all._contents.style.visibility = "visible";
	}

	else
	{
		document.all._contents.style.visibility='hidden';
	}
}
function _Determine()
{
	//判断是否选中手动付款的记录
	  if(submitCheckbox(form1.memberorder,"请选择要操作的会员."))
     {
		   //判断是否选中手动付款的记录
		    var ch = form1.memberorder;
		    var porders ="/";
			if((ch.length+"")=="undefined")
			{
		 	 		if(!ch.checked)
		 	 		{
		 	 			alert("您还没有选中订单信息!");
						return false;
		 	 	 	}else
			 	 	{
		 		 	 	  form1.porders.value=porders+ch.value+"/";
		 			 	}

		 	 }else
		 	 {
				    var f = false;

				    for (var i=0; i< ch.length; i++)
				    {
				      if (form1.memberorder[i].checked)
				      {
				    	  porders = porders+form1.memberorder[i].value+"/";
					      f = true;

					  }
				    }
				    form1.porders.value=porders;

				    if(!f)
				    {
						alert("您还没有选中订单信息!");
						return false;
				    }
		 	 }

		var intype  = document.getElementById("invoicetype");
		var str_url = "?act=ClssnMember_Determine&porders="+form1.porders.value+"&invoicetype="+intype.value
	    sendx("/jsp/admin/edn_ajax.jsp"+str_url,
	      		 function(data)
	      		 {
	 		 		alert(data.trim());
	 		 		window.location.reload();
	      		 }
	      	);

     }
}
//取消
function _Cancel()
{
	 document.all._contents.style.visibility = "hidden";
}
</script>

<h1>会员审核管理</h1>


<form action="?" name="form2">
<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>


<input type="hidden" name="id" value="<%=request.getParameter("id") %>">
<input type="hidden" name="membertype" value="<%=membertype %>"/>
<input type="hidden" name="divid" value="<%=divid %>"/>


<h2>查询</h2>

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
		<td nowrap align="right">用户名：</td>
		<td><input type="text" name="member" value="<%=Entity.getNULL(member) %>"/></td>
		<td align="right">姓名：</td>
		<td>
			<input type="text" name=firstname value="<%=Entity.getNULL(firstname) %>">
		</td>

		<td align="right">申请时间：</td>
		<td>
		 从&nbsp;
	        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>"  style="cursor:pointer" readonly="readonly" onClick="new Calendar().show('form2.time_c');">
	        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form2.time_c');" />
	        &nbsp;到&nbsp;
	        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>"  style="cursor:pointer" readonly="readonly" onClick="new Calendar().show('form2.time_d');" >
	        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"   style="cursor:pointer" onclick="new Calendar().show('form2.time_d');" />

		</td>

		</tr>
		<tr>

		<td align="right">审核状态：</td>
		<td>
			<select name="verifg">

		   		<option value="-1">-审核状态-</option>
		   		<%
		   			for(int i=0;i<Photography.AUDIT_TYPE.length;i++){
		   				out.print("<option value = "+i);
		   				if(verifg == i){
		   					out.print(" selected ");
		   				}
		   				out.print(">"+Photography.AUDIT_TYPE[i]);
		   				out.print("</option>");
		   			}
		   		%>
		</select>
		</td>


		<td align="right">阅读有效期：</td>
		<td>
		 从&nbsp;
	        <input id="becometime_c" name="becometime_c" size="7"  value="<%if(becometime_c!=null)out.print(becometime_c);%>"  style="cursor:pointer" readonly="readonly" onClick="new Calendar().show('form2.becometime_c');">
	        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form2.becometime_c');" />
	        &nbsp;到&nbsp;
	        <input id="becometime_d" name="becometime_d" size="7"  value="<%if(becometime_d!=null)out.print(becometime_d);%>"  style="cursor:pointer" readonly="readonly" onClick="new Calendar().show('form2.becometime_d');" >
	        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"   style="cursor:pointer" onclick="new Calendar().show('form2.becometime_d');" />

		</td>

		<td align="right">省份：</td>
		<td><script>selectcard('state','city',null,'<%=city%>');</script></td>

			</tr>
		<tr>

		<td align="right">工作单位：</td>
		<td>
			<input type="text" name="organization" value="<%=Entity.getNULL(organization) %>">

		</td>

		<td align="right">邮寄状态：</td>
		<td>
			<select name="invoicetype">
			<option value="-1" <%if(invoicetype==-1)out.print(" selected "); %>>-邮寄状态-</option>
				<%
				for(int i=0;i<MemberOrder.INVOICE_TYPE.length;i++)
				{
					out.print("<option value="+i);
					if(invoicetype==i){
						out.print(" selected ");
					}
					out.print(">"+MemberOrder.INVOICE_TYPE[i]);
					out.print("</option>");
				}
				%>
			</select>
		</td>
		<td align="right">是否汇款：</td>
		<td>
			<select name="remittance">
			<option value="-1" <%if(remittance==-1)out.print(" selected "); %>>-是否汇款-</option>
			<option value="0" <%if(remittance==0)out.print(" selected "); %>>-否-</option>
			<option value="1" <%if(remittance==1)out.print(" selected "); %>>-是-</option>

			</select>
		</td>
			</tr>

		<tr>
		<td align="right">汇款方式：</td>
		<td>
			<select name="remtype">
			<option value="-1" <%if(remtype==-1)out.print(" selected "); %>>-汇款方式-</option>
				<%
				for(int i=0;i<MemberOrder.REM_TYPE.length;i++)
				{
					out.print("<option value="+i);
					if(remtype==i){
						out.print(" selected ");
					}
					out.print(">"+MemberOrder.REM_TYPE[i]);
					out.print("</option>");
				}
				%>
			</select>
		</td>

		<td nowrap align="right">汇款金额：</td>
		<td ><input type="text" name="remittance2" value="<%=Entity.getNULL(remittance2) %>" size=4 onclick="f_rem();">
		&nbsp;<span  id="showrem"></span>
		</td>

		<td align="right">是否锁定(登陆)：</td>
		<td>
			<select name="servicetype">
			<option value="-1" <%if(servicetype==-1)out.print(" selected "); %>>-是否锁定-</option>
			<option value="0" <%if(servicetype==0)out.print(" selected "); %>>-否-</option>
			<option value="1" <%if(servicetype==1)out.print(" selected "); %>>-是-</option>
			</select>
		</td>

		</tr>
		<tr>
			<td align="right">是否锁定(电子报)：</td>
		<td>
			<select name="newlock">
			<option value="-1" <%if(newlock==-1)out.print(" selected "); %>>-是否锁定-</option>
			<option value="0" <%if(newlock==0)out.print(" selected "); %>>-否-</option>
			<option value="1" <%if(newlock==1)out.print(" selected "); %>>-是-</option>
			</select>
		</td>

		</tr>


		<tr>

	    <td colspan="10" align="center"><input type="submit" value="查询"/></td>
	    </tr>
	</tr>
 </table>
</form>

<form name="form1" action ="?" method="post">
<input type="hidden" name="nexturl">
<input type="hidden" name="membertype"/>
<input type="hidden" name="divid"/>
 <input type="hidden" name="o" VALUE="<%=o%>">
 <input type="hidden" name="porders">
      <input type="hidden" name="aq" VALUE="<%=aq%>">

<input type="hidden" name="id" value="<%=request.getParameter("id") %>">

<input type="hidden" name="act">
<input type="hidden" name="memberlist_act" value="MemberList">
<input type="hidden" name="files" value="会员列表"/>
<input type="hidden" name="sql" value="<%=MT.enc(sql.toString())%>">
<!-- sql.toString() -->

<h2>会员列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;位会员&nbsp;)&nbsp;&nbsp;<a href="###"  onClick="f_qt();">更多</a>&nbsp;</h2>
<h2 class="cnclass">
<!--
<input type="button" value="　审核　" onclick="f_sub('audit','请选择您要审核的会员!');">&nbsp; -->
<div class="cnlistLeft">

<input type="button" value="设置代理" onClick="f_sub('proxymember','请选择您要代理的会员!');">&nbsp;
<input type="button" value="汇款统计" onClick="f_remittance();">&nbsp;
<input type="button" value="金牌会员设置" onClick="f_goldmedal();">&nbsp;
<input type="button" value="邮寄状态" onClick="_Setshoudong(this);">&nbsp;
<input type="button" value="导出word" onClick="f_word();">&nbsp;


<span id="hiddenid" style="display:none">
<input type="button" value="还原" onClick="f_sub('cancel_audit','请选择您要还原的会员!');">&nbsp;
<input type="button" value="拒绝" onClick="f_sub('refusal','请选择您要拒绝的会员!');">&nbsp;
<input type="button" value="删除" onClick="f_sub('delete','请选择您要删除的会员!');">&nbsp;
<input type="button" value="导出EXCEL" onClick=f_excel();>&nbsp;
<input type="button" value="发Email" onClick=f_email();>&nbsp;
<input type="button" value="短消息" onClick="f_mailbox();">&nbsp;
</span>



</div>
<%
out.print("<span id=cnlistRight>");

out.print("<a href=### onclick=f_s('0','cnlistid_cmid'); class=cnlistclass2");
if("cnlistid_cmid".equals(divid))
{
	out.print(" id ="+divid);
}
out.print(">全部会员</a>");

out.print("<a href=### onclick=f_s('1','cnlistid_cmid2'); class=cnlistclass2");
if("cnlistid_cmid2".equals(divid))
{
	out.print(" id ="+divid);
}
out.print(">普通会员</a>");
	out.print("<a href=### onclick=f_s('100','cnlistid_cmid3'); class=cnlistclass3");
	if("cnlistid_cmid3".equals(divid))
	{
		out.print(" id ="+divid);
	}
	out.print(">金牌会员</a>");

	out.print("<a href=### onclick=f_s('2','cnlistid_cmid4'); class=cnlistclass4");
	if("cnlistid_cmid4".equals(divid))
	{
		out.print(" id ="+divid);
	}
	out.print(">数字报会员</a>");





	out.print("</span>");

 %>
 </h2>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	   <tr id=tableonetr>
  			  <td width="1"><input type='checkbox' name="checkall" onclick='CheckAll()' title="全选" style="cursor:pointer"></td>

  			  <td nowrap>用户名</td>
  			  <td nowrap>姓名</td>
  			  <td nowrap>会员类型</td>

  			  <td nowrap>省份</td>
  			   <td nowrap>阅读有效期</td>

  			    <td nowrap>汇款金额</td>
  			  <td nowrap>邮寄状态</td>
  			   <td nowrap><b>操作</b></td>

  			  <!-- <td nowrap>性别</td>-->
  			  <td nowrap>申请时间</td>
  			  <td nowrap>邮箱验证</td>
  			  <td nowrap>审核状态</td>
  			  <td nowrap>是否锁定(登陆)</td>


  			  <TD nowrap><a href="javascript:f_order('servicetypenumber');">锁定次数</a>
           <%
          if(o.equals("servicetypenumber"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %>
          </TD>


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
    	    String cname="";

    	    Pattern pattern = Pattern.compile("[0-9]*");
    		Matcher isNum = pattern.matcher(pobj.getCity(teasession._nLanguage));


    	    if(isNum.matches()&&pobj.getCity(teasession._nLanguage)!=null && pobj.getCity(teasession._nLanguage).length()>0 && !"--------------".equals(pobj.getCity(teasession._nLanguage)))
    	    {
    	    	tea.entity.util.Card cobj = tea.entity.util.Card.find(Integer.parseInt(pobj.getCity(teasession._nLanguage)));
    	    	cname = cobj.toString();
    	    }



    %>
    <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
      <td width=1><input type=checkbox name="memberorder" value="<%=memberorder%>" style="cursor:pointer"></td>

      <td><%=moobj.getMember() %></td>
         <td><%=pobj.getFirstName(teasession._nLanguage) %></td>
      <td><%
      if(membertype==100){out.print("金牌会员");}else{
      	if(moobj.getPeriod()>0){
      		out.print("金牌会员");
      	}else{
      		out.print(mtobj.getMembername());
      	}
      }
      	%></td>

      <td nowrap><%=cname %></td>
        <td nowrap><%if(moobj.getBecometime()!=null)out.print(Entity.sdf.format(moobj.getBecometime())); %></td>


        <td><%=moobj.getRemittance() %></td>
	   <td><%=moobj.INVOICE_TYPE[moobj.getInvoicetype()] %></td>
	   <td nowrap><b>
		   <%if(moobj.getVerifg()==0){
		   //审核按钮
		   %>
		   <a href="/jsp/mov/ClssnEditMember.jsp?member=<%=URLEncoder.encode(moobj.getMember(),"UTF-8") %>&memberorder=<%=memberorder %>&membertype=<%=moobj.getMembertype() %>&actclssn=member_audit&nexturl=<%=URLEncoder.encode(nexturl,"UTF-8") %>">审核</a>&nbsp;
		   <%}%>
		   <%
		   	//邮箱验证
		   	if(Profile.findValid(moobj.getMember())!=1){
			 // out.print(Profile.findValid(moobj.getMember()));
		   %>
		   <a href="###" onclick="f_email_valid('<%=moobj.getMember() %>');">邮箱验证</a>
		   <%} %>

		   <a href="/jsp/mov/ClssnEditMember.jsp?member=<%=URLEncoder.encode(moobj.getMember(),"UTF-8") %>&memberorder=<%=memberorder %>&membertype=<%=moobj.getMembertype() %>&nexturl=<%=URLEncoder.encode(nexturl,"UTF-8") %>">编辑</a>&nbsp;
		   <%

		   		if(moobj.getPeriod()>0){
		   			out.print("<a href=### 	onclick=f_Upgrade('"+memberorder+"');>继续升级</a>");
		   		}else{
		   			out.print("<a href=### 	onclick=f_Upgrade('"+memberorder+"');>升级会员</a>");
		   		}

		   %>
		   <a href="###" onclick="f_locking('<%=moobj.getMember()%>');">锁定电子报会员</a>

		   <a href= "###" onclick="f_paw('<%=moobj.getMember()%>');">发送密码</a>
		</b>
	   </td>



      <!--<td><%if(pobj.isSex()){out.print("女");}else {out.print("男");} %></td>-->
      <td nowrap><%if(pobj.getTime()!=null)out.print(Entity.sdf2.format(pobj.getTime()));%></td>

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
      <td nowrap><%
	      if(moobj.getVerifg()==0)
	      {
	    	  out.print("<font color=red>"+Photography.AUDIT_TYPE[moobj.getVerifg()]+"</font>");
	      }else if(moobj.getVerifg()==1)
	      {
	    	  out.print("<font color=#00ab00>"+Photography.AUDIT_TYPE[moobj.getVerifg()]+"</font>");
	      }else if(moobj.getVerifg()==2){
	    	  out.print(Photography.AUDIT_TYPE[moobj.getVerifg()]);
	      }else
	      {
	    	  out.print("不审核");
	      }
      %></td>

	   <td><a href="###" onclick="f_cms('<%=memberorder %>');" title="点击查看会员账号状态"><%	if( moobj.getServicetype()==1){out.println("是");}
  			  	else{out.print("否");} %></a></td>
  	     <td><a href="###" onclick="f_cms('<%=memberorder %>');" title="点击查看会员账号状态"><%=moobj.getServicetypenumber()	%></a></td>

    </tr>
<%} %>
     <%if (count > pageSize) {  %>
      <tr> <td colspan="20"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>
</form>
</body>
</html>
