<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

LmsOrg t=LmsOrg.find(Integer.parseInt(MT.dec(h.get("lmsorg"))));
LmsWork lw=LmsWork.find(t.lmsorg);


%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
</head>
<body>
<h1>查看学习服务中心</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1">


<table id="tablecenter" cellspacing="0" class='alignLeft'>
<!--
  <tr>
    <td>aspid</td>
    <td colspan="3"><input name="aspid" value="<%=MT.f(t.aspid)%>"/></td>
  </tr>
  <tr>
    <td>layer</td>
    <td colspan="3"><input name="layer" value="<%=MT.f(t.layer)%>"/></td>
  </tr>
-->
  <tr>
    <td rowspan="11" style='text-align:center'>申<br>请<br>单<br>位<br>基<br>本<br>信<br>息</td>
	<td class="th">承办机构编号</td>
    <td colspan="7"><%=MT.f(t.orgno,"编号系统自动生成")%></td>
  </tr>
  <tr>
    <td class="th">单位名称</td>
    <td colspan="2"><%=MT.f(t.orgname)%></td>
    <td class="th">网站地址</td>
    <td colspan="3"><%=MT.f(t.dnsname)%></td>
  </tr>
  <tr>
    <td class="th" colspan="2">是否已在省考办办理自学考试助学机构备案</td>
    <td colspan="6"><%=Lms.YES_NO[t.record]%></td>
  </tr>
  <tr>
    <td class="th">单位性质</td>
    <td colspan="4"><%=LmsOrg.ORGTYPE_TYPE0[t.orgtype]%></td>
  </tr>
  <tr>
    <td class="th">现有在校生人数</td>
    <td colspan="7">全日制在校人数 <%=MT.f(t.fullnum)%> 人,非全日制在校人数 <%=MT.f(t.sparenum)%> 人</td>
  </tr>
  <tr>
    <td class="th">现有分支培训机构数量</td>
    <td colspan="7"><%=LmsOrg.BRANCH_TYPE[t.branch]%></td>
  </tr>
  <tr>
    <td class="th">注册地区</td>
    <td colspan="7"><script>mt.city('<%=MT.f(t.city)%>');</script>　主考院校: --</td>
  </tr>
  <tr>
    <td class="th">注册地址</td>
    <td colspan="2"><%=MT.f(t.raddress)%></td>
    <td class="th" rowspan="2">办学许可证</td>
    <td class="th">批准部门</td>
    <td colspan="3"><%=MT.f(t.sjdepartment)%></td>
  </tr>
  <tr>
    <td class="th">邮政编码</td>
    <td colspan="2"><%=MT.f(t.rpostcode)%></td>
    <td class="th">证件号码</td>
    <td colspan="4"><%=MT.f(t.bxzjcode)%></td>
  </tr>
  <tr>
    <td class="th">通讯地址</td>
    <td colspan="2"><%=MT.f(t.address)%></td>
    <td class="th">电话</td>
    <td colspan="4"><%=MT.f(t.tel)%></td>
  </tr>
  <tr>
    <td class="th">邮政编码</td>
    <td colspan="2"><%=MT.f(t.postcode)%></td>
    <td class="th">传真</td>
    <td colspan="4"><%=MT.f(t.fax)%></td>
  </tr>

<%
ArrayList al=LmsPeople.find(" AND lmsorg="+t.lmsorg+" AND type=1",0,1);
LmsPeople lp=al.size()<1?new LmsPeople(0):(LmsPeople)al.get(0);
%>
  <input type="hidden" name="lmspeople" value="<%=lp.lmspeople%>" />
  <tr>
    <td rowspan="4" style="text-align:center">申<br>请<br>单<br>位<br>负<br>责<br>人</td>
    <td class="th" valign="top" rowspan="2">法定代表人（或法定代表）</td>
    <td class="th">姓名</td><td><%=MT.f(lp.name)%></td>
    <td class="th">性别</td><td><%=LmsPeople.SEX_TYPE[lp.sex]%></td>
    <td class="th">出生年月</td><td><%=MT.f(lp.brithday)%></td>
  </tr>
  <tr>
    <td class="th">办公电话</td><td><%=MT.f(lp.telphone)%></td>
    <td class="th">手机号</td><td><%=MT.f(lp.cellphone)%></td>
    <td class="th">电子邮箱</td><td><%=MT.f(lp.mail)%></td>
  </tr>
