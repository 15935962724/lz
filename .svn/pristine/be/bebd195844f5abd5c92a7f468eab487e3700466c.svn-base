<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String key=h.get("lmsorg");
int lmsorg=key.length()<1?0:Integer.parseInt(MT.dec(key));
LmsOrg t=LmsOrg.find(lmsorg);
if(t.lmsorg<1)
{
  t.father=h.getInt("father");
  t.isasp=1;
}

%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
</head>
<body>
<h1><%=t.lmsorg<1?"添加":"编辑"%>省助学发展机构</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/LmsOrgs.do" method="post" enctype="multipart/form-data" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmsorg" value="<%=key%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="father" value="<%=t.father%>"/>
<input type="hidden" name="isasp" value="<%=t.isasp%>"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0" class="alignLeft">
<!--
  <tr>
    <th>aspid</th>
    <td><input name="aspid" value="<%=MT.f(t.aspid)%>"/></td>
  </tr>
  <tr>
    <th>layer</th>
    <td><input name="layer" value="<%=MT.f(t.layer)%>"/></td>
  </tr>
-->
  <tr>
    <th>编号</th>
    <td colspan="6"><%=MT.f(t.orgno,"编号系统自动生成。生成规则:所在省区编号+所在市编号+省助学发展机构身份编号+省助学发展机构编号。")%></td>
  </tr>
  <tr>
    <th><em>*</em>省助学发展机构名称</th>
    <td colspan="6"><input name="orgname" value="<%=MT.f(t.orgname)%>" size="40" alt="省助学发展机构名称"/></td>
  </tr>
  <tr>
    <th><em>*</em>授权省</th>
    <td colspan="6"><script>mt.city('member',null,null,'<%=MT.f(t.member)%>');form1.member.alt="授权省";</script></td>
  </tr>
  <tr>
    <th><em>*</em>类型</th>
    <td colspan="6"><select name="orgtype" alt="类型"><%=h.options(LmsOrg.ORGTYPE_TYPE,t.orgtype)%></select></td>
  </tr>
  <tr>
    <th>通讯地址</th>
    <td colspan="3"><input name="address" value="<%=MT.f(t.address)%>"/></td>
    <th>邮编</th>
    <td colspan="2"><input name="postcode" value="<%=MT.f(t.postcode)%>"/></td>
  </tr>
  <tr>
    <th rowspan="2" valign="top">上级主管部门</th>
    <td rowspan="2" colspan="3"><input name="sjdepartment" value="<%=MT.f(t.sjdepartment)%>"/></td>
    <th>办学证件</th>
    <td colspan="2"><input name="bxzj" value="<%=MT.f(t.bxzj)%>"/></td>
  </tr>
  <tr>
    <th>证件号码</th>
    <td colspan="2"><input name="bxzjcode" value="<%=MT.f(t.bxzjcode)%>"/></td>
  </tr>
  <tr>
    <th valign="top" rowspan="2" align='right'>法定代表人</th>
    <th class="th1">姓名</th>
    <th class="th1">性别</th>
    <th class="th1">年龄</th>
    <th class="th1">民族</th>
    <th class="th1">办公电话</th>
    <th class="th1">手机</th>
  </tr>
<%
ArrayList al=LmsPeople.find(" AND lmsorg="+lmsorg+" AND type=1",0,1);
LmsPeople lp=al.size()<1?new LmsPeople(0):(LmsPeople)al.get(0);
%>
  <input type="hidden" name="lmspeople" value="<%=lp.lmspeople%>" />
  <tr>
    <td style='text-align:center'><input name="name_0" value="<%=MT.f(lp.name)%>" size="10"/></td>
    <td style='text-align:center'><select name="sex_0"><%=h.options(LmsPeople.SEX_TYPE,lp.sex)%></select></td>
    <td style='text-align:center'><input name="age_0" value="<%=MT.f(lp.age)%>" size="5" mask="int"/></td>
    <td style='text-align:center'><input name="nation_0" value="<%=MT.f(lp.nation)%>" size="10"/></td>
    <td style='text-align:center'><input name="telphone_0" value="<%=MT.f(lp.telphone)%>" size="10"/></td>
    <td style='text-align:center'><input name="cellphone_0" value="<%=MT.f(lp.cellphone)%>" size="10"/></td>
  </tr>
  <tr>
    <th rowspan="2" valign="top">项目负责人</th>
    <th class="th1">姓名</th>
    <th class="th1">性别</th>
    <th class="th1">年龄</th>
    <th class="th1">民族</th>
    <th class="th1">办公电话</th>
    <th class="th1"><em>*</em>手机</th>
  </tr>
