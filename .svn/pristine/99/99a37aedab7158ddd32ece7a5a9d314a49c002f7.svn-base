<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.taoism.Taoism"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String key=h.get("member");//null:自已  空字符串:添加
Profile t=Profile.find(key==null?h.member:key.length()<1?0:Integer.parseInt(MT.dec(key)));
String photo=t.getPhotopath(h.language);
boolean isEdit=t.getType()==0||"debug".equals(h.get("act"));

%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
</head>
<body>
<h1><%=t.profile<1?"添加":"编辑"%>学员信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form2" action="/LmsMembers.do?repository=student/photo" method="post" enctype="multipart/form-data" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<%
if(key!=null)out.print("<input type='hidden' name='member' value='"+key+"' />");

if(isEdit)
{
%>
<h2>基本信息</h2>
<table id="tablecenter" cellspacing="0" class="alignLeft">
  <tr>
    <th width="130"><em>*</em>用 户 名:</th>
    <td><%=t.profile<1?"学号系统自动生成。生成规则:学生所在学习服务中心编号(8位)+入学年份(后2位)+数字依次增加(5位)":t.getMember()%></td>
    <td rowspan="<%=t.profile<1?10:8%>" class="tright" align="center"><div class="picc"><img name="_photopath" src="<%=MT.f(photo,"/tea/image/avatar.gif")%>?max-age=0" width="144" height="192"/></div>
      <br/>
      <input type="file" name="photopath" accept="image/jpeg" <%=photo==null?"alt":"_alt"%>="照片" onchange="form2._photopath.src=value"/>
    </td>
  </tr>
<%
if(t.profile<1)
{
%>
  <tr>
    <th><em>*</em>密　　码:</th>
    <td>密码系统自动生成。生成规则:smebs+证件号后6位。</td>
  </tr>
  <tr>
    <script src="/jsp/lms/lms.js" type="text/javascript"></script>
    <%=Lms.query(h,null,null,true)%>
  </tr>
<%
}else
{%>
  <tr>
    <th><em>*</em>学习服务中心:</th>
    <td><%=MT.f(LmsOrg.find(t.getAgent()).orgname)%></td>
  </tr>
<%
}%>
  <tr>
    <th><em>*</em>姓　　名:</th>
    <td><input name="name" value="<%=t.getName(h.language)%>" alt="姓名"/> <span class="info">请填写真实姓名，此字段将用于学籍管理</span></td>
  </tr>
  <tr>
    <th><em>*</em>性　　别:</th>
    <td><select name="sex" alt="性别">
        <option value="1"<%=t.isSex()?" selected":""%>>男</option>
        <option value="0"<%=t.isSex()?"":" selected"%>>女</option>
      </select>
      <span class="info">请选择性别</span></td>
  </tr>
  <tr>
    <th><em>*</em>出生日期:</th>
    <td><input name="birth" value="<%=MT.f(t.getBirth())%>" onclick="mt.date(this)" alt="出生日期" class="date" readonly> <span class="info">请填写出生日期,以身份证为准</font></td>
  </tr>
  <tr>
    <th><em>*</em>民　　族:</th>
    <td><select name="zzracky" alt="民族" >
    <%
    for(int i=0;i<Taoism.ETHNIC.length;i++)
    {
      out.print("<option value='"+(i<1?"":Taoism.ETHNIC[i])+"'");
      if(Taoism.ETHNIC[i].equals(t.getZzracky()))out.print(" selected");
      out.print(">"+Taoism.ETHNIC[i]);
    }
    %></select> <span class="info">请选择民族</span></td>
  </tr>
  <tr>
    <th><em>*</em>政治面貌:</th>
    <td><select name="polity" alt="政治面貌"><%=h.options(Lms.POLITY_TYPE,t.getPolity())%></select> <span class="info">请选择政治面貌</span> </td>
  </tr>
  <tr>
    <th><em>*</em>证件类型:</th>
    <td><select name="cardtype" alt="证件类型"><%=h.options(Lms.CARD_TYPE,t.getCardType())%></select></td>
  </tr>
  <tr>
    <th><em>*</em>证件号码:</th>
    <td><input name="card" value="<%=t.getCard()%>" size="40" alt="证件号码"/>
      <span class="info">请填写真实证件号码，此字段将用于学籍管理。<br />身份证格式：110101198911062316。军官证、士官证格式：军字第10064757</span>
    </td>
    <td width="220" align="center" rowspan="7" valign="top">1、学籍注册时提交的照片一律为学生本人近期正面免冠照片，且必须与纸质材料上粘贴的照片一致；<br/>
        2、格式：文件格式为：jpg，大小不超过50k，不符合规格无法上传；<br/>
        3、命名：以证件号码命名。（如证件类型为身份证，命名为622225190912121611； 证件类型是军官证、护照、港澳通行证或者其他，证件号码中包含的数字或者字母、中文不可省略。例如证件类型为军官证，命名为 军字第10068924；证件类型为护照，命名为G50624859。以此类推。）<br/>
        4、背景：单一白色；<br/>
        5、取景：成像区上下要求头上部空1/10，头部占7/10，肩部占1/5，左右各空1/10。采集的图像像素大小为192×144（高×宽）。成像区大小为4.8厘米×3.3厘米（高×宽）。<br/>
      </td>
  </tr>
  <tr>
    <th><em>*</em>籍　　贯:</th>
    <td><script>mt.city("jcity",null,null,"<%=t.getJcity()%>");form2.jcity.setAttribute('alt','籍贯');</script> <span class="info">请选择省</span></td>
  </tr>
  <tr>
    <th><em>*</em>报名所在地:</th>
    <td><script>mt.city("province0","province1",null,"<%=t.getProvince(h.language)%>");form2.province0.setAttribute('alt','报名所在地');</script> <span class="info">请选择省/市</font> </td>
  </tr>
  <tr>
    <th><em>*</em>户　　籍:</th>
    <td><select name="zznyhk" alt="户籍"><%=h.options(Lms.ZZNYHK_TYPE,t.isZznyhk()?1:0)%></select> <span class="info">请选择户籍类型</span></td>
  </tr>
  <tr>
    <th><em>*</em>职　　业:</th>
    <td><select name="job" alt="职业"><%=h.options(Lms.JOB_TYPE,t.getJob())%></select></td>
  </tr>
  <tr>
    <th><em>*</em>单位性质:</th>
    <td><select name="orgnature" alt="单位性质"><%=h.options(Lms.ORG_NATURE,t.orgnature)%></select></td>
  </tr>
</table>

<h2>报名情况</h2>
<table id="tablecenter" cellspacing="0" class="alignLeft">
  <tr>
    <th width='130'><em>*</em>证书级别:<br/>(学历层次)</th>
    <td><input type="hidden" name="enterLevel" id="enterLevel">
      <select name="enterLevel1" id="enterLevel1" onChange="selecteProfession(this.options[this.options.selectedIndex].value)" style="width:185px;display: block;">
        <!--<option value="0">请选择报名层次</option>
                              <option value="1">一级（专科）</option> -->
        <option value="2" selected>二级（独立本科）</option>
      </select>
      <select name="enterLevel2" id="enterLevel2" onChange="selecteProfession(this.options[this.options.selectedIndex].value)" style="width:185px;display: none">
        <!--<option value="0">请选择报名层次</option>-->
        <option value="1" >一级（专科）</option>
        <option value="2" selected>二级（独立本科）</option>
      </select>
      &nbsp;<span class="info">请选择证书级别</span> </td>
  </tr>
  <tr>
    <th><em>*</em>专业方向:</th>
    <td><select name="leveltype"><%=LmsCert.options(" AND rank=2",t.getLeveltype())%></select> <span class="info">请选择证书方向</span></td>
  </tr>
</table>

<%
}else
{
%>
<h2>基本信息</h2>
<table id="tablecenter" cellspacing="0" class="alignLeft">
  <tr>
    <th width="130">用 户 名:</th>
    <td><%=t.getMember()%></td>
    <td rowspan="8" class="tright1" align="center"><div class="picc"><img name="_photopath" src="<%=t.getPhotopath(h.language)%>" height="210px" width="160px;"/></div></td>
  </tr>
  <tr>
    <th>学习服务中心:</th>
    <td><%=MT.f(LmsOrg.find(t.getAgent()).orgname)%></td>
  </tr>
  <tr>
    <th>姓　　名:</th>
    <td><%=t.getName(h.language)%></td>
  </tr>
  <tr>
    <th>性　　别:</th>
    <td><%=t.isSex()?"男":"女"%></td>
  </tr>
  <tr>
    <th>出生日期:</th>
    <td><%=MT.f(t.getBirth())%></td>
  </tr>
  <tr>
    <th>民　　族:</th>
    <td><%=t.getZzracky()%></td>
  </tr>
  <tr>
    <th>政治面貌:</th>
    <td><%=Lms.POLITY_TYPE[t.getPolity()]%></td>
  </tr>
  <tr>
    <th>证件类型:</th>
    <td><%=Lms.CARD_TYPE[t.getCardType()]%></td>
  </tr>
  <tr>
    <th>证件号码:</th>
    <td colspan="2"><%=t.getCard()%></td>
  </tr>
  <tr>
    <th>籍　　贯:</th>
    <td colspan="2"><script>mt.city("<%=t.getJcity()%>");</script></td>
  </tr>
  <tr>
    <th>报名所在地:</th>
    <td colspan="2"><script>mt.city("<%=t.getProvince(h.language)%>");</script></td>
  </tr>
  <tr>
    <th>户　　籍:</th>
    <td colspan="2"><%=Lms.ZZNYHK_TYPE[t.isZznyhk()?1:0]%></td>
  </tr>
  <tr>
    <th>职　　业:</th>
    <td colspan="2"><%=Lms.JOB_TYPE[t.getJob()]%></td>
  </tr>
  <tr>
    <th>单位性质:</th>
    <td colspan="2"><%=Lms.ORG_NATURE[t.orgnature]%></td>
  </tr>
</table>

<h2>报名情况</h2>
<table id="tablecenter" cellspacing="0" class="alignLeft">
  <tr>
    <th width="130">证书级别:<br/>(学历层次)</th>
    <td>二级（独立本科）</td>
  </tr>
  <tr>
    <th>专业方向:</th>
    <td><%=LmsCert.f(t.getLeveltype())%></td>
  </tr>
</table>
<%
}
%>

