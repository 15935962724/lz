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
<h1>查看省助学发展机构</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1">
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
    <th>省助学发展机构名称</th>
    <td colspan="6"><%=MT.f(t.orgname)%></td>
  </tr>
  <tr>
    <th>授权省</th>
    <td colspan="6"><script>mt.city('<%=MT.f(t.member)%>');</script></td>
  </tr>
  <tr>
    <th>类型</th>
    <td colspan="6"><%=LmsOrg.ORGTYPE_TYPE[t.orgtype]%></td>
  </tr>
  <tr>
    <th>通讯地址</th>
    <td colspan="3"><%=MT.f(t.address)%></td>
    <th>邮编</th>
    <td colspan="2"><%=MT.f(t.postcode)%></td>
  </tr>
  <tr>
    <th rowspan="2" valign="top">上级主管部门</th>
    <td rowspan="2" colspan="3"><%=MT.f(t.sjdepartment)%></td>
    <th>办学证件</th>
    <td colspan="2"><%=MT.f(t.bxzj)%></td>
  </tr>
  <tr>
    <th>证件号码</th>
    <td colspan="2"><%=MT.f(t.bxzjcode)%></td>
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
    <td style='text-align:center'><%=MT.f(lp.name)%></td>
    <td style='text-align:center'><%=LmsPeople.SEX_TYPE[lp.sex]%></td>
    <td style='text-align:center'><%=MT.f(lp.age)%></td>
    <td style='text-align:center'><%=MT.f(lp.nation)%></td>
    <td style='text-align:center'><%=MT.f(lp.telphone)%></td>
    <td style='text-align:center'><%=MT.f(lp.cellphone)%></td>
  </tr>
  <tr>
    <th rowspan="2" valign="top">项目负责人</th>
    <th class="th1">姓名</th>
    <th class="th1">性别</th>
    <th class="th1">年龄</th>
    <th class="th1">民族</th>
    <th class="th1">办公电话</th>
    <th class="th1">手机</th>
  </tr>
<%
al=LmsPeople.find(" AND lmsorg="+lmsorg+" AND type=2",0,1);
lp=al.size()<1?new LmsPeople(0):(LmsPeople)al.get(0);
%>
  <input type="hidden" name="lmspeople" value="<%=lp.lmspeople%>" />
  <tr>
    <td style='text-align:center'><%=MT.f(lp.name)%></td>
    <td style='text-align:center'><%=LmsPeople.SEX_TYPE[lp.sex]%></td>
    <td style='text-align:center'><%=MT.f(lp.age)%></td>
    <td style='text-align:center'><%=MT.f(lp.nation)%></td>
    <td style='text-align:center'><%=MT.f(lp.telphone)%></td>
    <td style='text-align:center'><%=MT.f(lp.cellphone)%></td>
  </tr>
  <tr>
    <th>传    真</th>
    <td colspan="3"><%=MT.f(lp.fax)%></td>
    <td class="th">Email</td>
    <td colspan="2"><%=MT.f(lp.mail)%></td>
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
    <td style='text-align:center'><%=MT.f(lp.name)%></td>
    <td style='text-align:center'><%=LmsPeople.SEX_TYPE[lp.sex]%></td>
    <td style='text-align:center'><%=MT.f(lp.age)%></td>
    <td style='text-align:center'><%=MT.f(lp.nation)%></td>
    <td style='text-align:center'><%=MT.f(lp.telphone)%></td>
    <td style='text-align:center'><%=MT.f(lp.cellphone)%></td>
  </tr>
<%
}%>
  <tr>
    <th>现有培训人数</th>
    <th class="th">合计</th>    <td style='text-align:left'><%=MT.f(t.pxtotal)%></td>

    <th class="th">全日制人数</th>
        <td style='text-align:left'><%=MT.f(t.fullnum)%></td>

    <th class="th">业余人数</th>
    <td style='text-align:left'><%=MT.f(t.sparenum)%></td>
  </tr>
  <tr>
    <th>占地面积</th>
    <td colspan="3"><%=MT.f(t.zdarea)%> 平方米</td>
    <th>建筑面积</th>
    <td colspan="2"><%=MT.f(t.jzarea)%> 平方米</td>
  </tr>
  <tr>
    <th>房屋建筑总面积</th>
    <td colspan="6"><%=MT.f(t.fujzarea)%> 平方米（教学行政用房 <%=MT.f(t.jxxzarea)%> 平方米，人均 <%=MT.f(t.averagejxarea)%> 平方米）</td>
  </tr>
  <tr>
    <th>图书资料</th>
    <td colspan="3"><%=MT.f(t.booknum)%> 册（人均 <%=MT.f(t.averagebooknum)%> 册）</td>
    <th>图书馆座位数</th>
    <td colspan="2"><%=MT.f(t.seatnum)%> 个</td>
  </tr>
  <tr>
    <th>计算机</th>
    <td colspan="6"><%=MT.f(t.computernum)%> 台（人均 <%=MT.f(t.averagecomputernum)%> 台）</td>
  </tr>
  <tr>
    <th>教学仪器设备总值</th>
    <td colspan="6"><%=MT.f(t.jxsbmoney)%> 万元</td>
  </tr>
  <tr>
    <th>教职工总人数</th>
    <th>教师人数</th>
    <td colspan="2"><%=MT.f(t.teachernum)%></td>
    <th>管理人员</th>
    <td colspan="2"><%=MT.f(t.managernum)%></td>
  </tr>
  <tr>
    <th valign="top">省助学发展机构简介</th>
    <td colspan="6"><%=MT.f(t.description).replace("\r\n","<br/>")%></td>
  </tr>
  <tr>
    <th>所在地区</th>
    <td colspan="6"><script>mt.city('<%=MT.f(t.city)%>');</script></td>
  </tr>
  <tr>
    <th>省助学发展机构成立时间</th>
    <td colspan="6"><%=MT.f(t.establish)%></td>
  </tr>
  <tr>
    <th>首批学生入学时间</th>
    <td colspan="6"><%=MT.f(t.sprxsj)%></td>
  </tr>
  <tr>
    <th>省助学发展机构网址</th>
    <td colspan="6"><%=MT.f(t.dnsname)%></td>
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
<input type="button" value="返回" onClick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
