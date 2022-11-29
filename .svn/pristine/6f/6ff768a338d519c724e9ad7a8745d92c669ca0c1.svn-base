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


String nexturl = request.getRequestURI();

StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);

StringBuffer sql=new StringBuffer(" and membertype=1 AND community="+DbAdapter.cite(teasession._strCommunity)+" AND member !="+DbAdapter.cite("webmaster"));
boolean fas = false;

int remembertype=0;


if(teasession.getParameter("remembertype")!=null && teasession.getParameter("remembertype").length()>0)
{
	remembertype = Integer.parseInt(teasession.getParameter("remembertype"));
	sql.append(" and remembertype = ").append(remembertype);
	param.append("&remembertype=").append(remembertype);
}

//会员编号
String code = teasession.getParameter("code");
if(code!=null && code.length()>0)
{
	code = code.trim();
	sql.append(" and code like ").append(DbAdapter.cite("%"+code+"%"));
	param.append("&code=").append(code);
	fas = true;
}
//用户名
String memberid = teasession.getParameter("memberid");
if(memberid!=null && memberid.length()>0)
{
	memberid = memberid.trim();
	sql.append(" and member like "+DbAdapter.cite("%"+memberid+"%")+"  ");
	param.append("&memberid=").append(URLEncoder.encode(memberid,"UTF-8"));
	fas = true;
}
//注册时间
String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND time >=").append(DbAdapter.cite(time_c+" 00:00"));
  param.append("&time_c=").append(time_c);
  fas = true;
}

String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND time <=").append(DbAdapter.cite(time_d+" 23:59"));
  param.append("&time_d=").append(time_d);
  fas = true;
}

//姓名
String membername = teasession.getParameter("membername");
if(membername!=null && membername.length()>0)
{
	membername = membername.trim();
	sql.append(" and exists (select member from ProfileLayer pl where pl.member=p.member AND pl.firstname like "+DbAdapter.cite("%"+membername+"%")+"  )");
	param.append("&membername=").append(URLEncoder.encode(membername,"UTF-8"));
	fas = true;
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
	fas = true;
}

//身份证

String card = teasession.getParameter("card");
if(card!=null && card.length()>0)
{
	card = card.trim();
	sql.append(" and card like "+DbAdapter.cite("%"+card+"%")+"  ");
	param.append("&card=").append(card);
	fas = true;
}


//手机
String mobile = teasession.getParameter("mobile");
if(mobile!=null && mobile.length()>0)
{
	mobile = mobile.trim();
	sql.append(" and mobile like "+DbAdapter.cite("%"+mobile+"%")+"  ");
	param.append("&mobile=").append(mobile);
	fas = true;
}

//生日

String birth = teasession.getParameter("birth");
if(birth!=null && birth.length()>0)
{
  sql.append(" AND birth >=").append(DbAdapter.cite(birth));
  param.append("&birth=").append(birth);
  fas = true;
}

String birth2 = teasession.getParameter("birth2");
if(birth2!=null && birth2.length()>0)
{
  sql.append(" AND birth <=").append(DbAdapter.cite(birth2));
  param.append("&birth2=").append(birth2);
  fas = true;
}



//工作地点城市
String city0 = teasession.getParameter("city0");
if(city0!=null && city0.length()>0)
{
		//province
	sql.append(" and exists (select member from ProfileLayer pl where pl.member=p.member AND pl.province like "+DbAdapter.cite("%"+city0+"%")+"  )");
	param.append("&city0=").append(city0);
	fas = true;

}

String city1 = teasession.getParameter("city1");
if(city1!=null && city1.length()>0)
{
		//province
	sql.append(" and exists (select member from ProfileLayer pl where pl.member=p.member AND pl.province like "+DbAdapter.cite("%"+city1+"%")+"  )");
	param.append("&city1=").append(city1);
	city0 = city1;
	fas = true;

}

//详细地址
String address = teasession.getParameter("address");
if(address!=null && address.length()>0)
{
	address = address.trim();
	sql.append(" and exists (select member from ProfileLayer pl where pl.member=p.member AND pl.address like "+DbAdapter.cite("%"+address+"%")+"  )");
	param.append("&address=").append(URLEncoder.encode(address,"UTF-8"));
	fas = true;
}
//民族 zzracky
String zzracky = teasession.getParameter("zzracky");

if(zzracky!=null && zzracky.length()>0)
{
	zzracky = zzracky.trim();
	sql.append(" and zzracky like "+DbAdapter.cite("%"+zzracky+"%")+"  ");
	param.append("&zzracky=").append(URLEncoder.encode(zzracky,"UTF-8"));
	fas = true;
}

//固定电话

String telephone = teasession.getParameter("telephone");
if(telephone!=null && telephone.length()>0)
{
	telephone = telephone.trim();
	sql.append(" and exists (select member from ProfileLayer pl where pl.member=p.member AND pl.telephone like "+DbAdapter.cite("%"+telephone+"%")+"  )");
	param.append("&telephone=").append(telephone);
	fas = true;
}
//家庭住址 省份
String zzhkszd0 = teasession.getParameter("zzhkszd0");
if(zzhkszd0!=null && zzhkszd0.length()>0)
{
		//province
	sql.append(" and exists (select member from ProfileLayer pl where pl.member=p.member AND pl.zzhkszd like "+DbAdapter.cite("%"+zzhkszd0+"%")+"  )");
	param.append("&zzhkszd0=").append(zzhkszd0);
	fas = true;

}

