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
  t.record=1;
  t.orgtype=1;
  t.branch=1;
}
LmsWork lw=LmsWork.find(t.lmsorg);


%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
</head>
<body>
<h1><%=t.lmsorg<1?"添加":"编辑"%>学习服务中心</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/LmsOrgs.do" method="post" enctype="multipart/form-data" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmsorg" value="<%=key%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="father" value="<%=t.father%>"/>
<input type="hidden" name="isasp" value="<%=t.isasp%>"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

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
    <td class="th"><em>*</em>单位名称</td>
    <td colspan="2"><input name="orgname" value="<%=MT.f(t.orgname)%>" size="40" alt="单位名称"/></td>
    <td class="th">网站地址</td>
    <td colspan="3"><input name="dnsname" value="<%=MT.f(t.dnsname)%>"/></td>
  </tr>
  <tr>
    <td class="th" colspan="2"><em>*</em>是否已在省考办办理自学考试助学机构备案</td>
    <td colspan="6"><%=h.radios(Lms.YES_NO,"record",t.record)%></td>
  </tr>
  <tr>
    <td class="th"><em>*</em>单位性质</td>
    <td colspan="4"><%=h.radios(LmsOrg.ORGTYPE_TYPE0,"orgtype",t.orgtype)%></td>
  </tr>
  <tr>
    <td class="th"><em>*</em>现有在校生人数</td>
    <td colspan="7">全日制在校人数 <input name="fullnum" value="<%=MT.f(t.fullnum)%>" size="10" mask="int"/> 人,非全日制在校人数 <input name="sparenum" value="<%=MT.f(t.sparenum)%>" size="10" mask="int"/> 人</td>
  </tr>
  <tr>
    <td class="th"><em>*</em>现有分支培训机构数量</td>
    <td colspan="7"><%=h.radios(LmsOrg.BRANCH_TYPE,"branch",t.branch)%></td>
  </tr>
  <tr>
    <td class="th"><em>*</em>注册地区</td>
    <td colspan="7"><script>mt.city('city1','city2',null,'<%=MT.f(t.city)%>');form1.city1.setAttribute("alt","省");form1.city2.setAttribute("alt","市");</script> 主考院校: <select name="schoolid"><option value="">--</option></select></td>
  </tr>
  <tr>
    <td class="th">注册地址</td>
    <td colspan="2"><input name="raddress" value="<%=MT.f(t.raddress)%>"/></td>
    <td class="th" rowspan="2">办学许可证</td>
    <td class="th">批准部门</td>
    <td colspan="3"><input name="sjdepartment" value="<%=MT.f(t.sjdepartment)%>"/></td>
  </tr>
  <tr>
    <td class="th">邮政编码</td>
    <td colspan="2"><input name="rpostcode" value="<%=MT.f(t.rpostcode)%>"/></td>
    <td class="th">证件号码</td>
    <td colspan="4"><input name="bxzjcode" value="<%=MT.f(t.bxzjcode)%>"/></td>
  </tr>
  <tr>
    <td class="th">通讯地址</td>
    <td colspan="2"><input name="address" value="<%=MT.f(t.address)%>"/></td>
    <td class="th">电话</td>
    <td colspan="4"><input name="tel" value="<%=MT.f(t.tel)%>"/></td>
  </tr>
  <tr>
    <td class="th">邮政编码</td>
    <td colspan="2"><input name="postcode" value="<%=MT.f(t.postcode)%>"/></td>
    <td class="th">传真</td>
    <td colspan="4"><input name="fax" value="<%=MT.f(t.fax)%>"/></td>
  </tr>

<%
ArrayList al=LmsPeople.find(" AND lmsorg="+lmsorg+" AND type=1",0,1);
LmsPeople lp=al.size()<1?new LmsPeople(0):(LmsPeople)al.get(0);
%>
  <input type="hidden" name="lmspeople" value="<%=lp.lmspeople%>" />
  <tr>
    <td rowspan="4" style="text-align:center">申<br>请<br>单<br>位<br>负<br>责<br>人</td>
    <td class="th" valign="top" rowspan="2">法定代表人（或法定代表）</td>
    <td class="th"><em>*</em>姓名</td><td><input name="name_0" value="<%=MT.f(lp.name)%>" alt="姓名"/></td>
    <td class="th"><em>*</em>性别</td><td><select name="sex_0" alt="性别"><%=h.options(LmsPeople.SEX_TYPE,lp.sex)%></select></td>
    <td class="th">出生年月</td><td><input name="brithday_0" value="<%=MT.f(lp.brithday)%>" onClick="mt.date(this)" class="date" readonly /></td>
  </tr>
  <tr>
    <td class="th">办公电话</td><td><input name="telphone_0" value="<%=MT.f(lp.telphone)%>"/></td>
    <td class="th"><em>*</em>手机号</td><td><input name="cellphone_0" value="<%=MT.f(lp.cellphone)%>" alt="手机号"/></td>
    <td class="th"><em>*</em>电子邮箱</td><td><input name="mail_0" value="<%=MT.f(lp.mail)%>" alt="电子邮箱"/></td>
  </tr>
