<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.orthonline.*"%>
<%@page import="java.util.Date"%>
<%
request.setCharacterEncoding("UTF-8");

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
String communitys = teasession.getParameter("community");
int doid = 0;
if(teasession.getParameter("doid")!=null && teasession.getParameter("doid").length()>0)
{
  doid = Integer.parseInt(teasession.getParameter("doid"));
}
Doctor doobj = Doctor.find(doid);
int maplen=0;
String xingming=null, xingbie=null, youxiaozhengjian="0", youxiaozhengjianhao=null,gerenzhaopianname=null,gerenzhaopianpath=null,yszigezheng=null,yszhiyezheng=null,
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
zyfx1=null,
zyfx2=null,
zyfx3=null,
jizhiqingkuang=null;

String chushengnianyue=null,yszigezhengtime=null,yszhiyezhengtime=null,
biyeshijian1=null,biyeshijian2=null;

int xingzhengzhicheng=0,sheng=0,shi=0,gongzuodanwei=0,xingzhengzhicheng2=0,
zhuanyefangxiang1=0,zhuanyefangxiang2=0,zhuanyefangxiang3=0,gongzuodanwei2s=0,jishuzhicheng1=0,
jishuzhicheng2=0,jishuzhicheng3=0;

if(doid>0)
{
 xingming=doobj.getXingming(); //姓名
  xingbie=doobj.getXingbie(); //性别
  youxiaozhengjian=doobj.getYouxiaozhengjian(); //有效证件
  youxiaozhengjianhao=doobj.getYouxiaozhengjianhao(); //有效证件号码
  chushengnianyue=doobj.getChushengnianyueToString(); //出生年月
  gerenzhaopianname=doobj.getGerenzhaopianname(); //个人照片名称
  gerenzhaopianpath=doobj.getGerenzhaopianpath(); //个人照片地址
  yszigezheng=doobj.getYszigezheng(); //医师资格证
  yszigezhengtime=doobj.getYszigezhengtimeToString(); //获取时间---医师资格证
  yszhiyezheng=doobj.getYszhiyezheng(); //医师执业证
  yszhiyezhengtime=doobj.getYszhiyezhengtimeToString(); //获取时间---医师执业证
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
  biyeshijian1=doobj.getBiyeshijian1ToString(); //毕业或肄业时间--国内
  biyeshijian2=doobj.getBiyeshijian2ToString(); //毕业或肄业时间--国外
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
}
boolean down=request.getParameter("down")!=null;
if(down){
  response.setHeader("Content-Disposition", "attachment; filename="+new String("中华医学会骨科学分会全国骨科医生登记表.html".getBytes("GBK"),"ISO-8859-1"));
}

tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);
if(!down){
%>

<html>
<head>
<base href="http://<%=request.getServerName()%>"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>

</head>

<body id="bodynone">
<script type="">
function f_x()
{
//  alert("登记表,提交成功!点击确定,返回.");

  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:457px;dialogHeight:215px;';
  var url = '/jsp/admin/orthonline/DoctorShow3.jsp?community='+form1.community.value;
  var rs = window.showModalDialog(url,self,y);

  if(rs==1)
  {//打印
    window.print();
  } else
  if(rs==2)
  {
    window.open('/jsp/admin/orthonline/DoctorShow.jsp?community='+form1.community.value+'&doid='+form1.doid.value+'&down=yer','_self');
  }else if(rs==3)
  {
      window.open('/jsp/admin/orthonline/EditDoctor.jsp?community='+form1.community.value,'_self');
  }


 // return;
}
</script>
<div id="head6"><img height="6" src="about:blank"></div>

  <form action="/servlet/EditDoctor" name="form1"  method="POST"  enctype="multipart/form-data">
  <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
  <input type="hidden" name="doid" value="<%=doid%>"/>
  <input type="hidden" name="act" value="EditDoctor"/>
  <input type="hidden" name="community" value="<%=communitys%>"/>
  <input type="hidden" name="repository" value="GeRenZhaoPian"/>
  <%}else{ %>
  <style>
  #tablecenter td select{font-size:12px;font-size:9pt}
  #tablecenter{font-size:12px;border: 1px solid #d7d7d7;width:980px;clear: both;background-color: #F2F2F2;margin-top:10px;border-collapse:collapse;margin-left:0;margin-right:0;margin-bottom:10px;}
  #tablecenter td{height:30px;padding:0px 10px 0px 10px;font-size:12px;border: 1px solid #d7d7d7;line-height:180%;}

  #xiaolijishu{font-size:12px;display:block;float:left;width:95px;}
  #xiaolitable{font-size:12px;width:100%;margin:5px 5px 5px 0;border:1px solid #000000;border-collapse:collapse;}
  #xiaolitable td{font-size:12px;border:1px solid #000000;border-collapse:collapse;}
  #xiaolitable input{font-size:12px;width:195px;}
  #tablecenter #biaotixiaoli{height:35px;font-size:16px;color:#000066;font-weight:bold;}
  </style>

  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <%} %>
  <table border="0" cellpadding="0" cellspacing="0" align="center" id="tablecenter">
  <tr>
  <td align="center" id="biaotixiaoli" colspan="5">中华医学会骨科学分会全国骨科医生登记表</td>
  </tr>
    <tr>
      <td align="right" nowrap><font color="red">*</font>姓　　名</td>
      <td colspan="4"><%if(xingming!=null)out.print(xingming);%></td>
    </tr>
     <tr>
      <td align="right" nowrap><font color="red">*</font>性　　别</td>
      <td colspan="4"><%if(xingbie!=null)out.print(xingbie);%> </td>
    </tr>
     <tr>
      <td align="right"  nowrap><font color="red">*</font>有效证件</td>
      <td colspan="4">
     <%if(Integer.parseInt(youxiaozhengjian)==1)out.print(" 身份证 ");%>
      <%if(Integer.parseInt(youxiaozhengjian)==2)out.print(" 军官证 ");%>
     <%if(Integer.parseInt(youxiaozhengjian)==3)out.print(" 文职证 ");%>
     <%if(Integer.parseInt(youxiaozhengjian)==4)out.print(" 护照 ");%>
     &nbsp;&nbsp;有效证件号码&nbsp;
      <%if(youxiaozhengjianhao!=null)out.print(youxiaozhengjianhao);%>
      </td>
    </tr>
     <tr>
      <td align="right" nowrap><font color="red">*</font>出生年月</td>
      <td colspan="4"><%=chushengnianyue%></td>
    </tr>
     <tr>
      <td align="right" nowrap>个人照片</td>
      <td colspan="4">
      <%
      if(maplen>0){
        out.print("<img width=100 src=http://"+request.getServerName()+gerenzhaopianpath+" />");

       // out.print("<a href=/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode(gerenzhaopianpath,"UTF-8")+"&name="+java.net.URLEncoder.encode(gerenzhaopianname,"UTF-8")+">"+gerenzhaopianname+"</a>");
        %>
        <%} %>
     </td>
    </tr>
    <tr>
      <td align="right" nowrap><font color="red">*</font>医师资格证</td>
      <td colspan="4">
      <%if(yszigezheng!=null)out.print(yszigezheng);%>&nbsp;获取时间&nbsp;
        <%=yszigezhengtime%>
      </td>
    </tr>
     <tr>
      <td align="right" nowrap><font color="red">*</font>医师执业证</td>
      <td colspan="4">
        <%if(yszhiyezheng!=null)out.print(yszhiyezheng);%>&nbsp;获取时间&nbsp;
        <%=yszhiyezhengtime%>
      </td>
    </tr>
    <tr>
      <td align="right" nowrap><font color="red">*</font>技术职称</td>
      <td colspan="4">

      <%
      if(jishuzhicheng1>0)
      {
        out.print("职称1:"+Doctor.JISHU_ZHICHENG[jishuzhicheng1]);
      }
      if(jishuzhicheng2>0)
      {
        out.print("职称2:"+Doctor.JISHU_ZHICHENG[jishuzhicheng2]);
      }
      if(jishuzhicheng3>0)
      {
        out.print("职称3:"+Doctor.JISHU_ZHICHENG[jishuzhicheng3]);
      }