String zzhkszd1 = teasession.getParameter("zzhkszd1");
if(zzhkszd1!=null && zzhkszd1.length()>0)
{
		//province
	sql.append(" and exists (select member from ProfileLayer pl where pl.member=p.member AND pl.zzhkszd like "+DbAdapter.cite("%"+zzhkszd1+"%")+"  )");
	param.append("&zzhkszd1=").append(zzhkszd1);
	zzhkszd0 = zzhkszd1;
	fas = true;
}
//家庭住址 详细地址
String organization = teasession.getParameter("organization");
if(organization!=null && organization.length()>0)
{
	organization = organization.trim();
	sql.append(" and exists (select member from ProfileLayer pl where pl.member=p.member AND pl.organization like "+DbAdapter.cite("%"+organization+"%")+"  )");
	param.append("&organization=").append(URLEncoder.encode(organization,"UTF-8"));
	fas = true;
}
//邮编
String zip = teasession.getParameter("zip");
if(zip!=null && zip.length()>0)
{
	organization = organization.trim();
	sql.append(" and exists (select member from ProfileLayer pl where pl.member=p.member AND pl.zip like "+DbAdapter.cite("%"+zip+"%")+"  )");
	param.append("&zip=").append(zip);
	fas = true;
}

//电子邮箱
String email = teasession.getParameter("email");
if(email!=null && email.length()>0)
{
	email = email.trim();
	sql.append(" and email like "+DbAdapter.cite("%"+email+"%")+" ");
	param.append("&email=").append(email);
	fas = true;
}
//QQ--msn
String msn = teasession.getParameter("msn");
if(msn!=null && msn.length()>0)
{
	msn = msn.trim();
	sql.append(" and msn like "+DbAdapter.cite("%"+msn+"%")+" ");
	param.append("&msn=").append(msn);
	fas = true;
}

//现操作机型  品牌
int xpinpai = 0;
if(teasession.getParameter("xpinpai")!=null && teasession.getParameter("xpinpai").length()>0)
{
	xpinpai = Integer.parseInt(teasession.getParameter("xpinpai"));
}

if(xpinpai>0)
{
	sql.append(" and xpinpai  = ").append(xpinpai);
	param.append("&xpinpai=").append(xpinpai);
	fas = true;

}
//型号
int xxinghao = 0;
if(teasession.getParameter("xxinghao")!=null && teasession.getParameter("xxinghao").length()>0)
{
	xxinghao = Integer.parseInt(teasession.getParameter("xxinghao"));
}

if(xxinghao>0)
{
	sql.append(" and xxinghao  = ").append(xxinghao);
	param.append("&xxinghao=").append(xxinghao);
	fas = true;
}
//其他
String xqita = teasession.getParameter("xqita");
if(xqita!=null && xqita.length()>0)
{

	sql.append(" and xqita like  "+DbAdapter.cite("%"+xqita+"%")+" ");
	param.append("&xqita=").append(URLEncoder.encode(xqita,"UTF-8"));
	fas = true;
}



//推荐人会员编号tjmember
String tjmember = teasession.getParameter("tjmember");
if(tjmember!=null && tjmember.length()>0)
{
	tjmember = tjmember.trim();
	sql.append(" and tjmember like "+DbAdapter.cite("%"+tjmember+"%")+" ");
	param.append("&tjmember=").append(tjmember);
	fas = true;
}


//    private String memberheight;//身高


String memberheight = teasession.getParameter("memberheight");
if(memberheight!=null && memberheight.length()>0)
{
	memberheight = memberheight.trim();
	sql.append(" and memberheight like "+DbAdapter.cite("%"+memberheight+"%")+" ");
	param.append("&memberheight=").append(memberheight);
	fas = true;
}

// private String ballage;//打球年龄

String ballage = teasession.getParameter("ballage");
if(ballage!=null && ballage.length()>0)
{
	ballage = ballage.trim();
	sql.append(" and ballage like "+DbAdapter.cite("%"+ballage+"%")+" ");
	param.append("&ballage=").append(ballage);
	fas = true;
}

//private String almostscore;//差点or平均成绩

String almostscore = teasession.getParameter("almostscore");
if(almostscore!=null && almostscore.length()>0)
{
	almostscore = almostscore.trim();
	sql.append(" and almostscore like "+DbAdapter.cite("%"+almostscore+"%")+" ");
	param.append("&almostscore=").append(almostscore);
	fas = true;
}

//private String likeitems;//喜欢的;(木，球道，铁木，铁，推)

String likeitems = teasession.getParameter("likeitems");
if(likeitems!=null && likeitems.length()>0)
{
	likeitems = likeitems.trim();
	sql.append(" and likeitems like "+DbAdapter.cite("%"+likeitems+"%")+" ");
	param.append("&likeitems=").append(likeitems);
	fas = true;
}
//private String handfoot;//手尺
String handfoot = teasession.getParameter("handfoot");
if(handfoot!=null && handfoot.length()>0)
{
	handfoot = handfoot.trim();
	sql.append(" and handfoot like "+DbAdapter.cite("%"+handfoot+"%")+" ");
	param.append("&handfoot=").append(handfoot);
	fas = true;
}
//private String gdistance;//手碗到地面距离

String gdistance = teasession.getParameter("gdistance");
if(gdistance!=null && gdistance.length()>0)
{
	gdistance = gdistance.trim();
	sql.append(" and gdistance like "+DbAdapter.cite("%"+gdistance+"%")+" ");
	param.append("&gdistance=").append(gdistance);
	fas = true;
}
//private String yhand;//用手 右手，左手

String yhand = teasession.getParameter("yhand");
if(yhand!=null && yhand.length()>0)
{
	yhand = yhand.trim();
	sql.append(" and yhand like "+DbAdapter.cite("%"+yhand+"%")+" ");
	param.append("&yhand=").append(yhand);
	fas = true;
}
//private String swingrhythm;//挥杆节奏

String swingrhythm = teasession.getParameter("swingrhythm");
if(swingrhythm!=null && swingrhythm.length()>0)
{
	swingrhythm = swingrhythm.trim();
	sql.append(" and swingrhythm like "+DbAdapter.cite("%"+swingrhythm+"%")+" ");
	param.append("&swingrhythm=").append(swingrhythm);
	fas = true;
}