<%
al=LmsPeople.find(" AND lmsorg="+t.lmsorg+" AND type=2",0,1);
lp=al.size()<1?new LmsPeople(0):(LmsPeople)al.get(0);
%>
  <input type="hidden" name="lmspeople" value="<%=lp.lmspeople%>" />
  <tr>
    <td class="th" valign="top" rowspan="2">项目负责人</td>
    <td class="th">姓名</td><td><%=MT.f(lp.name)%></td>
    <td class="th">性别</td><td><%=LmsPeople.SEX_TYPE[lp.sex]%></td>
    <td class="th">出生年月</td><td><%=MT.f(lp.brithday)%></td>
  </tr>
  <tr>
    <td class="th">办公电话</td><td><%=MT.f(lp.telphone)%></td>
    <td class="th">手机号</td><td><%=MT.f(lp.cellphone)%></td>
    <td class="th">电子邮箱</td><td><%=MT.f(lp.mail)%></td>
  </tr>
  <tr>
    <td rowspan="6" style="text-align:center">申<br>请<br>单<br>位<br>教<br>学<br>资<br>源<br>情<br>况</td>
    <td class="th">教学场地情况</td>
    <td class="th">房屋建筑总面积</td>
    <td><%=MT.f(t.fujzarea)%> 平方米</td><td  class="th">教学用房</td><td colspan='3'><%=MT.f(t.jxxzarea)%> 平方米</td>
  </tr>
  <tr>
	<td class="th" valign="top" rowspan="5">教学设备情况</td>
	<td class="th">计算机数量</td>
    <td colspan='5'><%=LmsOrg.COMPUTER_NUM[t.computernum]%></td>
  </tr>
  <tr>
    <td class="th" valign="top" rowspan="3">网络连接条件</td>
    <td colspan="2">局域网速是否达到100M</td>
    <td colspan='5'><%=Lms.YES_NO[t.lan]%></td>
  </tr>
  <tr>
    <td colspan="2">宽带是否达到2M</td>
    <td colspan='6'><%=Lms.YES_NO[t.adsl]%></td>
  </tr>
  <tr>
    <td colspan="2">单机上网平均速率能否达到32K bps以上<br/>（访问国内网站下行速率在56K bps以上）</td>
    <td colspan='6'><%=Lms.YES_NO[t.speed]%></td>
  </tr>
  <tr>
    <td class="th">多媒体教室情况</td>
    <td colspan='7'>具有投影仪、影音设备、计算机等教学设备的教室可容纳50人以下 <%=MT.f(t.classroom1)%> 间，可容纳五十人以上<%=MT.f(t.classroom2)%> 间</td>
  </tr>
  <tr>
    <td colspan="8">计划开展中小企业经理人证书考试项目情况</td>
  </tr>
  <tr>
    <td></td>
	<td class="th">计划招生层次</td>
    <td><%=t.specialized?"专科":""%>　<%=t.undergraduate?"本科":""%></td>
    <td>计划招生人数（年）</td>
    <td colspan="4">专科 <%=MT.f(t.specializednum)%> 人，本科 <%=MT.f(t.undergraduatenum)%> 人</td>
  </tr>
   <tr>
    <td></td>
	<td class="th">计划设置项目办公室面积</td>
    <td colspan="6"><%=MT.f(t.zdarea)%></td>
  </tr>
</table>