<%
al=LmsPeople.find(" AND lmsorg="+lmsorg+" AND type=2",0,1);
lp=al.size()<1?new LmsPeople(0):(LmsPeople)al.get(0);
%>
  <input type="hidden" name="lmspeople" value="<%=lp.lmspeople%>" />
  <tr>
    <td class="th" valign="top" rowspan="2">项目负责人</td>
    <td class="th"><em>*</em>姓名</td><td><input name="name_1" value="<%=MT.f(lp.name)%>" alt="姓名"/></td>
    <td class="th"><em>*</em>性别</td><td><select name="sex_1" alt="性别"><%=h.options(LmsPeople.SEX_TYPE,lp.sex)%></select></td>
    <td class="th">出生年月</td><td><input name="brithday_1" value="<%=MT.f(lp.brithday)%>" onClick="mt.date(this)" class="date" readonly /></td>
  </tr>
  <tr>
    <td class="th">办公电话</td><td><input name="telphone_1" value="<%=MT.f(lp.telphone)%>"/></td>
    <td class="th"><em>*</em>手机号</td>
    <td><input name="cellphone_1" value="<%=MT.f(lp.cellphone)%>" alt="手机号"/></td>
    <td class="th"><em>*</em>电子邮箱</td><td><input name="mail_1" value="<%=MT.f(lp.mail)%>" alt="电子邮箱"/></td>
  </tr>
  <tr>
    <td rowspan="6" style="text-align:center">申<br>请<br>单<br>位<br>教<br>学<br>资<br>源<br>情<br>况</td>
    <td class="th">教学场地情况</td>
    <td class="th">房屋建筑总面积</td>
    <td><input name="fujzarea" value="<%=MT.f(t.fujzarea)%>" mask="float"/> 平方米</td><td  class="th">教学用房</td><td colspan='3'><input name="jxxzarea" value="<%=MT.f(t.jxxzarea)%>" mask="float"/> 平方米</td>
  </tr>
  <tr>
	<td class="th" valign="top" rowspan="5">教学设备情况</td>
	<td class="th">计算机数量</td>
    <td colspan='5'><%=h.radios(LmsOrg.COMPUTER_NUM,"computernum",t.computernum)%></td>
  </tr>
  <tr>
    <td class="th" valign="top" rowspan="3">网络连接条件</td>
    <td colspan="2">局域网速是否达到100M</td>
    <td colspan='5'><%=h.radios(Lms.YES_NO,"lan",t.lan)%></td>
  </tr>
  <tr>
    <td colspan="2">宽带是否达到2M</td>
    <td colspan='6'><%=h.radios(Lms.YES_NO,"adsl",t.adsl)%></td>
  </tr>
  <tr>
    <td colspan="2">单机上网平均速率能否达到32K bps以上<br/>（访问国内网站下行速率在56K bps以上）</td>
    <td colspan='6'><%=h.radios(Lms.YES_NO,"speed",t.speed)%></td>
  </tr>
  <tr>
    <td class="th">多媒体教室情况</td>
    <td colspan='7'>具有投影仪、影音设备、计算机等教学设备的教室可容纳50人以下 <input name="classroom1" value="<%=MT.f(t.classroom1)%>" size="10" mask="int"/> 间，可容纳五十人以上<input name="classroom2" value="<%=MT.f(t.classroom2)%>" size="10" mask="int"/> 间</td>
  </tr>
  <tr>
    <td colspan="8">计划开展中小企业经理人证书考试项目情况</td>
  </tr>
  <tr>
    <td></td>
	<td class="th">计划招生层次</td>
    <td><input type="checkbox" name="specialized" <%=t.specialized?"checked":""%> id="_specialized" /><label for="_specialized">专科</label>　<input type="checkbox" name="undergraduate" <%=t.undergraduate?"checked":""%> id="_undergraduate" /><label for="_undergraduate">本科</label></td>
    <td>计划招生人数（年）</td>
    <td colspan="4">专科 <input name="specializednum" value="<%=MT.f(t.specializednum)%>" size="10" mask="int"/> 人，本科 <input name="undergraduatenum" value="<%=MT.f(t.undergraduatenum)%>" size="10" mask="int"/> 人</td>
  </tr>
   <tr>
    <td></td>
	<td class="th">计划设置项目办公室面积</td>
    <td colspan="6"><input name="zdarea" value="<%=MT.f(t.zdarea)%>" size="10" mask="float"/></td>
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
    <td><%=h.radios(Lms.YES_NO,"isinschool",lw.isinschool)%></td>
  </tr>
  <tr>
    <td>（2）</td>
    <td>排课及调课</td>
    <td><%=h.radios(Lms.YES_NO,"isadmincourse",lw.isadmincourse)%></td>
  </tr>
  <tr>
    <td>（3）</td>
    <td>网上选课</td>
    <td><%=h.radios(Lms.YES_NO,"isonlinecourse",lw.isonlinecourse)%></td>
  </tr>
  <tr>
    <td>（4）</td>
    <td>报考管理</td>
    <td><%=h.radios(Lms.YES_NO,"isregistration",lw.isregistration)%></td>
  </tr>
  <tr>
    <td>（5）</td>
    <td>准考证及考试通知单的发放</td>
    <td><%=h.radios(Lms.YES_NO,"isexnotice",lw.isexnotice)%></td>
  </tr>
  <tr>
    <td>（6）</td>
    <td>免考管理</td>
    <td><%=h.radios(Lms.YES_NO,"isexamption",lw.isexamption)%></td>
  </tr>
  <tr>
    <td>（7）</td>
    <td>教材管理</td>
    <td><%=h.radios(Lms.YES_NO,"isteach",lw.isteach)%></td>
  </tr>
  <tr>
    <td>（8）</td>
    <td>毕业论文的管理</td>
    <td><%=h.radios(Lms.YES_NO,"isthepaper",lw.isthepaper)%></td>
  </tr>
  <tr>
    <td>（9）</td>
    <td>学位英语考试管理</td>
    <td><%=h.radios(Lms.YES_NO,"isenglish",lw.isenglish)%></td>
  </tr>
  <tr>
    <td>（10）</td>
    <td>证书的办理</td>
    <td><%=h.radios(Lms.YES_NO,"iscertificate",lw.iscertificate)%></td>
  </tr>
  <tr>
    <td>（11）</td>
    <td>教学设备的管理及维护</td>
    <td><%=h.radios(Lms.YES_NO,"isequipment",lw.isequipment)%></td>
  </tr>
  <tr>
    <td rowspan="5" style="text-align:center">学生<br/>
      管理<br/>
      工作</td>
    <td>（1）</td>
    <td>班级管理</td>
    <td><%=h.radios(Lms.YES_NO,"isclass",lw.isclass)%></td>
  </tr>
  <tr>
    <td>（2）</td>
    <td>督促学生学习</td>
    <td><%=h.radios(Lms.YES_NO,"isstudy",lw.isstudy)%></td>
  </tr>
  <tr>
    <td>（3）</td>
    <td>组织学员参加实践环节考核</td>
    <td><%=h.radios(Lms.YES_NO,"ispractice",lw.ispractice)%></td>
  </tr>
  <tr>
    <td>（4）</td>
    <td>教学效果的考核</td>
    <td><%=h.radios(Lms.YES_NO,"isteaching",lw.isteaching)%></td>
  </tr>
  <tr>
    <td>（5）</td>
    <td>安全管理</td>
    <td><%=h.radios(Lms.YES_NO,"issafety",lw.issafety)%></td>
  </tr>
  <tr>
    <td rowspan="3" style="text-align:center">教学<br/>
      管理<br/>
      工作</td>
    <td>（1）</td>
    <td>操作指导</td>
    <td><%=h.radios(Lms.YES_NO,"isoperation",lw.isoperation)%></td>
  </tr>
  <tr>
    <td>（2）</td>
    <td>课程辅导</td>
    <td><%=h.radios(Lms.YES_NO,"iscoach",lw.iscoach)%></td>
  </tr>
  <tr>
    <td>（3）</td>
    <td>实践环节考核辅导</td>
    <td><%=h.radios(Lms.YES_NO,"ispracticecoach",lw.ispracticecoach)%></td>
  </tr>
  <tr>
    <td style="text-align:center">财务<br/>
      管理<br/>
      工作</td>
    <td>（1）</td>
    <td>开具培训费发票</td>
    <td><%=h.radios(Lms.YES_NO,"isinvoice",lw.isinvoice)%></td>
  </tr>
</table>


<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onClick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