//private String entername;//企业名称
String entername = teasession.getParameter("entername");
if(entername!=null && entername.length()>0)
{
	entername = entername.trim();
	sql.append(" and entername like "+DbAdapter.cite("%"+entername+"%")+" ");
	param.append("&entername=").append(entername);
	fas = true;
}
//private String enterpic;//企业logo或图片
String enterpic = teasession.getParameter("enterpic");
if(enterpic!=null && enterpic.length()>0)
{
	enterpic = enterpic.trim();
	sql.append(" and enterpic like "+DbAdapter.cite("%"+enterpic+"%")+" ");
	param.append("&enterpic=").append(enterpic);
	fas = true;
}
//private String enterwebsite;//企业网站
String enterwebsite = teasession.getParameter("enterwebsite");
if(enterwebsite!=null && enterwebsite.length()>0)
{
	enterwebsite = enterwebsite.trim();
	sql.append(" and enterwebsite like "+DbAdapter.cite("%"+enterwebsite+"%")+" ");
	param.append("&enterwebsite=").append(enterwebsite);
	fas = true;
}
//private String entercontact;//联系方式
String entercontact = teasession.getParameter("entercontact");
if(entercontact!=null && entercontact.length()>0)
{
	entercontact = entercontact.trim();
	sql.append(" and entercontact like "+DbAdapter.cite("%"+entercontact+"%")+" ");
	param.append("&entercontact=").append(entercontact);
	fas = true;
}
//private String enteraddress;//地址
String enteraddress = teasession.getParameter("enteraddress");
if(enteraddress!=null && enteraddress.length()>0)
{
	enteraddress = enteraddress.trim();
	sql.append(" and enteraddress like "+DbAdapter.cite("%"+enteraddress+"%")+" ");
	param.append("&enteraddress=").append(enteraddress);
	fas = true;
}
//private String enterproduct;//服务或产品
String enterproduct = teasession.getParameter("enterproduct");
if(enterproduct!=null && enterproduct.length()>0)
{
	enterproduct = enterproduct.trim();
	sql.append(" and enterproduct like "+DbAdapter.cite("%"+enterproduct+"%")+" ");
	param.append("&enterproduct=").append(enterproduct);
	fas = true;
}
//private String enterweibo;// 企业微博
String enterweibo = teasession.getParameter("enterweibo");
if(enterweibo!=null && enterweibo.length()>0)
{
	enterweibo = enterweibo.trim();
	sql.append(" and enterweibo like "+DbAdapter.cite("%"+enterweibo+"%")+" ");
	param.append("&enterweibo=").append(enterweibo);
	fas = true;
}
//private String personalweibo;//个人微博
String personalweibo = teasession.getParameter("personalweibo");
if(personalweibo!=null && personalweibo.length()>0)
{
	personalweibo = personalweibo.trim();
	sql.append(" and personalweibo like "+DbAdapter.cite("%"+personalweibo+"%")+" ");
	param.append("&personalweibo=").append(personalweibo);
	fas = true;
}
//private String entertext;//企业介绍
String entertext = teasession.getParameter("entertext");
if(entertext!=null && entertext.length()>0)
{
	entertext = entertext.trim();
	sql.append(" and entertext like "+DbAdapter.cite("%"+entertext+"%")+" ");
	param.append("&entertext=").append(entertext);
	fas = true;
}







int pos=0,pageSize=10;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}




int count=Profile.count(sql.toString());
sql.append(" order by time desc ");



%>

<html>
<head>
<title>俱乐部高级会员管理</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/Calendar.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
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
			if(confirm('删除操作系统会把会员信息清空\n您确定要删除吗？'))
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

		}




     }
}

function f_excel()
		{
			if(confirm("您确定要导出数据吗?"))
		    {
				form1.action='/servlet/EditExcel';
				form1.act.value='GolfMember';
				form1.submit();
			}
	   }