<%
al=LmsPeople.find(" AND lmsorg="+lmsorg+" AND type=2",0,1);
lp=al.size()<1?new LmsPeople(0):(LmsPeople)al.get(0);
%>
  <input type="hidden" name="lmspeople" value="<%=lp.lmspeople%>" />
  <tr>
    <td style='text-align:center'><input name="name_1" value="<%=MT.f(lp.name)%>" size="10"/></td>
    <td style='text-align:center'><select name="sex_1"><%=h.options(LmsPeople.SEX_TYPE,lp.sex)%></select></td>
    <td style='text-align:center'><input name="age_1" value="<%=MT.f(lp.age)%>" size="5" mask="int"/></td>
    <td style='text-align:center'><input name="nation_1" value="<%=MT.f(lp.nation)%>" size="10"/></td>
    <td style='text-align:center'><input name="telphone_1" value="<%=MT.f(lp.telphone)%>" size="10"/></td>
    <td style='text-align:center'><input name="cellphone_1" value="<%=MT.f(lp.cellphone)%>" alt="手机号" size="10"/></td>
  </tr>
  <tr>
    <th>传    真</th>
    <td colspan="3"><input name="fax_1" value="<%=MT.f(lp.fax)%>"/></td>
    <td class="th">Email</td>
    <td colspan="2"><input name="mail_1" value="<%=MT.f(lp.mail)%>"/></td>
    </tr>
  <tr>
    <th rowspan="4" valign="top">主要工作人员</th>
    <th class="th1">姓名</th>
    <th class="th1">性别</th>
    <th class="th1">年龄</th>
    <th class="th1">民族</th>
    <th class="th1">办公电话</th>
    <th class="th1">手机</th>
  </tr>
<%
al=LmsPeople.find(" AND lmsorg="+lmsorg+" AND type=3",0,3);
for(int i=0;i<3;i++)
{
  lp=al.size()<=i?new LmsPeople(0):(LmsPeople)al.get(i);
%>
  <input type="hidden" name="lmspeople" value="<%=lp.lmspeople%>" />
  <tr>
    <td style='text-align:center'><input name="name_<%=i+2%>" value="<%=MT.f(lp.name)%>" size="10"/></td>
    <td style='text-align:center'><select name="sex_<%=i+2%>"><%=h.options(LmsPeople.SEX_TYPE,lp.sex)%></select></td>
    <td style='text-align:center'><input name="age_<%=i+2%>" value="<%=MT.f(lp.age)%>" size="5" mask="int"/></td>
    <td style='text-align:center'><input name="nation_<%=i+2%>" value="<%=MT.f(lp.nation)%>" size="10"/></td>
    <td style='text-align:center'><input name="telphone_<%=i+2%>" value="<%=MT.f(lp.telphone)%>" size="10"/></td>
    <td style='text-align:center'><input name="cellphone_<%=i+2%>" value="<%=MT.f(lp.cellphone)%>" size="10"/></td>
  </tr>
<%
}%>
  <tr>
    <th>现有培训人数</th>
    <th class="th">合计</th>    <td style='text-align:left'><input name="pxtotal" value="<%=MT.f(t.pxtotal)%>" size="10" mask="int"/></td>

    <th class="th">全日制人数</th>
        <td style='text-align:left'><input name="fullnum" value="<%=MT.f(t.fullnum)%>" size="10" mask="int"/></td>

    <th class="th">业余人数</th>
    <td style='text-align:left'><input name="sparenum" value="<%=MT.f(t.sparenum)%>" size="10" mask="int"/></td>
  </tr>
  <tr>
    <th>占地面积</th>
    <td colspan="3"><input name="zdarea" value="<%=MT.f(t.zdarea)%>" mask="float"/> 平方米</td>
    <th>建筑面积</th>
    <td colspan="2"><input name="jzarea" value="<%=MT.f(t.jzarea)%>" mask="float"/> 平方米</td>
  </tr>
  <tr>
    <th>房屋建筑总面积</th>
    <td colspan="6"><input name="fujzarea" value="<%=MT.f(t.fujzarea)%>" mask="float"/> 平方米（教学行政用房 <input name="jxxzarea" value="<%=MT.f(t.jxxzarea)%>" mask="float"/> 平方米，人均 <input name="averagejxarea" value="<%=MT.f(t.averagejxarea)%>" mask="float"/> 平方米）</td>
  </tr>
  <tr>
    <th>图书资料</th>
    <td colspan="3"><input name="booknum" value="<%=MT.f(t.booknum)%>" mask="int"/> 册（人均 <input name="averagebooknum" value="<%=MT.f(t.averagebooknum)%>" mask="float"/> 册）</td>
    <th>图书馆座位数</th>
    <td colspan="2"><input name="seatnum" value="<%=MT.f(t.seatnum)%>" mask="int"/> 个</td>
  </tr>
  <tr>
    <th>计算机</th>
    <td colspan="6"><input name="computernum" value="<%=MT.f(t.computernum)%>" mask="int"/> 台（人均 <input name="averagecomputernum" value="<%=MT.f(t.averagecomputernum)%>" mask="float"/> 台）</td>
  </tr>
  <tr>
    <th>教学仪器设备总值</th>
    <td colspan="6"><input name="jxsbmoney" value="<%=MT.f(t.jxsbmoney)%>" mask="float"/> 万元</td>
  </tr>
  <tr>
    <th>教职工总人数</th>
    <th>教师人数</th>
    <td colspan="2"><input name="teachernum" value="<%=MT.f(t.teachernum)%>" mask="int"/></td>
    <th>管理人员</th>
    <td colspan="2"><input name="managernum" value="<%=MT.f(t.managernum)%>" mask="int"/></td>
  </tr>
  <tr>
    <th valign="top">省助学发展机构简介</th>
    <td colspan="6"><textarea name="description" rows="5" cols="80"><%=MT.f(t.description)%></textarea></td>
  </tr>
  <tr>
    <th><em>*</em>所在地区</th>
    <td colspan="6"><script>mt.city('city1','city2',null,'<%=MT.f(t.city)%>');form1.city1.setAttribute("alt","省");form1.city2.setAttribute("alt","市");</script></td>
  </tr>
  <tr>
    <th>省助学发展机构成立时间</th>
    <td colspan="6"><input name="establish" value="<%=MT.f(t.establish)%>" onClick="mt.date(this)" class="date" readonly /></td>
  </tr>
  <tr>
    <th>首批学生入学时间</th>
    <td colspan="6"><input name="sprxsj" value="<%=MT.f(t.sprxsj)%>" onClick="mt.date(this)" class="date" readonly /></td>
  </tr>
  <tr>
    <th>省助学发展机构网址</th>
    <td colspan="6"><input name="dnsname" value="<%=MT.f(t.dnsname)%>"/></td>
  </tr>