<table id="tablecenter" cellspacing="0" class='alignLeft'>
  <tr>
    <td rowspan="21" style="text-align:center">计<BR>划<BR>承<BR>担<BR>的<BR>工<BR>作</td>
    <th style="text-align:center">类别</td>
    <th style="text-align:center">序号</td>
    <th style="text-align:center">环节</td>
    <th style="text-align:center">是否承担</td>
  </tr>
  <tr>
    <td rowspan="11" style="text-align:center">教务<br/>
      管理<br/>
      工作</td>
    <td>（1）</td>
    <td>证书课程学籍管理</td>
    <td><%=Lms.YES_NO[lw.isinschool]%></td>
  </tr>
  <tr>
    <td>（2）</td>
    <td>排课及调课</td>
    <td><%=Lms.YES_NO[lw.isadmincourse]%></td>
  </tr>
  <tr>
    <td>（3）</td>
    <td>网上选课</td>
    <td><%=Lms.YES_NO[lw.isonlinecourse]%></td>
  </tr>
  <tr>
    <td>（4）</td>
    <td>报考管理</td>
    <td><%=Lms.YES_NO[lw.isregistration]%></td>
  </tr>
  <tr>
    <td>（5）</td>
    <td>准考证及考试通知单的发放</td>
    <td><%=Lms.YES_NO[lw.isexnotice]%></td>
  </tr>
  <tr>
    <td>（6）</td>
    <td>免考管理</td>
    <td><%=Lms.YES_NO[lw.isexamption]%></td>
  </tr>
  <tr>
    <td>（7）</td>
    <td>教材管理</td>
    <td><%=Lms.YES_NO[lw.isteach]%></td>
  </tr>
  <tr>
    <td>（8）</td>
    <td>毕业论文的管理</td>
    <td><%=Lms.YES_NO[lw.isthepaper]%></td>
  </tr>
  <tr>
    <td>（9）</td>
    <td>学位英语考试管理</td>
    <td><%=Lms.YES_NO[lw.isenglish]%></td>
  </tr>
  <tr>
    <td>（10）</td>
    <td>证书的办理</td>
    <td><%=Lms.YES_NO[lw.iscertificate]%></td>
  </tr>
  <tr>
    <td>（11）</td>
    <td>教学设备的管理及维护</td>
    <td><%=Lms.YES_NO[lw.isequipment]%></td>
  </tr>
  <tr>
    <td rowspan="5" style="text-align:center">学生<br/>
      管理<br/>
      工作</td>
    <td>（1）</td>
    <td>班级管理</td>
    <td><%=Lms.YES_NO[lw.isclass]%></td>
  </tr>
  <tr>
    <td>（2）</td>
    <td>督促学生学习</td>
    <td><%=Lms.YES_NO[lw.isstudy]%></td>
  </tr>
  <tr>
    <td>（3）</td>
    <td>组织学员参加实践环节考核</td>
    <td><%=Lms.YES_NO[lw.ispractice]%></td>
  </tr>
  <tr>
    <td>（4）</td>
    <td>教学效果的考核</td>
    <td><%=Lms.YES_NO[lw.isteaching]%></td>
  </tr>
  <tr>
    <td>（5）</td>
    <td>安全管理</td>
    <td><%=Lms.YES_NO[lw.issafety]%></td>
  </tr>
  <tr>
    <td rowspan="3" style="text-align:center">教学<br/>
      管理<br/>
      工作</td>
    <td>（1）</td>
    <td>操作指导</td>
    <td><%=Lms.YES_NO[lw.isoperation]%></td>
  </tr>
  <tr>
    <td>（2）</td>
    <td>课程辅导</td>
    <td><%=Lms.YES_NO[lw.iscoach]%></td>
  </tr>
  <tr>
    <td>（3）</td>
    <td>实践环节考核辅导</td>
    <td><%=Lms.YES_NO[lw.ispracticecoach]%></td>
  </tr>
  <tr>
    <td style="text-align:center">财务<br/>
      管理<br/>
      工作</td>
    <td>（1）</td>
    <td>开具培训费发票</td>
    <td><%=Lms.YES_NO[lw.isinvoice]%></td>
  </tr>
</table>


<br/>
<input type="button" value="返回" onClick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