<h2>学历信息</h2>
<table id="tablecenter" cellspacing="0" class="alignLeft">
  <tr>
    <th  width="130"><em>*</em>学　　历:</th>
    <td><select name="degree" alt="学历">
    <%
    for(int i=0;i<Lms.EDU_LEVEL.length;i++)
    {
      out.print("<option value='"+Lms.EDU_LEVEL[i]+"'");
      if(Lms.EDU_LEVEL[i].equals(t.getDegree(h.language)))out.print(" selected");
      out.print(">"+Lms.EDU_LEVEL[i]);
    }
    %></select>
    </td>
  </tr>
  <tr>
    <th height="21"><em>*</em>是否在读:</th>
    <td><input type="radio" name="rclass" id="_rclass1" value="1" checked ><label for="_rclass1">是</label>
      <input name="section" value="<%=t.getSection(h.language)%>" size="25"/> <span class="info">（填写现阶段班级）</span>
      <input type="radio" name="rclass" id="_rclass2" value="2" <%=t.rclass==2?" checked ":""%>><label for="_rclass2">否</label></td>
  </tr>
  <tr>
    <th><em>*</em>毕业院校:</th>
    <td><input name="school" value="<%=t.getSchool(h.language)%>" alt="毕业院校"/> <span class="info">如果没有填写“无”</span></td>
  </tr>
  <tr>
    <th><em>*</em>毕业专业:</th>
    <td><input name="functions" value="<%=t.getFunctions(h.language)%>" alt="毕业专业"/> <span class="info">如果没有填写“无”</span></td>
  </tr>
  <tr>
    <th><em>*</em>毕业时间:</th>
    <td><input name="gtime" value="<%=MT.f(t.gtime)%>" onclick="mt.date(this)" readonly alt="毕业时间" class="date"/></td>
  </tr>