<!--
  <tr>
    <th>状态</th>
    <td><%=h.radios(LmsOrg.ORGSTATUS_TYPE,"orgstatus",t.orgstatus)%></td>
  </tr>
-->
<%--



  <tr>
    <td>forguest</td>
    <td><input name="forguest" value="<%=MT.f(t.forguest)%>"/></td>
  </tr>
  <tr>
    <td>orgno</td>
    <td><input name="orgno" value="<%=MT.f(t.orgno)%>"/></td>
  </tr>
  <tr>
    <td>分类</td>
    <td><%//=h.checks(LmsOrg.ISASP_TYPE,"isasp",t.isasp)%></td>
  </tr>
  <tr>
    <td>传真</td>
    <td><input name="remark1" value="<%=MT.f(t.remark1)%>"/></td>
  </tr>
  <tr>
    <td style='text-align:right'>email</td>
    <td><input name="remark2" value="<%=MT.f(t.remark2)%>"/></td>
  </tr>
  <tr>
    <td>remark3</td>
    <td><input name="remark3" value="<%=MT.f(t.remark3)%>"/></td>
  </tr>
  <tr>
    <td>remark4</td>
    <td><input name="remark4" value="<%=MT.f(t.remark4)%>"/></td>
  </tr>
  <tr>
    <td>电话</td>
    <td><input name="remark5" value="<%=MT.f(t.remark5)%>"/></td>
  </tr>
  <tr>
    <td>startdate</td>
    <td><%=h.selects("startdate",t.startdate)%></td>
  </tr>
  <tr>
    <td>enddate</td>
    <td><%=h.selects("enddate",t.enddate)%></td>
  </tr>
  <tr>
    <td>schoolid</td>
    <td><input name="schoolid" value="<%=MT.f(t.schoolid)%>"/></td>
  </tr>
  <tr>
    <td>logo</td>
    <td><input name="logo" value="<%=MT.f(t.logo)%>"/></td>
  </tr>
  <tr>
    <td>regdate</td>
    <td><%=h.selects("regdate",t.regdate)%></td>
  </tr>
  <tr>
    <td>ischeck</td>
    <td><input name="ischeck" value="<%=MT.f(t.ischeck)%>"/></td>
  </tr>

  <tr>
    <td>billprice</td>
    <td><input name="billprice" value="<%=MT.f(t.billprice)%>"/></td>
  </tr>
  <tr>
    <td>通讯地址/邮编</td>
    <td><input name="txpostcode" value="<%=MT.f(t.txpostcode)%>"/></td>
  </tr>
  <tr>
    <td>222</td>
    <td><input name="aa" value="<%=MT.f(t.aa)%>"/></td>
  </tr>
  <tr>
    <td>zgtotal</td>
    <td><input name="zgtotal" value="<%=MT.f(t.zgtotal)%>"/></td>
  </tr>
  <tr>
    <td>局域网速是否达到100m</td>
    <td><input name="remark11" value="<%=MT.f(t.remark11)%>"/></td>
  </tr>
  <tr>
    <td>宽带是否达到2m</td>
    <td><input name="remark12" value="<%=MT.f(t.remark12)%>"/></td>
  </tr>
  <tr>
    <td>上网平均速率能否达到32k</td>
    <td><input name="remark13" value="<%=MT.f(t.remark13)%>"/></td>
  </tr>
  <tr>
    <td>可容纳50人以下多少间</td>
    <td><input name="remark14" value="<%=MT.f(t.remark14)%>"/></td>
  </tr>
  <tr>
    <td>可容纳五十人以上多少间</td>
    <td><input name="remark15" value="<%=MT.f(t.remark15)%>"/></td>
  </tr>
--%>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onClick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
