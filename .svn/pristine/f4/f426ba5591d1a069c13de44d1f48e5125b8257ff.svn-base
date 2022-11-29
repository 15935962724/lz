<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.orthonline.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.*"%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);
//if (teasession._rv == null) {
//  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
//  return;
//}
String nexturl =teasession.getParameter("nexturl");
if(nexturl!=null && nexturl.length()>0)
{}else
{
  nexturl = request.getRequestURI()+"?"+request.getQueryString();
}

int doid = 0;
if(teasession.getParameter("doid")!=null && teasession.getParameter("doid").length()>0)
{
  doid = Integer.parseInt(teasession.getParameter("doid"));
}
if("parlog".equals(teasession.getParameter("act")))
{
  String xm = teasession.getParameter("xm");
  String zjsssssssssss = teasession.getParameter("zjsssssssssss");
  String community = teasession.getParameter("community");

  doid = Doctor.getPardaid(community,xm,zjsssssssssss);
}

Doctor doobj = Doctor.find(doid);
int maplen=0;
String xingming=null, xingbie="男", youxiaozhengjian="0", youxiaozhengjianhao=null,gerenzhaopianname=null,gerenzhaopianpath=null,yszigezheng=null,yszhiyezheng=null,
gongzuodanwei2=null,
yyjibie=null,
yyxingzhi=null,
suoshukeshi=null,
danweidizhi=null,
youbian=null,
danweidianhua=null,
danweidianhua2=null,
shoujihao=null,
email=null,
email2=null,
biyeyuanxiao1=null,
biyeyuanxiao2=null,
zuigaoxuewei1=null,
zuigaoxuewei2=null,
zuigaoxueli1=null,
zuigaoxueli2=null,
gerenjianli=null,
jizhiqingkuang=null,
zyfx1=null,
zyfx2=null,
zyfx3=null
;

Date chushengnianyue=null,yszigezhengtime=null,yszhiyezhengtime=null,
biyeshijian1=null,biyeshijian2=null;



int xingzhengzhicheng=0,sheng=0,shi=0,gongzuodanwei=0,
zhuanyefangxiang1=0,zhuanyefangxiang2=0,zhuanyefangxiang3=0,gongzuodanwei2s=0,
jishuzhicheng1=0,jishuzhicheng2=0,jishuzhicheng3=0,xingzhengzhicheng2=0;
int sfs = 0;
if(doid>0)
{
  xingming=doobj.getXingming(); //姓名
  xingbie=doobj.getXingbie(); //性别
  youxiaozhengjian=doobj.getYouxiaozhengjian(); //有效证件
  youxiaozhengjianhao=doobj.getYouxiaozhengjianhao(); //有效证件号码
  chushengnianyue=doobj.getChushengnianyue(); //出生年月
  gerenzhaopianname=doobj.getGerenzhaopianname(); //个人照片名称
  gerenzhaopianpath=doobj.getGerenzhaopianpath(); //个人照片地址
  yszigezheng=doobj.getYszigezheng(); //医师资格证
  yszigezhengtime=doobj.getYszigezhengtime(); //获取时间---医师资格证
  yszhiyezheng=doobj.getYszhiyezheng(); //医师执业证
  yszhiyezhengtime=doobj.getYszhiyezhengtime(); //获取时间---医师执业证
  jishuzhicheng1=doobj.getJishuzhicheng1(); //技术职称1
  jishuzhicheng2=doobj.getJishuzhicheng2(); //技术职称2
  jishuzhicheng3=doobj.getJishuzhicheng3(); //技术职称3
  xingzhengzhicheng=doobj.getXingzhengzhicheng(); //现任行政职务1
  xingzhengzhicheng2=doobj.getXingzhengzhicheng2();//现任行政职务2
  sheng=doobj.getSheng(); //所属省份
  shi=doobj.getShi(); //市（县）
  gongzuodanwei=doobj.getGongzuodanwei(); //工作单位
  gongzuodanwei2=doobj.getGongzuodanwei2(); //请您填写您的单位名称:
  yyjibie=doobj.getYyjibie(); //医院级别
  yyxingzhi=doobj.getYyxingzhi(); //医院性质
  suoshukeshi=doobj.getSuoshukeshi(); //所属科室
  danweidizhi=doobj.getDanweidizhi(); //单位地址
  youbian=doobj.getYoubian(); //邮编编码
  danweidianhua=doobj.getDanweidianhua(); //单位电话
   danweidianhua2=doobj.getDanweidianhua2(); //单位电话
  shoujihao=doobj.getShoujihao(); //手 机 号
  email=doobj.getEmail(); //Email地址
    email2=doobj.getEmail2(); //Email地址
  zhuanyefangxiang1=doobj.getZhuanyefangxiang1(); //专业方向 第一专业
  zhuanyefangxiang2=doobj.getZhuanyefangxiang2(); //专业方向  第二专业
  zhuanyefangxiang3=doobj.getZhuanyefangxiang3(); //专业方向 第三专业
  zyfx1=doobj.getZyfx1();
  zyfx2=doobj.getZyfx2();
  zyfx3=doobj.getZyfx3();
  biyeyuanxiao1=doobj.getBiyeyuanxiao1(); //毕业院校名称--国内
  biyeyuanxiao2=doobj.getBiyeyuanxiao2(); //毕业院校名称--国外
  biyeshijian1=doobj.getBiyeshijian1(); //毕业或肄业时间--国内
  biyeshijian2=doobj.getBiyeshijian2(); //毕业或肄业时间--国外
  zuigaoxuewei1=doobj.getZuigaoxuewei1(); //最高学位--国内
  zuigaoxuewei2=doobj.getZuigaoxuewei2(); //最高学位--国外
  zuigaoxueli1=doobj.getZuigaoxueli1(); //最高学历--国内
  zuigaoxueli2=doobj.getZuigaoxueli2(); //最高学历--国外
  gerenjianli=doobj.getGerenjianli(); //个人简历(从参加工作起)
  jizhiqingkuang=doobj.getJizhiqingkuang(); //学会或社会兼职情况
  gongzuodanwei2s=doobj.getGongzuodanwei2s();

  if(doobj.getGerenzhaopianpath()!=null)
  {
    maplen=(int)new java.io.File(application.getRealPath(doobj.getGerenzhaopianpath())).length();
  }
  sfs = 1;
}

tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);
Calendar cal = Calendar.getInstance();
int year = cal.get(Calendar.YEAR);

%>

<html>
<head>

<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>骨科医生登记表</title>
</head>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<body id="bodynone" <% if(doid>0)out.print("onload=f_ajax();"); %>>
 <script>
 function f_ajax()
 {
   f_sheng();
   f_shi();
   //f_gongzuodanwei();
   f_gongzuodanwei2s(form1.gongzuodanwei2s);
   f_zyfx1('1');
   f_zyfx1('2');
   f_zyfx1('3');
 }
 function f_gongzuodanwei2s(obj)
 {
   var sbtitle=document.getElementById("gzd");
   var sbwei = document.getElementById("wei");
   if(obj.checked==true)
   {
     sbtitle.style.display='block';
     sbwei.style.display='none';
     form1.gongzuodanwei.value=0;
//     form1.danweidizhi.value='';
//     form1.youbian.value='';
   }else
   {
     sbtitle.style.display='none';
      sbwei.style.display='block';
      form1.gongzuodanwei2.value='';
   }
 }
 //专业方向
 function f_zyfx1(igd)
 {
   var zy1=document.getElementById("zy"+igd);
   if(document.all("zhuanyefangxiang"+igd).value==14)
   {
     zy1.style.display='block';
   }else
   {
      zy1.style.display='none';
      document.all("zyfx"+igd).value='';
   }

 }
 function f_sheng(){
         sendx("/jsp/admin/orthonline/city_ajax.jsp?doid=<%=doid%>&act=city&sheng="+form1.sheng.value,
         function(data)
         {
           document.getElementById("show").innerHTML=data;
         }
         );
 }
 function f_shi()
 {
        sendx("/jsp/admin/orthonline/city_ajax.jsp?doid=<%=doid%>&xianshi=no&act=gongzuodanwei&sheng="+form1.sheng.value+"&shi="+form1.shi.value,
         function(data)
         {
           document.getElementById("wei").innerHTML=data;
         }
         );
 }
 function f_gongzuodanwei()
 {
   sendx("/jsp/admin/orthonline/city_ajax.jsp?doid=<%=doid%>&act=addzip&gongzuodanwei="+form1.gongzuodanwei.value,
   function(data)
   {

     if(data.split("/")[1]=='null'){
        form1.danweidizhi.value = '';
     }else{
       form1.danweidizhi.value = data.split("/")[1];
     }
     if(data.split("/")[2]=='null'){
       form1.youbian.value='';
     }else
     {
       form1.youbian.value= data.split("/")[2];
     }
   }
   );
   //alert(form1.gongzuodanwei.value);
   if(form1.gongzuodanwei.value==-1)
   {
     var sbtitle=document.getElementById("gzd");

     var sbwei = document.getElementById("wei");
     sbtitle.style.display='block';
     document.getElementById("xiaoliche").checked=true;

    // c1.checked=true
     // {
       sbtitle.style.display='block';
       sbwei.style.display='none';
       form1.gongzuodanwei.value=0;
       //}

   }
 }