</table>

<h2>联系方式</h2>
<table id="tablecenter" cellspacing="0" class="alignLeft">
  <tr>
    <th width="130"><em>*</em>工作单位:</th>
    <td colspan="2"><input name="organization" value="<%=t.getOrganization(h.language)%>" size="40" alt="工作单位"/> <span class="info">如不是从业人员，工作单位处可填写“无”</span> </td>
  </tr>
  <tr>
    <th><em>*</em>固定电话:</th>
    <td colspan="2"><input name="telephone" value="<%=t.getTelephone(h.language)%>" alt="固定电话"/> <span class="info">格式： 区号+电话，如010-12345678</span></td>
  </tr>
  <tr>
    <th><em>*</em>移动电话:</th>
    <td colspan="2"><input name="mobile" value="<%=t.getMobile()%>" alt="移动电话"/> <span class="info">格式：11位手机号</span></td>
  </tr>
  <tr>
    <th><em>*</em>通讯地址:</th>
    <td colspan="2"><input name="address" value="<%=t.getAddress(h.language)%>" size="40" alt="通讯地址"/> <span class="info">格式：北京市ＸＸ路ＸＸ号</span> </td>
  </tr>
  <tr>
    <th><em>*</em>邮政编码:</th>
    <td colspan="2"><input name="zip" value="<%=t.getZip(h.language)%>" alt="邮政编码"/> <span class="info">格式：100086</span></td>
  </tr>
  <tr>
    <th><em>*</em>电子邮箱:</th>
    <td colspan="2"><input name="email" value="<%=t.getEmail()%>" alt="电子邮箱"/> <span class="info">格式：Sample@Domain.com</span></td>
  </tr>
</table>



<input type="submit" value="提交"/> <input type="button" value="返回" onClick="history.back();"/>
</form>

<script>
mt.focus();
var arr=document.getElementsByTagName('SELECT');
for(var i=0;i<arr.length;i++)
{
  var op=arr[i].options;
  if(op[0].text.indexOf("--")!=0)continue;
  op[0].value="";
}
</script>
</body>
</html>