//      if(jishuzhicheng!=null){
//        for(int i =1;i<jishuzhicheng.split("/").length;i++)
//        {
//          out.print(Doctor.JISHU_ZHICHENG[i]+"&nbsp;");
//        }
//      }
      %>
      </td>
    </tr>
     <tr>
      <td align="right" nowrap>现任行政职务</td>
      <td colspan="4">

        <%
        if(xingzhengzhicheng>0)
        {
           out.print("职务1："+Doctor.XINGZHENG_ZHICHENG[xingzhengzhicheng]+"&nbsp;");
        }
           if(xingzhengzhicheng2>0)
        {
           out.print("职务2："+Doctor.XINGZHENG_ZHICHENG[xingzhengzhicheng2]);
        }


        %>

      </td>
    </tr>
     <tr>
      <td align="right" nowrap><font color="red">*</font>所属省份</td>
      <td colspan="4">
          <%
            Provinces pobj = Provinces.find(sheng);
            out.print(pobj.getProvincity());

          %>
      </td>
    </tr>
     <tr>
      <td align="right" nowrap><font color="red">*</font>市（县）</td>
      <td colspan="4">
        <span id="show">
       <%
       Provinces probj2 = Provinces.find(shi);
       out.print(probj2.getProvincity());
       %>
       </span>
      </td>
    </tr>
     <tr>
      <td align="right" nowrap><font color="red">*</font>工作单位</td>
      <td colspan="4">
        <span id="wei">
       <%
       if(gongzuodanwei2!=null && gongzuodanwei2.length()>0){
         out.print(gongzuodanwei2);
       }else
       {
         Hospital hobj = Hospital.find(gongzuodanwei);
         out.print(hobj.getHoname());
       }


       %>
          </select>
        </span>

      </td>
    </tr>
     <tr>
      <td align="right" nowrap><font color="red">*</font>医院级别</td>
      <td colspan="4">
        <%if(yyjibie!=null)out.print(yyjibie);%>

      </td>
    </tr>
       <tr>
      <td align="right" nowrap><font color="red">*</font>医院性质</td>
      <td colspan="4">
       <%=yyxingzhi %>

      </td>
    </tr>
       <tr>
      <td align="right" nowrap><font color="red">*</font>所属科室</td>
      <td colspan="4"><%if(suoshukeshi!=null)out.print(suoshukeshi); %></td>
    </tr>
       <tr>
      <td align="right" nowrap><font color="red">*</font>单位地址</td>
      <td colspan="4"><%if(danweidizhi!=null)out.print(danweidizhi); %></td>
    </tr>
       <tr>
      <td align="right" nowrap><font color="red">*</font>邮编编码</td>
      <td colspan="4"><%if(youbian!=null)out.print(youbian); %></td>
    </tr>
       <tr>
      <td align="right" nowrap><font color="red">*</font>单位电话</td>
      <td colspan="4"><%if(danweidianhua!=null&&danweidianhua2!=null){out.print(danweidianhua+"-"+danweidianhua2);} %></td>
    </tr>
       <tr>
      <td align="right" nowrap><font color="red">*</font>手 机 号</td>
      <td colspan="4"><%if(shoujihao!=null)out.print(shoujihao); %></td>
    </tr>
       <tr>
      <td align="right" nowrap><font color="red">*</font>Email地址</td>
      <td colspan="4"><%if(email!=null&&email!=null){out.print(email+"@"+email2);} %></td>
    </tr>
       <tr>
      <td align="right" nowrap><font color="red">*</font>专业方向</td>
      <td colspan="4">
      <%
      if(zhuanyefangxiang1>0)
      {
        out.print("第一专业:"+Doctor.ZHUANYE_FANGXIANG[zhuanyefangxiang1]+"&nbsp;");
        //
        if(zhuanyefangxiang1==14)//其他
        {
          out.print(zyfx1+"nbsp;");
        }
      }
      if(zhuanyefangxiang2>0)
      {
        out.print("第二专业:"+Doctor.ZHUANYE_FANGXIANG[zhuanyefangxiang2]+"&nbsp;");
         if(zhuanyefangxiang2==14)//其他
        {
          out.print(zyfx2+"nbsp;");
        }
      }
      if(zhuanyefangxiang3>0)
      {
        out.print("第三专业:"+Doctor.ZHUANYE_FANGXIANG[zhuanyefangxiang3]+"&nbsp;");
         if(zhuanyefangxiang3==14)//其他
        {
          out.print(zyfx3+"nbsp;");
        }
      }
      %>

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
     <td align="right">国内</td>
            <td align="center"><%if(biyeyuanxiao1!=null)out.print(biyeyuanxiao1); %></td>
            <td align="center"><%if(biyeyuanxiao1!=null)out.print(biyeshijian1);%></td>
            <td align="center">
            <%=zuigaoxuewei1 %>
            </td>
            <td align="center">
             <%=zuigaoxueli1%>
            </td>
    </tr>

     <tr>
            <td align="right">国外</td>
          <td align="center"><%if(biyeyuanxiao2!=null)out.print(biyeyuanxiao2); %></td>
            <td align="center"><%if(biyeyuanxiao2!=null&&biyeyuanxiao2.length()>0)out.print(biyeshijian2);%></td>
            <td align="center">
              <%=zuigaoxuewei2%>
            </td>
            <td align="center">
             <%=zuigaoxueli2 %>
            </td>
          </tr>



       <tr>
      <td  align="right" nowrap>个人简历(从参加工作起)</td>
      <td colspan="4"><%if(gerenjianli!=null)out.print(gerenjianli);%></td>
    </tr>
       <tr>
      <td align="right" nowrap>学会或社会兼职情况</td>
      <td colspan="4"><%if(jizhiqingkuang!=null)out.print(jizhiqingkuang);%></td>
    </tr>
    <%
    if(!down){
    %>
    <tr>
      <td align="center" colspan="5">
        <input type="button" onClick="window.open('/jsp/admin/orthonline/EditDoctor.jsp?community=<%=communitys%>&doid=<%=doid%>','_self');" value="上一步 返回修改"> &nbsp;&nbsp;&nbsp;&nbsp;
       <!-- <input id="printbutton" type="button" value="打印"  onClick="window.print();">&nbsp;&nbsp;&nbsp;&nbsp;
        <input id="printbutton" type="button" value="导出并另存为" onClick="window.open('/jsp/admin/orthonline/DoctorShow.jsp?community=<%=teasession._strCommunity%>&doid=<%=doid%>&down=yer','_self');"/>&nbsp;&nbsp;&nbsp;&nbsp;
        -->
        <input id="printbutton2" type="button" onclick="f_x();" value="下一步 提交我的登记表">
      </td>
    </tr>
    <%} %>
  </table>
    <%
    if(!down){
    %>
  </form>



  <div id="head6"><img height="6" src="about:blank"></div>

</body>
</html>
<%} %>