//导入会员
function f_excelimp()
{
	var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:930px;dialogHeight:650px;';
	 var url = '/jsp/user/GolfMemberImports.jsp?t='+new Date().getTime()+"&community="+form1.community.value;
	 var rs = window.showModalDialog(url,self,y);

    // form1.submit();
	 window.location.reload();
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
	 var url = '/jsp/westrac/WestracEmail.jsp?t='+new Date().getTime()+"&member="+encodeURIComponent(lname)+"&sql="+encodeURIComponent(form1.sql.value);
	 var rs = window.showModalDialog(url,self,y);
	 if(rs==1)
	 {
		 window.location.reload();
	 }
}
function f_mailbox()
{
		var fname=document.getElementsByName("memberorder");
	var lname="";

	    for(var i=0; i<fname.length; i++)
	    {
	    	if( fname[i].checked==true){
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
//推荐好友
function f_tjmember(igd)
{
	if(confirm('您确定要执行功能吗')){
		  sendx("/jsp/admin/edn_ajax.jsp?act=WestracMemberTJ&member="+encodeURIComponent(igd),
					 function(data)
					 {
					    alert(data.trim());
					    window.location.reload();
					 }
					 );
		}
}
//设置推荐顺序

function f_reorder(igd,igd2)
{

	var ro = document.getElementById('rememberorder'+igd2).value;


		  sendx("/jsp/admin/edn_ajax.jsp?act=WestracMemberOrder&member="+encodeURIComponent(igd)+"&rememberorder="+ro,
					 function(data)
					 {
					   // alert(data.trim());
					   document.getElementById('rorderid').innerHTML='用户&nbsp;<font color=red>'+igd+'</font>&nbsp;顺序设置成功';
					   // window.location.reload();
					 }
					 );


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

 //会员参与的活动
 function f_myevent(igd)
 {


		var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:830px;dialogHeight:710px;';
		 var url = '/jsp/type/event/WestracAdminMyEvent.jsp?t='+new Date().getTime()+'&member='+encodeURIComponent(igd);
		 var rs = window.showModalDialog(url,self,y);
		 if(rs==1)
		 {
			 window.location.reload();
		 }
 }
 //会员提供的线索
 function f_myclue(igd)
 {

		var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:730px;dialogHeight:680px;';
		 var url = '/jsp/westrac/MyAdminWestracClue.jsp?t='+new Date().getTime()+'&member='+encodeURIComponent(igd);
		 var rs = window.showModalDialog(url,self,y);

 }
 function f_tj(igd)
 {
	 form1.remembertype.value=igd;
	 form1.submit();
 }
 //关联卡号
 function f_golfCar(igd)
 {
	var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:330px;dialogHeight:100px;';
	var url = '/jsp/user/GolfCardnumber.jsp?t='+new Date().getTime()+'&member='+encodeURIComponent(igd);
	var rs = window.showModalDialog(url,self,y);
 }

</script>

<h1>俱乐部高级会员管理</h1>


<form name="form1" action ="?" method="post">
<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>

<input type="hidden" name="nexturl">
<input type="hidden" name="membertype"/>
<input type="hidden" name="divid"/>

<input type="hidden" name="id" value="<%=request.getParameter("id") %>">

<input type="hidden" name="act">
<input type="hidden" name="memberlist_act" value="MemberList">
<input type="hidden" name="files" value="俱乐部高级会员列表"/>
<input type="hidden" name="sql" value="<%=MT.enc(sql.toString())%>">
<input type="hidden" name="remembertype" >




<input type="hidden" name="id" value="<%=request.getParameter("id") %>">

<h2>查询</h2>

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
		<td align="right">会员编号：<input type="text" name="code" value="<%=Entity.getNULL(code) %>"></td>

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

		<td align="right">活跃度：
				<select name="">
				<option value="">活跃度</option>

			</select>
		</td>
		<td align="right">工作地点：<script>mt.city("city0","city1",null,"<%=city0%>");</script></td>
		</tr>



		<tr>
	    <td colspan="10" align="center"><input type="submit" value="查询"/>&nbsp;<a href="/jsp/user/GolfAdvancedSearch.jsp">高级查询</a></td>
	    </tr>
	</tr>
 </table>



<h2>会员列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;位会员&nbsp;)&nbsp;
<a href="###" onclick="f_tj('1');">我的推荐会员</a>
<%if(remembertype==1){ %>
<a href="###" onclick="f_tj('');">返回</a>
<%} %>
</h2>
<%

if(fas)
{//有搜索

   out.print("<h2>您搜索的范围是：");
	//会员编号
	if(code!=null && code.length()>0)
	{
	  out.print("会员编号&nbsp;");
	  out.print("<span id = xlsize>"+code+"</span>&nbsp;");
	}
	//用户名
	if(memberid!=null && memberid.length()>0)
	{

	  out.print("用户名&nbsp;");
	  out.print("<span id = xlsize>"+memberid+"</span>&nbsp;");
	}

	//开始时间注册
	if(time_c!=null && time_c.length()>0)
	{
	  out.print("注册时间-开始&nbsp;");
	  out.print("<span id= xlsize>"+time_c+"</span>");
	}
	//开始时间注册
	if(time_d!=null && time_d.length()>0)
	{
	  out.print("注册时间-结束&nbsp;");
	  out.print("<span id= xlsize>"+time_d+"</span>");
	}

	//姓名
	if(membername!=null && membername.length()>0)
	{
	  out.print("姓名&nbsp;");
	  out.print("<span id = xlsize>"+membername+"</span>&nbsp;");
	}
	//性别
	if(sex>=0)
	{
	  out.print("性别&nbsp;");
	  if(sex==0)
	  {
		  out.print("<span id = xlsize>男</span>&nbsp;");
	  }else
	  {
		  out.print("<span id = xlsize>女</span>&nbsp;");
	  }

	}
	//身份证
	if(card!=null && card.length()>0)
	{
	  out.print("身份证&nbsp;");
	  out.print("<span id = xlsize>"+card+"</span>&nbsp;");
	}
	//手机
	if(mobile!=null && mobile.length()>0)
	{
	  out.print("手机&nbsp;");
	  out.print("<span id = xlsize>"+mobile+"</span>&nbsp;");
	}

	//生日时间
	if(birth!=null && birth.length()>0)
	{
	  out.print("生日-开始&nbsp;");
	  out.print("<span id= xlsize>"+birth+"</span>&nbsp;");
	}
	//生日时间
	if(birth2!=null && birth2.length()>0)
	{
	  out.print("生日-结束&nbsp;");
	  out.print("<span id= xlsize>"+birth2+"</span>&nbsp;");
	}
	//工作地点城市省

	if(city0!=null && city0.length()>0)
	{

		tea.entity.util.Card cobj = tea.entity.util.Card.find(Integer.parseInt(city0));

    	String cname = cobj.toStringCity1();
		 out.print("工作地点省&nbsp;");
		  out.print("<span id= xlsize>"+cname+"</span>&nbsp;");

	}
    //工作地点城市省
	if(city1!=null && city1.length()>0)
	{

		tea.entity.util.Card cobj = tea.entity.util.Card.find(Integer.parseInt(city1));

    	String cname = cobj.toStringCity2();
		 out.print("工作地点市&nbsp;");
		  out.print("<span id= xlsize>"+cname+"</span>&nbsp;");
	}
    //详细地址
    if(address!=null && address.length()>0)
	{
	  out.print("工作地点详细地址&nbsp;");
	  out.print("<span id= xlsize>"+address+"</span>&nbsp;");
	}

    //民族
    if(zzracky!=null && zzracky.length()>0)
	{
	  out.print("民族&nbsp;");
	  out.print("<span id= xlsize>"+zzracky+"</span>&nbsp;");
	}

 	 //固定电话
 	  if(telephone!=null && telephone.length()>0)
	  {
	  out.print("固定电话&nbsp;");
	   out.print("<span id= xlsize>"+telephone+"</span>&nbsp;");
	 }

 	 //家庭住址 省份
 	 if(zzhkszd0!=null && zzhkszd0.length()>0)
	{

		tea.entity.util.Card cobj = tea.entity.util.Card.find(Integer.parseInt(zzhkszd0));

    	String cname = cobj.toStringCity1();
		 out.print("家庭住址省&nbsp;");
		  out.print("<span id= xlsize>"+cname+"</span>&nbsp;");

	}
    //家庭住址 市
	if(zzhkszd1!=null && zzhkszd1.length()>0)
	{

		tea.entity.util.Card cobj = tea.entity.util.Card.find(Integer.parseInt(zzhkszd1));

    	String cname = cobj.toStringCity2();
		 out.print("家庭住址市&nbsp;");
		  out.print("<span id= xlsize>"+cname+"</span>&nbsp;");
	}
    //详细地址
    if(organization!=null && organization.length()>0)
	{
	  out.print("家庭住址详细地址&nbsp;");
	  out.print("<span id= xlsize>"+organization+"</span>&nbsp;");
	}
    //邮编
    if(zip!=null && zip.length()>0)
	{
	  out.print("邮编&nbsp;");
	  out.print("<span id= xlsize>"+zip+"</span>&nbsp;");
	}
  //电子邮箱
   if(email!=null && email.length()>0)
	{
	  out.print("电子邮箱&nbsp;");
	  out.print("<span id= xlsize>"+email+"</span>&nbsp;");
	}


   //QQ
   if(msn!=null && msn.length()>0)
	{
	  out.print("QQ&nbsp;");
	  out.print("<span id= xlsize>"+msn+"</span>&nbsp;");
	}


 //现操作机型  品牌
 if(xpinpai>0)
 {
 	out.print("现使用球具品牌&nbsp;");
 	  out.print("<span id= xlsize>"+WomenOptions.find(xpinpai).getWoname()+"</span>&nbsp;");
 }

 //型号
 if(xxinghao>0)
 {
 	out.print("现使用球具型号&nbsp;");
 	out.print("<span id= xlsize>"+WomenOptions.find(xxinghao).getWoname()+"</span>&nbsp;");
 }
 //其他
 if(xqita!=null && xqita.length()>0)
 {
 	out.print("现使用球具其他&nbsp;");
 	out.print("<span id= xlsize>"+xqita+"</span>&nbsp;");
 }



 //推荐人会员编号tjmember

   if(tjmember!=null && tjmember.length()>0)
	{
	  out.print("推荐人会员编号&nbsp;");
	  out.print("<span id= xlsize>"+tjmember+"</span>&nbsp;");
	}

   //private String memberheight;//身高
      if(memberheight!=null && memberheight.length()>0)
	{
	  out.print("身高&nbsp;");
	  out.print("<span id= xlsize>"+memberheight+"</span>&nbsp;");
	}

  // private String ballage;//打球年龄
     if(ballage!=null && ballage.length()>0)
	{
	  out.print("打球年龄&nbsp;");
	  out.print("<span id= xlsize>"+ballage+"</span>&nbsp;");
	}

  // private String almostscore;//差点or平均成绩
       if(almostscore!=null && almostscore.length()>0)
	{
	  out.print("差点or平均成绩&nbsp;");
	  out.print("<span id= xlsize>"+almostscore+"</span>&nbsp;");
	}
  // private String likeitems;//喜欢的;(木，球道，铁木，铁，推)
    if(likeitems!=null && likeitems.length()>0)
	{
	  out.print("差点or平均成绩&nbsp;");
	  out.print("<span id= xlsize>"+likeitems+"</span>&nbsp;");
	}

  // private String handfoot;//手尺
    if(handfoot!=null && handfoot.length()>0)
	{
	  out.print("手尺&nbsp;");
	  out.print("<span id= xlsize>"+likeitems+"</span>&nbsp;");
	}
 //  private String gdistance;//手碗到地面距离
   if(gdistance!=null && gdistance.length()>0)
	{
	  out.print("手碗到地面距离&nbsp;");
	  out.print("<span id= xlsize>"+gdistance+"</span>&nbsp;");
	}
 //  private String yhand;//用手 右手，左手
  if(yhand!=null && yhand.length()>0)
	{
	  out.print("用手&nbsp;");
	  out.print("<span id= xlsize>"+yhand+"</span>&nbsp;");
	}
  // private String swingrhythm;//挥杆节奏
   if(swingrhythm!=null && swingrhythm.length()>0)
	{
	  out.print("挥杆节奏&nbsp;");
	  out.print("<span id= xlsize>"+swingrhythm+"</span>&nbsp;");
	}


   //private String entername;//企业名称
   if(entername!=null && entername.length()>0)
	{
	  out.print("企业名称&nbsp;");
	  out.print("<span id= xlsize>"+entername+"</span>&nbsp;");
	}
   //private String enterpic;//企业logo或图片
   if(enterpic!=null && enterpic.length()>0)
	{
	  out.print("企业logo或图片&nbsp;");
	  out.print("<span id= xlsize>"+enterpic+"</span>&nbsp;");
	}
   //private String enterwebsite;//企业网站
   if(enterwebsite!=null && enterwebsite.length()>0)
	{
	  out.print("企业网站&nbsp;");
	  out.print("<span id= xlsize>"+enterwebsite+"</span>&nbsp;");
	}
   //private String entercontact;//联系方式
   if(swingrhythm!=null && swingrhythm.length()>0)
	{
	  out.print("企业联系方式&nbsp;");
	  out.print("<span id= xlsize>"+swingrhythm+"</span>&nbsp;");
	}
   //private String enteraddress;//地址
   if(enteraddress!=null && enteraddress.length()>0)
	{
	  out.print("企业地址&nbsp;");
	  out.print("<span id= xlsize>"+enteraddress+"</span>&nbsp;");
	}
   //private String enterproduct;//服务或产品
   if(enterproduct!=null && enterproduct.length()>0)
	{
	  out.print("企业或产品&nbsp;");
	  out.print("<span id= xlsize>"+enterproduct+"</span>&nbsp;");
	}
   //private String enterweibo;// 企业微博
   if(enterweibo!=null && enterweibo.length()>0)
	{
	  out.print("企业微博&nbsp;");
	  out.print("<span id= xlsize>"+enterweibo+"</span>&nbsp;");
	}
   //private String personalweibo;//个人微博
   if(personalweibo!=null && personalweibo.length()>0)
	{
	  out.print("个人微博&nbsp;");
	  out.print("<span id= xlsize>"+personalweibo+"</span>&nbsp;");
	}
   //private String entertext;//企业介绍
   if(entertext!=null && entertext.length()>0)
	{
	  out.print("企业介绍&nbsp;");
	  if(entertext!=null && entertext.length()>30)
	  {
		  out.print("<span id= xlsize>"+entertext.substring(0,30)+"....</span>&nbsp;");
	  }else
	  {
	  	out.print("<span id= xlsize>"+entertext+"</span>&nbsp;");
	  }
	}






	out.print("<input type=button value=返回   onclick=\"window.open('/jsp/user/GolfMember.jsp','_self');\" >");
out.print("</h2>");
}

%>



<h2 class="cnclass">

<div class="cnlistLeft">

<input type="button" value="批量删除" onClick="f_sub('delete','请选择您要删除的会员!');">&nbsp;
<input type="button" value="导出Excel" onClick="f_excel();">&nbsp;
<input type="button" value="导入会员" onClick="f_excelimp();">&nbsp;

<input type="button" value="发E-mail" onClick="f_email();">&nbsp;
<input type="button" value="发送站内信" onClick="f_mailbox();">&nbsp;
  <input type=button value="积分设置" onclick="f_jfall();">&nbsp;
<input type="button" value="发送短信" >&nbsp;
<input type="button" value="锁定会员" onclick="f_sub('locking','请选择要锁定的会员');">&nbsp;


</div>

 </h2>
   <span id="rorderid" ></span>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	   <tr id=tableonetr>
  			  <td width="1"><input type='checkbox' id="checkall" name="checkall" onclick='CheckAll()' title="全选" style="cursor:pointer"></td>
  			 <%if(remembertype==1){
  				 out.print("<td nowrap>显示顺序</td>");
  			 } %>
  			  <td nowrap>会员编号</td>
  			  <td nowrap>用户名</td>
  		       <td nowrap>姓名</td>
  		       <td nowrap>性别</td>
  			  <td nowrap>工作地点</td>
  			  <td nowrap>手机号</td>
  			  <td nowrap>注册时间</td>
  			    <td nowrap>积分</td>
  			 <td nowrap>活跃度</td>
  			 <%
  			 	if(card!=null && card.length()>0)
  			 	{
  			 		out.print("<td nowrap>身份证</td>");
  			 	}
  			   if((birth!=null && birth.length()>0) || (birth2!=null && birth2.length()>0))
			 	{
			 		out.print("<td nowrap>生日</td>");
			 	}
	  			if(address!=null && address.length()>0)
			 	{
			 		out.print("<td nowrap>工作地点详细地址</td>");
			 	}
	  			 if(zzracky!=null && zzracky.length()>0)
	  		 	{
	  		 		out.print("<td nowrap>民族</td>");
	  		 	}
	  			 if(telephone!=null && telephone.length()>0)
		  		 	{
		  		 		out.print("<td nowrap>固定电话</td>");
		  		 	}
	  			if((zzhkszd0!=null && zzhkszd0.length()>0) || (zzhkszd1!=null && zzhkszd1.length()>0) || (organization!=null && organization.length()>0))
	  		 	{
	  		 		out.print("<td nowrap>家庭住址</td>");
	  		 	}
	  		  if((zip!=null && zip.length()>0))
	  	 	{
	  	 		out.print("<td nowrap>邮编</td>");
	  	 	}
	  		  if((email!=null && email.length()>0))
		  	 	{
		  	 		out.print("<td nowrap>邮箱</td>");
		  	 	}
	  		  if((msn!=null && msn.length()>0))
	  	 	{
	  	 		out.print("<td nowrap>QQ</td>");
	  	 	}
	  		if(xpinpai>0)
	  		{
	  		  out.print("<td nowrap>现使用球具品牌</td>");

	  		}
	  		if(xxinghao>0)
		  		{
		  		  out.print("<td nowrap>现现使用球具型号</td>");

		  		}
	  		if(xqita!=null && xqita.length()>0)
	  		{
	  			out.print("<td nowrap>现使用球具其他</td>");
	  		}
	  		if((tjmember!=null && tjmember.length()>0))
	  	 	{
	  	 		out.print("<td nowrap>推荐人会员编号</td>");
	  	 	}





	  	 //   private String memberheight;//身高
	  	 if((memberheight!=null && memberheight.length()>0))
	  	 	{
	  	 		out.print("<td nowrap>身高</td>");
	  	 	}

	  	//    private String ballage;//打球年龄
	  		 if((ballage!=null && ballage.length()>0))
	  	 	{
	  	 		out.print("<td nowrap>打球年龄</td>");
	  	 	}
	  	//    private String almostscore;//差点or平均成绩
	  	 if((almostscore!=null && almostscore.length()>0))
	  	 	{
	  	 		out.print("<td nowrap>差点or平均成绩</td>");
	  	 	}
	  	//    private String likeitems;//喜欢的;(木，球道，铁木，铁，推)
	  	 if((likeitems!=null && likeitems.length()>0))
	  	 	{
	  	 		out.print("<td nowrap>喜欢的(木，球道，铁木，铁，推)</td>");
	  	 	}
	  	//    private String handfoot;//手尺
	  	 if((handfoot!=null && handfoot.length()>0))
	  	 	{
	  	 		out.print("<td nowrap>手尺</td>");
	  	 	}
	  	//    private String gdistance;//手碗到地面距离
	  	 if((gdistance!=null && gdistance.length()>0))
	  	 	{
	  	 		out.print("<td nowrap>手碗到地面距离</td>");
	  	 	}
	  	//    private String yhand;//用手 右手，左手
	  	 if((yhand!=null && yhand.length()>0))
	  	 	{
	  	 		out.print("<td nowrap>用手</td>");
	  	 	}
	  	//    private String swingrhythm;//挥杆节奏
	  	if((swingrhythm!=null && swingrhythm.length()>0))
	  	 	{
	  	 		out.print("<td nowrap>挥杆节奏</td>");
	  	 	}

	   // private String entername;//企业名称
	   if((entername!=null && entername.length()>0))
	  	 	{
	  	 		out.print("<td nowrap>企业名称</td>");
	  	 	}
	    //private String enterpic;//企业logo或图片
	    if((enterpic!=null && enterpic.length()>0))
	  	 	{
	  	 		out.print("<td nowrap>企业logo或图片</td>");
	  	 	}
	    //private String enterwebsite;//企业网站
	    if((enterwebsite!=null && enterwebsite.length()>0))
	  	 	{
	  	 		out.print("<td nowrap>企业网站</td>");
	  	 	}
	    ///private String entercontact;//联系方式
	    if((entercontact!=null && entercontact.length()>0))
	  	 	{
	  	 		out.print("<td nowrap>企业联系方式</td>");
	  	 	}
	    //private String enteraddress;//地址
	    if((enteraddress!=null && enteraddress.length()>0))
	  	 	{
	  	 		out.print("<td nowrap>企业地址</td>");
	  	 	}
	    //private String enterproduct;//服务或产品
	    if((enterproduct!=null && enterproduct.length()>0))
	  	 	{
	  	 		out.print("<td nowrap>企业服务或产品</td>");
	  	 	}
	    //private String enterweibo;// 企业微博
	    if((enterweibo!=null && enterweibo.length()>0))
	  	 	{
	  	 		out.print("<td nowrap>企业微博</td>");
	  	 	}
	    //private String personalweibo;//个人微博
	    if((personalweibo!=null && personalweibo.length()>0))
	  	 	{
	  	 		out.print("<td nowrap>个人微博</td>");
	  	 	}
	    //private String entertext;//企业介绍
	    if((entertext!=null && entertext.length()>0))
	  	 	{
	  	 		out.print("<td nowrap>企业介绍</td>");
	  	 	}


  			 %>



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
      <%if(remembertype==1){
  				 out.print("<td nowrap><input type=text size=3 name='rememberorder"+i+"' id='rememberorder"+i+"' value='"+pobj.getRememberorder()+"' onkeyup=\"f_reorder('"+member+"','"+i+"');\"></td>");
  			 } %>
    <td><a href="/jsp/user/EditGolfMember.jsp?member=<%=member%>&nexturl=<%=nexturl %>"><%=pobj.getCode()%></a>
    <% if(pobj.isLocking())out.print(" <font color='#FF0000'>[锁定]</font>"); %>
    <%if(pobj.getRemembertype()==1){out.print("<font color='#FF0000'>[推荐会员]</font>");}%>
    </td>
      <td><a href="/jsp/user/EditGolfMember.jsp?member=<%=member%>&nexturl=<%=nexturl %>"><%=member%></a></td>
       <td><a href="/jsp/user/EditGolfMember.jsp?member=<%=member%>&nexturl=<%=nexturl %>"><%=pobj.getFirstName(teasession._nLanguage)%></a></td>
        <td><%if(pobj.isSex()){out.print("女");}else {out.print("男");} %></td>

      <td nowrap><%=cname %></td>
      <td nowrap><%=pobj.getMobile() %></td>

      <td nowrap><%if(pobj.getTime()!=null)out.print(Entity.sdf2.format(pobj.getTime()));%></td>
      <td nowrap><%=pobj.getMyintegral() %></td>
     <td nowrap></td>

     <%
     if(card!=null && card.length()>0)
	 	{
	 		out.print("<td nowrap>"+pobj.getCard()+"</td>");
	 	}
     if((birth!=null && birth.length()>0) || (birth2!=null && birth2.length()>0))
	 	{
	 		out.print("<td nowrap>"+pobj.getBirthToString()+"</td>");
	 	}
     if(address!=null && address.length()>0)
	 	{
	 		out.print("<td nowrap>"+pobj.getAddress(teasession._nLanguage)+"</td>");
	 	}
     if(zzracky!=null && zzracky.length()>0)
	 	{
	 		out.print("<td nowrap>"+pobj.getZzracky()+"</td>");
	 	}
      if(telephone!=null && telephone.length()>0)
	 	{
	 		out.print("<td nowrap>"+pobj.getTelephone(teasession._nLanguage)+"</td>");
	 	}
      if((zzhkszd0!=null && zzhkszd0.length()>0) || (zzhkszd1!=null && zzhkszd1.length()>0) || (organization!=null && organization.length()>0))
	 	{

    	  tea.entity.util.Card cobj2 = tea.entity.util.Card.find(Integer.parseInt(pobj.getZzhkszd(teasession._nLanguage)));

	    	String cname2 = cobj2.toString2();
	    	String or = "";
	    	if(pobj.getOrganization(teasession._nLanguage)!=null)
	    	{
	    		or=pobj.getOrganization(teasession._nLanguage);
	    	}


	 		out.print("<td nowrap>"+cname2+or+"</td>");
	 	}
      if((zip!=null && zip.length()>0))
	 	{
	 		out.print("<td nowrap>"+pobj.getZip(teasession._nLanguage)+"</td>");
	 	}

      if((email!=null && email.length()>0))
	 	{
	 		out.print("<td nowrap>"+pobj.getEmail()+"</td>");
	 	}

      if((msn!=null && msn.length()>0))
	 	{
	 		out.print("<td nowrap>"+pobj.getMsnID()+"</td>");
	 	}


		if(xpinpai>0)
		{
		  out.print("<td nowrap>"+WomenOptions.find(pobj.getXpinpai()).getWoname()+"</td>");

		}
		if(xxinghao>0)
	  		{
	  		  out.print("<td nowrap>"+WomenOptions.find(pobj.getXxinghao()).getWoname()+"</td>");

	  		}
		if(xqita!=null && xqita.length()>0)
		{
			out.print("<td nowrap>"+pobj.getXqita()+"</td>");
		}
      if((tjmember!=null && tjmember.length()>0))
	 	{
	 		out.print("<td nowrap>"+pobj.getTjmember()+"</td>");
	 	}


   //   private String memberheight;//身高
    if((memberheight!=null && memberheight.length()>0))
	 	{
	 		out.print("<td nowrap>"+pobj.getMemberheight()+"</td>");
	 	}
   //   private String ballage;//打球年龄
     if((ballage!=null && ballage.length()>0))
	 	{
	 		out.print("<td nowrap>"+pobj.getBallage()+"</td>");
	 	}
   //   private String almostscore;//差点or平均成绩
    if((almostscore!=null && almostscore.length()>0))
	 	{
	 		out.print("<td nowrap>"+pobj.getAlmostscore()+"</td>");
	 	}
  //    private String likeitems;//喜欢的;(木，球道，铁木，铁，推)
   if((likeitems!=null && likeitems.length()>0))
	 	{
	 		out.print("<td nowrap>"+pobj.getLikeitems()+"</td>");
	 	}
   //   private String handfoot;//手尺
    if((handfoot!=null && handfoot.length()>0))
	 	{
	 		out.print("<td nowrap>"+pobj.getHandfoot()+"</td>");
	 	}

   //   private String gdistance;//手碗到地面距离
     if((gdistance!=null && gdistance.length()>0))
	 	{
	 		out.print("<td nowrap>"+pobj.getGdistance()+"</td>");
	 	}
   //   private String yhand;//用手 右手，左手
   if((yhand!=null && yhand.length()>0))
	 	{
	 		out.print("<td nowrap>"+pobj.getYhand()+"</td>");
	 	}
   //   private String swingrhythm;//挥杆节奏
   		 if((swingrhythm!=null && swingrhythm.length()>0))
	 	{
	 		out.print("<td nowrap>"+pobj.getSwingrhythm()+"</td>");
	 	}


   	    //private String entername;//企业名称
   	     if((entername!=null && entername.length()>0))
	 	{
	 		out.print("<td nowrap>"+pobj.getEntername()+"</td>");
	 	}
   	    //private String enterpic;//企业logo或图片
   	     if((enterpic!=null && enterpic.length()>0))
	 	{
	 		out.print("<td nowrap>"+pobj.getEnterpic()+"</td>");
	 	}
   	    //private String enterwebsite;//企业网站
   	     if((enterwebsite!=null && enterwebsite.length()>0))
	 	{
	 		out.print("<td nowrap>"+pobj.getEnterwebsite()+"</td>");
	 	}
   	    //private String entercontact;//联系方式
   	     if((entercontact!=null && entercontact.length()>0))
	 	{
	 		out.print("<td nowrap>"+pobj.getEntercontact()+"</td>");
	 	}
   	    //private String enteraddress;//地址
   	     if((enteraddress!=null && enteraddress.length()>0))
	 	{
	 		out.print("<td nowrap>"+pobj.getEnteraddress()+"</td>");
	 	}
   	    //private String enterproduct;//服务或产品
   	     if((enterproduct!=null && enterproduct.length()>0))
	 	{
	 		out.print("<td nowrap>"+pobj.getEnterproduct()+"</td>");
	 	}
   	    ///private String enterweibo;// 企业微博
   	     if((enterweibo!=null && enterweibo.length()>0))
	 	{
	 		out.print("<td nowrap>"+pobj.getEnterweibo()+"</td>");
	 	}
   	    //private String personalweibo;//个人微博
   	     if((personalweibo!=null && personalweibo.length()>0))
	 	{
	 		out.print("<td nowrap>"+pobj.getPersonalweibo()+"</td>");
	 	}
   	    //private String entertext;//企业介绍
   	     if((entertext!=null && entertext.length()>0))
	 	{
	 		out.print("<td nowrap>"+pobj.getEntertext()+"</td>");
	 	}


     %>


	    <td nowrap> <a href="###" onclick="f_cz('<%=member%>');" >操作</a></td>

    </tr>

    <tr id="trid<%=member %>" style="display:none">
  	<td align="right" colspan="20">


  		<a href="###"  onclick="window.open('/jsp/user/EditGolfMember.jsp?member=<%=URLEncoder.encode(member,"UTF-8")%>&nexturl=<%=nexturl%>','_self');">编辑</a>&nbsp;
  		<a href="###"  onclick="f_golfCar('<%=member%>');",'_self');">关联卡号</a>&nbsp;

  		<a href="###" onclick="f_tjmember('<%=member%>');"><%if(pobj.getRemembertype()==0){out.print("推荐到会员风采");}else{out.print("取消会员风采显示");} %></a>
  		<a href="###" onclick="f_myevent('<%=member%>');">参与活动</a>
  		<a href="###" onclick="f_myclue('<%=member%>');">提供线索</a>
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