//显示输入的医院
function f_gz2()
{
  sendx("/jsp/admin/orthonline/city_ajax.jsp?act=gongzuodanwei2&sheng="+form1.sheng.value+"&shi="+form1.shi.value+"&gzdw2="+encodeURIComponent(form1.gongzuodanwei2.value),
  function(data)
  {
    document.getElementById("gzshow").innerHTML=data;
  }
  );
}
function f_trdw(igd)
{
  form1.gongzuodanwei2.value=igd;
  document.getElementById("xilidiv").style.display='none';//隐藏div
}

 function f_submit()
 {
   if(form1.xingming.value=='')
   {
     alert('姓名不能为空');
     form1.xingming.focus();
     return false;
   }

   if(form1.chushengnianyueYear.value==''||form1.chushengnianyueMonth.value==''||form1.chushengnianyueDay.value=='')
   {
     alert('出生日期不能为空');
     form1.chushengnianyueYear.focus();
     return false;
   }


   if(form1.youxiaozhengjian.value==0)
   {
     alert('请选择有效证件');
     form1.youxiaozhengjian.focus();
     return false;
   }
   if(form1.youxiaozhengjianhao.value=='')
   {
     alert('有效证件号码不能为空');
     form1.youxiaozhengjianhao.focus();
     return false;
   }
   if(form1.sf.value==0)
   {
      alert('有效证件号码不能重复');
     form1.youxiaozhengjianhao.focus();
     return false;
   }

//    if(form1.youxiaozhengjian.value==1)
//   {
//      return f_zj();
//   }

   if(form1.yszigezheng.value==0)
   {
     alert('医师资格证不能为空');
     form1.yszigezheng.focus();
     return false;
   }
   if(form1.yszigezhengtimeYear.value==''||form1.yszigezhengtimeMonth.value==''||form1.yszigezhengtimeDay.value=='')
   {
     alert('医生资格证的获取时间不能为空');
     form1.yszigezhengtimeYear.focus();
     return false;
   }

   if(form1.yszhiyezheng.value==0)
   {
     alert('医师执业证不能为空');
     form1.yszhiyezheng.focus();
     return false;
   }
   if(form1.yszhiyezhengtimeYear.value==''||form1.yszhiyezhengtimeMonth.value==''||form1.yszhiyezhengtimeDay.value=='')
   {
     alert('医师执业证的获取时间不能为空');
     form1.yszhiyezhengtimeYear.focus();
     return false;
   }

   if(form1.jishuzhicheng1.value==0&&form1.jishuzhicheng2.value==0&&form1.jishuzhicheng3.value==0)
   {
     alert('请选择技术职称');
     form1.jishuzhicheng1.focus();
     return false;
   }
   if(form1.sheng.value==0)
   {
     alert('所属省份不能为空');
     form1.sheng.focus();
     return false;
   }
   if(form1.shi.value==0)
   {
     alert('所属市（县）不能为空');
     form1.shi.focus();
     return false;
   }

   if(form1.gongzuodanwei.value==0 && form1.gongzuodanwei2s.checked==false)
   {
     alert('工作单位不能为空');
     form1.gongzuodanwei.focus();
     return false;
   }
   if(form1.gongzuodanwei2s.checked==true && form1.gongzuodanwei2.value=='')
   {
     alert('工作单位不能为空');
     form1.gongzuodanwei2.focus();
     return false;
   }

   if(form1.yyjibie.value==0)
   {
     alert('医院级别不能为空');
     form1.yyjibie.focus();
     return false;
   }
   if(form1.yyxingzhi.value==0)
   {
     alert('医院性质不能为空');
     form1.yyxingzhi.focus();
     return false;
   }
    if(form1.suoshukeshi.value==0)
   {
     alert('所属科室不能为空');
     form1.suoshukeshi.focus();
     return false;
   }
   if(form1.danweidizhi.value==0)
   {
     alert('单位地址不能为空');
     form1.danweidizhi.focus();
     return false;
   }

   if(form1.youbian.value==0)
   {
     alert('邮编编码不能为空');
     form1.youbian.focus();
     return false;
   }
   if(form1.danweidianhua.value==''||form1.danweidianhua2.value=='')
   {
     alert('单位电话不能为空');
     form1.danweidianhua.focus();
     return false;
   }
   if(form1.shoujihao.value=='')
   {
     alert('手 机 号不能为空');
     form1.shoujihao.focus();
     return false;
   }
   if(form1.email.value==''||form1.email2.value=='')
   {
     alert('Email地址不能为空');
     form1.email.focus();
     return false;
   }
   if(form1.zhuanyefangxiang1.value==0&&form1.zhuanyefangxiang2.value==0&&form1.zhuanyefangxiang3.value==0)
   {
     alert('专业方向不能为空');
     form1.zhuanyefangxiang1.focus();
     return false;
   }else if(form1.zhuanyefangxiang1.value==14||form1.zhuanyefangxiang2.value==14||form1.zhuanyefangxiang3.value==14)
   {
     if(form1.zyfx1.value==''&&form1.zyfx2.value==''&&form1.zyfx3.value=='')
     {
       alert('专业方向不能为空');
       form1.zyfx1.focus();
       return false;
     }
   }
   if(form1.biyeyuanxiao1.value=='')
   {
     alert('国内毕业院校名称不能为空');
     form1.biyeyuanxiao1.focus();
     return false;
   }
   if(form1.biyeshijian1Year.value==''||form1.biyeshijian1Month.value==''||form1.biyeshijian1Day.value=='')
   {
     alert('国内毕业或肄业时间不能为空');
     form1.biyeshijian1Year.focus();
     return false;
   }

   if(form1.zuigaoxuewei1.value=='')
   {
     alert('国内最高学位不能为空');
     form1.zuigaoxuewei1.focus();
     return false;
   }
   if(form1.zuigaoxueli1.value=='')
   {
     alert('国内最高学历不能为空');
     form1.zuigaoxueli1.focus();
     return false;
   }
 }
 function f_zj()
 {
   if(form1.youxiaozhengjian.value==0)
   {
     alert("请先选择有效证件");
     form1.youxiaozhengjianhao.value='';
     form1.youxiaozhengjian.focus();
     return false;
   }

   if(form1.youxiaozhengjian.value==1)//选择的是身份证件才判断
   {
     var sID = document.form1.youxiaozhengjianhao.value;
     if(!(/^\d{15}$|^\d{18}$|^\d{17}[xX]$/.test(sID)))
     {
       alert("身份证号码有误,请确认.");
       document.form1.youxiaozhengjianhao.focus();
       form1.submitx.disabled=true;
       return false;
     }else
     {
        form1.submitx.disabled=false;
        form1.sf.value==1;
     }
   }

     sendx("/jsp/admin/orthonline/city_ajax.jsp?community="+form1.community.value+"&act=youxiaozhengjianhao&zj="+form1.youxiaozhengjianhao.value,
     function(data)
     {
       if(data.trim().length>0)
       {
         alert(data);
         form1.youxiaozhengjianhao.focus();
         form1.submitx.disabled=true;
         return false;
       }else
       {
          form1.submitx.disabled=false;
          form1.sf.value='1';
       }
     }
     );
 }
 //手机号位数判断
 function f_sj()
 {
   var tel = document.all("shoujihao").value;

   var string_value =form1.shoujihao.value;
   var type="^\s*[+-]?[0-9]+\s*$";
   var re = new RegExp(type);

   if(string_value.match(re)==null)
   {

     alert("手机号码有误,请确认.");
     form1.shoujihao.focus();
     form1.submitx.disabled=true;
     return false;
   }
   else if(string_value.length!=11)
   {

     alert("手机号码有误,请确认.");
     form1.shoujihao.focus();
     form1.submitx.disabled=true;
     return false;
   }else
   {
     form1.submitx.disabled=false;
   }



//   if(/^13\d{9}$/g.test(tel)||(/^15[8,9]\d{8}$/g.test(tel)))
//   {
//     form1.submitx.disabled=false;
//   }
//   else
//   {
//     alert("手机号码有误,请确认.");
//     form1.shoujihao.focus();
//     form1.submitx.disabled=true;
//     return false;
//   }

 }
 function f_yxzj()
 {
   form1.youxiaozhengjianhao.value='';
    form1.submitx.disabled=false;
 }
 //管理员登录

 function f_dalog()
 {
//   var rs = window.showModalDialog('/jsp/admin/orthonline/DoctorAdminLog.jsp?id='+form1.id.value+'&community='+form1.community.value,self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:315px;dialogHeight:205px;');
//   if(rs==1)
//   {
//     window.open('/jsp/admin/index2.jsp?community='+form1.community.value,'_self');
//   }
   window.open('/servlet/Node?node=2198508&community='+form1.community.value,'_self');
 }
 //个人登录
 function f_grlog()
 {
   var rs = window.showModalDialog('/jsp/admin/orthonline/DoctorParLog.jsp?id='+form1.id.value+'&community='+form1.community.value,self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:465px;dialogHeight:205px;');
   if(rs!=null)
   {

     window.open('/jsp/admin/orthonline/EditDoctor.jsp?act=parlog&xm='+encodeURIComponent(rs.split("/")[1])+'&zjsssssssssss='+ encodeURIComponent(rs.split("/")[2])+'&community='+form1.community.value,'_self');
   }
 }
 </script>
<div id="head6"><img height="6" src="about:blank"></div>
  <form action="/servlet/EditDoctor" name="form1"  method="POST"  enctype="multipart/form-data" onsubmit="return f_submit();">
  <input type="hidden" name="sf" value="<%=sfs%>"/>
  <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
  <input type="hidden" name="doid" value="<%=doid%>"/>
  <input type="hidden" name="act" value="EditDoctor"/>
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="repository" value="GeRenZhaoPian"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
  <td align="center" colspan="5" id="biaotixiaoli">中华医学会骨科学分会全国骨科医生登记表</td>
  </tr>
  <tr>
    <td align="center" colspan="5"><a href="#" onclick="f_dalog();">管理员登录</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <a href="#"  onclick="f_grlog();">个人登记表修改</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">带*号为必填项</font> </td>
  </tr>





    <tr>
      <td align="right"><font color="red">*</font>姓　　名</td>
      <td colspan="4" ><input type="text" name="xingming" value="<%if(xingming!=null)out.print(xingming);%>" /></td>
    </tr>
     <tr>
      <td align="right"><font color="red">*</font>性　　别</td>
      <td colspan="4"  id="xiaoset"><input type="radio" name="xingbie"  value="男" <%if("男".equals(xingbie))out.print(" checked ");%> />&nbsp;男&nbsp;<input type="radio" name="xingbie" value="女" <%if("女".equals(xingbie))out.print(" checked ");%> >&nbsp;女&nbsp;</td>
    </tr>
     <tr>
      <td align="right"><font color="red">*</font>有效证件</td>
      <td colspan="4" >
      <select name="youxiaozhengjian" onchange="f_yxzj();">
      <option value="0">请选择有效证件</option>
      <option value="1"  <%if(Integer.parseInt(youxiaozhengjian)==1)out.print(" selected ");%> >身份证</option>
      <option value="2"<%if(Integer.parseInt(youxiaozhengjian)==2)out.print(" selected ");%>>军官证</option>
      <option value="3"<%if(Integer.parseInt(youxiaozhengjian)==3)out.print(" selected ");%>>文职证</option>
      <option value="4"<%if(Integer.parseInt(youxiaozhengjian)==4)out.print(" selected ");%>>护照</option>
      </select>&nbsp;&nbsp;有效证件号码&nbsp;
      <input type="text" name="youxiaozhengjianhao" value="<%if(youxiaozhengjianhao!=null)out.print(youxiaozhengjianhao);%>" onchange="f_zj();">
      </td>
    </tr>
     <tr>
      <td align="right"><font color="red">*</font>出生年月</td>
      <td colspan="4" ><% out.print(Doctor.getSelectTime("chushengnianyue",chushengnianyue,year,1910));%></td>
    </tr>
     <tr>
      <td align="right">个人照片</td>
      <td colspan="4" ><input type="file" name="gerenzhaopianpath" value=""/>&nbsp;
         <%
          if(maplen>0){
            out.print("<a href=/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode(gerenzhaopianpath,"UTF-8")+"&name="+java.net.URLEncoder.encode(gerenzhaopianname,"UTF-8")+">"+gerenzhaopianname+"</a>");
            %>
            <input  id="CHECKBOX" type="CHECKBOX" name="clear1" onClick="form1.gerenzhaopianname.disabled=this.checked;"/> 清空
            <%} %>
      &nbsp;(宽度400像素,高度400像素以内)&nbsp;</td>
    </tr>
    <tr>
      <td align="right"><font color="red">*</font>医师资格证号</td>
      <td colspan="4" >
        <input type="text" name="yszigezheng" value="<%if(yszigezheng!=null)out.print(yszigezheng);%>" />&nbsp;获取时间&nbsp;
        <%out.print(Doctor.getSelectTime("yszigezhengtime",yszigezhengtime,year,1950));%>
      </td>
    </tr>
     <tr>
      <td align="right"><font color="red">*</font>医师执业证号</td>
      <td colspan="4" >
        <input type="text" name="yszhiyezheng" value="<%if(yszhiyezheng!=null)out.print(yszhiyezheng);%>" />&nbsp;获取时间&nbsp;
        <%out.print(Doctor.getSelectTime("yszhiyezhengtime",yszhiyezhengtime,year,1950));%>
      </td>
    </tr>
    <tr>
      <td align="right"><font color="red">*</font>技术职称</td>
      <td colspan="4" >
      职称1&nbsp;
      <select name="jishuzhicheng1">
        <option value="0">--请选择职称1--</option>
        <%
        for(int i =1;i<Doctor.JISHU_ZHICHENG.length;i++)
        {
          out.print("<option value="+i);
          if(jishuzhicheng1==i)
          {
            out.print(" selected ");
          }
          out.print(">"+Doctor.JISHU_ZHICHENG[i]);
          out.print("</option>");
        }
        %>
        </select>
        职称2&nbsp;
        <select name="jishuzhicheng2">
          <option value="0">--请选择职称2--</option>
          <%
          for(int i =1;i<Doctor.JISHU_ZHICHENG.length;i++)
          {
            out.print("<option value="+i);
            if(jishuzhicheng2==i)
            {
              out.print(" selected ");
            }
            out.print(">"+Doctor.JISHU_ZHICHENG[i]);
            out.print("</option>");
          }
          %>
          </select>
          职称3&nbsp;
          <select name="jishuzhicheng3">
            <option value="0">--请选择职称3--</option>
            <%
            for(int i =1;i<Doctor.JISHU_ZHICHENG.length;i++)
            {
              out.print("<option value="+i);
              if(jishuzhicheng3==i)
              {
                out.print(" selected ");
              }
              out.print(">"+Doctor.JISHU_ZHICHENG[i]);
              out.print("</option>");
            }
            %>
            </select>
      </td>
    </tr>
     <tr>
      <td nowrap align="right">现任行政职务</td>
      <td colspan="4" >
      职务1&nbsp;
        <select name="xingzhengzhicheng" >
        <option value="0">--请选择职务1--</option>
        <%
        for(int i =1;i<Doctor.XINGZHENG_ZHICHENG.length;i++)
        {
          out.print("<option value="+i);
          if(xingzhengzhicheng==i)
          {
            out.print(" selected");
          }
          out.print(">"+Doctor.XINGZHENG_ZHICHENG[i]);
          out.print("</option>");
        }
        %>
        </select>&nbsp;
        职务2&nbsp;
        <select name="xingzhengzhicheng2" >
          <option value="0">--请选择职务2--</option>
          <%
          for(int i =1;i<Doctor.XINGZHENG_ZHICHENG.length;i++)
          {
            out.print("<option value="+i);
            if(xingzhengzhicheng2==i)
            {
              out.print(" selected");
            }
            out.print(">"+Doctor.XINGZHENG_ZHICHENG[i]);
            out.print("</option>");
          }
          %>
          </select>&nbsp;

      </td>
    </tr>
     <tr>
      <td align="right"><font color="red">*</font>所属省份</td>
      <td colspan="4" >
        <select name="sheng" onchange="f_sheng();">
          <option value="0">请选择省份/直辖市</option>
          <%
          java.util.Enumeration e = Provinces.find(" AND type=0 ");
          while(e.hasMoreElements())
          {
            int proid = ((Integer)e.nextElement()).intValue();
            Provinces pobj = Provinces.find(proid);
            out.print("<option value="+proid);
            if(sheng==proid)
            {
              out.print(" selected");
            }
            out.print(">"+pobj.getProvincity());
            out.print("</option>");
          }
          %>
        </select>
      </td>
    </tr>
     <tr>
      <td align="right"><font color="red">*</font>市（县）</td>
      <td colspan="4" >
        <span id="show">
        <select name="shi">
          <option value="0">请选择市/县</option>
        </select>
       </span>
      </td>
    </tr>
     <tr>
      <td align="right"><font color="red">*</font>工作单位</td>
      <td colspan="4" >
        <span id="wei">
          <select name="gongzuodanwei">
            <option value="0">请选择医院</option>
          </select>
        </span>

       <span id="gzd" style="display:none;"> 请您填写您的单位名称:&nbsp;
        <span id="gztext"> <input type="text" name="gongzuodanwei2" value="<%if(gongzuodanwei2!=null)out.print(gongzuodanwei2);%>" size="50" onkeyup="f_gz2();"></span>
         <span id="gzshow">&nbsp;</span>

      &nbsp;如果没有从列表找到您的医院,请点击这里&nbsp;<input id="xiaoliche"   type="checkbox" name="gongzuodanwei2s" <%if(gongzuodanwei2s==1)out.print(" checked "); %>    value="1" onclick="f_gongzuodanwei2s(this);"/>
      </span>
      </td>
    </tr>
     <tr>
      <td align="right"><font color="red">*</font>医院级别</td>
      <td colspan="4" >
        <select name="yyjibie"  >
          <option value="">请选择医院级别</option>
          <option value="三甲" <%if("三甲".equals(yyjibie))out.print(" selected");%>>三甲</option>
          <option value="三乙" <%if("三乙".equals(yyjibie))out.print(" selected");%>>三乙</option>
          <option value="二甲" <%if("二甲".equals(yyjibie))out.print(" selected");%>>二甲</option>
          <option value="二乙" <%if("二乙".equals(yyjibie))out.print(" selected");%>>二乙</option>
          <option value="未评级" <%if("未评级".equals(yyjibie))out.print(" selected");%>>未评级</option>
        </select>
      </td>
    </tr>
       <tr>
      <td align="right"><font color="red">*</font>医院性质</td>
      <td colspan="4" >
        <select name="yyxingzhi" >
          <option value="">请选择医院性质</option>
            <option value="部队"  <%if("部队".equals(yyxingzhi))out.print(" selected ");%> >部队</option>
          <option value="公立"  <%if("公立".equals(yyxingzhi))out.print(" selected ");%> >公立</option>
          <option value="民营" <%if("民营".equals(yyxingzhi))out.print(" selected ");%> >民营</option>
        </select>
      </td>
    </tr>
       <tr>
      <td align="right"><font color="red">*</font>所属科室</td>
      <td colspan="4" ><input type="text" name="suoshukeshi" value="<%if(suoshukeshi!=null)out.print(suoshukeshi); %>" /></td>
    </tr>
       <tr>
      <td align="right"><font color="red">*</font>单位地址</td>
      <td colspan="4" ><input type="text" name="danweidizhi" value="<%if(danweidizhi!=null)out.print(danweidizhi); %>" /></td>
    </tr>
       <tr>
      <td align="right"><font color="red">*</font>邮编编码</td>
      <td colspan="4" ><input type="text" name="youbian" value="<%if(youbian!=null)out.print(youbian); %>" /></td>
    </tr>
       <tr>
      <td align="right"><font color="red">*</font>单位电话</td>
      <td colspan="4" >&nbsp;区号&nbsp;<input type="text" name="danweidianhua" value="<%if(danweidianhua!=null)out.print(danweidianhua); %>"  size="4">-
        <input type="text" name="danweidianhua2" value="<%if(danweidianhua2!=null)out.print(danweidianhua2); %>"  size="8">
      </td>
    </tr>
       <tr>
      <td align="right"><font color="red">*</font>手 机 号</td>
      <td colspan="4" ><input type="text" name="shoujihao" value="<%if(shoujihao!=null)out.print(shoujihao); %>" onchange="f_sj();" /></td>
    </tr>
       <tr>
      <td align="right"><font color="red">*</font>Email地址</td>
      <td colspan="4" >
        <input type="text" name="email" value="<%if(email!=null)out.print(email); %>" />@
         <input type="text" name="email2" value="<%if(email!=null)out.print(email2); %>" size="5">
      </td>
    </tr>
       <tr>
      <td align="right"><font color="red">*</font>专业方向</td>
      <td colspan="4" >
        <span id="zhuanye">第一专业<select name="zhuanyefangxiang1" onchange="f_zyfx1('1');">
          <option value="0">请选择第一专业</option>
         <%
            for(int i =1;i<Doctor.ZHUANYE_FANGXIANG.length;i++)
            {
              out.print("<option value="+i);
              if(zhuanyefangxiang1==i)
              {
                out.print(" selected");
              }
              out.print(">"+Doctor.ZHUANYE_FANGXIANG[i]);
              out.print("</option>");
            }
         %>
        </select></span><span id="zy1" style="display:none"><input type="text" name="zyfx1" value="<%if(zyfx1!=null)out.print(zyfx1);%>" ></span>
        <span id="zhuanye">第二专业<select name="zhuanyefangxiang2" onchange="f_zyfx1('2');">
          <option value="0">请选择第二专业</option>
          <%
          for(int i =1;i<Doctor.ZHUANYE_FANGXIANG.length;i++)
          {
            out.print("<option value="+i);
               if(zhuanyefangxiang2==i)
              {
                out.print(" selected");
              }
            out.print(">"+Doctor.ZHUANYE_FANGXIANG[i]);
            out.print("</option>");
          }
          %>
        </select></span><span id="zy2" style="display:none;"><input type="text" name="zyfx2" value="<%if(zyfx2!=null)out.print(zyfx2);%>" ></span>
        <span id="zhuanye">第三专业<select name="zhuanyefangxiang3" onchange="f_zyfx1('3');">
          <option value="0">请选择第三专业</option>
          <%
          for(int i =1;i<Doctor.ZHUANYE_FANGXIANG.length;i++)
          {
            out.print("<option value="+i);
               if(zhuanyefangxiang3==i)
              {
                out.print(" selected");
              }
            out.print(">"+Doctor.ZHUANYE_FANGXIANG[i]);
            out.print("</option>");
          }
          %>
          </select></span><span id="zy3"  style="display:none;"><input type="text" name="zyfx3" value="<%if(zyfx3!=null)out.print(zyfx3);%>"></span>

      </td>
    </tr>

    <tr>
      <td align="right">毕业院校</td>
      <td align="center">院校名称</td>
      <td align="center">毕业或肄业时间</td>
      <td align="center">最高学位</td>
      <td align="center">最高学历</td>
    </tr>
    <tr>
      <td align="right"><font color="red">*</font>国内</td>
      <td align="center"><input type="text" name="biyeyuanxiao1" value="<%if(biyeyuanxiao1!=null)out.print(biyeyuanxiao1);%>" size="50"></td>
        <td align="center"><%out.print(Doctor.getSelectTime("biyeshijian1",biyeshijian1,year,1940));%></td>
        <td align="center">
          <select name="zuigaoxuewei1">
            <option value="">-------</option>
              <option value="无" <%if("无".equals(zuigaoxuewei1))out.print(" selected");%> >无</option>
            <option value="学士" <%if("学士".equals(zuigaoxuewei1))out.print(" selected");%> >学士</option>
            <option value="硕士" <%if("硕士".equals(zuigaoxuewei1))out.print(" selected");%> >硕士</option>
            <option value="博士" <%if("博士".equals(zuigaoxuewei1))out.print(" selected");%> >博士</option>
          </select>
        </td>
        <td align="center">
          <select name="zuigaoxueli1">
            <option value="">-------</option>
            <option value="高中" <%if("高中".equals(zuigaoxueli1))out.print(" selected");%> >高中</option>
            <option value="中专" <%if("中专".equals(zuigaoxueli1))out.print(" selected");%> >中专</option>
            <option value="高职" <%if("高职".equals(zuigaoxueli1))out.print(" selected");%> >高职</option>
            <option value="大专" <%if("大专".equals(zuigaoxueli1))out.print(" selected");%> >大专</option>
            <option value="本科" <%if("本科".equals(zuigaoxueli1))out.print(" selected");%> >本科</option>
            <option value="研究生" <%if("研究生".equals(zuigaoxueli1))out.print(" selected");%> >研究生</option>
  <option value="博士" <%if("博士".equals(zuigaoxueli1))out.print(" selected");%> >博士</option>
            <option value="博士后" <%if("博士后".equals(zuigaoxueli1))out.print(" selected");%> >博士后</option>
          </select>
        </td>
    </tr>
    <tr>
    <td align="right">&nbsp;&nbsp;国外</td>
          <td align="center"><input type="text" name="biyeyuanxiao2" value="<%if(biyeyuanxiao1!=null)out.print(biyeyuanxiao2);%>" size="50"></td>
            <td align="center"><%out.print(Doctor.getSelectTime("biyeshijian2",biyeshijian2,year,1940));%></td>
            <td align="center">
              <select name="zuigaoxuewei2">
                <option value="">-------</option>
                 <option value="无" <%if("无".equals(zuigaoxuewei2))out.print(" selected");%> >无</option>
                <option value="学士" <%if("学士".equals(zuigaoxuewei2))out.print(" selected");%> >学士</option>
                <option value="硕士" <%if("硕士".equals(zuigaoxuewei2))out.print(" selected");%> >硕士</option>
                <option value="博士" <%if("博士".equals(zuigaoxuewei2))out.print(" selected");%> >博士</option>
              </select>
            </td>
            <td align="center">
              <select name="zuigaoxueli2">
                <option value="">-------</option>
                <option value="高中" <%if("高中".equals(zuigaoxueli2))out.print(" selected");%> >高中</option>
                <option value="中专" <%if("中专".equals(zuigaoxueli2))out.print(" selected");%> >中专</option>
                <option value="高职" <%if("高职".equals(zuigaoxueli2))out.print(" selected");%> >高职</option>
                <option value="大专" <%if("大专".equals(zuigaoxueli2))out.print(" selected");%> >大专</option>
                <option value="本科" <%if("本科".equals(zuigaoxueli2))out.print(" selected");%> >本科</option>
                <option value="研究生" <%if("研究生".equals(zuigaoxueli2))out.print(" selected");%> >研究生</option>
                 <option value="博士" <%if("博士".equals(zuigaoxueli2))out.print(" selected");%> >博士</option>
                <option value="博士后" <%if("博士后".equals(zuigaoxueli2))out.print(" selected");%> >博士后</option>
              </select>
            </td>
    </tr>

       <tr>
      <td nowrap align="right">个人简历<br />(从参加工作起)</td>
      <td colspan="4" ><textarea cols="80" rows="10" name="gerenjianli"><%if(gerenjianli!=null)out.print(gerenjianli);%></textarea></td>
    </tr>
       <tr>
      <td align="right">学会或社会兼职情况</td>
      <td colspan="4" ><textarea cols="80" rows="10" name="jizhiqingkuang"><%if(jizhiqingkuang!=null)out.print(jizhiqingkuang);%></textarea></td>
    </tr>
    <tr>
    <td align="center" colspan="5" id="submitid"><input name="submitx" type="submit" value="下一步 预览"/></td>
    </tr>
  </table>
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
  <script type="">
//  var ss=document.getElementsByTagName("SELECT");
//  for(var i=0;i<ss.length;i++)
//  {
//    if(ss[i].name.indexOf("Year")!=-1)
//    {
//      var op=ss[i].options;
//      op[op.length]=new Option("--选择年--","");
//      ss[i].value="";
//    }
//    if(ss[i].name.indexOf("Month")!=-1)
//    {
//      var op=ss[i].options;
//      op[op.length]=new Option("--选择月--","");
//      ss[i].value="";
//    }
//    if(ss[i].name.indexOf("Day")!=-1)
//    {
//      var op=ss[i].options;
//      op[op.length]=new Option("--选择日--","");
//      ss[i].value="";
//    }
//  }
  </script>
</body>
</html>
