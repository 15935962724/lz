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
String verifytype="";
if(teasession.getParameter("verifytype")!=null){
	verifytype=teasession.getParameter("verifytype");
	StringBuffer sb2=new StringBuffer();
	if(verifytype.trim().length()>0){
		String[] verifytypes= verifytype.split(";");
		for(int i=0;i<verifytypes.length;i++){
			String v=verifytypes[i];
			if(!v.trim().equals("")){
				if(sb2.length()>0){
					sb2.append("|| verifytype = "+v+" ");
				}else{
					sb2.append(" and (verifytype = "+v+" ");
				}
			}
		}
		if(sb2.length()>0){
			sql.append(sb2.toString()+") ");
			param.append("&verifytype=").append(URLEncoder.encode(verifytype,"UTF-8"));
			fas=true;
		}
	}
}
//销售员姓名
String belsell = teasession.getParameter("belsell");
if(belsell!=null && belsell.length()>0)
{
	belsell = belsell.trim();
	sql.append(" and belsell like "+DbAdapter.cite("%"+belsell+"%")+"  ");
	param.append("&belsell=").append(URLEncoder.encode(belsell,"UTF-8"));
	fas = true;
}
//销售员联系电话
String tjmobile = teasession.getParameter("tjmobile");
if(tjmobile!=null && tjmobile.length()>0)
{
	tjmobile = tjmobile.trim();
	sql.append(" and tjmobile like "+DbAdapter.cite("%"+tjmobile+"%")+"  ");
	param.append("&tjmobile=").append(URLEncoder.encode(tjmobile,"UTF-8"));
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

//活跃度
int actives = -1;
if(teasession.getParameter("actives")!=null && teasession.getParameter("actives").length()>0)
{
	actives = Integer.parseInt(teasession.getParameter("actives"));
}
if(actives>0)
{
	sql.append(" and p.actives= "+actives+"  ");
	param.append("&actives=").append(actives);
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
String city0="";
String city1="";
String address="";
String txtcityvals="";
	if(teasession.getParameter("cityvals")!=null&&(!teasession.getParameter("cityvals").equals(""))){
	String cityval=teasession.getParameter("cityvals");
	txtcityvals=teasession.getParameter("txtcityvals");
	String[] cityvals=cityval.split(";");
	StringBuffer sqls1=new StringBuffer();
	StringBuffer sqlsn=new StringBuffer();
	for(int i=0;i<cityvals.length;i++){
		boolean  thi=false;
		String[] cits=cityvals[i].split("-");
		for(int j=0;j<cits.length;j++){
		 if(!cits[j].trim().equals("")){
			if(j==0 || j==1){
				String scity="";
				if(j==0){
				if(!cits[1].trim().equals("")){
					scity=DbAdapter.cite(cits[1]+"%");

				}else{

					scity=DbAdapter.cite(cits[0]+"%");
				}
				if(sqlsn!=null&(!sqlsn.toString().trim().equals(""))){
						sqls1.append(" or ");
					}else{
						sqls1.append(" and ");
					}
					sqls1.append(" exists (select member from ProfileLayer pl where pl.member=p.member AND ( pl.province like "+scity);
				}else{
					continue;
				}
			}else if(j==2){
				if(sqls1.length()>0){
					if(sqls1.toString().endsWith("%'")){
						sqls1.append(") ");
						thi=true;
					}
					sqls1.append("  and pl.address like "+DbAdapter.cite("%"+cits[j]+"%")+") ");
				}else{
					if(sqlsn!=null&(!sqlsn.toString().trim().equals(""))){
						sqls1.append(" or ");
					}else{
						sqls1.append(" and ");
					}
					sqls1.append(" exists (select member from ProfileLayer pl where pl.member=p.member AND ( pl.address like "+DbAdapter.cite("%"+cits[j]+"%"));
				}
			}
		 }

		}
		if(sqls1!=null&&(!sqls1.equals(""))){
			if(sqls1.toString().endsWith("%'")){
				if(!thi){
				sqls1.append(") )");
				}
			}
			sqlsn.append(sqls1);
			sqls1=new StringBuffer();
		}
	}
	if(sqlsn!=null&&(!sqlsn.equals(""))){
		sql.append(sqlsn.toString());
	}

	param.append("&cityvals=").append(cityval);
	param.append("&txtcityvals=").append(URLEncoder.encode(txtcityvals,"UTF-8"));
		fas = true;
    }else{
	//工作地点城市
	 city0 = teasession.getParameter("city0");
	if(city0!=null && city0.length()>0)
	{
			//province
		sql.append(" and exists (select member from ProfileLayer pl where pl.member=p.member AND pl.province like "+DbAdapter.cite(city0+"%")+"  )");
		param.append("&city0=").append(city0);
		fas = true;

	}

	 city1 = teasession.getParameter("city1");
	if(city1!=null && city1.length()>0)
	{
			//province
		sql.append(" and exists (select member from ProfileLayer pl where pl.member=p.member AND pl.province like "+DbAdapter.cite(city1+"%")+"  )");
		param.append("&city1=").append(city1);
		city0 = city1;
		fas = true;

	}

	//详细地址
	 address = teasession.getParameter("address");
	if(address!=null && address.length()>0)
	{
		address = address.trim();
		sql.append(" and exists (select member from ProfileLayer pl where pl.member=p.member AND pl.address like "+DbAdapter.cite("%"+address+"%")+"  )");
		param.append("&address=").append(URLEncoder.encode(address,"UTF-8"));
		fas = true;
	}
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

//学历
String degree = teasession.getParameter("degree");

if(degree!=null && degree.length()>0)
{
	degree = degree.trim();

	if(Integer.parseInt(degree)>0){

		sql.append(" and exists (select member from ProfileLayer pl where pl.member=p.member AND pl.degree= "+DbAdapter.cite(degree)+"  )");
		param.append("&degree=").append(URLEncoder.encode(degree,"UTF-8"));
	}
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
//推荐人会员编号tjmember
String tjmember = teasession.getParameter("tjmember");
if(tjmember!=null && tjmember.length()>0)
{
	tjmember = tjmember.trim();
	sql.append(" and tjmember like "+DbAdapter.cite("%"+tjmember+"%")+" ");
	param.append("&tjmember=").append(tjmember);
	fas = true;
}

//是否有上岗证-
String sfshanggang = teasession.getParameter("sfshanggang");
if(sfshanggang!=null && sfshanggang.length()>0)
{

	sql.append(" and sfshanggang = "+DbAdapter.cite(sfshanggang)+" ");
	param.append("&sfshanggang=").append(sfshanggang);
	fas = true;
}
//fazhengjiguan  发证机关
String fazhengjiguan = teasession.getParameter("fazhengjiguan");
if(fazhengjiguan!=null && fazhengjiguan.length()>0)
{

	sql.append(" and fazhengjiguan = "+DbAdapter.cite(fazhengjiguan)+" ");
	param.append("&fazhengjiguan=").append(URLEncoder.encode(fazhengjiguan,"UTF-8"));
	fas = true;
}
//操作年限

String caozuonianxian = teasession.getParameter("caozuonianxian");
if(caozuonianxian!=null && caozuonianxian.length()>0)
{

	sql.append(" and caozuonianxian = "+DbAdapter.cite(caozuonianxian)+" ");
	param.append("&caozuonianxian=").append(caozuonianxian);
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

//曾操作机型
int cpinpai = 0;
if(teasession.getParameter("cpinpai")!=null && teasession.getParameter("cpinpai").length()>0)
{
	cpinpai = Integer.parseInt(teasession.getParameter("cpinpai"));
}

if(cpinpai>0)
{
	sql.append(" and cpinpai  = ").append(cpinpai);
	param.append("&cpinpai=").append(cpinpai);
	fas = true;

}
//型号
int cxinghao = 0;
if(teasession.getParameter("cxinghao")!=null && teasession.getParameter("cxinghao").length()>0)
{
	cxinghao = Integer.parseInt(teasession.getParameter("cxinghao"));
}

if(cxinghao>0)
{
	sql.append(" and cxinghao  = ").append(cxinghao);
	param.append("&cxinghao=").append(cxinghao);
	fas = true;
}
//其他
String cqita = teasession.getParameter("cqita");
if(cqita!=null && cqita.length()>0)
{

	sql.append(" and cqita like  "+DbAdapter.cite("%"+cqita+"%")+" ");
	param.append("&cqita=").append(URLEncoder.encode(cqita,"UTF-8"));
	fas = true;
}

//机主相关
//姓名
String jzname = teasession.getParameter("jzname");
if(jzname!=null && jzname.length()>0)
{
	jzname= jzname.trim();
	sql.append(" and jzname like  "+DbAdapter.cite("%"+jzname+"%")+" ");
	param.append("&jzname=").append(URLEncoder.encode(jzname,"UTF-8"));
	fas = true;
}
//型号
String jzxinghao = teasession.getParameter("jzxinghao");
if(jzxinghao!=null && jzxinghao.length()>0)
{
	jzxinghao= jzxinghao.trim();
	sql.append(" and jzxinghao like  "+DbAdapter.cite("%"+jzxinghao+"%")+" ");
	param.append("&jzxinghao=").append(URLEncoder.encode(jzxinghao,"UTF-8"));
	fas = true;
}
//序列号
String jzxuliehao = teasession.getParameter("jzxuliehao");
if(jzxuliehao!=null && jzxuliehao.length()>0)
{
	jzxuliehao= jzxuliehao.trim();
	sql.append(" and jzxuliehao like  "+DbAdapter.cite("%"+jzxuliehao+"%")+" ");
	param.append("&jzxuliehao=").append(URLEncoder.encode(jzxuliehao,"UTF-8"));
	fas = true;
}
//联系方式
String jzlianxi = teasession.getParameter("jzlianxi");
if(jzlianxi!=null && jzlianxi.length()>0)
{
	jzlianxi= jzlianxi.trim();
	sql.append(" and jzlianxi like  "+DbAdapter.cite("%"+jzlianxi+"%")+" ");
	param.append("&jzlianxi=").append(URLEncoder.encode(jzlianxi,"UTF-8"));
	fas = true;
}
//爱好
String aihao = teasession.getParameter("aihao");
if(aihao!=null && aihao.length()>0)
{
	aihao= aihao.trim();
	sql.append(" and aihao like  "+DbAdapter.cite("%"+aihao+"%")+" ");
	param.append("&aihao=").append(URLEncoder.encode(aihao,"UTF-8"));
	fas = true;
}

String[] IMP_TYPE={"注册会员","导入会员","同步会员"};
int source=0;
String tmp = teasession.getParameter("source");
if(tmp!=null)
{
  source=Integer.parseInt(tmp);
  if(source>0)
  {
    sql.append(" AND source="+source);
    param.append("&source=").append(source);
  }
}
int imptype=-1;
tmp = teasession.getParameter("imptype");
if(tmp!=null)
{
  imptype=Integer.parseInt(tmp);
  if(imptype!=-1)
  {
    sql.append(" AND(imptype="+imptype);
    if(imptype==0)sql.append(" OR imptype IS NULL");
    sql.append(")");
    param.append("&imptype=").append(imptype);
  }
}







int pos=0,pageSize=10;
tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

sql.append(" and ( nomanager is null or nomanager =0) ");

int count=Profile.count(sql.toString());
sql.append(" order by time desc ");




%><html>
<head>
<title>履友管理</title>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
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
				form1.act.value='WestracMember';
				form1.submit();
			}
	   }

//导入会员
function f_excelimp()
{
	var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:930px;dialogHeight:650px;';
	 var url = '/jsp/westrac/WestracMemberImports.jsp?t='+new Date().getTime()+"&community="+form1.community.value;
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
//发送站内信
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
function f_pg()
{
  mt.show(null,0);
  mt.post("/Members.do?act=actives");

//  ymPrompt.win({message:'<br><center>活跃度正在评估,请稍候...</center>',title:'',width:'300',height:'50',titleBar:false});
//  sendx("/jsp/admin/edn_ajax.jsp?act=WestracMemberPG",
//  function(data)
//  {
//    if(data!='')
//    {
//      alert(data.trim());
//    }
//    window.location.reload();
//  }
//  );
}
 function gettype(){
 	var types=document.getElementsByName("verifytypes");
 	var verifytype="";
 	for(var i=0;i<types.length;i++){
 		if(types[i].checked==true){
 			verifytype=verifytype+types[i].value+";";
 		}
 	}
 	document.form1.verifytype.value=verifytype;
 	document.form1.submit();
 }
</script>

<h1>履友管理</h1>


<form name="form1" action ="?" method="post">
<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>

<input type="hidden" name="nexturl">
<input type="hidden" name="membertype"/>
<input type="hidden" name="divid"/>
<input type="hidden" name="verifytype"/>
<input type="hidden" name="id" value="<%=request.getParameter("id") %>">

<input type="hidden" name="act">
<input type="hidden" name="memberlist_act" value="MemberList">
<input type="hidden" name="files" value="履友列表"/>
<input type="hidden" name="sql" value="<%=MT.enc(sql.toString())%>">
<input type="hidden" name="remembertype" >
<input type="hidden" name="fverifytypes">



<input type="hidden" name="id" value="<%=request.getParameter("id") %>">

<h2>查询</h2>

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
		<td align="right">会员编号：<input type="text" name="code" value="<%=Entity.getNULL(code) %>"></td>

		<td align="right">姓名：<input type="text" name="membername" value="<%=Entity.getNULL(membername) %>"></td>
		<td align="right">注册时间：从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null){out.println(time_c);} %>"  style="cursor:pointer" readonly onClick="new Calendar().show('form1.time_c');">
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null){out.println(time_d);} %>"  style="cursor:pointer" readonly onClick="new Calendar().show('form1.time_d');" >
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
				<select name="actives">
				<option value="-1">活跃度</option>
				<%
					for(int i =1;i<Profile.ACTIVES_TYPE.length;i++)
					{
						out.print("<option value="+i);
						if(actives==i)
						{
							out.print(" selected ");
						}
						out.print(">"+Profile.ACTIVES_TYPE[i]);
						out.print("</option>");
					}
				%>

			</select>
		</td>
		<td align="right">工作地点：<script>mt.city("city0","city1",null,"<%=city0%>");</script></td>
		</tr>
  <tr><td align="right">
  从何得知:
  <select name="source">
  <option value="0">--------------</option>
  <%
  for(int i=1;i<Profile.SOURCE_TYPE.length;i++)
  {
    out.print("<option value="+i);
    if(source==i)out.print(" selected");
    out.print(">"+Profile.SOURCE_TYPE[i]);
  }
  %>
  </select>
  <td align="right">
  来源:
  <select name="imptype">
  <option value="-1">--------------</option>
  <%
  for(int i=0;i<IMP_TYPE.length;i++)
  {
    out.print("<option value="+i);
    if(imptype==i)out.print(" selected");
    out.print(">"+IMP_TYPE[i]);
  }
  %>
  </select>
  </td>
  <td align="right">用户名：<input type="text" name=memberid value="<%=Entity.getNULL(memberid) %>"></td>



  </tr>
   <tr><td align="right">核实后身份：
   	<%for(int i=0;i<Profile.VERIFY_TYPE.length;i++){
   		int n=verifytype.indexOf(i+";");
   		String s=(verifytype!=null&&verifytype.trim().length()>0&&verifytype.indexOf(i+";")>-1)?"checked":" ";
   		if(i==0){
   			continue;
   		}
   		out.print("<input type=checkbox name='verifytypes' value="+i+" "+s+"/>"+Profile.VERIFY_TYPE[i]+"&nbsp;");
   	}
   	 %>
 </td>

   	<td align="right">销售员姓名：<input type="text" name=belsell value="<%=Entity.getNULL(belsell) %>"></td>
   <td align="right">销售员手机号：<input type="text" name=tjmobile value="<%=Entity.getNULL(tjmobile) %>"></td>

  </tr>

		<tr>
	    <td colspan="10" align="center"><input type="submit" value="查询" onClick="gettype();"/>&nbsp;<a href="/jsp/westrac/WestracAdvancedSearch.jsp">高级查询</a></td>
	    </tr>

 </table>



<h2>会员列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;位会员&nbsp;)&nbsp;
<a href="###" onClick="f_tj('1');">履友之星推荐</a>&nbsp;
<a href="###" onClick="f_pg();">评估活跃度</a>&nbsp;
<%if(remembertype==1){ %>
<a href="###" onClick="f_tj('');">返回</a>
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
	//活跃度
	if(actives>0)
	{
		  out.print("活跃度&nbsp;");

			  out.print("<span id = xlsize>"+Profile.ACTIVES_TYPE[actives]+"</span>&nbsp;");


	}
	//核实后身份
	if(verifytype!=null && verifytype.length()>0)
	{
	  out.print("核实后身份&nbsp;");
	  String[] ver=verifytype.split(";");
	  StringBuffer sb3=new StringBuffer();
	  sb3.append("<span id = xlsize>");
	  for(int i=0;i<ver.length;i++){
	  	if(ver[i]!=null&&(!ver[i].trim().equals(""))){
	  		sb3.append(Profile.VERIFY_TYPE[Integer.parseInt(ver[i])]+" ");
	  	}
	  }
	  out.print(sb3.append("</span>&nbsp;").toString());
	}
	//销售员姓名
	if(belsell!=null && belsell.length()>0)
	{
	  out.print("销售员姓名&nbsp;");
	  out.print("<span id = xlsize>"+belsell+"</span>&nbsp;");
	}
	//销售员手机号
	if(tjmobile!=null && tjmobile.length()>0)
	{
	  out.print("销售员手机号&nbsp;");
	  out.print("<span id = xlsize>"+tjmobile+"</span>&nbsp;");
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
	//多值查询
	if(txtcityvals!=null&&txtcityvals.length()>0){
		 out.print("工作地点:&nbsp;");
		  out.print("<span id= 'txtcit'></span><script>document.getElementById('txtcit').innerHTML='"+txtcityvals+"'</script>&nbsp;");
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
    //学历
    if(degree!=null && degree.length()>0)
	{
	  out.print("学历&nbsp;");
	  out.print("<span id= xlsize>"+Profile.DEGREE_TYPE[Integer.parseInt(degree)]+"</span>&nbsp;");
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
 //推荐人会员编号tjmember

   if(tjmember!=null && tjmember.length()>0)
	{
	  out.print("推荐人会员编号&nbsp;");
	  out.print("<span id= xlsize>"+tjmember+"</span>&nbsp;");
	}
 //是否有上岗证-
 if(sfshanggang!=null && sfshanggang.length()>0)
	{

	  out.print("是否有上岗证&nbsp;");
	  if("0".equals(sfshanggang))
	  {
		  out.print("<span id= xlsize>是</span>&nbsp;");
	  }else
	  {
		  out.print("<span id= xlsize>否</span>&nbsp;");
	  }

	}
//fazhengjiguan  发证机关
 if(fazhengjiguan!=null && fazhengjiguan.length()>0)
	{
	  out.print("发证机关&nbsp;");
	  out.print("<span id= xlsize>"+fazhengjiguan+"</span>&nbsp;");
	}

//操作年限
 if(caozuonianxian!=null && caozuonianxian.length()>0)
	{
	  out.print("操作年限&nbsp;");
	  out.print("<span id= xlsize>"+caozuonianxian+"</span>&nbsp;");
	}

//现操作机型  品牌
if(xpinpai>0)
{
	out.print("现操作机型品牌&nbsp;");
	  out.print("<span id= xlsize>"+WomenOptions.find(xpinpai,teasession._nLanguage).getWoname()+"</span>&nbsp;");
}

//型号
if(xxinghao>0)
{
	out.print("现操作机型型号&nbsp;");
	out.print("<span id= xlsize>"+WomenOptions.find(xxinghao,teasession._nLanguage).getWoname()+"</span>&nbsp;");
}
//其他
if(xqita!=null && xqita.length()>0)
{
	out.print("现操作机型其他&nbsp;");
	out.print("<span id= xlsize>"+xqita+"</span>&nbsp;");
}

//曾操作机型
 if(cpinpai>0)
{
	out.print("曾操作机型品牌&nbsp;");
	  out.print("<span id= xlsize>"+WomenOptions.find(cpinpai,teasession._nLanguage).getWoname()+"</span>&nbsp;");
}

//型号
if(cxinghao>0)
{
	out.print("曾操作机型型号&nbsp;");
	out.print("<span id= xlsize>"+WomenOptions.find(cxinghao,teasession._nLanguage).getWoname()+"</span>&nbsp;");
}
//其他
if(cqita!=null && cqita.length()>0)
{
	out.print("曾操作机型其他&nbsp;");
	out.print("<span id= xlsize>"+cqita+"</span>&nbsp;");
}
//机主相关
//姓名

if(jzname!=null && jzname.length()>0)
{
	out.print("机主相关姓名&nbsp;");
	out.print("<span id= xlsize>"+jzname+"</span>&nbsp;");
}

//型号
if(jzxinghao!=null && jzxinghao.length()>0)
{
	out.print("机主相关型号&nbsp;");
	out.print("<span id= xlsize>"+jzxinghao+"</span>&nbsp;");
}
//序列号
if(jzxuliehao!=null && jzxuliehao.length()>0)
{
	out.print("机主相关序列号&nbsp;");
	out.print("<span id= xlsize>"+jzxuliehao+"</span>&nbsp;");
}
//联系方式
if(jzlianxi!=null && jzlianxi.length()>0)
{
	out.print("机主相关联系方式&nbsp;");
	out.print("<span id= xlsize>"+jzlianxi+"</span>&nbsp;");
}
//爱好
if(aihao!=null && aihao.length()>0)
{
	out.print("爱好&nbsp;");
	out.print("<span id= xlsize>"+aihao+"</span>&nbsp;");
}


	out.print("<input type=button value=返回   onclick=\"window.open('/jsp/westrac/WestracMember.jsp','_self');\" >");
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
  <input type=button value="积分设置" onClick="f_jfall();">&nbsp;
<input type="button" value="发送短信" onClick="f_message();">&nbsp;
<input type="button" value="锁定会员" onClick="f_sub('locking','请选择要锁定的会员');">&nbsp;
<input type="button" value="核实身份" onClick="f_verifytypes();">&nbsp;
<input type="hidden" name="verifytypeinfo" value="">
<input type="hidden" name="verifytypeinfo2" value="">
<script type="text/javascript">

 function f_verifytypes(){
 	var fname=document.getElementsByName("memberorder");
    var lname="";

    for(var i=0; i<fname.length; i++)
    {
    	if( fname[i].checked==true){
       	   lname = lname + fname[i].value+";";
       }
     }
     var con='<span id="showid"></span><input type="hidden" id="memberts" value="'+lname+'"/><br/><br/><input type="radio" name="verifytype" value="1"/>机主&nbsp;'+
  		'<input type="radio" name="verifytype" value="2"/>机手&nbsp;'+'<input type="radio" name="verifytype" value="3"/>设备管理人员&nbsp;'+
  		'<input type="radio" name="verifytype" value="4"/>技术管理人员&nbsp;'+'<input type="radio" name="verifytype" value="5" checked/>与行业相关&nbsp;'+
  		'<input type="radio" name="verifytype" value="6"/>无效&nbsp;';
 	ymPrompt.confirmInfo({icoCls:'',msgCls:'confirm',message:con,titile:'请选择审核后身份类型',height:150,handler:verifymembertypes,autoClose:false});
 }

  	function verifymembertypes(tp){
  		if(tp!='ok')return ymPrompt.close();
  		var ck=9;
  		var types=document.getElementsByName("verifytype");
  		for(var i=0;i<types.length;i++){
  			if(types[i].checked){
  				ck=types[i].value;
  			}
  		}
  		document.getElementById("showid").innerHTML='<font color=red>信息提交中，请稍等。。。</font>';
  		var memt=document.getElementById("memberts").value;
  		sendx("/jsp/admin/edn_ajax.jsp?act=WmemberVerifytypes&type="+ck+"&memberid="+encodeURIComponent(memt),
  			function(data){
  				data=data.trim();
  				if(data=='true'){
  					ymPrompt.close();
				      // ymPrompt.win({message:'<br><center>审核通过</center>',width:200,height:100,handler:noTitlebar,btn:[['关闭']],titleBar:false});

  					ymPrompt.win({message:'<br/><center>核实身份成功</center>',width:200,height:100,btn:[['关闭']],titileBar:false});
  				}else if(data=='false'){
  					ymPrompt.close();
  					ymPrompt.win({message:'<br/><center>核实身份失败</center>',width:200,height:100,btn:[['关闭']],titileBar:false});
  				}else{

  					ymPrompt.close();
  				}
  			}
  		)

  		/*document.form1.action='/servlet/EditMember';
  		document.form1.act.value='WmemberVerifytypes';
  		document.form1.verifytypeinfo.value=memt;
  		document.form1.verifytypeinfo2.value=ck;
		form1.nexturl.value=location.pathname+location.search;
		form1.target="_ajax" ;
		form1.submit();*/
  	}

</script>

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
  			 <td nowrap>履友推荐</td>
  			 <td nowrap>来源</td>
  			  <td nowrap>类型</td>

  			 <%
  			 	//审核后身份
				if(verifytype!=null && verifytype.length()>0)
				{
				  out.print("<td nowrap>审核后身份</td>");
				}
  			 	//销售员姓名
				if(belsell!=null && belsell.length()>0)
				{
				  out.print("<td nowrap>销售员姓名</td>");
				}
				//销售员联系电话
				if(tjmobile!=null && tjmobile.length()>0)
				{
				  out.print("<td nowrap>销售员手机号</td>");
				}
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
	  			 if(degree!=null && degree.length()>0)
		  		 	{
		  		 		out.print("<td nowrap>学历</td>");
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
	  		if((tjmember!=null && tjmember.length()>0))
	  	 	{
	  	 		out.print("<td nowrap>推荐人会员编号</td>");
	  	 	}
	  		if((sfshanggang!=null && sfshanggang.length()>0))
		 	{
	    		  out.print("<td nowrap>是否有上岗证</td>");

		 	}
	  		if((fazhengjiguan!=null && fazhengjiguan.length()>0))
		 	{
	    		  out.print("<td nowrap>发证机关</td>");

		 	}
	  		if((caozuonianxian!=null && caozuonianxian.length()>0))
		 	{
	    		  out.print("<td nowrap>操作年限</td>");

		 	}
	  		if(xpinpai>0)
	  		{
	  		  out.print("<td nowrap>现操作机型品牌</td>");

	  		}
	  		if(xxinghao>0)
		  		{
		  		  out.print("<td nowrap>现操作机型型号</td>");

		  		}
	  		if(xqita!=null && xqita.length()>0)
	  		{
	  			out.print("<td nowrap>现操作机型其他</td>");
	  		}
	  		if(cpinpai>0)
	  		{
	  			 out.print("<td nowrap>曾操作机型品牌</td>");

	  		}
	  		if(cxinghao>0)
		  		{
	  			 out.print("<td nowrap>曾操作机型型号</td>");

		  		}
	  		if(cqita!=null && cqita.length()>0)
	  		{
	  			out.print("<td nowrap>曾操作机型其他</td>");
	  		}
	  		if(jzname!=null && jzname.length()>0)
	  		{
	  			out.print("<td nowrap>机主相关姓名</td>");
	  		}
	  		if(jzxinghao!=null && jzxinghao.length()>0)
	  		{
	  			out.print("<td nowrap>机主相关型号</td>");
	  		}
	  		if(jzxuliehao!=null && jzxuliehao.length()>0)
	  		{
	  			out.print("<td nowrap>机主相关序列号</td>");
	  		}
	  		if(jzlianxi!=null && jzlianxi.length()>0)
	  		{
	  			out.print("<td nowrap>机主相关联系方式</td>");
	  		}
	  		if(aihao!=null && aihao.length()>0)
	  		{
	  			out.print("<td nowrap>爱好</td>");
	  		}

  			 %>



  			  <td nowrap>操作</td>
	    </tr>

<%
//System.out.println(sql.toString());
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
    <td><a href="/jsp/westrac/EditWestracMember.jsp?member=<%=member%>&nexturl=<%=nexturl %>"><%=pobj.getCode()%></a>
    <% if(pobj.isLocking())out.print(" <font color='#FF0000'>[锁定]</font>"); %>
    <%if(pobj.getRemembertype()==1){out.print("<font color='#FF0000'>[推荐会员]</font>");}%>

    </td>
      <td><a href="/jsp/westrac/EditWestracMember.jsp?member=<%=member%>&nexturl=<%=nexturl %>"><%=member%></a></td>
       <td><a href="/jsp/westrac/EditWestracMember.jsp?member=<%=member%>&nexturl=<%=nexturl %>"><%=pobj.getFirstName(teasession._nLanguage)%></a></td>
        <td><%if(pobj.isSex()){out.print("女");}else {out.print("男");} %></td>

      <td nowrap><%=cname %></td>
      <td nowrap><%=pobj.getMobile() %></td>

      <td nowrap><%if(pobj.getTime()!=null)out.print(Entity.sdf2.format(pobj.getTime()));%></td>
      <td nowrap><%=pobj.getMyintegral() %></td>
     <td nowrap><%=pobj.ACTIVES_TYPE[pobj.getActives()] %></td>
       <td nowrap><%
       	if(pobj.getSource()==2&&pobj.getTjmember()!=null&&pobj.getTjmember().length()>0){out.println(pobj.getTjmember());}
       %></td>
       <td><%if(pobj.getImptype()==0){out.println("注册");}else if(pobj.getImptype()==1){out.println("导入");}else if(pobj.getImptype()==2){out.println("同步会员");} %></td>
     <td><%=Profile.SOURCE_TYPE[pobj.getSource()]%></td>
     <%
      if(verifytype!=null && verifytype.length()>0)
	 	{
	 		out.print("<td nowrap>"+Profile.VERIFY_TYPE[pobj.getVerifytype()]+"</td>");
	 	}
     if(belsell!=null && belsell.length()>0)
	 	{
	 		out.print("<td nowrap>"+pobj.getBelsell()+"</td>");
	 	}
	 	if(tjmobile!=null && tjmobile.length()>0)
	 	{
	 		out.print("<td nowrap>"+pobj.getTjmobile()+"</td>");
	 	}

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
     if(degree!=null && degree.length()>0)
	 	{
	 		out.print("<td nowrap>"+pobj.DEGREE_TYPE[Integer.parseInt(degree)]+"</td>");
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
      if((tjmember!=null && tjmember.length()>0))
	 	{
	 		out.print("<td nowrap>"+pobj.getTjmember()+"</td>");
	 	}
      if((sfshanggang!=null && sfshanggang.length()>0))
	 	{
    	  if(0==pobj.getSfshanggang())
    	  {
    		  out.print("<td nowrap>是</td>");
    	  }else
    	  {
    		  out.print("<td nowrap>否</td>");
    	  }

	 	}
		if((fazhengjiguan!=null && fazhengjiguan.length()>0))
	 	{
    		  out.print("<td nowrap>"+pobj.getFazhengjiguan()+"</td>");

	 	}
		if((caozuonianxian!=null && caozuonianxian.length()>0))
	 	{
    		  out.print("<td nowrap>"+pobj.getCaozuonianxian()+"</td>");

	 	}

		if(xpinpai>0)
  		{
  		  out.print("<td nowrap>"+WomenOptions.find(pobj.getXpinpai(),teasession._nLanguage)+"</td>");

  		}
  		if(xxinghao>0)
	  		{
	  		  out.print("<td nowrap>"+WomenOptions.find(pobj.getXxinghao(),teasession._nLanguage)+"</td>");

	  		}
  		if(xqita!=null && xqita.length()>0)
  		{
  			out.print("<td nowrap>"+pobj.getXqita()+"</td>");
  		}
  		if(cpinpai>0)
  		{
  		  out.print("<td nowrap>"+WomenOptions.find(pobj.getCpinpai(),teasession._nLanguage)+"</td>");

  		}
  		if(cxinghao>0)
	  		{
	  		  out.print("<td nowrap>"+WomenOptions.find(pobj.getCxinghao(),teasession._nLanguage)+"</td>");

	  		}
  		if(cqita!=null && cqita.length()>0)
  		{
  			out.print("<td nowrap>"+pobj.getXqita()+"</td>");
  		}
 		if(jzname!=null && jzname.length()>0)
  		{
  			out.print("<td nowrap>"+pobj.getJzname()+"</td>");
  		}
  		if(jzxinghao!=null && jzxinghao.length()>0)
  		{
  			out.print("<td nowrap>"+pobj.getJzxinghao()+"</td>");
  		}
  		if(jzxuliehao!=null && jzxuliehao.length()>0)
  		{
  			out.print("<td nowrap>"+pobj.getJzxuliehao()+"</td>");
  		}
  		if(jzlianxi!=null && jzlianxi.length()>0)
  		{
  			out.print("<td nowrap>"+pobj.getJzlianxi()+"</td>");
  		}
  		if(aihao!=null && aihao.length()>0)
  		{
  			out.print("<td nowrap>"+pobj.getAihao()+"</td>");
  		}



     %>


	    <td nowrap> <a href="###" onClick="f_cz('<%=member%>');" >操作</a></td>

    </tr>

    <tr id="trid<%=member %>" style="display:none">
  	<td align="right" colspan="20">

		<a href="###" onClick="f_verifytype('<%=member%>');" >核实身份</a>
  		<a href="###"  onclick="window.open('/jsp/westrac/EditWestracMember.jsp?member=<%=URLEncoder.encode(member,"UTF-8")%>&nexturl=<%=nexturl%>','_self');">编辑</a>&nbsp;

  		<a href="###" onClick="f_tjmember('<%=member%>');"><%if(pobj.getRemembertype()==0){out.print("推荐到履友之星");}else{out.print("取消履友之星推荐");} %></a>
  		<a href="###" onClick="f_myevent('<%=member%>');">参与活动</a>
  		<a href="###" onClick="f_myclue('<%=member%>');">提供线索</a>
  		<a href="###" onClick="f_act('<%=member%>');">积分</a>

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
  <script type="text/javascript">

  	function f_verifytype(member){
  		var con='<span id="showid"></span><input type="hidden" id="membert" value="'+member+'"/><br/><br/><input type="radio" name="verifytype" value="1"/>机主&nbsp;'+
  		'<input type="radio" name="verifytype" value="2"/>机手&nbsp;'+'<input type="radio" name="verifytype" value="3"/>设备管理人员&nbsp;'+
  		'<input type="radio" name="verifytype" value="4"/>技术管理人员&nbsp;'+'<input type="radio" name="verifytype" value="5" checked/>与行业相关&nbsp;'+
  		'<input type="radio" name="verifytype" value="6"/>无效&nbsp;';
  		ymPrompt.confirmInfo({icoCls:'',msgCls:'confirm',message:con,titile:'请选择审核后身份类型',height:150,handler:verifymembertype,autoClose:false});
  	}
  	function verifymembertype(tp){
  		if(tp!='ok')return ymPrompt.close();
  		var ck=6;
  		var types=document.getElementsByName("verifytype");
  		for(var i=0;i<types.length;i++){
  			if(types[i].checked){
  				ck=types[i].value;
  			}
  		}
  		document.getElementById("showid").innerHTML='<font color=red>信息提交中，请稍等。。。</font>';
  		var memt=document.getElementById("membert").value;
  		sendx("/jsp/admin/edn_ajax.jsp?act=WmemberVerifytype&type="+ck+"&memberid="+encodeURIComponent(memt),
  			function(data){
  				data=data.trim();
  				if(data=='true'){
  					ymPrompt.close();
				      // ymPrompt.win({message:'<br><center>审核通过</center>',width:200,height:100,handler:noTitlebar,btn:[['关闭']],titleBar:false});
				    //parent.f_win("核实身份成功");
  					ymPrompt.win({message:'<br/><center>核实身份成功</center>',width:200,height:100,btn:[['关闭']],titileBar:false});
  				}else if(data=='false'){
  					ymPrompt.close();
  					ymPrompt.win({message:'<br/><center>核实身份失败</center>',width:200,height:100,btn:[['关闭']],titileBar:false});
  				}else{
  					ymPrompt.close();
  				}
  			}
  		)
  	}
  </script>
</form>
</body>
</html>

